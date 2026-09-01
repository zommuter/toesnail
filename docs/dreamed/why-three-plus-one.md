---
title: "Why three plus one? The classical arguments, weighed"
permalink: /dreamed/why-three-plus-one
---

# Why is space three-dimensional? The arguments, and what this repo's own `mod 2` adds

> **DREAMED, UNREVIEWED, AND DELIBERATELY SPECULATIVE.** Written by an AI agent on 2026-09-01,
> not by the owner and not read by him. Status contract and hard rules:
> [`docs/dreamed/README.md`](README.md). The owner authorised speculation for this essay on
> 2026-09-01 **on his own condition: wild ideas are welcome, every RESULT must be sound.** So the
> question is speculated about freely and every speculative step is labelled as one, but every
> mathematical statement below is either derived here, checked by SymPy, proved in
> [`lean/Dimensionality.lean`](lean/Dimensionality.lean), or attributed to a source that was
> fetched and read. Nothing here is theory, nothing here is a decision.

Seeded by a finding made in this repo today. The sibling
[`wirohsh-ladder.md`](wirohsh-ladder.md) established that the owner's `d -> d-2` WiRoHSH ladder has
a parity, and then refuted the identification of that parity with Huygens' principle, on the ground
that Huygens **fails** at `d = 1` while the ladder calls `d = 1` its best floor. The repo therefore
now holds two independent `mod 2` facts about spatial dimension, which makes the famous question
sit up. This essay assembles the classical answers, checks the strongest one, and then asks
sceptically whether the ladder finding adds anything to it.

---

## 0. Headline

1. **Ehrenfest's argument closes, exactly.** At any stationary radius of the effective potential of
   a `1/r^{d-1}` central force, `V_eff''(r_0) = (4-d)L^2/(m r_0^4)`, coupling-free. Stable circular
   orbits exist **iff `d < 4`**. Proved in Lean for general `d`.
2. **The quantum version has the same critical dimension for the same reason:** at `d = 4` the
   attraction and the centrifugal barrier scale identically.
3. **The wave argument is real but weaker.** `d = 3` is the smallest dimension with sharp Huygens,
   hence the smallest with distortion-free propagation. A tail degrades signalling; it does not
   forbid observers. An argument of different strength, not a second proof.
4. **All of these are stability or anthropic arguments, not derivations, and they vary `d` while
   holding the FORM of the laws fixed.** That is the honest core, and Tegmark says so himself.
5. **The WiRoHSH ladder adds nothing here, and I recommend saying so.** The most defensible
   statement is the sibling's own: the ladder's parity and Huygens' parity share a cause in the
   `(d-1)/r` coefficient of the radial wave operator. A shared cause, not a shared statement, and a
   solution technique for a fixed equation is not a constraint on which `d` the world has.

---

## 1. Ehrenfest 1917: the strongest single argument

### 1.1 The force law is a Gauss-law consequence, not an input

In `d` spatial dimensions the sphere of radius `r` has area `2\pi^{d/2}/\Gamma(d/2)\,r^{d-1}`.
A radial field with the same flux `Q` through every sphere therefore has

$$ |F(r)| \;=\; \frac{Q}{2\pi^{d/2}/\Gamma(d/2)} \cdot \frac{1}{r^{d-1}} \;\propto\; r^{1-d}, \qquad V(r) = -\frac{k}{r^{d-2}} \;\; (d \neq 2) \veq{gauss}\lean $$

Lean proves the `r` dependence and the exact match between the flux constant and the potential
constant (`gauss_field_magnitude`, `hasDerivAt_coulomb`, `gauss_matches_coulomb`). It **drops the
`\Gamma`-function factor**, carrying it as an abstract nonzero `S`: only the `r` dependence enters
anything below, and claiming the constant would have been unearned decoration. So the inverse-square
law is the `d = 3` instance of one statement, and `d = 4` gives an inverse cube.

### 1.2 The effective potential, done properly for symbolic `d`

$$ V_{\rm eff}(r) \;=\; \frac{L^2}{2mr^2} \;-\; \frac{k}{r^{d-2}}, \qquad L, m, k > 0, \quad d \geq 3 \veq{veff}\lean $$

SymPy, with `d` free and positive:

$$ V_{\rm eff}'(r) \;=\; \frac{-L^2 r + k m (d-2)\, r^{5-d}}{m r^4}, \qquad r_0^{\,4-d} \;=\; \frac{L^2}{k m (d-2)} \veq{stationary}\sympy $$

