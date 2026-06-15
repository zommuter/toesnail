# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:numeric [esol] — the canonical pilot target: the free-oscillator energy.

Handle renamed cval→esol (2026-06-15, /meeting): the old `cval` name encoded the
now-answered "find the constant c" question; the equation is the analytical energy
SOLUTION, so `esol` (e-solution) is the content-meaningful handle.

Claim (physics/Resogram.md, handle `esol`) — owner-ratified exact form (2026-06-15):
    e = (A²ω/2) e^{−2βt} (ω + β·cos(2(Ωt+φ) − δ)),   δ = atan2(Ω,β).

We compute the exact specific energy of the FREE underdamped oscillator
    x(t) = A cos(Ωt+φ) e^{−βt},   Ω = √(ω²−β²),  y = 0
and confirm it equals the adopted phase-shifted form.

History: the pilot answered the doc's open "is c=0?" question — c ≠ 0; the old
template (c + cos²θ) e^{−2βt} silently dropped a sin(2θ) term. The owner ratified
ADOPTING the exact phase-shifted form via /relay human on 2026-06-15 and the
source now states it. This instrument verifies that exact form (VERDICT ✓).

Ω is carried as an INDEPENDENT positive symbol with ω² = Ω² + β² so SymPy can
crunch the double-angle algebra without a nested square root.

Run:  uv run verify/resogram_esol.py
Emits a finding only; it never edits the theory.
"""
import hashlib
from sympy import (symbols, srepr, simplify, cos, sin, exp, diff, sqrt,
                   Rational, expand_trig, expand, atan2)

t, A, phi, beta, Omega = symbols("t A phi beta Omega", positive=True)
omega_sq = Omega**2 + beta**2            # ω² = Ω² + β²
omega = sqrt(omega_sq)
theta = Omega * t + phi

x = A * cos(theta) * exp(-beta * t)
xdot = diff(x, t)
e = Rational(1, 2) * xdot**2 + Rational(1, 2) * omega_sq * x**2

# Strip the common envelope e^{−2βt}; what's left is the bracket the claim describes.
bracket = simplify(e * exp(2 * beta * t) / (A**2 / 2))
print("e·e^{+2βt}/(A²/2) =", bracket)

# Exact double-angle decomposition (SymPy-verifiable):  ω² + β²·cos(2θ) + βΩ·sin(2θ).
target = omega_sq + beta**2 * cos(2 * theta) + beta * Omega * sin(2 * theta)
# expand() opens the squared sum; expand_trig() drops target to single angles;
# simplify() applies cos²+sin²=1 to the leftover Ω²(cos²θ+sin²θ−1) residual.
decomp_ok = simplify(expand(bracket) - expand_trig(target)) == 0

# Owner-ratified ADOPTED form: collapse β²cos2θ + βΩsin2θ = βω·cos(2θ−δ), δ=atan2(Ω,β),
# so the bracket = ω² + βω·cos(2θ−δ) = ω(ω + β·cos(2θ−δ)).  Hence
#     e = (A²ω/2) e^{−2βt} (ω + β·cos(2(Ωt+φ) − δ)).
delta = atan2(Omega, beta)
adopted_bracket = omega * (omega + beta * cos(2 * theta - delta))
# R·cos(2θ−δ) with R=βω, δ=atan2(Ω,β) expands to R(cosδ cos2θ + sinδ sin2θ)
# = βω(β/ω cos2θ + Ω/ω sin2θ) = β²cos2θ + βΩsin2θ — equal to `target − ω²`.
adopted_ok = simplify(expand_trig(adopted_bracket) - expand_trig(target)) == 0

print("exact decomposition ω²+β²cos2θ+βΩsin2θ          :", decomp_ok)
print("adopted phase-shifted form ω(ω+β·cos(2θ−δ)) ok  :", adopted_ok)
print()
if decomp_ok and adopted_ok:
    print("VERDICT: ✓  free-oscillator energy matches the adopted exact form")
    print("  e = (A²ω/2) e^{−2βt} (ω + β·cos(2(Ωt+φ) − δ)),  δ = atan2(Ω,β).")
    print("  (Resolves the doc's old 'is c=0?': c ≠ 0 — the superseded template")
    print("   (c + cos²θ) e^{−2βt} dropped a sin(2θ) term; no constant c reproduces it.)")
else:
    print("VERDICT: ✗  adopted form does not match the energy — re-check Resogram.md handle esol")

# Attestation hash for the adopted bracket ω(ω + β·cos(2θ−δ)).
CLAIM = adopted_bracket
print("\nCLAIM_SREPR (adopted exact form) :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])
