package uploads

import (
	"compress/gzip"
	"context"
	"fmt"
	"io"
	"sync/atomic"
	"time"

	"github.com/jackc/pgconn"
	"github.com/keegancsmith/sqlf"
	otlog "github.com/opentracing/opentracing-go/log"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/sourcegraph/log"

	"github.com/sourcegraph/sourcegraph/internal/actor"
	"github.com/sourcegraph/sourcegraph/internal/api"
	codeinteltypes "github.com/sourcegraph/sourcegraph/internal/codeintel/shared/types"
	"github.com/sourcegraph/sourcegraph/internal/codeintel/uploads/internal/lsifstore"
	"github.com/sourcegraph/sourcegraph/internal/codeintel/uploads/internal/store"
	"github.com/sourcegraph/sourcegraph/internal/codeintel/uploads/shared"
	"github.com/sourcegraph/sourcegraph/internal/gitserver/gitdomain"
	"github.com/sourcegraph/sourcegraph/internal/observation"
	"github.com/sourcegraph/sourcegraph/internal/types"
	"github.com/sourcegraph/sourcegraph/internal/uploadstore"
	"github.com/sourcegraph/sourcegraph/internal/workerutil"
	"github.com/sourcegraph/sourcegraph/internal/workerutil/dbworker"
	dbworkerstore "github.com/sourcegraph/sourcegraph/internal/workerutil/dbworker/store"
	"github.com/sourcegraph/sourcegraph/lib/codeintel/lsif/conversion"
	"github.com/sourcegraph/sourcegraph/lib/codeintel/precise"
	"github.com/sourcegraph/sourcegraph/lib/errors"
)

func (s *Service) NewWorker(
	uploadStore uploadstore.Store,
	workerConcurrency int,
	workerBudget int64,
	workerPollInterval time.Duration,
	maximumRuntimePerJob time.Duration,
) *workerutil.Worker {
	rootContext := actor.WithInternalActor(context.Background())

	handler := s.WorkerutilHandler(
		uploadStore,
		workerConcurrency,
		workerBudget,
	)
	return dbworker.NewWorker(rootContext, s.WorkerutilStore(), handler, workerutil.WorkerOptions{
		Name:                 "precise_code_intel_upload_worker",
		NumHandlers:          workerConcurrency,
		Interval:             workerPollInterval,
		HeartbeatInterval:    time.Second,
		Metrics:              s.workerMetrics,
		MaximumRuntimePerJob: maximumRuntimePerJob,
	})
}

func (s *Service) WorkerutilStore() dbworkerstore.Store {
	return s.workerutilStore
}

func (s *Service) WorkerutilHandler(
	uploadStore uploadstore.Store,
	numProcessorRoutines int,
	budgetMax int64,
) workerutil.Handler {
	return &handler{
		dbStore:           s.store,
		repoStore:         s.repoStore,
		workerStore:       s.workerutilStore,
		lsifStore:         s.lsifstore,
		uploadStore:       uploadStore,
		gitserverClient:   s.gitserverClient,
		handleOp:          s.operations.uploadProcessor,
		budgetRemaining:   budgetMax,
		enableBudget:      budgetMax > 0,
		uncompressedSizes: make(map[int]uint64, numProcessorRoutines),
		uploadSizeGuage:   s.operations.uploadSizeGuage,
	}
}

type handler struct {
	dbStore         store.Store
	repoStore       RepoStore
	workerStore     dbworkerstore.Store
	lsifStore       lsifstore.LsifStore
	uploadStore     uploadstore.Store
	gitserverClient GitserverClient
	handleOp        *observation.Operation
	budgetRemaining int64
	enableBudget    bool
	// Map of upload ID to uncompressed size. Uploads are deleted before
	// PostHandle, so we store it here.
	// Should only contain entries for processing in-progress uploads.
	uncompressedSizes map[int]uint64
	uploadSizeGuage   prometheus.Gauge
}

var (
	_ workerutil.Handler        = &handler{}
	_ workerutil.WithPreDequeue = &handler{}
	_ workerutil.WithHooks      = &handler{}
)

// errCommitDoesNotExist occurs when gitserver does not recognize the commit attached to the upload.
var errCommitDoesNotExist = errors.Errorf("commit does not exist")

func (h *handler) Handle(ctx context.Context, logger log.Logger, record workerutil.Record) (err error) {
	upload, ok := record.(codeinteltypes.Upload)
	if !ok {
		return errors.Newf("unexpected record type %T", record)
	}

	var requeued bool

	ctx, otLogger, endObservation := h.handleOp.With(ctx, &err, observation.Args{})
	defer func() {
		endObservation(1, observation.Args{
			LogFields: append(
				createLogFields(upload),
				otlog.Bool("requeued", requeued),
			),
		})
	}()

	requeued, err = h.handle(ctx, logger, upload, otLogger)

	return err
}

