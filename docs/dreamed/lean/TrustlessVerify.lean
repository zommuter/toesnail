/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into any `*.toml` sidecar or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/trustless-distributed-ai.md`, on the
  INTEGRITY half of trustless distributed AI: not "can the server read my prompt" but "did
  the server run the model it billed for".

  This file has NO owner-authored source; it is systems security, not physics.

  The essay's constructive proposal is gap-gated verification: two independent providers
  compute the same logits, they will NOT agree bitwise (measured in
  `docs/dreamed/fhe-search/trustless_verify.py` experiment L: about 1e-5 apart at float32,
  purely from reduction order), so the check must be a tolerance check -- and a tolerance
  check on a discrete argmax is unsound unless the margin is large enough. `argmax_stable`
  is exactly the side condition that makes it sound.

  NOT NOVEL, recorded here as well as in the essays: DiFR (arXiv 2511.20621, Nov 2025) uses a
  clipped logit-gap margin for the same purpose and does it better -- as a continuous statistic
  aggregated over tokens rather than a binary gate, plus seed synchronisation. The theorem below
  is independently derived and remains a clean statement of WHY a margin is the right gate.

  Also: the ~1e-5 figure quoted above is the SYNTHETIC single-dot-product estimate. Measured on
  GPT-2 end to end (float32 vs float64), the median is ~1e-4 and the max ~4e-3 -- see the essay's
  section 4a. The theorem is unaffected; the tolerance it should be instantiated at is not.

    `argmax_stable`      if two logit vectors agree within eps and the winner's margin
                         exceeds 2*eps, both vectors have the same argmax. Tokens failing
                         the margin test are escalated; tokens passing it are settled.

    `margin_necessary`   the converse-ish guard: with a margin of exactly 2*eps the
                         conclusion can fail, so the strict inequality is not slack.

    `agree_pow_le_exp`   why comparing whole completions is the wrong primitive: the
                         probability that n independent tokens all survive decays at least
                         as fast as exp(-n*p), so at long context an HONEST provider fails
                         a naive text-equality check.

    `deterrence`         sampled verification: cheating has negative expected value exactly
                         when the sampling rate exceeds saving/bond. The toy form of Proof
                         of Sampling (arXiv 2405.00295), not offered as a new result.

  Check with:
    cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/TrustlessVerify.lean
-/

import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Real.Basic

namespace TrustlessVerify

/-! ## 1. When is approximate agreement enough?

Two honest providers produce logit vectors `v` and `w` that differ by at most `eps`. The
decoded token is the argmax. The question a verifier must answer is when the argmax is
forced to agree even though the vectors do not. -/

/-- `i₀` wins in `v` by a margin of at least `gap`. -/
def WinsBy {n : ℕ} (v : Fin n → ℝ) (i₀ : Fin n) (gap : ℝ) : Prop :=
  ∀ j, j ≠ i₀ → v j + gap ≤ v i₀

/-- The two providers' logits agree to within `eps`, coordinatewise. -/
def AgreeWithin {n : ℕ} (v w : Fin n → ℝ) (eps : ℝ) : Prop :=
  ∀ j, |w j - v j| ≤ eps

/-- **Gap-gated verification is sound.** If the providers agree within `eps` and the
winner's margin strictly exceeds `2*eps`, then the second provider's logits have the same
strict winner. So a verifier may accept the token on a tolerance comparison alone,
provided it checks the margin.

This is the theorem the essay's scheme rests on: without the margin condition a tolerance
comparison says nothing at all about the decoded token, because argmax is discrete. -/
theorem argmax_stable {n : ℕ} (v w : Fin n → ℝ) (i₀ : Fin n) (eps gap : ℝ)
    (hagree : AgreeWithin v w eps) (hwin : WinsBy v i₀ gap) (hgap : 2 * eps < gap) :
    ∀ j, j ≠ i₀ → w j < w i₀ := by
  intro j hj
  have hj' : v j + gap ≤ v i₀ := hwin j hj
  -- `w j ≤ v j + eps` and `v i₀ - eps ≤ w i₀`
  have h1 : w j ≤ v j + eps := by
    have := abs_le.mp (hagree j)
    linarith [this.2]
  have h2 : v i₀ - eps ≤ w i₀ := by
    have := abs_le.mp (hagree i₀)
    linarith [this.1]
  linarith

/-- The margin condition is not slack: at `gap = 2*eps` exactly, the conclusion can fail.
Two logits one apart, a tolerance of one half, and the challenger's perturbation moves
each by exactly the tolerance -- producing a tie, so the strict winner is gone. -/
theorem margin_necessary :
    ∃ (v w : Fin 2 → ℝ) (i₀ : Fin 2) (eps gap : ℝ),
      AgreeWithin v w eps ∧ WinsBy v i₀ gap ∧ 2 * eps = gap ∧
      ¬ (∀ j, j ≠ i₀ → w j < w i₀) := by
  refine ⟨![0, 1], ![1/2, 1/2], 1, 1/2, 1, ?_, ?_, by norm_num, ?_⟩
  · intro j
    fin_cases j <;> norm_num
  · intro j hj
    fin_cases j
    · norm_num
    · simp at hj
  · intro h
    have := h 0 (by decide)
    norm_num at this

/-! ## 2. Why whole-completion comparison is the wrong primitive

If each token survives the margin test independently with probability `1 - p`, the whole
completion survives with probability `(1-p)^n`, which decays exponentially. A verifier
that re-runs the model and compares the resulting TEXT therefore accuses honest providers
at long context. -/

/-- `(1 - p)^n ≤ exp(-n p)`: agreement over a whole completion decays at least
exponentially in its length. Concretely, the essay's table -- at a per-token flip rate of
one in a thousand, a 4096-token completion is reproduced 1.7% of the time. -/
theorem agree_pow_le_exp (p : ℝ) (_hp0 : 0 ≤ p) (hp1 : p ≤ 1) (n : ℕ) :
    (1 - p) ^ n ≤ Real.exp (-(n * p)) := by
  have hstep : (1 - p) ≤ Real.exp (-p) := by
    have := Real.add_one_le_exp (-p)
    linarith
  calc (1 - p) ^ n ≤ (Real.exp (-p)) ^ n :=
        pow_le_pow_left₀ (by linarith) hstep n
    _ = Real.exp (-(n * p)) := by
        rw [← Real.exp_nat_mul]; ring_nf

/-! ## 3. Sampled deterrence

The asymmetry the essay turns on: confidentiality cannot be sampled, integrity can. A
provider saving `s` per request and caught with probability `q`, forfeiting bond `D`, has
negative expected value from cheating exactly when `q * D` exceeds `s`. -/

/-- Expected payoff of cheating, per request: keep the saving, lose the bond when caught. -/
noncomputable def cheatPayoff (s q D : ℝ) : ℝ := s - q * D

/-- **Deterrence condition.** Cheating is unprofitable precisely when the checking rate
exceeds the saving-to-bond ratio. With a bond worth a thousand requests and a saving of
88% of one, that rate is under a tenth of a percent. -/
theorem deterrence (s q D : ℝ) (hD : 0 < D) :
    cheatPayoff s q D < 0 ↔ s / D < q := by
  unfold cheatPayoff
  rw [div_lt_iff₀ hD]
  constructor <;> intro h <;> nlinarith

/-- What the deterrence argument silently assumes, recorded as a definition rather than a
theorem because it is not a mathematical statement: that the checker can REPRODUCE the
computation it is checking. Section 1 exists because for floating-point LLM inference
across heterogeneous providers this assumption is false as stated, and has to be weakened
to reproduction-within-tolerance plus a margin test. STATED, NOT PROVED. -/
def CheckerCanReproduce {Input Output : Type*} (run : Input → Output)
    (check : Input → Output) : Prop :=
  ∀ i, check i = run i

end TrustlessVerify
