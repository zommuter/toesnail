---
title: "Dreamed: four drafted routes into `## Observe`"
permalink: /dreamed/measurement-routes
---

# Dreamed: four drafted routes into `## Observe`

**DREAMED, UNREVIEWED.** See `docs/dreamed/README.md`. Nothing here is theory, a decision, or
an edit to `physics/toesnail.md`. Seed picked by the owner 2026-09-01: draft every branch of
the spine's measurement choice rather than ask which one he wants. Companion Lean file:
`docs/dreamed/lean/Measurement.lean`. Line references are to `physics/toesnail.md` at 139
lines. Every route below is an **option with its cost**, never a plan.

## 0. What this drafts, and what the sibling essay already said

`physics/toesnail.md` l.135 to l.136, the whole of `## Observe`:

> Measurement via operators, but not the Eigenvalue-Approach, rather some product space or
> such. Eigenvalues of course, too, but not as "measurement values" but rather to justify
> bases and such.

The sibling essay `docs/dreamed/spine.md` §2 audited that sentence and named the same four
options, recommending: **frame with (c) decoherence, build with (b) POVM, hold (d) Gleason as
a Busch-flavoured late aside**. This essay does the other half. Each route below is drafted
far enough to be *read* rather than imagined: the physical question that demands it, the
mathematics it introduces in order, the first honest sentence of the chapter, what it costs
the reader, and what it leaves unexplained. Drafting changed one thing about the sibling's
recommendation, and §5 says where and why.

Constraints treated as settled and not relitigated: **D4** (audience "everyone", layered
reading), **D3** (`[derivation]`/`[input]`/`[hypothesis]` tags are a mechanism), the ratified
11-step skeleton, and the method rule that every piece of mathematics must be **demanded by a
physical question already posed**.

## 1. Route A: the projective postulate

**The question that demands it.** The spine already posed it at l.129 to l.133: the coin goes
from `|coin⟩` to `|tossed coin⟩`, and then someone looks. What does "looking" do to the state,
and where do the two numbers `p` and `1-p` of `\eqref{t1}` come from?

**The mathematics, in order.** Linear operator on the state space, from the l.133 transition
arrow. Self-adjointness, `⟪Tx|y⟫ = ⟪x|Ty⟫`, postulated. Eigenvalue and eigenvector. The
spectral theorem for a self-adjoint operator in finite dimensions: an orthonormal eigenbasis
exists. Outcomes are eigenvalues; the probability of outcome `a` is `|⟪a|ψ⟫|²`; after the
measurement the state is `|a⟩`. Five new objects, one of them a genuinely hard theorem, then a
working calculation.

**First honest sentence of the chapter.** *"Everything the coin can tell us has to be encoded
in an operator, and the price of admission is that the operator must be one whose eigenvectors
form a basis, because we are about to expand every state in them."*

**What it costs the reader.** Least of the four, which is the point. The spectral theorem
arrives as an unmotivated import (why *self-adjoint* rather than any other class of operator
is never answered at this altitude), collapse is a second postulate stacked on the first, and
the coin's two outcomes get an eigenvalue label (`+1`, `-1`?) that carries no physical content
whatever. That last item is exactly the owner's objection at l.136: the eigenvalue is doing a
job (labelling an outcome) that a plain index would do better.

**What it leaves unexplained.** Why probabilities are squared moduli, which is postulated.
Why the state collapses, and what "the state collapses" refers to physically. Why an imperfect
detector, which is every real detector, does not fit the scheme at all.

**What refusing it costs, stated precisely, because the refusal should be informed.**

1. It is the shortest path to a working calculation. Routes B, C and D each need at least one
   more structure before the reader can compute anything at all.
2. Every textbook and lecture course uses it. A reader who never sees `A|a⟩ = a|a⟩` presented
   as *the* measurement rule must translate on first contact with any other source, and under
   D4 that cost lands on the reader least able to pay it.
3. **The mathematics of Route A is not actually refused, only its interpretive role.**
   "Eigenvalues to justify bases" (l.136) *is* the spectral theorem. The owner needs the same
   theorem either way; what he is declining is the sentence "and the eigenvalue is the
   measured value". That is a much smaller refusal than it looks, and it is worth saying so in
   the chapter, because a reader who thinks eigenvalues have been thrown out will be confused
   the moment one appears.
