/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-bpi.md`, which discharges the
  first follow-up adopted in `docs/meeting-notes/2026-09-07-1508-bloch-truth-rulings.md`
  D4.1.

  THE CLAIM BEING TESTED. `docs/dreamed/logic-z2-grading.md` section 4.3 wrote, and flagged
  as unverified:

      "The negation cover is section 3.2's B -> B/~, whose *coherent* sections are
       ultrafilters. In ZFC one always exists (Boolean Prime Ideal theorem), so the
       obstruction vanishes. In ZF it need not: BPI is not provable from ZF and is strictly
       weaker than choice. So 'does this Boolean algebra admit a coherent sign?' is
       non-trivial exactly when the ambient set theory is choiceless, which is exactly the
       regime the owner's origin quote names."

  Both sentences are true of a GENERAL Boolean algebra. This file discharges the reason the
  lead does not reach the object the project cares about: the Lindenbaum-Tarski algebra of a
  theory in a countable language is countable, and for an ENUMERATED Boolean algebra a prime
  ideal is built by a bare recursion that consults nothing but the algebra's own operations.
  No maximal element is invoked, no Zorn, no well-ordering, no choice function.

  Reading the Lean symbols back into the essay's language:

    `B`                  the Lindenbaum-Tarski algebra of a theory `T`: sentences modulo
                         `T`-provable equivalence. `bot` is the refutable class, `top` the
                         class of theorems, and meet, join, complement are conjunction,
                         disjunction and negation.
    `(top : B) != bot`   `T` is CONSISTENT. This is the only nondegeneracy input.
    `e : Nat -> B`       a Goedel numbering: an enumeration of the algebra. For a theory in a
                         countable language this exists outright, as a definable function.
                         It is the hypothesis that replaces choice.
    `Function.Surjective e`
                         the enumeration is onto, so every sentence gets looked at. This is
                         what "countable" contributes, and all that it contributes.
    `approx e n`         the running conjunction of the first `n` decisions. The construction
                         walks the enumeration and, at stage `n`, adds `e n` if that keeps the
                         conjunction consistent and adds its negation otherwise. This is
                         Lindenbaum's lemma, written out.
    `eq_bot_of_inf_eq_bot_of_inf_compl_eq_bot`
                         the step lemma, and the whole mathematical content: if BOTH
                         extensions were inconsistent, the conjunction so far was already
                         inconsistent. Distributivity plus excluded middle, nothing else.
    `gen e`              the resulting ultrafilter, which is a complete consistent extension
                         of `T`, a point of the Stone space, and one of the essay's
                         "coherent signs".
    `idealOfGen e`       its complementary prime ideal, in Mathlib's `Order.Ideal` type, so
                         the output is the same object Mathlib's choice-based BPI returns.
    `inf_mem_gen_iff`, `sup_mem_gen_iff`, `mem_gen_iff_compl_notMem_gen`
                         the assignment is two-valued and respects conjunction, disjunction
                         and negation. That is exactly "a coherent truth assignment".

  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):

    - **This file does NOT certify that the construction is choice-free, and Lean cannot.**
      `#print axioms` is run at the bottom on five constants, one of which is a deliberate
      CONTROL, `probe`, which is nothing but `if x meet y = bot then x-complement else y`.
      The control already reports `Classical.choice`, so that dependency is inherited from
      Mathlib's order hierarchy and is no evidence about any argument here. The audit is
      reported because its NEGATIVE result is worth knowing: over Mathlib, `#print axioms` is
      not a usable choice-freeness oracle. The choice-freeness claim in the essay is a claim
      about the informal ZF proof, which this file makes explicit but does not formalise.
    - This is NOT a formalisation of BPI, and it does NOT refute BPI. For a general Boolean
      algebra the theorem below is simply unavailable, because there is no `e`. Mathlib's
      genuine BPI, `DistribLattice.prime_ideal_of_disjoint_filter_ideal`, is proved by Zorn
      and is included in the audit for contrast.
    - Nothing here is about PA, arithmetic, Goedel-Rosser, or the Stone space's topology. The
      identification of `B` with a Lindenbaum-Tarski algebra is made in the essay's prose and
      is used nowhere below. In particular the essay's separate point, that the completion
      produced here is NOT COMPUTABLE, is a fact about PA and is not formalised.
    - `approx` uses `if`, hence `DecidableEq B`. For a real Lindenbaum-Tarski algebra that
      instance is not computable: equality there is `T`-provable equivalence, which is only
      semi-decidable. The essay says so; the Lean file takes the instance as a hypothesis and
      is silent about where it comes from.
    - The construction is not canonical. A different enumeration gives a different
      ultrafilter, and `sign_never_canonical` in `LogicZ2.lean` is the companion statement.
