#!/usr/bin/env bash
# Full test suite. Definition of done (relay-TDD): this exits 0.
# Run from anywhere:  bash tests/run.sh
set -u
here="$(dirname "$0")"
rc=0
for t in test_verify.sh test_verify_entropy_routine.sh test_render.sh test_verify_hook.sh test_mw_mirror.sh test_lean.sh test_page_coverage.sh test_crypto_exclude.sh test_conventions_ladder.sh test_toolchain_pointer.sh test_ci.sh test_make.sh test_dreamed_lean_pin.sh; do
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
echo "RUN test_veqs_inline.cjs"
echo "============================================================"
if command -v node >/dev/null 2>&1; then
  node "$here/test_veqs_inline.cjs" || rc=1
else
  echo "[test_veqs_inline] SKIP — node not installed"
fi
echo
# ---- ADVISORY tier (id:8b1c, owner ruling option (c)) -----------------------
# Reports render breaks in the UNRATIFIED docs/dreamed/ pages. Deliberately does NOT
# contribute to $rc: those pages are published but not owner-ratified, so they must
# never be able to fail `make test`. Its own output is a loud ADVISORY block.
echo "============================================================"
echo "RUN test_dreamed_render.cjs  [ADVISORY: never fails the suite]"
echo "============================================================"
if command -v node >/dev/null 2>&1; then
  node "$here/test_dreamed_render.cjs" || true
else
  echo "[test_dreamed_render] SKIP: node not installed"
fi
echo
echo "============================================================"
echo "RUN test_carryback.sh  [ADVISORY: never fails the suite]"
echo "============================================================"
bash "$here/test_carryback.sh" || true
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
