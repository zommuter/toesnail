/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean companion to the dreamed essay `docs/dreamed/inflownistration.md`.

  The essay argues that the defensible core of "inflownistration" is not the 2017
  universal thesis ("everything we do is information processing") but a much narrower
  and much sharper one: **information flow has a direction and a decay rate**. A
  description of a thing, re-described, cannot gain information about the thing. That
  is not a metaphor; it is the data-processing inequality, and this file proves the
  case of it the essay actually leans on.

  What is proved here:

    1. `log_sum_ineq` — the log-sum inequality on a `Finset`, from
       `Real.log_le_sub_one_of_pos`. Everything else is a corollary.
    2. `gibbs_nonneg'` — relative entropy is non-negative. Statement pattern taken from
       the sibling file `docs/dreamed/lean/InfoWing.lean` (`gibbs_nonneg`), which proved
       it independently for the entropy wing; it is re-derived here as the normalised
       case of (1) rather than re-proved from scratch, because this file needs the
       *unnormalised* version and the normalised one falls out.
    3. `MI_nonneg` — mutual information of a finite joint distribution is `≥ 0`.
    4. `dpi_coarse` — **the data-processing inequality for deterministic coarse-graining**:
       for any `f : Y → Z`, `MI (push p f) ≤ MI p`. Re-describing a description through
       any function of it cannot increase what it says about the referent.
       `dpi_coarse_twice` iterates it.
       **SCOPE, stated because the label would otherwise launder it:** this is the
       deterministic case (`D' = f(D)`). The general stochastic-kernel DPI for a Markov
       chain `R → D → D'` with a random second channel is NOT proved here; it needs the
       chain rule for conditional mutual information, which is more machinery than this
       dreamed file earns. The deterministic case is the one the essay's staleness
       argument uses, since an edit, a summary, a cached verdict and a re-transcription
       are all functions of what they were taken from.
    5. `mi_decay`, `steps_to_epsilon`, `halfLife`, `rpow_halfLife` — the quantitative
       half: if each step preserves at most a fraction `q < 1`, then after `n` steps at
       most `q ^ n` survives, and the number of steps to fall below `ε` is
       `log (ε / I₀) / log q`. This is what turns "descriptions rot" into a number.

  Elementary throughout. The point is that the essay's central claim has a
  machine-checked kernel, not that the kernel is deep.

  Non-duplication: the sibling `docs/dreamed/lean/EssayWing.lean` already models
  staleness as a *predicate* (`stale_entry_proves_nothing`, `fresh_transfers`,
  `driftFree_insert_source`, and a toy `.mw` DAG). None of that is restated here; this
  file is the quantitative complement to it.
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic

namespace Toesnail.Inflow

open Finset

/-! ## 1. The log-sum inequality

Everything downstream is a corollary of this one statement. Positivity lives in named
hypotheses (`ha`, `hb`) rather than in a convention about `log 0`. -/

/-- **Log-sum inequality.** For strictly positive `a` and `b` on a `Finset`,
    `(∑ a) * log ((∑ a) / (∑ b)) ≤ ∑ a * log (a / b)`.

    Proof is the one-line `log x ≤ x - 1` argument: subtract, factor, and apply
    `Real.log_le_sub_one_of_pos` to `t i = (b i * A) / (a i * B)`. -/