4. There is a version of the refusal that costs nothing: Route B (§2) contains Route A as a
   **theorem** rather than a postulate. `POVM.ofProjections` in the Lean companion is that
   containment, proved. The owner can keep the projective picture and lose only its
   foundational status.

## 2. Route B: POVMs and Naimark dilation

**The question that demands it.** Two questions, both askable in the spine's own register and
neither needing new vocabulary. *My detector is not perfect: sometimes it just misses. What
does a measurement look like when the apparatus is part of the physics?* And: *the coin is not
alone in the universe, it was split off from `|everything else⟩` at l.46. What happens if I
measure it by letting it touch something else and then looking at that?*

**The mathematics, in order.**

1. **Effects.** A family of operators `Eᵢ`, one per outcome, each self-adjoint and
   **positive**, `⟪ψ|Eᵢψ⟫ ≥ 0`. Positivity is demanded, not decorative: it is the statement
   that the number the operator produces can be a probability.
2. **The resolution of the identity**, one equation, `Σᵢ Eᵢ = 𝟙`. This is the whole
   definition. There is no eigenvalue in it and no outcome *value* in it: the outcomes are
   the **indices**, which is l.136's first commitment satisfied literally.
3. **The Born numbers are then forced to be a distribution.**

$$\sum_i \braket{\Psi\vert E_i\Psi} = \braket{\Psi\vert\Psi} = \|\Psi\|^2 \quad \veq{povm-sum}\lean$$

   Two lines, one for each half of the definition: positivity gives `pᵢ ≥ 0`, the resolution
   of the identity gives `Σ pᵢ = ‖Ψ‖²`, and a normalized state gives `Σ pᵢ = 1`.
4. **Projective measurement as the special case.** If each `Eᵢ` is additionally idempotent,
   `Pᵢ² = Pᵢ`, positivity is no longer a hypothesis, it is a consequence:
   `⟪ψ|Pψ⟫ = ⟪ψ|P(Pψ)⟫ = ⟪Pψ|Pψ⟫ = ‖Pψ‖² ≥ 0`. Route A drops out here, as a theorem.

$$P^2 = P,\ P^\dagger = P,\ \textstyle\sum_i P_i = \mathbb{1} \implies (P_i)\ \text{is a POVM} \quad \veq{povm-proj}\lean$$

5. **The coin, cashed.** With the two projections onto `|heads⟩` and `|tails⟩`,

$$|\braket{\text{heads}\vert\Psi}|^2 + |\braket{\text{tails}\vert\Psi}|^2 = \|\Psi\|^2 \quad \veq{coin-born}\lean$$

   which for a normalized state is `p + (1-p) = 1`, derived rather than assumed.
6. **The unsharp measurement**, which is the reason for the whole detour. `E₀ = p·𝟙`,
   `E₁ = (1-p)·𝟙` is a perfectly legitimate POVM and is not projective, because
   `E₀² = p²·𝟙 ≠ p·𝟙`. It is the totally broken detector that reports "heads" with
   probability `p` whatever the coin did. A broken detector is still a detector.

$$E_0 = p\,\mathbb{1},\quad E_0^2 \neq E_0 \ \text{ for } 0<p<1 \quad \veq{unsharp}\lean$$

7. **Naimark.** Every POVM on the system is a projective measurement on
   `system ⊗ ancilla`, followed by forgetting the ancilla. This is the theorem that makes
   l.136's "some product space or such" exactly right rather than approximately right.

**First honest sentence of the chapter.** *"A measurement is not a special kind of number
attached to a special kind of operator; it is a way of carving the identity into pieces, one
piece per thing that could happen."*

**What it costs the reader.** Two structures where Route A has one: the general notion
(effects) and the special one (projections), with the relation between them to keep straight.
Positivity of an operator is a new and slightly abstract idea. Naimark is a real theorem, not
an aside, and honesty requires either proving it or visibly not proving it.

