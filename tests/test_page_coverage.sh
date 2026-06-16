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
# All five recovered content pages render CLEAN through MathJax 3 AND KaTeX (verified
# 2026-06-16 by running them through tests/test_mathjax.cjs — zero merror/throw). NB
# "incomplete derivation" ≠ "fails to render": wirohsh.md/photon.md have unfinished
# sections (empty align blocks) but that is valid LaTeX and renders fine; whether to
# FINISH them is an owner content question (REVIEW_ME), independent of render coverage.
#
# Contract (relay-TDD: never weaken a test to pass): each listed page must appear in
# test_mathjax.cjs's DOCS array. If a listed page ever fails to render there, that is an
# owner-content issue — HAND BACK, do not edit the math to make a test pass.
set -u
cd "$(dirname "$0")/.." || exit 2
CJS=tests/test_mathjax.cjs
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

[ -f "$CJS" ] || { echo "[test_page_coverage] FAIL — missing $CJS"; exit 1; }

# Recovered pages that MUST be render-covered (all verified render-clean).
for page in physics/entropy.md physics/wirohsh.md physics/photon.md crypto/fhe.md essays/supertool.md; do
  if grep -q "'$page'" "$CJS"; then
    pass "covered: $page"
  else
    bad "NOT in test_mathjax.cjs DOCS: $page"
  fi
done

if [ "$fail" -eq 0 ]; then echo "[test_page_coverage] PASS"; else echo "[test_page_coverage] FAIL"; fi
exit "$fail"
