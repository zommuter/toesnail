/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into any `*.toml` sidecar or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/fhe-encrypted-algorithm.md`, on
  the owner's second stated goal: encrypting the ALGORITHM as well as the data.

  Owner-authored source of the counting the first theorem sharpens:

    `crypto/fhe.md:8`  "there are O(n,m) = (2^I)^m = 2^(m 2^n) possible functions from n
                        to m bits. These functions can be enumerated using m 2^n bits."

  `crypto/fhe.md:8` states the enumeration length as a fact about a particular encoding.
  `universal_card_lower` turns the same count into a LOWER BOUND on every possible
  encoding: no universal evaluator, however clever, can carry a program shorter than
  2^n bits, because programs must separate functions. `tt_card` shows the truth table
  attains it, so 2^n is exact and not merely necessary. This is the pigeonhole reading
  of the owner's own line; the sibling essay `docs/dreamed/fhe-counting.md` proves the
  count itself (`ocount`).

  `oblivious_cost_constant` is the essay's second point: if the evaluator cannot
  distinguish two programs then it cannot spend different amounts of time on them, so an
  encrypted algorithm runs a fixed schedule -- its worst case. Experiment F of
  `docs/dreamed/fhe-search/circuit_search.py` measures the resulting padding factor for
  Euclid's algorithm (converging to about 2.5x).

  Check with:
    cd verify && nice -n19 lake env lean --threads=2 ../docs/dreamed/lean/FHEUniversal.lean
-/

import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi

namespace FHEUniversal

/-! ## 1. A universal evaluator cannot compress its program

Private function evaluation hides *which* function is computed by making the function an
input: the evaluator runs a fixed `U` on a program `p` and data `x`. The question the
essay asks is what that costs. The first half of the answer is: nothing, in program
length -- the bound below is met exactly, so the truth table is already optimal. -/

/-- `U` is universal for `n`-bit Boolean functions when every such function has a
program. -/
def Universal {P : Type*} {n : ℕ} (U : P → (Fin n → Bool) → Bool) : Prop :=
  ∀ f : (Fin n → Bool) → Bool, ∃ p, ∀ x, U p x = f x

/-- The number of `n`-bit inputs is `2^n` -- the `I` of `crypto/fhe.md:8`. -/
theorem card_inputs (n : ℕ) : Fintype.card (Fin n → Bool) = 2 ^ n := by
  simp

/-- The number of Boolean functions of `n` inputs is `2^(2^n)` -- `O(n,1)`. -/
theorem card_functions (n : ℕ) :
    Fintype.card ((Fin n → Bool) → Bool) = 2 ^ 2 ^ n := by
  simp

/-- **The program-bit floor.** Any universal evaluator needs at least `2^(2^n)`
programs, hence at least `2^n` bits of program. The proof is that `U` viewed as a map
from programs to functions is surjective, so it cannot shrink cardinality. -/
theorem universal_card_lower {P : Type*} [Fintype P] {n : ℕ}
    (U : P → (Fin n → Bool) → Bool) (hU : Universal U) :
    2 ^ 2 ^ n ≤ Fintype.card P := by
  have hsurj : Function.Surjective U := fun f => by
    obtain ⟨p, hp⟩ := hU f
    exact ⟨p, funext hp⟩
  have h := Fintype.card_le_of_surjective U hsurj
  rwa [card_functions] at h

/-- The floor is attained: the truth table itself is a universal program of exactly
`2^n` bits. So `crypto/fhe.md:8`'s enumeration length is not merely one encoding among
many -- it is optimal. -/
theorem tt_universal (n : ℕ) :
    Universal (fun (p : (Fin n → Bool) → Bool) (x : Fin n → Bool) => p x) :=
  fun f => ⟨f, fun _ => rfl⟩

theorem tt_card (n : ℕ) :
    Fintype.card ((Fin n → Bool) → Bool) = 2 ^ 2 ^ n := card_functions n

/-! ## 2. An encrypted algorithm runs its worst case

The second cost is not about size but about time. An evaluator that cannot tell two
programs apart cannot spend different effort on them; whatever schedule it runs, it runs
for both. Stated abstractly so it does not depend on a machine model: `obs` is whatever
the evaluator can observe, and the only assumption is that the cost it pays is a
function of what it observes. -/

/-- **Obliviousness forces a constant schedule.** If the evaluator's observation does not
distinguish two programs, and its cost is determined by that observation, then its cost
is the same for both -- hence equal to the worst case over all of them. -/
theorem oblivious_cost_constant {P O : Type*} (obs : P → O) (cost : P → ℕ) (g : O → ℕ)
    (hcost : ∀ p, cost p = g (obs p)) (hind : ∀ p q, obs p = obs q) :
    ∀ p q, cost p = cost q := by
  intro p q
  rw [hcost p, hcost q, hind p q]

/-- The same conclusion in the form the essay uses: the constant schedule is at least
every individual program's requirement, so it is the maximum, not an average. -/
theorem oblivious_pays_worst_case {P O : Type*} [Fintype P] (obs : P → O) (cost : P → ℕ)
    (g : O → ℕ) (hcost : ∀ p, cost p = g (obs p)) (hind : ∀ p q, obs p = obs q) :
    ∀ p q, cost q ≤ cost p := fun p q =>
  le_of_eq (oblivious_cost_constant obs cost g hcost hind q p)

/-- What the two theorems above do NOT say, recorded as a definition rather than a
theorem because it is a computability statement: for an arbitrary encrypted program
there is no worst case to pad TO, since the trip count is not computable from the
program. This is why fully homomorphic encryption is stated for circuits and not for
programs. STATED, NOT PROVED, and it would need a machine model to state properly. -/
def WorstCaseExists {P : Type*} (cost : P → Option ℕ) : Prop :=
  ∃ b : ℕ, ∀ p, ∀ c ∈ cost p, c ≤ b

end FHEUniversal
