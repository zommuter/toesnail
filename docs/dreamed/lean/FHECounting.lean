/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `crypto/fhe.toml` (none exists) or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/fhe-counting.md`, scoping the four
  `\leanc` open debts of ROADMAP `id:37cc` (meeting note
  `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md`, D2).

  Sources of the claims (owner-authored `crypto/fhe.md`, quoted at the exact lines):

    `ocount`    (fhe.md:8)   O(n,m) = (2^I)^m = 2^(m*2^n) functions from n to m bits,
                             where I = 2^n. Instances used: O(0,1)=2 (l.19), O(1,1)=4
                             (l.23), 2^(2^2)=16 (l.41), 2^(2*2^2)=256 (l.74).
    `bij24`     (fhe.md:74)  (2^2)! = 24 bijective functions on 2 bits; the general
                             P = (2^n)! is stated at fhe.md:10.
    `semidestr` (fhe.md:67)  binom(2^n, 2^(n-1)) = 6 semi-destructive (balanced)
                             single-output functions at n = 2; the count-per-weight
                             binom(4,s) = 1,4,6,4,1 is stated at fhe.md:65.
    identification (fhe.md:65) "Only the six balanced functions A, B, XOR and there
                             inverses are 'semi-destructive', i.e. can be used as output
                             bit of a bijective function". This is an IDENTIFICATION of
                             an informal crypto notion with a combinatorial one; below it
                             is a DEFINITION plus a stated Prop, deliberately NOT proved.

  Notation mapping (owner's -> Lean):
    "n input bits"            `Inputs n  := Fin n → Bool`   (Fintype.card = 2^n)
    "m output bits"           `Outputs m := Fin m → Bool`   (Fintype.card = 2^m)
    "function from n to m"    `Inputs n → Outputs m`
    "bijective function"      `Equiv.Perm (Inputs n)`       (m = n, fhe.md:10)
    "balanced" (fhe.md:65)    exactly 2^(n-1) of the 2^n truth-table rows output true
    binom(N,k)                `Nat.choose N k`
    N!                        `Nat.factorial N` (`N !`)

  EXPLICITLY OUT OF SCOPE:
    - The `stirling` claim (fhe.md:12). It is real analysis (asymptotics of log2(N!)),
      not counting; it also carries a LOCATED, still-open finding (ROADMAP id:76e5, the
      ln vs log2 constant-term mismatch, independently re-confirmed by the essay). A
      faithful Lean residual bound would need Stirling-series analysis far beyond the
      counting scope here; it stays with SymPy (essay section "Surfaced for the owner").
    - PROVING balanced <-> semi-destructive. `SemiDestructive` below is a candidate
      formalization; proving the equivalence against a definition this file itself
      stipulated would attest fidelity the owner has not ratified. See the essay.
    - Anything about key schedules, security, or the OTP argument (fhe.md:14).
-/
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Perm
import Mathlib.Data.Fintype.Powerset

namespace Toesnail.FHECounting

open Nat

/-- The truth-table domain for `n` input bits (fhe.md:8's `I = 2^n` possible inputs). -/
abbrev Inputs (n : ℕ) := Fin n → Bool

/-- The codomain for `m` output bits. -/
abbrev Outputs (m : ℕ) := Fin m → Bool

/-! ## `ocount` (fhe.md:8) -/

/-- There are `2^n` possible inputs on `n` bits (fhe.md:8's `I = 2^n`). -/
theorem card_inputs (n : ℕ) : Fintype.card (Inputs n) = 2 ^ n := by
  rw [Fintype.card_fun, Fintype.card_bool, Fintype.card_fin]

/-- **`ocount`, general form** (fhe.md:8): the number of functions from `n` input bits to
    `m` output bits is `O(n,m) = (2^(2^n))^m = 2^(m*2^n)`. Discharged by
    `Fintype.card_fun` (`card (α → β) = card β ^ card α`) plus `pow_mul`. -/
theorem ocount (n m : ℕ) :
    Fintype.card (Inputs n → Outputs m) = 2 ^ (m * 2 ^ n) := by
  rw [Fintype.card_fun, card_inputs, card_inputs, ← pow_mul]

/-- fhe.md:19: `O(0,1) = 2^(2^0) = 2`. -/
example : Fintype.card (Inputs 0 → Outputs 1) = 2 := by rw [ocount]; decide

/-- fhe.md:23: `O(1,1) = 2^(2^1) = 4`. -/
example : Fintype.card (Inputs 1 → Outputs 1) = 4 := by rw [ocount]; decide

/-- fhe.md:41: `2^(2^2) = 16` possible outputs for two input bits (m = 1). -/
example : Fintype.card (Inputs 2 → Outputs 1) = 16 := by rw [ocount]; decide

/-- fhe.md:74: `2^(2*2^2) = 256` functions for bits (A,B), i.e. n = m = 2. -/
example : Fintype.card (Inputs 2 → Outputs 2) = 256 := by rw [ocount]; decide

/-! ## `bij24` (fhe.md:10 general, fhe.md:74 instance) -/

/-- **`bij24`, general form** (fhe.md:10): there are `P = (2^n)!` bijective functions on
    `n` bits. Discharged by `Fintype.card_perm` (`card (Perm α) = (card α)!`). -/
theorem bij_count (n : ℕ) :
    Fintype.card (Equiv.Perm (Inputs n)) = (2 ^ n)! := by
  rw [Fintype.card_perm, card_inputs]

/-- **`bij24`, the fhe.md:74 instance**: `(2^2)! = 24` bijective functions on 2 bits. -/
theorem bij24 : Fintype.card (Equiv.Perm (Inputs 2)) = 24 := by
  rw [bij_count]; decide

/-- The same count over the abstract row-index type `Fin 4 ≃ Inputs 2`:
    `|S_4| = 4! = 24`. -/
theorem perm_fin4 : Fintype.card (Equiv.Perm (Fin 4)) = 24 := by
  rw [Fintype.card_perm, Fintype.card_fin]; decide

/-! ## `semidestr` count (fhe.md:65, fhe.md:67) -/

/-- A single-output function on the truth-table domain `α`, together with the number of
    rows it maps to `true` (fhe.md:65's column SUM). -/
def trueCount {α : Type*} [Fintype α] (f : α → Bool) : ℕ :=
  (Finset.univ.filter fun x => f x = true).card

/-- Weight-`k` Boolean functions on `α` correspond exactly to `k`-element subsets of `α`
    (the subset of rows mapped to `true`). -/
def weightEquivFinsetLen {α : Type*} [Fintype α] [DecidableEq α] (k : ℕ) :
    {f : α → Bool // trueCount f = k} ≃ {s : Finset α // s.card = k} where
  toFun f := ⟨Finset.univ.filter fun x => f.1 x = true, f.2⟩
  invFun s := ⟨fun x => decide (x ∈ s.1), by
    simpa [trueCount, Finset.filter_univ_mem] using s.2⟩
  left_inv f := Subtype.ext (funext fun x => by simp)
  right_inv s := Subtype.ext (by ext x; simp)

/-- **Weight-count, general form** (fhe.md:65: "For each sum `s` of truth-outputs per
    function there are `binom(4,s)` functions"): the number of Boolean functions on a
    finite domain `α` taking the value `true` exactly `k` times is `binom(|α|, k)`.
    Discharged by the equiv above plus `Fintype.card_finset_len`. -/
theorem weight_count (α : Type*) [Fintype α] [DecidableEq α] (k : ℕ) :
    Fintype.card {f : α → Bool // trueCount f = k} = (Fintype.card α).choose k :=
  (Fintype.card_congr (weightEquivFinsetLen k)).trans (Fintype.card_finset_len k)

/-- **`semidestr` count, general form** (fhe.md:67): there are `binom(2^n, 2^(n-1))`
    balanced single-output functions on `n` input bits. -/
theorem semidestr_count (n : ℕ) :
    Fintype.card {f : Inputs n → Bool // trueCount f = 2 ^ (n - 1)} =
      (2 ^ n).choose (2 ^ (n - 1)) := by
  rw [weight_count, card_inputs]

/-- **`semidestr` count, the fhe.md:67 instance**: `binom(2^2, 2^1) = binom(4,2) = 6`
    balanced functions at `n = 2` (A, B, XOR and their inverses, per the fhe.md:50
    table's bold rows). -/
theorem semidestr6 :
    Fintype.card {f : Inputs 2 → Bool // trueCount f = 2} = 6 := by
  rw [weight_count, card_inputs]; decide

/-- fhe.md:65's full weight profile at `n = 2`: `binom(4,s) = 1,4,6,4,1` for
    `s = 0..4`. -/
example : ((List.range 5).map ((4).choose ·)) = [1, 4, 6, 4, 1] := by decide

/-! ## `semidestr` identification (fhe.md:65) -- DEFINITION, NOT A THEOREM

  fhe.md:65 says a function is "semi-destructive" iff it "can be used as output bit of a
  bijective function", i.e. some second output bit makes the pair injective, and
  identifies these with the balanced functions. `SemiDestructive` below is ONE candidate
  formalization of the informal notion. THIS IS A DEFINITION, NOT A THEOREM: adopting it
  as the meaning of "semi-destructive" is the owner's modelling call, and no Lean proof
  of `balanced_iff_semiDestructive` would VERIFY the identification -- it would only be
  faithful to whatever this file stipulated. Deliberately left as a stated Prop (a `def`,
  so no `sorry` and no proof obligation). See the essay, section 3. -/

/-- CANDIDATE formalization of fhe.md:65's "can be used as output bit of a bijective
    function" at `m = 2`: some companion bit `g` makes `x ↦ (f x, g x)` injective
    (equivalently bijective, the domain and codomain both having 4 elements). -/
def SemiDestructive {α : Type*} (f : α → Bool) : Prop :=
  ∃ g : α → Bool, Function.Injective fun x => (f x, g x)

/-- Balanced: `true` on exactly half the truth-table rows (fhe.md:65). -/
def Balanced {α : Type*} [Fintype α] (f : α → Bool) : Prop :=
  2 * trueCount f = Fintype.card α

/-- The fhe.md:65 identification at `n = 2`, STATED, NOT PROVED. Whether
    `SemiDestructive` is what the owner means by "semi-destructive" is his call; a proof
    of this Prop (it is decidable, and a brute-force check outside Lean confirms both
    sides pick out the same 6 of the 16 functions) would establish only
    balanced <-> THIS definition, never balanced <-> the informal notion. -/
def balanced_iff_semiDestructive : Prop :=
  ∀ f : Inputs 2 → Bool, Balanced f ↔ SemiDestructive f

end Toesnail.FHECounting
