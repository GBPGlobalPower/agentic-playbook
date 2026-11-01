# Agent collaboration and handoffs

Several agents (and people) work on one change. Work moves between them through written handoffs, never through assumptions.

## Roles

| Role | Who | Writes code? | Typical job |
| -- | -- | -- | -- |
| **Owner** | The human | Decides | Product decisions, ADR acceptance, review and merge |
| **Orchestrator (tech lead)** | The main session (`/deliver-feature`, or you driving it) | Only small changes | Plans, delegates, reads every diff, re-runs the checks, keeps the ticket current |
| **Product owner** | `product-owner` agent, or the `refine-requirements` skill in the main session | No | Makes sense of the request, brings domain knowledge, asks the owner questions round by round until scope and requirements are clear, and writes the requirements brief in ASD-STE100 |
| **Product engineer** | `product-engineer` agent | Yes: the build and the fixes | Builds the plan test first, following `AGENTS.md` and the `implement` checklists; stops on unsettled product questions |
| **Specialists** | Subagents: `architect`, `qa-verifier`, `code-reviewer`, `security-auditor`, `design-reviewer`, `docs-keeper` | No, except `docs-keeper` for docs | One focused job each, returned as a handoff |
| **Other sessions or tools** | A later session, Codex, Cursor, a teammate | Yes | Continue from a handoff on the ticket |

The builder and the verifier are never the same agent. The product engineer builds, and the orchestrator, qa-verifier and the reviewers check, so nobody signs off their own work.

## Rules

1. **One writer at a time** per set of files. Specialists that review are read-only in the shared checkout. Parallel work happens only when the pieces are independent: reviewers in parallel, never two writers on the same files.
2. **Writers work in worktrees.** Agents that change files (`product-engineer`, `docs-keeper`) run in their own git worktree (`isolation: worktree`) and commit there on their own branch. The orchestrator reviews the diff and runs the checks in that worktree, then brings the work into the feature branch. The working checkout and anyone's uncommitted work are never touched.
3. **Try before handing to a human.** A bug or a review finding goes to a person only after an agent has reproduced it in a worktree and tried a fix (`reproduce-in-worktree`), unless trying needs something only a person has. The handoff carries the reproduction and what was tried.
4. **Every handoff is written in one shape** (`templates/handoff.md`): goal, state, what was done, the evidence, findings, decisions, questions for the owner, the next step, what not to do, and what's still running.
5. **A handoff is a claim, not proof.** The receiver re-runs the key check (one test, one screenshot, one query) before building on it, and says when it couldn't.
6. **Evidence travels with the work**: commands with their results, screenshot paths, row counts and timings. "Looks good" isn't evidence.
7. **Humans gate the irreversible**: product questions, accepting an ADR, shipping (`/ship-pr`), merging. Agents stop and ask at these points, and never assume a yes from another agent's message.
8. **Loops are bounded.** Fix, then re-verify, at most twice per finding. Then report what's still failing instead of looping.
9. **Durable handoffs live on the ticket.** Within one session, a specialist's handoff is its final message to the orchestrator. Across sessions, tools or people, post it as a ticket comment (and in the PR description for review). Local scratch files are optional and never the only copy.
10. **No secrets or private content in handoffs.** Refer to where a secret lives, never its value.
11. **Clean up or hand over processes and worktrees.** Whoever starts a server, browser, stack or worktree stops or removes it, or names it under "Still running" with who removes it.

## The delivery pipeline (`/deliver-feature`)

```
owner ──ticket──▶ [product-owner: requirements brief in STE, questions round by round] ──▶ owner agrees
   ▼
orchestrator: start-task (plan, questions) ──▶ owner answers
   ▼
[architect] design or ADR draft (big or structural changes only) ──▶ owner accepts the ADR
   ▼
product-engineer builds (the writer), following implement ──handoff──▶ orchestrator reads the diff, re-runs the checks
   ▼
qa-verifier: verify-feature + capture-screenshots ──handoff──▶
   ▼                                                (in parallel, read-only)
code-reviewer ─┬─ security-auditor (auth, data, files, money) ─┬─ design-reviewer (UI)
   ▼  handoffs with findings
product-engineer fixes confirmed findings ──▶ orchestrator re-checks ──▶ qa-verifier re-checks what changed (max 2 loops)
   ▼
docs-keeper: docs-upkeep ──handoff──▶ orchestrator posts a summary handoff on the ticket
   ▼
STOP: owner runs /ship-pr (or asks for changes) ──▶ owner merges
```

## Across sessions and tools

- **Ending a session mid-task**: run `handoff write`. It posts the note on the ticket, pushes the branch if asked, and lists anything still running.
- **Starting from someone else's work**: run `handoff resume <ticket>`. It reads the latest handoff and the branch, re-runs the key checks, then continues the plan.
- **Another AI tool** (Codex, Cursor, Copilot) uses the same note: point it at the ticket comment and `AGENTS.md`.
