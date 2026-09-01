---
title: Acoustics pilot 2, dreamed
permalink: /dreamed/acoustics
---

# Acoustics as pilot #2: a candidate marking inventory, and why the matched quantity is not the index

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, from an
> owner-picked seed: `physics/acoustics.md` (ROADMAP "Acoustics pilot #2", explicitly **human-only**
> for marker placement) plus his physics.SE [q/787284](https://physics.stackexchange.com/q/787284)
> ("What are the Fresnel formulas for acoustics?", `docs/se-corpus.md` row **P-K**). This essay
> **proposes markers; it places none.** Every table below is a menu for the owner to accept, edit, or
> reject. The sibling [`wirohsh-refraction.md`](wirohsh-refraction.md) reaches the acoustic impedance
> through the Wick-rotated transmission problem; this file takes the direct time-domain route and
> audits the seed file itself, and does not repeat the sibling's optics.

## 0. Headline

Three findings, stated up front. **First**, `physics/acoustics.md` never derives the wave equation:
the chain stops at the linearized equations plus the Helmholtz continuity argument, so the object
pilot #2 would most naturally verify does not yet exist in the file, and $c$ enters only through the
definition $c^2/\gamma := nRT/m$. That definition silently **is** the adiabatic (Laplace) choice: for
an ideal gas $p/\rho = RT/M$ equals $c^2/\gamma$ precisely when $c^2 = \gamma p/\rho$, so the
$\gamma$ in the notation presupposes Laplace's correction without the adiabatic assumption ever being
stated. **Second**, the derivation chain classifies cleanly into identities (SymPy-dischargeable),
approximations with a nameable small parameter, and modeling assumptions (owner-territory); the
classification is the candidate marking inventory of §2, twelve rows. **Third**, the acoustic Fresnel
problem at normal incidence gives $r = (Z_2-Z_1)/(Z_2+Z_1)$ with $Z = \rho c$, and because $\rho$ and
$c$ are independent material knobs, **an impedance-matched interface with $c_1 \neq c_2$ reflects
nothing while still refracting**. Optics at normal incidence cannot do this: for nonmagnetic media
$Z = Z_0/n$, so matching the impedance forces matching the index. All of §3-§4 is Lean-attested
(six theorems, zero sorries, attestation at the end).

## 1. The chain `physics/acoustics.md` actually asserts

Link by link, with a classification each. **I** = identity (mechanically dischargeable),
**A($\epsilon$)** = approximation with small parameter $\epsilon$, **M** = modeling assumption
(owner-territory per the repo's ⚠ convention in `docs/rigor-debt.md`).

1. **Mass conservation** $\partial_t\rho + \vec\nabla\cdot(\rho\vec u) = q$ (the file's $\rho.0$).
   **M**: a physical postulate (with source term $q$), not derivable inside the file.
2. **Gauss step** $\iiint_V \vec\nabla\cdot(\rho\vec u)\,dV = \oiint_{\partial V}(\rho\vec u)\cdot d\vec n$.
   **I**: the divergence theorem, given smoothness. Already a `verify:sympy` candidate in
   `docs/rigor-debt.md`.
3. **Shoebox conclusion**: $\vec n\cdot(\rho\vec u)$ continuous across an interface. **A($\epsilon$)**
   in form (a pillbox limit $\epsilon\to 0$) resting on **M** (no singular surface source). The
   quantity is the normal mass flux; the file's gloss "conservation of perpendicular momentum" names
   the momentum density, but the conservation law doing the work is mass, not momentum (surfaced in §6).
4. **Navier-Stokes** with the advective identity
   $(\vec u\cdot\vec\nabla)\vec u = \tfrac12\vec\nabla u^2 - \vec u\times\vec\omega$. The equation is
   **M** (constitutive: Newtonian fluid); the underbrace identity is **I** and I confirmed it
   componentwise in 3D with SymPy (residuals exactly 0).
5. **The viscous coefficient** $+\tfrac13\vec\nabla(\vec\nabla\cdot\vec u)$. **M**: Stokes' hypothesis
   (zero bulk viscosity). The known $\tfrac13$-vs-$\tfrac12$ discrepancy against the linearized line
   is already sharpened in `docs/rigor-debt.md` (linearization is exactly linear, so it cannot change
   the coefficient); nothing new to add, the owner's ratification is pending.
6. **Ideal gas** $p = (c^2/\gamma)\rho$ with $c^2/\gamma := nRT/m$. The equation of state is **M**;
   the naming is a **definition** that smuggles in the adiabatic assumption (§4).
7. **Gradient identity** $\tfrac1\rho\vec\nabla p = \tfrac{c^2}\gamma\vec\nabla\ln\rho + \vec\nabla\tfrac{c^2}\gamma$.
   **I**: pre-confirmed by the 2026-07-07 SymPy probe recorded in `docs/rigor-debt.md`.
8. **Linearization** $\rho \to \rho_0 + \rho$ with $\rho_0 \gg \rho$ and $|d\rho_0| \ll |d\rho|$;
   $\vec u_0 = 0$. **A($\epsilon$)** with $\epsilon = \rho/\rho_0$ for the dropped quadratic terms,
   plus the **separate** gradient-scale assumption $|d\rho_0| \ll |d\rho|$ which licenses dropping
   $\vec u\cdot\vec\nabla\rho_0$ from $\vec\nabla\cdot(\rho_0\vec u) = \rho_0\vec\nabla\cdot\vec u + \vec u\cdot\vec\nabla\rho_0$
   (the split itself is **I**, SymPy-confirmed above). The $\vec u_0 = 0$ clause is the **M** tension
   the owner already flags in his own parenthesis.
9. **The dangling vorticity line** "$\Rightarrow \partial_t\vec\omega$" ends the linearization block
   with no right-hand side. Not markable: an unfinished claim, not a wrong one.
10. **Green's first identity** step ($\vec\Gamma = \vec n$). **I**, rigor-debt candidate already.
11. **Helmholtz continuity argument** ($\vec f$ singularity-free $\Rightarrow$ $\phi$, $\vec a$
    continuous). A structured **I**-chain over pillbox/rectangle limits; the vector identity inside it
    is pre-confirmed per rigor-debt; the assembled argument is the file's standing `verify:lean` candidate.
12. **The wave equation**: absent. Combining $\partial_t(\rho.1)$ with the divergence of the
    linearized momentum equation (inviscid, no gravity, no source) would give
    $\partial_t^2\rho = c^2\Delta\rho$; the file stops one step short.

## 2. Candidate marking inventory (a proposal, nothing more)

**Placing any of these markers in `physics/acoustics.md` is the owner's call**; per the repo's own
ladder an open-debt badge names the *desired* verifier (`\sympyc`/`\numericc`/`\leanc`) and is never
`\sympy` before the instrument greens. Rows marked ⚠ have no badge on purpose: they are modeling
choices, tracked prose-side like the existing rigor-debt entries. Handles are suggestions in the
repo's content-meaningful style.

| # | handle | claim (one line) | class | proposed badge | instrument that would discharge it |
|---|---|---|---|---|---|
| 1 | `mass` | $\partial_t\rho + \vec\nabla\cdot(\rho\vec u) = q$ | M | none (⚠ postulate) | none; it is the axiom |
| 2 | `massflux` | Gauss step $\iiint\vec\nabla\cdot(\rho\vec u) = \oiint(\rho\vec u)\cdot d\vec n$ | I | `\sympyc` | SymPy on a symbolic box, or cite Mathlib divergence thm for `\leanc` |
| 3 | `shoebox` | $\vec n\cdot(\rho\vec u)$ continuous at an interface | A + M | `\leanc` | pillbox limit as a Lean statement; too analytic for SymPy |
| 4 | `advective` | $(\vec u\cdot\vec\nabla)\vec u = \tfrac12\vec\nabla u^2 - \vec u\times\vec\omega$ | I | `\sympyc` | componentwise 3D SymPy (pre-run here: residuals 0) |
| 5 | `stokes13` | viscous term is $\nu[\Delta\vec u + \tfrac13\vec\nabla(\vec\nabla\cdot\vec u)]$ | M | none (⚠) + `\sympyc` for the $\tfrac12$/$\tfrac13$ transcription check | already sharpened in rigor-debt; owner ratifies |
| 6 | `idealgas` | $p = (c^2/\gamma)\rho$, $c^2/\gamma := nRT/m$ | M + def | `\definition` **only if** the adiabatic content moves to its own row 12 | see §4; `\definition` must not absorb a real claim |
| 7 | `gradp` | $\tfrac1\rho\vec\nabla p = \tfrac{c^2}\gamma\vec\nabla\ln\rho + \vec\nabla\tfrac{c^2}\gamma$ | I | `\sympyc` | instrument exists in spirit (2026-07-07 probe ✓); greens on arrival |
| 8 | `linmass` | $(\rho.1)$: dropped terms are $O(\epsilon^2)$ and $O(\vec u\cdot\vec\nabla\rho_0)$ | A($\rho/\rho_0$) | `\sympyc` | SymPy order-bookkeeping: expand, collect in $\epsilon$, exhibit the residual |
| 9 | `linmom` | linearized momentum equation as written | A + suspect | `\sympyc` | the rigor-debt linearity probe, once row 5 is ratified |
| 10 | `green1` | $\vec\Gamma=\vec n \Rightarrow \iiint(\vec n\cdot\vec\nabla)\psi = \oiint\psi\,d\sigma$ | I | `\sympyc` | symbolic surface/volume pair on a box |
| 11 | `helmholtz-cont` | singularity-free $\vec f$ $\Rightarrow$ $\phi,\vec a$ continuous | I-chain | `\leanc` | structured Lean proof (standing rigor-debt candidate) |
| 12 | `waveq` | $\partial_t^2 p = c^2\Delta p$ from rows 6+8+9 | absent | `\leanc` once authored | the owner writes the step; `Acoustics.lean` §5 pilots the shape |

Rows 13-16 below (`fresnel-n`, `fresnel-energy`, `zmatch`, `newton-laplace`) would belong to the new
Fresnel section that corpus row P-K already earmarks ("new section/citation"); they are derived and
Lean-closed in this essay so the owner can see what he would be signing before writing a line.

## 3. The acoustic Fresnel problem, and what has no optical analogue

Normal incidence on a plane interface at $x=0$, medium 1 on the left. Linear acoustics gives each
plane wave the impedance relation $p = \pm Z u$ ($+$ rightward, $-$ leftward) with
$Z = \rho c$, from the linearized momentum equation $\rho_0\partial_t u = -\partial_x p$. Write the
incident, reflected, transmitted pressure amplitudes as $1, r, t$. The interface conditions are the
two continuities the seed file itself supplies the tools for: pressure continuity (from the momentum
equation, no surface mass) and normal-velocity continuity (the file's own boxed
$\vec n\cdot(\rho\vec u)$ argument, linearized):

$$1 + r = t, \qquad \frac{1-r}{Z_1} = \frac{t}{Z_2} \veq{fresnel-n}\lean$$

Solving (SymPy: unique solution; Lean: `fresnel_from_matching`):

$$r = \frac{Z_2 - Z_1}{Z_2 + Z_1}, \qquad t = \frac{2Z_2}{Z_2 + Z_1} \quad\text{(pressure convention)}$$

Here $t$ is the transmitted/incident *pressure* ratio; the velocity convention has
$t_u = 2Z_1/(Z_1+Z_2)$ instead, and both satisfy their energy identity (SymPy-checked for both).
With intensity $I = p^2/Z$ per medium, energy conservation is

$$r^2 + \frac{Z_1}{Z_2}\,t^2 = 1 \veq{fresnel-energy}\lean$$

```computation
r = (Z2 - Z1)/(Z2 + Z1)
t = 2*Z2/(Z2 + Z1)
energy_residual = r**2 + (Z1/Z2)*t**2 - 1   # == 0, SymPy simplify, Z1,Z2 > 0
```

**The asymmetry.** Reflection sees only $Z = \rho c$; refraction sees only $c$ (Snell:
$\sin\theta_t/\sin\theta_i = c_2/c_1$). In acoustics these are independent material knobs, so

$$r = 0 \iff Z_1 = Z_2, \quad\text{with no constraint on } c_1, c_2 \veq{zmatch}\lean$$

An interface with $\rho_1 c_1 = \rho_2 c_2$ but $c_1 \neq c_2$ (Lean witness: $\rho_2 = \rho_1/2$,
$c_2 = 2c_1$) is **invisible to reflection while refracting the ray** and halving the wavelength. In
optics at normal incidence this is impossible for nonmagnetic media: $Z = Z_0/n$ locks impedance to
index, so $Z_1 = Z_2 \iff n_1 = n_2 \iff c_1 = c_2$, and $r = (n_1-n_2)/(n_1+n_2)$ is the same
formula wearing the lock. (The sibling essay reaches the same $Z$ through the Wick-rotated weight
$1/\rho$; this is the time-domain face of its `acoustic-impedance` line.) What the decoupling buys
physically, with numbers from the ideal-gas relations $Z \propto 1/\sqrt T$, $c \propto \sqrt T$ at
fixed pressure:

- **A $+10\,$K warm-air layer** changes $c$ by 1.7% (strong refraction: this is why sound ducts over
  cold lakes at night) while reflecting only $R = r^2 \approx 7\cdot10^{-5}$ of the energy. Sound
  bends around temperature structure it barely echoes from; light through the same layer refracts
  about a thousand times more weakly ($n_{\text{air}} - 1 \approx 3\cdot10^{-4}$ scales with $\rho$).
- **Air to water** is the opposite regime: $Z_{\text{air}} \approx 413$ rayl,
  $Z_{\text{water}} \approx 1.5\cdot10^6$ rayl, so $R \approx 99.9$% and about $10^{-3}$ of the
  energy crosses; hence ultrasound gel (displace the air film, match the skin) and anechoic/antisonar
  coatings (grade $Z$ so no interface is sharp).

Oblique incidence, the actual question of q/787284, is deliberately left as a lead (§7): the same two
continuities plus Snell give the Rayleigh formula, and the density contrast buys an *intromission
angle* of total transmission that the scalar optical problem does not have.

## 4. Newton against Laplace, and which side the seed file is on

The "math on demand" moment the file walks past: what is $c$? Newton (1687) took the compression
isothermal, $c_{\text{iso}} = \sqrt{p/\rho}$; Laplace supplied the adiabatic correction
$c_{\text{ad}} = \sqrt{\gamma p/\rho}$. For air at 20 °C ($p = 101{,}325\,$Pa,
$\rho = 1.204\,$kg/m³ from the ideal-gas law, $\gamma = 1.4$):

$$c_{\text{iso}} = 290.1\ \text{m/s}, \qquad c_{\text{ad}} = 343.2\ \text{m/s}, \qquad \frac{c_{\text{ad}}}{c_{\text{iso}}} = \sqrt\gamma = 1.18322 \veq{newton-laplace}\lean$$

Newton is low by $1 - 1/\sqrt\gamma = 15.5$% against the measured value (equivalently Laplace exceeds
Newton by $\sqrt\gamma - 1 = 18.3$%; both percentages circulate, they are the same fact divided by
different denominators). Which assumption does `physics/acoustics.md` make? **Both and neither,
by notation**: $p = (c^2/\gamma)\rho$ is the isothermal ideal-gas law (correct for the *ambient
state*), but naming the constant $c^2/\gamma$ is only right if $c^2 = \gamma p/\rho$, i.e. if the
*propagating* compressions are adiabatic. The adiabatic assumption is therefore present, load-bearing,
and never stated; and since the wave equation is never derived, nothing in the file ever confirms
that this $c$ is the propagation speed. That is a located finding (§6), not an error: every symbol
is individually defensible, the file just never says why $\gamma$ is there.

## 5. What pilot #2 stresses in `.mw` that Resogram did not

Resogram is one ODE: six handles in an almost linear chain, one file, and the canonical staleness
witness was one sign fix propagating four hand-checkable discrepancies downstream. Acoustics is a
different shape of graph, and each difference is a specific `.mw` capability the Resogram pilot never
exercised:

1. **Fan-out staleness.** The `idealgas`/`gradp` node feeds $c$, which feeds `waveq`, `fresnel-n`,
   `fresnel-energy`, `zmatch`, and `newton-laplace` at once; ratifying the $\tfrac12\to\tfrac13$ fix
   invalidates several attestations in one edit. `stale_after_edit` must propagate transitively
   through a DAG with branching, not down a chain.
2. **Assumption nodes as first-class vertices.** Rows 1, 5, 6, 8 of §2 are assumptions, not
   equations. If the owner ever swaps Stokes' hypothesis or the adiabatic choice, every descendant
   claim is stale even though no *equation* text changed. Resogram had no assumption that anything
   downstream consumed; `.mw` currently hashes claims, not premises.
3. **Cross-file edges.** `fresnel-n` here, `acoustic-impedance` in the sibling essay, and the future
   Fresnel section in `physics/acoustics.md` are one claim in three files. Resogram was single-file;
   the sidecar grammar has no cross-file join yet beyond the handle string.
4. **A definition/claim type distinction.** Row 6 is a definition whose *change* must re-hash
   descendants but which itself can never "fail". The verify grammar currently only knows claims.
5. **PDE-tier Lean.** `HasDerivAt` witnesses were enough for the ODE pilot; `waveq` needs mixed
   partials and a Clairaut obligation (my §5 Lean skeleton names them as hypotheses precisely to show
   what the real proof owes).

## 6. Surfaced for the owner (findings only; nothing filed anywhere)

1. **The wave equation is absent** from `physics/acoustics.md`; the chain stops at linearization.
   Whether to add the closing step (§1 row 12) is a content decision.
2. **The adiabatic assumption enters only through the notation** $c^2/\gamma := nRT/m$ (§4). If the
   file is meant to teach "math on demand", Newton-vs-Laplace is arguably the payoff being skipped.
3. **"Conservation of perpendicular momentum"** (below the shoebox box) labels a mass-conservation
   consequence with momentum's name; $\rho\vec u$ is both mass flux and momentum density, but the law
   used is $\rho.0$.
4. **The dangling "$\Rightarrow \partial_t\vec\omega$"** line has no right-hand side; unfinished, not wrong.
5. **Front-matter spelling**: `title: Accoustics`, `permalink: /Accoustics` (double c). The permalink
   is a public URL, so even if the spelling is unintended, changing it breaks links; owner's trade-off.
6. The $\tfrac12$-vs-$\tfrac13$ viscous coefficient and the $\vec u_0 = 0$ tension are **already** in
   `docs/rigor-debt.md`; nothing new was found on either, and this essay adds no second copy of them.

## 7. Leads

1. **Oblique acoustic Fresnel (the real q/787284 ask):** derive
   $r(\theta) = (Z_2\cos\theta_i - Z_1\cos\theta_t)/(Z_2\cos\theta_i + Z_1\cos\theta_t)$ from the same
   two continuities plus Snell; decidable by SymPy against the Rayleigh formula. Landing it in
   `physics/acoustics.md` as the P-K section is owner-only.
2. **Intromission angle:** solve $r(\theta) = 0$; a Brewster-like total-transmission angle exists for
   a scalar wave iff the $(\rho_2/\rho_1, c_2/c_1)$ contrast lies in a computable region. Decidable
   as a `\sympyc` existence condition; interesting because scalar waves have no polarization to blame.
3. **Attenuation from the kept viscous term:** plane-wave ansatz in the linearized equations gives
   $\alpha \propto \nu\omega^2/c^3$; decidable by a SymPy dispersion-relation computation. Whether the
   file wants viscosity beyond the linearization is owner direction.
4. **`linmass` order-bookkeeping instrument:** mechanical once the owner blesses row 8's framing of
   the two distinct smallness assumptions; the instrument is a 20-line SymPy expansion.
5. **Row 12 in Lean for real:** upgrade `wave_from_linear_chain` from named-hypothesis skeleton to
   actual two-variable calculus (Clairaut via `ContDiff`). Decidable purely in Mathlib; worth doing
   only if the owner authors the prose step it would attest.

Leads 1, 3, 4, 5 have mechanical cores; every landing in `physics/` is owner-only, and lead 2's
region boundary is owner-interpretation once computed.

## Lean attestation

Proved in [`docs/dreamed/lean/Acoustics.lean`](lean/Acoustics.lean), namespace `DreamedAcoustics`:

| handle | theorem | content |
|---|---|---|
| `fresnel-n` | `fresnel_from_matching` | the two matching conditions force $r=(Z_2-Z_1)/(Z_2+Z_1)$, $t=2Z_2/(Z_2+Z_1)$, with $Z_1,Z_2>0$ named |
| `fresnel-energy` | `fresnel_energy` | $r^2 + (Z_1/Z_2)t^2 = 1$ (pressure convention) |
| `zmatch` | `matched_no_reflection` | $r = 0 \iff Z_1 = Z_2$ |
| `zmatch-c` | `matched_despite_refraction`, `matched_refracting_witness` | $\rho_1c_1=\rho_2c_2 \Rightarrow r=0$ with no hypothesis on $c_1$ vs $c_2$; witness with $c_2 = 2c_1$ |
| `newton-laplace` | `laplace_newton_ratio`, `sqrt_gamma_air_bounds` | $\sqrt{\gamma p/\rho} = \sqrt\gamma\sqrt{p/\rho}$; $1.183 < \sqrt{1.4} < 1.184$ |
| `waveq` | `right_mover_t`, `right_mover_tt`, `wave_from_linear_chain` | d'Alembert right-mover's first and second time derivative from `HasDerivAt` witnesses; the algebraic skeleton continuity + momentum + state + Clairaut $\Rightarrow p_{tt} = c^2 p_{xx}$, each calculus step a named hypothesis |

Checked with (exit 0, zero `sorry`):

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Acoustics.lean
```

Deliberate weakenings, stated: `wave_from_linear_chain` assumes its four calculus facts as named
hypotheses (it is the algebra tier of `waveq`, not the PDE proof); `right_mover_tt`'s claim about the
second *x*-derivative is stated in prose, proven only for the *t*-side; and the interface conditions
in `fresnel_from_matching` are hypotheses, their derivation from the PDE being the shoebox story the
owner's file supplies in nonlinear form. SymPy cross-checks run for this essay: matching-condition
solve (unique, matches), both energy conventions (residual 0), the `advective` identity (3D
componentwise, residuals 0), the linearization product-rule split (residual 0), and all numbers in
§3-§4 (air at 20 °C, warm-layer and air/water reflectances).
