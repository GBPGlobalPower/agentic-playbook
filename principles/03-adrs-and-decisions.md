# ADRs and decisions

Decisions are cheap to make and expensive to rediscover. Write them down where the next person (or agent) will look.

## Two levels

| | ADR | Decision Log entry |
| -- | -- | -- |
| **For** | Hard-to-reverse, cross-cutting choices: stack, vendor, data model, auth, sync, rendering, hosting | Everything else that someone will ask "why?" about: product calls, conventions, limits, known advisories |
| **Where** | `docs/adr/NNNN-kebab-title.md` in the repo | One living document in the tracker (Product / Technical / Process sections), or `docs/decisions.md` |
| **Shape** | Context, options with trade-offs, decision, consequences | One table row: date, decision, why, source (ticket or PR) |
| **Changes** | Immutable once accepted. A new ADR supersedes it, and the old one is marked *Superseded by NNNN* | Newest row first. Reversed rows are marked *Superseded* with a link; never deleted |

## When an ADR is needed

- Choosing or replacing a framework, database, hosting provider, auth method or major library.
- A data model or sync model other parts will depend on.
- Anything where "we'll change it later" means a migration, a rewrite or a forced client upgrade.
- A trade-off the team argued about. Record the losing option and why it lost.

If you can't decide, **spike first**: a time-boxed experiment that measures the options (frames per second, memory, cost, latency), with the numbers cited in the ADR.

## ADR template

Use `templates/adr.md`. Rules:

1. **Number in sequence**, never reuse a number, title it as the decision ("Use Postgres row-level security for tenancy").
2. **Context states the forces**: requirements (with ids), constraints, what's already decided.
3. **At least two real options**, each with pros, cons and a rough cost. "Do nothing" counts when it's real.
4. **The decision is one paragraph** a newcomer can act on.
5. **Consequences cover the good, the bad, and what we now must do**: rules for `AGENTS.md`, tickets, monitoring.
6. **Status**: Proposed → Accepted (with date and who decided) → Superseded / Deprecated.

## Decision Log rules

1. **Log it when it's made**, in the same PR or conversation, not later.
2. **Product decisions name who decided** ("owner decision 2026-10-26") and link the question that was asked.
3. **The "why" is the important column.** Write the constraint or evidence, not "seemed better".
4. **Known risks you accept** (an advisory you can't fix yet, a free-tier limit) are decisions too: log them with what triggers a revisit.
5. **Rules that follow from a decision go into `AGENTS.md`** so agents apply them without reading the log.
