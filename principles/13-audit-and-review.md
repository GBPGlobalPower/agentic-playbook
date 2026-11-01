# Audit and review

Review catches problems in a change. Audits catch problems that build up across changes. Both produce findings with evidence, and findings become tickets.

## Code review (every PR)

Run the `code-reviewer` agent, or `/code-review` where available, before asking the owner. It checks, in order:

1. **Correctness**: does it do what the ticket says, including the unhappy paths? Are there races, off-by-ones, time-zone or locale bugs, or null and undefined cases?
2. **Security**: authorisation at the data layer, input validation, secrets, logging of personal content (`06-security-privacy.md`).
3. **Data**: migrations are additive and safe for old clients, with policies, grants, tests and generated types.
4. **UX and accessibility**: the four states, copy in the catalogue, targets, labels, large text, reduce motion.
5. **Simplicity and scope**: no speculative code, every changed line traces to the request, nothing orphaned.
6. **Tests and evidence**: a failing-first test for bugs, and real-app verification with results in the PR.
7. **Docs**: `AGENTS.md`, the Decision Log, the Architecture doc and the runbook are updated where needed.

A finding is reported only with a **concrete failure scenario** (these inputs, in this state, give this wrong result). Rank findings by severity. Style preferences aren't findings.

## Audits (scheduled, or before a release)

| Audit | Skill or agent | When | Output |
| -- | -- | -- | -- |
| Security | `security-audit`, `security-auditor` | Before each release, and after auth or data-model changes | A report doc plus tickets (severity, exploit scenario, fix) |
| Threat model | `threat-model` | New feature touching auth, files, money, sharing or personal data | Threat table plus mitigation tickets |
| Dependencies | `vet-dependency` (per package), audit in CI | Weekly, and per new package | Upgrades, or Decision Log entries for accepted advisories |
| Accessibility | `a11y-audit`, `design-reviewer` | New screens, before each release | Findings per WCAG criterion plus tickets |
| Architecture | `architecture-review`, `architect` | Before big features, and quarterly | Drift from ADRs, new ADRs needed, debt tickets |
| Offline and sync | `verify-feature` with the offline scenario | Before each release | Pass/fail per scenario, with latencies |
| Layout QA | `verify-feature` with the layout matrix | Before each release | Screenshots across the matrix |
| Performance | `release-readiness` | Before each release, on real hardware | Numbers against the budgets |
| Release readiness | `release-readiness` | Before every production release | The completed checklist |

## How findings are handled

1. **Verify before reporting.** Reproduce it, or show the code path. Mark anything unverified as *plausible*, not *confirmed*.
2. **One ticket per finding**, with severity, scenario, evidence and the suggested fix, linked to the audit doc.
3. **Fix in priority order.** Accepted risks go to the Decision Log with a revisit trigger.
4. **Audits are dated documents** in the tracker, so the next audit can compare.
