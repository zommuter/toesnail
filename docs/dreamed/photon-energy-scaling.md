---
title: Dreamed - photon-energy scaling, laser to LED to maser
permalink: /dreamed/photon-energy-scaling
---

# Cheaper photons: what the COP optimum actually is

**STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Nothing here is theory or
owner-authored, and nothing may be promoted into `physics/` without the owner authoring the move.
The `\veq` badges refer **only** to `docs/dreamed/lean/CopOptimum.lean`; they are not wired to the
repo's sidecar/verify machinery.

**Seed** (owner-picked): `TODO.md` `id:e552` and §5d of
`docs/meeting-notes/2026-07-08-1056-se-corpus-mining-and-lasercool-deepdive.md`, the owner's
closing thought that "if the per-photon harvest is fixed at ~$k_BT$, use super-low-energy
photons", together with its flagged candidate original result: *the COP-optimal $h\nu/k_BT$,
which the literature apparently never states*.
**Scope guard:** ROADMAP `id:e552` (`[HARD -- hands]`) reserves the *authoring* of
`physics/lasercool.md` to the owner. This file does not write it. §8 marks which leads fall
inside `id:e552`.
**Sibling:** `docs/dreamed/lasercool.md` did the entropy budget and derived
$\sigma_\mathrm{atom}\le k_B T_\mathrm{rec}/T_D = 4\omega_\mathrm{rec}/\Gamma$ with a margin
$\sim10^3$ rather than $\sim10^7$. That is not redone here; this essay is the frequency axis.

## 1. The two results in one line each

**Negative.** There is no COP-optimal $h\nu/k_BT$. The COP of an idealised single-mode photonic
heat pump is *monotone* in photon energy at fixed harvest, and its supremum is the Carnot value
attained on the zero-flux boundary at **every** frequency. The quantity the seed asked for does
not exist as posed.

**Positive.** The optimum the owner's intuition was reaching for is real but it is a **power**
optimum, and it has a closed form. Once the free-space $A\propto\nu^3$ scaling is folded in, the
cooling power at fixed COP is stationary exactly where the harvested heat per photon is

$$ h\nu - \mu = \left[\,4 + W_0(-4e^{-4})\,\right] k_B T_c = 3.920690395\ k_B T_c \veq{wien4}\sympylean $$

which is the Wien displacement equation with exponent 4 (Wien's own frequency law is the
exponent-3 member of the same family). At $T_c=300$ K that is 24.508 THz, an equivalent
wavelength of **12.23 µm**, inside the 8-13 µm atmospheric window where sky cooling and
electroluminescent cooling already live. The owner's "a few $k_BT$" guess is right to two digits.

## 2. The device, and every assumption it rests on

An emitter (the cold side, at $T_c$) is driven by electrical work and radiates into a sink at
$T_h>T_c$. Per net emitted photon it consumes work $\mu$ and removes heat $h\nu-\mu$ from the
load. Assumptions, stated so they can be attacked:

| # | Assumption | Where it bites |
|---|---|---|
| A1 | One radiation mode at frequency $\nu$; all photons have energy $h\nu$ | drops the spectral integral; a real LED has a $\sim k_BT$-wide band |
| A2 | Generalised Planck (Würfel) occupation on the emitter, $\bar n_e = 1/(e^{(h\nu-\mu)/k_BT_c}-1)$, with $\mu = qV$ the photon chemical potential | this **is** the EL-cooling mechanism; without $\mu$ there is no pump |
| A3 | Sink is a blackbody at $T_h$ with $\mu=0$, $\bar n_a = 1/(e^{h\nu/k_BT_h}-1)$ | a thermophotonic device recovers work at the PV cell, raising the *system* COP; not modelled |
| A4 | Unity external quantum efficiency, no nonradiative recombination, no parasitic absorption | the single most violated assumption in practice; GaAs record is ~99.5 % |
| A5 | Rate prefactor $\kappa(\nu)$ is state-independent and $\propto\nu^3$ (free-space Einstein $A$, fixed dipole) | **this is the assumption a cavity breaks**, §7 |
| A6 | Steady state, detailed balance, no coherence | |

Net photon flux and the two ledgers:

$$ \Phi = \kappa(\nu)\,(\bar n_e - \bar n_a), \qquad \dot Q_c = (h\nu-\mu)\,\Phi, \qquad \dot W = \mu\,\Phi \veq{ledger}\definition $$

