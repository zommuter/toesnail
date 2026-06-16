---
title: WiRoHSH
permalink: /WiRoHSH
---

# WiRoHSH - Wick-rotated hyper-spherical harmonics

## Introduction

In order to solve the $d$-dimensional wave equation

$$ \Delta f(\vec r, t) - \frac1{c^2}\partial_t^2 f(\vec r, t) = 0 \tag{wave} $$

one typical approach is using a separation of variables

$$ f(\vec r, t) = R(r)\cdot T(t) $$

to obtain

$$ \underbrace{\frac{c^2}{R(\vec r)}\Delta R(\vec r)}_{\text{constant in }t} = \underbrace{\frac1{T(t)}\partial_t^2 T(t)}_{\text{constant in }\vec r} = \underbrace{-\omega^2}_{\stackrel{\text{therefore}}{\text{constant}}}$$

and thus

$$ T(t) = \int_{-\infty}^\infty \tilde T(\omega) e^{i\omega t}, \tag{Fourier} $$

i.e. the Fourier transform and resulting in the Helmholtz equation for the spatial part:

$$ \Delta R(\vec r) + k^2 R(\vec r) = 0\quad\text{where}\quad k^2 = \frac{\omega^2}{c^2}. \tag{Helmholtz} $$

While the frequency $\omega$ has a very physical meaning, for computational applications it is rather disadvantageous that a continuous variable has to be considered.

Contrast this to the derivation of Solid Harmonics (solving the Laplace equation $\Delta f(\vec r) = 0$ in spherical coordinates), which thanks to periodicity constraints on a shell only have discrete indices. Can this not also be applied to the wave equation somehow?

### The Wick-rotation

If time $t$ is replaced by a imaginary coordinate $\tau$ by $c$, i.e.

$$ c\cdot t = i\cdot\tau \Rightarrow -\frac1{c^2}\partial_t^2 = \partial_\tau^2, \tag{Wick} $$

the $n$-dimensional wave-equation transforms into the $(n+1)$-dimensional Laplace equation if the additional coordinate $\tau$ is considered real instead. That equation is solved by the discrete base set of hyperspherical functions. If the Wick-rotation is then reversed, a discrete set of solutions of the wave equation is obtained. But what is getting lost in contrast to the continuous Fourier base? Let's see...

## 1D

Let's start simpler first. The one-dimensional ($d=1$) wave equation

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

### A seemingly misleading generalization

The 1D solution obtained this way directly suggests a generalized solution

$$ f(\vec x, t) \stackrel?= \oint\limits_{|\vec e|=1}d^3e\ \tilde f(\vec e, \vec x +\vec e\,ct)$$

of splitting the solution into components moving into all possible directions $\vec e$. But note how

$$\begin{align*} \partial_t f(\vec x, t) &= \oint\limits_{|\vec e|=1} d^3e\ c (\vec e\vec\nabla) \tilde f(\vec e, \vec x+\vec e\, ct)
\\ \partial_t^2 f(\vec x, t) &= c^2 \oint\limits_{|\vec e|=1}d^3\ (\vec e\vec\nabla)^2 \tilde f(\vec e, \vec x+ \vec e\, ct) \end{align*}$$

does not solve the wave equation in general since

$$ (\vec e\vec\nabla)^2 = \underbrace{\vec e^2}_{=1]}\,\underbrace{\vec\nabla^2}_{=\Delta} - \underbrace{(\vec e\wedge\vec\nabla)^2}_{\neq 0}\quad (d\neq 1)
$$

so the additional restriction

$$ (\Delta - (\vec e\,\vec\nabla)^2) \tilde f(\vec e,\vec x) = 0$$

is required, i.e. the directional base functions must obey the $(d-1)$-dimensional Laplace equation in the (hyper)plane transversal to $\vec e$.

Now the peculiar thing about this approach is that by applying the Wick rotation to turn the $d$-dimensional wave equation into a $(d+1)$-dimensional Laplace equation

$$ (\Delta + \partial_\tau^2) f(\vec x, \tau) = 0 \tag{Laplace}$$

