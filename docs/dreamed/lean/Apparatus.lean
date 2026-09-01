/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean companion of `docs/dreamed/q6-q7-q8-apparatus.md` (Q6/Q7/Q8 editorial
  apparatus). An essay about NAMES has no theorems; this file formalizes the one
  claim in it that is genuinely mathematical, the claim its section 1 rests on:

    (1) the `\veq` assurance ladder of `CONVENTIONS.md` section 2 is a PARTIAL
        order, and deliberately NOT a total order: `\numeric` is documented as
        "a complementary counter-indicator, never the assurance badge", so it
        must not be comparable with the real rungs (`apparatus_partial_order`,
        `numeric_is_off_ramp`, `ladder_not_linear`);
    (2) the epistemic-status axis (Q6) is ORTHOGONAL to the tier axis: every
        (tier, status) combination is realizable and no status pins a tier
        (`card_apparatus`, `no_status_pins_tier`). If this failed, the whole
        Q6 tag family would be redundant with the ladder.

  `Status` here is the EXTENDED kind family the essay recommends: the two kinds
  the repo already pilots (`\definition`, `\assumption` -- see
  `_includes/custom-head.html` and the `physics/Resogram.toml` header comment)
  plus the three roadmap statuses of meeting note 2026-07-07-1228 D3. Modelling
  them as ONE inductive is itself the essay's section 1.3 argument in type form:
  one family, not two competing ones.

  Order modelled (assurance strength, CONVENTIONS.md section 2: "SymPy = fast
  heuristic CAS verdict; Lean = kernel-checked certainty"):

      sorryT < sympy < lean < sympylean        (the ladder proper)
      sorryT < numeric                          (numeric beats nothing else)

  `numeric` is comparable ONLY with `sorryT` and itself. The alternative
  evidence-subset reading (sympy and lean incomparable, both below sympylean)
  is discussed in the essay's "Surfaced for the owner"; the sidecar grammar's
  "tiers must contain the badge's tier" membership check implicitly leans that
  way, and the two readings disagree on whether achieved `lean` satisfies
  `tier_floor = "sympy"`. Pinning ONE reading is the point of this file.

  Names: `sorryT` because `sorry` is a Lean keyword; the others as in the badge
  macros. House style follows `verify/Resogram.lean`; narrow imports because
  full `import Mathlib` costs ~45 s.

  Check (from `verify/`, exit 0, zero sorry):
    nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Apparatus.lean
-/
import Mathlib.Order.Defs.PartialOrder
import Mathlib.Data.Fintype.Prod
import Mathlib.Tactic.DeriveFintype

namespace Apparatus

/-- Assurance tiers of the `\veq` badge family (`CONVENTIONS.md` section 2).
    `sorryT` = open debt `\sorry`; the rest are the achieved-tier badges. -/
inductive Tier where
  | sorryT | sympy | numeric | lean | sympylean
deriving DecidableEq, Fintype, Repr

/-- Epistemic-status / annotation KINDS: the two piloted kinds
    (`\definition`, `\assumption`) extended by the D3 roadmap statuses.
    One inductive = one family (the essay's Q6 recommendation). -/
inductive Status where
  | definition | assumption | derived | empirical | hypothesis
deriving DecidableEq, Fintype, Repr

namespace Tier

/-- Assurance order as a decidable Bool relation. `numeric` is an off-ramp:
    above `sorryT` only, incomparable with every real rung. -/
def le : Tier → Tier → Bool
  | sorryT, _ => true
  | sympy, sympy | sympy, lean | sympy, sympylean => true
  | lean, lean | lean, sympylean => true
  | sympylean, sympylean => true
  | numeric, numeric => true
  | _, _ => false

/-- The ladder is a partial order (reflexive, antisymmetric, transitive):
    125 cases, closed by `decide`. -/
instance apparatus_partial_order : PartialOrder Tier where
  le a b := le a b = true
  le_refl := by decide
  le_trans := by decide
  le_antisymm := by decide

instance : DecidableRel ((· ≤ ·) : Tier → Tier → Prop) :=
  fun a b => inferInstanceAs (Decidable (le a b = true))

/-- `\numeric` is exactly the documented counter-indicator: better than open
    debt, comparable with nothing else -- in particular it neither reaches nor
    is reached by `\sympy`, and it does not sit below `\sympylean`. -/
theorem numeric_is_off_ramp :
    Tier.sorryT ≤ Tier.numeric
      ∧ ¬ Tier.numeric ≤ Tier.sympy ∧ ¬ Tier.sympy ≤ Tier.numeric
      ∧ ¬ Tier.numeric ≤ Tier.sympylean ∧ ¬ Tier.sympylean ≤ Tier.numeric := by
  decide

/-- Because of the off-ramp the "ladder" is NOT a total order. A `\numeric`
    cross-check can never be silently read as an assurance upgrade or
    downgrade relative to any real rung. -/
theorem ladder_not_linear : ¬ ∀ a b : Tier, a ≤ b ∨ b ≤ a := by decide

end Tier

/-- Orthogonality, counted: the apparatus plane has |Tier| * |Status| = 25
    inhabitants -- no combination is collapsed away. -/
theorem card_apparatus :
    Fintype.card (Tier × Status) = Fintype.card Tier * Fintype.card Status :=
  Fintype.card_prod _ _

theorem card_apparatus_eq : Fintype.card (Tier × Status) = 25 := by decide

/-- Orthogonality, pointwise: fixing a status constrains the tier not at all --
    any two tiers are realized under the same status. So a status tag can never
    substitute for a `\veq` badge, and vice versa. -/
theorem no_status_pins_tier (s : Status) (t t' : Tier) :
    ∃ p q : Tier × Status, p.2 = s ∧ q.2 = s ∧ p.1 = t ∧ q.1 = t' :=
  ⟨(t, s), (t', s), rfl, rfl, rfl, rfl⟩

/-- Sidecar entry shape, mirroring `physics/Resogram.toml`
    (`tier_floor` + achieved `tiers`; `"sympy+lean"` reads as `sympylean`). -/
structure Entry where
  tier_floor : Tier
  achieved : List Tier

/-- Well-formedness under the ORDER reading of the floor: some achieved tier
    is at least the floor. (The membership reading would demand the floor
    itself be listed; see the essay's surfaced discrepancy.) -/
def Entry.wf (e : Entry) : Prop := ∃ t ∈ e.achieved, e.tier_floor ≤ t

instance : DecidablePred Entry.wf := fun e =>
  inferInstanceAs (Decidable (∃ t ∈ e.achieved, e.tier_floor ≤ t))

/-- The live `[edot]` entry (floor `sympy`, achieved `sympy+lean`) is
    well-formed under the order reading. -/
example : Entry.wf ⟨Tier.sympy, [Tier.sympylean]⟩ := by decide

/-- A `\numeric` cross-check never discharges a `sympy` floor: the off-ramp
    theorem, restated at the sidecar level. -/
example : ¬ Entry.wf ⟨Tier.sympy, [Tier.numeric]⟩ := by decide

/-- An entry with a floor but nothing achieved is malformed (open debt has no
    sidecar entry at all, per the `Resogram.toml` header). -/
example : ¬ Entry.wf ⟨Tier.sorryT, []⟩ := by decide

end Apparatus
