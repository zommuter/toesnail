---
title: "Q2 -- Galilei-first, Poincare-first, or hybrid"
permalink: /dreamed/q2-galilei-vs-poincare
---

# Q2: Galilei-first, Poincare-first, or hybrid?

**DREAMED, UNREVIEWED.** Written by an AI agent, not by the owner, not read by him.
Status contract and hard rules: [`docs/dreamed/README.md`](README.md). Nothing here is
theory and nothing here is a decision. **The choice this essay is about belongs to the
owner and this essay does not settle it.**

Seed: the open owner decision `TODO.md` `id:57e2`, sub-question **Q2/D2**, open since
2026-07-07. The brief was to elaborate *every* branch far enough that the owner can
choose by reading rather than by imagining, and to look hard for a decisive technical
asymmetry instead of producing a taste verdict.

---

## 0. What is already ratified, and therefore not up for grabs

Checked verbatim against `docs/meeting-notes/2026-07-07-1228-toe-roadmap-evaluation.md`
§7, not against any later restatement. The four ratified decisions that constrain this
one:

- **D1 (Q1, route + voice).** Routes chosen for *maximum non-physicist accessibility
  while staying precise*; re-occurring **methodology themes** are the connective tissue.
  The candidate theme set explicitly names **"deform & contract"** and cross-references
  D2. The concrete Fock-vs-counting call is *subordinated to whichever reads better for
  a layperson*, with ladder operators as a later "we already knew this" callback.
- **D3 (Q3, tags).** `[derivation]/[input]/[hypothesis]` becomes a machine-greppable
  marker family designed with `.mw`, on a *different axis* from `\veq` verification
  tiers.
- **D4 (Q4, audience): "everyone."** Determined laypersons must be able to follow with
  no prior knowledge; math-comfortable physicists still take something away via
  **skippable "trivial maths" sections that remain enjoyable as entertainment**.
  Owner's phrase: "ars mathematica like yet readable".
- **D5 (Q5, love wing).** Mathematical in sensible measure, veering to simulations and
  game theory; `essays/` stays the parallel non-mathematical track.

**One correction to the seed brief.** The brief said hybrid is "flagged for owner" and
that the AI's finding favours Galilei-first or hybrid. The note says exactly that:
*"Given D4's audience call, the AI's finding is that Galilei-first or hybrid fit better;
**owner decides**."* So there is already a prior AI recommendation on record. Anything
this essay says has to be read as *revising or confirming a recommendation that already
exists*, not as a first opinion. That matters: a fresh-looking verdict that quietly
contradicts a recorded one, without saying so, is exactly the derived-doc drift the
global instructions warn about. **This essay does contradict it in part.** Section 10
says so explicitly and gives the reason.

**Two further constraints that bind any answer:**

1. The ratified **11-step skeleton** (note §5) puts Bargmann's central charge at
   **step 3** and Galilei-to-Poincare + Wigner classification at **step 5**. Any branch
   that renumbers those steps is a bigger change than Q2 was scoped to be.
2. `docs/meeting-notes/2026-07-07-1318-math-on-demand-curriculum.md` records, as its
   first cross-cutting observation, that **step 3 is the corpus gap**: "none yet -- this
   step is the largest *gap* in the corpus". Every other step has at least one
   exercising file.

---

## 1. What all three branches must deliver

Independent of ordering, the spine has to get the reader from "states are rays" (step 2)
to "particles are irreps labelled by mass and spin" (step 5). Four things must be
delivered somewhere:

