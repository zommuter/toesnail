#!/usr/bin/env bash
# roadmap: render-pipeline
# Specs the Jekyll → MathJax rendering pipeline. Builds the site and asserts the
# invariants that make math actually render on GitHub Pages.
#
# Why this test exists: every page had a title+permalink but NO layout, so Jekyll
# emitted bare fragments with no <head> — MathJax never loaded and no math rendered.
# And kramdown's default math engine rewrites $$…$$ into <script type="math/tex">
# tags that MathJax 3 ignores. Both are now fixed; this test keeps them fixed.
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • the build succeeds;
#   • content pages carry a <head> that loads MathJax 3 with the tags:'ams' config;
#   • kramdown leaves the math delimiters alone (zero math/tex script tags);
#   • the $$ display blocks, \ltag handles, the \eqref cross-ref and the in-document
#     \gdef macro block all survive into the HTML;
#   • verify:/verified: markers stay HTML comments (never visible body text).
set -u
cd "$(dirname "$0")/.." || exit 2
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }
have() { [ "$(grep -c "$1" "$2" 2>/dev/null)" -ge "${3:-1}" ]; }

command -v bundle >/dev/null || { echo "[test_render] SKIP — bundler not on PATH (run: gem install --user-install bundler jekyll)"; exit 0; }

echo "[test_render] build"
if bundle exec jekyll build --quiet 2>/tmp/jekyll-build.log; then pass "jekyll build"; else bad "jekyll build (see /tmp/jekyll-build.log)"; tail -5 /tmp/jekyll-build.log; fi

R=_site/Resogram.html
[ -f "$R" ] || { bad "missing $R"; echo "[test_render] FAIL"; exit 1; }

echo "[test_render] head / MathJax"
have '<head'                "$R" && pass "page has <head>"                || bad "no <head> (missing layout?)"
have 'MathJax-script'       "$R" && pass "MathJax 3 script loads"          || bad "MathJax not loaded"
have 'window.MathJax'       "$R" && pass "window.MathJax config present"   || bad "no MathJax config"
have "tags: 'ams'"          "$R" && pass "tags:'ams' configured"           || bad "tags:'ams' missing"
have 'ltag:'                "$R" && pass "\\ltag macro in MathJax config"  || bad "\\ltag macro missing from config"
# MathJax rejects in-document \gdef; it must not reappear in a rendered math block.
if grep -qE '\\g?def\\(ltag|eqref)' "$R"; then bad "in-document \\gdef macro def leaked into body"; else pass "no in-document \\gdef in body"; fi

echo "[test_render] kramdown left math for MathJax"
[ "$(grep -c 'math/tex' "$R")" -eq 0 ] && pass "zero <script type=math/tex> tags" || bad "kramdown converted math (math_engine not null?)"

echo "[test_render] handles + delimiters survived"
have '\$\$'        "$R" 6 && pass "\$\$ display blocks present"   || bad "\$\$ blocks missing"
have 'ltag{eom}'   "$R"   && pass "\\ltag{eom} handle present"    || bad "ltag handle missing"
have 'eqref{eom}'  "$R"   && pass "\\eqref{eom} cross-ref present"|| bad "eqref cross-ref missing"
# A handle must live in a BLOCK ($$) equation. If a \ltag lands in an inline
# kdmath span (single $), kramdown folded the $$ into a paragraph — e.g. a
# comment glued to the closing $$ with no blank line — and MathJax then renders
# it inline (left-aligned, \tag suppressed). Guard against that regression.
[ "$(grep -c 'class="kdmath">\$[^$]*ltag' "$R")" -eq 0 ] && pass "all handles in block (\$\$) math" || bad "a \\ltag landed in inline math (blank line missing after \$\$?)"

echo "[test_render] markers stay HTML comments"
have '<!-- verify:'   "$R" && pass "verify: markers are comments"    || bad "verify: not in a comment"
have '<!-- verified:' "$R" && pass "verified: markers are comments"  || bad "verified: not in a comment"
# a verify: marker must never appear as visible <p> text
if grep -oE '<p>[^<]*verify:' "$R" | grep -q .; then bad "a verify: marker leaked into visible text"; else pass "no marker leaked into body"; fi

echo "[test_render] other pages also get a head"
have '<head' _site/toesnail.html && pass "toesnail.html has <head>" || bad "toesnail.html headless"

[ "$fail" -eq 0 ] && echo "[test_render] PASS" || echo "[test_render] FAIL"
exit "$fail"