func (h *handler) PreDequeue(ctx context.Context, logger log.Logger) (bool, any, error) {
	if !h.enableBudget {
		return true, nil, nil
	}

	budgetRemaining := atomic.LoadInt64(&h.budgetRemaining)
	if budgetRemaining <= 0 {
		return false, nil, nil
	}

	return true, []*sqlf.Query{sqlf.Sprintf("(upload_size IS NULL OR upload_size <= %s)", budgetRemaining)}, nil
}

func (h *handler) PreHandle(ctx context.Context, logger log.Logger, record workerutil.Record) {
	upload, ok := record.(codeinteltypes.Upload)
	if !ok {
		return
	}

	uncompressedSize := h.getUploadSize(upload.UncompressedSize)
	h.uploadSizeGuage.Add(float64(uncompressedSize))

	gzipSize := h.getUploadSize(upload.UploadSize)
	atomic.AddInt64(&h.budgetRemaining, -gzipSize)
}

func (h *handler) PostHandle(ctx context.Context, logger log.Logger, record workerutil.Record) {
	upload, ok := record.(codeinteltypes.Upload)
	if !ok {
		return
	}

	uncompressedSize := h.getUploadSize(upload.UncompressedSize)
	h.uploadSizeGuage.Sub(float64(uncompressedSize))

	gzipSize := h.getUploadSize(upload.UploadSize)
	atomic.AddInt64(&h.budgetRemaining, +gzipSize)
}

func (h *handler) getUploadSize(field *int64) int64 {
	if field != nil {
		return *field
	}

	return 0
}

