/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-complementarity.md`.

  ---------------------------------------------------------------------------------------
  WHAT THIS FILE IS ABOUT

  The "Bloch Truth" cluster of dreamed essays retired the owner's Bloch ball for a
  simplex, and its adjudicator (`logic-models-vs-epistemic.md`) closed with the single
  input that would reverse the recommendation:

      "name a pair of questions about a sentence that cannot be answered simultaneously."

  The parent essay hunts for such a pair, invents nine candidates, and fails to find one.
  This file discharges the reason the hunt fails, and it discharges the ONE escape route
  the essay takes seriously, namely that the non-commutativity might live in the ACT of
  establishing a proposition rather than in the propositions themselves.

  ---------------------------------------------------------------------------------------
  SYMBOL MAP: Lean name  ->  essay meaning

    `Omega`            the sample space. In the essay's reading, the set of complete
                       consistent extensions of the theory (equivalently the points of
                       the Stone space of the Lindenbaum-Tarski algebra), or the set of
                       terminal verdicts of a bounded prover. Which reading is taken does
                       not matter to anything below; that indifference is the point.
    `State Omega`      a state of a sentence: non-negative weights summing to one. This
                       is the simplex over `Omega`, the object four sibling essays
                       converged on.
    `Obs Omega`        a QUESTION: any two-valued property of the underlying point. In
                       the essay: "is it provable in T?", "does the Rosser order put the
                       proof of P first?", "does the budgeted prover answer yes at B?".
                       Section 3's nine candidates are ALL of this shape, and that is
                       exactly why they all fail.
    `marg S X b`       the probability the state `S` assigns to question `X` answering
                       `b`. Essay section 1, condition CT2.
    `joint S X Y b c`  the candidate joint distribution over both answers at once.
    `no_logical_complementarity`
                       the essay's central negative, section 2: any two questions about
                       the same sentence admit a joint distribution, so no pair of
                       questions about a sentence is complementary. This is the machine
                       -checked half of "why nobody can name one".
    `no_uncertainty_relation_binary`
                       essay condition CT4, refuted: for ANY pair of questions there is a
                       state on which both are answered with certainty, so no
                       state-independent uncertainty relation can exist.
    `act a b p`        the escape route, essay section 5. A prover's ACT: a stochastic
                       map on the state of a sentence. The essay's invented "Adoption
                       Algebra" and "Search-Order pair" both live here.
    `chan_noncommute`  the acts really do fail to commute. The essay's invented
                       constructions are not wrong about that.
    `escape_route_closed`
                       and it buys nothing: the same non-commuting acts preserve the
                       simplex, so order-dependence of UPDATE is not order-dependence of
                       EVALUATION. Essay section 5.4. This is the file's sharpest result
                       and the one that kills the essay's own best invention.

  ---------------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is)

  - **The essay's constructions are INVENTED and are not claimed to model anything.**
    "The Adoption Algebra", "the Search-Order pair", "the Rosser azimuth", "the Feferman
    pair", "the omega-pair", "the budget filtration", "the Girth-Existence pair", "the
    Twin-Rosser pair" and the complementarity test CT1-CT5 are the essay author's
    coinages, invented for that essay in September 2026. None of them is standard
    terminology, none is drawn from the literature, and NOTHING in this file asserts that
    any of them describes provability, proof search, or any real prover. What this file
    proves is a set of facts about finite probability spaces and stochastic maps. The
    essay's step from those facts to a claim about logic is the essay's ARGUMENT, made in
    prose, and it is speculation.

  - This is NOT a formalisation of provability, of Goedel's theorems, of the Rosser
    ordering, or of any arithmetic. No provability predicate appears below. The essay's
    reduction of every candidate to "a two-valued function of a point of Omega" is an
    argument in the essay, not a theorem here.

  - This is NOT a proof that the state space of a sentence is a simplex. It is the
    conditional: IF the state is a probability distribution over a set of underlying
    points, THEN no two questions about it are complementary. Whether logic supplies such
    a set is exactly what the cluster is arguing about.

  - This is NOT the general GPT theorem. That two-outcome measurement incompatibility
    characterises the simplex in full generality is Plavala, Phys. Rev. A 94, 042108
    (2016) and Kuramochi, Positivity (2020); the finite classical direction is what is
    checked here, and it is the easy direction. Nothing below re-proves the hard one.

  - `chan_noncommute` is NOT a claim that proof search is a stochastic map. It is a
    witness that non-commutativity of dynamics is available on a simplex, which is what
    the essay needs in order to show that non-commuting acts prove nothing.

  - No `sorry`. Checked with `lake env lean` from `verify/` under `capped.sh`.
-/
import Mathlib.Data.Real.Basic
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic

namespace Toesnail.LogicComplementarity

open Finset

/-! ## 1. States and questions -/

/-- A **state** of a sentence: a probability distribution over a finite set `Omega` of
    underlying points. In the essay's model-theoretic reading `Omega` is a finite stand-in
    for the completions of the theory; in its epistemic reading it is the verdict set.
    Either way this is the SIMPLEX the cluster converged on. -/
structure State (Omega : Type) [Fintype Omega] where
  p : Omega → ℝ
  nonneg : ∀ w, 0 ≤ p w
  total : ∑ w, p w = 1

/-- A **question** about the sentence: a two-valued property of the underlying point.
    Every one of the essay's nine invented candidates has this shape. -/
abbrev Obs (Omega : Type) := Omega → Bool

variable {Omega : Type} [Fintype Omega]

/-- The probability that question `X` is answered `b` in state `S`. -/
def marg (S : State Omega) (X : Obs Omega) (b : Bool) : ℝ :=
  ∑ w, if X w = b then S.p w else 0

/-- The candidate **joint distribution**: the weight of the points on which `X` answers
    `b` and `Y` answers `c` at once. Nothing is assumed about `X` and `Y`; they are
    arbitrary. -/
def joint (S : State Omega) (X Y : Obs Omega) (b c : Bool) : ℝ :=
  ∑ w, if X w = b ∧ Y w = c then S.p w else 0

/-! ## 2. The central negative: propositions admit joints, hence do not complement -/

theorem joint_nonneg (S : State Omega) (X Y : Obs Omega) (b c : Bool) :
    0 ≤ joint S X Y b c := by
  refine Finset.sum_nonneg (fun w _ => ?_)
  by_cases h : X w = b ∧ Y w = c <;> simp [h, S.nonneg w]

/-- The joint cell is the state's weight on the **Boolean meet** of the two events. This
    is the whole reason the essay's hunt is doomed: the meet always exists, because a
    Boolean algebra is closed under conjunction. -/
theorem joint_is_meet (S : State Omega) (X Y : Obs Omega) :
    joint S X Y true true = ∑ w, if (X w && Y w) = true then S.p w else 0 := by
  unfold joint
  refine Finset.sum_congr rfl (fun w _ => ?_)
  cases hx : X w <;> cases hy : Y w <;> simp

/-- Summing the joint over the second answer returns the first question's marginal. -/
theorem joint_marg_left (S : State Omega) (X Y : Obs Omega) (b : Bool) :
    ∑ c, joint S X Y b c = marg S X b := by
  unfold joint marg
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl (fun w _ => ?_)
  cases hx : X w <;> cases hy : Y w <;> cases b <;> simp

/-- Summing the joint over the first answer returns the second question's marginal. -/
theorem joint_marg_right (S : State Omega) (X Y : Obs Omega) (c : Bool) :
    ∑ b, joint S X Y b c = marg S Y c := by
  unfold joint marg
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl (fun w _ => ?_)
  cases hx : X w <;> cases hy : Y w <;> cases c <;> simp

theorem marg_total (S : State Omega) (X : Obs Omega) : ∑ b, marg S X b = 1 := by
  unfold marg
  rw [Finset.sum_comm]
  rw [← S.total]
  refine Finset.sum_congr rfl (fun w _ => ?_)
  cases hx : X w <;> simp

theorem joint_total (S : State Omega) (X Y : Obs Omega) :
    ∑ b, ∑ c, joint S X Y b c = 1 := by
  simp only [joint_marg_left]
  exact marg_total S X

/-- **Order-independence.** Asking `X` then `Y` and asking `Y` then `X` give the same
    joint statistics, transposed. There is no operational content to the order in which
    two questions about a sentence are put. Essay section 2.2. -/
theorem joint_symm (S : State Omega) (X Y : Obs Omega) (b c : Bool) :
    joint S X Y b c = joint S Y X c b := by
  unfold joint
  refine Finset.sum_congr rfl (fun w _ => ?_)
  by_cases h : X w = b <;> by_cases h' : Y w = c <;> simp [h, h']

/-- **The essay's central negative, machine-checked.**

    Any two two-valued questions about a sentence, whatever they are, admit a genuine
    joint distribution reproducing both marginals. No pair of questions about a sentence
    can therefore be complementary, because complementarity IS the non-existence of such
    a joint. The nine candidates of the essay's section 3 all have the shape `Obs Omega`,
    so they are all refuted at once by this one theorem. -/
theorem no_logical_complementarity (S : State Omega) (X Y : Obs Omega) :
    ∃ J : Bool → Bool → ℝ,
      (∀ b c, 0 ≤ J b c) ∧
      (∑ b, ∑ c, J b c = 1) ∧
      (∀ b, ∑ c, J b c = marg S X b) ∧
      (∀ c, ∑ b, J b c = marg S Y c) :=
  ⟨joint S X Y, joint_nonneg S X Y, joint_total S X Y,
    joint_marg_left S X Y, joint_marg_right S X Y⟩

/-! ## 3. No uncertainty relation is available (essay condition CT4) -/

section Dirac
variable [DecidableEq Omega]

/-- The point mass at `w`: total confidence about which underlying point obtains. -/
def dirac (w : Omega) : State Omega where
  p := fun v => if v = w then 1 else 0
  nonneg := by intro v; by_cases h : v = w <;> simp [h]
  total := by simp

/-- On a point mass, every question is answered with certainty. -/
theorem dirac_sharp (w : Omega) (X : Obs Omega) : marg (dirac w) X (X w) = 1 := by
  unfold marg dirac
  rw [Finset.sum_eq_single w]
  · simp
  · intro v _ hv
    by_cases hx : X v = X w <;> simp [hx, hv]
  · intro h
    exact absurd (Finset.mem_univ w) h

/-- **No uncertainty relation.** For ANY pair of questions there is a state on which both
    are answered with certainty at once. So no state-independent lower bound on any joint
    measure of spread can exist, and the essay's condition CT4 fails for every candidate
    without inspecting any of them. Contrast the qubit, where `sigma_x` and `sigma_z`
    have no common sharp state. -/
theorem no_uncertainty_relation_binary (w : Omega) (X Y : Obs Omega) :
    marg (dirac w) X (X w) = 1 ∧ marg (dirac w) Y (Y w) = 1 :=
  ⟨dirac_sharp w X, dirac_sharp w Y⟩

end Dirac

/-! ## 4. The escape route: non-commuting ACTS on a simplex

    The essay's best invention says the non-commutativity lives not between propositions
    but between the prover's acts. Below: the acts really do fail to commute, and it
    buys nothing, because they still map the simplex to itself. Order-dependence of
    UPDATE is not order-dependence of EVALUATION. -/

/-- A **binary channel** on the state of a sentence, written in the one coordinate a
    two-point simplex has: `p` is the weight of the first point, `a = P(first | first)`,
    `b = P(first | second)`. Every stochastic map on a classical bit has this form. -/
def act (a b p : ℝ) : ℝ := a * p + b * (1 - p)

/-- A channel maps the simplex into itself. This is the whole of "the state space stays
    classical no matter what the dynamics does". -/
theorem act_mem_simplex {a b p : ℝ} (ha : 0 ≤ a) (ha' : a ≤ 1) (hb : 0 ≤ b) (hb' : b ≤ 1)
    (hp : 0 ≤ p) (hp' : p ≤ 1) : 0 ≤ act a b p ∧ act a b p ≤ 1 := by
  constructor
  · unfold act; nlinarith
  · unfold act; nlinarith

/-- **The acts do not commute.** Take `N` = the flip `p |-> 1 - p` (that is `a = 0`,
    `b = 1`) and `H` = the half-damping `p |-> p/2` (`a = 1/2`, `b = 0`). Starting from
    the pure state `p = 1`, running `H` then `N` lands on `1/2`, running `N` then `H`
    lands on `0`.

    The essay's invented Adoption Algebra and Search-Order pair are RIGHT about this:
    the order in which a prover acts genuinely matters. -/
theorem chan_noncommute :
    act 0 1 (act (1/2) 0 1) = 1/2 ∧ act (1/2) 0 (act 0 1 1) = 0 ∧
    (1/2 : ℝ) ≠ 0 := by
  refine ⟨by norm_num [act], by norm_num [act], by norm_num⟩

/-- **The escape route is closed.** The same two non-commuting acts preserve the simplex,
    so their non-commutativity is a fact about the dynamics and not about the state space.
    A state space with non-commuting dynamics is still a simplex, still has a unique
    decomposition into extreme points, and still admits a joint distribution for every
    pair of questions (section 2 applies unchanged, since it assumed nothing about
    dynamics).

    Read into the essay: the prover's acts failing to commute does not make the
    SENTENCE's state space non-classical, so it cannot resurrect the ball. -/
theorem escape_route_closed :
    (∀ p : ℝ, 0 ≤ p → p ≤ 1 → 0 ≤ act 0 1 p ∧ act 0 1 p ≤ 1) ∧
    (∀ p : ℝ, 0 ≤ p → p ≤ 1 → 0 ≤ act (1/2) 0 p ∧ act (1/2) 0 p ≤ 1) ∧
    act 0 1 (act (1/2) 0 1) ≠ act (1/2) 0 (act 0 1 1) := by
  refine ⟨fun p hp hp' => act_mem_simplex (by norm_num) (by norm_num) (by norm_num)
            (by norm_num) hp hp',
          fun p hp hp' => act_mem_simplex (by norm_num) (by norm_num) (by norm_num)
            (by norm_num) hp hp',
          ?_⟩
  norm_num [act]

/-! ## 5. What a genuine complementary pair would have to break

    Stated as the contrapositive of section 2, so the bar is exactly legible: a candidate
    pair is complementary only if it is NOT jointly realisable on any common sample space.
    By `no_logical_complementarity` that means the pair cannot both be functions of a
    single underlying point. Whatever the second question is, it must fail to be a
    property of the thing the first question is a property of. -/

/-- The bar, stated negatively. If a pair of questions is complementary in the sense of
    having no joint distribution, then there is no common sample space on which both are
    two-valued functions. This is the only door the essay leaves open, and it requires
    giving up that the two questions are about the same object. -/
theorem complementary_pair_needs_no_common_sample_space
    (JX JY : Bool → ℝ)
    (h : ¬ ∃ J : Bool → Bool → ℝ,
          (∀ b c, 0 ≤ J b c) ∧
          (∀ b, ∑ c, J b c = JX b) ∧ (∀ c, ∑ b, J b c = JY c)) :
    ¬ ∃ (S : State Omega) (X Y : Obs Omega),
        (∀ b, marg S X b = JX b) ∧ (∀ c, marg S Y c = JY c) := by
  rintro ⟨S, X, Y, hX, hY⟩
  refine h ⟨joint S X Y, joint_nonneg S X Y, ?_, ?_⟩
  · intro b; rw [joint_marg_left, hX]
  · intro c; rw [joint_marg_right, hY]

end Toesnail.LogicComplementarity