so the coefficient of performance is a **per-photon** ledger, independent of $\kappa$ and of the
flux entirely:

$$ \mathrm{COP} = \frac{\dot Q_c}{\dot W} = \frac{h\nu-\mu}{\mu} \veq{cop}\definition $$

Dimensionless groups, all referred to the cold side except $w$:

$$ x = \frac{h\nu}{k_BT_c},\quad y = \frac{h\nu-\mu}{k_BT_c},\quad u = \frac{\mu}{k_BT_c} = x-y,\quad t = \frac{T_c}{T_h},\quad w = tx = \frac{h\nu}{k_BT_h} \veq{groups}\definition $$

## 3. The COP, its Carnot bound, and the missing optimum

Cooling requires $\Phi>0$, i.e. $\bar n_e>\bar n_a$. Because $1/(e^z-1)$ is strictly decreasing
(Lean-proved, wall 1 below), that is simply

$$ \frac{h\nu-\mu}{k_BT_c} < \frac{h\nu}{k_BT_h} \quad\Longleftrightarrow\quad y < xt \quad\Longleftrightarrow\quad \mu > h\nu\left(1-\frac{T_c}{T_h}\right) \veq{flux}\lean $$

The last form is the minimum work per photon. Substituting it into `\eqref{cop}`:

$$ \mathrm{COP} = \frac{y}{x-y} < \frac{xt}{x-xt} = \frac{t}{1-t} = \frac{T_c}{T_h-T_c} \veq{carnot}\lean $$

Carnot, recovered from detailed balance alone, with no assumption about spectra, rates or mode
counts. That is the honesty check, and it is Lean-proved from the flux condition in named
hypotheses.

**Now the negative result.** At fixed harvest $y$, $\mathrm{COP}(x) = y/(x-y)$ is strictly
decreasing in $x$ on $x>y$:

$$ \frac{\partial}{\partial x}\frac{y}{x-y} = -\frac{y}{(x-y)^2} < 0 \veq{nomax}\lean $$

Cheaper photons are *always* better for COP, without limit, and at fixed $x$ the COP rises
monotonically as $y\to xt$, i.e. as the flux goes to zero. **The supremum is the Carnot boundary
at every frequency; there is no interior stationary point in $h\nu/k_BT$.** So the seed's
"COP-optimal $h\nu/k_BT$" is not a thing that exists, and no paper states it because there is
nothing to state. This is not a failure of the idea. It relocates it: the real trade-off
parameter is **cooling power**, and the frequency optimum lives there.

The same structure appears in the optical-refrigeration literature. Sheik-Bahae and Epstein write
$P_\mathrm{cool} = P_\mathrm{abs}(\eta\,\nu_F/\nu - 1)$; that is `\eqref{cop}` for anti-Stokes
fluorescence, and it too is monotone in $\nu$ with no interior optimum.

## 4. The power optimum: a Wien displacement law with exponent 4

Fix the operating point by the **harvest fraction** $\eta = y/(xt) \in (0,1)$, the fraction of the
Carnot-limit heat per photon actually taken at that frequency. ($\eta$ and
$\mathrm{COP}/\mathrm{COP}_\mathrm{Carnot} = \eta(1-t)/(1-\eta t)$ determine each other
monotonically, so fixing one fixes the other.) Then $y = \eta w$ and

$$ \dot Q_c \;\propto\; f(w) = \eta\,w^4\left[\frac{1}{e^{\eta w}-1} - \frac{1}{e^{w}-1}\right] \veq{power}\sympy $$

three powers of $w$ from $\kappa\propto\nu^3$ and one from the heat each photon carries. Small $w$
gives $f\to(1-\eta)w^3\to0$; large $w$ gives $f\to\eta w^4e^{-\eta w}\to0$. An interior maximum
exists, and it exists **because of** wall 2: without the $\nu^3$ factor the power at fixed COP is
monotone decreasing in frequency, and the owner's "go lower" intuition would be unbounded.

Dropping the ambient term (justified below) and writing everything in $y=\eta w$:

$$ f = \eta^{-3}\,\frac{y^4}{e^{y}-1} + O\!\left(e^{-y/\eta}\right), \qquad \frac{d}{dy}\frac{y^4}{e^y-1} = 0 \iff 4\left(1-e^{-y}\right) = y \veq{foc}\lean $$

The first-order condition is Wien's transcendental equation with exponent 4. Rearranged,
$(y-4)e^{y-4} = -4e^{-4}$, so