**What it leaves unexplained, and this is sharp.** POVMs **generalize** the Born rule; they do
not derive it. The probability postulate survives Route B completely intact and merely changes
shape from "`|⟪a|ψ⟫|²`" to "`⟪ψ|Eψ⟫`". A reader who was promised a derivation and handed a
generalization will notice, so the chapter needs an explicit **`[input]`** tag at the sentence
where `⟪ψ|Eψ⟫` is first called a probability. Route B also does not explain collapse; it
relocates it, because the Naimark dilation puts a projective measurement back, one factor up.
If the owner's objection to Route A is that eigenvalue-as-value is a category error, B answers
it fully. If the objection is that projective collapse should not appear anywhere, B does not
answer it at all, and the chapter should say so in one sentence rather than let the reader
discover it.

## 3. Route C: decoherence and einselection first

**The question that demands it.** The spine posed this at l.44 to l.54 and then walked past
it. `|42⟩ = |coin⟩ ⊗ |everything else⟩`, and the split is only good "for a while" because the
two parts interact. So: *what does `|everything else⟩` do to the coin while we are not
looking?*

**The mathematics, in order.** The tensor product algebra properly, not as notation. Density
matrices, because after the split the coin alone is no longer described by a ket. The partial
trace, because "ignore `|everything else⟩`" needs a definition. An interaction Hamiltonian,
hence **dynamics**, hence everything the spine's l.133 `#TODO: get to operators...` still
owes. Then einselection: the interaction picks out a preferred basis, the states that survive
being watched, and the off-diagonal terms in that basis decay on a timescale that is absurdly
short for anything coin-sized.

**First honest sentence of the chapter.** *"We never actually left `|everything else⟩` out;
we only stopped writing it down, and the price of that convenience is now due."*

**What it costs the reader.** The highest prerequisite load of the four, and it collides
head-on with D4's "everyone". Density matrices and the partial trace cannot be waved through:
the whole argument is about what happens to the *off-diagonal* entries, so the reader must be
able to see a matrix. There is also an ordering cost that the audit should have priced and did
not: **Route C cannot be written before the spine pays its l.133 operator debt**, because
decoherence is a statement about dynamics. Choosing C to *frame* the measurement chapter is
therefore also choosing to write step 4 first.

**What it leaves unexplained, and it must be said loudly.** Decoherence explains **which
basis** and **why no interference**. It does not explain **why one outcome happens**. The
reduced density matrix becomes diagonal, `p|heads⟩⟨heads| + (1-p)|tails⟩⟨tails|`, and that
object is compatible with "heads *or* tails, we do not know which" and with "heads *and*
tails, both branches real" alike. The formalism does not choose. This is the "and-or" problem,
it is not a gap in the exposition but a genuinely open question in the field, and the
temptation to blur it is strong precisely because the algebra looks like it has finished the
job.

**Where the honest tags go, concretely.** `[derivation]` on the pointer-basis selection and on
the suppression of interference: those are theorems. **`[hypothesis]`** on any sentence of the
form "and therefore the coin is now definitely heads or definitely tails". Not `[input]`,
because it is not an assumption the theory is making on purpose; it is an unresolved question
being marked as unresolved. If the chapter carries only one D3 tag in the whole book, this is
the one it should carry, and the sibling audit's judgement that blurring it "would install the
largest rigor-debt item in the book" is correct.

## 4. Route D: Gleason

**The question that demands it.** The most "math on demand" question available anywhere in the
plan, and it is the reader's own: *why squared moduli? Why not the modulus, or the fourth
power, or something else entirely?*

**The mathematics, in order.** Closed subspaces of the state space, and the projections onto
them. The observation that a "yes or no" question about the system is exactly a projection.
A **frame function**: an assignment `f` of a number in `[0,1]` to every projection such that
`Σ f(Pᵢ) = 1` for every orthonormal basis, which is the weakest possible statement of "these
are probabilities and they are consistent". Then Gleason's theorem: for `dim ≥ 3` every such
assignment has the form `f(P) = tr(ρP)` for a density operator `ρ`. The Born rule, derived.

**First honest sentence of the chapter.** *"Suppose you insist on nothing more than this: that
every yes-or-no question has a probability, and that the probabilities of a complete set of
mutually exclusive answers add to one. That turns out to be enough to force the whole rule."*

**What it costs the reader, and both costs are real.**

1. **The proof is genuinely hard.** It is not a hard *step*; it is a hard *theorem*, whose
   core is a continuity argument on the sphere. There is no honest one-page version. Under D4
   the chapter would have to state the theorem and defer the proof, which is exactly the move
   the spine's method exists to avoid.
