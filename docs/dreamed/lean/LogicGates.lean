/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-bloch-gates.md`.

  Source of the seed (owner-authored, chat export "Falsifiability and Logical
  Boundaries", 2025-08-16, verbatim):

      "Use the quantum gates to infer a clearer meaning of the Bloch equator. Start
       with the simple NOT, what should happen to the phase angles and what could that
       logically state? Then continue with CNOT, what happens to the controlledly
       inverted qubit in dependence of the controlling qubit and how can that be
       interpreted? Finally do the same for the TOFFOLI gate"

  and (owner-authored, chat export "Bloch Sphere and Qubits", 2025-08-09, verbatim):

      "Why is the third qubit needed for AND?"

  and (owner-authored, chat export "Invertible Functions Bit Mapping Problem",
  2025-09-09, verbatim):

      "But only (2^2)!=12 of them are actually invertible - I wonder if all of them can
       be expressed via the TOFFOLI gate?"

  ------------------------------------------------------------------------------------
  Reading the Lean symbols back into the essay's language
  ------------------------------------------------------------------------------------

    `Bool`                a settled classical truth value: a POLE of the Bloch sphere.
                          Nothing in this file has an equator; see the scope block.
    `cnot`, `toffoli`     the two gates of the seed, as functions on tuples of poles.
                          These are the gates' action restricted to the computational
                          basis, which is exactly the classical/reversible-logic half
                          of the essay.
    `Function.Injective`  "no information is destroyed": distinct inputs stay distinct.
                          This is the counting half of the owner's AND question.
    `Affine2`             a two-input Boolean function of the form
                          `c XOR (a AND x) XOR (b AND y)`, i.e. a GF(2)-affine
                          function. CNOT circuits produce exactly these on each wire,
                          which is why CNOT alone cannot compute AND.
    `TranslationInvariant`
                          an order on a group that survives being rotated:
                          `a <= b` implies `a + c <= b + c` for every `c`. On the Bloch
                          EQUATOR the group is the rotation group of the circle and `c`
                          is a phase gate `R_z(theta)`, so this predicate is exactly
                          "the proposed truth-ordering of equatorial states does not
                          depend on where you put the zero of phase".
    `no_torsion_of_invariant`
                          the essay's central NEGATIVE finding: such an order forbids
                          every nonzero element of finite order. Every rotation by a
                          rational multiple of 2*pi is such an element, so no
                          phase-covariant order on the equator exists. A circle is not
                          a lattice of truth values.

  ------------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is)
  ------------------------------------------------------------------------------------
    - There is NO Hilbert space, NO Bloch sphere, NO density matrix and NO unitary
      anywhere below. The essay's reduced-density-matrix computation (its section 3.2,
      the contraction `b' = (b_x, a_z*b_y, a_z*b_z)`) is done BY HAND in the essay and
      checked numerically there; it is NOT discharged here and carries no `\veq` badge.
    - `cnot` and `toffoli` here are the classical restrictions to basis states. The
      phase-kickback claims, the `H`-conjugation identity
      `(H (x) H) CNOT (H (x) H) = CNOT with control and target exchanged`, and the
      `Toffoli = CCZ in the |-> basis` identity are all about the FULL unitary and are
      NOT proved here.
    - `no_ancilla_free_and` is a counting theorem about `Bool`, not a thermodynamic one.
      Landauer's `k_B T ln 2` appears in the essay as physics and is not formalised.
    - `no_torsion_of_invariant` is about an abstract ordered abelian group. That the
      circle group `U(1)` has nonzero torsion elements (the `n`-th roots of unity) is
      standard and is asserted in the essay's prose, not proved here; the Lean statement
      is the general lemma into which that fact is fed.
    - Nothing here says what the equator MEANS. Every interpretive claim in the essay is
      UNRATIFIED AI speculation for the owner to rule on.
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Logic.Function.Basic
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Prod
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Order.Group.Defs

namespace Toesnail.LogicGates

/-! ## 1. The gates, classically

`cnot` and `toffoli` are the seed's gates restricted to the computational basis. Both are
their own inverse, hence bijections: reversible logic loses nothing. -/

/-- CNOT: `(a, b) -> (a, a XOR b)`. The control `a` is untouched; the target receives the
    exclusive-or. -/
def cnot (p : Bool × Bool) : Bool × Bool := (p.1, xor p.1 p.2)