| Deliverable | Why the spine cannot skip it |
|---|---|
| **Group acts on rays, not vectors** | Already forced at step 2 (D1's theme "states are rays, not vectors"). |
| **Projective representation** | The immediate consequence of the previous line. This is the machinery whose *placement* Q2 decides. |
| **Mass** | Without it there is no particle, no Schrodinger equation, no Klein-Gordon. |
| **Spin** | Needs the double cover `SU(2) -> SO(3)`, which is a projective-rep phenomenon in either branch. |

Note that **spin is branch-neutral**. The `SU(2)` double cover and the belt trick are
needed at step 3 whichever spacetime group comes first, because rotations sit inside
both groups identically. So Q2 is *not* "when do we introduce projective reps at all"
-- projective reps arrive at step 3 either way. Q2 is narrower and sharper:

> **Does the spine also need the theory of Lie-algebra *central extensions*
> (`H^2`, cocycles, coboundaries) at step 3, or can it defer that machinery?**

That is the question the rest of this essay answers.

---

## 2. Branch A -- Galilei-first

### A.1 Section skeleton for the spine's `## Symmetry / Noether / Gauge`

The spine's current text there is a one-sentence stub (`physics/toesnail.md:138-139`).
Branch A would fill steps 3 to 5 like this:

1. **"What does not change when I walk past?"** Everyday kinematics: `x -> x + vt + a`,
   `t -> t + b`. The reader writes down the Galilei transformations from experience, with
   no postulate. *Mathematics demanded:* composition of maps; the group axioms the reader
   already met at step 1.
2. **Compose two of them and count.** Boost-then-translate is not translate-then-boost.
   *Mathematics demanded:* non-commutativity, and the first honest commutator.
3. **Linearise.** Slow boosts are the identity plus a generator. *Mathematics demanded:*
   the generator = derivative at identity, the Lie bracket. This is where corpus rows
   **M-1** (`e^{a d/dx}`, dilation, curl as skew `so(3)`) and **M-2** (`d/dx e^{A(x)}`,
   BCH) get exercised. Both are promoted.
4. **The brackets close.** `[K,H] = P`, `[K,P] = 0`, `[H,P] = 0`. Three generators,
   nothing left over. *Mathematics demanded:* nothing new. The reader has a complete,
   small, closed algebra and feels finished.
5. **Now put it on rays.** The states are rays (step 2), so the representation is only
   defined up to a phase. The composed phase is a **2-cocycle**. *Mathematics demanded:*
   the full central-extension apparatus -- 2-cochain, cocycle condition, coboundary,
   "trivial means removable by redefining generators".
6. **The phase does not go away.** For Galilei, `[K,P] = 0` means no redefinition of
   generators can ever produce a `K`-`P` term, so a `K`-`P` phase is stuck. Name it `m`.
   *This is the payoff:* **mass is forced by representation theory, not assumed.** The
   algebra the quantum theory actually represents has a fourth generator, `[K,P] = M`,
   `M` central: the **Bargmann** algebra [B54].
7. **Superselection.** Because `M` is central and its eigenvalue labels the
   representation, superpositions of different masses carry an unremovable relative
   phase under a boost-translation loop: they are unphysical. The **mass superselection
   rule** falls out of the same line.
8. **Deform.** Ask what happens if `[K,P]` is *not* forced to vanish: put `[K,P] = eps*H`
   and demand the Jacobi identity still holds. It does, for every `eps`. Set
   `eps = 1/c^2` and the reader has just constructed the Poincare algebra as a
   **deformation** of the one they already own [IW53]. Relativity *arrives* rather than
   being postulated. This is D1's "deform & contract" theme paying its first dividend.
9. **The Casimirs.** In the deformed algebra, `H^2/c^2 - P^2` commutes with everything:
   mass reappears, now as a Casimir rather than a central charge. Wigner classification,
   `P^2` and `W^2`, corpus row **P-C** (promoted).

### A.2 What Branch A costs

- **Central extensions arrive at step 3**, in full, for a reader who has just met the
  word "representation". The cocycle/coboundary vocabulary is genuinely the hardest
  abstraction in steps 0 to 5, and D4's "everyone" audience meets it at its earliest
  possible position.
- **The reader learns a structure that is then superseded.** Step 8 above tells them the
  algebra they worked so hard on is the `c -> infinity` corner of a bigger one. That is
  narratively fine (it is how physics happened) but it is a second pass over the same
  material.
- **`M` does not survive the deformation.** The Bargmann central generator is not a
  generator of the Poincare algebra; mass changes its *type* between step 3 and step 5,
  from central charge to Casimir eigenvalue. Section 6 below shows this is a theorem, not
  a presentational wrinkle, and it is the single most awkward thing the branch has to
  narrate.
- **The corpus gap sits exactly here** (1318 note, cross-cutting observation 1). No
  owner-authored file exercises projective reps or Bargmann. Every worked example in
  steps 3 to 4 of this branch would have to be written from scratch.

### A.3 What Branch A buys

The step-6 moment is, on the merits, the most beautiful "math on demand" beat available
anywhere in steps 0 to 5. The reader is not told mass exists. They are shown that a phase
they cannot get rid of *is* mass. Nothing in Branch B is as good a demonstration of the
book's own thesis (Wigner's "unreasonable effectiveness" inverted: physics demands the
math).