theorem log_sum_ineq {ι : Type*} (s : Finset ι) (a b : ι → ℝ)
    (ha : ∀ i ∈ s, 0 < a i) (hb : ∀ i ∈ s, 0 < b i) :
    (∑ i ∈ s, a i) * Real.log ((∑ i ∈ s, a i) / (∑ i ∈ s, b i))
      ≤ ∑ i ∈ s, a i * Real.log (a i / b i) := by
  rcases s.eq_empty_or_nonempty with rfl | hs
  · simp
  have hA : 0 < ∑ i ∈ s, a i := Finset.sum_pos ha hs
  have hB : 0 < ∑ i ∈ s, b i := Finset.sum_pos hb hs
  set A := ∑ i ∈ s, a i with hAdef
  set B := ∑ i ∈ s, b i with hBdef
  -- pointwise bound
  have key : ∀ i ∈ s, a i - b i * A / B
      ≤ a i * Real.log (a i / b i) - a i * Real.log (A / B) := by
    intro i hi
    have hai : 0 < a i := ha i hi
    have hbi : 0 < b i := hb i hi
    have ht : 0 < b i * A / (a i * B) := by positivity
    have hlog := Real.log_le_sub_one_of_pos ht
    have hrw : Real.log (b i * A / (a i * B))
        = Real.log (A / B) - Real.log (a i / b i) := by
      rw [Real.log_div (by positivity) (by positivity),
          Real.log_div (by positivity) (by positivity),
          Real.log_div (by positivity) (by positivity),
          Real.log_mul (by positivity) (by positivity),
          Real.log_mul (by positivity) (by positivity)]
      ring
    rw [hrw] at hlog
    -- multiply the bound by `a i > 0`
    have hmul : a i * (Real.log (A / B) - Real.log (a i / b i))
        ≤ a i * (b i * A / (a i * B) - 1) :=
      mul_le_mul_of_nonneg_left hlog hai.le
    have hsimp : a i * (b i * A / (a i * B) - 1) = b i * A / B - a i := by
      field_simp
    rw [hsimp] at hmul
    linarith
  have hsum := Finset.sum_le_sum key
  have hL : ∑ i ∈ s, (a i - b i * A / B) = 0 := by
    rw [Finset.sum_sub_distrib]
    have : ∑ i ∈ s, b i * A / B = A := by
      rw [← Finset.sum_div, ← Finset.sum_mul, ← hBdef]
      field_simp
    rw [this, ← hAdef]
    ring
  have hR : ∑ i ∈ s, (a i * Real.log (a i / b i) - a i * Real.log (A / B))
      = (∑ i ∈ s, a i * Real.log (a i / b i)) - A * Real.log (A / B) := by
    rw [Finset.sum_sub_distrib, ← Finset.sum_mul]
  rw [hL, hR] at hsum
  linarith

/-- **Gibbs' inequality** (relative entropy is non-negative), as the normalised case of
    `log_sum_ineq`. Statement pattern from the sibling `InfoWing.lean` `gibbs_nonneg`;
    that file proves it directly for the entropy wing, this one derives it, so the two
    agree without either depending on the other. -/
theorem gibbs_nonneg' {ι : Type*} (s : Finset ι) (p q : ι → ℝ)
    (hp : ∀ i ∈ s, 0 < p i) (hq : ∀ i ∈ s, 0 < q i)
    (hps : ∑ i ∈ s, p i = 1) (hqs : ∑ i ∈ s, q i = 1) :
    0 ≤ ∑ i ∈ s, p i * Real.log (p i / q i) := by
  have h := log_sum_ineq s p q hp hq
  rw [hps, hqs] at h
  simpa using h

/-! ## 2. Mutual information of a finite joint distribution

`p x y` is the joint law of the referent `x : X` and its description `y : Y`. The
marginals are sums; `MI` is the usual `∑ p log (p / (pX pY))`. Positivity is a named
hypothesis everywhere it is needed. -/

variable {X Y Z : Type*} [Fintype X] [Fintype Y] [Fintype Z]

/-- Marginal of the referent. -/
def marginalX (p : X → Y → ℝ) (x : X) : ℝ := ∑ y, p x y

/-- Marginal of the description. -/
def marginalY (p : X → Y → ℝ) (y : Y) : ℝ := ∑ x, p x y

/-- Mutual information `I(X ; Y)` of a finite joint distribution. -/
noncomputable def MI (p : X → Y → ℝ) : ℝ :=
  ∑ x, ∑ y, p x y * Real.log (p x y / (marginalX p x * marginalY p y))

theorem marginalX_pos {p : X → Y → ℝ} (hpos : ∀ x y, 0 < p x y) [Nonempty Y] (x : X) :
    0 < marginalX p x :=
  Finset.sum_pos (fun y _ => hpos x y) ⟨Classical.arbitrary Y, mem_univ _⟩

theorem marginalY_pos {p : X → Y → ℝ} (hpos : ∀ x y, 0 < p x y) [Nonempty X] (y : Y) :
    0 < marginalY p y :=
  Finset.sum_pos (fun x _ => hpos x y) ⟨Classical.arbitrary X, mem_univ _⟩

theorem sum_marginalX (p : X → Y → ℝ) (h : ∑ x, ∑ y, p x y = 1) :
    ∑ x, marginalX p x = 1 := h

theorem sum_marginalY (p : X → Y → ℝ) (h : ∑ x, ∑ y, p x y = 1) :
    ∑ y, marginalY p y = 1 := by
  unfold marginalY
  rw [Finset.sum_comm]
  exact h

