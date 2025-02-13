# WiRoHSH - Wick-rotated hyper-spherical harmonics

## Introduction

In order to solve the wave equation

$$ \Delta f(\vec r, t) - \frac1{c^2}\partial_t^2 f(\vec r, t) = 0 \tag{wave} $$

one typical approach is using a separation of variables

$$ f(\vec r, t) = R(r)\cdot T(t) $$

to obtain

$$ \underbrace{\frac{c^2}{R(\vec r)}\Delta R(\vec r)}_{\text{constant in }t} = \underbrace{\frac1{T(t)}\partial_t^2 T(t)}_{\text{constant in }\vec r} = \underbrace{-\omega^2}_{\stackrel{\text{therefore}}{\text{constant}}}$$

and thus

$$ T(t) = \int_{-\infty}^\infty \tilde T(\omega) e^{i\omega t}, \tag{Fourier} $$

i.e. the Fourier transform and resulting in the Helmholtz equation for the spatial part:

$$ \Delta R(\vec r) + k^2 R(\vec r) = 0\quad\text{where}\quad k^2 = \frac{\omega^2}{c^2}. $$

While the frequency $\omega$ has a very physical meaning, for computational applications it is rather disadvantageous that a continuous variable has to be considered.

Contrast this to the derivation of Solid Harmonics (solving the Laplace equation $\Delta f(\vec r) = 0$ in spherical coordinates), which thanks to periodicity constraints on a shell only have discrete indices. Can this not also be applied to the wave equation somehow?

### The Wick-rotation

If time $t$ is replaced by a imaginary coordinate $\tau$ by $c$, i.e.

$$ c\cdot t = i\cdot\tau \Rightarrow -\frac1{c^2}\partial_t^2 = \partial_\tau^2, \tag{Wick} $$

the $n$-dimensional wave-equation transforms into the $(n+1)$-dimensional Laplace equation if the additional coordinate $\tau$ is considered real instead. That equations is solved by the discrete base functions of hyperspherical functions. If the Wick-rotation is then reversed, a discrete set of solutions of the wave equation is obtained. But what is getting lost in contrast to the continuous Fourier base? Let's see...

## 1D

Let's start simpler first. The one-dimensional wave equation

$$ \partial_x^2 f(x,t) - \frac1{c^2}\partial_t^2 f(x,t) = 0 $$

Wick-rotates into the 2D Laplace equation

$$ \partial_x^2 f(x,y) + \partial_y^2 f(x,y) $$

if we name the imaginary time $y$ for convenience. Transforming this to polar coordinates $(r,\varphi)$ (such that $(x,y) = r\cdot(\cos\varphi, \sin\varphi)$) yields

$$ \frac1r\partial_r(r\partial_r f(r,\varphi)) + \frac1{r^2} \partial_\varphi^2 f(r,\varphi) = 0 $$

which can be variable-separated into

$$ (r\partial_r)^2 R(r) = -\frac1{\Phi(\varphi)}\partial_\varphi\Phi(\varphi) = m^2. $$

This can be solved to

$$ \Phi_m(\varphi) = e^{im\varphi},\quad m\in\mathbb Z $$

where the discreteness of $m$ is a result of requiring $\Phi(\varphi+2\pi) = \Phi(\varphi)$. For any given $m$, there are two radial solutions

$$ R_m^\pm (r) = r^{\pm m}, $$

so the general solution is

$$ f(r,\varphi) = \sum_{m=-\infty}^\infty f_m^+\cdot (r e^{i\varphi})^m + f_m^-\cdot (re^{-i\varphi})^m $$

(where the summation has been reordered for convenience). Noting that $re^{i\varphi} = x + iy =: z$ and $re^{-i\varphi} = \bar z$ being $z$'s complex conjugate, this is transformed back to cartesian coordinates:

$$ f(x,y) = \sum_{m=-\infty}^\infty f_m^+\cdot z^m + f_m^-\cdot \bar z^m =: f^+(z) + f^-(\bar z)$$

Those are actually two Laurent series for holomorphic functions in $z$ and $\bar z$ respectively, which shouldn't come as a surprise given the connection between the two-dimensional Laplace equation and the Cauchy-Riemann equations.

Wick-rotating back $z = x - ct$ and $\bar z = x + ct$ the final solution is

$$ f(x,t) = f^+(x-ct) + f^-(x+ct) $$

which shows $f^\pm$ are just the two forward and backward propagating components of a one-dimensional wave. While this solution is actually valid for any function, even discontinuous ones for example, the detour to the discrete Laurent series did impose the condition of being holomorphic to the two waves. In smooth regions those are perfectly sufficient, however the question is what happens to non-holomorphic parts in this approach.