so a stationary radius exists and is unique for every `d \neq 4`. Substituting the stationarity
relation into the second derivative, every trace of `k` cancels:

$$ V_{\rm eff}''(r_0) \;=\; \frac{(4-d)\,L^2}{m\,r_0^{4}} \veq{ehrenfest}\lean $$

**This is the exact inequality.** A stable circular orbit requires `V_eff''(r_0) > 0`, hence

$$ \boxed{\;d < 4\;} \qquad\text{equivalently, for integer } d \geq 3: \quad d = 3 \veq{ehrenfest-ineq}\lean $$

SymPy confirms `\eqref{ehrenfest}` independently at `d = 3, 5, 6` by explicit substitution of the
closed-form `r_0`; Lean proves it for **general** `d = q+3` (`veffSecond_at_stationary`), with
`m > 0` and `r_0 > 0` named, every derivative a `HasDerivAt` witness, and no positivity of `L` or
`k` needed. Three corollaries, all in Lean:

| `d` | stationary radius | `V_eff''(r_0)` | verdict |
|---|---|---|---|
| 3 | `L^2/(km)` | `+L^2/(m r_0^4)` | stable (`stable_dim_three`) |
| 4 | none, unless `L^2 = 2km` | `0` (`marginal_dim_four`) | marginal, and generically no circular orbit at all |
| 5 | `3km/L^2` | `-L^2/(m r_0^4)` | unstable (`unstable_dim_ge_five`) |
| `\geq 5` | exists | `(4-d)L^2/(m r_0^4) < 0` | unstable, general proof |

The `d = 4` row is sharper than the usual telling. It is not merely that the orbit is neutrally
stable: `dim_four_stationary_forces` proves that `V_eff'(r) = 0` for some `r > 0` **forces**
`L^2 = 2km`, and then it holds at *every* radius. Off that measure-zero locus `V_eff` is monotone
and there is no circular orbit at all. The `1/r^2` attraction and the `1/r^2` barrier are the same
power, so the competition is decided once, globally, by a constant.

Physically, for `d \geq 4` a test particle either escapes or spirals into the centre in finite
time. Tegmark's Figure 2 draws exactly this: incident particles split into escapees and a
finite-cross-section "annihilation" funnel, with no elliptic orbits anywhere.

---

## 2. The quantum version, and why `d = 4` is again the hinge

The same critical dimension appears in the Schrodinger problem, by a scaling argument three lines
long. The substitution `\psi = r^{-(d-1)/2}\chi(r)` turns the `d`-dimensional radial equation into
an exactly one-dimensional one, and SymPy returns its centrifugal coefficient as

$$ -\chi'' + \frac{(2\ell + d - 3)(2\ell + d - 1)}{4}\,\frac{\chi}{r^2} + V(r)\chi = E\chi \veq{radial-reduction}\sympy $$

(units `\hbar = 2m = 1`; at `d = 3` this is the familiar `\ell(\ell+1)/r^2`, and at `d = 4, \ell = 0`
it is `3/4`).

Now scale a trial state, `\psi_\lambda(x) = \lambda^{d/2}\psi(\lambda x)`, which preserves the norm.
The kinetic term scales as `\lambda^2` and the potential `-k/r^{d-2}` as `-\lambda^{d-2}`:

$$ E(\lambda) \;=\; \lambda^2 \langle T\rangle \;-\; \lambda^{d-2}\,k\,\langle r^{2-d}\rangle \veq{quantum-scaling}\sympy $$

- `d = 3`: exponents `2` versus `1`, kinetic wins at large `\lambda`, `E` has a minimum. A ground
  state exists with a scale: the Bohr radius.
- `d = 4`: exponents `2` versus `2`. **Both terms scale identically**, exactly as in
  `\eqref{ehrenfest}` at `d = 4`. The problem is scale invariant, so no length can be built. Either
  the net coefficient is positive and the spectrum is purely continuous with infimum `0` (no bound
  state at all), or it is negative and `E(\lambda) \to -\infty` (fall to the centre); which one is
  set by the coupling against the `3/4` of `\eqref{radial-reduction}` via the standard `-1/4`
  boundedness threshold for `c/r^2` in one dimension. Neither branch has a stable ground state.
- `d \geq 5`: `d-2 > 2`, the attraction wins, `E(\lambda) \to -\infty`. Unbounded below for any
  coupling: no ground state, and time-dependent states of arbitrarily negative energy, which is
  what Tegmark reports from Tangherlini (1963).

