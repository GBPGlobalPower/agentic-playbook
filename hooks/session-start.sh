#!/usr/bin/env bash
# Playbook plugin, SessionStart. Prints only in projects that use the playbook: where the plugin's files
# are (AGENTS.md can't know that path), and which files the project overrides in .playbook/local/, so
# skills read the project's copy instead. Prints nothing elsewhere.
project="${CLAUDE_PROJECT_DIR:-$PWD}"
root="${CLAUDE_PLUGIN_ROOT:-}"
local_dir="$project/.playbook/local"

if [ -n "$root" ] && grep -qi 'playbook' "$project/AGENTS.md" 2>/dev/null; then
  echo "The playbook plugin's files (principles/, templates/, stacks/, trackers/) are in $root."
fi

[ -d "$local_dir" ] || exit 0
files=$(cd "$local_dir" && find . -type f ! -name '.*' | sed 's#^\./##' | sort)
[ -n "$files" ] || exit 0
echo "Playbook overrides: this project changes these playbook files. Wherever a skill, agent or AGENTS.md names one of them in the playbook, read .playbook/local/<same path> instead:"
echo "$files" | sed 's#^#- #'
