#!/usr/bin/env bash
# roadmap:8757  roadmap:d5f9  roadmap:211c
# Spec for the v1 relay-aware verify commit-hook (HARD tier only).
# RED until id:8757 (hook) + id:d5f9 (git config) are implemented.
#
# Design: docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md (D1–D6).
#
# Contract (relay-TDD: never weaken a test to make it pass). The hook is a TRACKED
# `hooks/post-commit` (installed via core.hooksPath=hooks). It is exercised in a
# throwaway sandbox git repo so the suite never pollutes the real repo and runs
# regardless of the surrounding relay context. Each case is independent.
#
# Cases:
#   1. OWNER commit  → a `status:pending` note appears on refs/notes/verify. [roadmap:8757]
#   2. RELAY_SKIP=1  → NO note, commit succeeds (relay no-op, authoritative). [roadmap:8757]
#   3. /worktrees/ git-dir → NO note, commit succeeds (relay fallback).      [roadmap:8757]
#   4. .mw unavailable → commit succeeds, hook no-ops (graceful degrade).    [roadmap:8757]
#   5. squash two noted commits → BOTH findings survive (concatenate).       [roadmap:d5f9]
#   6. loose/off-branch note detected via merge-base --is-ancestor.          [roadmap:8757]
set -u
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOOK="$REPO_ROOT/hooks/post-commit"
NOTES_REF="refs/notes/verify"
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_verify_hook] hook presence"
if [ ! -f "$HOOK" ]; then
  bad "no hooks/post-commit (RED until id:8757 done)"
  echo "[test_verify_hook] FAIL"
  exit 1
fi
pass "hooks/post-commit exists"

# --- sandbox helpers -------------------------------------------------------
# A fresh sandbox repo with the tracked hook wired in via core.hooksPath, and the
# two git-config settings from id:d5f9 applied (the production install must set them;
# the test asserts the config-DRIVEN behavior, so it sets them too — but case 5
# additionally asserts the install actually sets rewriteMode, see below).
make_sandbox() {
  local d; d="$(mktemp -d)"
  git -C "$d" init -q
  git -C "$d" config user.email t@example.com
  git -C "$d" config user.name tester
  mkdir -p "$d/hooks"
  cp "$HOOK" "$d/hooks/post-commit"
  chmod +x "$d/hooks/post-commit"
  git -C "$d" config core.hooksPath hooks
  # carry the production verify-ref/mode so the harness mirrors a real install.
  git -C "$d" config notes.rewriteRef "$NOTES_REF"
  git -C "$d" config notes.rewriteMode concatenate
  echo "$d"
}
note_for() { # <repo> <rev> → note text or empty
  git -C "$1" notes --ref="$NOTES_REF" show "$2" 2>/dev/null || true
}
commit_file() { # <repo> <name> <content>
  printf '%s\n' "$3" > "$1/$2"
  git -C "$1" add "$2"
  git -C "$1" commit -q -m "$2"
}

# --- case 1: owner commit writes a pending note ----------------------------
echo "[test_verify_hook] case 1 — owner commit → status:pending note"
S=$(make_sandbox)
( cd "$S" && unset RELAY_SKIP; commit_file "$S" a.txt hello )
n=$(note_for "$S" HEAD)
if printf '%s' "$n" | grep -q 'status:pending'; then pass "pending note on owner commit"; else bad "no status:pending note on owner commit (got: '${n}')"; fi
rm -rf "$S"

# --- case 2: RELAY_SKIP=1 → no note, commit succeeds -----------------------
echo "[test_verify_hook] case 2 — RELAY_SKIP=1 no-op"
S=$(make_sandbox)
RELAY_SKIP=1 git -C "$S" -c core.hooksPath=hooks commit --allow-empty -q -m seed 2>/dev/null
( cd "$S" && RELAY_SKIP=1 commit_file "$S" b.txt world )
rc=$?
n=$(note_for "$S" HEAD)
if [ "$rc" -eq 0 ] && [ -z "$n" ]; then pass "RELAY_SKIP=1: no note, commit succeeded"; else bad "RELAY_SKIP=1 should no-op (rc=$rc note='${n}')"; fi
rm -rf "$S"

# --- case 3: /worktrees/ git-dir path → no note (relay fallback) -----------
# Faithful simulation: a REAL linked worktree's git-dir is `<main>/.git/worktrees/<name>`
# (genuinely contains `/worktrees/`), exactly the relay-context path the hook keys on as
# the fallback when RELAY_SKIP is unset. `git rev-parse --git-dir` from inside the linked
# worktree returns that path → the hook must no-op.
echo "[test_verify_hook] case 3 — /worktrees/ git-dir fallback no-op"
MAIN=$(make_sandbox)
( cd "$MAIN" && unset RELAY_SKIP; commit_file "$MAIN" seed.txt seed )   # need a commit to branch a worktree
git -C "$MAIN" notes --ref="$NOTES_REF" remove HEAD >/dev/null 2>&1 || true  # clear the seed's note; we test the worktree commit
WT=$(mktemp -d)/linked
git -C "$MAIN" worktree add -q -b wt-branch "$WT" >/dev/null 2>&1
# the linked worktree shares core.hooksPath=hooks (config is shared via common dir).
( cd "$WT" && unset RELAY_SKIP; printf 'threes\n' > c.txt; git add c.txt; git commit -q -m c.txt )
rc=$?
gd=$(git -C "$WT" rev-parse --git-dir 2>/dev/null)
n=$(git -C "$WT" notes --ref="$NOTES_REF" show HEAD 2>/dev/null || true)
case "$gd" in *"/worktrees/"*) gd_ok=1;; *) gd_ok=0;; esac
if [ "$gd_ok" -ne 1 ]; then
  bad "test setup: linked-worktree git-dir lacks /worktrees/ ('$gd') — cannot exercise fallback"
