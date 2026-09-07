/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-thermodynamics.md`
  ("A thermodynamics of proof search").

  ------------------------------------------------------------------------------
  WHAT THE ESSAY ASKS AND WHAT THIS FILE ANSWERS
  ------------------------------------------------------------------------------

  The essay INVENTS a statistical-mechanical ensemble over proofs and then asks the
  one question that can break it rather than decorate it:

      does the partition function exist?

  A "temperature" is empty vocabulary unless there is a normalisable Boltzmann
  distribution over something. The essay's ensemble is:

      microstate   a finite proof (derivation) in a fixed proof system
      energy       E(pi) = |pi|, the length of the proof in axiom-instance leaves
      density of states  N(n) = the number of proofs of length n
      partition function Z(beta) = sum over n of N(n) * exp(-beta * n)

  This file settles the convergence question exactly, in both directions, and then
  records three consequences the essay leans on.

  ------------------------------------------------------------------------------
  SYMBOL DICTIONARY (Lean name -> essay object)
  ------------------------------------------------------------------------------

    `term a beta n`            the n-th summand `a^n * exp(-beta*n)` of Z, for a proof
                               system whose density of states is exactly `N(n) = a^n`.
                               `a` is the essay's **[INVENTED]** proof-branching factor;
                               `beta` is the **[INVENTED]** inverse proof temperature.

    `partition_summable_iff`   *THE CRUX.* Z converges **iff** `log a < beta`, i.e. iff
                               the temperature is below `T_c = 1 / log a`. This is the
                               essay's critical-temperature claim, machine-checked and
                               stated as an iff, so it also proves the DIVERGENCE half:
                               above `T_c` there is no Boltzmann distribution over
                               proofs at all, and the word "temperature" is unearned
                               there. Essay handle `partition`.

    `critTemp a`               `1 / log a`. A definition, not a claim.

    `not_summable_of_exp_le`   Comparison form: any proof system with AT LEAST `a^n`
                               proofs of length `n` inherits the divergence. This is
                               what lets the essay apply the result to a real proof
                               system, where `N(n)` is only bounded below.
                               Essay handle `partition-lb`.

    `no_normalisation_of_empty`
                               If the set of proofs of a sentence is EMPTY, the weights
                               sum to 0 and no normalised Gibbs state exists. The essay
                               uses this against the "undecidability is a glassy phase"
                               reading: a glass is a system with a Gibbs measure and slow
                               dynamics; an unprovable sentence has NO Gibbs measure.
                               Essay handle `empty-ensemble`.

    `meanLen x`                `x / (1 - x)` with `x = a * exp(-beta)`: the ensemble mean
                               proof length.
    `meanLen_eq`               that this really is `(sum n*x^n) / (sum x^n)`.
    `meanLen_unbounded`        it exceeds every bound as `x -> 1`, i.e. as the temperature
                               rises to `T_c` from below. The essay reads this as the
                               Hagedorn-type signature: approaching `T_c` the typical
                               proof gets arbitrarily long. Essay handle `hagedorn`.

  ------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE -- do not read this file as more than it is
  ------------------------------------------------------------------------------

    - NO PHYSICAL CLAIM IS MADE ANYWHERE IN THIS FILE. There is no thermodynamics
      here: no heat, no work, no second law, no Landauer bound. Everything below is
      elementary real analysis about geometric series. The words "partition
      function", "temperature" and "Hagedorn" appear only in comments, and they are
      the ESSAY'S INVENTED NAMES for these series, not established terminology for
      proof search. The essay labels every one of them **[INVENTED]** and lists them
      in its Inventory of Invented Objects.

    - The identification of `E(pi)` with proof length, of `beta` with anything an
      actual prover controls, and of the ensemble with anything a prover samples, are
      all the essay's inventions and are NOT proved here. In particular nothing below
      shows that any real proof search visits proofs with Boltzmann probabilities.

    - `N(n) = a^n` is a MODEL of the density of states. The essay measures the real
      `N(n)` numerically for one tiny Hilbert system and finds it exponential with
      `a ~ 2.3445`, but that measurement is numerical and is NOT formalised here.

    - Nothing here is about Goedel, undecidability, or incompleteness as such.
      `no_normalisation_of_empty` is a statement about the empty index type. Reading
      "empty proof set" as "undecidable sentence" is the essay's step, not Lean's,
      and the essay flags the gap (an unprovable-but-refutable sentence also has an
      empty proof set, and so does a merely unproved theorem below any horizon).

    - This file does NOT re-prove the binary-entropy antitonicity `h((1+r)/2)` that
      licenses "r is settledness". That is already discharged by the sibling file
      `lean/LogicEpistemic.lean` as `settledEntropy_strictAntiOn`, and duplicating it
      here would be a padded attestation rather than a new one.

    - The random k-SAT phase transition discussed in the essay is REAL, PUBLISHED
      mathematics (Friedgut 1999; Ding-Sly-Sun for large k) and is NOT formalised
      here. The essay's own SAT numbers are simulations, not theorems.
-/
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace Toesnail.LogicThermo

open Real

/-! ## 1. The partition function of the invented proof ensemble -/

/-- The `n`-th summand of the invented partition function
`Z(β) = ∑ₙ N(n) e^{-βn}` for a proof system whose density of states is exactly
`N(n) = aⁿ`. Here `a` is the branching factor and `β` the inverse temperature. -/
noncomputable def term (a β : ℝ) (n : ℕ) : ℝ := a ^ n * Real.exp (-β * n)

/-- The whole summand is a single geometric power. This is the only algebra in the
file, and it is what makes the convergence question decidable. -/
lemma term_eq (a β : ℝ) (n : ℕ) : term a β n = (a * Real.exp (-β)) ^ n := by
  have h : Real.exp (-β * (n : ℝ)) = Real.exp (-β) ^ n := by
    rw [mul_comm, Real.exp_nat_mul]
  rw [term, h, mul_pow]

lemma term_fun (a β : ℝ) : term a β = fun n : ℕ => (a * Real.exp (-β)) ^ n :=
  funext (term_eq a β)

/-- **The crux, as an iff.** For a proof system with `aⁿ` proofs of length `n`
(`a > 0`), the partition function `∑ₙ aⁿ e^{-βn}` is summable **exactly when**
`log a < β`.

Read as thermodynamics (the essay's invented reading, not a theorem about heat):
there is a **critical temperature** `T_c = 1/log a`. Below it the Boltzmann
distribution over proofs exists; at or above it the normalisation diverges and
there is no distribution to speak of. The `iff` matters: the divergence half is the
essay's actual finding, because it says the analogy has a hard boundary rather than
an unlimited licence. -/
theorem partition_summable_iff {a β : ℝ} (ha : 0 < a) :
    Summable (term a β) ↔ Real.log a < β := by
  rw [term_fun, summable_geometric_iff_norm_lt_one]
  have hx : 0 < a * Real.exp (-β) := mul_pos ha (Real.exp_pos _)
  rw [Real.norm_eq_abs, abs_of_pos hx]
  rw [Real.exp_neg]
  constructor
  · intro h
    have hb : (0 : ℝ) < Real.exp β := Real.exp_pos _
    have : a < Real.exp β := by
      rw [mul_inv_lt_iff₀ hb] at h
      simpa using h
    exact (Real.log_lt_iff_lt_exp ha).mpr this
  · intro h
    have : a < Real.exp β := (Real.log_lt_iff_lt_exp ha).mp h
    have hb : (0 : ℝ) < Real.exp β := Real.exp_pos _
    rw [mul_inv_lt_iff₀ hb]
    simpa using this

/-- The critical temperature of the invented ensemble: a *definition*, so that the
essay's `T_c` has a referent. It depends only on the branching factor `a`, i.e. only
on the proof SYSTEM -- never on which sentence is being proved. The essay treats that
goal-independence as bad news for the analogy, not good news. -/
noncomputable def critTemp (a : ℝ) : ℝ := 1 / Real.log a

/-- Restatement of the crux in temperature language, for `a > 1` (so `log a > 0`
and `T_c` is a positive temperature): `Z` converges iff `T < T_c`, where
`T = 1/β`. Stated for `β > 0`, which is the only physically-read regime. -/
theorem partition_summable_iff_temp {a β : ℝ} (ha : 1 < a) (hβ : 0 < β) :
    Summable (term a β) ↔ 1 / β < critTemp a := by
  have hla : 0 < Real.log a := Real.log_pos ha
  rw [partition_summable_iff (lt_trans zero_lt_one ha), critTemp,
    div_lt_div_iff₀ hβ hla]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/-! ## 2. Comparison: a lower bound on the density of states is enough -/

/-- **The applicable form.** A real proof system does not have exactly `aⁿ` proofs of
length `n`; the essay only measures a lower bound. That is enough: if `aⁿ ≤ N n` for
every `n`, then at or above the critical temperature the partition function still
diverges. (Contrapositive of comparison, with `N ≥ 0` supplied by the bound.) -/
theorem not_summable_of_exp_le {a β : ℝ} {N : ℕ → ℝ} (ha : 0 < a)
    (hle : ∀ n, a ^ n ≤ N n) (hβ : β ≤ Real.log a) :
    ¬ Summable (fun n : ℕ => N n * Real.exp (-β * n)) := by
  intro hS
  have hterm : Summable (term a β) := by
    refine hS.of_nonneg_of_le (fun n => ?_) (fun n => ?_)
    · exact mul_nonneg (pow_nonneg ha.le n) (Real.exp_pos _).le
    · exact mul_le_mul_of_nonneg_right (hle n) (Real.exp_pos _).le
  exact absurd ((partition_summable_iff ha).mp hterm) (not_lt.mpr hβ)

/-! ## 3. An empty proof space carries no Gibbs state at all -/

/-- **Against the glass reading.** If a sentence has no proofs, its Boltzmann weights
sum to `0`, so there is no normalised distribution over them. A glass is a system that
*has* a Gibbs measure and cannot reach its ground state; an unprovable sentence has no
Gibbs measure to be slow about. The essay uses this to argue that "undecidable = glassy
phase" is a simile, not a shared structure. -/
theorem no_normalisation_of_empty {ι : Type*} [IsEmpty ι] (w : ι → ℝ) :
    ∑' i, w i ≠ 1 := by
  rw [tsum_empty]
  norm_num

/-- The same fact as a positive statement about the sum, so the essay can quote it
without the negation. -/
theorem tsum_weights_of_empty {ι : Type*} [IsEmpty ι] (w : ι → ℝ) :
    ∑' i, w i = 0 := tsum_empty

/-! ## 4. The Hagedorn signature: mean proof length diverges at `T_c` -/

/-- The ensemble mean proof length, in the variable `x = a·e^{-β}`. Below the
critical temperature `0 ≤ x < 1`; the critical point is `x = 1`. -/
noncomputable def meanLen (x : ℝ) : ℝ := x / (1 - x)

/-- `meanLen` really is the ensemble average of the length: numerator `∑ n xⁿ`,
denominator `∑ xⁿ`. -/
theorem meanLen_eq {x : ℝ} (h0 : 0 ≤ x) (h1 : x < 1) :
    (∑' n : ℕ, (n : ℝ) * x ^ n) / (∑' n : ℕ, x ^ n) = meanLen x := by
  have hnorm : ‖x‖ < 1 := by rwa [Real.norm_eq_abs, abs_of_nonneg h0]
  have hnum : (∑' n : ℕ, (n : ℝ) * x ^ n) = x / (1 - x) ^ 2 :=
    tsum_coe_mul_geometric_of_norm_lt_one hnorm
  have hden : (∑' n : ℕ, x ^ n) = (1 - x)⁻¹ := tsum_geometric_of_lt_one h0 h1
  have hne : (1 : ℝ) - x ≠ 0 := by linarith
  rw [hnum, hden, meanLen]
  field_simp

/-- **The divergence.** No bound survives: for every `M` there is a subcritical `x`
whose mean proof length exceeds `M`. Read as the essay's invented thermodynamics,
this is a Hagedorn-type transition -- as the temperature rises to `T_c` from below,
the typical proof grows without limit, so the ensemble runs out of finite proofs
before it runs out of temperature. -/
theorem meanLen_unbounded (M : ℝ) : ∃ x : ℝ, 0 ≤ x ∧ x < 1 ∧ M < meanLen x := by
  set t : ℝ := |M| with ht
  have ht0 : 0 ≤ t := abs_nonneg M
  refine ⟨(t + 1) / (t + 2), ?_, ?_, ?_⟩
  · positivity
  · rw [div_lt_one (by linarith)]; linarith
  · have h2 : (0 : ℝ) < t + 2 := by linarith
    have hx : (1 : ℝ) - (t + 1) / (t + 2) = 1 / (t + 2) := by
      field_simp; ring
    have hval : (t + 1) / (t + 2) / (1 / (t + 2)) = t + 1 := by
      field_simp
    rw [meanLen, hx, hval]
    have : M ≤ t := le_abs_self M
    linarith

/-- Monotonicity of the mean length below criticality: hotter means longer.
(`x = a·e^{-β}` increases with temperature.) -/
theorem meanLen_strictMono : StrictMonoOn meanLen (Set.Ico (0 : ℝ) 1) := by
  intro x hx y hy hxy
  have hx1 : (0 : ℝ) < 1 - x := by have := hx.2; linarith
  have hy1 : (0 : ℝ) < 1 - y := by have := hy.2; linarith
  rw [meanLen, meanLen, div_lt_div_iff₀ hx1 hy1]
  nlinarith [hx.1, hy.1]

end Toesnail.LogicThermo
