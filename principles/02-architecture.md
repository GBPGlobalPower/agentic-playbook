# Architecture principles

The shape of a system that holds up as it grows. Record each concrete choice as an ADR (`03-adrs-and-decisions.md`).

## Boundaries

1. **Everything hangs off a tenant.** Name the unit that owns data (workspace, account, space, org). Every content row carries its id, and access is decided by membership of it. Multi-tenant later is then a non-event, and so is billing.
2. **Authorisation lives where the data lives** (row-level security, policy middleware, a data-access layer), not only in the UI. Hiding a button isn't access control.
3. **One client per external service**, created in one module (`lib/db.ts`, `lib/stripe.ts`). Config, retries, auth and logging live there.
4. **Layers depend one way**: UI → feature logic → data access → infrastructure. Feature code doesn't import another feature's internals; shared code moves to a library or package with a public entry point. In a monorepo, enforce this with tags or lint rules.
5. **Server-made values need the server.** Codes, invites and payments are RPCs called online, not queued.

## Data flow

6. **Reads are cached queries keyed by scope**, for example `[tenant, table]`. Anything about the signed-in person is keyed by their user id too, so one account never sees another's cached answer after switching.
7. **Writes are idempotent.** The client generates the UUID, and a create is an upsert that ignores duplicates, so a retry or a replay never makes a second row.
8. **Writes that must survive go through a durable queue (an outbox)** when the product has to work offline or on bad networks. The queue is saved before the network call, transient failures retry with backoff, only permanent errors fail, and a write interrupted by a crash is sent after the restart.
9. **Retries live in one layer.** If the query library retries, turn off the HTTP client's retries.
10. **Live updates invalidate, they don't patch.** A change event invalidates the affected queries; after a reconnect, refetch everything in scope to catch what was missed.
11. **Never show an empty state before the data has arrived.** Every read has loading, error (with retry), offline and empty states (`04-design-and-ux.md`).

## Time

12. **Store instants in UTC with the IANA zone that gives them meaning**, and calendar dates as dates: a birthday is the same day everywhere.
13. **Never hand-roll time-zone maths.** One module does it, always with an explicit zone; it's property-tested across zones and DST changes.
14. **Enter times in the zone they happen in**, like a flight's landing on the arrival city's clock, and show them in the viewer's zone when that helps.

## Lifecycle

15. **Remove with a soft delete** (`deleted_at`). Clients filter it out, and a scheduled job purges after a retention window. Files follow their rows: an orphan sweep removes stored objects whose row is gone, and an object never goes while its row exists.
16. **The server stamps what clients can't be trusted with** (created times, "approved by", sequence numbers). The client keeps what only it knows, such as when an offline action happened.
17. **Background jobs are idempotent and re-plannable.** Scheduled work (notifications, reminders) is planned into a table, claimed with skip-locked, retried with backoff, and re-planned when its inputs change.

## Product-shaped infrastructure

18. **Billing-ready from day one.** The tenant is the billing unit. Gate costly creates through one entitlement check, server-side and mirrored on the client, with quotas held as data (an empty table means unlimited). No payment SDK until it's needed.
19. **Configuration as data.** Layouts, plan limits and feature switches live in files or tables that are validated by tests, not scattered through code.
20. **Privacy by construction.** Collect the least precise data that works (coarse location, rounded coordinates), strip metadata (EXIF), keep private text out of notifications and logs (`06-security-privacy.md`).

## Performance shape

21. **Set budgets early** (load time, interaction latency, API p95, bundle size) and measure them on real hardware (`11-observability-performance.md`).
22. **No always-on work.** Continuous animation, polling and timers run only while visible and needed, and stop under reduced motion.

## When to write it down

Anything hard to reverse (a vendor, a data model, an auth method, a rendering approach, a sync strategy) gets an ADR before it's built. If it's uncertain, run a time-boxed spike that measures the options, and let the ADR cite the numbers.
