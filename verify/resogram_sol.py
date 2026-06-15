# /// script
# requires-python = ">=3.10"
# dependencies = ["sympy"]
# ///
"""verify:sympy [sol] — the analytical solution solves the driven oscillator ODE.

Claim (physics/Resogram.md, handle `sol`):
    x(t) = A cos(Ωt+φ) e^{−βt}
           + ∫_{−∞}^{t} (ω²/Ω) sin(Ω(t−t')) e^{−β(t−t')} y(t') dt',   Ω := √(ω²−β²)
solves   ẍ + 2βẋ + ω²(x − y) = 0.

Strategy:
  • homogeneous part  x_h: substitute back directly.
  • convolution part  x_p = ∫_{−∞}^t K(t−t') y(t') dt',  K(τ) = (ω²/Ω) sin(Ωτ) e^{−βτ}:
    the Leibniz rule reduces (∂ₜ²+2β∂ₜ+ω²)x_p to the boundary terms plus
    ∫ (K''+2βK'+ω²K) y dt'.  We verify the kernel facts that make this = ω²y:
        K(0)=0,  K'(0)=ω²,  K''+2βK'+ω²K = 0,
    whence ẍ_p+2βẋ_p+ω²x_p = K'(0)·y = ω²y, i.e. ẍ+2βẋ+ω²(x−y)=0.

Run:  uv run verify/resogram_sol.py
"""
import hashlib
from sympy import symbols, srepr, simplify, Eq, sqrt, sin, cos, exp, diff

t, tau, A, phi, beta, omega = symbols("t tau A phi beta omega", positive=True)
Omega = sqrt(omega**2 - beta**2)

# --- homogeneous part ---
xh = A * cos(Omega * t + phi) * exp(-beta * t)
hom_residual = simplify(diff(xh, t, 2) + 2 * beta * diff(xh, t) + omega**2 * xh)
hom_ok = hom_residual == 0

# --- convolution kernel facts ---
K = (omega**2 / Omega) * sin(Omega * tau) * exp(-beta * tau)
K0 = simplify(K.subs(tau, 0))                       # expect 0
Kp0 = simplify(diff(K, tau).subs(tau, 0))           # expect ω²
kernel_ode = simplify(diff(K, tau, 2) + 2 * beta * diff(K, tau) + omega**2 * K)  # expect 0

K0_ok = K0 == 0
Kp0_ok = simplify(Kp0 - omega**2) == 0
kernel_ode_ok = kernel_ode == 0

print("homogeneous residual          :", hom_residual, "  → solves homogeneous ODE:", hom_ok)
print("kernel K(0)                   :", K0, "  (= 0:", K0_ok, ")")
print("kernel K'(0)                  :", Kp0, "  (= ω²:", Kp0_ok, ")")
print("kernel K''+2βK'+ω²K           :", kernel_ode, "  (= 0:", kernel_ode_ok, ")")
print()
if hom_ok and K0_ok and Kp0_ok and kernel_ode_ok:
    print("VERDICT: ✓  x_h solves the homogeneous ODE; the convolution kernel satisfies")
    print("            K(0)=0, K'(0)=ω², K''+2βK'+ω²K=0, so by the Leibniz rule")
    print("            ẍ+2βẋ+ω²x = ω²y, i.e. x = x_h + x_p solves ẍ+2βẋ+ω²(x−y)=0.")
else:
    print("VERDICT: ✗  located discrepancy")

CLAIM = Eq(diff(xh, t, 2) + 2 * beta * diff(xh, t) + omega**2 * xh, 0)
print("\nCLAIM_SREPR :", srepr(CLAIM))
print("CLAIM_HASH8 :", hashlib.sha256(srepr(CLAIM).encode()).hexdigest()[:8])
