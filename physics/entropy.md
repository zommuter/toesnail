---
title: Entropy
permalink: /Entropy
---

Given a system of $N$ states of energies $E_k$ for $k\in\{0,2,...,N-1\}$, it straightforward to maximize the entropy

$$ S_B := \underbrace{-\sum_{k=0}^{N-1} p_k \ln p_k}_{=-\langle\ln p_k\rangle} + \alpha(1-\langle 1\rangle) + \beta(E - \langle E_k\rangle)\quad \text{where } \langle x_k\rangle := \sum_{k=0}^{N-1} x_k p_k $$

(with Lagrange factors $\alpha, \beta$ to ensure $p_k$ are probabilities and the system's energy is $E$) to obtain state $k$'s probability $p_k = Z_k / Z_B$ with $Z_k=\exp(-\beta E_k)$ and $Z_B=\sum_k Z_k$, yielding the Boltzmann distribution with energy

$$ E = \frac1{Z_B}\sum_{k=0}^{N-1} \underbrace{E_k e^{-\beta E_k}}_{=-\partial_\beta Z_k} = -\partial_\beta \ln Z_B. $$

For linear energies $E_k = k\cdot E_1$ this simplifies to $Z_k = e^{-\beta k E_1} = Z_1^k,\ Z_B=\sum\limits_{k=0}^{N-1} Z_1^k = \frac{1-Z_1^{N}}{1-Z_1}$ and $p_k = Z_1^k/Z_B = Z_1^k\frac{1-Z_1}{1-Z_1^N}.$ For the total energy we obtain

$$\begin{align}
 E/E_1 &= \sum_{k=0}^{N-1} p_k k = \langle k\rangle= \frac{Z_1}{Z_B} \sum_{k=0}^{N-1} \underbrace{kZ_1^{k-1}}_{=\frac{d}{dZ_1}Z_1^k} = \frac{Z_1}{Z_B}\frac{d}{dZ_1}\underbrace{\sum_{k=0}^{N-1} Z_1^k}_{=Z_B} = Z_1 \frac{d}{dZ_1}\ln Z_B
\\ &= Z_1\frac{d}{dZ_1}\left(\ln(1-Z_1^N) - \ln(1-Z_1)\right)
\\ &= \underbrace{-\frac{N\cdot Z_1^N}{1-Z_1^N}}_{=-N\frac{p_N}{1-Z_1}} + \frac{Z_1}{1-Z_1} = \frac{Z_1 - N\cdot p_N}{1-Z_1}
\\ &= \frac{ - N\cdot Z_1^N + Z_1\overbrace{\frac{1-Z_1^N}{1-Z_1}}^{=Z_B}}{1-Z_1^N}
\\ &= \frac{-N Z_1^{N-1} + Z_B}{1-Z_1^N}Z_1
\\ &= \frac{-NZ_1^N}{Z_B(1-Z_1)} + \frac1{Z_1^{-1}-1} \veq{meanE}\sympyc
\end{align}$$

Let's take the limit $N\to\infty$, noting that $Z_1^N\to0$ exponentially, so

$$\langle k\rangle = E/E_1 \to Z_1 Z_B\to \frac{Z_1}{1-Z_1} = \frac 1{e^{\beta E_1} - 1}, \veq{be}\sympyc$$

which is just the Bose-Einstein (BE) statistics for a bosonic two-level system of energy difference $E$, i.e. an arbitrary amount of particles can populate any energy level.

On the other hand, take $N=2$ to obtain

$$\begin{align*}
Z_B &= \frac{1-Z_1^2}{1-Z_1} = 1+Z_1, \\
\langle k\rangle = E/E_1 &= \frac{-2Z_1^2+Z_1(1+Z_1)}{1-Z_1^2} = \frac{Z_1-Z_1^2}{1-Z_1^2} = \frac{Z_1}{1+Z_1} = \frac1{e^{\beta E_1} + 1} = p_1, \veq{fd}\sympyc
\end{align*}$$

which is the Fermi-Dirac (FD) statistics for a fermionic system, where each level can only be populated once.

---

Now, let's try to determine $E_1$ from $E$. For one approach, note

$$ E = \pm\partial_\beta\ln(1\mp e^{-\beta E_1}) $$

and integrate over $\beta$ to obtain

$$ e^{-\beta E_1} = \mp\left(\exp\left\{\mp\int_\beta^\infty E\,d\beta\right\}-1\right). $$

However, let's try a different approach by directly solving $E$ for $E_1$. Since $E_1$ occurs both by itself as well as in an exponential, chances are this will involve the Lambert $W$ function:

$$\begin{align}
  \beta E &= \frac{\beta E_1}{e^{\beta E_1}\mp 1} \quad\Big\vert\quad \beta E_1 =: x,\ \beta E =: y
\\\Leftrightarrow y &= \frac{x}{e^x\mp 1}
\\ y e^x &= x \pm y \quad\Big\vert\quad x \to x\mp y
\\ ye^{\mp y} e^x &= x
\\ -ye^{\mp y} &= -x e^{-x}
\\\Rightarrow x &= -W(-ye^{\mp y})
\\\Rightarrow \beta E_1 &= -W(-\beta E\cdot e^{\mp\beta E}) \mp \beta E \veq{lambertw}\sympyc
\\ e^{\beta E_1} &= e^{\mp\beta E}\cdot e^{-W(...)}
\\ &= e^{\mp\beta E}\frac{W(...)}{-\beta E e^{\mp\beta E}} = -\frac1\beta W\left(-\beta E\cdot e^{\mp\beta E}\right)
\end{align}$$