---

## 3. Branch B -- Poincare-first

### B.1 Section skeleton

1. **"What does not change for anyone?"** The invariant is not duration but the
   interval. *Mathematics demanded:* a quadratic form, and D1's theme "look for what
   stays invariant" doing the work.
2. **The transformations that preserve it.** Boosts and rotations. *Mathematics
   demanded:* the same non-commutativity beat, same linearisation, same M-1/M-2 corpus
   exercise as A.3.
3. **The brackets close on what is already there.** `[K,H] = P`, `[K,P] = H/c^2`,
   `[H,P] = 0`. Ten generators in 3+1, no leftovers.
4. **Put it on rays.** The double cover: `SL(2,C) -> SO(1,3)` (and its restriction
   `SU(2) -> SO(3)`), the belt trick, spin-1/2. *Mathematics demanded:* projective reps
   as "the double cover fixes it", **without** cocycle vocabulary. The residual phase
   ambiguity is a sign, and a sign is a covering-group question, not a cohomology one.
5. **Casimirs.** `P^2` and `W^2` commute with everything. `P^2 = m^2 c^2` is mass;
   `W^2` gives spin. Corpus row **P-C** is the headline here, exactly as promoted for
   step 5.
6. **Wigner's classification.** Orbits of `P` in momentum space, little groups,
   helicity for `m = 0`. Corpus rows **P-D** (mass = Casimir `P^2`) and **P-F**
   (VSH under Poincare) attach.
7. **Contract.** Set `1/c^2 -> 0` and recover Galilei [IW53]. *Then* observe that the
   contracted Casimir has lost the mass, so the non-relativistic theory has to carry
   mass some other way -- and only now, with a reader who already owns "mass = Casimir",
   introduce the central extension and Bargmann as the *repair* of a defect the reader
   has just watched appear.

### B.2 What Branch B costs

- **Relativity is postulated, not motivated.** Step 1 asks the reader to accept the
  interval on authority. The Galilei on-ramp is genuinely more lay-friendly, and D4 is a
  ratified constraint, not a preference.
- **Wigner's classification lands before the reader has met a wave.** Step 6 of the
  ratified skeleton ("why fields") comes after step 5. Branch B has the reader classify
  particles as irreps before they have seen a single field equation. Corpus row P-C's own
  framing ("Casimir eigenvalue equations as field equations") half-repairs this: `P^2` on
  a rep *is* the Klein-Gordon equation, so the wave arrives as the Casimir's eigenvalue
  equation. That is a genuinely elegant repair, and it is the owner's own promoted
  material rather than an invention.
- **The `H^2 = 0` claim needs care in the retelling.** "Poincare has no central
  extensions" is true in 3+1 and **false in 1+1** (see section 6.3). A spine that
  motivates the branch on the strength of that slogan must state the dimension it holds
  in.

### B.3 What Branch B buys

Single pass. Mass and spin arrive together, as the two Casimirs, in the moment the
owner's own promoted corpus item was ratified to headline. The heavy cohomology
machinery is deferred to a step-7 aside where it repairs a *felt* defect.

---

## 4. Branch C -- and it is at least two different branches

"Hybrid" is not one option. The 1228 note's own hybrid sentence ("narrate Galilei for
intuition, do the rigor once at Poincare, present contraction as the bridge") is C1
below. C2 is a different architecture with a different cost.

### C1 -- Galilei as narrative on-ramp, Poincare as the only rigorous pass

