/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/omniscience.md`.

  Source of the claim (owner-authored, `physics/toesnail.md`, section
  "Subsystems: Divide and Conquer!", verbatim):

      "If |42> is known, you're omniscient and don't need to read on (since you already
       know everything including this very text. #TODO: try and proof whether omniscience
       is impossible?). Most mortals however don't, and it is infeasible to try and know
       everything about the entire universe at all times."

  The essay's proposal, which this file discharges: the honest reading of that #TODO is
  NOT a physics claim. It is Lawvere's fixed-point theorem (Lawvere 1969), whose
  contrapositive says a set cannot point-surject onto its own function space into any
  type carrying a fixed-point-free endomap. Cantor, Russell, the liar, Tarski and
  Goedel I are all instances of that one lemma.

  Reading the Lean symbols back into the owner's |42> language:

    `A`            the state space of the KNOWER (a subsystem of |42>, in the sense of
                   the doc's  |42> = |coin> ⊗ |everything else>  split).
    `B`            the space of ANSWERS the knower's knowledge returns. `Bool` = yes/no;
                   `Prop` = truth values.
    `φ : A → (A → B)`
                   "each state of the knower encodes a description of the whole".
                   Because the knower is INSIDE |42>, the thing described has `A` as a
                   factor, so the description is itself a map out of `A`. That is the
                   whole content of the argument: self-containment forces the arity
                   `A → (A → B)`, and nothing else about physics is used.
    `∀ g, ∃ a, φ a = g`
                   point-surjectivity = OMNISCIENCE: every possible description `g` is
                   actually held by some state `a` of the knower. Weaker than surjectivity
                   of a category-theoretic exponential; strong enough to break.
    `f : B → B` fixed-point-free
                   negation. On `Bool` it is `not`; on `Prop` it is `Not`, and there
                   `f`'s fixed point IS the liar sentence "this description is false".

  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):
    - This is NOT Goedel's first incompleteness theorem. Goedel I needs a consistent,
      effectively axiomatized theory interpreting enough arithmetic, plus arithmetization
      of provability. None of that appears below. A gap-free Lean 4 Goedel I is claimed
      by the FormalizedFormalLogic/Foundation project, not by this file.
    - This is NOT a theorem about quantum mechanics. No Hilbert space, no observable, no
      no-cloning. The physics-flavoured cousins (Breuer 1995, Wolpert 2008) are cited in
      the essay and proved nowhere in this repo.
    - `A`, `B` are bare types. Reading `A` as "the observer's Hilbert space" is the
      essay's SPECULATION, and is flagged as such there.
-/
import Mathlib.Logic.Basic
import Mathlib.Logic.Function.Basic

namespace Toesnail.Omniscience

universe u v

/-- **Lawvere's fixed-point theorem.** If `φ : A → (A → B)` is point-surjective (every
    map `g : A → B` is `φ a` for some `a`), then *every* endomap `f : B → B` has a fixed
    point.

    The proof is the diagonal: feed `φ` the map `g a := f (φ a a)`, which it must realise
    as some `φ a`; then `φ a a` is the fixed point, because `φ a a = g a = f (φ a a)`.

    In the doc's language: if some subsystem state could hold *every* description of the
    whole, then every operation on answers would have to be a no-op somewhere. -/
theorem lawvere {A : Type u} {B : Type v} (φ : A → (A → B))
    (hφ : ∀ g : A → B, ∃ a, φ a = g) (f : B → B) : ∃ b, f b = b := by
  obtain ⟨a, ha⟩ := hφ (fun a => f (φ a a))
  exact ⟨φ a a, (congrFun ha a).symm⟩

/-- Contrapositive of `lawvere`: a single fixed-point-free `f : B → B` rules out *any*
    point-surjective `φ : A → (A → B)`, for every `A` whatsoever. No cardinality
    assumption, no finiteness, no physics. -/
theorem no_pointSurjective_of_fixedPointFree {A : Type u} {B : Type v} {f : B → B}
    (hf : ∀ b, f b ≠ b) (φ : A → (A → B)) : ¬ (∀ g : A → B, ∃ a, φ a = g) := by
  intro hφ
  obtain ⟨b, hb⟩ := lawvere φ hφ f
  exact hf b hb

/-- **No self-describing subsystem** (the essay's headline, handle `omni`).

    Take `B := Bool` and `f := not`. Since `!b ≠ b` for both booleans, there is NO
    point-surjective `φ : A → (A → Bool)`: no state of a subsystem `A` can encode a
    complete truthful yes/no description of a whole that contains `A`.

    The obstruction is ARITY, not capacity. `A` may be as large as you like -- infinite,
    uncountable, a continuum of field configurations. The argument never counts anything.
    Consequently it survives any future physics, including a completed TOE. -/
theorem no_self_describing_subsystem {A : Type u} (φ : A → (A → Bool)) :
    ¬ (∀ g : A → Bool, ∃ a, φ a = g) :=
  no_pointSurjective_of_fixedPointFree (f := not) (by decide) φ

/-- `Not : Prop → Prop` is fixed-point-free: no proposition equals its own negation.
    This is exactly the liar sentence failing to exist as a *proposition*; `iff_not_self`
    is the classical `¬(p ↔ ¬p)`. -/
theorem not_ne_self (p : Prop) : (¬p) ≠ p := fun h => iff_not_self (Eq.to_iff h).symm

/-- `Prop`-valued form of `no_self_describing_subsystem`. The witness `f := Not` means
    the diagonal sentence built in `lawvere` is literally
    "the description I hold of myself says of me that it is false" -- the liar. -/
theorem no_self_describing_subsystem_prop {A : Type u} (φ : A → (A → Prop)) :
    ¬ (∀ g : A → Prop, ∃ a, φ a = g) :=
  no_pointSurjective_of_fixedPointFree (f := Not) not_ne_self φ

/-- **Cantor as an instance.** `Set A` is by definition `A → Prop`, so
    `no_self_describing_subsystem_prop` immediately gives Cantor's theorem: no `A`
    surjects onto its own powerset.

    Relation to Mathlib: this is the SAME statement as `Function.cantor_surjective`
    (`{α : Type u} (f : α → Set α) : ¬Surjective f`), not a strengthening of it -- it
    does NOT subsume Mathlib's, it re-derives it from the Lawvere lemma to exhibit
    Cantor as one instance of the diagonal rather than as a separate fact. Mathlib's
    dual `Function.cantor_injective` is not derived here. -/
theorem cantor_no_surjection {A : Type u} (φ : A → Set A) : ¬ Function.Surjective φ :=
  fun h => no_self_describing_subsystem_prop (fun a => (φ a : A → Prop)) (fun g => h g)

/-- Sanity check that the `f := Not` instance really is the liar: `lawvere` hands back a
    proposition `b` with `¬b = b`, and `not_ne_self` says none exists. Stated as the
    combined form the essay quotes. -/
theorem omniscience_impossible {A : Type u} :
    ¬ ∃ φ : A → (A → Prop), ∀ g : A → Prop, ∃ a, φ a = g := by
  rintro ⟨φ, hφ⟩
  exact no_self_describing_subsystem_prop φ hφ

end Toesnail.Omniscience