/-- TOFFOLI: `(a, b, c) -> (a, b, c XOR (a AND b))`. -/
def toffoli (p : Bool × Bool × Bool) : Bool × Bool × Bool :=
  (p.1, p.2.1, xor p.2.2 (p.1 && p.2.1))

theorem cnot_involutive : Function.Involutive cnot := by
  intro p; revert p; decide

theorem toffoli_involutive : Function.Involutive toffoli := by
  intro p; revert p; decide

theorem cnot_bijective : Function.Bijective cnot := cnot_involutive.bijective

theorem toffoli_bijective : Function.Bijective toffoli := toffoli_involutive.bijective

/-- With the ancilla initialised to `false`, TOFFOLI's third output IS the conjunction.
    This is the sense in which the three-wire gate "computes AND". -/
theorem toffoli_computes_and (a b : Bool) :
    (toffoli (a, b, false)).2.2 = (a && b) := by
  revert a b; decide

/-- TOFFOLI leaves its two controls alone, so the inputs are still there afterwards.
    That is the whole trick: nothing was erased, the answer was merely *added*. -/
theorem toffoli_preserves_inputs (p : Bool × Bool × Bool) :
    (toffoli p).1 = p.1 ∧ (toffoli p).2.1 = p.2.1 := ⟨rfl, rfl⟩

/-! ## 2. Why AND needs the third wire: the counting argument

The owner's question, from the 2025-08-09 export: *"Why is the third qubit needed for
AND?"* The answer below is pure cardinality and uses no physics at all. -/

/-- **Two bits in, one bit out is never injective.** Stated for an arbitrary `f`, so it
    is not a fact about AND: no two-input single-output Boolean function whatsoever can
    be reversible. `Fintype.card (Bool × Bool) = 4 > 2 = Fintype.card Bool`. -/
theorem no_injective_two_to_one (f : Bool × Bool → Bool) : ¬ Function.Injective f := by
  intro h
  have hcard := Fintype.card_le_of_injective f h
  simp at hcard

/-- The concrete witness for AND: `(false, true)` and `(true, false)` are distinct inputs
    with the same conjunction. -/
theorem and_not_injective : ¬ Function.Injective (fun p : Bool × Bool => p.1 && p.2) :=
  no_injective_two_to_one _

/-- **Widening the output to two bits does not rescue it either.** There is no injective
    `g : Bool × Bool → Bool × Bool` whose SECOND component is the conjunction.

    Counting: three of the four inputs have conjunction `false`, so `g` would have to
    send three distinct inputs into the two-element set `{(x, false)}`. A genuinely
    ancilla-free reversible AND is therefore impossible even with the inputs' own width
    to spend, and the third wire of TOFFOLI is not an implementation convenience. -/
theorem no_ancilla_free_and :
    ¬ ∃ g : Bool × Bool → Bool × Bool,
        Function.Injective g ∧ ∀ p, (g p).2 = (p.1 && p.2) := by
  rintro ⟨g, hinj, hg⟩
  have h1 : (g (false, false)).2 = false := hg (false, false)
  have h2 : (g (false, true)).2 = false := hg (false, true)
  have h3 : (g (true, false)).2 = false := hg (true, false)
  -- three points of a 4-element type land in a 2-element fibre; two must collide
  have pair : ∀ p q : Bool × Bool, p.2 = false → q.2 = false → p.1 = q.1 → p = q := by
    rintro ⟨p1, p2⟩ ⟨q1, q2⟩ hp hq h
    simp_all
  rcases Bool.eq_false_or_eq_true (g (false, false)).1 with e1 | e1 <;>
    rcases Bool.eq_false_or_eq_true (g (false, true)).1 with e2 | e2 <;>
      rcases Bool.eq_false_or_eq_true (g (true, false)).1 with e3 | e3
  · exact absurd (hinj (pair _ _ h1 h2 (e1.trans e2.symm))) (by decide)
  · exact absurd (hinj (pair _ _ h1 h2 (e1.trans e2.symm))) (by decide)
  · exact absurd (hinj (pair _ _ h1 h3 (e1.trans e3.symm))) (by decide)
  · exact absurd (hinj (pair _ _ h2 h3 (e2.trans e3.symm))) (by decide)
  · exact absurd (hinj (pair _ _ h2 h3 (e2.trans e3.symm))) (by decide)
  · exact absurd (hinj (pair _ _ h1 h3 (e1.trans e3.symm))) (by decide)
  · exact absurd (hinj (pair _ _ h1 h2 (e1.trans e2.symm))) (by decide)
  · exact absurd (hinj (pair _ _ h1 h2 (e1.trans e2.symm))) (by decide)