-/
import Mathlib.Order.PrimeIdeal
import Mathlib.Order.PrimeSeparator
import Mathlib.Order.BooleanAlgebra.Basic
import Mathlib.Data.Countable.Defs

namespace Toesnail.LogicBPI

open Order

variable {B : Type*} [BooleanAlgebra B]

/-- **The step lemma**, handle `step`. If adding `b` and adding `bᶜ` both make the running
conjunction `a` inconsistent, then `a` was already inconsistent.

This is the entire nontrivial content of Lindenbaum's lemma, and it is pure algebra:
`a = a ⊓ (b ⊔ bᶜ) = (a ⊓ b) ⊔ (a ⊓ bᶜ)`. Distributivity and the excluded middle, with no
choice principle, no maximality and no cardinality. Everything else below is bookkeeping
around it. -/
theorem eq_bot_of_inf_eq_bot_of_inf_compl_eq_bot {a b : B}
    (h₁ : a ⊓ b = ⊥) (h₂ : a ⊓ bᶜ = ⊥) : a = ⊥ :=
  calc a = a ⊓ b ⊔ a ⊓ bᶜ := by rw [← inf_sup_left, sup_compl_eq_top, inf_top_eq]
    _ = ⊥ := by rw [h₁, h₂, bot_sup_eq]

section Enumerated

variable [DecidableEq B]

/-- The running conjunction of the decisions taken through stage `n`.

At stage `n` the construction looks at `e n` and takes it if that is consistent with what it
has already committed to, and takes its negation otherwise. The recursion consults only the
algebra: there is no set of candidates to choose from, and no chain to take a bound of. -/
def approx (e : ℕ → B) : ℕ → B
  | 0 => ⊤
  | n + 1 => if approx e n ⊓ e n = ⊥ then approx e n ⊓ (e n)ᶜ else approx e n ⊓ e n

@[simp] theorem approx_zero (e : ℕ → B) : approx e 0 = ⊤ := rfl

theorem approx_succ (e : ℕ → B) (n : ℕ) :
    approx e (n + 1) =
      if approx e n ⊓ e n = ⊥ then approx e n ⊓ (e n)ᶜ else approx e n ⊓ e n := rfl

theorem approx_succ_le (e : ℕ → B) (n : ℕ) : approx e (n + 1) ≤ approx e n := by
  rw [approx_succ]; split_ifs with h <;> exact inf_le_left

/-- The commitments only ever get stronger. -/
theorem approx_antitone (e : ℕ → B) : Antitone (approx e) :=
  antitone_nat_of_succ_le (approx_succ_le e)

/-- **Consistency is maintained at every stage**, handle `consistent`. The induction step is
the step lemma and nothing else.

This is the line where a general Boolean algebra would need BPI. There, the analogous
argument runs up a chain and must justify a limit stage; here every stage is a successor, so
there is no limit stage to justify. -/
theorem approx_ne_bot (htop : (⊤ : B) ≠ ⊥) (e : ℕ → B) : ∀ n, approx e n ≠ ⊥
  | 0 => htop
  | n + 1 => by
      rw [approx_succ]
      split_ifs with h
      · intro h2
        exact approx_ne_bot htop e n (eq_bot_of_inf_eq_bot_of_inf_compl_eq_bot h h2)
      · exact h

/-- Stage `n + 1` has settled the `n`-th element of the enumeration one way or the other. -/
theorem approx_decides (e : ℕ → B) (n : ℕ) :
    approx e (n + 1) ≤ e n ∨ approx e (n + 1) ≤ (e n)ᶜ := by
  rw [approx_succ]; split_ifs with h
  · exact Or.inr inf_le_right
  · exact Or.inl inf_le_right

/-- The filter generated by the run: everything implied by some finite stage. Read logically,
the set of sentences the completed theory asserts. -/
def gen (e : ℕ → B) : Set B := {x | ∃ n, approx e n ≤ x}

theorem top_mem_gen (e : ℕ → B) : (⊤ : B) ∈ gen e := ⟨0, le_top⟩

theorem mem_gen_of_le {e : ℕ → B} {x y : B} (h : x ≤ y) (hx : x ∈ gen e) : y ∈ gen e := by
  obtain ⟨n, hn⟩ := hx
  exact ⟨n, hn.trans h⟩

