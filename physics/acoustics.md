---
title: Accoustics
permalink: /Accoustics
---

Kinda part of my [Theory of Everything - Some Novel Approach Including Love ❤️ – Math on Demand Edition](./)
[![](img/cc-by-nc-sa-88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

# Basics

## Conservation of mass (with source term $q$):

$$\partial_t\rho + \vec\nabla(\rho \vec u) = q \tag{$\rho.0$}$$

Use Gauss/Divergence Theorem:

$$\begin{align*}
  Q &= \iiint_V q\,dV = \iiint_V\left[\partial_t\rho + \vec\nabla(\rho\vec u)\right]\,dV
\\ &= \iiint_V \partial_t\rho\,dV + \oiint_{\partial V}(\rho\vec u)\, d\vec n
\end{align*}$$

Use "shoebox" argument at interface to obtain

$$\boxed{\vec n\cdot (\rho\vec u) \quad\text{continuous}} \tag{$\rho\vec u_n$}$$

i.e. conservation of perpendicular momentum, which makes sense.

## Newtonian Navier Stokes:

$$\partial_t\vec u + \underbrace{(\vec u\vec\nabla)\vec u}_{=\frac12\vec\nabla u^2 - \vec u\times\vec\omega} = -\frac1\rho\vec\nabla p + \nu\left[\Delta\vec u + \frac13\vec\nabla(\vec\nabla\vec u)\right] + \vec g \tag{u}$$

## Ideal gas

$$\begin{align*}
  p\underbrace{\cdot V}_{=m/\rho} & = nRT
\\ p &= \underbrace{\frac{nRT}m}_{=:c^2/\gamma}\rho
\\\Rightarrow \frac1\rho \vec\nabla p &= \frac{c^2}\gamma\vec\nabla\ln\rho + \vec\nabla\frac{c^2}\gamma
\end{align*}$$

## From Green's first identity

$$\begin{align*}
  \iiint_V(\psi\vec\nabla\vec\Gamma + \vec\Gamma\vec\nabla\psi)\,dV &= \oiint_{\partial V}\psi\cdot(\vec\Gamma\vec n)d\sigma = \oiint_{\partial V}\psi\vec\Gamma\, d\vec\sigma
\\\vec\Gamma = \vec n \Rightarrow \iiint_V(\vec n\vec\nabla)\psi\,dV &= \oiint_{\partial V} \psi\,d\sigma
\end{align*}$$

## Linearization

$$\rho(\vec x,t) \to\rho_0(\vec x,t) + \rho(\vec x, t), \quad \rho_0\gg\rho, \quad |d\rho_0| \ll |d\rho|$$
analoguously $\vec u$ and $p$ but assume $\vec u_0=0$ (which contradicts $u_0\gg u$ though...):

$$\begin{align*}
  \partial_t\rho + \cancel{\vec u_0\vec\nabla\rho} + \rho_0\vec\nabla\vec u &= q \tag{$\rho.1$}
\\ \partial_t\vec u + \cancel{\underbrace{(\vec u_0\vec\nabla)\vec u}_{\dot= \frac12\vec\nabla(\vec u_0\vec u) - \vec u_0 \times \vec \omega}} &= -\frac1\rho\vec\nabla p + \nu\left[\Delta\vec u + \frac12\vec\nabla(\vec\nabla\vec u)\right] + \vec g
\\\Rightarrow \partial_t\vec\omega
\end{align*}$$

---

## Continuity

Start from the [Helmholtz decomposition](https://en.wikipedia.org/wiki/Helmholtz_decomposition)

$$\vec f(\vec x, t) = \vec\nabla\times\vec a - \vec\nabla\phi$$

for a field $\vec f$ that has no singularities. Any singularity in $\vec a$ (and thus also in its curl) must then be compensated by a corresponding singularity in $\phi$ (or rather its gradient) and vice versa, but since curl and gradient are functionally orthogonal, this is not possible and therefore $\vec a$ and $\phi$ also have no singularities.

Next, note how

$$\begin{align*}
  \iiint_V \vec n\cdot\vec f\,dV &= \iiint_V\Big[ \underbrace{\vec n\cdot(\vec\nabla\times\vec a)}_{=-\vec\nabla(\vec n\times\vec a) + \vec a\cdot(\vec\nabla\times\vec n)} - \underbrace{\vec n\cdot\vec\nabla\phi}_{=\vec\nabla(\vec n\phi) - \phi\vec\nabla\vec n} \Big]\,dV
\\ &= \underbrace{-\iiint_V\vec\nabla\Big[\vec n\times\vec a + \vec n\cdot\phi\Big]\,dV}_{=-\oiint_{\partial V}\Big[\vec n\times\vec a + \vec n\cdot\phi\Big]d\vec\sigma} + \iiint_V\Big[\vec a\cdot(\vec\nabla\times\vec n) + \phi\vec\nabla\vec n\Big]\,dV
\end{align*}$$

for any sufficiently smooth field $\vec n(\vec x,t)$ (and especially a constant unit vector). Consider $V$ a cylinder through some point $\vec z$ symmetrically aligned along $\vec n(\vec z,t)$ of a fixed base area $A$ and height $\epsilon$. For $\epsilon\to0$ the volume $V$ vanishes, and since $\vec f, \vec a, \phi$ and $\vec n$ (and both its curl and divergence) have no singularities, so do all the volume integrations, while the base surface integrals "above" and "below" $\vec z$ (think $\vec x\searrow\vec z$ and $\vec x\nearrow\vec z$) remain for any $A>0$ and must therefore be the same. This means the normal component of the integrant must be the same on both sides of the cylinder and hence be continuous in direction of $\vec n$, and since

$$\vec n\cdot(\vec n\times\vec a + \vec n\cdot\phi) = \underbrace{\vec n\cdot(\vec n\times\vec a)}_{=0} + n^2\phi$$

this means $\phi$ must be continuous in any direction since $\vec n$ was arbitrary. This is not surprising, since any discontinuity in $\phi$ would yield a singularity in $\vec\nabla\phi$, which as discussed above could not be compensated by $\vec\nabla\times\vec a$ to obtain a singularity-free $\vec f$.

Next, consider a rectangle of surface $S$ with its shorter edge of length $\epsilon$ parallel to the same $\vec n$ as before, and the other edge of fixed length $L>\epsilon>0$ in any direction perpendicular to $\vec n$. Calculate

$$\begin{align*}
  \iint_S \vec f\,d\vec \sigma &= \underbrace{\iint_S(\vec\nabla\times\vec a)\,d\vec\sigma}_{=\oint_{\partial S}\vec a\,d\vec\gamma} - \iint_S(\vec\nabla \phi)\,d\vec\sigma
\end{align*}$$

Again, let $\epsilon\to0$ and the surface integrals vanish due to the aforementioned non-singular integrants, such that only the line integral elements perpendicular to $\vec n$ remain, meaning the components of $\vec a$ tangential to $\vec n$, i.e. $\vec n\times\vec a$ is continuous as well. Again, since $\vec n$ was arbitrary, $\vec a$ is also continuous.

And all this is not that surprising since any discontinuity in the potentials would raise singularities in $\vec f$, which can be explained in one sentence instead of all those calculations...