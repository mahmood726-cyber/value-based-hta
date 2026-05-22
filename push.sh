#!/usr/bin/env bash
# Quick push for publication-managed files.
# Usage: bash push.sh "commit message"
#
# Pushes to the currently checked-out branch. Override the binary via
# E156_GIT_BIN if needed (defaults to `git`).

set -euo pipefail

MSG="${1:-Update E156 submission}"
GIT_NAME="${E156_GIT_NAME:-Mahmood Ahmad}"
GIT_EMAIL="${E156_GIT_EMAIL:-mahmood726-cyber@users.noreply.github.com}"
GIT_BIN="${E156_GIT_BIN:-git}"

if ! command -v "$GIT_BIN" >/dev/null 2>&1; then
  echo "git binary '$GIT_BIN' not found on PATH." >&2
  exit 1
fi

if ! "$GIT_BIN" diff --cached --quiet --exit-code; then
  echo "There are already staged changes in this repo. Review and push manually."
  exit 1
fi

paths=(
  "e156-submission"
  "push.sh"
  "LICENSE"
  "LICENSE.md"
  "LICENSE.txt"
  "CITATION.cff"
)

for path in "${paths[@]}"; do
  if [ -e "$path" ] || "$GIT_BIN" ls-files -- "$path" | grep -q .; then
    "$GIT_BIN" add -A -- "$path"
  fi
done

if ! "$GIT_BIN" diff --cached --quiet --exit-code; then
  "$GIT_BIN" -c user.name="$GIT_NAME" -c user.email="$GIT_EMAIL" \
    commit --no-verify --no-gpg-sign -m "$MSG"
else
  echo "No publication-managed changes to commit."
fi

branch="$("$GIT_BIN" rev-parse --abbrev-ref HEAD)"
if [ -z "$branch" ] || [ "$branch" = "HEAD" ]; then
  echo "Could not determine current branch (detached HEAD?). Aborting push." >&2
  exit 1
fi

"$GIT_BIN" push -u origin "$branch"

echo ""
echo "Pushed branch '$branch' to GitHub. View at:"
echo "  https://github.com/mahmood726-cyber/value-based-hta"
echo "  https://mahmood726-cyber.github.io/value-based-hta/"
echo "  https://mahmood726-cyber.github.io/value-based-hta/e156-submission/"