/-- **Mutual information is non-negative.** `I(X;Y) ≥ 0`: a description can never carry
    a negative amount about its referent. Corollary of `gibbs_nonneg'` applied to the
    joint law against the product of the marginals. -/
theorem MI_nonneg [Nonempty X] [Nonempty Y] (p : X → Y → ℝ)
    (hpos : ∀ x y, 0 < p x y) (hsum : ∑ x, ∑ y, p x y = 1) :
    0 ≤ MI p := by
  have hprod : ∑ i : X × Y, marginalX p i.1 * marginalY p i.2 = 1 := by
    rw [Fintype.sum_prod_type]
    simp_rw [← Finset.mul_sum]
    rw [← Finset.sum_mul, sum_marginalX p hsum, sum_marginalY p hsum, one_mul]
  have hjoint : ∑ i : X × Y, p i.1 i.2 = 1 := by
    rw [Fintype.sum_prod_type]; exact hsum
  have h := gibbs_nonneg' (univ : Finset (X × Y))
    (fun i => p i.1 i.2) (fun i => marginalX p i.1 * marginalY p i.2)
    (fun i _ => hpos i.1 i.2)
    (fun i _ => mul_pos (marginalX_pos hpos i.1) (marginalY_pos hpos i.2))
    hjoint hprod
  rw [Fintype.sum_prod_type] at h
  exact h

/-! ## 3. The data-processing inequality, deterministic case

`push p f` is the joint law of the referent and a *re-description* `f` of the original
description: an edit, a summary, a transcription, a cached verdict. -/

variable [DecidableEq Z]

/-- Push a joint law forward along a re-description `f : Y → Z`. -/
def push (p : X → Y → ℝ) (f : Y → Z) : X → Z → ℝ :=
  fun x z => ∑ y ∈ univ.filter (fun y => f y = z), p x y

theorem marginalX_push (p : X → Y → ℝ) (f : Y → Z) (x : X) :
    marginalX (push p f) x = marginalX p x := by
  unfold marginalX push
  exact Finset.sum_fiberwise _ _ _

theorem marginalY_push (p : X → Y → ℝ) (f : Y → Z) (z : Z) :
    marginalY (push p f) z = ∑ y ∈ univ.filter (fun y => f y = z), marginalY p y := by
  unfold marginalY push
  exact Finset.sum_comm

/-- **Data-processing inequality, deterministic coarse-graining.** For any re-description
    `f : Y → Z`, `I(X ; f(Y)) ≤ I(X ; Y)`.

    A description of a description says no more about the referent than the description
    did. Descriptions rot; they never spontaneously improve. -/
theorem dpi_coarse [Nonempty X] [Nonempty Y] (p : X → Y → ℝ) (f : Y → Z)
    (hpos : ∀ x y, 0 < p x y) :
    MI (push p f) ≤ MI p := by
  unfold MI
  refine Finset.sum_le_sum ?_
  intro x _
  have step : ∀ z ∈ (univ : Finset Z),
      push p f x z * Real.log (push p f x z /
          (marginalX (push p f) x * marginalY (push p f) z))
        ≤ ∑ y ∈ univ.filter (fun y => f y = z),
            p x y * Real.log (p x y / (marginalX p x * marginalY p y)) := by
    intro z _
    have h := log_sum_ineq (univ.filter (fun y => f y = z))
      (fun y => p x y) (fun y => marginalX p x * marginalY p y)
      (fun y _ => hpos x y)
      (fun y _ => mul_pos (marginalX_pos hpos x) (marginalY_pos hpos y))
    have hb : ∑ y ∈ univ.filter (fun y => f y = z), marginalX p x * marginalY p y
        = marginalX (push p f) x * marginalY (push p f) z := by
      rw [← Finset.mul_sum, marginalX_push, marginalY_push]
    rw [hb] at h
    simpa [push] using h
  calc ∑ z, push p f x z * Real.log (push p f x z /
          (marginalX (push p f) x * marginalY (push p f) z))
      ≤ ∑ z, ∑ y ∈ univ.filter (fun y => f y = z),
          p x y * Real.log (p x y / (marginalX p x * marginalY p y)) :=
        Finset.sum_le_sum step
    _ = ∑ y, p x y * Real.log (p x y / (marginalX p x * marginalY p y)) :=
        Finset.sum_fiberwise _ _ _

