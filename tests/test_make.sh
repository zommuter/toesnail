#!/usr/bin/env bash
# roadmap:fca7
# Spec for the Makefile convenience wrapper. RED until a Makefile with build/serve/test
# targets exists. The Makefile is tooling only — it must not touch content.
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • a Makefile exists at repo root with `build`, `serve`, `test` targets;
#   • `make test` is wired to the suite (tests/run.sh) — checked via `make -n` (dry run),
#     NOT executed here: `make test` calls run.sh, so running it inside the suite would
#     recurse. The actual `make test` exit-0 run is the executor's done-check.
#   • `make -n build` / `make -n serve` resolve to the jekyll build/serve commands.
set -u
cd "$(dirname "$0")/.." || exit 2
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_make] Makefile presence + targets"
[ -f Makefile ] || { bad "no Makefile at repo root (RED until id:fca7 done)"; echo "[test_make] FAIL"; exit 1; }
pass "Makefile exists"

for t in build serve test; do
  if make -n "$t" >/dev/null 2>&1; then pass "target '$t' resolves"; else bad "target '$t' missing"; fi
done

# `make test` must be wired to the suite. Check via dry-run only (executing it would
# recurse: make test → tests/run.sh). The actual exit-0 run is the done-check.
if make -n test 2>/dev/null | grep -q 'tests/run.sh'; then pass "make test wired to tests/run.sh"; else bad "make test does not call tests/run.sh"; fi
if make -n build 2>/dev/null | grep -q 'jekyll build'; then pass "make build wired to jekyll build"; else bad "make build not wired to jekyll build"; fi

[ "$fail" -eq 0 ] && echo "[test_make] PASS" || echo "[test_make] FAIL"
exit "$fail"
