
## Stack: Node.js service (TypeScript)

- **Runtime**: an LTS Node version pinned in `.nvmrc` or `engines` and in CI. TypeScript `strict`. ESM unless the ecosystem forces CJS.
- **Config**: read environment variables once at startup, validated with a schema (zod); the process exits with a clear message when something is missing. `.env.example` lists the names only.
- **Boundaries**: validate every request body, query and header with the same schemas that generate the API description (OpenAPI). Never trust client ids for authorisation: derive the tenant from the session.
- **Layers**: routes/handlers (thin) → services (rules, pure where possible, dependencies injected) → repositories (the only code that talks to the DB) → infrastructure clients (one per external service).
- **Idempotency**: POSTs that create things accept a client-generated id or an `Idempotency-Key`; retries never duplicate. Webhooks are verified (signature) and deduplicated by event id.
- **Errors**: one error type with a stable `code`, mapped to an HTTP status in one place. 4xx codes are permanent, 5xx and timeouts are transient. Never leak stack traces or SQL to clients.
- **Logging**: structured JSON (pino), a request id on every line, no personal content or secrets. Redact auth headers and tokens.
- **Operability**: `/healthz` (liveness) and `/readyz` (checks dependencies), graceful shutdown on SIGTERM (stop accepting, drain, close pools), timeouts on every outbound call, and rate limits on public endpoints.
- **Security**: `helmet` (or equivalent headers), CORS allow-list, body size limits, parameterised queries only, and dependency audit in CI. Run as a non-root user in containers with minimal base images.
- **Jobs**: background work through a queue or a DB-backed schedule with claim/skip-locked, retries with backoff, and a recorded outcome per job.
- **Tests**: unit tests for services with injected fakes; integration tests against real dependencies started locally (Docker Compose or Testcontainers), never live third-party APIs; contract tests for the public API.
