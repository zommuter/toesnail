#!/usr/bin/env bash
# Full test suite. Definition of done (relay-TDD): this exits 0.
# Run from anywhere:  bash tests/run.sh
set -u
here="$(dirname "$0")"
rc=0
for t in test_verify.sh test_render.sh; do
  echo "============================================================"
  echo "RUN $t"
  echo "============================================================"
  bash "$here/$t" || rc=1
  echo
done

echo "============================================================"
echo "RUN test_mathjax.cjs"
echo "============================================================"
if command -v node >/dev/null 2>&1; then
  node "$here/test_mathjax.cjs" || rc=1
else
  echo "[test_mathjax] SKIP — node not installed"
fi
echo
echo "============================================================"
if [ "$rc" -eq 0 ]; then
  echo "SUITE: PASS"
else
  echo "SUITE: FAIL"
fi
echo "Reminder: tests/HUMAN-integration.md still needs a human pass for the"
echo "irreducibly-visual checks (MathJax runs client-side; CI can't 'see' it)."
exit "$rc"
