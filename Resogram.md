---
title: Resogramm
permalink: /Resogramm
---

Kinda part of my [Theory of Everything - Some Novel Approach Including Love ❤️ – Math on Demand Edition](./)
[![](img/cc-by-nc-sa-88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

Consider a simple mass on a spring system, yielding a driven harmonic oscillator

$
\ddot x + 2\beta \dot x + \omega^2 (x-y) = 0
$

It is of course possible to solve this with some analysis:

$
x(t) = A\cos\Big(\underbrace{\sqrt{\omega^2-\beta^2}}_{=:\Omega}t+\phi\Big)e^{-\beta t} + \int_{-\infty}^t\frac{\omega^2}{\Omega}\sin(\Omega (t-t')e^{-\beta(t-t')} y(t')\, dt'
$

But that's too verbose for now. Let's instead consider the time evolution of the specific energy:

$
  e = \frac12\dot x^2 + \frac{\omega^2}2 x^2,
\\ \dot e = \dot x\cdot(\underbrace{\ddot x}_{=-2\beta\dot x-\omega^2(x-y)} + \omega^2 x) = \dot x\cdot(-2\beta\dot x + \omega^2 y  )
\\ = \underbrace{-2\beta\dot x^2}_{\le 0} + \omega^2\dot x y = -4\beta e - \omega^2(2\beta x^2 - \dot x y)
$

Even without the analytical solution it would be clear that a free oscillator ($y=0$) would permanently loose energy for $\beta\neq0$. Now one interesting question is what kind of drive $y$ is needed in order to keep the energy constant, i.e. $\dot e=0$. Since $\dot x\neq 0$ that means

$
  y = 2\frac{\beta}{\omega^2}\dot x
$

There is one solution independent of $\dot x$:

$
  \dot y = 2\frac{\beta}{\omega^2}\ddot x = -4\frac{\beta^2}{\omega^2}\dot x - 2\beta(x-y) = -2\beta y -2\beta(x-y) = -2\beta x,
\\ \ddot y = -2\beta\dot x = -\omega^2 y
$

So, by swinging at exactly the free frequency $\omega$ (and not the eigenfrequency $\Omega$) the oscillator will maintain its energy. What if instead we want to increase the energy of the system? As seen above, $\dot e>0$ if $y\dot x > 2\beta/\omega^2\dot x^2$, i.e. $|y|>2\beta/\omega^2|\dot x|$ and $y$ has the same sign as $\dot x$. In words, one has to pull in movement direction, but stop at the apex to start pushing and vice versa – which is precisely what intuition causes us to do.

Another question is how much change of energy does the external force contribute. Without the analytical solution there might be some handwaving about how $\dot e$ varies between zero and $-4\beta e$ in the absence of external forces, thus averaging to $\dot e\approx -2\beta e$. But I'll just use the analytical solution now, which boils down to confirming that: $e\propto (c+\cos^2(\Omega t+\phi))e^{-2\beta t}$ . I'm too lazy to check whether $c=0$, doesn't matter anyway. The point is that this hints at a sensible sliding average:

$
  \bar e(t) := 2\Omega\int_0^{\frac1{2\Omega}} e(t-t')e^{+2\beta t'}\,dt'
$
