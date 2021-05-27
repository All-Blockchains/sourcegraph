BEGIN;

CREATE EXTENSION IF NOT EXISTS citext;

CREATE EXTENSION IF NOT EXISTS hstore;

CREATE EXTENSION IF NOT EXISTS intarray;

CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TYPE cm_email_priority AS ENUM (
    'NORMAL',
    'CRITICAL'
);

CREATE TYPE critical_or_site AS ENUM (
    'critical',
    'site'
);

CREATE TYPE lsif_index_state AS ENUM (
    'queued',
    'processing',
    'completed',
    'errored',
    'failed'
);

CREATE TYPE lsif_upload_state AS ENUM (
    'uploading',
    'queued',
    'processing',
    'completed',
    'errored',
    'deleted',
    'failed'
);

CREATE FUNCTION delete_batch_change_reference_on_changesets() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE
          changesets
        SET
          batch_change_ids = changesets.batch_change_ids - OLD.id::text
        WHERE
          changesets.batch_change_ids ? OLD.id::text;

        RETURN OLD;
    END;
$$;

CREATE FUNCTION delete_external_service_ref_on_external_service_repos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        -- if an external service is soft-deleted, delete every row that references it
        IF (OLD.deleted_at IS NULL AND NEW.deleted_at IS NOT NULL) THEN
          DELETE FROM
            external_service_repos
          WHERE
            external_service_id = OLD.id;
        END IF;

        RETURN OLD;
    END;
$$;

CREATE FUNCTION delete_repo_ref_on_external_service_repos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        -- if a repo is soft-deleted, delete every row that references that repo
        IF (OLD.deleted_at IS NULL AND NEW.deleted_at IS NOT NULL) THEN
        DELETE FROM
            external_service_repos
        WHERE
            repo_id = OLD.id;
        END IF;

        RETURN OLD;
    END;
$$;

CREATE FUNCTION invalidate_session_for_userid_on_password_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF OLD.passwd != NEW.passwd THEN
            NEW.invalidated_sessions_at = now() + (1 * interval '1 second');
            RETURN NEW;
        END IF;
    RETURN NEW;
    END;
$$;

CREATE FUNCTION soft_delete_orphan_repo_by_external_service_repos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- When an external service is soft or hard-deleted,
    -- performs a clean up to soft-delete orphan repositories.
    UPDATE
        repo
    SET
        name = soft_deleted_repository_name(name),
        deleted_at = transaction_timestamp()
    WHERE
      deleted_at IS NULL
      AND NOT EXISTS (
        SELECT FROM external_service_repos WHERE repo_id = repo.id
    );

    RETURN NULL;
END;
$$;

CREATE FUNCTION soft_delete_user_reference_on_external_service() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- If a user is soft-deleted, delete every row that references that user
    IF (OLD.deleted_at IS NULL AND NEW.deleted_at IS NOT NULL) THEN
        UPDATE external_services
        SET deleted_at = NOW()
        WHERE namespace_user_id = OLD.id;
    END IF;

    RETURN OLD;
END;
$$;

CREATE FUNCTION soft_deleted_repository_name(name text) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $$
BEGIN
    RETURN 'DELETED-' || extract(epoch from transaction_timestamp()) || '-' || name;
END;
$$;

CREATE TABLE access_tokens (
    id bigint NOT NULL,
    subject_user_id integer NOT NULL,
    value_sha256 bytea NOT NULL,
    note text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone,
    deleted_at timestamp with time zone,
    creator_user_id integer NOT NULL,
    scopes text[] NOT NULL
);

CREATE SEQUENCE access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE access_tokens_id_seq OWNED BY access_tokens.id;

CREATE TABLE batch_changes (
    id bigint NOT NULL,
    name text NOT NULL,
    description text,
    initial_applier_id integer,
    namespace_user_id integer,
    namespace_org_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    closed_at timestamp with time zone,
    batch_spec_id bigint NOT NULL,
    last_applier_id bigint,
    last_applied_at timestamp with time zone NOT NULL,
    CONSTRAINT batch_changes_has_1_namespace CHECK (((namespace_user_id IS NULL) <> (namespace_org_id IS NULL))),
    CONSTRAINT batch_changes_name_not_blank CHECK ((name <> ''::text))
);

CREATE SEQUENCE batch_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE batch_changes_id_seq OWNED BY batch_changes.id;

CREATE TABLE batch_specs (
    id bigint NOT NULL,
    rand_id text NOT NULL,
    raw_spec text NOT NULL,
    spec jsonb DEFAULT '{}'::jsonb NOT NULL,
    namespace_user_id integer,
    namespace_org_id integer,
    user_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT batch_specs_has_1_namespace CHECK (((namespace_user_id IS NULL) <> (namespace_org_id IS NULL)))
);

CREATE SEQUENCE batch_specs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE batch_specs_id_seq OWNED BY batch_specs.id;

CREATE TABLE changeset_specs (
    id bigint NOT NULL,
    rand_id text NOT NULL,
    raw_spec text NOT NULL,
    spec jsonb DEFAULT '{}'::jsonb NOT NULL,
    batch_spec_id bigint,
    repo_id integer NOT NULL,
    user_id integer,
    diff_stat_added integer,
    diff_stat_changed integer,
    diff_stat_deleted integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    head_ref text,
    title text,
    external_id text
);

CREATE TABLE changesets (
    id bigint NOT NULL,
    batch_change_ids jsonb DEFAULT '{}'::jsonb NOT NULL,
    repo_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    external_id text,
    external_service_type text NOT NULL,
    external_deleted_at timestamp with time zone,
    external_branch text,
    external_updated_at timestamp with time zone,
    external_state text,
    external_review_state text,
    external_check_state text,
    diff_stat_added integer,
    diff_stat_changed integer,
    diff_stat_deleted integer,
    sync_state jsonb DEFAULT '{}'::jsonb NOT NULL,
    current_spec_id bigint,
    previous_spec_id bigint,
    publication_state text DEFAULT 'UNPUBLISHED'::text,
    owned_by_batch_change_id bigint,
    reconciler_state text DEFAULT 'queued'::text,
    failure_message text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    process_after timestamp with time zone,
    num_resets integer DEFAULT 0 NOT NULL,
    closing boolean DEFAULT false NOT NULL,
    num_failures integer DEFAULT 0 NOT NULL,
    log_contents text,
    execution_logs json[],
    syncer_error text,
    external_title text,
    CONSTRAINT changesets_batch_change_ids_check CHECK ((jsonb_typeof(batch_change_ids) = 'object'::text)),
    CONSTRAINT changesets_external_id_check CHECK ((external_id <> ''::text)),
    CONSTRAINT changesets_external_service_type_not_blank CHECK ((external_service_type <> ''::text)),
    CONSTRAINT changesets_metadata_check CHECK ((jsonb_typeof(metadata) = 'object'::text)),
    CONSTRAINT external_branch_ref_prefix CHECK ((external_branch ~~ 'refs/heads/%'::text))
);

CREATE TABLE repo (
    id integer NOT NULL,
    name citext NOT NULL,
    description text,
    fork boolean,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    external_id text,
    external_service_type text,
    external_service_id text,
    archived boolean DEFAULT false NOT NULL,
    uri citext,
    deleted_at timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    private boolean DEFAULT false NOT NULL,
    cloned boolean DEFAULT false NOT NULL,
    CONSTRAINT check_name_nonempty CHECK ((name OPERATOR(<>) ''::citext)),
    CONSTRAINT repo_metadata_check CHECK ((jsonb_typeof(metadata) = 'object'::text))
);

CREATE VIEW branch_changeset_specs_and_changesets AS
 SELECT changeset_specs.id AS changeset_spec_id,
    COALESCE(changesets.id, (0)::bigint) AS changeset_id,
    changeset_specs.repo_id,
    changeset_specs.batch_spec_id,
    changesets.owned_by_batch_change_id AS owner_batch_change_id,
    repo.name AS repo_name,
    changeset_specs.title AS changeset_name,
    changesets.external_state,
    changesets.publication_state,
    changesets.reconciler_state
   FROM ((changeset_specs
     LEFT JOIN changesets ON (((changesets.repo_id = changeset_specs.repo_id) AND (changesets.current_spec_id IS NOT NULL) AND (EXISTS ( SELECT 1
           FROM changeset_specs changeset_specs_1
          WHERE ((changeset_specs_1.id = changesets.current_spec_id) AND (changeset_specs_1.head_ref = changeset_specs.head_ref)))))))
     JOIN repo ON ((changeset_specs.repo_id = repo.id)))
  WHERE ((changeset_specs.external_id IS NULL) AND (repo.deleted_at IS NULL));

CREATE TABLE changeset_events (
    id bigint NOT NULL,
    changeset_id bigint NOT NULL,
    kind text NOT NULL,
    key text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT changeset_events_key_check CHECK ((key <> ''::text)),
    CONSTRAINT changeset_events_kind_check CHECK ((kind <> ''::text)),
    CONSTRAINT changeset_events_metadata_check CHECK ((jsonb_typeof(metadata) = 'object'::text))
);