set_option maxRecDepth 100000 in
/-- The mirrored statement, for completeness: nor can the conjunction appear in the FIRST
    output coordinate of an injective two-bit map. Together with `no_ancilla_free_and`
    this says no reversible two-wire gate emits AND on any wire at all, so three wires is
    a genuine MINIMUM and not merely the convenient choice. -/
theorem no_ancilla_free_and_fst :
    ¬ ∃ g : Bool × Bool → Bool × Bool,
        Function.Injective g ∧ ∀ p, (g p).1 = (p.1 && p.2) := by decide

/-! ## 3. Why CNOT alone cannot do it: linearity over GF(2)

CNOT computes an exclusive-or, and XOR is addition in `GF(2)`. Every wire of a circuit
built from CNOT and NOT therefore carries an AFFINE function of the inputs, and AND is
not affine. This is the algebraic reason the essay gives for CNOT's failure, distinct
from the cardinality reason above. -/

/-- `f` is GF(2)-affine in two variables: `f x y = c XOR (a AND x) XOR (b AND y)`. Over
    `GF(2)`, `AND` by a constant is scalar multiplication and `XOR` is addition, so this
    is exactly "affine map plus constant". -/
def Affine2 (f : Bool → Bool → Bool) : Prop :=
  ∃ c a b : Bool, ∀ x y, f x y = xor c (xor (a && x) (b && y))

instance : DecidablePred Affine2 := fun _ => inferInstanceAs (Decidable (∃ _ _ _, _))

/-- XOR is affine: take `c = false`, `a = b = true`. This is CNOT's target wire. -/
theorem xor_affine : Affine2 (fun x y => xor x y) := by
  refine ⟨false, true, true, ?_⟩; decide

/-- Projection is affine, so a CNOT's control wire is affine too. -/
theorem fst_affine : Affine2 (fun x _ => x) := by
  refine ⟨false, true, false, ?_⟩; decide

/-- Negation is affine: this is why NOT gates buy no extra power. -/
theorem not_affine : Affine2 (fun x _ => !x) := by
  refine ⟨true, true, false, ?_⟩; decide

