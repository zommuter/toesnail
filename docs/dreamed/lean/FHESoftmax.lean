/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into any `*.toml` sidecar or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/fhe-llm.md`, on the owner's third
  stated goal: an LLM whose input is encrypted, processed by an untrusted cloud, and
  decrypted only by the client.

  This file has NO owner-authored source. It is not about `crypto/fhe.md` or any physics
  page; it formalises two properties of softmax that the essay uses to argue about where
  an encrypted transformer must spend its money. They are elementary and certainly
  folklore -- the point of proving them is that the essay's DESIGN CONCLUSIONS rest on
  them, and softmax under encryption is exactly the place where an "obviously fine"
  step is expensive enough to be worth checking.

    `softmax_shift`    softmax is invariant under adding a constant to every logit, so
                       the max-subtraction every plaintext implementation performs is a
                       numerical-stability device, not part of the semantics. Under FHE
                       an encrypted max is one of the most expensive primitives there
                       is, and this says it can be replaced by ANY public constant --
                       a range bound, not a data-dependent maximum.

    `softmax_le_iff`   softmax is strictly monotone, so it preserves the order of the
                       logits and therefore the argmax. Greedy (temperature-zero)
                       decoding can be done on the raw encrypted logits, and the server
                       never has to evaluate softmax at all. Temperature sampling can
                       not, which is the real asymmetry the essay draws on.

  Check with:
    cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/FHESoftmax.lean
-/

import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace FHESoftmax

open Finset

variable {n : ℕ} [NeZero n]

/-- The softmax of a logit vector. -/
noncomputable def softmax (v : Fin n → ℝ) (i : Fin n) : ℝ :=
  Real.exp (v i) / ∑ j, Real.exp (v j)

theorem sum_exp_pos (v : Fin n → ℝ) : 0 < ∑ j, Real.exp (v j) := by
  apply Finset.sum_pos (fun j _ => Real.exp_pos _)
  exact Finset.univ_nonempty

theorem softmax_pos (v : Fin n → ℝ) (i : Fin n) : 0 < softmax v i :=
  div_pos (Real.exp_pos _) (sum_exp_pos v)

theorem softmax_sum_one (v : Fin n → ℝ) : ∑ i, softmax v i = 1 := by
  simp only [softmax, div_eq_mul_inv, ← Finset.sum_mul]
  exact mul_inv_cancel₀ (ne_of_gt (sum_exp_pos v))

omit [NeZero n] in
/-- **Shift invariance.** Adding the same constant to every logit changes nothing.

Design consequence for an encrypted transformer: the `x - max x` that every plaintext
softmax performs is there to keep `exp` in range, not to compute the right answer. An
encrypted maximum is expensive -- it is a comparison, which CKKS cannot do at all and
TFHE pays a programmable bootstrap for -- and this theorem says a PUBLIC constant, from
a calibration bound on the logit range, is semantically just as good. -/
theorem softmax_shift (v : Fin n → ℝ) (c : ℝ) (i : Fin n) :
    softmax (fun j => v j + c) i = softmax v i := by
  unfold softmax
  have hc : Real.exp c ≠ 0 := ne_of_gt (Real.exp_pos c)
  have hsum : ∑ j, Real.exp (v j + c) = (∑ j, Real.exp (v j)) * Real.exp c := by
    rw [Finset.sum_mul]
    exact Finset.sum_congr rfl fun j _ => Real.exp_add (v j) c
  rw [hsum, Real.exp_add]
  exact mul_div_mul_right (Real.exp (v i)) _ hc

/-- **Order preservation.** Softmax is monotone in each logit, so it does not move the
argmax.

Design consequence: for greedy decoding the server can hand back the encrypted LOGITS
and skip softmax entirely -- the client's argmax over decrypted logits gives the same
token. Softmax becomes unavoidable only once the client wants to sample at a nonzero
temperature, since then the actual probabilities matter and not just their order. -/
theorem softmax_le_iff (v : Fin n → ℝ) (i j : Fin n) :
    softmax v i ≤ softmax v j ↔ v i ≤ v j := by
  unfold softmax
  rw [div_le_div_iff_of_pos_right (sum_exp_pos v)]
  exact Real.exp_le_exp

/-- The argmax statement itself: a logit is maximal exactly when its softmax is. -/
theorem softmax_argmax (v : Fin n → ℝ) (i : Fin n) :
    (∀ j, v j ≤ v i) ↔ (∀ j, softmax v j ≤ softmax v i) :=
  ⟨fun h j => (softmax_le_iff v j i).mpr (h j),
   fun h j => (softmax_le_iff v j i).mp (h j)⟩

end FHESoftmax
