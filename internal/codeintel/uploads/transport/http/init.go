package http

import (
	"net/http"
	"sync"

	"github.com/prometheus/client_golang/prometheus"
	"go.opentelemetry.io/otel"

	"github.com/sourcegraph/log"

	"github.com/sourcegraph/sourcegraph/cmd/frontend/backend"
	uploads "github.com/sourcegraph/sourcegraph/internal/codeintel/uploads"
	"github.com/sourcegraph/sourcegraph/internal/codeintel/uploads/transport/http/auth"
	"github.com/sourcegraph/sourcegraph/internal/database"
	"github.com/sourcegraph/sourcegraph/internal/gitserver"
	"github.com/sourcegraph/sourcegraph/internal/observation"
	"github.com/sourcegraph/sourcegraph/internal/trace"
	"github.com/sourcegraph/sourcegraph/internal/uploadhandler"
	"github.com/sourcegraph/sourcegraph/internal/uploadstore"
)

var (
	handler         http.Handler
	handlerWithAuth http.Handler
	handlerOnce     sync.Once
)

func GetHandler(svc *uploads.Service, db database.DB, uploadStore uploadstore.Store, withCodeHostAuthAuth bool) http.Handler {
	handlerOnce.Do(func() {
		logger := log.Scoped(
			"uploads.handler",
			"codeintel uploads http handler",
		)

		observationContext := &observation.Context{
			Logger:     logger,
			Tracer:     &trace.Tracer{TracerProvider: otel.GetTracerProvider()},
			Registerer: prometheus.DefaultRegisterer,
		}

		operations := newOperations(observationContext)
		uploadHandlerOperations := uploadhandler.NewOperations("codeintel", observationContext)

		userStore := db.Users()
		repoStore := backend.NewRepos(logger, db, gitserver.NewClient(db))

		// Construct base handler, used in internal routes and as internal handler wrapped
		// in the auth middleware defined on the next few lines
		handler = newHandler(repoStore, uploadStore, svc.UploadHandlerStore(), uploadHandlerOperations)

		// 🚨 SECURITY: Non-internal installations of this handler will require a user/repo
		// visibility check with the remote code host (if enabled via site configuration).
		handlerWithAuth = auth.AuthMiddleware(
			handler,
			userStore,
			auth.DefaultValidatorByCodeHost,
			operations.authMiddleware,
		)
	})

	if withCodeHostAuthAuth {
		return handlerWithAuth
	}
	return handler
}
