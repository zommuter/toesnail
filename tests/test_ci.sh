#!/usr/bin/env bash
# roadmap:9868
# Spec for the GitHub Actions CI workflow. RED until .github/workflows/ci.yml exists.
# NOTE: this checks the workflow is WELL-FORMED and COMPLETE; the actual CI run is
# `# unverified — runs on GitHub Actions`. A green local test is NOT a green CI run —
# the item's done-check also requires confirming the run is green on GitHub after push.
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • .github/workflows/ci.yml exists and is valid YAML;
#   • it references all three test layers so CI runs the full suite.
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

W=.github/workflows/ci.yml
echo "[test_ci] workflow presence + validity"
[ -f "$W" ] || { bad "no $W (RED until id:9868 done)"; echo "[test_ci] FAIL"; exit 1; }
pass "$W exists"

# Valid YAML (pyyaml via uv — no system install).
if uv run --quiet --with pyyaml python -c "import yaml,sys; yaml.safe_load(open('$W'))" 2>/dev/null; then
  pass "$W is valid YAML"
else
  bad "$W is not valid YAML"
fi

echo "[test_ci] runs all three test layers"
for ref in test_verify test_render test_mathjax; do
  if grep -q "$ref" "$W"; then pass "references $ref"; else bad "CI does not run $ref"; fi
done

[ "$fail" -eq 0 ] && echo "[test_ci] PASS" || echo "[test_ci] FAIL"
exit "$fail"