CREATE SEQUENCE changeset_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE changeset_events_id_seq OWNED BY changeset_events.id;

CREATE SEQUENCE changeset_specs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE changeset_specs_id_seq OWNED BY changeset_specs.id;

CREATE SEQUENCE changesets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE changesets_id_seq OWNED BY changesets.id;

CREATE TABLE cm_action_jobs (
    id integer NOT NULL,
    email bigint NOT NULL,
    state text DEFAULT 'queued'::text,
    failure_message text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    process_after timestamp with time zone,
    num_resets integer DEFAULT 0 NOT NULL,
    num_failures integer DEFAULT 0 NOT NULL,
    log_contents text,
    trigger_event integer
);

CREATE SEQUENCE cm_action_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE cm_action_jobs_id_seq OWNED BY cm_action_jobs.id;

CREATE TABLE cm_emails (
    id bigint NOT NULL,
    monitor bigint NOT NULL,
    enabled boolean NOT NULL,
    priority cm_email_priority NOT NULL,
    header text NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    changed_by integer NOT NULL,
    changed_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE cm_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE cm_emails_id_seq OWNED BY cm_emails.id;

CREATE TABLE cm_monitors (
    id bigint NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    description text NOT NULL,
    changed_at timestamp with time zone DEFAULT now() NOT NULL,
    changed_by integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    namespace_user_id integer,
    namespace_org_id integer
);

CREATE SEQUENCE cm_monitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE cm_monitors_id_seq OWNED BY cm_monitors.id;

CREATE TABLE cm_queries (
    id bigint NOT NULL,
    monitor bigint NOT NULL,
    query text NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    changed_by integer NOT NULL,
    changed_at timestamp with time zone DEFAULT now() NOT NULL,
    next_run timestamp with time zone DEFAULT now(),
    latest_result timestamp with time zone
);

CREATE SEQUENCE cm_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE cm_queries_id_seq OWNED BY cm_queries.id;

CREATE TABLE cm_recipients (
    id bigint NOT NULL,
    email bigint NOT NULL,
    namespace_user_id integer,
    namespace_org_id integer
);

CREATE SEQUENCE cm_recipients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE cm_recipients_id_seq OWNED BY cm_recipients.id;

CREATE TABLE cm_trigger_jobs (
    id integer NOT NULL,
    query bigint NOT NULL,
    state text DEFAULT 'queued'::text,
    failure_message text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    process_after timestamp with time zone,
    num_resets integer DEFAULT 0 NOT NULL,
    num_failures integer DEFAULT 0 NOT NULL,
    log_contents text,
    query_string text,
    results boolean,
    num_results integer
);

CREATE SEQUENCE cm_trigger_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE cm_trigger_jobs_id_seq OWNED BY cm_trigger_jobs.id;

CREATE TABLE critical_and_site_config (
    id integer NOT NULL,
    type critical_or_site NOT NULL,
    contents text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE critical_and_site_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE critical_and_site_config_id_seq OWNED BY critical_and_site_config.id;

CREATE TABLE default_repos (
    repo_id integer NOT NULL
);

CREATE TABLE discussion_comments (
    id bigint NOT NULL,
    thread_id bigint NOT NULL,
    author_user_id integer NOT NULL,
    contents text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    reports text[] DEFAULT '{}'::text[] NOT NULL
);

CREATE SEQUENCE discussion_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE discussion_comments_id_seq OWNED BY discussion_comments.id;

CREATE TABLE discussion_mail_reply_tokens (
    token text NOT NULL,
    user_id integer NOT NULL,
    thread_id bigint NOT NULL,
    deleted_at timestamp with time zone
);

CREATE TABLE discussion_threads (
    id bigint NOT NULL,
    author_user_id integer NOT NULL,
    title text,
    target_repo_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    archived_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);

CREATE SEQUENCE discussion_threads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE discussion_threads_id_seq OWNED BY discussion_threads.id;

CREATE TABLE discussion_threads_target_repo (
    id bigint NOT NULL,
    thread_id bigint NOT NULL,
    repo_id integer NOT NULL,
    path text,
    branch text,
    revision text,
    start_line integer,
    end_line integer,
    start_character integer,
    end_character integer,
    lines_before text,
    lines text,
    lines_after text
);

CREATE SEQUENCE discussion_threads_target_repo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE discussion_threads_target_repo_id_seq OWNED BY discussion_threads_target_repo.id;

CREATE TABLE event_logs (
    id bigint NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    user_id integer NOT NULL,
    anonymous_user_id text NOT NULL,
    source text NOT NULL,
    argument jsonb NOT NULL,
    version text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT event_logs_check_has_user CHECK ((((user_id = 0) AND (anonymous_user_id <> ''::text)) OR ((user_id <> 0) AND (anonymous_user_id = ''::text)) OR ((user_id <> 0) AND (anonymous_user_id <> ''::text)))),
    CONSTRAINT event_logs_check_name_not_empty CHECK ((name <> ''::text)),
    CONSTRAINT event_logs_check_source_not_empty CHECK ((source <> ''::text)),
    CONSTRAINT event_logs_check_version_not_empty CHECK ((version <> ''::text))
);

CREATE SEQUENCE event_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE event_logs_id_seq OWNED BY event_logs.id;

CREATE TABLE external_service_repos (
    external_service_id bigint NOT NULL,
    repo_id integer NOT NULL,
    clone_url text NOT NULL
);

CREATE SEQUENCE external_service_sync_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE external_service_sync_jobs (
    id integer DEFAULT nextval('external_service_sync_jobs_id_seq'::regclass) NOT NULL,
    state text DEFAULT 'queued'::text NOT NULL,
    failure_message text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    process_after timestamp with time zone,
    num_resets integer DEFAULT 0 NOT NULL,
    external_service_id bigint,
    num_failures integer DEFAULT 0 NOT NULL,
    log_contents text,
    execution_logs json[]
);

CREATE TABLE external_services (
    id bigint NOT NULL,
    kind text NOT NULL,
    display_name text NOT NULL,
    config text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    last_sync_at timestamp with time zone,
    next_sync_at timestamp with time zone,
    namespace_user_id integer,
    unrestricted boolean DEFAULT false NOT NULL,
    cloud_default boolean DEFAULT false NOT NULL,
    encryption_key_id text DEFAULT ''::text NOT NULL,
    CONSTRAINT check_non_empty_config CHECK ((btrim(config) <> ''::text))
);

CREATE VIEW external_service_sync_jobs_with_next_sync_at AS
 SELECT j.id,
    j.state,
    j.failure_message,
    j.started_at,
    j.finished_at,
    j.process_after,
    j.num_resets,
    j.num_failures,
    j.execution_logs,
    j.external_service_id,
    e.next_sync_at
   FROM (external_services e
     JOIN external_service_sync_jobs j ON ((e.id = j.external_service_id)));

CREATE SEQUENCE external_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE external_services_id_seq OWNED BY external_services.id;

CREATE TABLE gitserver_repos (
    repo_id integer NOT NULL,
    clone_status text DEFAULT 'not_cloned'::text NOT NULL,
    last_external_service bigint,
    shard_id text NOT NULL,
    last_error text,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE global_state (
    site_id uuid NOT NULL,
    initialized boolean DEFAULT false NOT NULL,
    mgmt_password_plaintext text DEFAULT ''::text NOT NULL,
    mgmt_password_bcrypt text DEFAULT ''::text NOT NULL
);

CREATE TABLE insights_query_runner_jobs (
    id integer NOT NULL,
    series_id text NOT NULL,
    search_query text NOT NULL,
    state text DEFAULT 'queued'::text,
    failure_message text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    process_after timestamp with time zone,
    num_resets integer DEFAULT 0 NOT NULL,
    num_failures integer DEFAULT 0 NOT NULL,
    execution_logs json[],
    record_time timestamp with time zone
);

CREATE SEQUENCE insights_query_runner_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE insights_query_runner_jobs_id_seq OWNED BY insights_query_runner_jobs.id;

CREATE TABLE lsif_dirty_repositories (
    repository_id integer NOT NULL,
    dirty_token integer NOT NULL,
    update_token integer NOT NULL,
    updated_at timestamp with time zone
);

CREATE TABLE lsif_uploads (
    id integer NOT NULL,
    commit text NOT NULL,
    root text DEFAULT ''::text NOT NULL,
    uploaded_at timestamp with time zone DEFAULT now() NOT NULL,
    state text DEFAULT 'queued'::text NOT NULL,
    failure_message text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    repository_id integer NOT NULL,
    indexer text NOT NULL,
    num_parts integer NOT NULL,
    uploaded_parts integer[] NOT NULL,
    process_after timestamp with time zone,
    num_resets integer DEFAULT 0 NOT NULL,
    upload_size bigint,
    num_failures integer DEFAULT 0 NOT NULL,
    associated_index_id bigint,
    CONSTRAINT lsif_uploads_commit_valid_chars CHECK ((commit ~ '^[a-z0-9]{40}$'::text))
);

CREATE VIEW lsif_dumps AS
 SELECT u.id,
    u.commit,
    u.root,
    u.uploaded_at,
    u.state,
    u.failure_message,
    u.started_at,
    u.finished_at,
    u.repository_id,
    u.indexer,
    u.num_parts,
    u.uploaded_parts,
    u.process_after,
    u.num_resets,
    u.upload_size,
    u.num_failures,
    u.associated_index_id,
    u.finished_at AS processed_at
   FROM lsif_uploads u
  WHERE (u.state = 'completed'::text);

CREATE SEQUENCE lsif_dumps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE lsif_dumps_id_seq OWNED BY lsif_uploads.id;

CREATE VIEW lsif_dumps_with_repository_name AS
 SELECT u.id,
    u.commit,
    u.root,
    u.uploaded_at,
    u.state,
    u.failure_message,
    u.started_at,
    u.finished_at,
    u.repository_id,
    u.indexer,
    u.num_parts,
    u.uploaded_parts,
    u.process_after,
    u.num_resets,
    u.upload_size,
    u.num_failures,
    u.associated_index_id,
    u.processed_at,
    r.name AS repository_name
   FROM (lsif_dumps u
     JOIN repo r ON ((r.id = u.repository_id)))
  WHERE (r.deleted_at IS NULL);

CREATE TABLE lsif_index_configuration (
    id bigint NOT NULL,
    repository_id integer NOT NULL,
    data bytea NOT NULL
);

CREATE SEQUENCE lsif_index_configuration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE lsif_index_configuration_id_seq OWNED BY lsif_index_configuration.id;

CREATE TABLE lsif_indexable_repositories (
    id integer NOT NULL,
    repository_id integer NOT NULL,
    search_count integer DEFAULT 0 NOT NULL,
    precise_count integer DEFAULT 0 NOT NULL,
    last_index_enqueued_at timestamp with time zone,
    last_updated_at timestamp with time zone DEFAULT now() NOT NULL,
    enabled boolean
);

CREATE SEQUENCE lsif_indexable_repositories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE lsif_indexable_repositories_id_seq OWNED BY lsif_indexable_repositories.id;

CREATE TABLE lsif_indexes (
    id bigint NOT NULL,
    commit text NOT NULL,
    queued_at timestamp with time zone DEFAULT now() NOT NULL,
    state text DEFAULT 'queued'::text NOT NULL,
    failure_message text,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    repository_id integer NOT NULL,
    process_after timestamp with time zone,
    num_resets integer DEFAULT 0 NOT NULL,
    num_failures integer DEFAULT 0 NOT NULL,
    docker_steps jsonb[] NOT NULL,
    root text NOT NULL,
    indexer text NOT NULL,
    indexer_args text[] NOT NULL,
    outfile text NOT NULL,
    log_contents text,
    execution_logs json[],
    local_steps text[] NOT NULL,
    CONSTRAINT lsif_uploads_commit_valid_chars CHECK ((commit ~ '^[a-z0-9]{40}$'::text))
);

CREATE SEQUENCE lsif_indexes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE lsif_indexes_id_seq OWNED BY lsif_indexes.id;

CREATE VIEW lsif_indexes_with_repository_name AS
 SELECT u.id,
    u.commit,
    u.queued_at,
    u.state,
    u.failure_message,
    u.started_at,
    u.finished_at,
    u.repository_id,
    u.process_after,
    u.num_resets,
    u.num_failures,
    u.docker_steps,
    u.root,
    u.indexer,
    u.indexer_args,
    u.outfile,
    u.log_contents,
    u.execution_logs,
    u.local_steps,
    r.name AS repository_name
   FROM (lsif_indexes u
     JOIN repo r ON ((r.id = u.repository_id)))
  WHERE (r.deleted_at IS NULL);

CREATE TABLE lsif_nearest_uploads (
    repository_id integer NOT NULL,
    commit_bytea bytea NOT NULL,
    uploads jsonb NOT NULL
);

CREATE TABLE lsif_nearest_uploads_links (
    repository_id integer NOT NULL,
    commit_bytea bytea NOT NULL,
    ancestor_commit_bytea bytea NOT NULL,
    distance integer NOT NULL
);

CREATE TABLE lsif_packages (
    id integer NOT NULL,
    scheme text NOT NULL,
    name text NOT NULL,
    version text,
    dump_id integer NOT NULL
);

CREATE SEQUENCE lsif_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE lsif_packages_id_seq OWNED BY lsif_packages.id;

CREATE TABLE lsif_references (
    id integer NOT NULL,
    scheme text NOT NULL,
    name text NOT NULL,
    version text,
    filter bytea NOT NULL,
    dump_id integer NOT NULL
);

CREATE SEQUENCE lsif_references_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE lsif_references_id_seq OWNED BY lsif_references.id;

CREATE TABLE lsif_uploads_visible_at_tip (
    repository_id integer NOT NULL,
    upload_id integer NOT NULL
);

CREATE VIEW lsif_uploads_with_repository_name AS
 SELECT u.id,
    u.commit,
    u.root,
    u.uploaded_at,
    u.state,
    u.failure_message,
    u.started_at,
    u.finished_at,
    u.repository_id,
    u.indexer,
    u.num_parts,
    u.uploaded_parts,
    u.process_after,
    u.num_resets,
    u.upload_size,
    u.num_failures,
    u.associated_index_id,
    r.name AS repository_name
   FROM (lsif_uploads u
     JOIN repo r ON ((r.id = u.repository_id)))
  WHERE (r.deleted_at IS NULL);

CREATE TABLE names (
    name citext NOT NULL,
    user_id integer,
    org_id integer,
    CONSTRAINT names_check CHECK (((user_id IS NOT NULL) OR (org_id IS NOT NULL)))
);

CREATE TABLE org_invitations (
    id bigint NOT NULL,
    org_id integer NOT NULL,
    sender_user_id integer NOT NULL,
    recipient_user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    notified_at timestamp with time zone,
    responded_at timestamp with time zone,
    response_type boolean,
    revoked_at timestamp with time zone,
    deleted_at timestamp with time zone,
    CONSTRAINT check_atomic_response CHECK (((responded_at IS NULL) = (response_type IS NULL))),
    CONSTRAINT check_single_use CHECK ((((responded_at IS NULL) AND (response_type IS NULL)) OR (revoked_at IS NULL)))
);

CREATE SEQUENCE org_invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE org_invitations_id_seq OWNED BY org_invitations.id;

CREATE TABLE org_members (
    id integer NOT NULL,
    org_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer NOT NULL
);

CREATE TABLE org_members_bkup_1514536731 (
    id integer,
    org_id integer,
    user_id_old text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    user_id integer
);

CREATE SEQUENCE org_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE org_members_id_seq OWNED BY org_members.id;

CREATE TABLE orgs (
    id integer NOT NULL,
    name citext NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    display_name text,
    slack_webhook_url text,
    deleted_at timestamp with time zone,
    CONSTRAINT orgs_display_name_max_length CHECK ((char_length(display_name) <= 255)),
    CONSTRAINT orgs_name_max_length CHECK ((char_length((name)::text) <= 255)),
    CONSTRAINT orgs_name_valid_chars CHECK ((name OPERATOR(~) '^[a-zA-Z0-9](?:[a-zA-Z0-9]|[-.](?=[a-zA-Z0-9]))*-?$'::citext))
);

CREATE SEQUENCE orgs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE orgs_id_seq OWNED BY orgs.id;

CREATE TABLE out_of_band_migrations (
    id integer NOT NULL,
    team text NOT NULL,
    component text NOT NULL,
    description text NOT NULL,
    introduced text NOT NULL,
    deprecated text,
    progress double precision DEFAULT 0 NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    last_updated timestamp with time zone,
    non_destructive boolean NOT NULL,
    apply_reverse boolean DEFAULT false NOT NULL,
    CONSTRAINT out_of_band_migrations_component_nonempty CHECK ((component <> ''::text)),
    CONSTRAINT out_of_band_migrations_deprecated_valid_version CHECK ((deprecated ~ '^(\d+)\.(\d+)\.(\d+)$'::text)),
    CONSTRAINT out_of_band_migrations_description_nonempty CHECK ((description <> ''::text)),
    CONSTRAINT out_of_band_migrations_introduced_valid_version CHECK ((introduced ~ '^(\d+)\.(\d+)\.(\d+)$'::text)),
    CONSTRAINT out_of_band_migrations_progress_range CHECK (((progress >= (0)::double precision) AND (progress <= (1)::double precision))),
    CONSTRAINT out_of_band_migrations_team_nonempty CHECK ((team <> ''::text))
);

CREATE TABLE out_of_band_migrations_errors (
    id integer NOT NULL,
    migration_id integer NOT NULL,
    message text NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT out_of_band_migrations_errors_message_nonempty CHECK ((message <> ''::text))
);

CREATE SEQUENCE out_of_band_migrations_errors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE out_of_band_migrations_errors_id_seq OWNED BY out_of_band_migrations_errors.id;

CREATE SEQUENCE out_of_band_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE out_of_band_migrations_id_seq OWNED BY out_of_band_migrations.id;

CREATE TABLE phabricator_repos (
    id integer NOT NULL,
    callsign citext NOT NULL,
    repo_name citext NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    url text DEFAULT ''::text NOT NULL
);

CREATE SEQUENCE phabricator_repos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE phabricator_repos_id_seq OWNED BY phabricator_repos.id;

CREATE TABLE product_licenses (
    id uuid NOT NULL,
    product_subscription_id uuid NOT NULL,
    license_key text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE product_subscriptions (
    id uuid NOT NULL,
    user_id integer NOT NULL,
    billing_subscription_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    archived_at timestamp with time zone
);

CREATE TABLE query_runner_state (
    query text,
    last_executed timestamp with time zone,
    latest_result timestamp with time zone,
    exec_duration_ns bigint
);

CREATE TABLE users (
    id integer NOT NULL,
    username citext NOT NULL,
    display_name text,
    avatar_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    invite_quota integer DEFAULT 15 NOT NULL,
    passwd text,
    passwd_reset_code text,
    passwd_reset_time timestamp with time zone,
    site_admin boolean DEFAULT false NOT NULL,
    page_views integer DEFAULT 0 NOT NULL,
    search_queries integer DEFAULT 0 NOT NULL,
    tags text[] DEFAULT '{}'::text[],
    billing_customer_id text,
    invalidated_sessions_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT users_display_name_max_length CHECK ((char_length(display_name) <= 255)),
    CONSTRAINT users_username_max_length CHECK ((char_length((username)::text) <= 255)),
    CONSTRAINT users_username_valid_chars CHECK ((username OPERATOR(~) '^[a-zA-Z0-9](?:[a-zA-Z0-9]|[-.](?=[a-zA-Z0-9]))*-?$'::citext))
);

CREATE VIEW reconciler_changesets AS
 SELECT c.id,
    c.batch_change_ids,
    c.repo_id,
    c.created_at,
    c.updated_at,
    c.metadata,
    c.external_id,
    c.external_service_type,
    c.external_deleted_at,
    c.external_branch,
    c.external_updated_at,
    c.external_state,
    c.external_review_state,
    c.external_check_state,
    c.diff_stat_added,
    c.diff_stat_changed,
    c.diff_stat_deleted,
    c.sync_state,
    c.current_spec_id,
    c.previous_spec_id,
    c.publication_state,
    c.owned_by_batch_change_id,
    c.reconciler_state,
    c.failure_message,
    c.started_at,
    c.finished_at,
    c.process_after,
    c.num_resets,
    c.closing,
    c.num_failures,
    c.log_contents,
    c.execution_logs,
    c.syncer_error
   FROM (changesets c
     JOIN repo r ON ((r.id = c.repo_id)))
  WHERE ((r.deleted_at IS NULL) AND (EXISTS ( SELECT 1
           FROM ((batch_changes
             LEFT JOIN users namespace_user ON ((batch_changes.namespace_user_id = namespace_user.id)))
             LEFT JOIN orgs namespace_org ON ((batch_changes.namespace_org_id = namespace_org.id)))
          WHERE ((c.batch_change_ids ? (batch_changes.id)::text) AND (namespace_user.deleted_at IS NULL) AND (namespace_org.deleted_at IS NULL)))));

CREATE TABLE registry_extension_releases (
    id bigint NOT NULL,
    registry_extension_id integer NOT NULL,
    creator_user_id integer NOT NULL,
    release_version citext,
    release_tag citext NOT NULL,
    manifest jsonb NOT NULL,
    bundle text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    source_map text
);

CREATE SEQUENCE registry_extension_releases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE registry_extension_releases_id_seq OWNED BY registry_extension_releases.id;

CREATE TABLE registry_extensions (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    publisher_user_id integer,
    publisher_org_id integer,
    name citext NOT NULL,
    manifest text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT registry_extensions_name_length CHECK (((char_length((name)::text) > 0) AND (char_length((name)::text) <= 128))),
    CONSTRAINT registry_extensions_name_valid_chars CHECK ((name OPERATOR(~) '^[a-zA-Z0-9](?:[a-zA-Z0-9]|[_.-](?=[a-zA-Z0-9]))*$'::citext)),
    CONSTRAINT registry_extensions_single_publisher CHECK (((publisher_user_id IS NULL) <> (publisher_org_id IS NULL)))
);

CREATE SEQUENCE registry_extensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE registry_extensions_id_seq OWNED BY registry_extensions.id;

CREATE SEQUENCE repo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE repo_id_seq OWNED BY repo.id;

CREATE TABLE repo_pending_permissions (
    repo_id integer NOT NULL,
    permission text NOT NULL,
    user_ids bytea DEFAULT '\x'::bytea NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_ids_ints integer[] DEFAULT '{}'::integer[] NOT NULL
);

CREATE TABLE repo_permissions (
    repo_id integer NOT NULL,
    permission text NOT NULL,
    user_ids bytea DEFAULT '\x'::bytea NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    synced_at timestamp with time zone,
    user_ids_ints integer[] DEFAULT '{}'::integer[] NOT NULL
);

CREATE TABLE saved_searches (
    id integer NOT NULL,
    description text NOT NULL,
    query text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    notify_owner boolean NOT NULL,
    notify_slack boolean NOT NULL,
    user_id integer,
    org_id integer,
    slack_webhook_url text,
    CONSTRAINT user_or_org_id_not_null CHECK ((((user_id IS NOT NULL) AND (org_id IS NULL)) OR ((org_id IS NOT NULL) AND (user_id IS NULL))))
);

CREATE SEQUENCE saved_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE saved_searches_id_seq OWNED BY saved_searches.id;

CREATE TABLE settings (
    id integer NOT NULL,
    org_id integer,
    contents text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer,
    author_user_id integer
);

CREATE TABLE settings_bkup_1514702776 (
    id integer,
    org_id integer,
    author_user_id_old text,
    contents text,
    created_at timestamp with time zone,
    user_id integer,
    author_user_id integer
);

CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE settings_id_seq OWNED BY settings.id;

CREATE VIEW site_config AS
 SELECT global_state.site_id,
    global_state.initialized
   FROM global_state;

CREATE TABLE survey_responses (
    id bigint NOT NULL,
    user_id integer,
    email text,
    score integer NOT NULL,
    reason text,
    better text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE survey_responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE survey_responses_id_seq OWNED BY survey_responses.id;

CREATE VIEW tracking_changeset_specs_and_changesets AS
 SELECT changeset_specs.id AS changeset_spec_id,
    COALESCE(changesets.id, (0)::bigint) AS changeset_id,
    changeset_specs.repo_id,
    changeset_specs.batch_spec_id,
    repo.name AS repo_name,
    COALESCE((changesets.metadata ->> 'Title'::text), (changesets.metadata ->> 'title'::text)) AS changeset_name,
    changesets.external_state,
    changesets.publication_state,
    changesets.reconciler_state
   FROM ((changeset_specs
     LEFT JOIN changesets ON (((changesets.repo_id = changeset_specs.repo_id) AND (changesets.external_id = changeset_specs.external_id))))
     JOIN repo ON ((changeset_specs.repo_id = repo.id)))
  WHERE ((changeset_specs.external_id IS NOT NULL) AND (repo.deleted_at IS NULL));

CREATE TABLE user_credentials (
    id bigint NOT NULL,
    domain text NOT NULL,
    user_id integer NOT NULL,
    external_service_type text NOT NULL,
    external_service_id text NOT NULL,
    credential text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE user_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE user_credentials_id_seq OWNED BY user_credentials.id;

CREATE TABLE user_emails (
    user_id integer NOT NULL,
    email citext NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    verification_code text,
    verified_at timestamp with time zone,
    last_verification_sent_at timestamp with time zone,
    is_primary boolean DEFAULT false NOT NULL
);

CREATE TABLE user_external_accounts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    service_type text NOT NULL,
    service_id text NOT NULL,
    account_id text NOT NULL,
    auth_data text,
    account_data text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_id text NOT NULL,
    expired_at timestamp with time zone,
    last_valid_at timestamp with time zone
);

CREATE SEQUENCE user_external_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE user_external_accounts_id_seq OWNED BY user_external_accounts.id;

CREATE TABLE user_pending_permissions (
    id integer NOT NULL,
    bind_id text NOT NULL,
    permission text NOT NULL,
    object_type text NOT NULL,
    object_ids bytea DEFAULT '\x'::bytea NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    service_type text NOT NULL,
    service_id text NOT NULL,
    object_ids_ints integer[] DEFAULT '{}'::integer[] NOT NULL
);

CREATE SEQUENCE user_pending_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE user_pending_permissions_id_seq OWNED BY user_pending_permissions.id;

CREATE TABLE user_permissions (
    user_id integer NOT NULL,
    permission text NOT NULL,
    object_type text NOT NULL,
    object_ids bytea DEFAULT '\x'::bytea NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    synced_at timestamp with time zone,
    object_ids_ints integer[] DEFAULT '{}'::integer[] NOT NULL
);

CREATE TABLE user_public_repos (
    user_id integer NOT NULL,
    repo_uri text NOT NULL,
    repo_id integer NOT NULL
);

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE users_id_seq OWNED BY users.id;

CREATE TABLE versions (
    service text NOT NULL,
    version text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY access_tokens ALTER COLUMN id SET DEFAULT nextval('access_tokens_id_seq'::regclass);

ALTER TABLE ONLY batch_changes ALTER COLUMN id SET DEFAULT nextval('batch_changes_id_seq'::regclass);

ALTER TABLE ONLY batch_specs ALTER COLUMN id SET DEFAULT nextval('batch_specs_id_seq'::regclass);

ALTER TABLE ONLY changeset_events ALTER COLUMN id SET DEFAULT nextval('changeset_events_id_seq'::regclass);

ALTER TABLE ONLY changeset_specs ALTER COLUMN id SET DEFAULT nextval('changeset_specs_id_seq'::regclass);

ALTER TABLE ONLY changesets ALTER COLUMN id SET DEFAULT nextval('changesets_id_seq'::regclass);

ALTER TABLE ONLY cm_action_jobs ALTER COLUMN id SET DEFAULT nextval('cm_action_jobs_id_seq'::regclass);

ALTER TABLE ONLY cm_emails ALTER COLUMN id SET DEFAULT nextval('cm_emails_id_seq'::regclass);

ALTER TABLE ONLY cm_monitors ALTER COLUMN id SET DEFAULT nextval('cm_monitors_id_seq'::regclass);

ALTER TABLE ONLY cm_queries ALTER COLUMN id SET DEFAULT nextval('cm_queries_id_seq'::regclass);

ALTER TABLE ONLY cm_recipients ALTER COLUMN id SET DEFAULT nextval('cm_recipients_id_seq'::regclass);

ALTER TABLE ONLY cm_trigger_jobs ALTER COLUMN id SET DEFAULT nextval('cm_trigger_jobs_id_seq'::regclass);

ALTER TABLE ONLY critical_and_site_config ALTER COLUMN id SET DEFAULT nextval('critical_and_site_config_id_seq'::regclass);

ALTER TABLE ONLY discussion_comments ALTER COLUMN id SET DEFAULT nextval('discussion_comments_id_seq'::regclass);

ALTER TABLE ONLY discussion_threads ALTER COLUMN id SET DEFAULT nextval('discussion_threads_id_seq'::regclass);

ALTER TABLE ONLY discussion_threads_target_repo ALTER COLUMN id SET DEFAULT nextval('discussion_threads_target_repo_id_seq'::regclass);

ALTER TABLE ONLY event_logs ALTER COLUMN id SET DEFAULT nextval('event_logs_id_seq'::regclass);

ALTER TABLE ONLY external_services ALTER COLUMN id SET DEFAULT nextval('external_services_id_seq'::regclass);

ALTER TABLE ONLY insights_query_runner_jobs ALTER COLUMN id SET DEFAULT nextval('insights_query_runner_jobs_id_seq'::regclass);

ALTER TABLE ONLY lsif_index_configuration ALTER COLUMN id SET DEFAULT nextval('lsif_index_configuration_id_seq'::regclass);

ALTER TABLE ONLY lsif_indexable_repositories ALTER COLUMN id SET DEFAULT nextval('lsif_indexable_repositories_id_seq'::regclass);

ALTER TABLE ONLY lsif_indexes ALTER COLUMN id SET DEFAULT nextval('lsif_indexes_id_seq'::regclass);

ALTER TABLE ONLY lsif_packages ALTER COLUMN id SET DEFAULT nextval('lsif_packages_id_seq'::regclass);

ALTER TABLE ONLY lsif_references ALTER COLUMN id SET DEFAULT nextval('lsif_references_id_seq'::regclass);

ALTER TABLE ONLY lsif_uploads ALTER COLUMN id SET DEFAULT nextval('lsif_dumps_id_seq'::regclass);

ALTER TABLE ONLY org_invitations ALTER COLUMN id SET DEFAULT nextval('org_invitations_id_seq'::regclass);

ALTER TABLE ONLY org_members ALTER COLUMN id SET DEFAULT nextval('org_members_id_seq'::regclass);

ALTER TABLE ONLY orgs ALTER COLUMN id SET DEFAULT nextval('orgs_id_seq'::regclass);

ALTER TABLE ONLY out_of_band_migrations ALTER COLUMN id SET DEFAULT nextval('out_of_band_migrations_id_seq'::regclass);

ALTER TABLE ONLY out_of_band_migrations_errors ALTER COLUMN id SET DEFAULT nextval('out_of_band_migrations_errors_id_seq'::regclass);

ALTER TABLE ONLY phabricator_repos ALTER COLUMN id SET DEFAULT nextval('phabricator_repos_id_seq'::regclass);

ALTER TABLE ONLY registry_extension_releases ALTER COLUMN id SET DEFAULT nextval('registry_extension_releases_id_seq'::regclass);

ALTER TABLE ONLY registry_extensions ALTER COLUMN id SET DEFAULT nextval('registry_extensions_id_seq'::regclass);

ALTER TABLE ONLY repo ALTER COLUMN id SET DEFAULT nextval('repo_id_seq'::regclass);

ALTER TABLE ONLY saved_searches ALTER COLUMN id SET DEFAULT nextval('saved_searches_id_seq'::regclass);

ALTER TABLE ONLY settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);

ALTER TABLE ONLY survey_responses ALTER COLUMN id SET DEFAULT nextval('survey_responses_id_seq'::regclass);

ALTER TABLE ONLY user_credentials ALTER COLUMN id SET DEFAULT nextval('user_credentials_id_seq'::regclass);

ALTER TABLE ONLY user_external_accounts ALTER COLUMN id SET DEFAULT nextval('user_external_accounts_id_seq'::regclass);

ALTER TABLE ONLY user_pending_permissions ALTER COLUMN id SET DEFAULT nextval('user_pending_permissions_id_seq'::regclass);

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);

ALTER TABLE ONLY access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (id);

ALTER TABLE ONLY access_tokens
    ADD CONSTRAINT access_tokens_value_sha256_key UNIQUE (value_sha256);

ALTER TABLE ONLY batch_changes
    ADD CONSTRAINT batch_changes_pkey PRIMARY KEY (id);

ALTER TABLE ONLY batch_specs
    ADD CONSTRAINT batch_specs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY changeset_events
    ADD CONSTRAINT changeset_events_changeset_id_kind_key_unique UNIQUE (changeset_id, kind, key);

ALTER TABLE ONLY changeset_events
    ADD CONSTRAINT changeset_events_pkey PRIMARY KEY (id);

ALTER TABLE ONLY changeset_specs
    ADD CONSTRAINT changeset_specs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY changesets
    ADD CONSTRAINT changesets_pkey PRIMARY KEY (id);

ALTER TABLE ONLY changesets
    ADD CONSTRAINT changesets_repo_external_id_unique UNIQUE (repo_id, external_id);

ALTER TABLE ONLY cm_action_jobs
    ADD CONSTRAINT cm_action_jobs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY cm_emails
    ADD CONSTRAINT cm_emails_pkey PRIMARY KEY (id);

ALTER TABLE ONLY cm_monitors
    ADD CONSTRAINT cm_monitors_pkey PRIMARY KEY (id);

ALTER TABLE ONLY cm_queries
    ADD CONSTRAINT cm_queries_pkey PRIMARY KEY (id);

ALTER TABLE ONLY cm_recipients
    ADD CONSTRAINT cm_recipients_pkey PRIMARY KEY (id);

ALTER TABLE ONLY cm_trigger_jobs
    ADD CONSTRAINT cm_trigger_jobs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY critical_and_site_config
    ADD CONSTRAINT critical_and_site_config_pkey PRIMARY KEY (id);

ALTER TABLE ONLY default_repos
    ADD CONSTRAINT default_repos_pkey PRIMARY KEY (repo_id);

ALTER TABLE ONLY discussion_comments
    ADD CONSTRAINT discussion_comments_pkey PRIMARY KEY (id);

ALTER TABLE ONLY discussion_mail_reply_tokens
    ADD CONSTRAINT discussion_mail_reply_tokens_pkey PRIMARY KEY (token);

ALTER TABLE ONLY discussion_threads
    ADD CONSTRAINT discussion_threads_pkey PRIMARY KEY (id);

ALTER TABLE ONLY discussion_threads_target_repo
    ADD CONSTRAINT discussion_threads_target_repo_pkey PRIMARY KEY (id);

ALTER TABLE ONLY event_logs
    ADD CONSTRAINT event_logs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY external_service_repos
    ADD CONSTRAINT external_service_repos_repo_id_external_service_id_unique UNIQUE (repo_id, external_service_id);

ALTER TABLE ONLY external_services
    ADD CONSTRAINT external_services_pkey PRIMARY KEY (id);

ALTER TABLE ONLY gitserver_repos
    ADD CONSTRAINT gitserver_repos_pkey PRIMARY KEY (repo_id);

ALTER TABLE ONLY global_state
    ADD CONSTRAINT global_state_pkey PRIMARY KEY (site_id);

ALTER TABLE ONLY insights_query_runner_jobs
    ADD CONSTRAINT insights_query_runner_jobs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY lsif_dirty_repositories
    ADD CONSTRAINT lsif_dirty_repositories_pkey PRIMARY KEY (repository_id);

ALTER TABLE ONLY lsif_index_configuration
    ADD CONSTRAINT lsif_index_configuration_pkey PRIMARY KEY (id);

ALTER TABLE ONLY lsif_index_configuration
    ADD CONSTRAINT lsif_index_configuration_repository_id_key UNIQUE (repository_id);

ALTER TABLE ONLY lsif_indexable_repositories
    ADD CONSTRAINT lsif_indexable_repositories_pkey PRIMARY KEY (id);

ALTER TABLE ONLY lsif_indexable_repositories
    ADD CONSTRAINT lsif_indexable_repositories_repository_id_key UNIQUE (repository_id);

ALTER TABLE ONLY lsif_indexes
    ADD CONSTRAINT lsif_indexes_pkey PRIMARY KEY (id);

ALTER TABLE ONLY lsif_packages
    ADD CONSTRAINT lsif_packages_pkey PRIMARY KEY (id);

ALTER TABLE ONLY lsif_references
    ADD CONSTRAINT lsif_references_pkey PRIMARY KEY (id);

ALTER TABLE ONLY lsif_uploads
    ADD CONSTRAINT lsif_uploads_pkey PRIMARY KEY (id);

ALTER TABLE ONLY names
    ADD CONSTRAINT names_pkey PRIMARY KEY (name);

ALTER TABLE ONLY org_invitations
    ADD CONSTRAINT org_invitations_pkey PRIMARY KEY (id);

ALTER TABLE ONLY org_members
    ADD CONSTRAINT org_members_org_id_user_id_key UNIQUE (org_id, user_id);

ALTER TABLE ONLY org_members
    ADD CONSTRAINT org_members_pkey PRIMARY KEY (id);

ALTER TABLE ONLY orgs
    ADD CONSTRAINT orgs_pkey PRIMARY KEY (id);

ALTER TABLE ONLY out_of_band_migrations_errors
    ADD CONSTRAINT out_of_band_migrations_errors_pkey PRIMARY KEY (id);

ALTER TABLE ONLY out_of_band_migrations
    ADD CONSTRAINT out_of_band_migrations_pkey PRIMARY KEY (id);

ALTER TABLE ONLY phabricator_repos
    ADD CONSTRAINT phabricator_repos_pkey PRIMARY KEY (id);

ALTER TABLE ONLY phabricator_repos
    ADD CONSTRAINT phabricator_repos_repo_name_key UNIQUE (repo_name);

ALTER TABLE ONLY product_licenses
    ADD CONSTRAINT product_licenses_pkey PRIMARY KEY (id);

ALTER TABLE ONLY product_subscriptions
    ADD CONSTRAINT product_subscriptions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY registry_extension_releases
    ADD CONSTRAINT registry_extension_releases_pkey PRIMARY KEY (id);

ALTER TABLE ONLY registry_extensions
    ADD CONSTRAINT registry_extensions_pkey PRIMARY KEY (id);

ALTER TABLE ONLY repo
    ADD CONSTRAINT repo_name_unique UNIQUE (name) DEFERRABLE;

ALTER TABLE ONLY repo_pending_permissions
    ADD CONSTRAINT repo_pending_permissions_perm_unique UNIQUE (repo_id, permission);

ALTER TABLE ONLY repo_permissions
    ADD CONSTRAINT repo_permissions_perm_unique UNIQUE (repo_id, permission);

ALTER TABLE ONLY repo
    ADD CONSTRAINT repo_pkey PRIMARY KEY (id);

ALTER TABLE ONLY saved_searches
    ADD CONSTRAINT saved_searches_pkey PRIMARY KEY (id);

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);

ALTER TABLE ONLY survey_responses
    ADD CONSTRAINT survey_responses_pkey PRIMARY KEY (id);

ALTER TABLE ONLY user_credentials
    ADD CONSTRAINT user_credentials_domain_user_id_external_service_type_exter_key UNIQUE (domain, user_id, external_service_type, external_service_id);

ALTER TABLE ONLY user_credentials
    ADD CONSTRAINT user_credentials_pkey PRIMARY KEY (id);

ALTER TABLE ONLY user_emails
    ADD CONSTRAINT user_emails_no_duplicates_per_user UNIQUE (user_id, email);

ALTER TABLE ONLY user_emails
    ADD CONSTRAINT user_emails_unique_verified_email EXCLUDE USING btree (email WITH OPERATOR(=)) WHERE ((verified_at IS NOT NULL));

ALTER TABLE ONLY user_external_accounts
    ADD CONSTRAINT user_external_accounts_pkey PRIMARY KEY (id);

ALTER TABLE ONLY user_pending_permissions
    ADD CONSTRAINT user_pending_permissions_service_perm_object_unique UNIQUE (service_type, service_id, permission, object_type, bind_id);

ALTER TABLE ONLY user_permissions
    ADD CONSTRAINT user_permissions_perm_object_unique UNIQUE (user_id, permission, object_type);

ALTER TABLE ONLY user_public_repos
    ADD CONSTRAINT user_public_repos_user_id_repo_id_key UNIQUE (user_id, repo_id);

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (service);

CREATE INDEX access_tokens_lookup ON access_tokens USING hash (value_sha256) WHERE (deleted_at IS NULL);

CREATE INDEX batch_changes_namespace_org_id ON batch_changes USING btree (namespace_org_id);

CREATE INDEX batch_changes_namespace_user_id ON batch_changes USING btree (namespace_user_id);

CREATE INDEX batch_specs_rand_id ON batch_specs USING btree (rand_id);

CREATE INDEX changeset_specs_external_id ON changeset_specs USING btree (external_id);

CREATE INDEX changeset_specs_head_ref ON changeset_specs USING btree (head_ref);

CREATE INDEX changeset_specs_rand_id ON changeset_specs USING btree (rand_id);

CREATE INDEX changeset_specs_title ON changeset_specs USING btree (title);

CREATE INDEX changesets_batch_change_ids ON changesets USING gin (batch_change_ids);

CREATE INDEX changesets_external_state_idx ON changesets USING btree (external_state);

CREATE INDEX changesets_external_title_idx ON changesets USING btree (external_title);

CREATE INDEX changesets_publication_state_idx ON changesets USING btree (publication_state);

CREATE INDEX changesets_reconciler_state_idx ON changesets USING btree (reconciler_state);

CREATE UNIQUE INDEX critical_and_site_config_unique ON critical_and_site_config USING btree (id, type);

CREATE INDEX discussion_comments_author_user_id_idx ON discussion_comments USING btree (author_user_id);

CREATE INDEX discussion_comments_reports_array_length_idx ON discussion_comments USING btree (array_length(reports, 1));

CREATE INDEX discussion_comments_thread_id_idx ON discussion_comments USING btree (thread_id);

CREATE INDEX discussion_mail_reply_tokens_user_id_thread_id_idx ON discussion_mail_reply_tokens USING btree (user_id, thread_id);

CREATE INDEX discussion_threads_author_user_id_idx ON discussion_threads USING btree (author_user_id);

CREATE INDEX discussion_threads_target_repo_repo_id_path_idx ON discussion_threads_target_repo USING btree (repo_id, path);

CREATE INDEX event_logs_anonymous_user_id ON event_logs USING btree (anonymous_user_id);

CREATE INDEX event_logs_name ON event_logs USING btree (name);

CREATE INDEX event_logs_source ON event_logs USING btree (source);

CREATE INDEX event_logs_timestamp ON event_logs USING btree ("timestamp");

CREATE INDEX event_logs_timestamp_at_utc ON event_logs USING btree (date(timezone('UTC'::text, "timestamp")));

CREATE INDEX event_logs_user_id ON event_logs USING btree (user_id);

CREATE INDEX external_service_repos_external_service_id ON external_service_repos USING btree (external_service_id);

CREATE INDEX external_service_repos_idx ON external_service_repos USING btree (external_service_id, repo_id);

CREATE INDEX external_service_sync_jobs_state_idx ON external_service_sync_jobs USING btree (state);

CREATE INDEX external_services_namespace_user_id_idx ON external_services USING btree (namespace_user_id);

CREATE INDEX gitserver_repos_cloned_status_idx ON gitserver_repos USING btree (repo_id) WHERE (clone_status = 'cloned'::text);

CREATE INDEX gitserver_repos_cloning_status_idx ON gitserver_repos USING btree (repo_id) WHERE (clone_status = 'cloning'::text);

CREATE INDEX gitserver_repos_not_cloned_status_idx ON gitserver_repos USING btree (repo_id) WHERE (clone_status = 'not_cloned'::text);

CREATE INDEX insights_query_runner_jobs_state_btree ON insights_query_runner_jobs USING btree (state);

CREATE UNIQUE INDEX kind_cloud_default ON external_services USING btree (kind, cloud_default) WHERE ((cloud_default = true) AND (deleted_at IS NULL));

CREATE INDEX lsif_nearest_uploads_links_repository_id_commit_bytea ON lsif_nearest_uploads_links USING btree (repository_id, commit_bytea);

CREATE INDEX lsif_nearest_uploads_repository_id_commit_bytea ON lsif_nearest_uploads USING btree (repository_id, commit_bytea);

CREATE INDEX lsif_packages_scheme_name_version ON lsif_packages USING btree (scheme, name, version);

CREATE INDEX lsif_references_package ON lsif_references USING btree (scheme, name, version);

CREATE UNIQUE INDEX lsif_uploads_repository_id_commit_root_indexer ON lsif_uploads USING btree (repository_id, commit, root, indexer) WHERE (state = 'completed'::text);

CREATE INDEX lsif_uploads_state ON lsif_uploads USING btree (state);

CREATE INDEX lsif_uploads_uploaded_at ON lsif_uploads USING btree (uploaded_at);

CREATE INDEX lsif_uploads_visible_at_tip_repository_id_upload_id ON lsif_uploads_visible_at_tip USING btree (repository_id, upload_id);

CREATE INDEX org_invitations_org_id ON org_invitations USING btree (org_id) WHERE (deleted_at IS NULL);

CREATE INDEX org_invitations_recipient_user_id ON org_invitations USING btree (recipient_user_id) WHERE (deleted_at IS NULL);

CREATE UNIQUE INDEX org_invitations_singleflight ON org_invitations USING btree (org_id, recipient_user_id) WHERE ((responded_at IS NULL) AND (revoked_at IS NULL) AND (deleted_at IS NULL));

CREATE UNIQUE INDEX orgs_name ON orgs USING btree (name) WHERE (deleted_at IS NULL);

CREATE INDEX registry_extension_releases_registry_extension_id ON registry_extension_releases USING btree (registry_extension_id, release_tag, created_at DESC) WHERE (deleted_at IS NULL);

CREATE UNIQUE INDEX registry_extension_releases_version ON registry_extension_releases USING btree (registry_extension_id, release_version) WHERE (release_version IS NOT NULL);

CREATE UNIQUE INDEX registry_extensions_publisher_name ON registry_extensions USING btree (COALESCE(publisher_user_id, 0), COALESCE(publisher_org_id, 0), name) WHERE (deleted_at IS NULL);

CREATE UNIQUE INDEX registry_extensions_uuid ON registry_extensions USING btree (uuid);

CREATE INDEX repo_archived ON repo USING btree (archived);

CREATE INDEX repo_cloned ON repo USING btree (cloned);

CREATE INDEX repo_created_at ON repo USING btree (created_at);

CREATE UNIQUE INDEX repo_external_unique_idx ON repo USING btree (external_service_type, external_service_id, external_id);

CREATE INDEX repo_fork ON repo USING btree (fork);

CREATE INDEX repo_metadata_gin_idx ON repo USING gin (metadata);

CREATE INDEX repo_name_idx ON repo USING btree (lower((name)::text) COLLATE "C");

CREATE INDEX repo_name_trgm ON repo USING gin (lower((name)::text) gin_trgm_ops);

CREATE INDEX repo_private ON repo USING btree (private);

CREATE INDEX repo_uri_idx ON repo USING btree (uri);

CREATE INDEX settings_org_id_idx ON settings USING btree (org_id);

CREATE UNIQUE INDEX user_emails_user_id_is_primary_idx ON user_emails USING btree (user_id, is_primary) WHERE (is_primary = true);

CREATE UNIQUE INDEX user_external_accounts_account ON user_external_accounts USING btree (service_type, service_id, client_id, account_id) WHERE (deleted_at IS NULL);

CREATE INDEX user_external_accounts_user_id ON user_external_accounts USING btree (user_id) WHERE (deleted_at IS NULL);

CREATE UNIQUE INDEX users_billing_customer_id ON users USING btree (billing_customer_id) WHERE (deleted_at IS NULL);

CREATE INDEX users_created_at_idx ON users USING btree (created_at);

CREATE UNIQUE INDEX users_username ON users USING btree (username) WHERE (deleted_at IS NULL);

CREATE TRIGGER trig_delete_batch_change_reference_on_changesets AFTER DELETE ON batch_changes FOR EACH ROW EXECUTE FUNCTION delete_batch_change_reference_on_changesets();

CREATE TRIGGER trig_delete_external_service_ref_on_external_service_repos AFTER UPDATE OF deleted_at ON external_services FOR EACH ROW EXECUTE FUNCTION delete_external_service_ref_on_external_service_repos();

CREATE TRIGGER trig_delete_repo_ref_on_external_service_repos AFTER UPDATE OF deleted_at ON repo FOR EACH ROW EXECUTE FUNCTION delete_repo_ref_on_external_service_repos();

CREATE TRIGGER trig_invalidate_session_on_password_change BEFORE UPDATE OF passwd ON users FOR EACH ROW EXECUTE FUNCTION invalidate_session_for_userid_on_password_change();

CREATE TRIGGER trig_soft_delete_orphan_repo_by_external_service_repo AFTER DELETE ON external_service_repos FOR EACH STATEMENT EXECUTE FUNCTION soft_delete_orphan_repo_by_external_service_repos();

CREATE TRIGGER trig_soft_delete_user_reference_on_external_service AFTER UPDATE OF deleted_at ON users FOR EACH ROW EXECUTE FUNCTION soft_delete_user_reference_on_external_service();

ALTER TABLE ONLY access_tokens
    ADD CONSTRAINT access_tokens_creator_user_id_fkey FOREIGN KEY (creator_user_id) REFERENCES users(id);

ALTER TABLE ONLY access_tokens
    ADD CONSTRAINT access_tokens_subject_user_id_fkey FOREIGN KEY (subject_user_id) REFERENCES users(id);

ALTER TABLE ONLY batch_changes
    ADD CONSTRAINT batch_changes_batch_spec_id_fkey FOREIGN KEY (batch_spec_id) REFERENCES batch_specs(id) DEFERRABLE;

ALTER TABLE ONLY batch_changes
    ADD CONSTRAINT batch_changes_initial_applier_id_fkey FOREIGN KEY (initial_applier_id) REFERENCES users(id) ON DELETE SET NULL DEFERRABLE;

ALTER TABLE ONLY batch_changes
    ADD CONSTRAINT batch_changes_last_applier_id_fkey FOREIGN KEY (last_applier_id) REFERENCES users(id) ON DELETE SET NULL DEFERRABLE;

ALTER TABLE ONLY batch_changes
    ADD CONSTRAINT batch_changes_namespace_org_id_fkey FOREIGN KEY (namespace_org_id) REFERENCES orgs(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY batch_changes
    ADD CONSTRAINT batch_changes_namespace_user_id_fkey FOREIGN KEY (namespace_user_id) REFERENCES users(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY batch_specs
    ADD CONSTRAINT batch_specs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL DEFERRABLE;

ALTER TABLE ONLY changeset_events
    ADD CONSTRAINT changeset_events_changeset_id_fkey FOREIGN KEY (changeset_id) REFERENCES changesets(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY changeset_specs
    ADD CONSTRAINT changeset_specs_batch_spec_id_fkey FOREIGN KEY (batch_spec_id) REFERENCES batch_specs(id) DEFERRABLE;

ALTER TABLE ONLY changeset_specs
    ADD CONSTRAINT changeset_specs_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repo(id) DEFERRABLE;

ALTER TABLE ONLY changeset_specs
    ADD CONSTRAINT changeset_specs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL DEFERRABLE;

ALTER TABLE ONLY changesets
    ADD CONSTRAINT changesets_changeset_spec_id_fkey FOREIGN KEY (current_spec_id) REFERENCES changeset_specs(id) DEFERRABLE;

ALTER TABLE ONLY changesets
    ADD CONSTRAINT changesets_owned_by_batch_spec_id_fkey FOREIGN KEY (owned_by_batch_change_id) REFERENCES batch_changes(id) ON DELETE SET NULL DEFERRABLE;

ALTER TABLE ONLY changesets
    ADD CONSTRAINT changesets_previous_spec_id_fkey FOREIGN KEY (previous_spec_id) REFERENCES changeset_specs(id) DEFERRABLE;

ALTER TABLE ONLY changesets
    ADD CONSTRAINT changesets_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repo(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY cm_action_jobs
    ADD CONSTRAINT cm_action_jobs_email_fk FOREIGN KEY (email) REFERENCES cm_emails(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_action_jobs
    ADD CONSTRAINT cm_action_jobs_trigger_event_fk FOREIGN KEY (trigger_event) REFERENCES cm_trigger_jobs(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_emails
    ADD CONSTRAINT cm_emails_changed_by_fk FOREIGN KEY (changed_by) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_emails
    ADD CONSTRAINT cm_emails_created_by_fk FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_emails
    ADD CONSTRAINT cm_emails_monitor FOREIGN KEY (monitor) REFERENCES cm_monitors(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_monitors
    ADD CONSTRAINT cm_monitors_changed_by_fk FOREIGN KEY (changed_by) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_monitors
    ADD CONSTRAINT cm_monitors_created_by_fk FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_monitors
    ADD CONSTRAINT cm_monitors_org_id_fk FOREIGN KEY (namespace_org_id) REFERENCES orgs(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_monitors
    ADD CONSTRAINT cm_monitors_user_id_fk FOREIGN KEY (namespace_user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_recipients
    ADD CONSTRAINT cm_recipients_emails FOREIGN KEY (email) REFERENCES cm_emails(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_recipients
    ADD CONSTRAINT cm_recipients_org_id_fk FOREIGN KEY (namespace_org_id) REFERENCES orgs(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_recipients
    ADD CONSTRAINT cm_recipients_user_id_fk FOREIGN KEY (namespace_user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_trigger_jobs
    ADD CONSTRAINT cm_trigger_jobs_query_fk FOREIGN KEY (query) REFERENCES cm_queries(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_queries
    ADD CONSTRAINT cm_triggers_changed_by_fk FOREIGN KEY (changed_by) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_queries
    ADD CONSTRAINT cm_triggers_created_by_fk FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE ONLY cm_queries
    ADD CONSTRAINT cm_triggers_monitor FOREIGN KEY (monitor) REFERENCES cm_monitors(id) ON DELETE CASCADE;

ALTER TABLE ONLY default_repos
    ADD CONSTRAINT default_repos_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repo(id) ON DELETE CASCADE;

ALTER TABLE ONLY discussion_comments
    ADD CONSTRAINT discussion_comments_author_user_id_fkey FOREIGN KEY (author_user_id) REFERENCES users(id) ON DELETE RESTRICT;

ALTER TABLE ONLY discussion_comments
    ADD CONSTRAINT discussion_comments_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES discussion_threads(id) ON DELETE CASCADE;

ALTER TABLE ONLY discussion_mail_reply_tokens
    ADD CONSTRAINT discussion_mail_reply_tokens_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES discussion_threads(id) ON DELETE CASCADE;

ALTER TABLE ONLY discussion_mail_reply_tokens
    ADD CONSTRAINT discussion_mail_reply_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT;

ALTER TABLE ONLY discussion_threads
    ADD CONSTRAINT discussion_threads_author_user_id_fkey FOREIGN KEY (author_user_id) REFERENCES users(id) ON DELETE RESTRICT;

ALTER TABLE ONLY discussion_threads
    ADD CONSTRAINT discussion_threads_target_repo_id_fk FOREIGN KEY (target_repo_id) REFERENCES discussion_threads_target_repo(id) ON DELETE CASCADE;

ALTER TABLE ONLY discussion_threads_target_repo
    ADD CONSTRAINT discussion_threads_target_repo_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repo(id) ON DELETE CASCADE;

ALTER TABLE ONLY discussion_threads_target_repo
    ADD CONSTRAINT discussion_threads_target_repo_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES discussion_threads(id) ON DELETE CASCADE;

ALTER TABLE ONLY external_service_repos
    ADD CONSTRAINT external_service_repos_external_service_id_fkey FOREIGN KEY (external_service_id) REFERENCES external_services(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY external_service_repos
    ADD CONSTRAINT external_service_repos_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repo(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY external_service_sync_jobs
    ADD CONSTRAINT external_services_id_fk FOREIGN KEY (external_service_id) REFERENCES external_services(id);

ALTER TABLE ONLY external_services
    ADD CONSTRAINT external_services_namepspace_user_id_fkey FOREIGN KEY (namespace_user_id) REFERENCES users(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY gitserver_repos
    ADD CONSTRAINT gitserver_repos_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repo(id);

ALTER TABLE ONLY lsif_index_configuration
    ADD CONSTRAINT lsif_index_configuration_repository_id_fkey FOREIGN KEY (repository_id) REFERENCES repo(id) ON DELETE CASCADE;

ALTER TABLE ONLY lsif_packages
    ADD CONSTRAINT lsif_packages_dump_id_fkey FOREIGN KEY (dump_id) REFERENCES lsif_uploads(id) ON DELETE CASCADE;

ALTER TABLE ONLY lsif_references
    ADD CONSTRAINT lsif_references_dump_id_fkey FOREIGN KEY (dump_id) REFERENCES lsif_uploads(id) ON DELETE CASCADE;

ALTER TABLE ONLY names
    ADD CONSTRAINT names_org_id_fkey FOREIGN KEY (org_id) REFERENCES orgs(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY names
    ADD CONSTRAINT names_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY org_invitations
    ADD CONSTRAINT org_invitations_org_id_fkey FOREIGN KEY (org_id) REFERENCES orgs(id);

ALTER TABLE ONLY org_invitations
    ADD CONSTRAINT org_invitations_recipient_user_id_fkey FOREIGN KEY (recipient_user_id) REFERENCES users(id);

ALTER TABLE ONLY org_invitations
    ADD CONSTRAINT org_invitations_sender_user_id_fkey FOREIGN KEY (sender_user_id) REFERENCES users(id);

ALTER TABLE ONLY org_members
    ADD CONSTRAINT org_members_references_orgs FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE RESTRICT;

ALTER TABLE ONLY org_members
    ADD CONSTRAINT org_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT;

ALTER TABLE ONLY out_of_band_migrations_errors
    ADD CONSTRAINT out_of_band_migrations_errors_migration_id_fkey FOREIGN KEY (migration_id) REFERENCES out_of_band_migrations(id) ON DELETE CASCADE;

ALTER TABLE ONLY product_licenses
    ADD CONSTRAINT product_licenses_product_subscription_id_fkey FOREIGN KEY (product_subscription_id) REFERENCES product_subscriptions(id);

ALTER TABLE ONLY product_subscriptions
    ADD CONSTRAINT product_subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE ONLY registry_extension_releases
    ADD CONSTRAINT registry_extension_releases_creator_user_id_fkey FOREIGN KEY (creator_user_id) REFERENCES users(id);

ALTER TABLE ONLY registry_extension_releases
    ADD CONSTRAINT registry_extension_releases_registry_extension_id_fkey FOREIGN KEY (registry_extension_id) REFERENCES registry_extensions(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY registry_extensions
    ADD CONSTRAINT registry_extensions_publisher_org_id_fkey FOREIGN KEY (publisher_org_id) REFERENCES orgs(id);

ALTER TABLE ONLY registry_extensions
    ADD CONSTRAINT registry_extensions_publisher_user_id_fkey FOREIGN KEY (publisher_user_id) REFERENCES users(id);

ALTER TABLE ONLY saved_searches
    ADD CONSTRAINT saved_searches_org_id_fkey FOREIGN KEY (org_id) REFERENCES orgs(id);

ALTER TABLE ONLY saved_searches
    ADD CONSTRAINT saved_searches_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_author_user_id_fkey FOREIGN KEY (author_user_id) REFERENCES users(id) ON DELETE RESTRICT;

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_references_orgs FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE RESTRICT;

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT;

ALTER TABLE ONLY survey_responses
    ADD CONSTRAINT survey_responses_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE ONLY user_credentials
    ADD CONSTRAINT user_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE DEFERRABLE;

ALTER TABLE ONLY user_emails
    ADD CONSTRAINT user_emails_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE ONLY user_external_accounts
    ADD CONSTRAINT user_external_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE ONLY user_public_repos
    ADD CONSTRAINT user_public_repos_repo_id_fkey FOREIGN KEY (repo_id) REFERENCES repo(id) ON DELETE CASCADE;

ALTER TABLE ONLY user_public_repos
    ADD CONSTRAINT user_public_repos_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

COMMIT;
