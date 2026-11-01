---
name: handoff
description: Hand work to the next agent, session, tool or person, or pick up work someone else handed over. Write mode records goal, state, evidence, findings, decisions, the next step and still-running processes on the ticket. Resume mode reads the latest handoff, re-verifies its key claims, then continues. Use when stopping mid-task, switching sessions or tools, finishing a specialist step, or starting from another agent's work.
argument-hint: "[write | resume] [ticket id]"
---

# Handoff

> Playbook files named here: when the project has its own copy at `.playbook/local/<same path>`, use that copy instead.

Request: $ARGUMENTS

Rules: `${CLAUDE_PLUGIN_ROOT}/principles/15-agent-collaboration.md`. Shape: `${CLAUDE_PLUGIN_ROOT}/templates/handoff.md`.

## write

1. **Gather the facts**, not memories:
   - `git status` and `git log` for the branch and commits; push if the owner wants the next session to start from it.
   - The commands you ran and their results; screenshot paths; data checks.
   - Open findings with their scenarios.
   - Decisions made and who made them; questions still open for the owner.
   - Processes still running (dev server, browser, local stack, listeners).
2. **Fill the template completely.**
   - **Next** names exactly who does what, with the inputs they need.
   - **Don't** lists the traps, such as a migration already applied or a setting changed.
   - Mark anything unverified as such.
3. **Deliver it**:
   - **To a subagent's caller**: as your final message.
   - **To a later session, another tool or a person**: as a comment on the ticket (via the tracker in `AGENTS.md` → Tracker), and in the PR description if a PR is open.
4. **Stop the processes you started**, unless the handoff names them under "Still running" with an owner.
5. **Before handing a bug or a review finding to a person** (human in the loop), try it first in a worktree (`reproduce-in-worktree`): the handoff carries the reproduction, what you tried, the result, the worktree path and branch, and your recommendation. Hand off without trying only when trying needs something you don't have, and say what.

## resume

1. **Read** the latest handoff on the ticket, plus the PR, the branch (`git log`, `git diff <base>...`) and `AGENTS.md`.
2. **Re-verify** before building on it: re-run the key check behind each "done" (one test command, one screenshot, one query). If something doesn't hold, say so and fix the plan.
3. **Check "Don't" and "Still running"** first: stop or reuse those processes deliberately.
4. **Continue the "Next" step.** Ask the owner any open questions before work that depends on them.
5. When you stop, write a new handoff. Never edit the old one: the history matters.
