# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:numeric [cval] — the canonical pilot target: determine c.

Claim (physics/Resogram.md, handle `cval`):
    "e ∝ (c + cos²(Ωt+φ)) e^{−2βt};  too lazy to check whether c = 0."

We compute the exact specific energy of the FREE underdamped oscillator
    x(t) = A cos(Ωt+φ) e^{−βt},   Ω = √(ω²−β²),  y = 0
and test whether it has the claimed form.

Ω is carried as an INDEPENDENT positive symbol with ω² = Ω² + β² so SymPy can
crunch the double-angle algebra without a nested square root.

Run:  uv run verify/resogram_cval.py
Emits a finding only; it never edits the theory.
"""
import hashlib
from sympy import (symbols, srepr, simplify, cos, sin, exp, diff,
                   Rational, expand_trig, expand)

t, A, phi, beta, Omega = symbols("t A phi beta Omega", positive=True)
omega_sq = Omega**2 + beta**2            # ω² = Ω² + β²
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

# The claimed template κ(c + cos²θ) = κc + κ/2 + (κ/2)cos(2θ) has NO sin(2θ) term.
# Coefficient of sin(2θ) in the true bracket is βΩ ≠ 0 for β,Ω > 0  ⇒  no exact fit.
sin_coeff = beta * Omega
# Matching the cos(2θ) coefficient anyway: κ/2 = β² ⇒ κ = 2β²; constant κc+κ/2 = ω²:
kappa = 2 * beta**2
c_value = simplify((omega_sq - kappa / 2) / kappa)   # = Ω²/(2β²)

print("exact decomposition ω²+β²cos2θ+βΩsin2θ :", decomp_ok)
print("coefficient of sin(2θ) (must be 0 for the claimed form) :", sin_coeff, " ≠ 0")
print("c forced by matching the cos(2θ) coefficient            :", c_value, " = Ω²/(2β²)")
print()
print("VERDICT: ✗  located discrepancy — the claimed form is not exact for β ≠ 0.")
print("  • The true energy carries a sin(2θ) term (coeff βΩ ≠ 0); the template (c + cos²θ)")
print("    has a zero-phase cos(2θ) only, so NO constant c reproduces it exactly.")
print("  • Even forcing a match on the cos(2θ) coefficient gives c = Ω²/(2β²) ≠ 0, not c = 0.")
print("  • The clean exact statement (phase-shifted form) is")
print("      e = (A²ω/2) e^{−2βt} (ω + β·cos(2(Ωt+φ) − δ)),  δ = atan2(Ω,β),")
print("    since β²cos2θ + βΩsin2θ = βω·cos(2θ−δ) with amplitude √(β⁴+β²Ω²) = βω.")
print("  • So the honest answer to 'is c=0?' is NO — and the stated form needs a phase term.")

# No attestation hash: this claim is a located discrepancy (✗); it stays a verify: marker.
print("\nCLAIM_SREPR (verified decomposition) :", srepr(target))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(target).encode()).hexdigest()[:8])
