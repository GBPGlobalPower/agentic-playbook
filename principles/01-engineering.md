# Engineering principles

How code gets written. These apply to every language and stack.

## 1. Think before coding

**Don't assume. Don't hide confusion. Surface trade-offs.**

- State your assumptions. If you're unsure, ask.
- If there are several readings of the request, present them; don't pick one silently.
- If a simpler approach exists, say so, and push back when it's warranted.
- If something is unclear, stop, name what's confusing, and ask.

## 2. Simplicity first

**The least code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for code used once, and no configurability nobody asked for.
- No error handling for things that can't happen. Do handle what can: network, permissions, bad input, concurrency.
- If 200 lines could be 50, rewrite it. Ask: "Would a senior engineer call this overcomplicated?"

## 3. Surgical changes

**Touch only what you must. Clean up only your own mess.**

- Don't "improve" nearby code, comments or formatting, or refactor what isn't broken.
- Match the existing style, even where you'd do it differently.
- Remove imports, variables and functions your change made unused. Mention other dead code you notice; don't delete it.
- The test: every changed line traces back to the request.

## 4. Goal-driven execution

**Define success. Loop until it's verified.**

- Turn tasks into checks: "fix the bug" means "write a test that reproduces it, then make it pass"; "add validation" means "test the invalid inputs, then make them pass"; "refactor" means "tests pass before and after".
- For multi-step work, state a short plan with a check per step:
  ```
  1. Add the column + policy → verify: policy tests pass
  2. Show it on the screen   → verify: screenshot at the largest text size
  ```
- "Done" means the project's full check suite passes **and** the behaviour was seen working in the real app or service (see `08-testing-qa.md`).

## 5. Code that reads like its surroundings

- **Comments say why, not what**: the constraint, the bug it avoids, the decision behind it, with the ticket id. Match the file's comment density.
- **Names come from the domain** (`invoice`, `outbox`, `workspace`), not from the implementation (`dataManager`, `helper2`).
- **Pure core, thin edges.** Put rules in pure functions with injected dependencies (clock, client, fetch) so they're testable without a device or network. Entry points (routes, handlers, screens) stay thin.
- **One place for each rule.** When a rule must exist in two layers (an SQL function and app code), say so in both, change them together, and add a test that checks they agree.
- **Generated code is never hand-edited** (API and DB types, clients). CI checks it's up to date.
- **Store keys, not display text.** Data holds stable keys (`status: "overdue"`, `plan: "team"`); the UI turns them into words and colours. Then a new language or palette never needs a migration.
- **Version persisted shapes.** JSON in a column or on the device carries a version (`{ v: 1, … }`), and readers fall back to defaults for values they don't know.

## 6. Don't trust memory for fast-moving APIs

Frameworks, SDKs and cloud services change every release. Before using an API:

- Read the docs **for the installed version** (versioned docs, `llms.txt`, the package's own README or changelog).
- Install with the ecosystem's version-aware installer where one exists (`nx add`, `ng add`, or the one the stack file names).
- When the docs and your memory disagree, the docs win, and the project rules note the trap.

## 7. Errors are classified, not guessed

- Decide **permanent vs transient** from codes (SQLSTATE, HTTP status, provider error codes), never from message text.
- Transient failures retry with backoff, in **one** layer. Permanent ones fail fast with a friendly message.
- Every new error code the server can raise has an explicit client mapping.

## 8. Ask before widening scope

Fix what was asked. File what you found along the way as a ticket (bug, follow-up, tech debt) with enough detail to act on, and mention it in your report.
