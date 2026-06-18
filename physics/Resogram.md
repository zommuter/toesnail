---
title: Resogram
permalink: /Resogram
---

Kinda part of my [Theory of Everything - Some Novel Approach Including Love ❤️ – Math on Demand Edition](./)
[![](img/cc-by-nc-sa-88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

Consider a simple mass on a spring system, yielding a driven harmonic oscillator

$$
\ddot x + 2\beta \dot x + \omega^2 (x-y) = 0 \veq{eom}\assumption
$$

It is of course possible to solve $\eqref{eom}$ with some analysis:

$$
x(t) = A\cos\Big(\underbrace{\sqrt{\omega^2-\beta^2}}_{=:\Omega}t+\phi\Big)e^{-\beta t} + \int_{-\infty}^t\frac{\omega^2}{\Omega}\sin(\Omega (t-t'))e^{-\beta(t-t')} y(t')\, dt' \veq{sol}\sorry
$$

<!-- verify:sympy [sol] the solution x(t) solves eom; Ω:=√(ω²−β²). inst=verify/resogram_sol.py.
     Finding (✓ partial): x_h solves the homogeneous ODE and the convolution kernel satisfies
     K(0)=0, K'(0)=ω², K''+2βK'+ω²K=0, so by the Leibniz rule ẍ+2βẋ+ω²(x−y)=0 — see docs/rigor-debt.md.
     NOTE for owner: the integrand paren-balance typo (missing `)` after `(t-t')`) was owner-ratified
     and fixed 2026-06-15 via /relay human; the integrand now reads sin(Ω(t−t'))·e^{−β(t−t')}. -->

But that's too verbose for now. Let's instead consider the time evolution of the specific energy:

$$
  e = \frac12\dot x^2 + \frac{\omega^2}2 x^2 \veq{e}\definition
$$

$$
\begin{aligned}
  \dot e &= \dot x\cdot(\underbrace{\ddot x}_{=-2\beta\dot x-\omega^2(x-y)} + \omega^2 x) \veqs{edot_deriv}\lean
  \\ &= \dot x\cdot(-2\beta\dot x + \omega^2 y) %\ltag{edot.2}
  \\ &= \underbrace{-2\beta\dot x^2}_{\le 0} + \omega^2\dot x y %\ltag{edot.3}
  \\ &= -4\beta e + \omega^2(2\beta x^2 + \dot x y) \veqs{edot}\sympylean
\end{aligned} \tag{edot}
$$

<!-- [edot] energy-rate chain: ė=ẋ(ẍ+ω²x)=−2βẋ²+ω²ẋy = −4βe+ω²(2βx²+ẋy). inst=verify/resogram_edot.py.
     RESOLVED 2026-06-15 (owner-ratified via /relay human): the located sign discrepancy on the SECOND
     equality was confirmed and the source corrected to ė = −4βe + ω²(2βx² + ẋy). Instrument RE-PINNED
     2026-06-15 (/relay review): resogram_edot.py now verifies the corrected closed form end-to-end
     (verdict ✓). Attestation (claim/by hashes) now lives in physics/Resogram.toml [edot] (a9d2 migration
     2026-06-18); the in-prose badge is \veqs{edot}\sympylean. edot_deriv (\veqs{edot_deriv}\lean) is the
     derivative sub-step, attested in [edot_deriv]. See docs/rigor-debt.md. -->

Even without the analytical solution it would be clear from (edot.3) that a free oscillator ($y=0$) would permanently loose energy for $\beta\neq0$. Now one interesting question is what kind of drive $y$ is needed in order to keep the energy constant, i.e. $\dot e=0$. Since $\dot x\neq 0$ that means

$$
  y = 2\frac{\beta}{\omega^2}\dot x \veq{ymaint}\sympy
$$

<!-- [ymaint/yfree] energy-maintaining drive y=2(β/ω²)ẋ and its ẋ-independent solution ẏ=−2βx, ÿ=−ω²y.
     inst=verify/resogram_drive.py (verifies eq ymaint + yfree jointly). Finding (✓): confirmed — drive at
     the free frequency ω, not the eigenfrequency Ω. Attestation now in physics/Resogram.toml [ymaint] and
     [yfree] (same instrument; handle ymaint kept per a9d2 fork A 2026-06-18, instrument file is
     resogram_drive.py). In-prose badges: \veq{ymaint}\sympy, \veq{yfree}\sympy. -->

There is one solution independent of $\dot x$:

$$
\begin{aligned}
  \dot y &= 2\frac{\beta}{\omega^2}\ddot x = -4\frac{\beta^2}{\omega^2}\dot x - 2\beta(x-y) = -2\beta y -2\beta(x-y) = -2\beta x, \\
  \ddot y &= -2\beta\dot x = -\omega^2 y
\end{aligned} \veq{yfree}\sympy
$$

So, by swinging at exactly the free frequency $\omega$ (and not the eigenfrequency $\Omega$) the oscillator will maintain its energy. What if instead we want to increase the energy of the system? As seen above,

$$
  \dot e > 0 \iff |y| > 2\frac{\beta}{\omega^2}|\dot x| \ \text{with}\ \operatorname{sign} y = \operatorname{sign}\dot x \veq{eincr}\sympy
$$

<!-- prose↔math equivalent: this condition was stated only in the prose above; promoted to a display
     equation here so \veq (equation-only) can carry its attestation. Example of the prose↔mathematical-
     equivalent design question — see mathematical-writing TODO id:ffbe. -->

i.e. one has to pull in movement direction, but stop at the apex to start pushing and vice versa – which is precisely what intuition causes us to do.
<!-- [eincr] energy-increase condition: ė>0 ⟺ |y|>2(β/ω²)|ẋ| with sign(y)=sign(ẋ).
     inst=verify/resogram_eincr.py. Finding (✓): confirmed. Attestation now in physics/Resogram.toml [eincr]
     (a9d2 migration 2026-06-18). -->

> 🚧 **Located rigor-debt** (flagged via `/meeting` 2026-06-15; tracked in `REVIEW_ME.md`) — two items in the energy-method chain above:
> 1. The opening claim that a free oscillator *"would permanently loose energy"* is asserted as obvious, but the cited closed form `edot` (ė = −4βe + ω²(2βx² + ẋy)) is **not manifestly** ≤ 0. *Finding (owner to confirm):* the **first** form ė = −2βẋ² (at y=0) **is** manifestly ≤ 0 — the wording should lean on that form.  
>   **re** okay, explicitly mentioned (edot.3) though we need to fix the `ParseError: KaTeX parse error: Multiple \tag` in an aligned env, and automated dot-numbering of subequation should be on the wishlist...
> 2. The `ymaint` / `yfree` derivation skips steps. Their **results are machine-verified ✓** by `verify/resogram_drive.py` and are unaffected by the `edot` sign fix (which changed only edot's *second* equality, not the first form they derive from) — so this is an **exposition** gap, not a correctness one.  
>   **re** same
>
> *AI flags only — the owner resolves; the math/prose stays untouched.*

Another question is how much change of energy does the external force contribute. Without the analytical solution there might be some handwaving about how $\dot e$ varies between zero and $-4\beta e$ in the absence of external forces, thus averaging to $\dot e\approx -2\beta e$. But I'll just use the analytical solution now, which boils down to:

$$
  e = \frac{A^2\omega}{2}e^{-2\beta t}\Big(\omega + \beta\cos\big(2(\Omega t+\phi)-\delta\big)\Big),\qquad \delta=\operatorname{atan2}(\Omega,\beta) \veq{esol}\numeric
$$

<!-- [esol] e = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ)−δ)), δ=atan2(Ω,β). inst=verify/resogram_esol.py.
     Handle renamed cval→esol 2026-06-15 (/meeting): the old name encoded the now-answered "find c" question;
     esol = the analytical energy SOLUTION. The equation itself is verified ✓ — the OPEN items below are in
     the surrounding prose, not this line.
     RESOLVED 2026-06-15 (owner-ratified via /relay human): the located discrepancy ("is c=0?" → c≠0;
     the (c+cos²θ) form drops a sin(2θ) term) was confirmed and the source now states the exact
     phase-shifted form.
       (1) [DONE — /relay review 2026-06-15] resogram_esol.py (was resogram_cval.py) re-derived: it now
           verifies the adopted exact phase-shifted form (verdict ✓); attestation now in
           physics/Resogram.toml [esol] (a9d2 migration 2026-06-18); in-prose badge \veq{esol}\numeric.
       (2) [STILL OPEN — owner narrative; AI must not edit] the surrounding prose still references the
           now-removed constant c ("varies between zero and −4βe … averaging" ¶ above; "too lazy to check
           whether c=0" ¶ below). Reconcile the c-narrative with the exact form. See docs/rigor-debt.md and
           the located-discrepancy callouts flagged in this file (/meeting 2026-06-15). -->

This hints at a sensible sliding average:

$$
  \bar e(t) := \frac\Omega\pi \int_0^{\frac\pi\Omega} e(t-t')e^{+2\beta t'}\,dt'
$$
