# Documentation and knowledge

Docs are how the next session (yours, a teammate's, an agent's) starts with context instead of guesses. Keep few of them, and keep them current.

## The set

| Doc | Holds | Lives | Updated |
| -- | -- | -- | -- |
| **`AGENTS.md`** (`CLAUDE.md` imports it) | The rules for working in this repo: stack, commands, layout, conventions, and one bullet per domain rule with where its code lives | Repo root | In the PR that adds or changes the rule |
| **`README.md`** | What it is and how to run it locally | Repo root | When setup changes |
| **ADRs** | Hard-to-reverse decisions (`03-adrs-and-decisions.md`) | `docs/adr/` | When a decision is made or superseded |
| **Decision Log** | Every other decision, with its why | Tracker doc (or `docs/decisions.md`) | When the decision is made |
| **Architecture & Data Model** | How it fits together: stack table, schema, flows as text diagrams, what's built vs planned | Tracker doc | Each PR that changes a flow or table |
| **Developer Runbook** | Environments, the local loop, how to test hard things, and a **Traps already hit** table (trap → fix) | Tracker doc | Whenever something cost more than 10 minutes to figure out |
| **PRD** | What customers get: requirements with ids (FR-XX-01, NFR-05) | Tracker doc | When scope changes, with the owner |
| **Tickets** | One unit of work: acceptance criteria, then a closing comment saying what was done, how it was verified, and the PR | Tracker | Throughout |

## Rules

1. **Docs change in the same PR as the code** (the `docs-upkeep` skill runs at the end of `ship-pr`). A PR that adds a table, flow or rule without the doc update isn't done.
2. **`AGENTS.md` stays operational**: rules an agent must follow, and where things live. Keep the history and the reasons in the Decision Log; keep it short enough to read every session (split very long sections into linked docs or path-scoped rules).
3. **Write traps down the first time.** A runbook row costs one minute; rediscovering the trap costs an hour.
4. **Link, don't duplicate.** Docs point to code paths, ticket ids and PRs. Each fact has one home.
5. **Plain language**: short sentences, active voice, concrete names. Write for someone tired at 11 pm.
6. **Ticket hygiene**: move status as work moves (in progress → in review → done, in the tracker's own names), link the PR, and close with evidence. Things found along the way become new tickets, not silent fixes.
7. **Owner tasks** get step-by-step tickets that someone non-technical can follow.

## Any tracker

The playbook doesn't assume a tracker. Each project's `AGENTS.md` has a **Tracker** section that every skill reads. It's installed from `trackers/` with `--tracker linear | jira | github`, or written by hand for another one. It records:

- **Access**: how agents reach the tracker (MCP server, CLI, API with an owner-held token) without ever seeing a secret.
- **Ids and linking**: the id format, and how branches, commits and PRs link to tickets and close them.
- **The status mapping**: the tracker's own names for in progress, in review and done.
- **Where the living docs live**: tracker documents, Confluence pages, `docs/` in the repo, Notion.
- **Editing notes**: how to edit those docs safely. For example, Linear rewrites ticket ids into links, so patch anchors must avoid ids; Confluence needs the page's next version number.

To support a new tracker, copy `trackers/github.md`, fill in the same headings, and pass `--tracker <name>`.
