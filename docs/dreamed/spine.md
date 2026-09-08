---
title: "Dreamed: auditing the TOESNAIL spine against its own method"
permalink: /dreamed/spine
---

# Dreamed: auditing the TOESNAIL spine against its own method

**DREAMED, UNREVIEWED.** See `docs/dreamed/README.md`. Nothing here is theory, a decision, or
an edit to `physics/toesnail.md`. Seed picked by the owner 2026-09-01: the spine itself.
Companion Lean file: `docs/dreamed/lean/Spine.lean`. Per `CONVENTIONS.md` "Working contract"
this is criticism of **structure and method** plus formal proofs of claims **the owner
already stated**; every narrative option below is an option with its cost, never a plan. Line
references are to `physics/toesnail.md` at the commit this was dreamed from (139 lines).

## 1. The audit: does the spine obey "math on demand"?

"Math on demand" (l.23: mathematics "only when it's actually needed and motivated", YAGNI,
Occam, KISS) is unusually strong as an editorial constraint because it is **falsifiable per
paragraph**. For every piece of mathematics, ask which physical question, already posed
earlier in the file, demands it. Walking the 139 lines gives an answer with a shape.

### 1.1 Paid in full

Four introductions state their demand before the notation, textbook execution of the method:
**ket labels** (l.30, because writing "life, the universe and everything" is tedious);
**subsystem splitting** (l.44, because the omniscience problem one sentence earlier forbids
knowing everything); **linear combination** (l.65, because the coin at l.57 has two weighted
outcomes, which also makes `\ltag{linearity}` at l.88 the only one of the three axioms with a
demand already standing when it is stated); **norm and unit vectors** (l.110, l.116, because
l.110 asks what `⟪Ψ|Ψ⟫` is and vectors of different length need comparing).

### 1.2 Supplied before demanded

- **The tensor product symbol** (l.50). The demand at l.44 is "split `|42⟩` into
  weakly-interacting parts", and the comma form at l.46 already answers it completely. `⊗`
  arrives at l.50 with an explicit deferral, "Don't worry about the details for now" (l.52).
  Under the file's own standard that deferral is the tell: a symbol whose meaning must be
  postponed was not demanded. Its real demand appears much later, in everything in §2 below.
- **Complex numbers** (l.71, plus the ~350-word footnote at l.77 to l.79). No physical
  question in the file asks for a phase. This is the largest single unpaid introduction by
  word count in the spine, and the ratified curriculum note already assigns its demand to
  step 2 (interference forces ℂ). Internal tension: l.23 says the author likes mathematics
  *iff* it is useful, and by l.105 the only use ℂ has been put to is one conjugation bar.
- **Conjugate symmetry** (l.87). Nothing in the preceding 86 lines asks how `⟪Φ|Ψ⟫` relates
  to `⟪Ψ|Φ⟫`. It arrives purely as an item in an axiom list, and per §1.3 it is also the
  axiom the file most urgently needs and never cashes.
- **Positive-definiteness** (l.89). Its demand exists, but 21 lines *later*, at l.110 where
  the norm is defined. The list at l.86 to l.90 gives properties the inner product "fulfills",
  which is the standard mathematical order (axioms first, consequences later) and therefore
  precisely the order "math on demand" undertakes not to use.

### 1.3 The internal inconsistency this creates

The footnote at l.79 ends: complex numbers "can't be ordered! There is no unique way to
determine which of two complex numbers is 'greater' or 'smaller'". Sixteen lines later, l.89
writes

$$\forall\ket\Psi\neq\ket0:\ \|\Psi\|^2 := \braket{\Psi\vert\Psi} > 0 \quad \veq{inner-real}\lean$$

for a quantity the reader has just been told is complex and unorderable. The resolution is
one line, and it is the missing demand for `\ltag{conjugate symmetry}`: setting `Φ = Ψ` in
l.87 gives `⟪Ψ|Ψ⟫ = conj ⟪Ψ|Ψ⟫`, so that particular inner product is real and `> 0` means
something. The file never makes the link. This is the strongest unused "math on demand"
opportunity in the spine, because the objection is raised by the text itself at l.79 and
demands exactly the axiom stated at l.87. Formalized as `spine_inner_self_is_real` and
`spine_positive_definiteness`.

### 1.4 Demanded and never paid

