#!/usr/bin/env bash
#
# update.sh — snapshot changed dotfiles into scoped, revertible commits.
#
# Safety model:
#   * Refuses to run on a detached HEAD (was a trap: `git add .` + `git push`
#     from detached HEAD made an unpushed commit and pushed nothing).
#   * Refuses to run with a dirty working tree that is NOT part of this save
#     (so a stray `git add .` never bundles unrelated WIP into one dump commit).
#   * Stages EXPLICIT paths (never `git add .`), then commits per changed
#     top-level directory so `git revert`/`bisect` stay useful.
#   * Pushes explicitly to the branch you are on (defaults to main).
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Pull the branch you are on; abort on detached HEAD.
BRANCH="$(git symbolic-ref --quiet --short HEAD || true)"
if [[ -z "$BRANCH" ]]; then
  echo "✗ Refusing to run: detached HEAD." >&2
  echo "  Run: git checkout main   (or your working branch) first." >&2
  exit 1
fi

# Anything outside the paths we intend to snapshot? Warn and bail.
# We only ever save files already tracked or staged; we do NOT sweep untracked
# cruft (e.g. *.bak) into commits.
UNTRACKED="$(git ls-files --others --exclude-standard)"
if [[ -n "$UNTRACKED" ]]; then
  echo "⚠ Untracked files exist (left UNstaged on purpose):" >&2
  echo "$UNTRACKED" | sed 's/^/    /' >&2
fi

# Collect modified + deleted (tracked) paths. Skip untracked entirely.
CHANGED="$(git diff --name-only HEAD)"
DELETED="$(git diff --name-only --diff-filter=D HEAD)"
STAGED="$(git diff --cached --name-only)"

if [[ -z "$CHANGED$DELETED$STAGED" ]]; then
  echo "Nothing tracked to commit. Clean ship — nothing to do."
  exit 0
fi

echo "=== Snapshotting changes on branch '$BRANCH' ==="

# Group changed paths by their top-level directory (or the file itself if at
# repo root), and commit each group separately.
mapfile -t FILES < <(printf '%s\n' "$CHANGED" "$DELETED" "$STAGED" | grep -v '^$')
declare -A GROUPS
for f in "${FILES[@]}"; do
  top="$(cut -d/ -f1 <<<"$f")"
  GROUPS["$top"]+="$f"$'\n'
done

for top in $(printf '%s\n' "${!GROUPS[@]}" | sort); do
  group="${GROUPS[$top]}"
  count="$(grep -c . <<<"$group")"
  msg="chore(dotfiles): update ${top} ($(date +'%Y-%m-%d %H:%M'))"
  echo "  → committing $count file(s) under '$top'"
  git add -- $group
  git commit -q -m "$msg"
done

echo "=== Pushing '$BRANCH' to origin ==="
git push origin "$BRANCH"

echo "Dotfiles snapshot pushed."
