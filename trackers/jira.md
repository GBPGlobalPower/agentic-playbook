
## Tracker: Jira (with Confluence)

- **Access**, in this order of preference. Check the tool's help for the installed version before using a command.
  - The Atlassian remote MCP server (Jira and Confluence), authorised once by the owner with OAuth.
  - The Atlassian CLI (`acli`), signed in by the owner.
  - The REST API, with a token the owner keeps in the environment. Never put the token in the repo, chat or tickets.
- **Ids**: `<KEY>-123`. Put the key in the branch name, the commit subject and the PR title, so the GitHub or Bitbucket integration links them.
- **Workflow**: statuses and transitions differ per project. Read the issue's available transitions before moving it, and map:
  - starting → the "In Progress" equivalent
  - PR open → "In Review" / "Code Review"
  - merged → "Done" (often automatic)

  Record this project's mapping here once you know it: `<In Progress> / <In Review> / <Done>`.
- **Fields**:
  - Acceptance criteria go in the description, or the project's custom field.
  - Components and labels for the area, Epics for milestones, Fix Version for releases.
  - Link owner tasks with "blocks" / "is blocked by".
- **Living docs**: Confluence pages in the project's space (Decision Log, Architecture & Data Model, Developer Runbook, PRD), or `docs/` in the repo if there's no Confluence.
- **Editing docs safely**: fetch the page's current version first, change only the affected section, and save with the next version number. If the version moved on in the meantime, re-read and merge; never overwrite someone else's edit.
- **Formatting**: the API stores descriptions and comments as Atlassian Document Format. The MCP server and the CLI convert markdown; with the raw API, send ADF.
- **Smart commits** (`KEY-123 #comment …`, `#time`) only if the project enables them.
