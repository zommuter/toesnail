---
title: Photon
permalink: /Photon
---

Let's try and find a single Photon solution to the wave equation in the Lorentz-gauge ($\partial^\alpha A_\alpha = 0$)

$$ \square A_\mu = J_\mu. $$

with a Gaussian Ansatz

$$\begin{align*}
  A_\alpha(\underline x) &= a_\alpha \exp\Bigg\{-\frac{(x^\nu-\mu_\alpha^\nu(\underline x))^2}{2\sigma_\alpha(\underline x)^2}\Bigg\}
\\\partial^\beta A_\alpha(\underline x) &= A_\alpha(\underline x)\cdot\Bigg(-\frac{(x^\nu - \mu_\alpha^\nu(\underline x))\cdot\Big[\sigma_\alpha(\underline x)\cdot(\eta^\beta_\nu-\partial^\beta \mu_\alpha(\underline x)) - (\partial^\beta\sigma_\alpha(\underline x)\cdot(x_\nu - \mu_{\alpha\nu}(\underline x)) \Big]}{\sigma_\alpha(\underline x)^3}\Bigg)
\end{align*}$$