Order: Galilei kinematics *informally* (steps 1 to 3 of Branch A, stopping before the
cocycle), then the interval, then Poincare done once and properly, then the contraction
back to Galilei, then Bargmann as the repair.

- **Cost:** exactly one revisit. The reader meets Galilei twice: once as intuition,
  once as a limit.
- **What it preserves:** D4's lay on-ramp (everyday kinematics first), the single
  rigorous pass, and the "deform & contract" theme (which now runs in the contraction
  direction, `c -> infinity`, which is the direction Inonu and Wigner actually wrote).
- **What it loses:** the step-6 Branch-A payoff moves from step 3 to roughly step 5.5.
  Mass is *first* met as a Casimir and only afterwards as a central charge, so "mass is
  forced by the representation theory" becomes a second, quieter beat rather than the
  first wow.
- **Corpus:** step 3 shrinks to spin/double-cover only, which the gap analysis says is
  the thinnest ice but is also the smaller half of it. Everything else attaches to
  promoted rows.

### C2 -- parallel columns

Develop both groups' representation theory side by side in a two-column chapter, so the
reader watches which assumptions each needs and where they diverge.

- **Cost:** high, and specifically high for D4. A two-column comparison presumes the
  reader can hold two unfamiliar structures at once and notice a *difference* between
  them. That is a physicist's reading mode. D4's determined layperson is being asked to
  learn two things before understanding either.
- **What it buys:** the comparison is the point, so the asymmetry of section 6 becomes
  visible content rather than an author's private reason.
- **Verdict on cost:** **C1 is clearly cheaper for the "everyone" audience.** C2 is
  excellent as a *skippable advanced aside* under D4's layered-reading convention (Q7's
  `advanced` layer), and poor as spine.

**A third hybrid worth naming, because it is nearly free.** C1-plus: run C1, and place
the C2 two-column comparison as exactly the kind of "trivial maths, still entertaining"
aside D4 asks for. The layered-reading mechanism the owner already ratified is what makes
the expensive option affordable in the cheap position.

---

## 5. The mathematics, stated

Everything below is checked. In 1+1 dimensions, with `H` the time-translation generator,
`P` the space-translation generator, `K` the boost, and `eps = 1/c^2`:

$$ [K,H] = P, \qquad [K,P] = \varepsilon\,H, \qquad [H,P] = 0 \veq{spacetime-brackets}\lean $$

These satisfy the Jacobi identity for every `eps`, so both ends of the family are honest
Lie algebras. Setting `eps = 0` gives the Galilei brackets exactly. That identity of
structure constants is the Inonu-Wigner contraction [IW53]:

$$ \big[\,\cdot\,,\,\cdot\,\big]_{\varepsilon=0} = \big[\,\cdot\,,\,\cdot\,\big]_{\text{Galilei}} \veq{contraction}\lean $$

A 2-cochain on this algebra is fixed by three numbers, `a = w(K,H)`, `b = w(K,P)`,
`d = w(H,P)`. Every one of them satisfies the cocycle condition, for every `eps`:

$$ \omega([X,Y],Z) + \omega([Y,Z],X) + \omega([Z,X],Y) = 0 \veq{cocycle}\lean $$

so `Z^2` is the whole 3-dimensional cochain space and the entire content of `H^2` is
which cochains are coboundaries. With `(\delta f)(X,Y) = -f([X,Y])`:

$$ (\delta f)(K,H) = -f_P, \qquad (\delta f)(K,P) = -\varepsilon\, f_H, \qquad (\delta f)(H,P) = 0 \veq{coboundary}\lean $$

**The `eps` in the middle equation is the whole question.** For `eps != 0` choose
`f_H = -b/eps` and the boost-translation central term `b` is a coboundary, removable by
redefining the energy generator:

$$ \omega_{K,P} = b \;=\; (\delta f)(K,P) \quad\text{with}\quad f_H = -b/\varepsilon \veq{poincare-coboundary}\lean $$

For `eps = 0` the right-hand side is identically zero, so for `m != 0`:

$$ \nexists\, f: \quad (\delta f)(K,P) = m \veq{galilei-mass-class}\lean $$

