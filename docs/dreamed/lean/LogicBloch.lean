/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-bloch-poles.md`.

  Seed (owner-authored, claude.ai conversation "Falsifiability and Logical Boundaries",
  2025-08-16, human turns, verbatim):

      "Let's use a qubit with the two states (proven) true and (proven) false. What states
       can it describe in superposition or even statistical mixture? How to encode that a
       statement is unprovable [...]?"
      "What about the Bloch sphere instead of a qutrit? Would the origin encode unprovable
       or provable but not yet determined or something entirely different? What about the
       circle at z=0 i.e. as far from proven truth and falsehood as possible?"
      "Would a qubit true or unprovable make sense? How could false be encoded there?"

  This file discharges the three SMALL, PURELY STRUCTURAL claims the essay leans on. It
  proves nothing about quantum mechanics and nothing about Goedel.

  ---------------------------------------------------------------------------
  SYMBOL MAP -- Lean name  <->  essay language
  ---------------------------------------------------------------------------

  PART A -- the counting obstruction that kills the |true>/|unprovable> encoding.

    `Status`                 the three epistemic statuses the owner listed as mutually
                             exclusive: provably true, provably false, independent
                             (= neither provable nor refutable in the theory).
    `Pole`                   `Bool`: the TWO antipodal outcomes of one sharp measurement
                             on a qubit. A basis choice names exactly two poles, and a
                             projective measurement in that basis returns exactly one of
                             them. This is the ONLY thing the physics contributes here.
    `no_two_pole_encoding`   there is no injective `Status -> Pole`. Hence any qubit
                             encoding that wants the three statuses to be distinguishable
                             by a single sharp measurement is impossible, by counting
                             alone. Essay handle `poles-2`.

  PART B -- the Belnap-Dunn FOUR bilattice, as the essay's rival to the Bloch ball.

    `V4 := Bool x Bool`      a truth value read as (has-evidence-FOR, has-evidence-AGAINST).
                             `N` = (false,false) = neither (a gap, Kleene K3's third value).
                             `T` = (true ,false) = true only.
                             `F` = (false,true ) = false only.
                             `B` = (true ,true ) = both (a glut, Priest's LP third value).
    `leT`                    the TRUTH order  <=_t : more for, less against.
                             F <_t N <_t T and F <_t B <_t T; N, B incomparable.
    `leK`                    the KNOWLEDGE / INFORMATION order <=_k : more evidence of
                             either sign. N <_k T <_k B and N <_k F <_k B; T, F incomparable.
    `andT`, `orT`            the truth-order meet and join (conjunction, disjunction).
    `otimes`, `oplus`        the knowledge-order meet and join. `otimes` is CONSENSUS
                             (keep only what both sources assert), `oplus` is GULLIBILITY
                             (believe everything either source asserts).
    `neg`                    Belnap negation: swap the two evidence bits. Note it fixes
                             both N and B, which is exactly why they are the two "as far
                             from true as from false" values, and why the essay insists
                             they are DIFFERENT values rather than one.
    `orders_differ`          <=_t and <=_k are distinct relations. Essay handle `two-orders`.
    `leT_not_total`,
    `leK_not_total`          neither order is total. So a single scalar in [0,1] (a fuzzy
                             degree, a probability, a `z` coordinate) cannot carry either
                             order faithfully. Essay handle `not-total`.
    `interlaced_*`           all four operations are monotone in BOTH orders (Ginsberg's
                             interlacing condition). This is the structural property the
                             essay asks whether the Bloch ball has.
    `lem_fails`              excluded middle fails at the gap `N`: `N or ~N` is not
                             designated. This is K3's characteristic failure.
    `glut_designated`        `B and ~B` IS designated, i.e. a contradiction can be accepted
                             without triviality. This is LP's characteristic feature.

  PART C -- the two Bloch-ball coordinates the essay says logic conflates.

    `Bloch`                  a Bloch vector as a bare triple of reals (r_x, r_y, r_z).
                             NO positivity, NO density matrix, NO trace: this part proves
                             only affine/quadratic arithmetic, see OUT OF SCOPE below.
    `rsq v`                  |r|^2, the squared Bloch radius. Purity of the corresponding
                             density matrix is Tr(rho^2) = (1 + |r|^2)/2, so `rsq` is an
                             affine reparametrisation of purity; the essay's "how much is
                             settled" axis.
    `zc v`                   the z coordinate; the essay's "which way it is settled" axis.
    `mix t a b`              the convex combination t*a + (1-t)*b, which for density
                             matrices is literally the statistical mixture.
    `zc_mix_affine`          z is AFFINE under mixing. Essay handle `z-affine`.
    `rsq_not_affine`         |r|^2 is NOT. Mixing true with false gives z = 0 and radius 0,
                             while the average of the two radii is 1. Essay handle `r-drop`.
    `equator_two_kinds`      two Bloch vectors both with z = 0 but different radius: the
                             coherent equator point (1,0,0) and the centre (0,0,0). These
                             are the two states the essay insists must mean different
                             things. Essay handle `equator-vs-centre`.

  ---------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE -- do not read this file as more than it is
  ---------------------------------------------------------------------------

    - NOTHING here is a theorem about quantum mechanics. `Bloch` is a triple of reals with
      no positive-semidefiniteness constraint, no unit trace, no Hermitian 2x2 matrix, and
      no connection to any Hilbert space. The identification of `rsq <= 1` with the set of
      qubit density matrices is asserted in the essay's prose and proved NOWHERE below.
    - NOTHING here is a theorem about Goedel. No arithmetic, no provability predicate, no
      consistency hypothesis, no diagonal lemma. `Status.independent` is an opaque
      constructor of a three-element inductive type; that it is INHABITED for PA is
      Goedel's business, not this file's. The sibling `lean/Omniscience.lean` is equally
      not a Goedel file, and says so.
    - `no_two_pole_encoding` is PIGEONHOLE, nothing deeper. It refutes exactly one thing:
      that three statuses can be told apart by one two-outcome measurement. It does NOT
      refute encoding the third status somewhere else in the ball (that is the essay's
      whole §2), and it does NOT refute a qutrit.
    - The FDE fragment is finite and everything about it is closed by `decide`. That is a
      feature (it is a 4-element algebra) and NOT evidence that anything about the
      continuous Bloch ball follows. No bilattice structure on the ball is proved here;
      whether one exists is the essay's open question, surfaced for the owner.
    - Birkhoff-von Neumann orthomodularity is NOT touched. The projection lattice of a
      qubit is not constructed, and the non-distributivity of that lattice is cited in the
      essay from the literature, not proved here.
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace Toesnail.LogicBloch

/-! ## Part A. Two poles cannot separate three statuses. -/

/-- The three epistemic statuses the owner's seed treats as mutually exclusive: a sentence
    of a fixed theory is provable, refutable, or independent. Whether the third is
    inhabited for a given theory is Goedel's business and is not asserted here. -/
inductive Status
  | provablyTrue
  | provablyFalse
  | independent
  deriving DecidableEq, Repr

/-- The two antipodal outcomes of one sharp (projective, two-outcome) measurement on a
    qubit. Naming a basis names exactly two of these and no third. -/
abbrev Pole := Bool

/-- **Antipodal poles are exhaustive-or-nothing** (essay handle `poles-2`).

    No assignment of the three statuses to the two poles is injective. So a qubit encoding
    in which the poles are `|proven true>` and `|unprovable>` cannot ALSO place `proven
    false` at a pole: whatever it does with "false", it is not a pole, and a single sharp
    measurement in that basis cannot distinguish it from whichever pole it collides with.

    This is pigeonhole and nothing more. It is stated because the seed conversation
    proposed exactly that encoding and then hunted for somewhere to put "false". -/
theorem no_two_pole_encoding (e : Status → Pole) : ¬ Function.Injective e := by
  intro hinj
  have h3 : ∀ a b c : Bool, a = b ∨ a = c ∨ b = c := by decide
  rcases h3 (e .provablyTrue) (e .provablyFalse) (e .independent) with h | h | h
  · exact absurd (hinj h) (by decide)
  · exact absurd (hinj h) (by decide)
  · exact absurd (hinj h) (by decide)

/-- The same obstruction phrased positively: any `e : Status → Pole` collides on some pair
    of *distinct* statuses. This is the form the essay quotes, because it names the pair
    that a measurement conflates. -/
theorem two_statuses_collide (e : Status → Pole) :
    ∃ s t : Status, s ≠ t ∧ e s = e t := by
  have h3 : ∀ a b c : Bool, a = b ∨ a = c ∨ b = c := by decide
  rcases h3 (e .provablyTrue) (e .provablyFalse) (e .independent) with h | h | h
  · exact ⟨.provablyTrue, .provablyFalse, by decide, h⟩
  · exact ⟨.provablyTrue, .independent, by decide, h⟩
  · exact ⟨.provablyFalse, .independent, by decide, h⟩

/-! ## Part B. The Belnap-Dunn bilattice FOUR. -/

/-- A four-valued truth value read as (has evidence FOR, has evidence AGAINST). -/
abbrev V4 := Bool × Bool

namespace V4

/-- Neither: no evidence either way. Kleene K3's gap. -/
def N : V4 := (false, false)
/-- True only. -/
def T : V4 := (true, false)
/-- False only. -/
def F : V4 := (false, true)
/-- Both: contradictory evidence. Priest LP's glut. -/
def B : V4 := (true, true)

/-- The truth order `≤_t`: more evidence for, less evidence against. -/
def leT (u v : V4) : Prop := u.1 ≤ v.1 ∧ v.2 ≤ u.2

/-- The knowledge (information) order `≤_k`: more evidence of *either* sign. -/
def leK (u v : V4) : Prop := u.1 ≤ v.1 ∧ u.2 ≤ v.2

instance (u v : V4) : Decidable (leT u v) := by unfold leT; infer_instance
instance (u v : V4) : Decidable (leK u v) := by unfold leK; infer_instance

/-- Truth-order meet: conjunction. -/
def andT (u v : V4) : V4 := (u.1 && v.1, u.2 || v.2)
/-- Truth-order join: disjunction. -/
def orT (u v : V4) : V4 := (u.1 || v.1, u.2 && v.2)
/-- Knowledge-order meet: CONSENSUS. Keep only what both sources assert. -/
def otimes (u v : V4) : V4 := (u.1 && v.1, u.2 && v.2)
/-- Knowledge-order join: GULLIBILITY. Believe everything either source asserts. -/
def oplus (u v : V4) : V4 := (u.1 || v.1, u.2 || v.2)

/-- Belnap negation: swap the evidence bits. Fixes `N` and `B`. -/
def neg (u : V4) : V4 := (u.2, u.1)

/-- A value is *designated* (assertible) when there is evidence for it. Both `T` and `B`
    are designated; this is the choice that makes the logic paraconsistent. -/
def designated (u : V4) : Prop := u.1 = true

instance (u : V4) : Decidable (designated u) := by unfold designated; infer_instance

/-! ### Both relations are partial orders. -/

theorem leT_refl : ∀ u : V4, leT u u := by decide
theorem leT_trans : ∀ u v w : V4, leT u v → leT v w → leT u w := by decide
theorem leT_antisymm : ∀ u v : V4, leT u v → leT v u → u = v := by decide

theorem leK_refl : ∀ u : V4, leK u u := by decide
theorem leK_trans : ∀ u v w : V4, leK u v → leK v w → leK u w := by decide
theorem leK_antisymm : ∀ u v : V4, leK u v → leK v u → u = v := by decide

/-! ### The two orders are genuinely different, and neither is total. -/

/-- **The two orders are distinct relations** (essay handle `two-orders`).

    `T ≤_k B` (the glut has strictly more evidence than the plain truth) but `¬ (T ≤_t B)`
    (the glut is strictly *less* true than the plain truth). One pair, opposite verdicts.
    This is the fact the essay claims the Bloch ball's (z, r) pair mirrors. -/
theorem orders_differ : leK T B ∧ ¬ leT T B := by decide

/-- And the disagreement runs the other way too: `F ≤_t N` but `¬ (F ≤_k N)`. -/
theorem orders_differ' : leT F N ∧ ¬ leK F N := by decide

/-- **The truth order is not total** (essay handle `not-total`): the gap `N` and the glut
    `B` are incomparable. Both are "as far from true as from false"; neither is above the
    other. Any encoding that maps truth values onto a single real number in a
    order-preserving way must therefore identify `N` with `B`, which is precisely the
    conflation the essay says the naive Bloch reading commits. -/
theorem leT_not_total : ¬ leT N B ∧ ¬ leT B N := by decide

/-- The knowledge order is not total either: plain truth and plain falsity carry the same
    amount of evidence, one bit each, and neither dominates. -/
theorem leK_not_total : ¬ leK T F ∧ ¬ leK F T := by decide

/-- `N` and `B` are the exactly two negation-fixed values. In the Bloch picture negation
    is the rotation that swaps the poles, so its fixed set is the equator TOGETHER with
    the centre -- and FDE says that fixed set holds two *different* values, not one. -/
theorem neg_fixed_iff : ∀ u : V4, neg u = u ↔ (u = N ∨ u = B) := by decide

/-! ### Interlacing: every operation is monotone in both orders (Ginsberg). -/

theorem interlaced_andT_T : ∀ u v w : V4, leT u v → leT (andT u w) (andT v w) := by decide
theorem interlaced_andT_K : ∀ u v w : V4, leK u v → leK (andT u w) (andT v w) := by decide
theorem interlaced_orT_T : ∀ u v w : V4, leT u v → leT (orT u w) (orT v w) := by decide
theorem interlaced_orT_K : ∀ u v w : V4, leK u v → leK (orT u w) (orT v w) := by decide
theorem interlaced_otimes_T : ∀ u v w : V4, leT u v → leT (otimes u w) (otimes v w) := by decide
theorem interlaced_otimes_K : ∀ u v w : V4, leK u v → leK (otimes u w) (otimes v w) := by decide
theorem interlaced_oplus_T : ∀ u v w : V4, leT u v → leT (oplus u w) (oplus v w) := by decide
theorem interlaced_oplus_K : ∀ u v w : V4, leK u v → leK (oplus u w) (oplus v w) := by decide

/-- De Morgan for the truth-order operations, and negation's *knowledge*-order behaviour:
    `neg` is order-REVERSING for `≤_t` and order-PRESERVING for `≤_k`. The second half is
    the one people forget, and it is what makes "information" an axis negation cannot move. -/
theorem neg_antitone_T : ∀ u v : V4, leT u v → leT (neg v) (neg u) := by decide
theorem neg_monotone_K : ∀ u v : V4, leK u v → leK (neg u) (neg v) := by decide

/-! ### The two characteristic failures of the neighbouring three-valued logics. -/

/-- **Excluded middle fails at the gap** -- Kleene K3's characteristic loss. `N ∨ ¬N = N`,
    which is not designated. -/
theorem lem_fails : ¬ designated (orT N (neg N)) := by decide

/-- **A contradiction is assertible at the glut** -- Priest LP's characteristic feature.
    `B ∧ ¬B = B`, which IS designated, so accepting it does not force triviality. Note
    this is the exact dual of `lem_fails`, at the *other* negation-fixed value. -/
theorem glut_designated : designated (andT B (neg B)) ∧ andT B (neg B) = B := by decide

/-- Classical logic is recovered exactly on `{T, F}`: excluded middle holds there and
    nowhere else. -/
theorem lem_iff_classical :
    ∀ u : V4, designated (orT u (neg u)) ↔ (u = T ∨ u = F ∨ u = B) := by decide

end V4

/-! ## Part C. The Bloch ball has two independent coordinates. -/

/-- A Bloch vector as a bare triple of reals. See OUT OF SCOPE: no positivity constraint,
    no density matrix, no Hilbert space. -/
abbrev Bloch := ℝ × ℝ × ℝ

namespace Bloch

/-- Squared Bloch radius. Purity of the corresponding density matrix would be
    `(1 + rsq)/2`, so this is an affine reparametrisation of purity -- asserted in the
    essay's prose, not proved here. -/
def rsq (v : Bloch) : ℝ := v.1 ^ 2 + v.2.1 ^ 2 + v.2.2 ^ 2

/-- The z coordinate: the essay's truth axis. -/
def zc (v : Bloch) : ℝ := v.2.2

/-- Convex combination. For density matrices this is literally a statistical mixture, and
    the Bloch vector of a mixture is the same combination of the Bloch vectors, because
    `rho = (I + r·sigma)/2` is affine in `r`. -/
def mix (t : ℝ) (a b : Bloch) : Bloch :=
  (t * a.1 + (1 - t) * b.1, t * a.2.1 + (1 - t) * b.2.1, t * a.2.2 + (1 - t) * b.2.2)

/-- **z is affine under mixing** (essay handle `z-affine`). Ignorance about which of two
    states you hold moves the truth coordinate exactly as a probability would. -/
theorem zc_mix_affine (t : ℝ) (a b : Bloch) :
    zc (mix t a b) = t * zc a + (1 - t) * zc b := rfl

/-- **The radius is not affine** (essay handle `r-drop`). Mixing `|0>` with `|1>` in equal
    parts gives radius 0, while the average of the two radii is 1. So `r` is a genuinely
    second coordinate: it records something the truth axis cannot, and mixing destroys it
    while leaving `z` behaving classically. -/
theorem rsq_not_affine :
    ∃ (t : ℝ) (a b : Bloch), rsq (mix t a b) ≠ t * rsq a + (1 - t) * rsq b := by
  refine ⟨1/2, (0, 0, 1), (0, 0, -1), ?_⟩
  simp only [rsq, mix]
  norm_num

/-- **The equator and the centre are different points with the same truth coordinate**
    (essay handle `equator-vs-centre`).

    `(1,0,0)` is a pure coherent superposition; `(0,0,0)` is the maximally mixed state.
    Both sit at `z = 0`, i.e. both are exactly as far from proven-true as from
    proven-false. They differ only in radius. Any logical reading that assigns meaning to
    `z` alone therefore CANNOT distinguish them -- which is the essay's central structural
    complaint about reading the equator as "undecidable". -/
theorem equator_two_kinds :
    ∃ a b : Bloch, zc a = 0 ∧ zc b = 0 ∧ rsq a ≠ rsq b := by
  refine ⟨(1, 0, 0), (0, 0, 0), rfl, rfl, ?_⟩
  simp only [rsq]
  norm_num

/-- The centre is reachable as a mixture of the two poles, and so is *every* point of the
    z-axis: classical ignorance about a proven-true/proven-false pair fills the axis and
    nothing else. Nothing off-axis is a mixture of the poles alone. -/
theorem axis_from_poles (t : ℝ) :
    mix t (0, 0, 1) (0, 0, -1) = (0, 0, t * 1 + (1 - t) * (-1)) := by
  simp only [mix]
  norm_num

/-- The equatorial pure state `(1,0,0)` is NOT a mixture of the two poles, for any `t`:
    coherence is information the truth axis has no room for. -/
theorem equator_not_from_poles :
    ∀ t : ℝ, mix t (0, 0, 1) (0, 0, -1) ≠ (1, 0, 0) := by
  intro t h
  rw [axis_from_poles] at h
  exact absurd (congrArg Prod.fst h) (by norm_num)

end Bloch

end Toesnail.LogicBloch