**Labelled as speculation:** classical and quantum break at the *same* `d = 4` for the *same*
reason, a coincidence of two scaling exponents. I verified both statements, not that this is more
than the shared `1/r^2` algebra. No claim that it is deep.

---

## 3. The wave-propagation argument, which is where this repo's own work lands

Sharp Huygens says a point-source signal arrives and is then gone: the fundamental solution of the
wave equation is supported **on** the light cone, not in it. It holds for odd spatial `d \geq 3`
and fails otherwise. The `d = 1` exception is not a technicality, and the sibling
[`wirohsh-ladder.md`](wirohsh-ladder.md) §2(a) is where it was pinned down here: d'Alembert's
initial-velocity term integrates over the whole interval `[x-ct, x+ct]`, so a point of initial
velocity is heard forever. The exact predicate is therefore

$$ \mathrm{SharpHuygens}(d) \;\equiv\; \big(d \bmod 2 = 1\big) \;\wedge\; \big(d \geq 3\big) \veq{huygens-parity}\lean $$

which Lean carries as a decidable predicate, with `d = 1, 2, 4` refuted and `d = 3, 5` confirmed.

**The argument.** In even `d` the fundamental solution fills the solid cone and leaves a decaying
tail, so a sharp pulse is followed by reverberation: every emission keeps being received, weakly,
forever. In `d = 1` the same holds for the velocity data. So `d = 3` is the **smallest** dimension
supporting distortion-free propagation, and Lean's `three_unique` records the intersection with §1:
`d = 3` is the unique dimension both `\leq 3` (Ehrenfest) and sharp-Huygens.

**The honest weighing, because this is weaker than §1 and must not be sold level with it.**

- A tail is a real effect, not a fatal one. "Degraded" means a receiver at fixed distance sees the
  signal smeared with a `(c^2t^2-r^2)^{-1/2}` weight over its whole past, so pulses overlap and the
  channel has memory. That costs bandwidth. It does not destroy causality, prediction, or matter.
  Compare §1, where atoms simply do not exist.
- The tail is fragile where the Ehrenfest result is not. Klein-Gordon in `d = 3` has a tail, so a
  mass term destroys sharp Huygens without moving `d` at all. "Our world has sharp Huygens" is false
  for every massive field: an argument that `d = 3` because propagation is clean is an argument
  about photons specifically.
- Tegmark does not use it. His `n < 3` case rests on Whitrow's nerve-crossing argument and on
  Wheeler's point that general relativity has no local gravitational force below `d = 3`, not on
  wave tails at all. The wave argument is a genuine gap in his Figure 1, and, speculatively, the
  most interesting place a toesnail remark could sit.

**Verdict: keep it, rank it second, never call it a proof.**

---

## 4. Why one time dimension: the signature side

Fetched and read, so the citation is not from memory: **M. Tegmark, "On the dimensionality of
spacetime", Class. Quantum Grav. 14, L69-L75 (1997)**, arXiv:gr-qc/9702052. What it actually argues:

- The **frame is anthropic selection inside an ensemble**, not a derivation. Superstring theories
  with several low-energy limits predict a distribution over `(n, m)`; all but `(3,1)` are claimed
  to be "dead worlds". His own words: *"we are not attempting to rigorously show that merely
  `(n,m) = (3,1)` permits observers. Rather, we are simply arguing that it is far from obvious that
  any other `(n,m)` permits observers"*, with the burden of proof placed on the critic.
- **Time.** Classify a second-order linear PDE by the eigenvalue signs of its principal symbol
  (Courant and Hilbert): elliptic if all agree, hyperbolic if exactly one differs, ultrahyperbolic
  otherwise. A metric of signature `(n,m)` hands the symbol those signs, so `m = 0` is elliptic,
  `m = 1` (or `n = 1`) hyperbolic, `m, n \geq 2` ultrahyperbolic, and only the hyperbolic case has a
  well-posed initial-value problem. For the ultrahyperbolic case he invokes **Asgeirsson's theorem**
  (Math. Ann. **113**, 321, 1936): every hypersurface then contains both spacelike and timelike
  directions, so there are *no* spacelike or timelike hypersurfaces at all and hence no well-posed
  problem. His well-posedness criterion is the practical one, that the solution depend **boundedly**
  on the data, or an observer would need infinitely accurate measurements for finite error bars.
- `(n,m) = (1,3)` is not a third option: it is `(3,1)` with the sign flipped, so all particles are
  tachyons and well-posed data lives in the nonlocal region *outside* the light cones.