The mass is a nontrivial class. The algebra a quantum theory actually represents is the
four-generator Bargmann algebra, witnessed concretely by real 4x4 matrices acting on
`(t, x, xi, 1)`:

$$ H = E_{03}, \quad P = E_{13}, \quad K = E_{10} + E_{21}, \quad M = E_{23} \veq{bargmann-matrices}\lean $$

with `[K,H] = P`, `[K,P] = M`, `[H,P] = 0`, `M` central, and `M` **not** in the span of
`H, P, K`. Finally, `ad_K` acting as a derivation on quadratics in `H` and `P` annihilates

$$ C_{\varepsilon} = \varepsilon H^2 - P^2 = \tfrac{H^2}{c^2} - P^2 \veq{casimir-poincare}\lean $$

and this is the unique such quadratic up to scale. At `eps = 0` every annihilated
quadratic has zero `H^2` coefficient:

$$ \mathrm{ad}_K\,q = 0 \;\wedge\; \varepsilon = 0 \;\Longrightarrow\; \alpha_{H^2} = 0 \veq{casimir-galilei-blind}\lean $$

The contracted Casimir is blind to energy. **Mass does not survive the contraction as a
Casimir, which is precisely why the Galilei side has to recover it from the central
extension instead.** The two facts are the same fact seen from two sides.

### The computation

```computation
# Structure constants of the 1+1 spacetime algebra, eps = 1/c^2.
# X = (h, p, k) means X = h*H + p*P + k*K.
bracket = lambda X, Y: (eps*(X[2]*Y[1] - X[1]*Y[2]), X[2]*Y[0] - X[0]*Y[2], 0)

# Jacobi holds identically in eps  ->  [0, 0, 0]
jacobi = bracket(bracket(X,Y),Z) + bracket(bracket(Y,Z),X) + bracket(bracket(Z,X),Y)

# 2-cochain with w(K,H)=a, w(K,P)=b, w(H,P)=d
omega = lambda X, Y: d*(X[0]*Y[1]-X[1]*Y[0]) + a*(X[2]*Y[0]-X[0]*Y[2]) + b*(X[2]*Y[1]-X[1]*Y[2])

# Cocycle condition  ->  0, identically, for every eps
cocycle = omega(bracket(X,Y),Z) + omega(bracket(Y,Z),X) + omega(bracket(Z,X),Y)

# Coboundary of f  ->  (K,H) = -f_P ,  (K,P) = -eps*f_H ,  (H,P) = 0
coboundary = lambda X, Y: -(f_H*bracket(X,Y)[0] + f_P*bracket(X,Y)[1] + f_K*bracket(X,Y)[2])

# rank of the coboundary map:  2 at eps=1, 1 at eps=0
# dim Z^2 = 3  =>  dim H^2 = 1 (Poincare 1+1)   vs   2 (Galilei 1+1)

# ad_K on quadratics alpha*H^2 + beta*H*P + gamma*P^2
adK = lambda al, be, ga: (eps*be, 2*al + 2*eps*ga, be)
casimir = adK(eps, 0, -1)          # -> (0, 0, 0):  eps*H^2 - P^2
galilei_kernel = solve(adK(al, be, ga).subs(eps, 0))   # -> alpha = 0, beta = 0
```

Run 2026-09-01 with SymPy under `uv run --with sympy`. Verdicts, verbatim: Jacobi
`[0, 0, 0]`; cocycle condition `0`; coboundary on basis pairs `-f_P`, `-eps*f_H`, `0`;
`dim B^2 = 2` at `eps != 0` and `1` at `eps = 0`, so `dim H^2 = 1` (Poincare) versus `2`
(Galilei); Poincare solution `f_H = -b/eps`; `ad_K` kernel `{alpha: -eps*gamma,
beta: 0}` in general and `{alpha: 0, beta: 0}` at `eps = 0`; the 4x4 Bargmann matrices
give `[K,H] - P = 0`, `[K,P] - M = 0`, `[H,P] = 0`, `M` central `True True True`, and
`rank{H,P,K} = 3` versus `rank{H,P,K,M} = 4`.

## Lean attestation