$$ y^\ast = 4 + W_0\!\left(-4e^{-4}\right) = 3.920690395\ \ (\text{10 s.f.}) \veq{ystar}\sympylean $$

SymPy returns exactly `LambertW(-4*exp(-4)) + 4` from `solve`; mpmath at 30 digits gives
$3.92069039487289$, and $P''(y^\ast) = -1.145 < 0$, a maximum. The root sits at $y^\ast-4\in(-1,0)$,
so it is on the **principal** branch $W_0$ (contrast `physics/entropy.md`'s `\veq{lambertw}`
inversion, where the sibling `docs/dreamed/lambertw-statistics.md` shows the physical root is
$W_{-1}$; here $W_0$ is correct and the branch check is not vacuous).

**How good is dropping the ambient term.** Exact maximisation of `\eqref{power}` by mpmath:

| $\eta$ | 0.05 | 0.10 | 0.20 | 0.30 | 0.50 | 0.70 | 0.90 |
|---|---|---|---|---|---|---|---|
| $w^\ast = h\nu^\ast/k_BT_h$ | 78.414 | 39.207 | 19.603 | 13.072 | 7.9946 | 6.1074 | 5.2110 |
| $y^\ast = \eta w^\ast$ | 3.920690 | 3.920690 | 3.920693 | 3.921695 | 3.997303 | 4.275211 | 4.689900 |

$y^\ast$ is $3.9206904$ to seven digits for $\eta\le0.2$ and drifts only to 4.69 at $\eta=0.9$.
**The heat harvested per photon at the power optimum is $3.92\,k_BT_c$, essentially independent
of frequency, of the temperature ratio, and of the operating point.** That invariance, not the
number, is the content.

**Sensitivity to the rate exponent.** If $\kappa\propto\nu^p$ the objective is $y^{p+1}/(e^y-1)$
and $y^\ast = n + W_0(-ne^{-n})$ with $n=p+1$. The whole family is the Wien constants:

| rate law | $n$ | $y^\ast$ | reading |
|---|---|---|---|
| $\kappa\propto\nu$ | 2 | 1.593624260 | Wien peak of the photon-number spectrum |
| $\kappa\propto\nu^2$ (mode-density-limited) | 3 | 2.821439372 | Wien's frequency displacement law |
| $\kappa\propto\nu^3$ (free-space Einstein $A$) | 4 | **3.920690395** | this result |
| $\kappa\propto\nu^4$ | 5 | 4.965114232 | Wien's wavelength displacement law |

So "$h\nu-\mu$ between 2.8 and 4.0 $k_BT_c$" survives a whole unit of uncertainty in the rate
exponent. The result is robust in exactly the way an order-of-magnitude physics claim needs.

**Numbers.** $k_BT/h = 6.250986$ THz at 300 K and 83.346 GHz at 4 K, so

- $T_c = 300$ K: $(h\nu^\ast-\mu)/h = 24.50818$ THz, equivalent wavelength 12.232 µm. For a
  small-$\Delta T$ cooler $\mu\ll h\nu$, so $\nu^\ast\approx24.5$ THz directly.
- $T_c = 4$ K: 326.78 GHz, 0.917 mm.

## 5. Originality: a calibrated verdict

**I claim: I could not find it stated. I do not claim it is original.** Those are different, and
the difference matters here because the surrounding physics is thoroughly worked over.

What I checked and found:

- **Santhanam, Gray & Ram, *PRL* **108**, 097403 (2012)** exists as cited (verified: MIT DSpace
  copy and the APS abstract). It demonstrates an LED above unity wall-plug efficiency and frames
  the trade explicitly as *more lattice heat per photon at small bias, at the cost of smaller heat
  flux*. That is the COP-versus-power tension of §3 and §4, correctly identified, without a
  frequency optimum.
