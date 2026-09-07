/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean companion for the dreamed essay `docs/dreamed/logic-counterfactual-boundary.md`.

  ------------------------------------------------------------------------------------
  WHAT THE ESSAY IS ABOUT, IN ONE PARAGRAPH
  ------------------------------------------------------------------------------------

  The owner's layered-core idea (his own words, 2025-08-08) wants a COMPLETE lower layer
  under an INCOMPLETE upper one. A sibling essay, `logic-layered-core.md`, redrew the
  dividing line at "interprets arithmetic" versus "does not". This essay walks along that
  line and asks how thin it is. The real mathematics quoted in the essay:

    * Presburger arithmetic  <N, +>   is complete and decidable   (Presburger 1929).
    * Skolem arithmetic      <N, *>   is decidable                (Mostowski 1952).
    * Both together          <N, +, *> is incomplete              (Goedel 1931).

  So NEITHER operation alone is fatal and the PAIR is. This file discharges the part of
  that story that is a theorem rather than a quotation: WHY the pair is needed, at the
  level of what a language can define.

  ------------------------------------------------------------------------------------
  SYMBOL MAP: Lean name  ->  essay section
  ------------------------------------------------------------------------------------

    AddTerm, AddTerm.eval          the additive term language of section 4.1. A term
                                   built from variables, 0, +, and unary minus, over the
                                   integers. This is the "Layer 0 with addition only"
                                   of the owner's architecture, taken literally.

    AddTerm.eval_neg               EQUIVARIANCE. Every additive term commutes with
                                   x |-> -x. Section 4.1. This is the machine-checked
                                   half of the classical automorphism argument.

    mul_not_addTerm_definable      Section 4.1, the headline of the Lean file.
                                   Multiplication is NOT an additive term. Proof: x |-> -x
                                   is an automorphism of (Z, +) and is not one of
                                   (Z, +, *), because (-1)*(-1) = +1 while -(1*1) = -1.

    affine_not_injective           Section 4.2. No affine map N x N -> N is injective, so
                                   an additive language has NO PAIRING FUNCTION. Since
                                   Goedel numbering of syntax is exactly pairing, an
                                   additive core cannot encode its own sentences.

    pair_injective                 Section 4.2, the contrast. Cantor's pairing function
                                   IS injective. Its Mathlib definition is quadratic: it
                                   needs multiplication. Pairing is where the second
                                   operation is spent.

    mul_from_sq                    Section 5.3. Squaring plus addition RECOVERS
                                   multiplication. Any "intermediate" operation strong
                                   enough to square is already the whole of arithmetic.

    sq_step, next_square_forces    Section 5.3. Even the bare SET of squares collapses:
                                   consecutive squares differ by 2n+1, and that gap pins
                                   n uniquely, so <N, +, {squares}> defines the graph of
                                   squaring, hence multiplication.

    const_mul_is_iterated_add      Section 5.2. What stays SAFE: multiplication by a
                                   fixed numeral is iterated addition and lives inside
                                   Presburger arithmetic. It is variable-times-variable
                                   that crosses the line, not the multiplication sign.

  ------------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE -- do not read this file as more than it is
  ------------------------------------------------------------------------------------

    * NOT Goedel's first incompleteness theorem. Nothing here formalises provability,
      consistency, or effective axiomatisation. The essay quotes Goedel 1931; this file
      proves none of it.

    * NOT the decidability of Presburger arithmetic, and NOT Tarski's theorem on real
      closed fields, and NOT Tennenbaum's theorem. All three are QUOTED in the essay from
      the literature and formalised nowhere in this repository.

    * NOT full first-order definability. `mul_not_addTerm_definable` rules out
      multiplication as a TERM of the additive language. The step from terms to
      quantified FORMULAS is the standard model-theoretic fact that a first-order
      definable relation is preserved by every automorphism of the structure. That step
      is quoted in the essay (section 4.1) and is NOT proved here. The distinction is
      stated in the essay rather than blurred: this file proves the weaker, purely
      algebraic statement.

    * NOT a claim about physics. Section 7 of the essay draws an analogy between this
      boundary and phase transitions, and cites Cubitt, Perez-Garcia and Wolf (Nature
      528, 2015) as a real physical undecidability result. Neither the analogy nor that
      paper is formalised here.

    * EVERY INVENTED OBJECT IN THE ESSAY IS ABSENT FROM THIS FILE. The essay's
      counterfactual worlds (Flatland-of-Addition, the Oracle World, and the invented
      intermediate operation "the ladder operation") are labelled [INVENTED] there and
      appear nowhere below. Nothing in this file is a theorem about an invented object.

  ZERO `sorry`.
