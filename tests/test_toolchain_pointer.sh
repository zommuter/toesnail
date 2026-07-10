#!/usr/bin/env bash
# roadmap:318f
# Spec: CLAUDE.md carries the lean-toolchain provenance pointer (routed:89d0 from
# mathematical-writing). RED until id:318f adds the pointer. Docs-only [ROUTINE]
# work — NO theory/physics content is touched (scope-guard clean).
#
# Contract (relay-TDD: never weaken a test to make it pass). CLAUDE.md must state,
# in one contiguous block, all three facts near a `lean-toolchain` mention:
#   (a) verify/lean-toolchain is a CACHE / DERIVED value of the vendored Mathlib rev,
#       NOT a hand-edited fact;
#   (b) toesnail is the triad's rev-bump DECIDER (it pays the ~7 GB Mathlib build);
#   (c) mathematical-writing PUBLISHES the derived fleet value at its repo root.
set -u
cd "$(dirname "$0")/.." || exit 2
DOC="CLAUDE.md"
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_toolchain_pointer] CLAUDE.md lean-toolchain provenance pointer"

if ! grep -qi 'lean-toolchain' "$DOC"; then
  bad "no 'lean-toolchain' mention in $DOC (RED until id:318f done)"
  echo "[test_toolchain_pointer] FAIL"
  exit 1
fi
pass "mentions lean-toolchain"

# Context window around the lean-toolchain mention(s): the three facts must co-occur
# near it, not merely somewhere else in the file.
ctx="$(grep -i -A5 -B2 'lean-toolchain' "$DOC")"

if echo "$ctx" | grep -qiE 'cache|cached|derived|not .*hand-edit'; then
  pass "(a) states it is a cache/derived value"
else
  bad "(a) no cache/derived/not-hand-edited framing near lean-toolchain"
fi

if echo "$ctx" | grep -qiE 'rev-bump|decider|decide|pays'; then
  pass "(b) names toesnail as the rev-bump decider / build payer"
else
  bad "(b) no rev-bump/decider/pays framing near lean-toolchain"
fi

if echo "$ctx" | grep -qiE 'mathematical-writing|publishes'; then
  pass "(c) points at mathematical-writing as publisher of the fleet value"
else
  bad "(c) no mathematical-writing/publishes framing near lean-toolchain"
fi

[ "$fail" -eq 0 ] && echo "[test_toolchain_pointer] PASS" || echo "[test_toolchain_pointer] FAIL"
exit "$fail"
