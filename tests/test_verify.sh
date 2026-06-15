#!/usr/bin/env bash
# roadmap: verify-instruments
# Specs the SymPy verification layer (verify/resogram_*.py) and the verified:
# attestation integrity in physics/Resogram.md.
#
# Contract (relay-TDD: never weaken a test to make it pass):
#   • each instrument runs under `uv run` and prints exactly one VERDICT line;
#   • verdicts are the pinned pilot outcome: all five ✓ (edot/esol re-pinned
#     2026-06-15 after the owner ratified the located corrections via /relay human;
#     handle cval→esol renamed 2026-06-15 via /meeting);
#   • every verified: attestation in Resogram.md matches its instrument's
#     current claim-hash AND file-hash (no drift) — a stale attestation fails.
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0
pass() { printf '  ok   %s\n' "$1"; }
bad()  { printf '  FAIL %s\n' "$1"; fail=1; }

echo "[test_verify] instrument verdicts"
declare -A want=( [sol]=✓ [drive]=✓ [eincr]=✓ [edot]=✓ [esol]=✓ )
declare -A out
for h in sol drive eincr edot esol; do
  v=$(uv run --quiet "verify/resogram_${h}.py" 2>/dev/null)
  out[$h]=$v
  got=$(printf '%s\n' "$v" | grep -oE 'VERDICT: [✓✗]' | grep -oE '[✓✗]')
  if [ "$got" = "${want[$h]}" ]; then pass "$h → ${got}"; else bad "$h → got '${got}', want '${want[$h]}'"; fi
done

echo "[test_verify] attestation non-drift (drive, eincr, edot, esol)"
for h in drive eincr edot esol; do
  claim=$(printf '%s\n' "${out[$h]}" | grep -oP 'CLAIM_HASH8\s*:\s*\K\w+')
  file=$(sha256sum "verify/resogram_${h}.py" | cut -c1-8)
  # marker type is sympy or numeric (esol is numeric); match either.
  marker=$(grep -oE "verified:(sympy|numeric) \[${h}\] claim=\w+ by=resogram_${h}\.py@\w+" physics/Resogram.md)
  if [ -z "$marker" ]; then bad "$h: no verified: marker in Resogram.md"; continue; fi
  if printf '%s' "$marker" | grep -q "claim=${claim} " && printf '%s' "$marker" | grep -q "@${file}"; then
    pass "$h attestation matches (claim=${claim} @${file})"
  else
    bad "$h DRIFT: instrument claim=${claim} file=${file} vs marker '${marker}'"
  fi
done

[ "$fail" -eq 0 ] && echo "[test_verify] PASS" || echo "[test_verify] FAIL"
exit "$fail"