-/

import Mathlib.Data.Nat.Basic
import Mathlib.Data.Nat.Pairing
import Mathlib.Algebra.BigOperators.Group.List.Basic
import Mathlib.Logic.Function.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace Toesnail.LogicBoundary

/-! ## 1. The additive term language, and what it cannot say

A term language with variables, zero, addition and unary minus, interpreted over `ℤ`.
This is "Layer 0 with addition only", taken literally as a term algebra. -/

/-- Terms of the language `{0, +, -}` in `n` variables. -/
inductive AddTerm (n : ℕ) : Type
  | var  : Fin n → AddTerm n
  | zero : AddTerm n
  | add  : AddTerm n → AddTerm n → AddTerm n
  | neg  : AddTerm n → AddTerm n
  deriving Repr

/-- Evaluation of an additive term at an assignment of integers to its variables. -/
def AddTerm.eval {n : ℕ} : AddTerm n → (Fin n → ℤ) → ℤ
  | .var i,    v => v i
  | .zero,     _ => 0
  | .add s t,  v => s.eval v + t.eval v
  | .neg t,    v => -(t.eval v)

/-- **Equivariance.** Every additive term commutes with the map `x ↦ -x`.

    This is the machine-checked half of the classical automorphism argument: `x ↦ -x`
    is an automorphism of the group `(ℤ, +)`, so no term built out of `+`, `0` and `-`
    can tell the two sides apart. -/
theorem AddTerm.eval_neg {n : ℕ} (t : AddTerm n) (v : Fin n → ℤ) :
    t.eval (fun i => -(v i)) = -(t.eval v) := by
  induction t with
  | var i => simp [AddTerm.eval]
  | zero => simp [AddTerm.eval]
  | add s t hs ht => simp only [AddTerm.eval, hs, ht]; ring
  | neg t ht => simp only [AddTerm.eval, ht]

/-- **Multiplication is not an additive term.**

    The whole of the argument is one asymmetry: `-(1 * 1) = -1` but `(-1) * (-1) = +1`.
    Negation is an automorphism of `(ℤ, +)` and is not an automorphism of `(ℤ, +, *)`,
    so multiplication cannot be assembled out of the additive operations.

    Read back into the owner's architecture: a Layer 0 whose only arithmetic is additive
    cannot *define* multiplication, which is exactly why it escapes Goedel. The escape
    is bought by weakness, not by cleverness. -/
theorem mul_not_addTerm_definable :
    ¬ ∃ t : AddTerm 2, ∀ v : Fin 2 → ℤ, t.eval v = v 0 * v 1 := by
  rintro ⟨t, ht⟩
  have hp : t.eval (fun _ => (1 : ℤ)) = 1 := by
    have := ht (fun _ => (1 : ℤ)); simpa using this
  have hm : t.eval (fun _ => (-1 : ℤ)) = 1 := by
    have := ht (fun _ => (-1 : ℤ)); simpa using this
  have hequiv : t.eval (fun _ => (-1 : ℤ)) = -(t.eval (fun _ => (1 : ℤ))) := by
    have h := AddTerm.eval_neg t (fun _ => (1 : ℤ))
    simpa using h
  rw [hp, hm] at hequiv
  norm_num at hequiv

/-! ## 2. Pairing: where the second operation is spent

Goedel numbering encodes a finite sequence of symbols as one number. The primitive it
needs is a *pairing function*: an injection `ℕ × ℕ → ℕ`. The next two results say that
an additive language does not have one, and that the standard one is quadratic. -/

/-- **No affine map `ℕ × ℕ → ℕ` is injective.**

    The witness is explicit and needs no case analysis on size: the two distinct points
    `(b, 0)` and `(0, a)` are both sent to `a * b + c`. The degenerate case `a = b = 0`
    is handled separately, since there the two points coincide.

    Consequence, stated in the essay rather than here: every Presburger-definable
    function is piecewise affine on semilinear pieces, and each piece is a copy of this
    obstruction, so Presburger arithmetic has no pairing function at all. That step is
    QUOTED in the essay, not proved in this file. -/
