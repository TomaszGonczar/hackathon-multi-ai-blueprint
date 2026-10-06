#!/usr/bin/env bash
#
# verify.sh - runs the ten checks from seed/VERIFY.md and exits 0 only if all
# of them pass. Run it right after bootstrap.sh, before the event starts.
#
# Non-destructive: check 9 simulates a merge in a throwaway clone, checks 6
# and 7 use temporary files that are removed on exit, and checks 1 and 10
# re-run bootstrap.sh, which is idempotent. They run last, so the re-run
# cannot repair anything the earlier checks are meant to catch.
#
# Usage:
#   bash seed/verify.sh                  # default repo dir: ~/hackathon-solution
#   bash seed/verify.sh /path/to/repo    # same argument as bootstrap.sh
#
# After real merges to main, check 8 fails for the pieces that have landed -
# it only means something before the first merge.
#
# Exit codes: 0 = all ten checks passed, 1 = at least one failed.

set -u   # no -e: every check runs and reports, failures are counted

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="${1:-$HOME/hackathon-solution}"
PIECES=(w1-piece w2-piece w3-piece w4-piece w5-piece)   # must match bootstrap.sh
BRANCHES=(w1 w2 w3 w4 w5)
GIT_ID=(-c user.name="verify" -c user.email="verify@local")

W1="$HOME/${PIECES[0]}"
PHASE1_COPY="$W1/.verify-phase1.sh"
SECRET_FILE="$W1/.verify-secret.txt"
TMP="$(mktemp -d)"

# shellcheck disable=SC2329  # invoked by the EXIT trap below
cleanup() {
  git -C "$W1" reset -q -- "$(basename "$SECRET_FILE")" 2>/dev/null
  rm -f "$PHASE1_COPY" "$SECRET_FILE"
  rm -rf "$TMP"
}
trap cleanup EXIT

failed=0
report() {  # report <number> <description> <exit status of the check>
  if [ "$3" -eq 0 ]; then
    printf 'PASS  %2s  %s\n' "$1" "$2"
  else
    printf 'FAIL  %2s  %s\n' "$1" "$2"
    failed=$((failed + 1))
  fi
}

# check.sh in w1 with the phase gate flipped to 1, written next to the real one
# so that its `cd "$(dirname "$0")"` lands in the worktree.
make_phase1_copy() {
  sed 's/^PHASE=0$/PHASE=1/' "$W1/check.sh" > "$PHASE1_COPY" || return 1
  grep -qx 'PHASE=1' "$PHASE1_COPY"
}

# --- the checks ----------------------------------------------------------------

five_directories() {
  local n
  for n in "${PIECES[@]}"; do
    [ -d "$HOME/$n" ] || return 1
  done
}

context_in_every_worktree() {
  local n
  for n in "${PIECES[@]}"; do
    [ -f "$HOME/$n/AGENTS.md" ] || return 1
    [ -f "$HOME/$n/CAPSULE.md" ] || return 1
  done
}

check_sh_executable() {
  local n
  for n in "${PIECES[@]}"; do
    [ -x "$HOME/$n/check.sh" ] || return 1
  done
}

phase0_exits_1() {
  local n out rc
  for n in "${PIECES[@]}"; do
    out="$(bash "$HOME/$n/check.sh" 2>&1)"; rc=$?
    [ "$rc" -eq 1 ] || return 1
    [[ "$out" == *"phase 0"* ]] || return 1
  done
}

phase1_exits_0() {
  local rc
  make_phase1_copy || return 1
  bash "$PHASE1_COPY" >/dev/null 2>&1; rc=$?
  rm -f "$PHASE1_COPY"
  [ "$rc" -eq 0 ]
}