2. **`dim ≥ 3` excludes the coin.** The spine's running example, carried since l.57, is a
   two-outcome system. A qubit has non-contextual hidden-variable assignments that Gleason's
   hypotheses cannot exclude, so the theorem is not merely unproven at `dim = 2`, it is
   **false** there as stated. The one example the whole narrative is built on is the one
   example the spectacular theorem cannot reach.

**Busch's version, and why it is not a competitor.** Busch's theorem replaces "frame function
on projections" with "frame function on **effects**", the POVM elements of Route B. The
dimension restriction disappears, the coin is covered, and the proof collapses to an
essentially linear argument that a determined lay reader can follow. That is a genuine
combination of Route D with Route B, not an alternative to either.

The honest price, which the sibling audit did not state and which drafting made visible: the
premise is **stronger**. Gleason assumes probabilities are defined for every projection; Busch
assumes they are defined for every effect, a strictly larger set including all the unsharp
ones. Busch is therefore a cheaper derivation from a more expensive assumption. That is a
perfectly respectable trade and it may well be the right one, but it should be stated as one,
because the sentence "Busch removes Gleason's dimension restriction" reads as a free lunch and
is not.

**What it leaves unexplained.** Everything except the numerical form of the probabilities.
Neither Gleason nor Busch says why measurement produces a single outcome, what collapse is, or
where the ancilla goes. They answer "why squared moduli", completely, and nothing else.

## 5. Comparison, scored against the ratified decisions

Criteria are taken from D3, D4, the method rule, and l.136, not from taste.

| | **A** projective | **B** POVM / Naimark | **C** decoherence | **D** Gleason (Busch) |
|---|---|---|---|---|
| Obeys math-on-demand? | Partly. The transition arrow at l.133 demands an operator; nothing demands *self-adjointness* or the spectral theorem. | Yes. "My detector is imperfect" and the l.46 split both already stand in the text. | Yes, and it is the strongest case of the four: the demand is l.54, unpaid since. | Yes for the *question*; the *machinery* (frame functions) has no prior demand. |
| Serves D4 "everyone" with layered reading? | Best on-ramp; the aside layer stays thin. | Good. Layer 1 is "carve the identity into pieces"; the dilation is a clean layer-2 aside. | Worst. Density matrices and the partial trace are unavoidable in layer 1. | Only as an aside. As main line it is out of reach for the lay reader. |
| Honours l.136? | **No.** Contradicts it directly; eigenvalues are the measured values. | **Yes, most literally.** Outcomes are indices, and Naimark's ancilla is the product space. | **Yes, second sentence.** Pointer states are bases selected dynamically, not postulated. | Partly. Eigenvalues are absent, but projections are the *foundation*, not a basis-justifier. |
| New structures before the first calculation | 3 (self-adjoint operator, eigenvalue, spectral theorem) | 2 (positive operator, resolution of identity) | 4 (⊗ algebra, density matrix, partial trace, dynamics) | 3 (projection lattice, frame function, the theorem) |
| Postulate left standing | **The Born rule**, plus **collapse**. | **The Born rule**, restated as `⟪ψ|Eψ⟫`. Collapse relocated to the ancilla factor, not removed. | **Single outcomes** (the "and-or" problem). Basis and interference are explained; the Born rule is assumed. | **None for the Born rule** (that is the point). Single outcomes and collapse untouched; and Busch assumes probabilities over *all effects*. |

### Recommendation, with its weaknesses, and it is the owner's to ratify

**Build with B, let C arrive as the physical reading of B's ancilla, keep A explicitly as the
special case, hold Busch as the layered capstone.**

This differs from the sibling essay in **ordering**, and the difference is not cosmetic. The
sibling recommends framing with C and building with B. Drafting both says the reverse order is
cheaper and loses nothing:

- **C cannot come first without paying step 4 first.** Decoherence is a dynamical statement;
  the spine's dynamics debt at l.133 is still open. B needs only `⊗`, operators and
  positivity, all of which the text either has or can introduce in a paragraph.
- **B's ancilla and C's environment are the same object**, and it is `|everything else⟩` from
  l.46. Introducing B first means the reader meets that object once, as "the thing you let the
  coin touch", and C later answers "what if you cannot control it and never look at it?" That
  is a demand-driven route into decoherence, which C otherwise lacks.
