# Architecture & Data Model

> **Updated YYYY-MM-DD** to match what's built (PRs #…). Decisions and their reasons: see the **Decision Log**. Day-to-day work: see the **Developer Runbook**.

## Stack (ADR 0001)

| Layer | Choice | Why |
| -- | -- | -- |
| App | | |
| Data / sync | | |
| Backend | | |
| Auth | | |
| Files | | |
| Push / email | | |
| Observability | | |
| Payments (later) | | |

## Core principle: everything hangs off `<tenant>`

<The access rule in one sentence.>

## Schema

```
<table>   column · column · column (notes)
```

Conventions: UUIDs generated on the client, `created_at`/`updated_at` in UTC, the zone stored where meaning depends on it, soft deletes purged after N days.

## Flows

### <Flow name> (built: <ticket>, PR #…)

```
client ──▶ <step> ──▶ <step>
              └─ <branch>
```

<Notes: what's cached, what's retried, what's server-only.>

## Planned

- <Feature>: <shape> (<ticket>)
