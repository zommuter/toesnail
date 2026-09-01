/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/information-wing.md`, which
  explores open owner question **Q9** from
  `docs/meeting-notes/2026-07-07-1257-corpus-dreaming-session.md`:

      "Q9 - wings: ratify the information wing (fhe + entropy + Landauer/Shannon,
       Sec. 1.6) as a named third wing beside physics spine and essays?"

  The essay's answer is that the wing coheres around exactly ONE quantity, the
  LOGARITHM OF A COUNT, and that the three candidate members meet only there. This
  file discharges the four places where that claim is a theorem rather than a
  reading, in the owner's own notation wherever he has one.

  Notation map, Lean back to the owner's text:

    `∑ k ∈ Finset.range N, r ^ k`
                   the truncated partition function `Z_B` of `physics/entropy.md`
                   line 14, with `r = Z_1 = exp(-β E_1)`. Section 1 below evaluates
                   the SAME sum at `r = 2`, where it counts binary strings. That
                   coincidence is the wing's whole architecture, not a pun.
    `Σ k : Fin n, (Fin k → Bool)`
                   the descriptions SHORTER than `n` bits: a length `k < n` together
                   with the `k` bits. This is the counting half of `crypto/fhe.md`'s
                   opening paragraph ("these functions can be enumerated using
                   `m 2^n` bits") applied to strings instead of functions.
    `dec`          a decompressor. Deliberately an ARBITRARY function, with no
                   computability assumption: the counting bound never needs one.
    `p`, `q`       probability vectors. `p` is `physics/entropy.md`'s `p_k`.
    `β`, `E`, `Z`  as in `physics/entropy.md` line 10: `p_k = exp(-β E_k)/Z_B`.
    `kB`, `T`, `Q` Boltzmann constant, bath temperature, heat to the bath. Landauer.

  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):
    - Kolmogorov complexity is NOT defined here. Section 1 proves the COUNTING bound
      that underlies incompressibility, over an arbitrary `dec`. It says nothing
      about uncomputability of `K`, nothing about the invariance theorem, and nothing
      about any particular universal machine. The essay is explicit that the
      uncomputability half is cited, not proved.
    - Landauer's principle is not derived from microphysics here. `landauer_heat`
      takes the second law as a NAMED hypothesis (`second_law`) and does the
      arithmetic. That is the honest content: the physics is the hypothesis, the
      `kB T log 2` is bookkeeping.
    - Nothing here concerns fully homomorphic encryption. The essay's verdict is that
      `crypto/fhe.md` as written contains no FHE, only reversible-function counting,
      and that FHE security is COMPUTATIONAL, hence outside any entropy theorem.
    - `gibbs_nonneg` assumes strict positivity of both vectors on the index set. The
      `0 log 0 = 0` boundary convention is avoided rather than handled.
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Field.GeomSum
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Sigma
import Mathlib.Data.Fintype.Pi
import Mathlib.Tactic

namespace Toesnail.InfoWing

open Finset

/-! ## 1. The one quantity: a truncated geometric sum, read twice

`physics/entropy.md` line 14 writes the partition function of a ladder of linear
energies as `Z_B = ∑_{k<N} Z_1^k = (1 - Z_1^N)/(1 - Z_1)`. The counting argument
behind incompressibility is the SAME sum at `Z_1 = 2`. -/

/-- The owner's truncated partition function, closed form (`physics/entropy.md` l.14).
    Mathlib states `geom_sum_eq` with the `(r^N - 1)/(r - 1)` orientation; the owner
    writes `(1 - r^N)/(1 - r)`. They are equal, and this records that. -/
theorem partition_truncated (r : ℝ) (hr : r ≠ 1) (N : ℕ) :
    ∑ k ∈ range N, r ^ k = (1 - r ^ N) / (1 - r) := by
  rw [geom_sum_eq hr]
  rw [div_eq_div_iff (sub_ne_zero.mpr hr) (sub_ne_zero.mpr (Ne.symm hr))]
  ring

/-- The same sum over `ℕ` at `r = 2`, stated additively so that truncated `Nat`
    subtraction never appears: `(∑_{k<n} 2^k) + 1 = 2^n`. Read as counting, the sum
    is the number of binary strings of length strictly less than `n`. -/
theorem geom_two_succ (n : ℕ) : (∑ k ∈ range n, 2 ^ k) + 1 = 2 ^ n := by
  induction n with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ, pow_succ]
    omega

/-- The type of descriptions shorter than `n` bits: a length `k < n` plus `k` bits.
    Its cardinality is the sum above, so `card + 1 = 2 ^ n`: strictly fewer short
    descriptions than there are strings of length `n`. -/
theorem card_short_descriptions (n : ℕ) :
    Fintype.card (Σ k : Fin n, (Fin (k : ℕ) → Bool)) + 1 = 2 ^ n := by
  rw [Fintype.card_sigma]
  simp only [Fintype.card_fun, Fintype.card_fin, Fintype.card_bool]
  rw [Fin.sum_univ_eq_sum_range (fun k => 2 ^ k) n]
  exact geom_two_succ n

/-- **Incompressibility, counting form.** For ANY map `dec` from descriptions shorter
    than `n` bits to strings of length `n` -- no computability assumption, no choice of
    universal machine -- some string of length `n` is not in the image. There is at
    least one incompressible string.

    This is the essay's item 4: the same diagonal as `Omniscience.lean`'s Lawvere, in
    a counting coat. Where Lawvere needs no cardinality at all, this one needs nothing
    BUT cardinality. -/
theorem exists_incompressible (n : ℕ)
    (dec : (Σ k : Fin n, (Fin (k : ℕ) → Bool)) → (Fin n → Bool)) :
    ∃ s : Fin n → Bool, ∀ d, dec d ≠ s := by
  by_contra h
  push Not at h
  have hsurj : Function.Surjective dec := by
    intro s
    obtain ⟨d, hd⟩ := h s
    exact ⟨d, hd⟩
  have hle := Fintype.card_le_of_surjective dec hsurj
  have hstr : Fintype.card (Fin n → Bool) = 2 ^ n := by
    simp
  have hdesc := card_short_descriptions n
  omega

/-- **Most strings are incompressible.** Splitting `n = m + c`, the descriptions
    shorter than `m` bits number fewer than `2^n / 2^c`: the fraction of length-`n`
    strings compressible by `c` bits or more is under `2^(-c)`. Stated multiplicatively
    to keep everything in `ℕ` with no division and no truncated subtraction. -/
theorem few_compressible (m c n : ℕ) (hn : m + c = n) :
    Fintype.card (Σ k : Fin m, (Fin (k : ℕ) → Bool)) * 2 ^ c < 2 ^ n := by
  have hcard := card_short_descriptions m
  have hpow : (2 : ℕ) ^ m * 2 ^ c = 2 ^ n := by
    rw [← pow_add, hn]
  have hpos : 0 < (2 : ℕ) ^ c := pow_pos (by norm_num) c
  nlinarith [hcard, hpow, hpos]

/-! ## 2. Landauer: the one place an information count has an energy price -/

/-- Halving the accessible state count costs exactly `log 2` of `log W`. This is the
    whole of the Landauer entropy step; `W > 0` is NAMED because `Real.log` is junk
    at `0`. -/
theorem log_halving {W : ℝ} (hW : 0 < W) : Real.log (2 * W) - Real.log W = Real.log 2 := by
  rw [Real.log_mul (by norm_num) (ne_of_gt hW)]
  ring

/-- Boltzmann form: with `S(W) = kB log W`, erasing one bit (state count `2W → W`)
    changes the system entropy by `-kB log 2`. -/
theorem boltzmann_erasure (kB : ℝ) {W : ℝ} (hW : 0 < W) :
    kB * Real.log W - kB * Real.log (2 * W) = -(kB * Real.log 2) := by
  rw [Real.log_mul (by norm_num) (ne_of_gt hW)]
  ring

/-- **Landauer's bound.** The second law is a NAMED hypothesis, not a derivation:
    given that the system entropy drops by `kB log 2` (previous theorem), that the
    bath absorbs `Q` at temperature `T` so its entropy rises by `Q/T`, and that the
    total does not decrease, the heat obeys `Q ≥ kB T log 2`.

    The physics lives entirely in `second_law` and in the identification of `Q/T` as
    the bath's entropy change. Everything else is arithmetic. That is the honest
    shape of the argument, and the essay states it that way. -/
theorem landauer_heat (kB T Q dS_sys dS_bath : ℝ) (hT : 0 < T)
    (h_sys : dS_sys = -(kB * Real.log 2)) (h_bath : dS_bath = Q / T)
    (second_law : 0 ≤ dS_sys + dS_bath) :
    kB * T * Real.log 2 ≤ Q := by
  rw [h_sys, h_bath] at second_law
  have hQ : Q = Q / T * T := by field_simp
  nlinarith [second_law, hT]

/-! ## 3. Gibbs, and the owner's own maximum-entropy calculation

`physics/entropy.md` line 8 maximizes `-∑ p_k ln p_k` under `∑ p_k = 1` and
`∑ p_k E_k = E` with Lagrange multipliers `α, β`, and reads off the Boltzmann
distribution. Lagrange multipliers give a stationary point; that it is the MAXIMUM
is the content below, via Gibbs' inequality. -/

/-- **Gibbs' inequality** (non-negativity of the Kullback-Leibler divergence).
    Both vectors are assumed strictly positive on `s`, which sidesteps the
    `0 log 0 = 0` convention entirely. -/
theorem gibbs_nonneg {ι : Type*} (s : Finset ι) (p q : ι → ℝ)
    (hp : ∀ i ∈ s, 0 < p i) (hq : ∀ i ∈ s, 0 < q i)
    (hps : ∑ i ∈ s, p i = 1) (hqs : ∑ i ∈ s, q i = 1) :
    0 ≤ ∑ i ∈ s, p i * Real.log (p i / q i) := by
  have key : ∀ i ∈ s, p i - q i ≤ p i * Real.log (p i / q i) := by
    intro i hi
    have hpi := hp i hi
    have hqi := hq i hi
    have hlog := Real.log_le_sub_one_of_pos (div_pos hqi hpi)
    have hneg : Real.log (q i / p i) = -Real.log (p i / q i) := by
      rw [← Real.log_inv]
      congr 1
      field_simp
    rw [hneg] at hlog
    have hmul : p i * (-Real.log (p i / q i)) ≤ p i * (q i / p i - 1) :=
      mul_le_mul_of_nonneg_left hlog (le_of_lt hpi)
    have hsimp : p i * (q i / p i - 1) = q i - p i := by field_simp
    rw [hsimp] at hmul
    linarith
  have hsum : ∑ i ∈ s, (p i - q i) ≤ ∑ i ∈ s, p i * Real.log (p i / q i) :=
    Finset.sum_le_sum key
  rw [Finset.sum_sub_distrib, hps, hqs] at hsum
  simpa using hsum

/-- **The uniform distribution maximizes Shannon entropy**: `H(p) ≤ log |s|`.
    The corollary of Gibbs at `q = 1/|s|`. In the wing's language: the entropy of an
    ensemble never exceeds the logarithm of the count of its possibilities, which is
    the sentence that makes `log W` the wing's single quantity. -/
theorem entropy_le_log_card {ι : Type*} (s : Finset ι) (hs : s.Nonempty) (p : ι → ℝ)
    (hp : ∀ i ∈ s, 0 < p i) (hps : ∑ i ∈ s, p i = 1) :
    ∑ i ∈ s, -(p i * Real.log (p i)) ≤ Real.log s.card := by
  have hcard : (0 : ℝ) < (s.card : ℝ) := by
    exact_mod_cast Finset.card_pos.mpr hs
  have hq : ∀ i ∈ s, 0 < (1 : ℝ) / s.card := fun _ _ => by positivity
  have hqs : ∑ _i ∈ s, (1 : ℝ) / s.card = 1 := by
    rw [Finset.sum_const, nsmul_eq_mul]
    field_simp
  have hG := gibbs_nonneg s p (fun _ => (1 : ℝ) / s.card) hp hq hps hqs
  have hrw : ∀ i ∈ s, p i * Real.log (p i / (1 / s.card))
      = p i * Real.log (p i) + p i * Real.log s.card := by
    intro i hi
    have hpi := hp i hi
    rw [div_div_eq_mul_div, div_one, Real.log_mul (ne_of_gt hpi) (ne_of_gt hcard)]
    ring
  rw [Finset.sum_congr rfl hrw, Finset.sum_add_distrib, ← Finset.sum_mul, hps, one_mul] at hG
  have : ∑ i ∈ s, -(p i * Real.log (p i)) = -∑ i ∈ s, p i * Real.log (p i) := by
    simp [Finset.sum_neg_distrib]
  rw [this]
  linarith

/-- **Boltzmann's entropy value.** For `p_k = exp(-β E_k)/Z` with `Z = ∑ exp(-β E_k)`
    (`physics/entropy.md` line 10 verbatim), the Shannon entropy equals `log Z + β⟨E⟩`.
    This is the value the owner's Lagrange calculation lands on. -/
theorem boltzmann_entropy_value {ι : Type*} (s : Finset ι) (β : ℝ) (E : ι → ℝ)
    (Z : ℝ) (hZ : 0 < Z) (hZdef : Z = ∑ i ∈ s, Real.exp (-(β * E i))) :
    ∑ i ∈ s, -((Real.exp (-(β * E i)) / Z) * Real.log (Real.exp (-(β * E i)) / Z))
      = Real.log Z + β * ∑ i ∈ s, (Real.exp (-(β * E i)) / Z) * E i := by
  have hnorm : ∑ i ∈ s, Real.exp (-(β * E i)) / Z = 1 := by
    rw [← Finset.sum_div, ← hZdef]
    field_simp
  have hterm : ∀ i ∈ s, -((Real.exp (-(β * E i)) / Z) * Real.log (Real.exp (-(β * E i)) / Z))
      = (Real.exp (-(β * E i)) / Z) * Real.log Z
        + β * ((Real.exp (-(β * E i)) / Z) * E i) := by
    intro i _
    rw [Real.log_div (Real.exp_ne_zero _) (ne_of_gt hZ), Real.log_exp]
    ring
  rw [Finset.sum_congr rfl hterm, Finset.sum_add_distrib, ← Finset.sum_mul, hnorm, one_mul,
    ← Finset.mul_sum]

/-- **The Boltzmann distribution is the maximum-entropy distribution at fixed mean
    energy** -- the statement `physics/entropy.md` line 8 asserts and its Lagrange
    multipliers only make stationary. Any probability vector `p` with the same mean
    energy has entropy at most `log Z + β⟨E⟩`.

    Hypotheses named rather than assumed: `p` positive and normalized, and
    `h_energy` fixing the mean energy to the Boltzmann value. `β` is unconstrained in
    sign, so this covers negative temperatures too. -/
theorem boltzmann_maximizes {ι : Type*} (s : Finset ι) (β : ℝ) (E : ι → ℝ)
    (Z : ℝ) (hZ : 0 < Z) (hZdef : Z = ∑ i ∈ s, Real.exp (-(β * E i)))
    (p : ι → ℝ) (hp : ∀ i ∈ s, 0 < p i) (hps : ∑ i ∈ s, p i = 1)
    (h_energy : ∑ i ∈ s, p i * E i = ∑ i ∈ s, (Real.exp (-(β * E i)) / Z) * E i) :
    ∑ i ∈ s, -(p i * Real.log (p i))
      ≤ Real.log Z + β * ∑ i ∈ s, (Real.exp (-(β * E i)) / Z) * E i := by
  set w : ι → ℝ := fun i => Real.exp (-(β * E i)) / Z with hw
  have hwpos : ∀ i ∈ s, 0 < w i := fun i _ => div_pos (Real.exp_pos _) hZ
  have hwsum : ∑ i ∈ s, w i = 1 := by
    rw [hw]
    simp only
    rw [← Finset.sum_div, ← hZdef]
    field_simp
  have hG := gibbs_nonneg s p w hp hwpos hps hwsum
  have hrw : ∀ i ∈ s, p i * Real.log (p i / w i)
      = p i * Real.log (p i) + p i * Real.log Z + β * (p i * E i) := by
    intro i hi
    have hpi := hp i hi
    have hwi := hwpos i hi
    rw [Real.log_div (ne_of_gt hpi) (ne_of_gt hwi)]
    have : Real.log (w i) = -(β * E i) - Real.log Z := by
      rw [hw]
      simp only
      rw [Real.log_div (Real.exp_ne_zero _) (ne_of_gt hZ), Real.log_exp]
    rw [this]
    ring
  rw [Finset.sum_congr rfl hrw] at hG
  rw [Finset.sum_add_distrib, Finset.sum_add_distrib, ← Finset.sum_mul, hps, one_mul,
    ← Finset.mul_sum, h_energy] at hG
  have hneg : ∑ i ∈ s, -(p i * Real.log (p i)) = -∑ i ∈ s, p i * Real.log (p i) := by
    simp [Finset.sum_neg_distrib]
  rw [hneg]
  linarith

/-! ## 4. The two-point case, stated explicitly

The wing's smallest instance, and the one `crypto/fhe.md` lives in: one bit. -/

/-- **Binary entropy is bounded by `log 2`**: `h(p) = -p log p - (1-p) log(1-p) ≤ log 2`
    on `0 < p < 1`. Proved directly from `Real.log_le_sub_one_of_pos` rather than via
    the general Gibbs inequality, so that this section stands alone. -/
theorem binary_entropy_le_log_two {p : ℝ} (h0 : 0 < p) (h1 : p < 1) :
    -(p * Real.log p) - ((1 - p) * Real.log (1 - p)) ≤ Real.log 2 := by
  have hq : 0 < 1 - p := by linarith
  have hA : Real.log (1 / (2 * p)) ≤ 1 / (2 * p) - 1 :=
    Real.log_le_sub_one_of_pos (by positivity)
  have hB : Real.log (1 / (2 * (1 - p))) ≤ 1 / (2 * (1 - p)) - 1 :=
    Real.log_le_sub_one_of_pos (by positivity)
  have hAe : Real.log (1 / (2 * p)) = -(Real.log 2 + Real.log p) := by
    rw [Real.log_div one_ne_zero (by positivity), Real.log_one,
      Real.log_mul (by norm_num) (ne_of_gt h0)]
    ring
  have hBe : Real.log (1 / (2 * (1 - p))) = -(Real.log 2 + Real.log (1 - p)) := by
    rw [Real.log_div one_ne_zero (by positivity), Real.log_one,
      Real.log_mul (by norm_num) (ne_of_gt hq)]
    ring
  rw [hAe] at hA
  rw [hBe] at hB
  have h1' : p * (-(Real.log 2 + Real.log p)) ≤ p * (1 / (2 * p) - 1) :=
    mul_le_mul_of_nonneg_left hA (le_of_lt h0)
  have h2' : (1 - p) * (-(Real.log 2 + Real.log (1 - p)))
      ≤ (1 - p) * (1 / (2 * (1 - p)) - 1) :=
    mul_le_mul_of_nonneg_left hB (le_of_lt hq)
  have e1 : p * (1 / (2 * p) - 1) = 1 / 2 - p := by field_simp
  have e2 : (1 - p) * (1 / (2 * (1 - p)) - 1) = 1 / 2 - (1 - p) := by field_simp
  rw [e1] at h1'
  rw [e2] at h2'
  nlinarith [h1', h2']

/-- Equality at `p = 1/2`: the bound above is attained, so `log 2` really is the
    maximum and not merely an upper bound. One bit of entropy is exactly `log 2` nats,
    which is the constant Landauer's `kB T log 2` carries. -/
theorem binary_entropy_half :
    -((1 / 2 : ℝ) * Real.log (1 / 2)) - ((1 - 1 / 2) * Real.log (1 - 1 / 2))
      = Real.log 2 := by
  have h : Real.log ((1 : ℝ) / 2) = -Real.log 2 := by
    rw [Real.log_div one_ne_zero (by norm_num), Real.log_one]
    ring
  rw [show (1 : ℝ) - 1 / 2 = 1 / 2 by norm_num, h]
  ring

end Toesnail.InfoWing