/-- Iterating the previous theorem: two rounds of re-description lose at least as much
    as one. The essay's "an annotation of a summary of a paraphrase". -/
theorem dpi_coarse_twice {W : Type*} [Fintype W] [DecidableEq W]
    [Nonempty X] [Nonempty Y] (p : X → Y → ℝ) (f : Y → Z) (g : Z → W)
    (hpos : ∀ x y, 0 < p x y) (hpush : ∀ x z, 0 < push p f x z) :
    MI (push (push p f) g) ≤ MI p := by
  have h1 : MI (push (push p f) g) ≤ MI (push p f) := by
    haveI : Nonempty Z := ⟨f (Classical.arbitrary Y)⟩
    exact dpi_coarse (push p f) g hpush
  exact le_trans h1 (dpi_coarse p f hpos)

/-! ## 4. The decay rate, and the half-life of a claim

The DPI says the quantity is non-increasing. It says nothing about *how fast*. The
rate is an empirical parameter, and the statements below say what a measured rate
buys, with the rate itself as a named hypothesis. -/

/-- If each editing step preserves at most a fraction `q` of the mutual information,
    then after `n` steps at most `q ^ n` of the original survives. -/
theorem mi_decay (I : ℕ → ℝ) (q : ℝ) (hq : 0 ≤ q)
    (hstep : ∀ n, I (n + 1) ≤ q * I n) :
    ∀ n, I n ≤ q ^ n * I 0 := by
  intro n
  induction n with
  | zero => simp
  | succ k ih =>
    calc I (k + 1) ≤ q * I k := hstep k
      _ ≤ q * (q ^ k * I 0) := by
          exact mul_le_mul_of_nonneg_left ih hq
      _ = q ^ (k + 1) * I 0 := by ring

/-- **Steps to fall below a threshold.** With `0 < q < 1`, once
    `n ≥ log (ε / I₀) / log q`, the surviving information `I₀ * q ^ n` is below `ε`.
    This is the number the essay asks for: staleness expressed as a count of edits. -/
theorem steps_to_epsilon {q ε I0 : ℝ} (hq0 : 0 < q) (hq1 : q < 1) (hε : 0 < ε)
    (hI0 : 0 < I0) {n : ℕ} (hn : Real.log (ε / I0) / Real.log q ≤ n) :
    I0 * q ^ n ≤ ε := by
  have hlq : Real.log q < 0 := Real.log_neg hq0 hq1
  have h1 : (n : ℝ) * Real.log q ≤ Real.log (ε / I0) :=
    (div_le_iff_of_neg hlq).mp hn
  have h2 : Real.log (q ^ n) ≤ Real.log (ε / I0) := by
    rw [Real.log_pow]; exact h1
  have hqn : (0 : ℝ) < q ^ n := pow_pos hq0 n
  have h3 : q ^ n ≤ ε / I0 := by
    have := (Real.log_le_log_iff hqn (by positivity)).mp h2
    exact this
  calc I0 * q ^ n ≤ I0 * (ε / I0) := by
        exact mul_le_mul_of_nonneg_left h3 hI0.le
    _ = ε := by field_simp

/-- The half-life of a claim under a per-step preservation ratio `q`: the number of
    steps after which half the mutual information with the referent is gone. -/
noncomputable def halfLife (q : ℝ) : ℝ := Real.log 2 / (-Real.log q)

theorem halfLife_pos {q : ℝ} (hq0 : 0 < q) (hq1 : q < 1) : 0 < halfLife q := by
  have hlq : Real.log q < 0 := Real.log_neg hq0 hq1
  unfold halfLife
  apply div_pos (Real.log_pos (by norm_num))
  linarith

/-- `halfLife` deserves its name: `q ^ (halfLife q) = 1 / 2`, as a real power. -/
theorem rpow_halfLife {q : ℝ} (hq0 : 0 < q) (hq1 : q < 1) :
    q ^ (halfLife q) = 1 / 2 := by
  have hlq : Real.log q < 0 := Real.log_neg hq0 hq1
  have hne : Real.log q ≠ 0 := ne_of_lt hlq
  rw [Real.rpow_def_of_pos hq0]
  have : Real.log q * halfLife q = -Real.log 2 := by
    unfold halfLife
    field_simp
  rw [this, Real.exp_neg, Real.exp_log (by norm_num)]
  norm_num

end Toesnail.Inflow