# Phase 0 exits 1 anyway, so the exit code alone cannot show that the secret
# was caught - the message can. Checked in both phases.
secret_caught_in_both_phases() {
  local out0="" rc0=0 out1="" rc1=0 staged=0
  echo "API_KEY=supersecret" > "$SECRET_FILE" \
    && git -C "$W1" add -- "$(basename "$SECRET_FILE")" && staged=1
  if [ "$staged" -eq 1 ] && make_phase1_copy; then
    out0="$(bash "$W1/check.sh" 2>&1)"; rc0=$?
    out1="$(bash "$PHASE1_COPY" 2>&1)"; rc1=$?
  fi
  git -C "$W1" reset -q -- "$(basename "$SECRET_FILE")" 2>/dev/null
  rm -f "$SECRET_FILE" "$PHASE1_COPY"
  [ "$staged" -eq 1 ] || return 1
  [ "$rc0" -eq 1 ] || return 1
  [ "$rc1" -eq 1 ] || return 1
  [[ "$out0" == *"FAIL: secret"* ]] || return 1
  [[ "$out1" == *"FAIL: secret"* ]]
}

# Before any merge, no wN may look merged. `merge-base --is-ancestor` exits 1
# for "not an ancestor"; 0 means the gate is vacuous, anything else is an error.
gate_not_vacuous() {
  local b rc
  for b in "${BRANCHES[@]}"; do
    git -C "$REPO_DIR" rev-parse -q --verify "refs/heads/$b" >/dev/null || return 1
    git -C "$REPO_DIR" merge-base --is-ancestor "$b" main; rc=$?
    [ "$rc" -eq 1 ] || return 1
  done
}

# Merge w1 in a throwaway clone: w1 must become an ancestor, w2 and w3 must not.
gate_unlocks_after_merge() {
  local clone="$TMP/clone" rc
  git clone -q --branch main "$REPO_DIR" "$clone" 2>/dev/null || return 1
  git -C "$clone" "${GIT_ID[@]}" merge -q --no-ff origin/w1 -m "verify: simulated merge of w1" \
    >/dev/null 2>&1 || return 1
  git -C "$clone" merge-base --is-ancestor origin/w1 HEAD || return 1
  git -C "$clone" merge-base --is-ancestor origin/w2 HEAD; rc=$?
  [ "$rc" -eq 1 ] || return 1
  git -C "$clone" merge-base --is-ancestor origin/w3 HEAD; rc=$?
  [ "$rc" -eq 1 ]
}

bootstrap_reruns_clean() {
  bash "$SCRIPT_DIR/bootstrap.sh" "$REPO_DIR" > "$TMP/rerun.log" 2>&1 || return 1
  ! grep -q '^FAIL:' "$TMP/rerun.log"
}

rerun_is_idempotent() {
  local i count
  [ -f "$TMP/rerun.log" ] || return 1
  count="$(grep -c 'worktree exists' "$TMP/rerun.log")"
  [ "$count" -eq "${#PIECES[@]}" ] || return 1
  for i in "${!PIECES[@]}"; do
    count="$(git -C "$REPO_DIR" log --format=%s "${BRANCHES[$i]}" | grep -cx "seed: ${PIECES[$i]} marker")"
    [ "$count" -eq 1 ] || return 1
  done
}

# --- run -------------------------------------------------------------------------

echo "== verifying the seed: $REPO_DIR + ~/${PIECES[0]} ... ~/${PIECES[4]} =="
echo "   (checks 1 and 10 re-run bootstrap.sh, so they run last)"
echo

five_directories;              report 2  "five worktree directories exist" $?
context_in_every_worktree;     report 3  "AGENTS.md + CAPSULE.md inside every worktree" $?
check_sh_executable;           report 4  "check.sh exists and is executable in every worktree" $?
phase0_exits_1;                report 5  "phase 0: check.sh exits 1 and says why" $?
phase1_exits_0;                report 6  "phase 1: check.sh exits 0" $?
secret_caught_in_both_phases;  report 7  "a staged secret is caught in phase 0 and phase 1" $?
gate_not_vacuous;              report 8  "merge gate: no piece looks merged before any merge" $?
gate_unlocks_after_merge;      report 9  "merge gate unlocks w1 after its merge, w2/w3 still wait" $?
bootstrap_reruns_clean;        report 1  "bootstrap.sh re-runs and exits 0" $?
rerun_is_idempotent;           report 10 "re-run is idempotent: worktrees skipped, one marker each" $?

echo
if [ "$failed" -eq 0 ]; then
  echo "OK - all 10 checks passed"
  exit 0
fi
echo "FAIL - $failed of 10 checks failed (what each one means: seed/VERIFY.md)"
exit 1
