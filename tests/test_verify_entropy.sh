#!/usr/bin/env bash
# roadmap:7306
# RED spec for the entropy + FHE-Stirling SymPy instrument bucket (/meeting id:3d2a D1/D3).
# The owner has placed four \sympyc open-debt badges with no instrument behind them:
#   physics/entropy.md  meanE (l.22), be (l.27), fd (l.35)
#   crypto/fhe.md       stirling (l.12)
# The executor's TOOLING job: build the SymPy instruments (modelled on verify/resogram_esol.py),
# write the physics/entropy.toml + crypto/fhe.toml sidecars, and — on green — flip the source
# badge \sympyc -> \sympy (badge-arg carve-out D4 ONLY; never touch the claim).
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • each instrument runs under `uv run` and prints exactly one VERDICT: ✓ line;
#   • each instrument emits a CLAIM_HASH8 matching its sidecar `claim`;
#   • every sidecar attestation is drift-free (file-hash + claim-hash) and its handle
#     appears as a \veq/\veqs badge in the source page (no dangling attestation).
# Currently RED: the instruments and sidecars do not exist yet.
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_verify_entropy] instrument verdicts"
# instrument-basename : source-page  (handle join lives in the sidecar)
for inst in entropy_meanE entropy_be entropy_fd fhe_stirling; do
  f="verify/${inst}.py"
  if [ ! -f "$f" ]; then bad "$inst → instrument $f missing"; continue; fi
  v=$(uv run --quiet "$f" 2>/dev/null)
  got=$(printf '%s\n' "$v" | grep -oE 'VERDICT: [✓✗]' | grep -oE '[✓✗]')
  if [ "$got" = "✓" ]; then pass "$inst → ✓"; else bad "$inst → got '${got}', want '✓'"; fi
done

echo "[test_verify_entropy] sidecar attestation non-drift + handle-subset"
uv run python - <<'PY'
import sys, re, hashlib, subprocess, tomllib, pathlib
root = pathlib.Path(".")
fail = 0
def bad(m):
    global fail; print("  FAIL " + m); fail = 1
def ok(m): print("  ok   " + m)

# (sidecar, source-page) pairs the bucket introduces.
pairs = [("physics/entropy.toml", "physics/entropy.md"),
         ("crypto/fhe.toml",      "crypto/fhe.md")]

claim_cache = {}
def instrument_claim(pyfile):
    if pyfile not in claim_cache:
        p = root / "verify" / pyfile
        if not p.exists():
            claim_cache[pyfile] = None
        else:
            out = subprocess.run(["uv", "run", "--quiet", "verify/" + pyfile],
                                 capture_output=True, text=True).stdout
            m = re.search(r'CLAIM_HASH8\s*:\s*(\w+)', out)
            claim_cache[pyfile] = m.group(1) if m else None
    return claim_cache[pyfile]
def filehash8(f):
    p = root / "verify" / f
    return hashlib.sha256(p.read_bytes()).hexdigest()[:8] if p.exists() else None

for sidecar, page in pairs:
    sp = root / sidecar
    if not sp.exists():
        bad(f"{sidecar}: missing (no attestation sidecar)"); continue
    toml = tomllib.loads(sp.read_text())
    src  = (root / page).read_text()
    src_handles = set(re.findall(r'\\veqs?\{([^}]+)\}', src))
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

[ "$fail" -eq 0 ] && echo "[test_verify_entropy] PASS" || echo "[test_verify_entropy] FAIL"
exit "$fail"