**Time** (l.54): "we have not even defined the passage of time so far, which is something
we'll fix later." Still open at l.139. **Operators** (l.133): the Transition section poses
`|coin⟩ → |tossed coin⟩` and stops at `#TODO: get to operators...`, the file's one *total*
non-payment, a demand posed in full and given nothing, not even a deferral with a name.
**Omniscience** (l.44), already parked in `docs/rigor-debt.md` as ill-posed without a definition.

### 1.5 Headline

Before l.126 the maths arrives before the question; after it the questions arrive and no maths
does. The spine's method fails **asymmetrically**, with a boundary at l.126. Before it, mathematics
runs *ahead* of demand: `⊗`, ℂ, conjugate symmetry and positive-definiteness all arrive
before a question needs them, four such introductions against four clean ones. After it the
pattern inverts completely, two demands posed and nothing supplied. The file therefore does
not drift from its method gradually; it has one over-supplied region and one starved region,
joined exactly where the prose turns from narrative into "a roughly commented outline"
(l.126). The repair is local rather than a rewrite.

## 2. The load-bearing gap: how measurement gets introduced

l.136, in full: "Measurement via operators, but not the Eigenvalue-Approach, rather some
product space or such. Eigenvalues of course, too, but not as 'measurement values' but rather
to justify bases and such."

Two commitments are already in that sentence: measurement lives on a *product* space, and
eigenvalues justify *bases* rather than supply *values*. That narrows the menu without
closing it. The four live options, with what each demands and costs.

**(a) Eigenvalue / projective postulate.** Demands operators, self-adjointness, the spectral
theorem (finite-dimensional suffices for the coin); could follow the Transition section
immediately. Cost: the spectral theorem is a heavy import with no prior demand, "why
self-adjoint" stays a bare postulate, and it contradicts l.136 directly. Its one virtue is
being the cheapest path to a working chapter, labellable as temporary scaffolding.

**(b) POVMs and Naimark dilation.** Demands positive operators, a resolution of identity
`Σ Eᵢ = 𝟙`, and for the dilation a projective measurement on `system ⊗ ancilla`; the
*statement* needs only `⊗` plus operators, so it can land before the full step 3 to 4
machinery. It matches l.136 most literally, the observable genuinely living on a product
space, and it is the **only** option that retroactively pays the `⊗` debt from §1.2. Cost:
Naimark is a real theorem, not an aside; and POVMs **generalize** the Born rule rather than
deriving it, so the probability postulate survives intact and merely changes shape. A reader
promised a derivation and handed a generalization will notice.

**(c) Decoherence-first, with einselection.** Demands density matrices and partial trace
(hence a working `⊗`), a system-environment interaction, and therefore *dynamics*, which is
exactly the l.133 gap; cannot precede step 4. Payoff: the split at l.46,
`|coin⟩ ⊗ |everything else⟩`, becomes the mechanism rather than a convenience, and preferred
bases *emerge* as pointer states instead of being postulated, which is l.136's second
sentence almost verbatim. Cost: the highest prerequisite load of the four, colliding with
D4's "everyone" audience; and the caveat that must be stated loudly wherever this is written,
**decoherence explains the basis, not the single outcome**. It suppresses interference
between pointer states; it does not say why one outcome happens. Blurring that would install
the largest rigor-debt item in the book.

**(d) Gleason's theorem.** Demands the lattice of closed subspaces, projections, frame
functions, `dim ≥ 3`. Payoff: the Born rule **derived**, the most spectacular "math on
demand" moment available anywhere in the plan. Cost, sharp: the running example is a
two-outcome coin, a qubit, `dim = 2`, precisely the case Gleason excludes. Busch's POVM
version restores `dim = 2`, folding (d) into (b) as its capstone rather than a route.

