#!/usr/bin/env bash
# roadmap:7fd7, id:8b1c
# Specs render-test COVERAGE of every RATIFIED published page.
#
# Why this test exists: tests/test_mathjax.cjs hardcodes a DOCS list of pages it renders
# through MathJax 3 + KaTeX. A page that is not in that list ships to GitHub Pages with
# ZERO render verification (the exact class of bug -- headless pages, kramdown math,
# \gdef -- that test_mathjax exists to catch).
#
# WHY IT WAS REWRITTEN (id:8b1c, owner ruling 2026-09-07): this test used to assert that
# 5 HARDCODED page names appeared in that array. Both sides of the comparison were
# hand-maintained lists, so the guard checked an allowlist against itself: adding a page
# tripped nothing, which is how 57 docs/dreamed/ pages and 4 physics/essays pages reached
# the public site uncovered. It is now a DIRECTORY SCAN -- it enumerates the pages that
# actually exist on disk and asserts coverage against that.
#
# ---------------------------------------------------------------------------
# SCOPE SPLIT -- which directories block, and which only advise
# ---------------------------------------------------------------------------
# BLOCKING (this test):  physics/  essays/  crypto/  and the root README.md
#   This is the owner's RATIFIED content. It is the site proper, and a render break here
#   must stop the suite. Every such page must appear in test_mathjax.cjs's DOCS array.
#
# ADVISORY (tests/test_dreamed_render.cjs):  docs/dreamed/
#   Unratified AI exploration, published but explicitly not owner-ratified. Covering it
#   HERE would let an unratified essay break `make test`, which is exactly wrong; leaving
#   it uncovered would let a kramdown/MathJax break go silent AND public. So it gets its
#   own non-blocking tier that reports and exits 0. It is NOT expected in DOCS, and this
#   test must never grow to demand it.
#
# OUT OF SCOPE for both:  docs/meeting-notes/
#   A permalinked meeting note is a decision RECORD, not site content; it is not a
#   rendering surface anyone reads for the math.
#
# A page counts as "published" iff its front-matter carries a `permalink:` (that is what
# puts it on the site), so the scan tracks reality rather than a second name list.
#
# Contract (relay-TDD: never weaken a test to pass): a NEW ratified page turns this RED
# until it is added to DOCS. If a page then fails to render there, that is an
# owner-content issue -- HAND BACK, do not edit the math to make a test pass.
set -u
cd "$(dirname "$0")/.." || exit 2
CJS=tests/test_mathjax.cjs
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

[ -f "$CJS" ] || { echo "[test_page_coverage] FAIL: missing $CJS"; exit 1; }

# Enumerate the ratified published pages that actually exist (directory scan, not a list).
published=""
for f in physics/*.md essays/*.md crypto/*.md README.md; do
  [ -f "$f" ] || continue
  head -6 "$f" | grep -q '^permalink:' || continue
  published="$published $f"
done

n=0
for page in $published; do
  n=$((n + 1))
  if grep -q "'$page'" "$CJS"; then
    pass "covered: $page"
  else
    bad "NOT in test_mathjax.cjs DOCS: $page (add it, then confirm it renders)"
  fi
done

if [ "$n" -eq 0 ]; then
  bad "directory scan found ZERO published pages: the scan itself is broken"
else
  pass "scanned $n ratified published page(s) in physics/ essays/ crypto/ README.md"
fi

# The advisory half of the split must exist, or dreamed pages are silently uncovered again.
if [ -f tests/test_dreamed_render.cjs ]; then
  pass "advisory tier present for docs/dreamed/ (tests/test_dreamed_render.cjs)"
else
  bad "missing tests/test_dreamed_render.cjs: docs/dreamed/ would be uncovered (id:8b1c)"
fi

# docs/dreamed/ must NOT have leaked into the blocking DOCS array (that would let an
# unratified essay fail the owner's build, which the ruling explicitly rejected).
if grep -q "'docs/dreamed/" "$CJS"; then
  bad "docs/dreamed/ page found in the BLOCKING DOCS array: it belongs in the advisory tier"
else
  pass "no docs/dreamed/ page in the blocking DOCS array"
fi

if [ "$fail" -eq 0 ]; then echo "[test_page_coverage] PASS"; else echo "[test_page_coverage] FAIL"; fi
exit "$fail"