// handle converts a raw upload into a dump within the given transaction context. Returns true if the
// upload record was requeued and false otherwise.
func (h *handler) handle(ctx context.Context, logger log.Logger, upload codeinteltypes.Upload, trace observation.TraceLogger) (requeued bool, err error) {
	repo, err := h.repoStore.Get(ctx, api.RepoID(upload.RepositoryID))
	if err != nil {
		return false, errors.Wrap(err, "Repos.Get")
	}

	if requeued, err := requeueIfCloningOrCommitUnknown(ctx, logger, h.repoStore, h.workerStore, upload, repo); err != nil || requeued {
		return requeued, err
	}

	// Determine if the upload is for the default Git branch.
	isDefaultBranch, err := h.gitserverClient.DefaultBranchContains(ctx, upload.RepositoryID, upload.Commit)
	if err != nil {
		return false, errors.Wrap(err, "gitserver.DefaultBranchContains")
	}

	trace.Log(otlog.Bool("defaultBranch", isDefaultBranch))

	getChildren := func(ctx context.Context, dirnames []string) (map[string][]string, error) {
		directoryChildren, err := h.gitserverClient.DirectoryChildren(ctx, upload.RepositoryID, upload.Commit, dirnames)
		if err != nil {
			return nil, errors.Wrap(err, "gitserverClient.DirectoryChildren")
		}
		return directoryChildren, nil
	}

	return false, withUploadData(ctx, logger, h.uploadStore, upload.ID, trace, func(r io.Reader) (err error) {
		groupedBundleData, err := conversion.Correlate(ctx, r, upload.Root, getChildren)
		if err != nil {
			return errors.Wrap(err, "conversion.Correlate")
		}

		// Note: this is writing to a different database than the block below, so we need to use a
		// different transaction context (managed by the writeData function).
		if err := writeData(ctx, h.lsifStore, upload, repo, isDefaultBranch, groupedBundleData, trace); err != nil {
			if isUniqueConstraintViolation(err) {
				// If this is a unique constraint violation, then we've previously processed this same
				// upload record up to this point, but failed to perform the transaction below. We can
				// safely assume that the entire index's data is in the codeintel database, as it's
				// parsed deterministically and written atomically.
				logger.Warn("LSIF data already exists for upload record")
				trace.Log(otlog.Bool("rewriting", true))
			} else {
				return err
			}
		}

		// Start a nested transaction with Postgres savepoints. In the event that something after this
		// point fails, we want to update the upload record with an error message but do not want to
		// alter any other data in the database. Rolling back to this savepoint will allow us to discard
		// any other changes but still commit the transaction as a whole.
		return inTransaction(ctx, h.dbStore, func(tx store.Store) error {
			// Before we mark the upload as complete, we need to delete any existing completed uploads
			// that have the same repository_id, commit, root, and indexer values. Otherwise the transaction
			// will fail as these values form a unique constraint.
			if err := tx.DeleteOverlappingDumps(ctx, upload.RepositoryID, upload.Commit, upload.Root, upload.Indexer); err != nil {
				return errors.Wrap(err, "store.DeleteOverlappingDumps")
			}

			// Find the date of the commit and store that in the upload record. We do this now as we
			// will need to find the _oldest_ commit with code intelligence data to efficiently update
			// the commit graph for the repository.
			_, commitDate, revisionExists, err := h.gitserverClient.CommitDate(ctx, upload.RepositoryID, upload.Commit)
			if err != nil {
				return errors.Wrap(err, "gitserverClient.CommitDate")
			}
			if !revisionExists {
				return errCommitDoesNotExist
			}
			trace.Log(otlog.String("commitDate", commitDate.String()))

			if err := tx.UpdateCommittedAt(ctx, upload.RepositoryID, upload.Commit, commitDate.Format(time.RFC3339)); err != nil {
				return errors.Wrap(err, "store.CommitDate")
			}

			trace.Log(otlog.Int("packages", len(groupedBundleData.Packages)))
			// Update package and package reference data to support cross-repo queries.
			if err := tx.UpdatePackages(ctx, upload.ID, groupedBundleData.Packages); err != nil {
				return errors.Wrap(err, "store.UpdatePackages")
			}
			trace.Log(otlog.Int("packageReferences", len(groupedBundleData.Packages)))
			if err := tx.UpdatePackageReferences(ctx, upload.ID, groupedBundleData.PackageReferences); err != nil {
				return errors.Wrap(err, "store.UpdatePackageReferences")
			}

			// When inserting a new completed upload record, update the reference counts both to it from
			// existing uploads, as well as the reference counts to all of this new upload's dependencies.
			// We always keep this value up to date - we also decrement reference counts of dependencies
			// on upload deletion or when the set of uploads providing an existing package change.
			updated, err := tx.UpdateUploadsReferenceCounts(ctx, []int{upload.ID}, shared.DependencyReferenceCountUpdateTypeAdd)
			if err != nil {
				return errors.Wrap(err, "store.UpdateReferenceCount")
			}
			trace.Log(otlog.Int("updatedReferencingUploads", updated))

			// Insert a companion record to this upload that will asynchronously trigger other workers to
			// sync/create referenced dependency repositories and queue auto-index records for the monikers
			// written into the lsif_references table attached by this index processing job.
			if _, err := tx.InsertDependencySyncingJob(ctx, upload.ID); err != nil {
				return errors.Wrap(err, "store.InsertDependencyIndexingJob")
			}

			// Mark this repository so that the commit updater process will pull the full commit graph from
			// gitserver and recalculate the nearest upload for each commit as well as which uploads are visible
			// from the tip of the default branch. We don't do this inside of the transaction as we re-calcalute
			// the entire set of data from scratch and we want to be able to coalesce requests for the same
			// repository rather than having a set of uploads for the same repo re-calculate nearly identical
			// data multiple times.
			if err := tx.SetRepositoryAsDirty(ctx, upload.RepositoryID); err != nil {
				return errors.Wrap(err, "store.MarkRepositoryAsDirty")
			}

			return nil
		})
	})
}

func inTransaction(ctx context.Context, dbStore store.Store, fn func(tx store.Store) error) (err error) {
	tx, err := dbStore.Transact(ctx)
	if err != nil {
		return errors.Wrap(err, "store.Transact")
	}
	defer func() { err = tx.Done(err) }()

	return fn(tx)
}

// requeueDelay is the delay between processing attempts to process a record when waiting on
// gitserver to refresh. We'll requeue a record with this delay while the repo is cloning or
// while we're waiting for a commit to become available to the remote code host.
const requeueDelay = time.Minute

