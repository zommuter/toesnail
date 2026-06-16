#!/usr/bin/env bash
# roadmap:5776
# Specs the Lean/Mathlib attestation layer (verify/Resogram.lean).
#
# Optional-tool SKIP pattern: no `lake` → SKIP cleanly (mirrors test_render.sh
# without bundler, test_mathjax.cjs without node).  Present → run the real
# `lake build` + sorry-guard.
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • if lake is absent, exit 0 with SKIP message (never FAIL);
#   • `cd verify && lake build` exits 0;
#   • verify/Resogram.lean contains NO `sorry` — a sorry-green is a fake green.
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

command -v lake >/dev/null || { echo "[test_lean] SKIP — lake not on PATH (install lean4/elan)"; exit 0; }

echo "[test_lean] lake build"
if (cd verify && lake build 2>/tmp/lake-build.log); then
  pass "lake build"
else
  bad "lake build failed (see /tmp/lake-build.log)"
  tail -10 /tmp/lake-build.log
fi

echo "[test_lean] sorry guard"
if grep -qE '\bsorry\b' verify/Resogram.lean; then
  bad "verify/Resogram.lean contains 'sorry' — not a real proof"
else
  pass "no sorry in Resogram.lean"
fi

[ "$fail" -eq 0 ] && echo "[test_lean] PASS" || echo "[test_lean] FAIL"
exit "$fail"
