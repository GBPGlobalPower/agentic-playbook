
## Tracker: GitHub Issues and Projects

- **Access**: the `gh` CLI (signed in by the owner with `gh auth login`) or the GitHub MCP server. Never paste tokens.
- **Ids**: `#123`, or `owner/repo#123` from another repository. Branch `<user>/123-short-title`. `Closes #123` in the PR body closes the issue on merge.
- **Statuses**:
  - With a GitHub Project, set its Status field (Todo → In Progress → In Review → Done) with `gh project item-edit`. Find the field and option ids with `gh project field-list <number> --owner <owner>`.
  - Without a Project, use labels (`status:in-progress`, `status:in-review`) and close on merge.
- **Labels** for type and area, **milestones** for usable slices, and the `owner` label for owner-only tasks.
- **Living docs**: `docs/` in the repo (`decisions.md`, `architecture.md`, `runbook.md`, `prd.md`), changed in the same PR as the code. Use the wiki only if the team prefers it.
- **Comments**: `gh issue comment <n> --body-file <file>` (a file avoids shell-quoting accidents).
