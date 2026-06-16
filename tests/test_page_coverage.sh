#!/usr/bin/env bash
# roadmap:7fd7
# Specs render-test COVERAGE of the recovered owner pages (merge c1e20b4, 2026-06-16).
#
# Why this test exists: test_mathjax.cjs hardcodes a DOCS list of pages it renders
# through MathJax 3 + KaTeX. When the cartmanjaro recovery merge added new content
# pages, they were NOT added to that list — so they ship to GitHub Pages with ZERO
# render verification (the exact class of bug — headless pages, kramdown math, \gdef —
# that test_mathjax exists to catch). This asserts the render-CLEAN recovered pages are
# in the coverage list.
#
# SCOPE GUARD (CLAUDE.md → "Repo-specific scope guard"): this is TOOLING coverage only.
# It lists ONLY the pages that are render-well-formed. physics/wirohsh.md and
# physics/photon.md are deliberately EXCLUDED here — they contain incomplete owner math
# (empty align blocks, unbalanced delimiters) that fails to render; adding them is NOT an
# executor task (it would require editing owner theory). They stay owner-gated in
# REVIEW_ME until the owner finishes/withdraws them — see id:8807 / the recovery box.
#
# Contract (relay-TDD: never weaken a test to pass): each listed page must appear in
# test_mathjax.cjs's DOCS array. Turning this green = add them to DOCS AND confirm the
# mathjax suite still passes (if a listed page fails to render, HAND BACK — do not edit
# the math).
set -u
cd "$(dirname "$0")/.." || exit 2
CJS=tests/test_mathjax.cjs
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

[ -f "$CJS" ] || { echo "[test_page_coverage] FAIL — missing $CJS"; exit 1; }

# Render-clean recovered pages that MUST be covered.
for page in physics/entropy.md crypto/fhe.md essays/supertool.md; do
  if grep -q "'$page'" "$CJS"; then
    pass "covered: $page"
  else
    bad "NOT in test_mathjax.cjs DOCS: $page"
  fi
done

if [ "$fail" -eq 0 ]; then echo "[test_page_coverage] PASS"; else echo "[test_page_coverage] FAIL"; fi
exit "$fail"
