#!/usr/bin/env bash
# roadmap: verify-instruments
# Specs the SymPy/Lean verification layer (verify/resogram_*.py, verify/Resogram.lean)
# and the attestation integrity now carried by \veq badges in physics/Resogram.md +
# the physics/Resogram.toml sidecar (a9d2 migration 2026-06-18, was HTML-comment markers).
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • each instrument runs under `uv run` and prints exactly one VERDICT line (all ✓);
#   • every Resogram.toml attestation matches its instrument's current claim-hash AND
#     file-hash (no drift) — a stale attestation fails;
#   • sidecar handles ⊆ source \veq/\veq* handles (no dangling attestation).
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_verify] instrument verdicts"
# Loop over INSTRUMENT basenames (not handles): handle ymaint is attested by
# resogram_drive.py, etc. — the handle↔instrument join lives in Resogram.toml.
for inst in sol drive eincr edot esol; do
  v=$(uv run --quiet "verify/resogram_${inst}.py" 2>/dev/null)
  got=$(printf '%s\n' "$v" | grep -oE 'VERDICT: [✓✗]' | grep -oE '[✓✗]')
  if [ "$got" = "✓" ]; then pass "$inst → ✓"; else bad "$inst → got '${got}', want '✓'"; fi
done

echo "[test_verify] sidecar attestation non-drift + handle-subset (physics/Resogram.toml)"
uv run python - <<'PY'
import sys, re, hashlib, subprocess, tomllib, pathlib
root = pathlib.Path(".")
toml = tomllib.loads((root / "physics/Resogram.toml").read_text())
src  = (root / "physics/Resogram.md").read_text()
fail = 0
def bad(m):
    global fail; print("  FAIL " + m); fail = 1
def ok(m): print("  ok   " + m)

# Source handles carried by \veq{h} (numbered) or \veqs{h} (unnumbered) — the badge carrier.
src_handles = set(re.findall(r'\\veqs?\{([^}]+)\}', src))

claim_cache = {}
def instrument_claim(pyfile):
    if pyfile not in claim_cache:
        out = subprocess.run(["uv", "run", "--quiet", "verify/" + pyfile],
                             capture_output=True, text=True).stdout
        m = re.search(r'CLAIM_HASH8\s*:\s*(\w+)', out)
        claim_cache[pyfile] = m.group(1) if m else None
    return claim_cache[pyfile]
def filehash8(f):
    p = root / "verify" / f
    return hashlib.sha256(p.read_bytes()).hexdigest()[:8] if p.exists() else None

for handle, entry in toml.items():
    # (b) sidecar handle ⊆ source handles — no dangling attestation
    if handle not in src_handles:
        bad(f"{handle}: sidecar handle has no \\veq/\\veq* in Resogram.md (dangling attestation)")
    # (a) per-instrument file-hash non-drift + claim-hash non-drift for the .py producer
    for b in entry.get("by", []):
        f, _, h = b.partition("@")
        cur = filehash8(f)
        if cur is None:
            bad(f"{handle}: instrument {f} missing")
        elif cur != h:
            bad(f"{handle}: {f} file DRIFT — pinned @{h} vs current @{cur}")
        else:
            ok(f"{handle}: {f} @{h}")
        if f.endswith(".py"):
            c = instrument_claim(f)
            if c is None:
                bad(f"{handle}: {f} emitted no CLAIM_HASH8")
            elif c != entry["claim"]:
                bad(f"{handle}: claim DRIFT — pinned {entry['claim']} vs instrument {c}")
            else:
                ok(f"{handle}: claim {entry['claim']} ({f})")

sys.exit(1 if fail else 0)
PY
[ $? -ne 0 ] && fail=1

[ "$fail" -eq 0 ] && echo "[test_verify] PASS" || echo "[test_verify] FAIL"
exit "$fail"
