# Developer Runbook

How to work on <project> day to day, and the traps already hit. `README.md` and `AGENTS.md` are the source of truth for commands and rules; this page adds context and history. Decisions are in the **Decision Log**.

## Environments

| What | Where |
| -- | -- |
| Repo | <org/repo>. Branches are named from tickets and auto-delete after merge. |
| dev | <URL / project ref>. Deploys on merge. |
| prod | <…>. Manual pipeline run. |
| CI secrets | <names only, never values>. Set with `gh secret set NAME`. |

## CI

- **<job>**: <what it runs>

## Local loop

1. <start the backend>
2. <start the app>
3. <sign in: where codes and emails land locally>
4. Before calling work done: <commands>

### Testing multi-user flows

<How to script the second user.>

## Testing on real devices

<Build profiles, how to install, which accounts.>

## Traps already hit (and the fix)

| Trap | Fix |
| -- | -- |
| **<What went wrong, in one line, with the symptom someone would search for>** | <The fix or workaround, with commands> |

## Where things live

- `<path>`: <what>
