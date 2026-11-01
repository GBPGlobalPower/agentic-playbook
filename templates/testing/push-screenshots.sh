#!/usr/bin/env bash
# Publish PR screenshots to a `screenshots` branch (never the default branch) and print the markdown to
# embed them. Run from the repo root:  push-screenshots.sh <PR number> file.png[=name.png] …
# Only the named files change, so a re-run for the same PR keeps its other images. Images are scaled
# to 540 px wide when a resizer is available (sips on macOS, or ImageMagick).
set -euo pipefail
[ $# -ge 2 ] || { echo "usage: $0 <PR number> file.png[=name.png] …" >&2; exit 1; }
PR="$1"; shift
SCR="$(mktemp -d)"; IDX="$(mktemp)"; rm -f "$IDX"
REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"

if git ls-remote --exit-code -q origin screenshots >/dev/null 2>&1; then
  git fetch -q origin screenshots
  PARENT="$(git rev-parse origin/screenshots)"
  GIT_INDEX_FILE="$IDX" git read-tree "$PARENT"
  PARENT_ARGS=(-p "$PARENT")
else
  PARENT_ARGS=()   # first run: the branch starts with no history
fi

resize() {
  if command -v sips >/dev/null 2>&1; then sips -s format png --resampleWidth 540 "$1" --out "$2" >/dev/null
  elif command -v magick >/dev/null 2>&1; then magick "$1" -resize 540x "$2"
  elif command -v convert >/dev/null 2>&1; then convert "$1" -resize 540x "$2"
  else cp "$1" "$2"; fi
}

mkdir -p "$SCR/pr-$PR"
names=()
for spec in "$@"; do
  src="${spec%%=*}"; name="${spec#*=}"; [ "$name" = "$spec" ] && name="$(basename "$src")"
  resize "$src" "$SCR/pr-$PR/$name"
  names+=("pr-$PR/$name")
done
GIT_INDEX_FILE="$IDX" git --work-tree="$SCR" add -- "${names[@]}"
TREE="$(GIT_INDEX_FILE="$IDX" git write-tree)"
COMMIT="$(git commit-tree "$TREE" "${PARENT_ARGS[@]}" -m "Screenshots for PR #$PR")"
git push -q origin "${COMMIT}:refs/heads/screenshots"

echo "Pushed. Embed with:"
for n in "${names[@]}"; do echo "![$(basename "$n" .png)](https://github.com/$REPO/blob/screenshots/$n?raw=true)"; done