- **Zhu, Fiorino, Thompson, Mittapally, Meyhofer & Reddy, *Nature* **566**, 239 (2019)**, "Near-field
  photonic cooling through control of the chemical potential of photons" (verified). Confirms
  assumption A2 as the operative mechanism. (Note the meeting note's "Zhu et al." is this group,
  not Fan's.)
- **Sadi, Radevici & Oksanen, *Nat. Photonics* **14**, 205 (2020)**, thermophotonic cooling with
  LEDs (verified).
- **Sheik-Bahae & Epstein**, optical refrigeration: the cooling-power expression
  $P_\mathrm{abs}(\eta\nu_F/\nu-1)$ is standard and monotone. Corroborates §3's negative result.
- **The 2025 detailed-balance analysis** (arXiv:2504.05013 → *J. Appl. Phys.* **138**, 173106
  (2025)) is the closest hit and it is close. It states "there is an optimum bandgap energy for
  each quantum efficiency" and produces it **numerically, per material, in eV**. It does not give
  a dimensionless optimum, a closed form, or a transcendental condition.

So the *content* "there is an optimal photon energy for cooling power" is known and published.
What I could not find anywhere is the **dimensionless closed form** $h\nu-\mu = [4+W_0(-4e^{-4})]
k_BT_c$, its identification as the exponent-4 Wien member, or the observation that $y^\ast$ is
nearly independent of the operating point. My searches were three targeted web searches plus one
full-text read of the 2025 paper; that is not a literature review, and a Wien-type displacement
result is exactly the kind of thing that could sit in a 1980s thermophotonics paper or a Landau-era
footnote unindexed. **Recommended framing for any owner-authored version: "the optimum, in the
dimensionless form that makes it a Wien displacement law, does not appear in the papers I checked",
not "never stated".** Note also that the negative result of §3 is *why* nobody states a COP
optimum, and that is worth saying explicitly in `physics/lasercool.md` because it pre-empts the
obvious reader objection.

## 6. The three walls, quantified

Wall 1 is thermal occupation $\bar n_\mathrm{th}=1/(e^x-1)$, wall 2 is the collapse of
spontaneous emission as $A\propto\nu^3$, wall 3 is mode count and the Nyquist power cap.

| regime | $\nu$ | $x$ at 300 K | $\bar n_\mathrm{th}$(300 K) | $x$ at 4 K | $\bar n_\mathrm{th}$(4 K) | $A$ rel. 780 nm | modes $\propto\nu^2$ |
|---|---|---|---|---|---|---|---|
| visible laser, 780 nm | 384.2 THz | 61.47 | $2.0\times10^{-27}$ | 4610 | $\sim10^{-2002}$ | 1 | 1 |
| mid-IR LED, 10 µm | 29.98 THz | 4.796 | $8.3\times10^{-3}$ | 359.7 | $6\times10^{-157}$ | $4.8\times10^{-4}$ | $6.1\times10^{-3}$ |
| §4 optimum, 24.51 THz | 24.51 THz | 3.921 | $2.0\times10^{-2}$ | 294.1 | $2\times10^{-128}$ | $2.6\times10^{-4}$ | $4.1\times10^{-3}$ |
| X-band maser, 10 GHz | 10 GHz | $1.6\times10^{-3}$ | 625 | 0.120 | 7.84 | $1.8\times10^{-14}$ | $6.8\times10^{-10}$ |

Nyquist: a single mode carries at most $\sim k_BTB$. At $B=10$ GHz that is **41.4 pW** at 300 K
and **0.55 pW** at 4 K, whatever the load.

**Which wall binds first.** This is the section's deliverable.

| regime | binding constraint | why the others do not bind |
|---|---|---|
| optical, $x\gg1$ | **none of the three.** The binding wall is the *quantum defect*: the harvest is $k_BT/h\nu = 1.6\,\%$ of each photon at 780 nm, so $\mathrm{COP}\approx0.016$ and any nonradiative loss above 1.6 % flips cooling to heating | modes empty ($\bar n=2\times10^{-27}$), $A$ is at its maximum, mode supply is $\sim10^{13}$/s (sibling essay §3) |
| mid-IR / THz, $x\sim1$-5 | **none binds hard; this is the sweet spot,** and §4 puts the power optimum here for exactly that reason | $\bar n\sim10^{-2}$, still an empty exhaust; $A$ down only $5\times10^{-4}$; harvest up to 21-26 % of $h\nu$ |
| microwave, $x\ll1$ | **wall 2, always.** Free-space magnetic-dipole $A$ at 7.335 GHz is $3.95\times10^{-13}$ s$^{-1}$, a radiative lifetime of $8.0\times10^{4}$ years. **Plus wall 1 at 300 K** ($\bar n=625$: ambient absorption swamps emission) | wall 3 is real but secondary: 41 pW per mode is small, not zero |

Two things the table says that the $k_BT/h\nu$ harvest argument alone does not. First, the optical
wall is not on the owner's list: it is the quantum defect, and it is what forces 99.5 % EQE
materials. Second, in the microwave the *rate* wall binds even at 4 K where the occupation wall has
relaxed to $\bar n=7.8$: a factor $10^{14}$ in $A$ is not something a cold load fixes.

## 7. Why a maser cools anyway, and exactly which premise it breaks

Albanese, Probst, Ranjan, Zollitsch, Pechal, Wallraff, Morton, Esteve, Flurin & Bertet,
"Radiative cooling of a spin ensemble", *Nat. Phys.* **16**, 751 (2020) (verified): bismuth donor
spins in silicon, coupled to a micron-scale superconducting resonator, cooled **below the lattice
temperature**. The photon-energy-scaling argument of §6 says this should be impossible twice over.
It is wrong twice, for two separable reasons, and neither is a loophole in thermodynamics.

**Wall 2 is broken by the cavity, and it was never a law.** $A\propto\nu^3$ is the free-space
photon density of states times a fixed dipole matrix element. Assumption A5, not physics. A
resonator substitutes its own density of states; the Purcell factor
$F = 3Q(\lambda/n)^3/(4\pi^2 V)$ makes the radiative rate an **engineering parameter decoupled from
$\nu$**. To bring the 8.0-kiloyear free-space lifetime computed above down to the ~1 s that
competes with spin-lattice relaxation takes $F\sim2.5\times10^{12}$, which is what a small-mode-volume
high-$Q$ superconducting resonator supplies. Precursor: Bienfait et al., *Nature* **531**, 74 (2016).

**Wall 1 is broken by the sink, not by the frequency.** The occupation that matters is the
*sink's*, not the ambient's. $\bar n_a$ enters `\eqref{power}` only through $T_h$, and Albanese
terminates the resonator in a **cold resistive load**, emptying the mode without raising $h\nu$.
Cold-sky radiometry is the same move with the 3 K sky as the load.

**What is not broken, and this is the honest part.** The per-photon harvest is still
$h\nu-\mu\lesssim h\nu$, i.e. $k_B\times0.35$ K at 7.3 GHz. Albanese cools a spin ensemble, an
object with a minuscule heat capacity, not a watt-scale load. Wall 3 is untouched: 41 pW per mode
stands. So the maser route defeats the *rate* and *occupation* walls and leaves the *power* wall
exactly where it was. The correct summary is not "low frequency works after all" but: **the three
walls have different modal status. Wall 1 is a statement about the sink and is engineerable. Wall 2
is a statement about the mode density and is engineerable. Wall 3 is $k_BTB$ and is not.** Only
wall 3 survives §4's optimisation as a genuine constraint, which is why §4's answer is a power
optimum.

## 8. Leads

1. Redo §4 without assumption A1, integrating over a real emitter band of width $\sim k_BT$; the
   optimum should shift by $O(1)$ but the Wien structure should survive. Decidable by one SymPy or
   mpmath session against the 2025 detailed-balance paper's per-material numbers. **Inside
   `id:e552` (owner-only) if it lands in `physics/lasercool.md`.**
2. Relax A4: with external quantum efficiency $\eta_\mathrm{ext}<1$ the COP acquires a genuine
   interior maximum in $\nu$ (the parasitic load does not scale with the harvest), which would turn
   §3's negative into a positive under a weaker assumption. Decidable by adding one loss term to
   `\eqref{ledger}` and re-running §4; this is the single highest-value follow-up.
3. Settle originality properly: a Google Scholar and ADS sweep for "Wien" plus "cooling power
   optimum" in the thermophotonic and radiative-cooling literature 1980-2010, plus Landau 1946 in
   full. Decidable in an hour by a human with library access, and it is the difference between
   "could not find" and "original".
4. Weld §4 to the sibling essay: $\sigma_\mathrm{atom}\le k_BT_\mathrm{rec}/T_D$ is a per-photon
   *entropy* bound and $y^\ast=3.92$ is a per-photon *energy* optimum. Whether the entropy-optimal
   and power-optimal photon energies coincide is a well-posed question, decidable by maximising
   $s(\bar n)/\bar n$ times the same $\nu^3$ against the same constraint. **Inside `id:e552`.**
5. Formalise the maximum, not just the stationary point: `P_critical_iff` gives the first-order
   condition, and a second-derivative or strict-concavity argument in Mathlib would close the gap
   between "stationary" and "maximum". Decidable by a Lean session, not attempted here.

## 9. Lean attestation

File `docs/dreamed/lean/CopOptimum.lean`, checked 2026-09-01 from
`/home/tobias/src/toesnail/verify`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/CopOptimum.lean
```

**Exit status 0, no output, no `sorry`.**

| Theorem | Attests | Handle |
|---|---|---|
| `strictAntiOn_nbar` | $1/(e^x-1)$ strictly decreasing on $x>0$ (wall 1, and the step in `\eqref{flux}`) | `flux` |
| `nbar_tendsto_zero` | $\bar n_\mathrm{th}\to0$ as $x\to\infty$: the optical vacuum is free | `flux` |
| `nbar_pos` | $\bar n_\mathrm{th}>0$ on $x>0$ | `flux` |
| `cop_le_carnot` | $(E-\mu)/\mu \le T_c/(T_h-T_c)$ from the flux condition alone, with $0<T_c<T_h$, $0<\mu$ named | `carnot` |
| `cop_strictAntiOn_of_photon_energy` | $E\mapsto y/(E-y)$ strictly antitone on $E>y$: **no interior COP optimum** | `nomax` |
| `hasDerivAt_P` | derivative of $y^4/(e^y-1)$ | `foc` |
| `P_critical_iff` | stationary on $y>0$ $\iff$ $4(1-e^{-y})=y$ | `foc` |
| `wien4_lambert_form` | $4(1-e^{-y})=y \iff (y-4)e^{y-4} = -4e^{-4}$, the $W$ precondition | `ystar` |
| `strictAntiOn_g`, `four_lt_exp_two` | $g(y)=4(1-e^{-y})-y$ strictly decreasing on $y\ge2$ | `ystar` |
| `wien4_root_exists` | a root exists with $3<y^\ast<4$ | `ystar` |
| `wien4_root_unique` | it is the only one at or above $y=2$ | `ystar` |

**What was weakened.**

- **The stationary point is not proved to be a maximum.** `P_critical_iff` gives the first-order
  condition and `wien4_root_exists`/`wien4_root_unique` bracket and isolate it; $P''(y^\ast)=-1.145$
  is mpmath, not Lean. Lead 5.
- **Nothing numeric is attested beyond $3<y^\ast<4$.** The 10-significant-figure value
  3.920690395, the 24.51 THz, the wall table and the $\eta$-sensitivity table are all mpmath.
- **The Lambert-W value is stated via its precondition,** as Mathlib has no $W$. The branch
  identification ($W_0$, since $y^\ast-4\in(-1,0)$) rests on `wien4_root_exists` plus
  `strictMonoOn_F` in the sibling `docs/dreamed/lean/Statistics.lean`, which is cited and not
  reproved; nor is `be_y_lt_one` there, which is $x/(e^x-1)<1$ on $x>0$.
- **`cop_le_carnot` takes the flux condition as a hypothesis** rather than deriving it from the
  Bose occupations. The derivation is `\eqref{flux}` in the essay and uses `strictAntiOn_nbar`,
  but the two are not welded in Lean.
- **`\eqref{ledger}`, `\eqref{cop}` and `\eqref{groups}` are tagged `\definition`,** not verified:
  they are the model, and the model is assumptions A1-A6, not a theorem.

## 10. What a `.mw` version would carry

Sketch in the style of `verify/mirror/resogram_esol.mw`. Not a mirror, not executable.

```computation
nbar_e = 1/(exp((h*nu - mu)/(kB*Tc)) - 1)
nbar_a = 1/(exp(h*nu/(kB*Th)) - 1)
flux = kappa * (nbar_e - nbar_a)
COP = (h*nu - mu)/mu
```

```computation
y = (h*nu - mu)/(kB*Tc)
w = h*nu/(kB*Th)
Qdot = kappa0 * w**3 * kB*Tc * y * (nbar_e - nbar_a)
ystar = solve(Eq(diff(y**4/(exp(y)-1), y), 0), y)
```

The staleness payoff is specific and it is the same class as the `edot` sign propagation in
MEMORY. `Qdot` depends on `kappa` through the exponent 3 in `w**3`; `ystar` depends on the
exponent 4 in `y**4`, which is that same 3 plus one. Change the assumed rate law in one place
and §4's table of Wien constants goes stale in the other, silently, in plain markdown. A DAG
catches it; a human rereading a 300-line essay does not.
