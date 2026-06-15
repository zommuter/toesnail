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
x(t) = A\cos\Big(\underbrace{\sqrt{\omega^2-\beta^2}}_{=:\Omega}t+\phi\Big)e^{-\beta t} + \int_{-\infty}^t\frac{\omega^2}{\Omega}\sin(\Omega (t-t'))e^{-\beta(t-t')} y(t')\, dt' \ltag{sol}
$$

<!-- verify:sympy [sol] the solution x(t) solves eom; Ω:=√(ω²−β²). inst=verify/resogram_sol.py.
     Finding (✓ partial): x_h solves the homogeneous ODE and the convolution kernel satisfies
     K(0)=0, K'(0)=ω², K''+2βK'+ω²K=0, so by the Leibniz rule ẍ+2βẋ+ω²(x−y)=0 — see docs/rigor-debt.md.
     NOTE for owner: the integrand paren-balance typo (missing `)` after `(t-t')`) was owner-ratified
     and fixed 2026-06-15 via /relay human; the integrand now reads sin(Ω(t−t'))·e^{−β(t−t')}. -->

But that's too verbose for now. Let's instead consider the time evolution of the specific energy:

$$
\begin{aligned}
  e &= \frac12\dot x^2 + \frac{\omega^2}2 x^2, \\
  \dot e &= \dot x\cdot(\underbrace{\ddot x}_{=-2\beta\dot x-\omega^2(x-y)} + \omega^2 x) = \dot x\cdot(-2\beta\dot x + \omega^2 y) \\
  &= \underbrace{-2\beta\dot x^2}_{\le 0} + \omega^2\dot x y = -4\beta e + \omega^2(2\beta x^2 + \dot x y)
\end{aligned} \ltag{edot}
$$

<!-- verified:sympy [edot] claim=b575864e by=resogram_edot.py@54710d91 -->
<!-- verify:sympy [edot] energy-rate chain: ė=ẋ(ẍ+ω²x)=−2βẋ²+ω²ẋy = −4βe+ω²(2βx²+ẋy). inst=verify/resogram_edot.py.
     RESOLVED 2026-06-15 (owner-ratified via /relay human): the located sign discrepancy on the SECOND
     equality was confirmed and the source corrected to ė = −4βe + ω²(2βx² + ẋy). Instrument RE-PINNED
     2026-06-15 (/relay review): resogram_edot.py now verifies the corrected closed form end-to-end
     (verdict ✓) and test_verify.sh pins edot=✓ with the attestation above. See docs/rigor-debt.md. -->

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

> 🚧 **Located rigor-debt** (flagged via `/meeting` 2026-06-15; tracked in `REVIEW_ME.md`) — two items in the energy-method chain above:
> 1. The opening claim that a free oscillator *"would permanently loose energy"* is asserted as obvious, but the cited closed form `edot` (ė = −4βe + ω²(2βx² + ẋy)) is **not manifestly** ≤ 0. *Finding (owner to confirm):* the **first** form ė = −2βẋ² (at y=0) **is** manifestly ≤ 0 — the wording should lean on that form.
> 2. The `ymaint` / `yfree` derivation skips steps. Their **results are machine-verified ✓** by `verify/resogram_drive.py` and are unaffected by the `edot` sign fix (which changed only edot's *second* equality, not the first form they derive from) — so this is an **exposition** gap, not a correctness one.
>
> *AI flags only — the owner resolves; the math/prose stays untouched.*

Another question is how much change of energy does the external force contribute. Without the analytical solution there might be some handwaving about how $\dot e$ varies between zero and $-4\beta e$ in the absence of external forces, thus averaging to $\dot e\approx -2\beta e$. But I'll just use the analytical solution now, which boils down to confirming that:

$$
  e = \frac{A^2\omega}{2}e^{-2\beta t}\Big(\omega + \beta\cos\big(2(\Omega t+\phi)-\delta\big)\Big),\qquad \delta=\operatorname{atan2}(\Omega,\beta) \ltag{esol}
$$

<!-- verified:numeric [esol] claim=18d3f7a7 by=resogram_esol.py@e6722a73 -->
<!-- verify:numeric [esol] e = (A²ω/2)e^{−2βt}(ω + β cos(2(Ωt+φ)−δ)), δ=atan2(Ω,β). inst=verify/resogram_esol.py.
     Handle renamed cval→esol 2026-06-15 (/meeting): the old name encoded the now-answered "find c" question;
     esol = the analytical energy SOLUTION. The equation itself is verified ✓ — the OPEN items below are in
     the surrounding prose, not this line.
     RESOLVED 2026-06-15 (owner-ratified via /relay human): the located discrepancy ("is c=0?" → c≠0;
     the (c+cos²θ) form drops a sin(2θ) term) was confirmed and the source now states the exact
     phase-shifted form.
       (1) [DONE — /relay review 2026-06-15] resogram_esol.py (was resogram_cval.py) re-derived: it now
           verifies the adopted exact phase-shifted form (verdict ✓); test_verify.sh pins esol=✓ with the
           attestation above.
       (2) [STILL OPEN — owner narrative; AI must not edit] the surrounding prose still references the
           now-removed constant c ("varies between zero and −4βe … averaging" ¶ above; "too lazy to check
           whether c=0" ¶ below). Reconcile the c-narrative with the exact form. See docs/rigor-debt.md and
           the located-discrepancy callouts flagged in this file (/meeting 2026-06-15). -->

> 🚧 **Located rigor-debt** (flagged via `/meeting` 2026-06-15; tracked in `REVIEW_ME.md`) — **c-narrative inconsistency.** The exact form `esol` above contains no constant `c`, yet the sentence below (*"too lazy to check whether c=0"*) and the ¶ before `esol` (*"ė varies between zero and −4βe … averaging to ė ≈ −2βe"*) still reason in terms of the removed `c`. *Finding (owner to confirm):* the exact form's period-average plausibly reproduces the −2β rate the handwaving guessed — promoting it from guess to result.
>
> *AI flags only — the owner authors the reconciled prose.*

I'm too lazy to check whether $c=0$, doesn't matter anyway. The point is that this hints at a sensible sliding average:

$$
  \bar e(t) := 2\Omega\int_0^{\frac1{2\Omega}} e(t-t')e^{+2\beta t'}\,dt'
$$

> 🚧 **Located rigor-debt** (flagged via `/meeting` 2026-06-15; tracked in `REVIEW_ME.md`) — **suspect averaging window.** The upper limit `1/(2Ω)` above is ≈ 0.16 of the `β cos` term's period `π/Ω`, so it is not an obvious full-period average. `git blame`: this line dates to the original commit `0249a41` at **2021-01-31 00:56** (just before 1 AM) and has been carried unchanged since — consistent with the late-night-error hypothesis. Owner to re-derive the intended window.
>
> *AI flags only.*
