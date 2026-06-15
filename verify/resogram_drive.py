# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [drive] — the energy-maintaining drive and its ẋ-independent solution.

Claim (physics/Resogram.md, handles `ymaint`, `yfree`):
    ė = 0, ẋ ≠ 0  ⟹  y = 2(β/ω²)ẋ
    the ẋ-independent solution: ẏ = −2βx,  ÿ = −ω²y
    (drive at the FREE frequency ω, not the eigenfrequency Ω).

Run:  uv run verify/resogram_drive.py
"""
import hashlib
from sympy import symbols, srepr, simplify, solve, Eq

x, xd, xdd, y, beta, omega = symbols("x xd xdd y beta omega", real=True, positive=False)

# ė after substituting the equation of motion (see resogram_edot.py):
edot = -2 * beta * xd**2 + omega**2 * xd * y

# Solve ė = 0 for y, given ẋ ≠ 0 (divide through by ẋ first).
y_maint = solve(Eq(simplify(edot / xd), 0), y)[0]
y_claim = 2 * beta / omega**2 * xd
maint_ok = simplify(y_maint - y_claim) == 0

# ẋ-independent solution: set y = 2β/ω² ẋ, so ẋ = ω²y/(2β).
eom = -2 * beta * xd - omega**2 * (x - y)          # ẍ
yd = 2 * beta / omega**2 * xdd                      # ẏ = 2β/ω² ẍ
yd = yd.subs(xdd, eom)
# substitute the maintenance relation ẋ = ω²y/(2β):
yd = simplify(yd.subs(xd, omega**2 * y / (2 * beta)))
yd_claim = -2 * beta * x
yd_ok = simplify(yd - yd_claim) == 0

# ÿ = −2βẋ = −ω²y
ydd = -2 * beta * xd
ydd = simplify(ydd.subs(xd, omega**2 * y / (2 * beta)))
ydd_claim = -omega**2 * y
ydd_ok = simplify(ydd - ydd_claim) == 0

print("y (maintenance)   :", y_maint, "   matches 2(β/ω²)ẋ:", maint_ok)
print("ẏ                 :", yd, "   matches −2βx:", yd_ok)
print("ÿ                 :", ydd, "   matches −ω²y:", ydd_ok)
print()
if maint_ok and yd_ok and ydd_ok:
    print("VERDICT: ✓  drive relation and ẋ-independent (free-frequency) solution confirmed")
else:
    print("VERDICT: ✗  located discrepancy")

CLAIM = Eq(y, y_claim)
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])
