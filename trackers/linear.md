
## Tracker: Linear

- **Access**: the Linear MCP server (connected once by the owner). Never paste an API key into chat, tickets or the repo.
- **Ids**: `<TEAM>-123`. Use the issue's own git branch name. A PR that names the id in its branch or title links itself; `Fixes <TEAM>-123` in the description closes it on merge.
- **Statuses**: starting → **In Progress**; PR open → **In Review**; merged → **Done** (automatic if the workflow is set up). Owner-only tasks carry the `Owner` label.
- **Living docs**: Linear documents in the project (Decision Log, Architecture & Data Model, Developer Runbook, PRD).
- **Editing docs safely**: patch the section that changed instead of resending the document. Anchor patches on headings or table headers **without ticket ids**: Linear rewrites ids into links, so an anchor containing one never matches.
- **Comments**: markdown. Mention someone with `@name` only when you mean to notify them.
