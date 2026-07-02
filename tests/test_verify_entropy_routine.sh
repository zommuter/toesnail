#!/usr/bin/env bash
# roadmap:e9e9
# Spec for the id:e9e9 seam of id:7306 (auto hard-split, id:3801): the three
# already-verifiable entropy SymPy instruments (meanE/be/fd) + the
# physics/entropy.toml sidecar. The FOURTH id:7306 instrument, fhe_stirling
# (crypto/fhe.md `stirling`), is OUT of scope here — it is blocked on a
# unit-mismatch fix and lives in its own seam, id:76e5 [HARD — strong model].
# tests/test_verify_entropy.sh (roadmap:7306) still specs all four together
# and stays unwired/RED until id:76e5 lands; this file is the NEW, narrower
# spec that id:e9e9 actually closes.
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • each instrument runs under `uv run` and prints exactly one VERDICT: ✓ line;
#   • each instrument emits a CLAIM_HASH8 matching its physics/entropy.toml entry;
#   • the physics/entropy.toml attestation is drift-free (file-hash + claim-hash)
#     and its handles ⊆ source \veq/\veqs handles in physics/entropy.md.
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_verify_entropy_routine] instrument verdicts"
for inst in entropy_meanE entropy_be entropy_fd; do
  f="verify/${inst}.py"
  if [ ! -f "$f" ]; then bad "$inst → instrument $f missing"; continue; fi
  v=$(uv run --quiet "$f" 2>/dev/null)
  got=$(printf '%s\n' "$v" | grep -oE 'VERDICT: [✓✗]' | grep -oE '[✓✗]')
  if [ "$got" = "✓" ]; then pass "$inst → ✓"; else bad "$inst → got '${got}', want '✓'"; fi
done

echo "[test_verify_entropy_routine] sidecar attestation non-drift + handle-subset (physics/entropy.toml)"
uv run python - <<'PY'
import sys, re, hashlib, subprocess, tomllib, pathlib
root = pathlib.Path(".")
fail = 0
def bad(m):
    global fail; print("  FAIL " + m); fail = 1
def ok(m): print("  ok   " + m)

sidecar, page = "physics/entropy.toml", "physics/entropy.md"
sp = root / sidecar
if not sp.exists():
    bad(f"{sidecar}: missing (no attestation sidecar)")
    sys.exit(1)
toml = tomllib.loads(sp.read_text())
src  = (root / page).read_text()
src_handles = set(re.findall(r'\\veqs?\{([^}]+)\}', src))

def instrument_claim(pyfile):
    out = subprocess.run(["uv", "run", "--quiet", "verify/" + pyfile],
                         capture_output=True, text=True).stdout
    m = re.search(r'CLAIM_HASH8\s*:\s*(\w+)', out)
    return m.group(1) if m else None
def filehash8(f):
    p = root / "verify" / f
    return hashlib.sha256(p.read_bytes()).hexdigest()[:8] if p.exists() else None

for handle, entry in toml.items():
    if handle not in src_handles:
        bad(f"{sidecar}:{handle}: no \\veq/\\veqs in {page} (dangling attestation)")
    for b in entry.get("by", []):
        f, _, h = b.partition("@")
        cur = filehash8(f)
        if cur is None:
            bad(f"{sidecar}:{handle}: instrument {f} missing")
        elif cur != h:
            bad(f"{sidecar}:{handle}: {f} file DRIFT — pinned @{h} vs current @{cur}")
        else:
            ok(f"{sidecar}:{handle}: {f} @{h}")
        if f.endswith(".py"):
            c = instrument_claim(f)
            if c is None:
                bad(f"{sidecar}:{handle}: {f} emitted no CLAIM_HASH8")
            elif c != entry.get("claim"):
                bad(f"{sidecar}:{handle}: claim DRIFT — pinned {entry.get('claim')} vs instrument {c}")
            else:
                ok(f"{sidecar}:{handle}: claim {entry.get('claim')} ({f})")

sys.exit(1 if fail else 0)
PY
[ $? -ne 0 ] && fail=1

[ "$fail" -eq 0 ] && echo "[test_verify_entropy_routine] PASS" || echo "[test_verify_entropy_routine] FAIL"
exit "$fail"