All `\veq{...}\lean` badges above refer to
[`docs/dreamed/lean/Q2Symmetry.lean`](lean/Q2Symmetry.lean) and to nothing else. They are
**not** wired into the repo's `verify/` sidecar machinery, per the `docs/dreamed/`
contract.

Command, from `verify/`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Q2Symmetry.lean
```

**Exit status 0, no output, zero `sorry`, zero warnings** (run 2026-09-01).

| Handle | Theorem(s) |
|---|---|
| `spacetime-brackets` | `br_K_H`, `br_K_P`, `br_H_P`, `br_antisymm`, `jacobi_h`, `jacobi_p`, `jacobi_k` |
| `contraction` | `contraction`, `galilei_br_K_P` |
| `cocycle` | `cochain_is_always_a_cocycle` |
| `coboundary` | `cob_K_H`, `cob_K_P`, `cob_H_P` |
| `poincare-coboundary` | `poincare_KP_is_a_coboundary`, `poincare_KP_is_a_coboundary_basis`, `dim_H2_poincare_is_one` |
| `galilei-mass-class` | `galilei_KP_coboundary_vanishes`, `galilei_mass_is_not_a_coboundary`, `branch_asymmetry` |
| `bargmann-matrices` | `bargmann_K_H`, `bargmann_K_P`, `bargmann_H_P`, `bargmann_M_H`, `bargmann_M_P`, `bargmann_M_K`, `bargmann_M_not_in_span` |
| `casimir-poincare` | `casimir_poincare`, `casimir_unique` |
| `casimir-galilei-blind` | `casimir_galilei_blind` |

**What was weakened, stated plainly.** Everything is 1+1 dimensional. `H^2` is modelled
by hand as an explicit three-parameter cochain space with an explicit coboundary map, not
via Mathlib's Lie-algebra cohomology. The `casimir_*` block is a coefficient model of
`ad_K` acting on quadratics in two commuting generators, not the universal enveloping
algebra. No projective unitary representations, no Wigner theorem, no group-to-algebra
cocycle passage, no superselection rule, no `W^2`. The file's header lists all of this.

---

## 6. The decisive comparison

Criteria taken from the ratified decisions, not from taste. Scores: `++` strong, `+`
positive, `o` neutral, `-` cost, `--` significant cost.

| Criterion (source) | A: Galilei-first | B: Poincare-first | C1: on-ramp hybrid | C2: parallel columns |
|---|---|---|---|---|
| **Math on demand** -- is each structure demanded by a question already posed? (owner's stated intent, note §1) | `++` cocycles are demanded by a phase the reader watched fail to cancel | `+` Casimirs demanded; the interval is postulated | `++` same demand, arriving where the defect is felt | `o` the comparison itself is not a physics question |
| **D4 "everyone", lay on-ramp** | `++` everyday kinematics | `-` interval on authority | `++` everyday kinematics | `--` two structures before either is understood |
| **D4 "everyone", peak abstraction early** | `--` central extensions at step 3 | `+` deferred to step 7 aside | `+` deferred to ~5.5 | `--` doubled |
| **D4 physicist layer still rewarded** | `+` Bargmann is the treat | `+` Wigner is the treat | `+` both | `++` this is the physicist's chapter |
| **Exercises promoted corpus P-C** (Casimirs as field equations, ratified step-5 headline) | `+` arrives at step 9 of the branch | `++` lands exactly where promoted | `++` lands where promoted | `+` |
| **Exercises promoted corpus P-A, M-1, M-2** (discrete Noether; generators, BCH) | `+` | `+` | `+` | `+` -- branch-neutral, all three linearise a group |
| **Corpus gap at step 3** (1318 note, obs. 1) | `--` the branch's centrepiece is the gap | `+` step 3 shrinks to spin/double cover | `+` same | `-` needs the gap material anyway |
| **Fits the 11-step skeleton without renumbering** | `++` Bargmann at 3, Wigner at 5, as written | `-` Bargmann moves out of step 3 into a 5/7 aside | `-` same displacement | `-` same |
| **Serves D1 theme "deform & contract"** | `++` deformation, forward direction | `+` contraction, historical direction | `++` both directions, one each | `+` |

Two rows deserve reading against each other. **Branch A is the only one that fits the
ratified skeleton without moving Bargmann out of step 3** -- and step 3 is precisely
where the owner has no corpus. Branch A's structural fidelity and its material scarcity
are the same cell.

---

## 7. The one fact that might settle it on its own

There is a real technical asymmetry, and it is not a matter of taste.

**The Galilei central extension is unavoidable; the Poincare one, in the boost-translation
slot, is removable.** In the Galilei algebra `[K,P] = 0`, so a coboundary can never have a
`K`-`P` component, and a nonzero mass is a nontrivial cohomology class. In Poincare
`[K,P] = H/c^2 != 0`, so the same central term is `delta f` for `f_H = -b/(1/c^2)` and
disappears into a redefinition of the energy generator. Both directions are proved:
`galilei_mass_is_not_a_coboundary` and `poincare_KP_is_a_coboundary`, packaged together
in `branch_asymmetry`.

The consequence for the spine is not negotiable. **A Galilei-first spine must either
teach central extensions at step 3 or lie by omission**, because the structure the reader
is being handed at step 3 is not the algebra their quantum theory represents. Branch B
can genuinely defer that machinery: its step-3 projective-rep content is the `SU(2)`
double cover, which is a covering-group fact and needs no cohomology vocabulary at all.

**Honest caveat on the Lean side.** In 1+1 dimensions the Poincare algebra still has a
one-dimensional `H^2`, spanned by the translation-translation class `w(H,P)`; the
verified statement is `dim H^2 = 1` (`dim_H2_poincare_is_one`), not zero. The clean
"`H^2` vanishes, projective reps lift to true reps of the covering group" statement is a
3+1 fact [B54] and is **not** verified here. What is verified in 1+1 is the part the
branch decision actually turns on: the *boost-translation* class is a coboundary for
Poincare and is not one for Galilei. A spine that advertises "Poincare has no central
extensions" must say in which dimension.

**And there is a second asymmetry, this one about the owner's own material rather than
the mathematics.** Checked by grep over `docs/se-corpus.md`, `physics/`, and `essays/`:

- "Galilei", "Bargmann", "projective", "double cover", "little group", "Wigner":
  **zero occurrences anywhere in the owner's corpus or content files.**
- "Casimir": three corpus rows. **P-C** (q/27195, "Casimir eigenvalue equations as field
  equations, `P^2 -> KG`, `W^2 -> spin?`) is **promoted 2026-07-08** and ratified as the
  step-5 headline. **P-D** (a/8627, "mass = Casimir `P^2` of the whole system") and
  **P-F** (VSH under Poincare) are in inventory.

So the branch that needs new material from scratch is the branch whose centrepiece the
owner has never written about, and the branch that can be assembled from owner-authored,
already-promoted posts is the other one. **That is the real asymmetry: a documented
corpus gap on one branch, a promoted owner-authored post on the other.** It is a
production-cost fact, not a physics fact, and it points the opposite way from the 1228
note's aesthetic finding.

---

## 8. Recommendation, with its weaknesses

**Recommendation: C1, the on-ramp hybrid, with the C2 comparison as a D4 advanced
aside.** Concretely: everyday Galilei kinematics and the commutator for intuition; the
interval and the one rigorous Poincare pass; Casimirs and Wigner at step 5 on P-C; then
the contraction, the observation that the contracted Casimir has lost the mass, and
Bargmann as the *repair* -- with the central-extension machinery introduced exactly at
the moment the reader has watched mass disappear.

**This revises the 1228 note's recorded finding.** That note favoured "Galilei-first or
hybrid" on D4 grounds. This essay agrees on D4 and narrows to hybrid, on the strength of
two things the note did not have: the proved asymmetry (section 7) and the corpus
evidence, which arrived later with the 1318 note and the 2026-07-08 promotions.

**Weaknesses of this recommendation, in order of how much they should worry the owner:**

1. **It moves Bargmann out of step 3**, which the ratified 11-step skeleton puts there.
   That is a renumbering of the skeleton's content even though the step *count* is
   unchanged, and the skeleton is an owner ratification. If the owner regards step 3's
   content as settled, C1 is out and Branch A is in, on that ground alone.
2. **It sacrifices the best beat in the book to production convenience.** "Mass is the
   phase you cannot remove" arriving as the reader's first encounter with mass is
   stronger than arriving as a repair. An author writing for the payoff rather than for
   the schedule should pick A, and the corpus gap is a cost that a determined author
   simply pays once.
3. **The corpus argument is contingent.** If the owner writes the spin/double-cover/
   belt-trick exploration file that the 1318 note names as the natural next one, the gap
   closes and this recommendation's second leg is gone. It is an argument about today's
   inventory, not about the physics.
4. **"One revisit" is optimistic.** C1 promises the reader meets Galilei twice. In
   practice a hybrid that narrates informally and then re-derives rigorously tends to
   grow a third pass where the informal version has to be corrected. That risk is real
   and is the standard failure mode of hybrid expositions.
5. **The decisive asymmetry does not actually favour one branch.** It quantifies Branch
   A's cost (you must teach cohomology at step 3), it does not forbid paying it. Read
   honestly, section 7 says "Branch A is more expensive", not "Branch A is wrong".

**This is the owner's decision and this essay does not settle it.** A delegated agent's
verdict is a recommendation. Nothing here has been written into `TODO.md`, `ROADMAP.md`,
or `REVIEW_ME.md`.

---

## 9. Surfaced for the owner

Findings that emerged while writing, deliberately **not** filed anywhere:

- The 1228 note's D2 hybrid line is one sentence and describes only what this essay calls
  C1. If the owner picks "hybrid", the record should say which hybrid.
- "Poincare has no central extensions" is dimension-dependent. If it becomes spine prose,
  it needs "in 3+1" attached, or it is a `[derivation]`-tagged claim that is false as
  stated.
- Spin is branch-neutral. Q2 is narrower than "when do projective reps arrive"; it is
  "when do *central extensions* arrive". The 1228 note's D2 text conflates the two
  slightly, and the narrower reading changes the cost estimate for Branch B.

## 10. Follow-up leads

1. **Write the spin / double-cover / belt-trick exploration file** the 1318 note names.
   *Decidable by:* the owner deciding whether he wants to author it; its existence
   removes leg two of section 8's recommendation and re-opens Branch A on equal terms.
2. **Ask whether the ratified 11-step skeleton's step-3 content is binding or
   indicative.** *Decidable by:* one owner sentence. It settles weakness 1 outright and
   may settle Q2 with it.
3. **Extend the Lean file to 3+1 and prove `H^2(poincare) = 0`.** *Decidable by:*
   whether Mathlib's Lie-algebra cohomology is usable at the vendored rev; the payoff is
   turning section 7's caveat into a theorem rather than a citation.
4. **Q8 (chapter granularity) interacts with this.** If each roadmap step is its own
   file, C1's Bargmann-as-repair lands in a step-5 or step-7 file and the cross-file DAG
   question F5 becomes load-bearing at exactly that seam. *Decidable by:* deciding Q8
   first, which may be the cheaper order.
5. **Check whether the mass superselection rule is worth a spine paragraph at all.**
   *Decidable by:* whether the owner wants the reader to meet a superselection rule
   before they have met a measurement; if not, Branch A loses its step-7 beat and the
   Galilei case weakens further.

## References

- [B54] V. Bargmann, "On unitary ray representations of continuous groups",
  *Ann. Math.* **59**, 1-46 (1954).
- [IW53] E. Inonu, E. P. Wigner, "On the Contraction of Groups and Their
  Representations", *Proc. Natl. Acad. Sci. USA* **39**, 510-524 (1953).
- [W39] E. Wigner, "On Unitary Representations of the Inhomogeneous Lorentz Group",
  *Ann. Math.* **40**, 149-204 (1939).
- [Wei95] S. Weinberg, *The Quantum Theory of Fields*, Vol. 1, CUP (1995), ch. 2-5.
- Corpus rows P-A, P-C, P-D, P-F, M-1, M-2: `docs/se-corpus.md`.