the just-derived solution can also be applied. In other words, the Laplace equation can be solved as the superposition of solutions two dimensions lower!

Without loss of generality, let's pick the last dimension as direction to eliminate via Wick-Rotation and let $\vec x_{d+1} = (\vec x, \tau)$. Then _(Laplace)_ is solved by

$$\begin{align*}
  f(\vec x, \tau) &= \oint_{|\vec e|=1} f_{\vec e}(\vec x + i\vec e \tau)
\\\text{where}\ 0 &= \Delta_{\vec e} f_{\vec e}(\vec x)
\end{align*}$$

with $\Delta_{\vec e} = \Delta - (\vec e\cdot\vec\nabla)^2$ denoting the $(d-1)$-dimensional Laplacian tangential to $\vec e$. Let's consider $\vec e = \vec e_d$ and denote $\vec x = (\vec x', x_d)$.

---

Let's see how this work. For the 2D Laplace equation

$$(\partial_x^2+\partial_y^2) f(x,y) = 0$$

Wick-rotate $y$ to obtain

$$\begin{align*}
  f(x,y) &= \sum_{e = \pm 1} f_e(x + iey)
\end{align*}$$

Note how in this case $f_e(x)$ would have to solve the zero-dimensional Laplace equation, which is trivially fulfilled, so any $f_e$ is acceptable and the solution from before the generalization is obtained.

Next, let's consider 3D

$$(\partial_x^2 + \partial_y^2 + \partial_z^2) f(x,y,z) = 0$$

and eliminate the $z$ coordinate to obtain

$$\begin{align*}
  f(x,y,z) &= \int_0^{2\pi}d\phi\ f_\phi\Big(\underbrace{\begin{pmatrix}x\\y\end{pmatrix}}_{=:\vec x} + iz\underbrace{\begin{pmatrix}\cos\phi \\ \sin\phi\end{pmatrix}}_{=:\vec e_\phi}\Big)
\end{align*}$$

First, consider $\phi=\frac\pi2$ to obtain

$$\begin{align*}
  \partial_x^2 f_{\frac\pi2}(x,y) &= 0 \Rightarrow f_{\frac\pi2}(x,y) = a_{\frac\pi2}(y)+b_{\frac\pi2}(y)\cdot x
\end{align*}$$

Let $x_\phi := \vec e_\phi\cdot \vec x = x\cos\phi + y\sin\phi$ and $x_{\bar\phi} := x\sin\phi - y\cos\phi$ (and $\vec e_{\bar\phi} = (\sin\phi, -\cos\phi)$). Note how 

$$\begin{align*}
  \Delta_\phi &= \Delta - \partial_\phi^2 = \partial_x^2 + \partial_y^2 - (\partial_x\cos\phi + \partial_y\sin\phi)^2
\\ &= \partial_x^2\sin^2\phi + \partial_y^2\cos^2\phi - 2\partial_x\partial_y\cos\phi\sin\phi
\\ &= (\partial_x\sin\phi - \partial_y\cos\phi)^2 = \partial_{\bar\phi}^2
\end{align*}$$

to obtain

$$f_\phi(\vec x) = a_\phi(x_\phi) + b_\phi(x_\phi)\cdot x_{\bar\phi},$$

i.e. $f_\phi$ must be linear in the tangential direction but can be arbitrary in the parallel direction. Next note

$$\begin{align*}
  (\vec x + iz\vec e_\phi)_\phi &= x_\phi + iz,
\\ (\vec x +iz\vec e_\phi)_{\bar\phi} &= x_{\bar\phi}
\end{align*}$$

Thus

$$\begin{align*}
  f_\phi\left(\begin{pmatrix}x+iz\cos\phi \\ y + iz\sin\phi\end{pmatrix}\right) &= a_\phi(x_\phi+iz) + b_\phi(x_\phi+iz)\cdot x_{\bar\phi}
\end{align*}$$

and finally

$$\begin{align*}
  f(x,y,z) &= \int_0^{2\pi}d\phi\ \Big(\Big)
\end{align*}$$

$$\begin{align*}
\end{align*}$$

### Refraction
