#!/usr/bin/env bash
# roadmap:fed0
# Specs that the crypto/ NON-PAGE companions are not published as site artifacts.
#
# Why this test exists: the recovery merge added crypto/fhe.md (a real page, permalink
# /FHE) alongside its jupytext/computation companions crypto/fhe.{ipynb,py,ods}. Jekyll
# copies any non-underscore source file into _site, so those three companions would be
# published verbatim at _site/crypto/ — build clutter, and the .ipynb/.ods are not web
# pages. They must stay in the repo (the .ods holds the unique 368-cell enumeration) but
# be EXCLUDED from the rendered site via _config.yml `exclude:`. The FHE *page*
# (crypto/fhe.md) must still render at /FHE.
#
# NOTE (owner-routable): if the owner later wants the .ods downloadable from the site,
# that's a one-line re-include — surface it, don't silently re-add.
#
# Contract (relay-TDD): after a clean build, _site contains the FHE page but NOT the
# three companions. Turn green by adding crypto/fhe.ipynb, crypto/fhe.py, crypto/fhe.ods
# to `exclude:` in _config.yml. Do NOT delete the companions from the repo.
set -u
cd "$(dirname "$0")/.." || exit 2
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

command -v bundle >/dev/null || { echo "[test_crypto_exclude] SKIP — bundler not on PATH"; exit 0; }

echo "[test_crypto_exclude] build"
bundle exec jekyll build --quiet 2>/tmp/jekyll-build.log || { bad "jekyll build (see /tmp/jekyll-build.log)"; tail -5 /tmp/jekyll-build.log; echo "[test_crypto_exclude] FAIL"; exit 1; }

# The FHE page must render (permalink /FHE).
if [ -f _site/FHE.html ]; then pass "FHE page rendered (/FHE)"; else bad "missing _site/FHE.html (FHE page should render)"; fi

# The non-page companions must NOT be published.
for art in crypto/fhe.ipynb crypto/fhe.py crypto/fhe.ods; do
  if [ -e "_site/$art" ]; then bad "published companion leaked into _site: $art"; else pass "excluded from site: $art"; fi
done

if [ "$fail" -eq 0 ]; then echo "[test_crypto_exclude] PASS"; else echo "[test_crypto_exclude] FAIL"; fi
exit "$fail"
