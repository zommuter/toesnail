#!/usr/bin/env bash
# roadmap:0720
#
# id:0720 has landed; wired into tests/run.sh in the same commit that made this green.
#
# What it specs
# -------------
# `docs/dreamed/lean/*.lean` (56 files today) sit OUTSIDE the lake targets:
# verify/lakefile.toml declares `defaultTargets = ["Resogram"]`, so `make test` never
# elaborates them. They are nevertheless PUBLISHED as machine-checked claims. A Mathlib
# bump could therefore silently invalidate all 56 with nothing to catch it.
#
# Owner ruling 2026-09-08 (`/relay human`, TODO+ROADMAP id:0720): the cheap tier --
# pinned-good hashes + re-check on touch -- AND a pinned Mathlib/toolchain. The pin is
# what makes the cheap tier sound: hashes alone only re-check when a FILE is touched, so
# an upstream Mathlib change would go unnoticed indefinitely. The two halves are ONE
# mechanism and must ship together. This spec fails if either half is missing.
#
# Deliberately NOT specified here: any bulk re-elaboration of the 56 files. The owner
# rejected nightly re-verification on cost. The checker must be a pure hash/pin
# comparison that runs with NO `lake` on PATH and merely REPORTS the drifted subset;
# re-elaborating that subset stays an ad-hoc run under docs/dreamed/capped.sh.
#
# Contract (relay-TDD: never weaken a test to make it pass): the checker's non-zero exit
# on drift is the load-bearing assertion. A checker that reports drift and exits 0 is the
# silent-no-op failure class and does NOT satisfy this spec.
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

CHECKER="verify/dreamed_lean_pin.sh"      # the implementation this spec expects
MANIFEST="docs/dreamed/lean-pins.json"    # recorded hashes + recorded pin

echo "[test_dreamed_lean_pin] (a) a recorded good hash per docs/dreamed/lean/*.lean"

if [ ! -f "$MANIFEST" ]; then
  bad "no pin manifest at $MANIFEST -- acceptance (a)+(c) unrecorded"
elif ! command -v python3 >/dev/null 2>&1; then
  bad "python3 absent -- cannot read $MANIFEST"
else
  python3 - "$MANIFEST" <<'PYEOF'
import glob, hashlib, json, os, sys
man = json.load(open(sys.argv[1], encoding="utf-8"))
files = man.get("files") or {}
tree = sorted(os.path.basename(p) for p in glob.glob("docs/dreamed/lean/*.lean"))
if not tree:
    print("  FAIL docs/dreamed/lean/*.lean is empty -- fixture broken, not a pass")
    sys.exit(1)
recorded = sorted(os.path.basename(k) for k in files)
missing = [f for f in tree if f not in recorded]
extra = [f for f in recorded if f not in tree]
rc = 0
if missing:
    print(f"  FAIL {len(missing)} .lean file(s) with no recorded hash, e.g. {missing[:3]}")
    rc = 1
else:
    print(f"  ok   every one of {len(tree)} .lean files carries a recorded hash")
if extra:
    print(f"  FAIL {len(extra)} recorded hash(es) for absent file(s), e.g. {extra[:3]}")
    rc = 1
bad_hash = []
for name, rec in files.items():
    p = os.path.join("docs", "dreamed", "lean", os.path.basename(name))
    want = rec.get("sha256") if isinstance(rec, dict) else rec
    if not os.path.isfile(p):
        continue
    got = hashlib.sha256(open(p, "rb").read()).hexdigest()
    if got != want:
        bad_hash.append(name)
if bad_hash:
    print(f"  FAIL recorded hash disagrees with the tree for {bad_hash[:3]} -- stale baseline")
    rc = 1
else:
    print("  ok   every recorded hash matches its file on disk")
sys.exit(rc)
PYEOF
  [ $? -eq 0 ] || fail=1
fi

echo "[test_dreamed_lean_pin] (c) the Mathlib rev + toolchain are recorded, and are the REAL ones"

if [ -f "$MANIFEST" ] && command -v python3 >/dev/null 2>&1; then
  python3 - "$MANIFEST" <<'PYEOF'
import json, sys
man = json.load(open(sys.argv[1], encoding="utf-8"))
pin = man.get("pin") or {}
rc = 0
want_tc = open("verify/lean-toolchain", encoding="utf-8").read().strip()
got_tc = (pin.get("toolchain") or "").strip()
if got_tc != want_tc:
    print(f"  FAIL recorded toolchain {got_tc!r} != verify/lean-toolchain {want_tc!r}")
    rc = 1
