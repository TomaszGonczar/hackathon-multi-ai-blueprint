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
  git -c user.name="hackathon" -c user.email="hackathon@local" commit -qm "init"
fi

# Make sure we are on main; every piece merges here.
git checkout -q main 2>/dev/null || git checkout -q -b main 2>/dev/null || true

# --- copy agent context to repo root ----------------------------------------
# AGENTS.md and KAPSULA.md are loaded from the repo root by the coding agent,
# not from the blueprint repo.




echo "== copying agent context to repo root =="
for f in AGENTS.md KAPSULA.md; do
  [ -f "$TPL/$f" ] || { echo "FAIL: template missing: seed/templates/$f"; exit 1; }
  if [ -f "$REPO_DIR/$f" ]; then
    # Never overwrite a capsule that the team has already filled in.
    if ! git -C "$REPO_DIR" diff --quiet -- "$f" 2>/dev/null; then
      echo "NOTE: $f already exists and was modified — keeping yours"
    else
      cp "$TPL/$f" "$REPO_DIR/$f"
    fi
  else
    cp "$TPL/$f" "$REPO_DIR/$f"
  fi
done

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
    echo "== worktree: ~/$name (new branch $branch) =="
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
done

# --- commit the scaffolding ---------------------------------------------------

git add -A
git -c user.name="hackathon" -c user.email="hackathon@local" \
  commit -q -m "seed: agent context + 5 worktrees" 2>/dev/null \
  || echo "== nothing new to commit =="

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
echo "2. check.sh is present and runnable in each:"
echo "   for n in ${PIECES[*]}; do bash ~/\$n/check.sh; echo \"\$n -> \$?\"; done"
echo
echo "3. Branches (one per person, merge target is main):"
echo "   git -C $REPO_DIR worktree list"
echo
echo "4. AGENTS.md and KAPSULA.md are at the repo root (agent loads them):"
echo "   ls $REPO_DIR/AGENTS.md $REPO_DIR/KAPSULA.md"
echo
echo "5. Push works (you need write access to the remote):"
echo "   git -C $REPO_DIR push origin main --dry-run"
echo
echo "Next: read seed/templates/START-HERE.md — first 30 minutes of Saturday."
echo
echo "OK"
exit 0
