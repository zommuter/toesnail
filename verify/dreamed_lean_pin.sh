#!/usr/bin/env bash
# roadmap:0720
#
# Pure hash/pin drift guard for docs/dreamed/lean/*.lean. Deliberately does NOT invoke
# `lake` or re-elaborate anything -- it is a cheap comparison, not a re-verification.
# Reports every drifted item (missing/extra/mismatched hash, mismatched toolchain or
# Mathlib pin) and exits non-zero if any drift is found. See docs/dreamed/lean-pins.json
# for the recorded baseline and tests/test_dreamed_lean_pin.sh for the spec.
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT" || exit 2

MANIFEST="docs/dreamed/lean-pins.json"
TOOLCHAIN_FILE="verify/lean-toolchain"
LAKE_MANIFEST="verify/lake-manifest.json"
LEAN_DIR="docs/dreamed/lean"

if [ ! -f "$MANIFEST" ]; then
  echo "dreamed_lean_pin: no manifest at $MANIFEST" >&2
  exit 2
fi
if ! command -v python3 >/dev/null 2>&1; then
  echo "dreamed_lean_pin: python3 not on PATH" >&2
  exit 2
fi

python3 - "$MANIFEST" "$TOOLCHAIN_FILE" "$LAKE_MANIFEST" "$LEAN_DIR" <<'PYEOF'
import glob, hashlib, json, os, sys

manifest_path, toolchain_path, lake_manifest_path, lean_dir = sys.argv[1:5]

drift = []

try:
    man = json.load(open(manifest_path, encoding="utf-8"))
except Exception as e:
    print(f"DRIFT: cannot parse {manifest_path}: {e}")
    sys.exit(1)

files = man.get("files") or {}
pin = man.get("pin") or {}

tree = sorted(os.path.basename(p) for p in glob.glob(os.path.join(lean_dir, "*.lean")))
recorded = sorted(os.path.basename(k) for k in files)

missing = [f for f in tree if f not in recorded]
extra = [f for f in recorded if f not in tree]
for f in missing:
    drift.append(f"{f}: no recorded hash")
for f in extra:
    drift.append(f"{f}: recorded hash for a file no longer present")

for name, rec in files.items():
    base = os.path.basename(name)
    p = os.path.join(lean_dir, base)
    want = rec.get("sha256") if isinstance(rec, dict) else rec
    if not os.path.isfile(p):
        continue
    got = hashlib.sha256(open(p, "rb").read()).hexdigest()
    if got != want:
        drift.append(f"{base}: hash mismatch (recorded {want!r} != current {got!r})")

# Toolchain pin
try:
    want_tc = open(toolchain_path, encoding="utf-8").read().strip()
except OSError as e:
    drift.append(f"toolchain: cannot read {toolchain_path}: {e}")
    want_tc = None
got_tc = (pin.get("toolchain") or "").strip()
if want_tc is not None and got_tc != want_tc:
    drift.append(f"toolchain: recorded {got_tc!r} != {toolchain_path} {want_tc!r}")

# Mathlib rev pin
try:
    lm = json.load(open(lake_manifest_path, encoding="utf-8"))
    want_rev = next(
        (p.get("rev") for p in lm.get("packages", []) if p.get("name") == "mathlib"),
        None,
    )
except Exception as e:
    drift.append(f"mathlib_rev: cannot read {lake_manifest_path}: {e}")
    want_rev = None
got_rev = (pin.get("mathlib_rev") or "").strip()
if want_rev is not None and got_rev != want_rev:
    drift.append(f"mathlib_rev: recorded {got_rev!r} != {lake_manifest_path} {want_rev!r}")

if drift:
    print(f"DRIFT: {len(drift)} item(s) out of date against docs/dreamed/lean-pins.json:")
    for d in drift:
        print(f"  - {d}")
    sys.exit(1)

print(f"dreamed_lean_pin: {len(tree)} .lean file(s), toolchain and mathlib_rev pin all match")
sys.exit(0)
PYEOF
