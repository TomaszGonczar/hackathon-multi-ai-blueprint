#!/usr/bin/env bash
#
# bootstrap.sh — creates the solution repo and 5 worktrees for the hackathon.
#
# Idempotent: re-running never destroys existing worktrees or branches.
# No secrets, no network, no accounts required.
#
# Usage:
#   bash seed/bootstrap.sh                  # default repo dir: ~/hackathon-rozwiazanie
#   bash seed/bootstrap.sh /path/to/repo    # custom repo dir
#
# Exit codes: 0 = everything ready, 1 = something is wrong (see messages above).


# Absolute path to the seed directory. Computed BEFORE any cd, because after
# cd-ing into the new repo the relative path "seed/templates" no longer exists.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TPL="$SCRIPT_DIR/templates"

GIT_ID=(-c user.name="hackathon" -c user.email="hackathon@local")

# --- configuration ----------------------------------------------------------

REPO_DIR="${1:-$HOME/hackathon-rozwiazanie}"
PIECES=(w1-kawalek w2-kawalek w3-kawalek w4-kawalek w5-kawalek)
BRANCHES=(w1 w2 w3 w4 w5)
DEPS=(git)

# --- preflight --------------------------------------------------------------

for d in "${DEPS[@]}"; do
  command -v "$d" >/dev/null 2>&1 || { echo "FAIL: '$d' not found in PATH"; exit 1; }
done

if [ -e "$REPO_DIR/.git" ]; then
  echo "== repo already exists: $REPO_DIR (re-using, nothing destroyed) =="
else
  echo "== creating repo: $REPO_DIR =="
  mkdir -p "$REPO_DIR"
  git init -q "$REPO_DIR"
fi

cd "$REPO_DIR"

# Initial commit is needed before worktrees can be created. If the repo is
# brand new and has no commit at all, make a placeholder one.
if ! git rev-parse -q --verify HEAD >/dev/null; then
  echo "== initial commit =="
  git checkout -q -b main 2>/dev/null || true
  echo "# repo rozwiązania" > README.md
  git add README.md
  git "${GIT_ID[@]}" commit -qm "init"
fi

# Make sure we are on main; every piece merges here.
git checkout -q main 2>/dev/null || git checkout -q -b main 2>/dev/null || true

# --- agent context, committed BEFORE the worktrees ---------------------------
# Each worktree is a separate checkout of its own branch. A file that is
# committed to main AFTER the worktrees were created is NOT visible inside
# them. The agent works with the worktree as cwd, so if AGENTS.md and
# KAPSULA.md are not on the branch, it reads neither its rules nor the capsule
# — i.e. the whole "capsule is the only wire" design silently fails.
# Therefore: commit them to main first, then branch the worktrees off it.

echo "== copying agent context to repo root =="
for f in AGENTS.md KAPSULA.md; do
  [ -f "$TPL/$f" ] || { echo "FAIL: template missing: seed/templates/$f"; exit 1; }
  if [ -f "$REPO_DIR/$f" ] && ! git diff --quiet -- "$f" 2>/dev/null; then
    # Never overwrite a capsule the team has already filled in.
    echo "NOTE: $f already exists and was modified — keeping yours"
  else
    cp "$TPL/$f" "$REPO_DIR/$f"
  fi
done

git add AGENTS.md KAPSULA.md 2>/dev/null
git "${GIT_ID[@]}" commit -q -m "seed: agent context (AGENTS.md + KAPSULA.md)" 2>/dev/null \
  || echo "== agent context unchanged =="

# --- worktrees ---------------------------------------------------------------
# One worktree per person. The worktree root IS the piece directory, so
# check.sh lives at the worktree root and is called as ./check.sh.

for i in "${!PIECES[@]}"; do
  name="${PIECES[$i]}"
  branch="${BRANCHES[$i]}"
  target="$HOME/$name"

  # An existing worktree dir contains a .git FILE (not a dir) pointing at the
  # shared object store. This check is symlink-proof: on macOS, git resolves
  # /tmp to /private/tmp, so parsing `git worktree list` and string-matching
  # paths silently never matches.
  if [ -e "$target/.git" ]; then
    echo "== worktree exists: ~/$name (skipping) =="
  elif git show-ref -q --verify "refs/heads/$branch"; then
    # Branch already exists (e.g. pushed by a teammate) — attach it instead of
    # failing, which is what a plain `worktree add -b` does.
    echo "== worktree: ~/$name (existing branch $branch) =="
    git worktree add -q "$target" "$branch"
  else
    echo "== worktree: ~/$name (new branch $branch, from main) =="
    git worktree add -q -b "$branch" "$target"
  fi

  # check.sh per piece — written every run so a broken one is repaired, but a
  # locally modified one is never clobbered.
  if [ -f "$target/check.sh" ] && ! git -C "$target" diff --quiet -- check.sh 2>/dev/null; then
    echo "NOTE: ~/$name/check.sh was modified locally — keeping it"
  else
    cp "$TPL/check.sh.example" "$target/check.sh"
    chmod +x "$target/check.sh"
  fi

  # Marker commit — REQUIRED for the merge-order gate to mean anything.
  # Without it every branch tip is an ancestor of main (they all point at the
  # commit main descends from), so `git merge-base --is-ancestor origin/wN
  # origin/main` reports every piece as "already merged" and a piece with
  # dependencies would merge immediately, out of order.
  # Guarded by the commit message, so re-running (even after a real merge)
  # never adds a second marker.
  if ! git -C "$target" log --format=%s 2>/dev/null | grep -qx "seed: $name marker"; then
    git -C "$target" add -A 2>/dev/null
    git -C "$target" "${GIT_ID[@]}" commit -q --allow-empty -m "seed: $name marker"
  fi
done

# --- verification checklist ---------------------------------------------------

echo
echo "=============================================================="
echo "VERIFICATION — run these now, before the hackathon starts"
echo "=============================================================="
echo
echo "1. Five directories exist:"
for name in "${PIECES[@]}"; do
  echo "   ls ~/$name"
done
echo
echo "2. Agent context is INSIDE each worktree (agent reads it there):"
for name in "${PIECES[@]}"; do
  echo "   ls ~/$name/AGENTS.md ~/$name/KAPSULA.md"
done
echo
echo "3. check.sh in each worktree exits 1 in phase 0 (that is correct):"
echo "   for n in ${PIECES[*]}; do bash ~/\$n/check.sh; echo \"\$n -> \$?\"; done"
echo
echo "4. Merge gate is NOT vacuously true — before any merge it must say NIE:"
echo "   git -C $REPO_DIR merge-base --is-ancestor w2 main && echo 'ZLE: w2 wyglada na zmergowany' \\"
echo "     || echo 'OK: w2 jeszcze nie na main'"
echo
echo "5. Branches (one per person, merge target is main):"
echo "   git -C $REPO_DIR worktree list"
echo
echo "6. Push works (you need write access to the remote):"
echo "   git -C $REPO_DIR remote add origin <url> && git -C $REPO_DIR push origin main --dry-run"
echo
echo "Next: read seed/templates/START-HERE.md — first 30 minutes of Saturday."
echo
echo "OK"
exit 0