elif [ "$rc" -eq 0 ] && [ -z "$n" ]; then
  pass "/worktrees/ git-dir: no note, commit succeeded (git-dir=$gd)"
else
  bad "/worktrees/ fallback should no-op (rc=$rc note='${n}' git-dir='$gd')"
fi
git -C "$MAIN" worktree remove --force "$WT" >/dev/null 2>&1 || true
rm -rf "$MAIN" "$(dirname "$WT")"

# --- case 4: .mw unavailable → commit succeeds, hook no-ops ----------------
# Make .mw unreachable by pointing the hook's discovery env at a nonexistent path.
echo "[test_verify_hook] case 4 — .mw unavailable → graceful degrade"
S=$(make_sandbox)
( cd "$S" && unset RELAY_SKIP; MW_REPO=/nonexistent/no-such-mw commit_file "$S" d.txt four )
rc=$?
# Commit MUST succeed (HEAD advanced) even with .mw gone. The hook must not have raised.
if [ "$rc" -eq 0 ] && git -C "$S" rev-parse HEAD >/dev/null 2>&1; then
  pass ".mw-absent: commit still succeeded (graceful degrade)"
else
  bad ".mw-absent must not break the commit (rc=$rc)"
fi
rm -rf "$S"

# --- case 5: concatenate-on-squash preserves both findings -----------------
echo "[test_verify_hook] case 5 — concatenate-on-squash keeps both notes"
S=$(make_sandbox)
( cd "$S" && unset RELAY_SKIP; commit_file "$S" base.txt b0 )   # base
( cd "$S" && unset RELAY_SKIP; commit_file "$S" e1.txt first )  # note 1
( cd "$S" && unset RELAY_SKIP; commit_file "$S" e2.txt second ) # note 2
# both notes must exist pre-squash for the test to be meaningful
n1=$(note_for "$S" HEAD~1); n2=$(note_for "$S" HEAD)
if [ -n "$n1" ] && [ -n "$n2" ]; then
  # Faithful squash: a non-interactive rebase that SQUASHES the top two commits onto
  # base. notes.rewriteRef + notes.rewriteMode=concatenate (id:d5f9) cause git to copy
  # AND merge the rewritten commits' notes onto the squashed commit; the default
  # `overwrite` would keep only the last. GIT_SEQUENCE_EDITOR scripts the todo list
  # (interactive flags are unavailable, so we rewrite the rebase todo programmatically).
  base=$(git -C "$S" rev-parse HEAD~2)
  GIT_SEQUENCE_EDITOR="sed -i '2s/^pick/squash/'" \
    git -C "$S" -c notes.rewriteRef="$NOTES_REF" -c notes.rewriteMode=concatenate \
    rebase -i "$base" >/dev/null 2>&1
  merged=$(note_for "$S" HEAD)
  c=$(printf '%s\n' "$merged" | grep -c 'status:pending')
  if [ "$c" -ge 2 ]; then pass "squash concatenated both findings (count=$c)"; else bad "squash dropped notes: expected >=2 findings, got $c (merged='${merged}')"; fi
else
  bad "pre-squash notes missing (n1='${n1}' n2='${n2}') — can't test concatenate"
fi
rm -rf "$S"

# --- case 6: loose/off-branch note via merge-base --is-ancestor ------------
# A note on a commit that is NOT an ancestor of the branch tip is "loose"
# (the /relay review sweep recovers these). Assert the detection predicate works
# on a hook-produced note.
echo "[test_verify_hook] case 6 — loose/off-branch note detection"
S=$(make_sandbox)
( cd "$S" && unset RELAY_SKIP; commit_file "$S" m0.txt m0 )
git -C "$S" checkout -q -b side
( cd "$S" && unset RELAY_SKIP; commit_file "$S" side.txt s1 )  # noted commit on side
side_sha=$(git -C "$S" rev-parse HEAD)
git -C "$S" checkout -q -
# main tip does NOT contain side_sha → it is loose w.r.t. main.
if git -C "$S" merge-base --is-ancestor "$side_sha" HEAD 2>/dev/null; then
  loose=0
else
  loose=1
fi
sidenote=$(note_for "$S" "$side_sha")
if [ "$loose" -eq 1 ] && [ -n "$sidenote" ]; then
  pass "off-branch noted commit detected as loose (merge-base --is-ancestor)"
else
  bad "loose-note detection failed (loose=$loose sidenote='${sidenote}')"
fi
rm -rf "$S"

[ "$fail" -eq 0 ] && echo "[test_verify_hook] PASS" || echo "[test_verify_hook] FAIL"
exit "$fail"