- **`n > 3`** is Ehrenfest [4] and Tangherlini [5], exactly §1 and §2 above. **`n < 3`** is
  "too simple": no gravitational force in general relativity below `d = 3` (Wheeler, via
  Deser-Jackiw-'t Hooft), plus Whitrow's argument that two nerves cannot cross in a plane. He
  raises the escape hatch himself: `(4,1)` might yet be stable given short-distance corrections to
  `1/r^2`, or string-like rather than point-like particles.

The Lean file carries **only the arithmetic** of that classification (`pdeClass`: `(3,1)`
hyperbolic, `(3,0)` elliptic, `(3,2)` ultrahyperbolic, `(1,3)` hyperbolic) and makes **no**
well-posedness claim. Asgeirsson's theorem is analysis and stays in this prose; the boundary is
deliberate. The signature side of the question is already open here as Q2 of `TODO.md id:57e2`
(Galilei versus Poincare), treated by the sibling
[`q2-galilei-vs-poincare.md`](q2-galilei-vs-poincare.md). This essay does not touch that choice.

---

## 5. The counter-case, stated as strongly as I can make it

This section is the intellectually honest core, and none of the above survives it intact.

**(a) They are stability arguments, not derivations.** Every argument in §1 to §4 has the form "in
dimension `d`, structure `X` is impossible", plus the premise that observers require `X`. That is a
conditional about habitability, never a statement that `d` **must** be `3`. The strongest available
reading is Tegmark's: an ensemble plus a selection effect predicts what we observe. Absent the
ensemble they explain nothing; they note that we are where we could be.

**(b) They vary `d` while holding the FORM of the laws fixed, which is the questionable move.**
`\eqref{gauss}` assumes Gauss's law, `\eqref{radial-reduction}` the Schrodinger equation, §3 the
flat wave equation, §4 second-order PDEs whose symbol is the metric. But the form of the laws and
the dimension are not independent inputs to nature; they are outputs of the same unknown structure.
A world with `d = 5` need not have a `1/r^4` force law, since there is no reason its
electromagnetism is a two-form. Vary law and dimension together and the analysis has no fixed point
to stand on. **This is the strongest objection and I have no answer to it.** Tegmark's `(4,1)`
escape hatch is a small instance of exactly this, conceding the objection's structure while
limiting its scope.

**(c) String theory dissolves the question rather than answering it.** With 9 or 10 spatial
dimensions and 6 or 7 compactified, "why 3" becomes "why does the compactification leave 3 large":
vacuum selection, moduli stabilisation, cosmological dynamics. A different question, whose current
answer is a count and not a mechanism. This is Tegmark's own framing, so his argument does not
compete with string theory, it feeds on it, and it inherits every objection to ensemble reasoning
wholesale.

**(d) The arguments are not independent, so they must not be multiplied.** §1 and §2 are the same
`1/r^2` scaling twice; §3 and §4 are both statements about one principal symbol. Counting four
coincidences pointing at `3+1` would be double counting. There are at most two ideas here, and both
concern the same radial operator.

---

## 6. What the WiRoHSH ladder adds, tested sceptically

**Recommendation: nothing, and the essay's value is in saying so.**

The temptation is obvious: the repo holds two `mod 2` facts about `d`, one of them the owner's own
construction. The test, which the identification fails on all three counts:

1. **The ladder is a solution technique for a fixed equation, not a constraint on `d`.** It takes
   the `d`-dimensional wave equation as given and represents its solutions using `(d-2)`-dimensional
   ones. Whatever `d` the world has, the ladder applies. A method that works in every dimension
   cannot select one.
2. **Its parity is arithmetic on an integer, and the sibling proved exactly that.**
   `WirohshLadder.bottom d` is `d % 2` in a hat. It is immune to a mass term, to a change of
   coupling, to anything physical. Huygens is a support property of a distribution and is fragile
   to all three (§3). Nothing that stable can be evidence about the world.
3. **Its floors point the wrong way.** The ladder's *best* floor is `d = 1`, where the profile is
   completely arbitrary. Every dimensionality argument in §1 to §4 says `d = 1` is a dead world. If
   the ladder had anything to say about which `d` is preferred, its answer would be the wrong one.

**What survives, worth stating precisely because it is small.** The sibling already identified the
common cause: both parities descend from the first-order coefficient `(d-1)/r` in the radial wave
operator `\partial_r^2 + \frac{d-1}{r}\partial_r`, which is why a shift by two is natural on both
sides. That coefficient carries the same `d-1` as the sphere-area exponent in `\eqref{gauss}`. So
**one integer, `d-1`, is the source of the Gauss-law exponent, the ladder's step, and Huygens'
parity.** A genuine structural observation, already in the repo, and not an argument about
dimensionality. Anything stronger would be the AI inventing physics, which this repo forbids.

---

## 7. Where, if anywhere, this belongs in toesnail

The ratified 11-step TOE skeleton (2026-07-07, `TODO.md id:57e2`) has no "why 3+1" step. Three
options, each with its cost, and **the choice is the owner's**:

- **Nothing.** Cost: a reader meeting the WiRoHSH parity and the Huygens parity in the same repo
  asks the question anyway and probably answers it wrongly, the failure mode the sibling flagged.
  Benefit: zero maintenance, zero commitment to anthropic reasoning.
- **An epigraph or footnote at the spine's dimension-fixing step.** Two sentences: `d = 3` is where
  Ehrenfest stability and sharp Huygens intersect, and this is a stability argument, not a
  derivation. Cheapest, commits the theory to nothing. The option I would recommend if the owner
  wants any of it.
- **A full aside in `physics/`.** Cost: it is a survey of other people's arguments, while the spine
  is "math on demand" from the owner's own line. An aside deriving nothing the spine later uses
  would be the first section whose demand is never paid, exactly what the sibling
  [`spine.md`](spine.md) audits for. Benefit: the Ehrenfest computation is a nice worked example of
  an effective potential, and it is now fully formalised.

Whichever, `docs/dreamed/` is where it stays until the owner authors the move. Nothing from this
essay has been written into `TODO.md`, `ROADMAP.md`, or `REVIEW_ME.md`.

---

## 8. Follow-up leads

1. **Does the `d = 4` marginality survive a short-distance modification?** Tegmark's own escape
   hatch. Decidable by adding an `\epsilon/r^{d-1}` core to `\eqref{veff}` and rerunning
   `veffSecond_at_stationary`: if a stable minimum reappears, the "no atoms" claim is conditional
   on point particles and must be stated that way.
2. **Is `\eqref{ehrenfest}` coupling-free, or is that an artefact of the pure power law?**
   Decidable by redoing §1 with `V = -k/r^{p}` for `p \neq d-2`, which gives `(2-p)L^2/(mr_0^4)`
   (this is what the Lean theorem actually proves, with `p = q+1`). The criterion is then `p < 2`
   and `d` enters only through Gauss's law, relocating the argument from "`d`" to "the exponent"
   and sharpening objection 5(b).
3. **What is the tail's actual information cost?** §3 calls even-`d` propagation "degraded" with no
   number. Decidable by computing the channel capacity of the 2D Poisson kernel against the 3D
   delta kernel at fixed bandwidth; a finite loss ranks the wave argument permanently below §1.
4. **Does anything change off the integers?** `\eqref{ehrenfest}` holds for real `d` and still says
   `d < 4`, while `\eqref{huygens-parity}` has no meaning there. Decidable by asking which argument
   a fractal-dimension model can even state: the survivor is the one that does not use parity.
5. **Is there any argument for `d = 3` that is not anthropic?** Decidable only negatively: a survey
   finding that every published argument reduces to habitability plus a fixed law form would settle
   §5(a) as terminal, and shrink this whole essay to one paragraph.

---

## Lean attestation

Every `\lean` badge above refers to [`lean/Dimensionality.lean`](lean/Dimensionality.lean),
namespace `Dimensionality`.

| handle | definitions and theorems | content |
|---|---|---|
| `gauss` | `sphereArea`, `gauss_field_magnitude`, `hasDerivAt_coulomb`, `gauss_matches_coulomb` | flux conservation gives `|F| \propto r^{1-d}`; that is `-V'` for `V = -k/r^{d-2}`; the constants agree iff `Q/S = (d-2)k` |
| `veff` | `Veff`, `VeffFirst`, `VeffSecond`, `hasDerivAt_Veff`, `hasDerivAt_VeffFirst` | the effective potential and both radial derivatives, as `HasDerivAt` witnesses with `r \neq 0` named |
| `ehrenfest` | `veffFirst_eq_zero_iff`, `veffSecond_at_stationary` | at any stationary radius, `V_eff'' = (4-d)L^2/(mr^4)`, general `d = q+3` |
| `ehrenfest-ineq` | `stable_dim_three`, `marginal_dim_four`, `dim_four_stationary_forces`, `unstable_dim_ge_five`, `stationary_radius_dim_three/five/six` | stable at `d=3`, zero at `d=4` (and stationarity there forces `L^2 = 2km`), strictly negative for all `d \geq 5`, with the `d = 3, 5, 6` radii exhibited |
| `huygens-parity` | `SharpHuygens`, `sharpHuygens_three/five`, `not_sharpHuygens_one/two/four`, `sharpHuygens_odd`, `odd_not_sharpHuygens_iff`, `three_unique` | the decidable predicate, `d = 1` as the unique odd failure, and `d = 3` as the unique dimension both `\leq 3` and sharp-Huygens |
| (§4) | `PDEClass`, `pdeClass`, `pdeClass_our_world`, `pdeClass_no_time`, `pdeClass_two_times`, `pdeClass_tachyon_case`, `pdeClass_hyperbolic_of_one_time`, `pdeClass_ultrahyperbolic_of`, `not_hyperbolic_of_two_times` | Tegmark's Figure 1 as arithmetic on `(n,m)`. Deliberately **unbadged in the prose**: it proves the classification, not the physics |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Dimensionality.lean
```

**Exit status 0**, silent, zero `sorry`, zero warnings.

**Out of scope, and what was weakened.**

- The `\Gamma`-function constant in the sphere area is **not** in Lean; `sphereArea` carries an
  abstract `S`, so only the `r` dependence is claimed. §1.1 says so.
- `stationary_radius_dim_three/five/six` state the radius in **cleared-denominator form**
  (`kmr = L^2`, `L^2r = 3km`, `L^2r^2 = 4km`) instead of `r = \ldots`. Same content, no division or
  square root in the statement. This is the one place I shrank a statement rather than fight the
  algebra.
- `unstable_dim_ge_five` is conditional on a stationary radius existing. General-`d` existence needs
  a real power root and is not formalised; `d = 5, 6` are exhibited so the theorem is not vacuous.
- §2 is **SymPy only**: no Hilbert space, no spectrum, no Tangherlini result in Lean.
- §3's physics is **not** in Lean. Lean fixes the sharp-Huygens *predicate*; the support property of
  the fundamental solution is classical analysis, cited not proved. §4's Asgeirsson step is likewise
  absent by design, `pdeClass` being bookkeeping on signature counts.
- Per [`docs/dreamed/README.md`](README.md), these badges attest the dreamed Lean file and the
  SymPy runs recorded here only. They are **not** wired into `physics/*.toml` or
  `tests/test_verify.sh`.

## `.mw` sketch

What a future `.mw` document would carry, so the essay is `.mw`-linkable:

```computation
Veff = L**2/(2*m*r**2) - k/r**(d-2)
```

```computation
stationary = solve(Eq(diff(Veff, r), 0), r)
```

```computation
curvature = simplify(diff(Veff, r, 2).subs(k, L**2*r**(d-4)/(m*(d-2))))
```

```computation
radial_reduction = expand((diff(psi,r,2) + (d-1)/r*diff(psi,r) - l*(l+d-2)/r**2*psi) / r**(-(d-1)/2))
```

The DAG edge that matters: `curvature` depends on `Veff` **through the stationarity substitution**,
not through a textual reference, so an edit to the potential's exponent (a screened
`exp(-r/a)/r^(d-2)`, say) marks `curvature` stale while `stationary` still looks fine. That is the
staleness a human misses, and the same failure class as this repo's `edot` propagation witness.

## Sources consulted

- [M. Tegmark, "On the dimensionality of spacetime", Class. Quantum Grav. **14**, L69 (1997)](https://iopscience.iop.org/article/10.1088/0264-9381/14/4/002), preprint [arXiv:gr-qc/9702052](https://arxiv.org/abs/gr-qc/9702052). Fetched and read in full for §4.
- Cited by Tegmark, **not read directly**: P. Ehrenfest, Proc. Amsterdam Acad. **20**, 200 (1917) and Ann. Physik **61**, 440 (1920) [4]; F. R. Tangherlini, Nuovo Cim. **27**, 636 (1963) [5]; L. Asgeirsson, Math. Ann. **113**, 321 (1936) [13]; R. Courant and D. Hilbert, *Methods of Mathematical Physics* (Interscience, 1962) [12].
- [`wirohsh-ladder.md`](wirohsh-ladder.md), for the ladder parity, the `d = 1` Huygens exception,
  and the `(d-1)/r` common cause; [`q2-galilei-vs-poincare.md`](q2-galilei-vs-poincare.md), for the
  signature side of the same question (`TODO.md id:57e2` Q2).