// requeueIfCloningOrCommitUnknown ensures that the repo and revision are resolvable. If the repo is currently
// cloning or if the commit does not exist, then the upload will be requeued and this function returns a true
// valued flag. Otherwise, the repo does not exist or there is an unexpected infrastructure error, which we'll
// fail on.
func requeueIfCloningOrCommitUnknown(ctx context.Context, logger log.Logger, repoStore RepoStore, workerStore dbworkerstore.Store, upload codeinteltypes.Upload, repo *types.Repo) (requeued bool, _ error) {
	_, err := repoStore.ResolveRev(ctx, repo, upload.Commit)
	if err == nil {
		// commit is resolvable
		return false, nil
	}

	var reason string
	if errors.HasType(err, &gitdomain.RevisionNotFoundError{}) {
		reason = "commit not found"
	} else if gitdomain.IsCloneInProgress(err) {
		reason = "repository still cloning"
	} else {
		return false, errors.Wrap(err, "repos.ResolveRev")
	}

	after := time.Now().UTC().Add(requeueDelay)

	if err := workerStore.Requeue(ctx, upload.ID, after); err != nil {
		return false, errors.Wrap(err, "store.Requeue")
	}
	logger.Warn("Requeued LSIF upload record",
		log.Int("id", upload.ID),
		log.String("reason", reason))
	return true, nil
}

// withUploadData will invoke the given function with a reader of the upload's raw data. The
// consumer should expect raw newline-delimited JSON content. If the function returns without
// an error, the upload file will be deleted.
func withUploadData(ctx context.Context, logger log.Logger, uploadStore uploadstore.Store, id int, trace observation.TraceLogger, fn func(r io.Reader) error) error {
	uploadFilename := fmt.Sprintf("upload-%d.lsif.gz", id)

	trace.Log(otlog.String("uploadFilename", uploadFilename))

	// Pull raw uploaded data from bucket
	rc, err := uploadStore.Get(ctx, uploadFilename)
	if err != nil {
		return errors.Wrap(err, "uploadStore.Get")
	}
	defer rc.Close()

	rc, err = gzip.NewReader(rc)
	if err != nil {
		return errors.Wrap(err, "gzip.NewReader")
	}
	defer rc.Close()

	if err := fn(rc); err != nil {
		return err
	}

	if err := uploadStore.Delete(ctx, uploadFilename); err != nil {
		logger.Warn("Failed to delete upload file",
			log.NamedError("err", err),
			log.String("filename", uploadFilename))
	}

	return nil
}

// writeData transactionally writes the given grouped bundle data into the given LSIF store.
func writeData(ctx context.Context, lsifStore lsifstore.LsifStore, upload codeinteltypes.Upload, repo *types.Repo, isDefaultBranch bool, groupedBundleData *precise.GroupedBundleDataChans, trace observation.TraceLogger) (err error) {
	tx, err := lsifStore.Transact(ctx)
	if err != nil {
		return err
	}
	defer func() { err = tx.Done(err) }()

	if err := tx.WriteMeta(ctx, upload.ID, groupedBundleData.Meta); err != nil {
		return errors.Wrap(err, "store.WriteMeta")
	}
	count, err := tx.WriteDocuments(ctx, upload.ID, groupedBundleData.Documents)
	if err != nil {
		return errors.Wrap(err, "store.WriteDocuments")
	}
	trace.Log(otlog.Uint32("numDocuments", count))

	count, err = tx.WriteResultChunks(ctx, upload.ID, groupedBundleData.ResultChunks)
	if err != nil {
		return errors.Wrap(err, "store.WriteResultChunks")
	}
	trace.Log(otlog.Uint32("numResultChunks", count))

	count, err = tx.WriteDefinitions(ctx, upload.ID, groupedBundleData.Definitions)
	if err != nil {
		return errors.Wrap(err, "store.WriteDefinitions")
	}
	trace.Log(otlog.Uint32("numDefinitions", count))

	count, err = tx.WriteReferences(ctx, upload.ID, groupedBundleData.References)
	if err != nil {
		return errors.Wrap(err, "store.WriteReferences")
	}
	trace.Log(otlog.Uint32("numReferences", count))

	count, err = tx.WriteImplementations(ctx, upload.ID, groupedBundleData.Implementations)
	if err != nil {
		return errors.Wrap(err, "store.WriteImplementations")
	}
	trace.Log(otlog.Uint32("numImplementations", count))

	return nil
}

func isUniqueConstraintViolation(err error) bool {
	var e *pgconn.PgError
	return errors.As(err, &e) && e.Code == "23505"
}

func createLogFields(upload codeinteltypes.Upload) []otlog.Field {
	fields := []otlog.Field{
		otlog.Int("uploadID", upload.ID),
		otlog.Int("repositoryID", upload.RepositoryID),
		otlog.String("commit", upload.Commit),
		otlog.String("root", upload.Root),
		otlog.String("indexer", upload.Indexer),
		otlog.Int("queueDuration", int(time.Since(upload.UploadedAt))),
	}

	if upload.UploadSize != nil {
		fields = append(fields, otlog.Int64("uploadSize", *upload.UploadSize))
	}

	return fields
}