theorem inf_mem_gen {e : ℕ → B} {x y : B} (hx : x ∈ gen e) (hy : y ∈ gen e) :
    x ⊓ y ∈ gen e := by
  obtain ⟨n, hn⟩ := hx
  obtain ⟨m, hm⟩ := hy
  exact ⟨max n m, le_inf ((approx_antitone e (le_max_left n m)).trans hn)
    ((approx_antitone e (le_max_right n m)).trans hm)⟩

/-- The completed theory is consistent. -/
theorem bot_notMem_gen (htop : (⊤ : B) ≠ ⊥) (e : ℕ → B) : (⊥ : B) ∉ gen e := by
  rintro ⟨n, hn⟩
  exact approx_ne_bot htop e n (le_bot_iff.mp hn)

/-- **The completed theory is complete**, handle `complete`. Every element of the algebra is
decided, because every element is `e n` for some `n`, and stage `n + 1` decided it. -/
theorem mem_gen_or_compl_mem_gen {e : ℕ → B} (he : Function.Surjective e) (x : B) :
    x ∈ gen e ∨ xᶜ ∈ gen e := by
  obtain ⟨n, rfl⟩ := he x
  rcases approx_decides e n with h | h
  · exact Or.inl ⟨n + 1, h⟩
  · exact Or.inr ⟨n + 1, h⟩

theorem not_mem_gen_of_compl_mem_gen (htop : (⊤ : B) ≠ ⊥) {e : ℕ → B} {x : B}
    (h : xᶜ ∈ gen e) : x ∉ gen e := by
  intro hx
  exact bot_notMem_gen htop e (by simpa using inf_mem_gen hx h)

/-- Negation clause of the truth assignment, handle `tv-not`. -/
theorem mem_gen_iff_compl_notMem_gen (htop : (⊤ : B) ≠ ⊥) {e : ℕ → B}
    (he : Function.Surjective e) (x : B) : x ∈ gen e ↔ xᶜ ∉ gen e := by
  constructor
  · intro hx hcx
    exact not_mem_gen_of_compl_mem_gen htop hcx hx
  · intro h
    exact (mem_gen_or_compl_mem_gen he x).resolve_right h

/-- Conjunction clause of the truth assignment, handle `tv-and`. -/
theorem inf_mem_gen_iff {e : ℕ → B} {x y : B} :
    x ⊓ y ∈ gen e ↔ x ∈ gen e ∧ y ∈ gen e :=
  ⟨fun h => ⟨mem_gen_of_le inf_le_left h, mem_gen_of_le inf_le_right h⟩,
   fun h => inf_mem_gen h.1 h.2⟩

/-- Disjunction clause of the truth assignment, handle `tv-or`. This is primeness: the
completed theory asserts a disjunction only if it asserts a disjunct. -/
theorem sup_mem_gen_iff {e : ℕ → B} (he : Function.Surjective e) {x y : B} :
    x ⊔ y ∈ gen e ↔ x ∈ gen e ∨ y ∈ gen e := by
  constructor
  · intro h
    rcases mem_gen_or_compl_mem_gen he x with hx | hx
    · exact Or.inl hx
    · refine Or.inr (mem_gen_of_le (le_refl _) ?_)
      have : (x ⊔ y) ⊓ xᶜ ∈ gen e := inf_mem_gen h hx
      refine mem_gen_of_le ?_ this
      calc (x ⊔ y) ⊓ xᶜ = x ⊓ xᶜ ⊔ y ⊓ xᶜ := by rw [inf_sup_right]
        _ ≤ y := by simp
  · rintro (h | h)
    · exact mem_gen_of_le le_sup_left h
    · exact mem_gen_of_le le_sup_right h

/-- The complementary ideal, packaged as Mathlib's `Order.Ideal` so that the output type is
the one Mathlib's choice-based BPI also produces. -/
def idealOfGen (e : ℕ → B) : Order.Ideal B where
  carrier := {x | xᶜ ∈ gen e}
  lower' := by
    intro a b hba ha
    exact mem_gen_of_le (compl_le_compl hba) ha
  nonempty' := ⟨⊥, by simpa using top_mem_gen e⟩
  directed' := by
    rintro x hx y hy
    refine ⟨x ⊔ y, ?_, le_sup_left, le_sup_right⟩
    have : xᶜ ⊓ yᶜ ∈ gen e := inf_mem_gen hx hy
    simpa [compl_sup] using this

