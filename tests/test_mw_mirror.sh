#!/usr/bin/env bash
# roadmap:0e63
# Spec for the one-section Resogram `.mw` mirror the HARD commit-hook tier reads.
# RED until id:0e63 stands up the mirror file.
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • a checked-in `.mw` mirror exists at verify/mirror/resogram_esol.mw (a DERIVED
#     TOOLING ARTIFACT — it FAITHFULLY transcribes ONE Resogram section's equations
#     into `.mw` fragment syntax; it must NOT invent/alter physics — owner confirms
#     fidelity, see REVIEW_ME.md);
#   • the mirror has: a block defining the energy `e` (the `esol` form), a sliding-
#     average consumer `ebar` that uses `e`, the independent maintenance drive `y`,
#     and at least one inline `$e$` prose citation;
#   • editing the `e` definition flags its `$e$` citation AND the `ebar` average STALE
#     via mathematical_writing.dag.stale_after_edit, while the unrelated `y` is NOT
#     flagged. This is the DAG staleness signal the hook depends on.
#
# Runs the real `.mw` DAG via `uv run --project <.mw repo>`. A SKIP is NOT a pass:
# if `.mw` or `uv` is unavailable the done-check requires running it where they are.
set -u
cd "$(dirname "$0")/.." || exit 2
MW="${MW_REPO:-/home/tobias/src/mathematical-writing}"
MIRROR="verify/mirror/resogram_esol.mw"
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_mw_mirror] mirror presence"
if [ ! -f "$MIRROR" ]; then
  bad "no $MIRROR (RED until id:0e63 done)"
  echo "[test_mw_mirror] FAIL"
  exit 1
fi
pass "mirror exists"

if ! command -v uv >/dev/null 2>&1; then
  echo "[test_mw_mirror] CANNOT VERIFY — uv not installed; rerun where .mw + uv exist (NOT a pass)"
  exit 1
fi
if [ ! -d "$MW" ]; then
  echo "[test_mw_mirror] CANNOT VERIFY — .mw repo not at $MW (set MW_REPO); NOT a pass"
  exit 1
fi

echo "[test_mw_mirror] DAG staleness signal (edit e → e-citation + ebar stale, y untouched)"
ABS_MIRROR="$(cd "$(dirname "$MIRROR")" && pwd)/$(basename "$MIRROR")"
out=$(MIRROR_PATH="$ABS_MIRROR" uv run --quiet --project "$MW" python - <<'PY' 2>&1
import os, re
from mathematical_writing.parser import parse
from mathematical_writing.dag import stale_after_edit

src = open(os.environ["MIRROR_PATH"], encoding="utf-8").read()
frags = parse(src)

def find(type_, granularity, pred):
    for fr in frags:
        if fr.type == type_ and fr.granularity == granularity and pred(fr.content):
            return fr
    return None

# The energy definition block: a `computation block` assigning e = ...
e_def = find("computation", "block", lambda c: re.match(r"\s*e\s*=", c))
ebar  = find("computation", "block", lambda c: re.match(r"\s*ebar\s*=", c))
y_def = find("computation", "block", lambda c: re.match(r"\s*y\s*=", c))
e_cit = find("computation", "inline", lambda c: c.strip() == "e")

missing = [n for n, v in (("e",e_def),("ebar",ebar),("y",y_def),("$e$ citation",e_cit)) if v is None]
if missing:
    print("MISSING_FRAGMENTS", missing); raise SystemExit(3)

# Drive an edit of the e-definition (replace its RHS) and re-run stale_after_edit.
old_src = src
new_src = src.replace(e_def.content, e_def.content + " + 0  # edited")
stale = stale_after_edit(parse(old_src), parse(new_src))

print("E_CIT_STALE", e_cit.handle in stale)
print("EBAR_STALE",  ebar.handle in stale)
print("Y_STALE",     y_def.handle in stale)
PY
)
echo "$out" | sed 's/^/    /'

if echo "$out" | grep -q "E_CIT_STALE True" \
   && echo "$out" | grep -q "EBAR_STALE True" \
   && echo "$out" | grep -q "Y_STALE False"; then
  pass "editing e stales its citation + ebar; y untouched"
else
  bad "DAG staleness split wrong (see output above)"
fi

[ "$fail" -eq 0 ] && echo "[test_mw_mirror] PASS" || echo "[test_mw_mirror] FAIL"
exit "$fail"