/-- **AND is not affine over GF(2).** Hence no CNOT/NOT circuit computes it on any wire,
    however many wires and ancillas it is given, because affineness is preserved by
    composition. (The closure statement is standard linear algebra and is asserted in the
    essay's prose; only the non-affineness of AND is discharged here.) -/
theorem and_not_affine : ¬ Affine2 (fun x y => x && y) := by decide

/-- Affine functions are closed under XOR, the one closure fact used in the essay's
    inductive sketch. -/
theorem affine2_xor {f g : Bool → Bool → Bool} (hf : Affine2 f) (hg : Affine2 g) :
    Affine2 (fun x y => xor (f x y) (g x y)) := by
  obtain ⟨c₁, a₁, b₁, h₁⟩ := hf
  obtain ⟨c₂, a₂, b₂, h₂⟩ := hg
  refine ⟨xor c₁ c₂, xor a₁ a₂, xor b₁ b₂, ?_⟩
  intro x y
  simp only [h₁, h₂]
  clear h₁ h₂
  revert c₁ a₁ b₁ c₂ a₂ b₂ x y
  decide

/-! ## 4. The equator is a circle, and a circle carries no truth ordering

The essay's central negative finding. Kleene's and Priest's third value sits in a finite
LATTICE: there is an order, and the logical connectives are its meet and join. The Bloch
equator's parameter is a CIRCLE, acted on transitively by the phase gates `R_z(theta)`.
Ask for a truth-ordering of equatorial states that does not depend on an arbitrary choice
of where phase zero sits, and you are asking for a translation-invariant linear order on
the rotation group. There is none, and the obstruction is torsion. -/

section OrderedCircle

variable {G : Type*} [AddCommGroup G] [LinearOrder G]

/-- The order survives rotation: comparing two states and then rotating both agrees with
    rotating both and then comparing. -/
def TranslationInvariant (G : Type*) [AddCommGroup G] [LinearOrder G] : Prop :=
  ∀ a b c : G, a ≤ b → a + c ≤ b + c

theorem lt_add_of_invariant (h : TranslationInvariant G) {a b : G} (hab : a < b) (c : G) :
    a + c < b + c := by
  rcases lt_or_eq_of_le (h a b c hab.le) with h' | h'
  · exact h'
  · exact absurd (add_right_cancel h') hab.ne

/-- A positive element stays positive under repeated addition. -/
theorem pos_nsmul_succ (h : TranslationInvariant G) {g : G} (hg : 0 < g) :
    ∀ n : ℕ, 0 < (n + 1) • g := by
  intro n
  induction n with
  | zero => rw [one_nsmul]; exact hg
  | succ k ih =>
      have h1 : (0 : G) + (k + 1) • g < g + (k + 1) • g := lt_add_of_invariant h hg _
      rw [zero_add] at h1
      have hs : (k + 1 + 1) • g = (k + 1) • g + g := succ_nsmul g (k + 1)
      calc (0 : G) < (k + 1) • g := ih
        _ < g + (k + 1) • g := h1
        _ = (k + 1) • g + g := add_comm _ _
        _ = (k + 1 + 1) • g := hs.symm

/-- **A rotation-invariant linear order forbids torsion** (handle `circle-order`).

    If the order on `G` survives every translation, then no nonzero `g` can satisfy
    `n • g = 0` for `n > 0`. Fed the circle group and `g` = rotation by `2*pi/n`, this
    says: no linear order on the Bloch equator is covariant under the phase gates. The
    equator's parameter is therefore not a truth VALUE in the sense Kleene, Lukasiewicz,
    Priest and Belnap all use, since each of those is an order. -/
theorem no_torsion_of_invariant (h : TranslationInvariant G) {g : G} (hg : g ≠ 0)
    {n : ℕ} (hn : 0 < n) (htor : n • g = 0) : False := by
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn.ne'
  simp only [Nat.succ_eq_add_one] at htor
  rcases lt_trichotomy 0 g with hp | he | hm
  · have hpos := pos_nsmul_succ h hp m
    rw [htor] at hpos
    exact lt_irrefl 0 hpos
  · exact hg he.symm
  · have hp : 0 < -g := by
      have hstep := lt_add_of_invariant h hm (-g)
      simpa using hstep
    have hpos := pos_nsmul_succ h hp m
    have hz : (m + 1) • (-g) = 0 := by
      have hsum : (m + 1) • (-g) + (m + 1) • g = 0 := by
        rw [← nsmul_add, neg_add_cancel, nsmul_zero]
      rw [htor, add_zero] at hsum
      exact hsum
    rw [hz] at hpos
    exact lt_irrefl 0 hpos

/-- Contrapositive, in the form the essay quotes: an abelian group carrying a nonzero
    element of finite order admits NO translation-invariant linear order at all. -/
theorem no_invariant_order_of_torsion {g : G} (hg : g ≠ 0) {n : ℕ} (hn : 0 < n)
    (htor : n • g = 0) : ¬ TranslationInvariant G :=
  fun h => no_torsion_of_invariant h hg hn htor

end OrderedCircle

/-! ## 5. The owner's own question, answered at two bits

From the 2025-09-09 export: *"But only (2^2)!=12 of them are actually invertible - I
wonder if all of them can be expressed via the TOFFOLI gate?"* At two bits the answer is
yes, and more sharply than asked: every bijection of two bits is already GF(2)-affine, so
CNOT and NOT alone suffice and TOFFOLI is not needed. It is exactly at three bits that
this collapses. -/

set_option maxRecDepth 100000 in
/-- **Every bijection of two bits is affine in each output coordinate.** Since CNOT and
    NOT generate all affine bijections, this says the reversible two-bit gates are
    exhausted by CNOT and NOT: `AGL(2, GF(2))` is all of `S_4`. Contrast
    `and_not_affine`, which shows the corresponding statement fails from three bits on --
    that is the gap TOFFOLI fills. -/
theorem bijective_two_bit_affine (g : Bool × Bool → Bool × Bool) (hg : Function.Bijective g) :
    Affine2 (fun x y => (g (x, y)).1) ∧ Affine2 (fun x y => (g (x, y)).2) := by
  revert g; decide

end Toesnail.LogicGates