theorem isProper_idealOfGen (htop : (⊤ : B) ≠ ⊥) (e : ℕ → B) :
    Order.Ideal.IsProper (idealOfGen e) := by
  refine Order.Ideal.isProper_of_notMem (p := (⊤ : B)) ?_
  show ¬ ((⊤ : B)ᶜ ∈ gen e)
  rw [compl_top]
  exact bot_notMem_gen htop e

theorem isPrime_idealOfGen (htop : (⊤ : B) ≠ ⊥) {e : ℕ → B} (he : Function.Surjective e) :
    Order.Ideal.IsPrime (idealOfGen e) := by
  haveI := isProper_idealOfGen htop e
  refine Order.Ideal.isPrime_of_mem_or_compl_mem ?_
  intro x
  show xᶜ ∈ gen e ∨ xᶜᶜ ∈ gen e
  rw [compl_compl]
  exact (mem_gen_or_compl_mem_gen he x).symm

/-- **The headline**, handle `enum-prime`. A consistent, ENUMERATED Boolean algebra has a
prime ideal, built by the explicit recursion above.

Read back: a consistent theory in a countable language has a complete consistent extension,
obtained by walking a Goedel numbering. The essay's point is what is absent from the
hypotheses. No maximal element, no chain, no Zorn, no BPI. -/
theorem exists_isPrime_of_enumeration (htop : (⊤ : B) ≠ ⊥) (e : ℕ → B)
    (he : Function.Surjective e) : ∃ I : Order.Ideal B, Order.Ideal.IsPrime I :=
  ⟨idealOfGen e, isPrime_idealOfGen htop he⟩

end Enumerated

/-- **Corollary**, handle `ctble-prime`: a countable nontrivial Boolean algebra has a prime
ideal. Stated with Mathlib's `Countable`, which supplies the enumeration.

This is NOT the headline, deliberately. `Countable` in Lean is an existential, and pulling
the enumeration out of it is a use of choice inside Lean even though the informal ZF argument
has none. The enumerated form above takes `e` as data, which is how the ZF argument gets it. -/
theorem exists_isPrime_of_countable [Countable B] [Nontrivial B] :
    ∃ I : Order.Ideal B, Order.Ideal.IsPrime I := by
  classical
  obtain ⟨e, he⟩ := exists_surjective_nat B
  exact exists_isPrime_of_enumeration top_ne_bot e he

section AxiomAudit

/-- CONTROL for the axiom audit below. Nothing but an `if` on a Boolean algebra: no
recursion, no induction, no ideal, no essay content. Whatever `#print axioms` reports for
this constant is inherited from Mathlib's order hierarchy and is not evidence about any
argument in this file. -/
def probe {C : Type*} [BooleanAlgebra C] [DecidableEq C] (x y : C) : C :=
  if x ⊓ y = ⊥ then xᶜ else y

/-
  Output at check time, with the vendored Mathlib at `leanprover/lean4:v4.30.0-rc2`:

    'Toesnail.LogicBPI.probe' depends on axioms: [propext, Classical.choice, Quot.sound]
    'Toesnail.LogicBPI.eq_bot_of_inf_eq_bot_of_inf_compl_eq_bot' depends on axioms:
        [propext, Classical.choice, Quot.sound]
    'Toesnail.LogicBPI.approx' depends on axioms: [propext, Classical.choice, Quot.sound]
    'Toesnail.LogicBPI.exists_isPrime_of_enumeration' depends on axioms:
        [propext, Classical.choice, Quot.sound]
    'DistribLattice.prime_ideal_of_disjoint_filter_ideal' depends on axioms:
        [propext, Classical.choice, Quot.sound]

  All five agree, INCLUDING the control on the first line and Mathlib's Zorn-based BPI on the
  last. The audit therefore separates nothing, and the honest conclusion is the
  methodological one recorded in the header: over Mathlib, `#print axioms` cannot be used to
  certify that an argument avoids choice.
-/
#print axioms probe
#print axioms Toesnail.LogicBPI.eq_bot_of_inf_eq_bot_of_inf_compl_eq_bot
#print axioms Toesnail.LogicBPI.approx
#print axioms Toesnail.LogicBPI.exists_isPrime_of_enumeration
#print axioms DistribLattice.prime_ideal_of_disjoint_filter_ideal

end AxiomAudit

end Toesnail.LogicBPI