**Recommendation, and it is a recommendation.** Frame with (c), build the machinery with (b),
hold (d) via Busch as a late layered aside for the physicist reading layer (D4). It is the
reading of l.136 that keeps both of the owner's commitments, and the only combination that
cashes the `⊗` introduced at l.50. **Weaknesses:** the longest prerequisite chain of the
four, landing hardest on the lay reader D4 committed to; and it still contains an unremoved
postulate, so the chapter must carry an explicit `[input]` tag (D3's marker family) at the
exact sentence where a probability rule is assumed, or it reads as a derivation it is not. If
the owner weights on-ramp gentleness above structural payoff, (a) as declared scaffolding is
defensible and reversible. **This choice is the owner's, it is the most consequential open
narrative decision in the file, and nothing here settles it.**

## 3. Cauchy-Schwarz as the worked "math on demand" example

l.105: "For two unit vectors, the length of the inner product is always `≤1` and only exactly
equal to one of the vectors are parallel or anti-parallel."

This is the one place where the method can be demonstrated end to end at zero narrative cost,
because the demand is *already standing*: l.122 says the inner product "is a measure of the
_similarity_ of two vectors", a measure needs a scale, and l.57's coin has already promised
that something here will be a probability. **If `⟪Φ|Ψ⟫` measures similarity, what is its
largest possible value, and when is it reached?**

The proof needs **nothing the spine has not already stated**. For unit `|Ψ⟩`, `|Φ⟩`, set
`c = ⟪Ψ|Φ⟫` and expand the manifestly non-negative quantity `‖Φ − cΨ‖²` using
`\eqref{linearity}`, `\eqref{conjugate symmetry}` and `\eqref{positive-definiteness}`:

$$0 \le \|\Phi - c\Psi\|^2 = 1 - |c|^2 \quad\Longrightarrow\quad |\braket{\Psi\vert\Phi}| \le 1 \quad \veq{cs}\lean$$

Three axioms in, one inequality out, no new machinery. That is the best available
advertisement for the method, and where the axiom list of §1.2 earns its place retroactively:
the reader sees all three axioms *used together* for the first time. It buys two things
immediately, both formalized. `|⟪Ψ|Φ⟫|² ≤ 1`, so that number can be a probability at all
(`spine_born_bound`; the Born rule is not derived by this, but the *type* obligation is
discharged). And the ratio `|⟪Ψ|Φ⟫| / (‖Ψ‖‖Φ‖) ∈ [0,1]`, which turns "angle between states"
and l.122's orthogonality-as-zero into a scale rather than a slogan
(`spine_similarity_in_unit_interval`).

### Surfaced for the owner

Located findings, evidenced, **not resolved and not edited**. Each is the owner's call.

- **F1 (`physics/toesnail.md:105`) -- the equality condition is the real-vector-space one.**
  "Parallel or anti-parallel" is the equality case over ℝ, `c = ±1`. Over ℂ, which the file
  admitted at l.71, equality holds exactly when the vectors are **linearly dependent**,
  `|Φ⟩ = c|Ψ⟩` with `|c| = 1` for a **complex** `c`, the entire unit circle, strictly larger
  than `{+1, −1}`. Counterexample to the sentence as written: `|Φ⟩ = i|Ψ⟩` gives
  `|⟪Ψ|Φ⟫| = 1`, and `i|Ψ⟩` is neither parallel nor anti-parallel in the everyday sense the
  sentence invokes. Both directions proven in `spine_cauchy_schwarz_unit_eq_iff`. For the
  owner's decision: this correction and the **rays** concept are the *same content*, and
  `docs/meeting-notes/2026-07-07-1318` lists rays under step 2 as "the single most
  consequential NEW item the current text hasn't stated yet", so the finding doubles as a
  demand-driven on-ramp to rays the curriculum note does not name, costing one sentence.
- **F2 (`:105`) -- a garble that renders as-is.** "only exactly equal to one of the vectors
  are parallel" is missing an "if". Prose, not physics, but it is on the live site.
- **F3 (`:89` vs `:79`) -- `> 0` on a quantity declared unorderable.** §1.3 above. The fix is
  a cross-reference, not new content, but which one and where is the owner's.
- **F4 (`:116`) -- "the 'smallest' vector with vanishing norm"** presupposes an order on
  vectors the file has not defined and l.79 has just argued is unavailable for the scalars.
  The scare quotes suggest the author knows; recorded so it is not lost.
- **F5 (`:89` vs `:110`) -- `‖Ψ‖²` is defined twice**, as `:=` at l.89 and `=:` at l.110, in
  opposite directions. Harmless, except that l.112 teaches the `:=` / `=:` distinction on
  this very example, so it is visible to exactly the reader that passage targets.

## 4. The zero-vector footnote, discharged

Footnote `uniqueZero` (l.118): "_The_ vector and not _a_ vector, since it turns out for a
given vector space the vector of norm zero is unique -- but that is a #TODO for later."

Two readings, two different theorems. **(a) Uniqueness of the additive identity:** if
`|Ψ⟩ + z = |Ψ⟩` for all `|Ψ⟩` then `z = |0⟩`, one line, `z = |0⟩ + z = |0⟩`, group theory with
no norm and no inner product. That is the reading l.103 sets up ("behaves like the normal
number zero by not changing anything it is added to"); `spine_zero_unique_additive_identity`.
**(b) Uniqueness of the norm-zero vector:** `‖Ψ‖ = 0 ⟹ |Ψ⟩ = |0⟩`; `spine_norm_eq_zero_iff`
and `spine_norm_zero_unique`.

The footnote says "the vector of *norm zero*", so it means (b). And (b) is **exactly
`\ltag{positive-definiteness}`, stated 29 lines earlier at l.89**, read contrapositively:
every non-zero vector has strictly positive `⟪Ψ|Ψ⟫`, hence only `|0⟩` can have norm zero. No
debt, only a missing cross-reference, which makes this the cheapest closable `#TODO` in the
file: one `\eqref{positive-definiteness}`.

One caveat the Lean file makes structurally visible: (b) is a theorem only because the spine
builds the norm *from* the inner product (l.110). Mathlib puts `‖x‖ = 0 ↔ x = 0` into
`NormedAddCommGroup`, one layer *below* `InnerProductSpace`, so that section of `Spine.lean`
needs no inner product at all; in a bare normed space it is a norm axiom, not a consequence.
The spine's construction order runs the way the footnote wants, so the footnote is right for
a reason worth one clause.

$$\|\Psi\| = 0 \iff \ket\Psi = \ket 0 \quad \veq{zero-unique}\lean$$

## 5. A curriculum patch, as an option

Smallest ordered set that closes the §1 holes, cross-checked against
`docs/meeting-notes/2026-07-07-1228-toe-roadmap-evaluation.md` (D1 to D5, the ratified
11-step skeleton) and `...-1318-math-on-demand-curriculum.md` **before** proposing. None of
these is a plan.

| # | Change | The physical question that demands it | Vs. ratified |
|---|---|---|---|
| P1 | Move the l.105 Cauchy-Schwarz sentence to after `#### Norms`, attached to l.122's similarity paragraph; give it handle `cs` | "If the inner product measures similarity, what is its maximum?" | **Agrees.** Step 2 already lists Cauchy-Schwarz. Purely positional. |
| P2 | One sentence at l.89 linking `> 0` to conjugate symmetry via `⟪Ψ|Ψ⟫ = conj⟪Ψ|Ψ⟫` | "l.79 said complex numbers cannot be ordered, so what does `> 0` mean here?" | **Neither.** Repairs an internal inconsistency; not a direction choice. |
| P3 | Replace the `uniqueZero` `#TODO` with `\eqref{positive-definiteness}` | Already answered; the file just does not say so | **Neither.** Closes a `#TODO` at zero content cost. |
| P4 | Either give `⊗` a demand at l.50 or defer the symbol until it has one | "What does composing two systems actually *do* to the maths?" | **Diverges, mildly.** The 1318 note marks the ⊗ idea "(have)" and defers only bilinearity. This asks whether the *symbol* belongs at l.50 at all. Flagged as divergence, not correction. |
| P5 | Introduce rays out of the ℂ equality case (F1) rather than as a standalone concept | "If `|Ψ⟩` and `i|Ψ⟩` are equally similar to everything, in what sense are they different states?" | **Agrees on the item, adds a route.** Step 2 already names rays; the 1318 note does not name a demand for them. This supplies one. |
| P6 | Nothing proposed for the l.133 operator gap | -- | **Deliberate.** Steps 3 and 4 already own generators and Stone's theorem. Proposing content here would be direction, which is out of bounds. |

P1 to P3 are structural and cost no new physics. P4 and P5 touch narrative shape and are
genuinely the owner's. P6 is where an AI proposal would overstep, so it stops.

## 6. Follow-up leads

1. **Does the ⊗-debt argument survive option (b)?** Decidable by drafting the POVM chapter's
   first page and counting the `⊗` properties it uses; if only "states of a composite live in
   the product", l.50 was right and P4 is wrong.
2. **Is the l.126 boundary an artifact of drafting order?** Decidable from `git log --follow
   physics/toesnail.md`: if everything after l.126 landed in one sitting as an outline,
   §1.5's asymmetry is a work-in-progress signature, not a method failure.
3. **Does Gleason survive the "everyone" audience (D4)?** Decidable by writing the
   frame-function definition in the spine's register and measuring it against the l.79
   complex-number footnote, the file's established ceiling for aside difficulty.
4. **Should `docs/rigor-debt.md` carry F1 to F5?** Owner-only: F1 is a located discrepancy of
   the `edot` kind, F2 and F5 are prose, F3 and F4 are method. Three species, one list is
   probably wrong.
5. **Is `spine_first_slot_is_forced` worth a spine sentence?** Decidable by whether a reader
   ever asks "why only three axioms?"; it shows the apparently missing fourth,
   conjugate-linearity in the first slot, is a consequence rather than an axiom.

## Lean attestation

File: `docs/dreamed/lean/Spine.lean`. Command, run from `/home/tobias/src/toesnail/verify`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Spine.lean
```

**Exit status 0, no `sorry`, no warnings.** Toolchain `leanprover/lean4:v4.30.0-rc2`, single
import `Mathlib.Analysis.InnerProductSpace.Basic`. Sixteen theorems over an arbitrary complex
inner product space `E`:

| Badge / handle | Theorem | Source line |
|---|---|---|
| `\veq{zero-unique}\lean` | `spine_zero_add`, `spine_zero_smul` | l.99, l.100 |
| `\veq{zero-unique}\lean` | `spine_zero_unique_additive_identity` | footnote l.118, reading (a) |
| `\veq{zero-unique}\lean` | `spine_norm_eq_zero_iff`, `spine_norm_zero_unique` | footnote l.118, reading (b) |
| -- | `spine_conjugate_symmetry`, `spine_linearity`, `spine_norm_sq` | l.87, l.88, l.110 |
| -- | `spine_first_slot_is_forced` | not in the spine; shows the axiom list is complete |
| `\veq{inner-real}\lean` | `spine_positive_definiteness`, `spine_inner_self_is_real` | l.89 (+ F3) |
| `\veq{cs}\lean` | `spine_cauchy_schwarz`, `spine_cauchy_schwarz_unit` | l.105, first half |
| `\veq{cs}\lean` | `spine_cauchy_schwarz_unit_eq_iff` | l.105, second half; **F1** |
| `\veq{cs}\lean` | `spine_similarity_in_unit_interval`, `spine_born_bound` | l.122, l.57 |

Per `docs/dreamed/README.md` these badges are claims about this Lean file **only**, are not
wired into `physics/*.toml` or `tests/test_verify.sh`, and the handles `cs`, `zero-unique`,
`inner-real` are **proposals**, not placed markers. Placing a marker is the owner's act.

**Convention check, clean.** Mathlib's `⟪·,·⟫` is conjugate-linear in the *first* slot and
linear in the *second* (`InnerProductSpace.smul_left`); the spine's `\ltag{linearity}` puts
linearity in the *second* slot. **They agree.** That is the Dirac convention, so no
translation layer is needed anywhere in `Spine.lean`. Recorded because the mathematician's
convention is the opposite one and the mismatch is a classic source of conjugation errors.

**Nothing was weakened.** Both directions of the equality case closed. The only statements
adjusted from their prose form are the two where the spine's `> 0` on a complex quantity had
to become `0 < re ⟪Ψ,Ψ⟫`, which is F3 reappearing as a typing obligation rather than a
weakening; the reality of `⟪Ψ,Ψ⟫` is proven separately.

What a future `.mw` document would carry, in the style of `verify/mirror/resogram_esol.mw`.
These are **Lean-tier structural claims, not SymPy-tier algebra**, so `computation` is the
wrong carrier as `.mw` stands today; `.mw` would need a `lean` block kind, or these stay in
`Spine.lean` and the `.mw` document references them by handle.

```computation
# tier: lean (NOT sympy -- these are structural, no CAS verdict exists)
cs      = Le(Abs(inner(Psi, Phi)), 1)            # given norm(Psi) == 1, norm(Phi) == 1
cs_eq   = Iff(Eq(Abs(inner(Psi, Phi)), 1),
              Exists(c, And(Eq(Abs(c), 1), Eq(Phi, c*Psi))))
zero_unique  = Iff(Eq(norm(Psi), 0), Eq(Psi, ket0))
inner_real   = Eq(conjugate(inner(Psi, Psi)), inner(Psi, Psi))
born_bound   = Le(Abs(inner(Psi, Phi))**2, 1)
```
