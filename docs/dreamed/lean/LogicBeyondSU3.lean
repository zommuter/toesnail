/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-beyond-su3.md`.

  ---------------------------------------------------------------------------
  SEED (owner's words, this session, verbatim)

      "Also explore non-SU(3) representations of non-trivial logic that considers
       provability / undecidability etc"

  The essay surveys eight candidate carriers for a logic that takes provability and
  undecidability seriously, and ranks them. This file discharges the two small,
  load-bearing facts behind the top two entries of that ranking. It proves nothing
  about SU(3), nothing about the qutrit, and nothing about physics.

  ---------------------------------------------------------------------------
  PART A -- HEYTING ALGEBRAS (essay candidate 1, ranked first)

  Reading the Lean symbols back into the essay's language:

    `α` with `[HeytingAlgebra α]`
                   the algebra of TRUTH VALUES of a constructive logic. Under the
                   BHK reading an element is "the set of constructions establishing
                   this proposition", so `⊤` = established, `⊥` = refuted, and
                   everything in between is a genuine intermediate STATUS, not a
                   probability and not an ignorance weight.
    `a ⇨ b`        relative pseudocomplement: the LARGEST truth value `c` with
                   `c ⊓ a ≤ b`. This is what makes a Heyting algebra a Heyting
                   algebra; a lattice can have `⊓ ⊔ ⊥ ⊤` and no `⇨`.
    `aᶜ`           `a ⇨ ⊥`, intuitionistic negation: "a construction of `a` yields
                   a contradiction". NOT set-theoretic complement.
    `a ⊔ aᶜ = ⊤`   the law of excluded middle FOR THAT `a`.
    `aᶜᶜ = a`      double negation elimination FOR THAT `a`.

  `heyting_lem_forces_dne` and `heyting_lem_forces_isCompl` are the COLLAPSE
  THEOREM the essay leans on: a Heyting algebra in which excluded middle holds
  everywhere is a Boolean algebra. That is the precise sense in which intuitionistic
  logic is the non-trivial choice -- assume LEM and the whole extra structure
  evaporates, leaving exactly the two-valued classical picture the owner's project
  is trying to escape.

  `chain3` is the concrete countermodel. `Fin 3 = {0 < 1 < 2}` with its Heyting
  structure is, up to isomorphism, all three of:
    - the frame of OPEN SETS of the Sierpinski space (∅, {1}, {0,1});
    - the algebra of UP-SETS of the two-world Kripke frame `w₀ ≤ w₁`, i.e. "one
      state of information, and one strictly better one";
    - the three-element Goedel chain.
  In it, `1` (the middle element, the essay's "not settled here, settled later")
  has `1ᶜ = 0`, so `1 ⊔ 1ᶜ = 1 ≠ ⊤` and `1ᶜᶜ = ⊤ ≠ 1`. Excluded middle and double
  negation both fail, concretely, by `decide`.

  `chain3_weak_lem` and `chain3_prelinearity` are the HONEST LIMIT of that
  countermodel, and they are in this file precisely so the essay cannot overclaim:
  the chain still validates weak excluded middle `aᶜ ⊔ aᶜᶜ = ⊤` and the Goedel-Dummett
  prelinearity axiom `(a ⇨ b) ⊔ (b ⇨ a) = ⊤`. So `Fin 3` is a model of GOEDEL logic
  G₃, strictly between intuitionistic and classical logic, and it is NOT a
  countermodel for every non-classical principle one might want. A frame refuting
  weak excluded middle has to be non-directed (the branching Kripke frame
  `w₀ ≤ w₁`, `w₀ ≤ w₂` with `w₁`, `w₂` incomparable); that is stated in the essay
  and is NOT proved here.

  ---------------------------------------------------------------------------
  PART B -- PROVABILITY LOGIC GL (essay candidate 2, ranked second)

    `P`            the type of SENTENCES of a formal theory (abstract; no syntax,
                   no Goedel numbering, no arithmetic is built here).
    `S.Thm a`      "the theory proves `a`".
    `S.box a`      the sentence "`a` is provable in the theory", i.e. the object-level
                   provability predicate `Prov_T(⌜a⌝)`, NOT the metalevel `S.Thm`.
                   Keeping those two apart is the entire content of provability logic.
    `S.mp`, `S.nec`
                   modus ponens and the necessitation rule (Hilbert-Bernays-Loeb
                   derivability condition 1).
    `S.loeb`       Loeb's axiom `□(□a → a) → □a`, the single axiom that turns modal
                   logic K into GL.
    `S.Con`        `□⊥ → ⊥`, the theory's own consistency statement.
    `S.Consistent` the METAtheoretic statement that the theory does not prove `⊥`.

  `loeb_rule` derives Loeb's RULE from Loeb's AXIOM in three steps (necessitate,
  detach the axiom, detach the hypothesis). `godel_two` then reads Goedel's second
  incompleteness theorem straight off it at `a := ⊥`: a consistent theory does not
  prove its own consistency. `no_global_reflection` is the same one-liner at the
  same instance: a consistent theory cannot prove the reflection schema `□a → a`
  for every sentence.

  `boolModel` witnesses that the axiom bundle is NON-VACUOUS (a structure satisfying
  all four fields exists, with `Thm ⊥` false), so `godel_two` is not vacuously true
  of an empty class. It is a DEGENERATE model -- `box` is constantly `⊤` -- and it is
  here for that non-vacuity check alone.

  ---------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):
    - This is NOT Goedel's second incompleteness theorem about PA. `godel_two` is a
      theorem about any structure satisfying the four stated conditions. The hard
      content of the real theorem is that PA's provability predicate SATISFIES them
      (Hilbert-Bernays-Loeb derivability conditions + arithmetisation of syntax);
      none of that is formalised here or anywhere in this repo.
    - This is NOT Solovay's arithmetical completeness theorem (1976), NOT Segerberg's
      modal completeness with respect to finite transitive irreflexive trees, and NOT
      the decidability / PSPACE-completeness of GL. All three are cited in the essay
      and proved nowhere here.
    - This is NOT a theorem about SU(3), the qutrit Bloch body, or any Hilbert space.
      No density matrix, no positivity constraint, no Gell-Mann basis appears. The
      comparison with `lean/LogicQutrit.lean` is made in PROSE only.
    - This is NOT Chang's completeness theorem for MV-algebras, NOT Stone duality, NOT
      Gleason, and NOT anything about the effective topos. Candidates 3-8 of the essay
      are surveyed there and discharged here not at all.
    - `chain3` being a model of Goedel logic G₃ is shown only by the two `decide`
      checks named above; the essay's claim that G₃ is exactly the logic of linear
      Kripke frames is classical and is NOT proved here.
-/
import Mathlib.Order.Heyting.Basic
import Mathlib.Order.Fin.Basic

namespace Toesnail.LogicBeyondSU3

/-! ## Part A. Heyting algebras: the collapse theorem and a concrete countermodel -/

section Heyting

variable {α : Type*} [HeytingAlgebra α]

/-- **The collapse theorem, half one.** In a Heyting algebra in which the law of
    excluded middle holds for every element, double negation elimination holds too.

    The proof is the one line that makes intuitionistic logic interesting: cut the
    assumed unit `a ⊔ aᶜ` with `aᶜᶜ`, distribute (a Heyting algebra is automatically
    a distributive lattice), and note that the `aᶜᶜ ⊓ aᶜ` branch is `⊥` because
    `aᶜ ⊓ aᶜᶜ = ⊥` always holds. What is left is `aᶜᶜ = aᶜᶜ ⊓ a ≤ a`.

    Essay reading: assume "every statement is provable or refutable" and the space
    of truth values loses every intermediate element. There is no such thing as a
    Heyting algebra that satisfies excluded middle and still has room for an
    undecided status. -/
theorem heyting_lem_forces_dne (h : ∀ a : α, a ⊔ aᶜ = ⊤) (a : α) : aᶜᶜ = a := by
  refine le_antisymm ?_ le_compl_compl
  have hd : aᶜᶜ ⊓ (a ⊔ aᶜ) = aᶜᶜ ⊓ a ⊔ aᶜᶜ ⊓ aᶜ := inf_sup_left _ _ _
  have h2 : aᶜᶜ ⊓ aᶜ = ⊥ := by rw [inf_comm]; exact inf_compl_self _
  rw [h a, inf_top_eq, h2, sup_bot_eq] at hd
  exact hd.le.trans inf_le_right

/-- **The collapse theorem, half two.** Under the same hypothesis every element has
    `aᶜ` as a genuine Boolean complement: they are disjoint and codisjoint. Together
    with `heyting_lem_forces_dne` this is the statement "a Heyting algebra satisfying
    excluded middle is Boolean", in the form Mathlib's `IsCompl` already names.

    Note what each half needs. Disjointness `a ⊓ aᶜ = ⊥` is free in ANY Heyting
    algebra -- intuitionistic logic never gave up non-contradiction. Only
    codisjointness `a ⊔ aᶜ = ⊤` is the assumption. The asymmetry is the essay's
    point: constructive logic drops excluded middle and keeps non-contradiction, so
    it models a GAP and not a GLUT, exactly as the sibling `logic-bloch-poles.md`
    found for the Bloch ball. -/
theorem heyting_lem_forces_isCompl (h : ∀ a : α, a ⊔ aᶜ = ⊤) (a : α) : IsCompl a aᶜ :=
  ⟨disjoint_compl_right, codisjoint_iff.mpr (h a)⟩

/-- Non-contradiction, stated separately to make the asymmetry above unmissable: it
    needs no hypothesis at all. -/
theorem heyting_noncontradiction (a : α) : a ⊓ aᶜ = ⊥ := inf_compl_self a

/-- **Triple negation collapses, double negation does not.** `aᶜᶜᶜ = aᶜ` is an
    intuitionistic theorem, so the negation hierarchy has exactly two levels, not
    infinitely many. This is why "not proven false" is a genuinely new status while
    "not not proven false" is not a third one. -/
theorem heyting_triple_compl (a : α) : aᶜᶜᶜ = aᶜ :=
  le_antisymm (compl_le_compl le_compl_compl) le_compl_compl

end Heyting

/-! ### The concrete countermodel: the three-element chain -/

/-- The three-element chain `0 < 1 < 2` as a Heyting (indeed bi-Heyting) algebra.
    Isomorphic to the opens of the Sierpinski space and to the up-sets of the
    two-world Kripke frame `w₀ ≤ w₁`. Mathlib supplies the construction for any
    bounded linear order; it is `noncomputable` only because that construction is,
    which does not stop `decide` from evaluating the three-element instance. -/
noncomputable instance chain3 : BiheytingAlgebra (Fin 3) :=
  LinearOrder.toBiheytingAlgebra (Fin 3)

/-- In the chain the middle element negates to `⊥`: from "not settled here" you can
    derive no contradiction, so its negation is the weakest possible thing. -/
theorem chain3_compl_mid : (1 : Fin 3)ᶜ = 0 := by decide

/-- **Excluded middle FAILS, concretely.** `1 ⊔ 1ᶜ = 1 ≠ ⊤`. The essay's candidate 1
    rests on this element existing at all. -/
theorem chain3_lem_fails : (1 : Fin 3) ⊔ (1 : Fin 3)ᶜ ≠ ⊤ := by decide

/-- **Double negation elimination FAILS, concretely.** `1ᶜᶜ = ⊤ ≠ 1`: the middle
    element is not-not-true without being true. This is the algebraic shadow of the
    Goedel situation the owner is after -- a sentence that resists refutation without
    being established. -/
theorem chain3_dne_fails : ((1 : Fin 3)ᶜᶜ) ≠ (1 : Fin 3) := by decide

/-- Contrapositive sanity check: since excluded middle fails somewhere in `Fin 3`,
    `heyting_lem_forces_dne` cannot apply to it, and indeed does not. Stated as the
    combined form the essay quotes: no Heyting algebra can both contain a strictly
    intermediate element of this kind and satisfy excluded middle. -/
theorem chain3_not_boolean : ¬ (∀ a : Fin 3, a ⊔ aᶜ = ⊤) := by decide

/-- **The honest limit, part one.** The chain still validates WEAK excluded middle
    `aᶜ ⊔ aᶜᶜ = ⊤` (the De Morgan / Jankov axiom). So refuting excluded middle does
    not automatically refute everything classical, and this countermodel is weaker
    than an arbitrary Heyting algebra. -/
theorem chain3_weak_lem : ∀ a : Fin 3, aᶜ ⊔ aᶜᶜ = ⊤ := by decide

/-- **The honest limit, part two.** The chain validates Goedel-Dummett prelinearity
    `(a ⇨ b) ⊔ (b ⇨ a) = ⊤`, so it is a model of Goedel logic G₃, strictly between
    intuitionistic and classical logic. Any claim in the essay that needs a genuinely
    intuitionistic (non-linear) countermodel must use a branching Kripke frame
    instead, and the essay says so. -/
theorem chain3_prelinearity : ∀ a b : Fin 3, (a ⇨ b) ⊔ (b ⇨ a) = ⊤ := by decide

/-! ## Part B. Provability logic: Loeb's axiom, Loeb's rule, Goedel II -/

/-- An abstract **GL system**: sentences `P`, a theoremhood predicate `Thm`, an
    implication, a falsum, and a provability operator `box`, closed under modus
    ponens and necessitation and satisfying Loeb's axiom.

    Nothing here is arithmetic. The real theorem about Peano Arithmetic is that its
    `Prov_T` predicate satisfies these conditions; that is the Hilbert-Bernays-Loeb
    derivability-conditions half, and it is not formalised in this repo. What IS
    shown below is that Goedel's second theorem is then three lines of modal
    bookkeeping, which is the essay's actual claim about candidate 2: GL is about
    provability by construction, not by analogy. -/
structure GLSystem (P : Type u) where
  /-- Object-level implication between sentences. -/
  imp : P → P → P
  /-- Object-level provability predicate: `box a` is the sentence "`a` is provable". -/
  box : P → P
  /-- The falsum sentence. -/
  bot : P
  /-- Metalevel theoremhood: `Thm a` says the theory proves the sentence `a`. -/
  Thm : P → Prop
  /-- Modus ponens. -/
  mp : ∀ {a b : P}, Thm (imp a b) → Thm a → Thm b
  /-- Necessitation (derivability condition 1): what is proved is provably provable. -/
  nec : ∀ {a : P}, Thm a → Thm (box a)
  /-- **Loeb's axiom** `□(□a → a) → □a`, the axiom that makes GL GL. -/
  loeb : ∀ a : P, Thm (imp (box (imp (box a) a)) (box a))

namespace GLSystem

variable {P : Type u} (S : GLSystem P)

/-- The theory's own consistency statement, `□⊥ → ⊥`. -/
def Con : P := S.imp (S.box S.bot) S.bot

/-- Metatheoretic consistency: the theory does not prove `⊥`. Note this is a
    statement in Lean ABOUT the system, not a sentence of the system. -/
def Consistent : Prop := ¬ S.Thm S.bot

/-- **Loeb's rule from Loeb's axiom.** If the theory proves `□a → a` then it proves
    `a`. Three steps: necessitate the hypothesis to get `□(□a → a)`; detach Loeb's
    axiom to get `□a`; detach the hypothesis to get `a`.

    Read as a slogan: a theory that can prove "if I can prove it, it is true" for a
    given sentence has thereby already proved that sentence. Self-trust is never
    free. -/
theorem loeb_rule {a : P} (h : S.Thm (S.imp (S.box a) a)) : S.Thm a :=
  S.mp h (S.mp (S.loeb a) (S.nec h))

/-- **Goedel's second incompleteness theorem, in this abstract setting.** A
    consistent GL system does not prove its own consistency.

    The whole proof is `loeb_rule` at `a := ⊥`, because `Con` IS `□⊥ → ⊥`, which is
    the reflection instance for `⊥`. If the theory proved it, Loeb's rule would hand
    back `⊥`. -/
theorem godel_two (hc : S.Consistent) : ¬ S.Thm S.Con :=
  fun h => hc (S.loeb_rule h)

/-- **No global reflection.** A consistent GL system cannot prove the reflection
    schema `□a → a` for every sentence `a`. Same one-line argument, same instance.
    This is the sharpest form of the essay's point about a layered core: the upper
    layer cannot certify its own soundness to the lower one. -/
theorem no_global_reflection (hc : S.Consistent) :
    ¬ (∀ a : P, S.Thm (S.imp (S.box a) a)) :=
  fun h => hc (S.loeb_rule (h S.bot))

end GLSystem

/-- A **non-vacuity witness**: a `GLSystem` structure really can be inhabited with a
    `Thm` predicate that does not prove `⊥`, so `godel_two` is not vacuous.

    Deliberately degenerate: sentences are booleans, `box` is constantly `true`,
    `Thm` is "equals `true`". It satisfies all four conditions and is consistent.
    It is emphatically NOT a model of arithmetic and proves nothing about PA; it is
    here so that the abstract theorems above are known to have a non-empty subject. -/
def boolModel : GLSystem Bool where
  imp a b := (!a || b)
  box _ := true
  bot := false
  Thm a := a = true
  mp := by intro a b h1 h2; subst h2; simpa using h1
  nec := by intro a _; rfl
  loeb := by intro a; rfl

theorem boolModel_consistent : boolModel.Consistent := by
  intro h
  exact Bool.noConfusion h

/-- And the conclusion of `godel_two` really does hold of it: the degenerate model
    does not prove its own consistency statement. -/
theorem boolModel_not_prove_con : ¬ boolModel.Thm boolModel.Con :=
  boolModel.godel_two boolModel_consistent

end Toesnail.LogicBeyondSU3