- **B is the only route that retroactively pays the `⊗` debt** the sibling audit located at
  l.50, and it pays it earlier under this ordering.

Where I agree with the sibling entirely: (d) belongs as a late aside via Busch and not as a
route; the "and-or" caveat is the single most important honest tag in the chapter; and the
choice is the owner's.

**Weaknesses of this recommendation, stated rather than buried.** It still leaves the Born
rule as an `[input]`, so the chapter must carry that tag at a named sentence or it reads as a
derivation it is not. It commits the narrative to two structures (effects and projections)
before the first calculation, where Route A needs the reader to swallow only one. It defers
the most satisfying single moment in the whole plan (Busch, "here is *why* squared moduli") to
a later aside, which is a real narrative cost if the owner would rather spend the reader's
goodwill there. And if the owner's instinct at l.136 turns out to be about **collapse** rather
than about eigenvalue-as-value, then B is the wrong answer and C is the right one, at the
price of writing step 4 first. That reading of l.136 is the one thing in this essay that only
the owner can settle.

### Surfaced for the owner

Located findings, evidenced, **not resolved and not edited**.

- **G1 (`physics/toesnail.md:136`) -- the sentence is ambiguous between two refusals.**
  "Not the Eigenvalue-Approach" reads either as *eigenvalues should not be outcome labels* or
  as *projective collapse should not be foundational*. The routes answer these differently: B
  answers the first, C the second. Every comparison above depends on which was meant.
- **G2 (`:136`) -- "eigenvalues to justify bases" is the spectral theorem.** Route A's
  heaviest import is needed under every route including the ones that reject A. Worth one
  sentence in the chapter so a reader does not conclude eigenvalues were discarded.
- **G3 (`:59`, eq `t1`) -- the coin equation is untouched here on purpose.** `\eqref{t1}`
  writes `p` and `1-p` as coefficients where amplitudes belong; `docs/rigor-debt.md` already
  holds this as owner territory. `Measurement.lean` formalizes the *structure* a corrected
  `t1` would live in (`coin_born`), with `p` never identified with an amplitude, and picks no
  side.
- **G4 -- Route C's ordering constraint.** It is blocked on the l.133 dynamics gap. This is a
  scheduling fact about the 11-step skeleton, not a criticism of C.

## 6. Follow-up leads

1. **Which refusal does l.136 mean (G1)?** Decidable only by the owner, in one sentence, and
   it settles §5's ordering rather than merely informing it.
2. **Does the Busch premise survive the D4 audience?** Decidable by drafting the effect-valued
   frame-function definition in the spine's register and measuring it against the l.79
   complex-number footnote, the file's established ceiling for aside difficulty.
3. **Is Naimark provable at this altitude, or must it be stated and deferred?** Decidable by
   drafting the two-outcome case explicitly: dilate the unsharp POVM `E₀ = p·𝟙` to a
   projective measurement on a four-dimensional space and see whether the construction fits
   one page of the spine's prose.
4. **Does the coin survive as the running example under C?** Decidable by writing the coin's
   `2×2` reduced density matrix and asking whether a lay reader can be shown an off-diagonal
   entry decaying without a matrix formalism first.
5. **Does the `⊗`-debt argument actually get paid by B?** Decidable by counting the tensor
   properties B's first page uses: if it needs only "states of a composite live in the
   product", the sibling's P4 is wrong and l.50 was right all along.

## Lean attestation

