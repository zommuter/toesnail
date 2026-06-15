# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [eincr] — the energy-increase condition.

Claim (physics/Resogram.md, handle `eincr`):
    ė > 0  ⟺  yẋ > 2(β/ω²)ẋ²,
    equivalently  |y| > 2(β/ω²)|ẋ|  AND  sign(y) = sign(ẋ).

Run:  uv run verify/resogram_eincr.py
"""
import hashlib
from sympy import symbols, srepr, simplify, Eq

xd, y, beta, omega = symbols("xd y beta omega", real=True)
omega_pos, beta_pos = symbols("omega beta", positive=True)

edot = -2 * beta * xd**2 + omega**2 * xd * y

# (1) ė > 0  ⟺  ω²ẋy > 2βẋ²  ⟺  ẋy > 2(β/ω²)ẋ²   (ω² > 0, so dividing preserves the sense)
lhs = edot                                   # > 0
rhs_form = omega**2 * (xd * y - 2 * beta / omega**2 * xd**2)
equiv_ok = simplify(lhs - rhs_form) == 0     # ė = ω²·(ẋy − 2β/ω²·ẋ²)

# (2) sufficiency of the magnitude+sign statement, checked on both sign branches.
# Same sign, |y| > 2β/ω²|ẋ|: take ẋ=a>0, y=b>0 with b > 2β/ω² a  ⇒  ė>0.
a, b = symbols("a b", positive=True)
sub = {xd: a, y: b, beta: beta_pos, omega: omega_pos}
edot_pp = edot.subs(sub)                      # = -2β a² + ω² a b
# at the boundary b0 = 2β/ω² a, ė = 0; for b > b0, ė increases linearly in b:
b0 = 2 * beta_pos / omega_pos**2 * a
boundary_zero = simplify(edot_pp.subs(b, b0)) == 0
slope_pos = simplify(edot_pp.diff(b) - omega_pos**2 * a) == 0   # ∂ė/∂y = ω²ẋ > 0
# opposite sign (y=-b) always fails the strict inequality:
edot_pm = edot.subs({xd: a, y: -b, beta: beta_pos, omega: omega_pos})
opp_neg = bool(simplify(edot_pm).is_negative)   # = −2βa² − ω²ab, manifestly < 0

print("ė = ω²(ẋy − 2β/ω²·ẋ²) identity     :", equiv_ok)
print("boundary |y|=2β/ω²|ẋ| gives ė=0    :", boundary_zero)
print("ė increases past the boundary      :", slope_pos)
print("opposite signs ⇒ ė < 0             :", opp_neg)
print()
if equiv_ok and boundary_zero and slope_pos and opp_neg:
    print("VERDICT: ✓  increase condition |y|>2(β/ω²)|ẋ| with matching sign confirmed")
else:
    print("VERDICT: ✗  located discrepancy")

CLAIM = Eq(edot, omega**2 * (xd * y - 2 * beta / omega**2 * xd**2))
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])