else:
    print(f"  ok   recorded toolchain matches verify/lean-toolchain ({want_tc})")
lm = json.load(open("verify/lake-manifest.json", encoding="utf-8"))
want_rev = next((p.get("rev") for p in lm.get("packages", []) if p.get("name") == "mathlib"), None)
got_rev = (pin.get("mathlib_rev") or "").strip()
if not want_rev:
    print("  FAIL no mathlib package in verify/lake-manifest.json -- fixture broken")
    rc = 1
elif got_rev != want_rev:
    print(f"  FAIL recorded mathlib_rev {got_rev!r} != lake-manifest rev {want_rev!r}")
    rc = 1
else:
    print(f"  ok   recorded mathlib_rev matches lake-manifest.json ({want_rev[:12]}…)")
sys.exit(rc)
PYEOF
  [ $? -eq 0 ] || fail=1
else
  bad "cannot check the recorded pin -- $MANIFEST absent or python3 missing"
fi

echo "[test_dreamed_lean_pin] (c) the pin is stated where a READER of the claims can find it"

if [ ! -f docs/dreamed/README.md ]; then
  bad "docs/dreamed/README.md absent"
elif grep -qE 'leanprover/lean4:v[0-9]' docs/dreamed/README.md \
  && grep -qiE 'mathlib' docs/dreamed/README.md; then
  pass "docs/dreamed/README.md states the toolchain and names Mathlib"
else
  bad "docs/dreamed/README.md does not state the pinned toolchain -- 'machine-checked' is only true relative to a stated toolchain"
fi

echo "[test_dreamed_lean_pin] (b) drift in a FILE makes the checker exit NON-ZERO"

if [ ! -x "$CHECKER" ]; then
  bad "no executable checker at $CHECKER -- acceptance (b) has no trigger"
else
  if ! "$CHECKER" >/dev/null 2>&1; then
    bad "$CHECKER is already non-zero on the UNDRIFTED tree -- a guard that always fires guards nothing"
  else
    pass "$CHECKER exits 0 on the undrifted tree"
  fi

  scratch="$(mktemp -d)"
  trap 'rm -rf "$scratch"' EXIT
  victim="$(ls docs/dreamed/lean/*.lean 2>/dev/null | head -1)"
  if [ -z "$victim" ]; then
    bad "no .lean file to mutate -- fixture broken, not a pass"
  else
    cp -- "$victim" "$scratch/victim.bak"
    printf '\n-- drift probe (test_dreamed_lean_pin)\n' >> "$victim"
    if "$CHECKER" >"$scratch/out" 2>&1; then
      bad "$CHECKER exits 0 with a MUTATED .lean file -- the re-check never fires (silent no-op)"
    elif grep -q "$(basename "$victim")" "$scratch/out"; then
      pass "mutated .lean file → non-zero, and the drifted file is named"
    else
      bad "$CHECKER went non-zero on a mutated file but did not NAME it"
    fi
    cp -- "$scratch/victim.bak" "$victim"
  fi

  cp -- verify/lean-toolchain "$scratch/toolchain.bak"
  printf 'leanprover/lean4:v9.99.99-drift-probe\n' > verify/lean-toolchain
  if "$CHECKER" >"$scratch/out2" 2>&1; then
    bad "$CHECKER exits 0 with a MUTATED toolchain pin -- the pin is documentation, not a trigger (the owner's ruling says it must be a trigger)"
  else
    pass "mutated toolchain pin → non-zero: the pin is a trigger"
  fi
  cp -- "$scratch/toolchain.bak" verify/lean-toolchain

  echo "[test_dreamed_lean_pin] the checker must not need lake (bulk re-verification is OUT of scope)"
  if PATH="/usr/bin:/bin" env -u LAKE "$CHECKER" >/dev/null 2>&1; then
    pass "checker runs without a lake build"
  else
    bad "checker fails on a minimal PATH -- it is doing more than a hash/pin comparison"
  fi
fi

[ "$fail" -eq 0 ] && echo "[test_dreamed_lean_pin] PASS" || echo "[test_dreamed_lean_pin] FAIL (expected until id:0720 lands)"
exit "$fail"