File: `docs/dreamed/lean/Measurement.lean`. Command, run from `/home/tobias/src/toesnail/verify`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Measurement.lean
```

**Exit status 0, no `sorry`.** Three cosmetic linter warnings remain (two `simpa`-could-be-
`simp` suggestions and one simp argument the linter calls unused but whose removal breaks the
proof); no errors. Toolchain `leanprover/lean4:v4.30.0-rc2`. Imports:
`Mathlib.Analysis.InnerProductSpace.Symmetric`, `...InnerProductSpace.PiL2`,
`Mathlib.Data.Complex.BigOperators`. Conventions inherited from `Spine.lean`; nothing proved
there is reproved here.

| Badge / handle | Theorem | What it attests |
|---|---|---|
| `\veq{povm-sum}\lean` | `POVM` (structure), `POVM.prob` | A POVM is a positive self-adjoint family with `Σ Eᵢ = 𝟙`; no eigenvalue appears |
| `\veq{povm-sum}\lean` | `POVM.prob_nonneg`, `POVM.prob_sum`, `POVM.prob_sum_one` | Born numbers are `≥ 0`, sum to `‖ψ‖²`, and to `1` for a normalized state |
| `\veq{povm-proj}\lean` | `POVM.ofProjections` | Self-adjoint idempotents summing to `𝟙` **are** a POVM; positivity is derived, not assumed |
| `\veq{povm-proj}\lean` | `proj`, `proj_isSymmetric`, `proj_idem`, `prob_proj` | The rank-one projection `x ↦ ⟪e,x⟫e`; idempotence needs `‖e‖ = 1`; its Born number is `\|⟪e,ψ⟫\|²` |
| `\veq{coin-born}\lean` | `POVM.ofOrthonormalBasis`, `born_orthonormalBasis` | Any orthonormal basis gives a projective POVM, at **any** dimension including 2 |
| `\veq{coin-born}\lean` | `coin_born`, `coin_born_coords`, `coin_born_normalized` | The owner's coin: `\|⟪heads\|ψ⟫\|² + \|⟪tails\|ψ⟫\|² = ‖ψ‖²`, and `= 1` when normalized |
| `\veq{unsharp}\lean` | `unsharpPOVM`, `unsharp_not_idempotent` | `E₀ = p·𝟙`, `E₁ = (1-p)·𝟙` is a valid POVM and is **not** projective for `0 < p < 1` |

Per `docs/dreamed/README.md` these badges are claims about this Lean file **only**, are not
wired into `physics/*.toml` or `tests/test_verify.sh`, and the handles are **proposals**, not
placed markers. Placing a marker is the owner's act.

**What was weakened, explicitly.** Three things.

1. **Naimark's dilation is not proved.** Mathlib has no Naimark or Stinespring dilation for
   POVMs (`GelfandNaimarkSegal.lean` is the GNS construction for states on a C\*-algebra, a
   different theorem). What stands in its place is `unsharp_not_idempotent`, the witness that
   the class of POVMs is strictly larger than the class of projective measurements, which is
   the argumentative load Route B actually needs carried.
2. **Gleason is not stated.** Mathlib does not have it; the only `Gleason` in the tree is the
   topological Gleason theorem on extremally disconnected spaces, unrelated. `Measurement.lean`
   §6 says so in a comment and states nothing, rather than writing a `sorry`-shaped signature.
3. **Positivity is stated on the real part**, `0 ≤ re ⟪ψ, Eψ⟫`, for the same reason
   `Spine.lean` states positive-definiteness that way: the spine's own l.79 footnote says
   complex numbers cannot be ordered. Self-adjointness makes the quantity real, so this is a
   typing obligation rather than a weakening, and it is the F3 finding reappearing.

Self-adjointness is stated as `LinearMap.IsSymmetric` (`⟪Tx,y⟫ = ⟪x,Ty⟫`) rather than via the
adjoint, avoiding a completeness hypothesis the spine has not demanded; it is also the form
the owner's own axiom list at l.86 to l.90 is written in.

What a future `.mw` document would carry, in the style of `verify/mirror/resogram_esol.mw`.
These are **Lean-tier structural claims, not SymPy-tier algebra**, so `computation` is the
wrong carrier as `.mw` stands today; `.mw` would need a `lean` block kind.

```computation
# tier: lean (NOT sympy -- structural claims, no CAS verdict exists)
povm_sum    = Eq(Sum(inner(Psi, E(i)*Psi), (i, 0, n-1)), norm(Psi)**2)
povm_nonneg = Ge(inner(Psi, E(i)*Psi), 0)                  # given E(i) positive
povm_proj   = Implies(And(Eq(P(i)**2, P(i)), Eq(dagger(P(i)), P(i))), povm(P))
coin_born   = Eq(Abs(inner(heads, Psi))**2 + Abs(inner(tails, Psi))**2, norm(Psi)**2)
unsharp     = And(povm([p*I, (1-p)*I]), Ne((p*I)**2, p*I))  # given 0 < p < 1
```