theorem affine_not_injective (a b c : ℕ) :
    ¬ Function.Injective (fun p : ℕ × ℕ => a * p.1 + b * p.2 + c) := by
  intro h
  by_cases hab : a = 0 ∧ b = 0
  · obtain ⟨ha, hb⟩ := hab
    have hcol : ((0 : ℕ), (0 : ℕ)) = ((1 : ℕ), (0 : ℕ)) := by
      apply h
      simp [ha, hb]
    rw [Prod.mk.injEq] at hcol
    exact absurd hcol.1 (by norm_num)
  · have hcol : ((b : ℕ), (0 : ℕ)) = ((0 : ℕ), (a : ℕ)) := by
      apply h
      show a * b + b * 0 + c = a * 0 + b * a + c
      ring
    rw [Prod.mk.injEq] at hcol
    exact hab ⟨hcol.2.symm, hcol.1⟩

/-- **Cantor's pairing function is injective**, the contrast to `affine_not_injective`.

    Mathlib's `Nat.pair` is defined by a quadratic case split, and that is the point: the
    cheapest known encoding of syntax already spends multiplication. Pairing is not a
    convenience of Goedel's proof, it is where the second operation goes. -/
theorem pair_injective : Function.Injective (fun p : ℕ × ℕ => Nat.pair p.1 p.2) := by
  intro p q h
  have hpq := Nat.pair_eq_pair.mp h
  exact Prod.ext hpq.1 hpq.2

/-! ## 3. The other side: how little it takes to fall over the line

Section 5 of the essay asks whether anything sits strictly between addition and
multiplication. These three results are the negative half of the answer: several
apparently modest additions to the additive language are already the whole of
arithmetic. -/

/-- **Squaring plus addition recovers multiplication.**

    `2xy = (x+y)² - x² - y²`, stated additively so that it is a statement about `ℕ`.
    Any candidate "intermediate" operation that can square is therefore not intermediate
    at all: with addition it defines the graph of multiplication, so Robinson's Q is
    interpretable and Goedel applies. -/
theorem mul_from_sq (x y : ℕ) :
    2 * (x * y) + (x * x + y * y) = (x + y) * (x + y) := by ring

/-- Consecutive squares differ by `2n + 1`. -/
theorem sq_step (n : ℕ) : (n + 1) * (n + 1) = n * n + (2 * n + 1) := by ring

/-- **Even the bare SET of squares collapses the additive language.**

    Suppose `m * m` is the *next* square after `k * k` (that is what `hmin` says: `m` is
    below every `j` exceeding `k`), and suppose their gap is `2n + 1`. Then `n = k`.

    So the formula "`y` is a square, `y + 2n + 1` is the next square after `y`" defines
    `y = n * n` using only addition and a unary predicate for the squares. Together with
    `mul_from_sq` this gives multiplication. A decidable additive core therefore cannot
    be handed a squares predicate as a harmless extra: it is the whole of arithmetic in
    disguise. -/
theorem next_square_forces {k n m : ℕ}
    (hm : m * m = k * k + (2 * n + 1)) (hmin : ∀ j, k < j → m ≤ j) : n = k := by
  have hk : k < m := by
    rcases Nat.lt_or_ge k m with h | h
    · exact h
    · exfalso
      have hle : m * m ≤ k * k := Nat.mul_le_mul h h
      linarith
  have hub : m ≤ k + 1 := hmin (k + 1) (by omega)
  have hmk : m = k + 1 := by omega
  subst hmk
  have hexp : k * k + (2 * k + 1) = k * k + (2 * n + 1) := by
    rw [← hm]; ring
  have := Nat.add_left_cancel hexp
  omega

/-- **What stays safe.** Multiplication by a fixed numeral is iterated addition, so it
    lives inside the additive language: `k * x` is the sum of `k` copies of `x`.

    This is the precise sense in which the boundary is not "the multiplication sign".
    Presburger arithmetic is perfectly happy with `3 * x`. What it cannot have is
    `x * y` with both factors quantified. -/
theorem const_mul_is_iterated_add (k x : ℕ) :
    k * x = (List.replicate k x).sum := by
  simp [List.sum_replicate]

/-! ## 4. The one-line summary of this file

`mul_not_addTerm_definable` says addition alone is too weak.
`affine_not_injective` says addition alone cannot even pair, hence cannot encode syntax.
`mul_from_sq` and `next_square_forces` say the far side has no shallow end.

Together: the line is thin in the sense that very little must be added to the additive
side before it is crossed, and it is sharp in the sense that nothing lands ON it. That
is the essay's central claim, and these are the parts of it that are proved rather than
quoted. -/

end Toesnail.LogicBoundary
