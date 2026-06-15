---
title: Resogramm
permalink: /Resogramm
---

Kinda part of my [Theory of Everything - Some Novel Approach Including Love ❤️ – Math on Demand Edition](./)
[![](img/cc-by-nc-sa-88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

Consider a simple mass on a spring system, yielding a driven harmonic oscillator

$$
\ddot x + 2\beta \dot x + \omega^2 (x-y) = 0 \ltag{eom}
$$

It is of course possible to solve $\eqref{eom}$ with some analysis:

$$
x(t) = A\cos\Big(\underbrace{\sqrt{\omega^2-\beta^2}}_{=:\Omega}t+\phi\Big)e^{-\beta t} + \int_{-\infty}^t\frac{\omega^2}{\Omega}\sin(\Omega (t-t')e^{-\beta(t-t')} y(t')\, dt' \ltag{sol}
$$

<!-- verify:sympy [sol] the solution x(t) solves eom; Ω:=√(ω²−β²). inst=verify/resogram_sol.py.
     Finding (✓ partial): x_h solves the homogeneous ODE and the convolution kernel satisfies
     K(0)=0, K'(0)=ω², K''+2βK'+ω²K=0, so by the Leibniz rule ẍ+2βẋ+ω²(x−y)=0 — see docs/rigor-debt.md.
     NOTE for owner: the rendered integrand has an unbalanced paren `\sin(\Omega (t-t')e^{...}` (missing
     `)` after `(t-t')`); the verified kernel is sin(Ω(t−t'))·e^{−β(t−t')}. Surfaced, not edited. -->

But that's too verbose for now. Let's instead consider the time evolution of the specific energy:

$$
\begin{aligned}
  e &= \frac12\dot x^2 + \frac{\omega^2}2 x^2, \\
  \dot e &= \dot x\cdot(\underbrace{\ddot x}_{=-2\beta\dot x-\omega^2(x-y)} + \omega^2 x) = \dot x\cdot(-2\beta\dot x + \omega^2 y) \\
  &= \underbrace{-2\beta\dot x^2}_{\le 0} + \omega^2\dot x y = -4\beta e - \omega^2(2\beta x^2 - \dot x y)
\end{aligned} \ltag{edot}
$$

<!-- verify:sympy [edot] energy-rate chain: ė=ẋ(ẍ+ω²x)=−2βẋ²+ω²ẋy = −4βe−ω²(2βx²−ẋy). inst=verify/resogram_edot.py.
     Finding (✗ located discrepancy): the FIRST equality holds, but the SECOND is off by −4βω²x²;
     the correct closed form is ė = −4βe + ω²(2βx² + ẋy) (sign on the ω²-bracket). Surfaced, not edited;
     owner decides — see docs/rigor-debt.md. -->

Even without the analytical solution it would be clear that a free oscillator ($y=0$) would permanently loose energy for $\beta\neq0$. Now one interesting question is what kind of drive $y$ is needed in order to keep the energy constant, i.e. $\dot e=0$. Since $\dot x\neq 0$ that means

$$
  y = 2\frac{\beta}{\omega^2}\dot x \ltag{ymaint}
$$

<!-- verified:sympy [drive] claim=67223e71 by=resogram_drive.py@9fe74c88 -->
<!-- verify:sympy [drive] energy-maintaining drive y=2(β/ω²)ẋ and its ẋ-independent solution ẏ=−2βx, ÿ=−ω²y
     (eq ymaint + yfree). inst=verify/resogram_drive.py. Finding (✓): confirmed — drive at the free
     frequency ω, not the eigenfrequency Ω. -->

There is one solution independent of $\dot x$:

$$
\begin{aligned}
  \dot y &= 2\frac{\beta}{\omega^2}\ddot x = -4\frac{\beta^2}{\omega^2}\dot x - 2\beta(x-y) = -2\beta y -2\beta(x-y) = -2\beta x, \\
  \ddot y &= -2\beta\dot x = -\omega^2 y
\end{aligned} \ltag{yfree}
$$

So, by swinging at exactly the free frequency $\omega$ (and not the eigenfrequency $\Omega$) the oscillator will maintain its energy. What if instead we want to increase the energy of the system? As seen above, $\dot e>0$ if $y\dot x > 2\beta/\omega^2\dot x^2$, i.e. $|y|>2\beta/\omega^2|\dot x|$ and $y$ has the same sign as $\dot x$. In words, one has to pull in movement direction, but stop at the apex to start pushing and vice versa – which is precisely what intuition causes us to do.
<!-- verified:sympy [eincr] claim=d4c18e3b by=resogram_eincr.py@60891e80 -->
<!-- verify:sympy [eincr] energy-increase condition: ė>0 ⟺ |y|>2(β/ω²)|ẋ| with sign(y)=sign(ẋ).
     inst=verify/resogram_eincr.py. Finding (✓): confirmed. -->

Another question is how much change of energy does the external force contribute. Without the analytical solution there might be some handwaving about how $\dot e$ varies between zero and $-4\beta e$ in the absence of external forces, thus averaging to $\dot e\approx -2\beta e$. But I'll just use the analytical solution now, which boils down to confirming that:

$$
  e\propto (c+\cos^2(\Omega t+\phi))e^{-2\beta t} \ltag{cval}
$$

<!-- verify:numeric [cval] "e ∝ (c+cos²(Ωt+φ))e^{−2βt}; too lazy to check whether c=0." inst=verify/resogram_cval.py.
     Finding (✗ located discrepancy): c ≠ 0. The free-oscillator energy is
     e = (A²/2)e^{−2βt}(ω² + β²cos2θ + βΩ sin2θ) = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ)−δ)), δ=atan2(Ω,β):
     it carries a sin(2θ) term, so no constant c fits the stated form exactly; forcing the cos(2θ) match
     gives c=Ω²/(2β²) (≠0). Surfaced, not edited — owner decides; see docs/rigor-debt.md. -->

I'm too lazy to check whether $c=0$, doesn't matter anyway. The point is that this hints at a sensible sliding average:

$$
  \bar e(t) := 2\Omega\int_0^{\frac1{2\Omega}} e(t-t')e^{+2\beta t'}\,dt'
$$
