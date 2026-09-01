/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/narrativium-formalized.md`, which
  asks whether "things happen because they make a good story" (`essays/Narrativium.md`,
  Pratchett's narrativium) has any formal content.

  The essay's answer is that the myth does NOT survive as a force, and that the piece of
  it which IS a theorem points the OPPOSITE way to the myth: a short description is
  available for only an exponentially small fraction of histories. This file discharges
  the four places where the essay makes a mathematical rather than a literary claim.

  Notation map, Lean back to the essay:

    `dec`          a decompressor: descriptions in, histories out. Deliberately an
                   ARBITRARY function, no computability assumption. A "story" is a
                   description; `dec` is the act of telling it back out in full.
    `Fin n → Bool` a history of `n` binary events. Not physics; a stand-in for a
                   discrete history, exactly as in `lean/InfoWing.lean`.
    `m`, `c`       a story of fewer than `m` bits, saving `c = n - m` bits over the
                   history it describes. `m + c = n` is stated additively so that
                   truncated `Nat` subtraction never appears.
    `a * x^2 + b*x + c`
                   an action `S` on a one-parameter family of histories `x`. The
                   stationary point is the classical path; this is the least-action
                   "preferred history" principle in the only case where it is finite
                   algebra rather than variational calculus.
    `Lm`, `Lcond`  the two parts of an MDL two-part code: model length, and data length
                   given the model. The essay's candidate rescue of the narrativium
                   identification ("a story is a short model with dramatic exceptions").

  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):
    - Kolmogorov complexity is NOT defined here, and its uncomputability is NOT proved.
      Section 1 is a counting bound over an arbitrary `dec`, valid with or without
      computability. The essay is explicit that the uncomputability half is cited.
    - `exists_incompressible` and `few_compressible` are NOT reproved. They live in the
      sibling `lean/InfoWing.lean`. Section 1 takes their content as the NAMED hypothesis
      `hD : Fintype.card D ≤ 2 ^ m` and proves the quantitative fraction bound those two
      do not state.
    - There is no path integral here and no `exp(i S / ħ)`. Section 2 is the stationary
      point of a real quadratic. Stationary phase proper needs oscillatory-integral
      asymptotics, which are not attempted, and the essay says so.
    - Maximum caliber is NOT formalised here. It is `entropy_le_log_card` in
      `lean/InfoWing.lean` with the index type read as trajectories instead of states,
      and reproving it here would be a copy. The essay states the reuse rather than
      duplicating the proof.
    - Nothing in this file is evidence for or against narrative causality being real.
      Section 1 bounds how many histories admit a short description. Whether the world
      selects such histories is not a mathematical question, and the essay argues it is
      not even an empirically decidable one as usually posed.
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic

namespace Toesnail.Narrativium

open Finset

/-! ## 1. Stories are rare: the quantitative incompressibility fraction

`lean/InfoWing.lean` proves that SOME length-`n` string escapes every decompressor
(`exists_incompressible`) and that the short descriptions are outnumbered
(`few_compressible`). Neither states the fraction. The fraction is what narrativium
needs, because the myth is a claim about which histories are TYPICAL, and the answer is
that a story-shaped history is exponentially atypical. -/

/-- The set of histories that the decompressor `dec` can actually produce, i.e. the ones
    that have a description at all in this code. Everything outside it is, in this code,
    unstoryable: no shorter account of it exists. -/
def storyable {n : ℕ} {D : Type*} [Fintype D] [DecidableEq (Fin n → Bool)]
    (dec : D → (Fin n → Bool)) : Finset (Fin n → Bool) :=
  Finset.univ.image dec

/-- The count of storyable histories is bounded by the number of descriptions, which is
    the only fact about `dec` this section ever uses. -/
theorem card_storyable_le {n : ℕ} {D : Type*} [Fintype D] [DecidableEq (Fin n → Bool)]
    (dec : D → (Fin n → Bool)) : (storyable dec).card ≤ Fintype.card D := by
  unfold storyable
  calc (Finset.univ.image dec).card ≤ (Finset.univ : Finset D).card := Finset.card_image_le
    _ = Fintype.card D := Finset.card_univ

/-- **The exponential story bound** (essay handle `nrare`).

    If the descriptions number at most `2 ^ m` and histories have length `n = m + c`,
    then the fraction of histories admitting a description is at most `2 ^ (-c)`.

    This is the sharpened form the sibling file does not state, and it is the whole
    mathematical content of narrativium, pointing the opposite way to the myth: saving
    `c` bits is possible for at most one history in `2 ^ c`. Ten bits of narrative
    economy already restricts you to one history in a thousand.

    `hD` is the counting bound proved as `card_short_descriptions` /
    `few_compressible` in `lean/InfoWing.lean`; it is a named hypothesis here rather
    than a duplicated proof. -/
theorem story_fraction (m c n : ℕ) (hmc : m + c = n)
    {D : Type*} [Fintype D] [DecidableEq (Fin n → Bool)]
    (hD : Fintype.card D ≤ 2 ^ m) (dec : D → (Fin n → Bool)) :
    ((storyable dec).card : ℝ) / 2 ^ n ≤ 1 / 2 ^ c := by
  have hnat : (storyable dec).card ≤ 2 ^ m := le_trans (card_storyable_le dec) hD
  have hreal : ((storyable dec).card : ℝ) ≤ 2 ^ m := by exact_mod_cast hnat
  have hpow : ((2 : ℝ)) ^ n = 2 ^ m * 2 ^ c := by rw [← pow_add, hmc]
  have hm : (0 : ℝ) < 2 ^ m := by positivity
  have hc : (0 : ℝ) < 2 ^ c := by positivity
  have hrw : (1 : ℝ) / 2 ^ c = 2 ^ m / (2 ^ m * 2 ^ c) := by
    field_simp
  rw [hpow, hrw]
  gcongr

/-- The same bound read as a count rather than a fraction: at most `2 ^ n / 2 ^ c` of
    the `2 ^ n` histories are storyable. Stated multiplicatively so no division and no
    truncated subtraction appears. -/
theorem story_count (m c n : ℕ) (hmc : m + c = n)
    {D : Type*} [Fintype D] [DecidableEq (Fin n → Bool)]
    (hD : Fintype.card D ≤ 2 ^ m) (dec : D → (Fin n → Bool)) :
    (storyable dec).card * 2 ^ c ≤ 2 ^ n := by
  have hnat : (storyable dec).card ≤ 2 ^ m := le_trans (card_storyable_le dec) hD
  calc (storyable dec).card * 2 ^ c ≤ 2 ^ m * 2 ^ c :=
        Nat.mul_le_mul_right _ hnat
    _ = 2 ^ n := by rw [← pow_add, hmc]

/-! ## 2. The honest "preferred history" principle: stationarity, not narrative

Physics already selects histories, by an EXTREMAL principle. On a one-parameter family
of histories with quadratic action there is exactly one stationary path, it is available
in closed form, and it is a minimum exactly when the quadratic coefficient is positive.
Nothing teleological survives the algebra. -/

/-- The derivative of a quadratic action, stated with a `HasDerivAt` witness rather than
    `deriv` (house convention: `deriv` is junk-on-failure and would silently model a
    false claim). -/
theorem hasDerivAt_action (a b c x : ℝ) :
    HasDerivAt (fun y : ℝ => a * y ^ 2 + b * y + c) (2 * a * x + b) x := by
  have h1 : HasDerivAt (fun y : ℝ => y ^ 2) (2 * x) x := by
    simpa using hasDerivAt_pow 2 x
  have h2 : HasDerivAt (fun y : ℝ => a * y ^ 2) (a * (2 * x)) x := h1.const_mul a
  have h3 : HasDerivAt (fun y : ℝ => b * y) (b * 1) x := (hasDerivAt_id x).const_mul b
  have h4 := (h2.add h3).add_const c
  convert h4 using 1
  ring

/-- **The classical path is unique** (essay handle `nstat`). For `a ≠ 0` the action
    `S(x) = a x² + b x + c` is stationary at exactly one history, `x = -b/(2a)`.
    Uniqueness is the `↔`: no second stationary path exists to compete for the role. -/
theorem action_stationary_iff (a b c x : ℝ) (ha : a ≠ 0) :
    HasDerivAt (fun y : ℝ => a * y ^ 2 + b * y + c) 0 x ↔ x = -b / (2 * a) := by
  have h2a : (2 : ℝ) * a ≠ 0 := by
    simpa using mul_ne_zero (two_ne_zero) ha
  constructor
  · intro h
    have h0 : (0 : ℝ) = 2 * a * x + b := h.unique (hasDerivAt_action a b c x)
    field_simp
    linarith
  · intro hx
    subst hx
    have h := hasDerivAt_action a b c (-b / (2 * a))
    convert h using 1
    field_simp
    ring

/-- Completing the square: the action is its stationary value plus `a` times a square.
    Every later statement about minima is this identity read twice. -/
theorem action_shift (a b c x : ℝ) (ha : a ≠ 0) :
    a * x ^ 2 + b * x + c
      = a * (x + b / (2 * a)) ^ 2
        + (a * (-b / (2 * a)) ^ 2 + b * (-b / (2 * a)) + c) := by
  field_simp
  ring

/-- **The stationary path is the minimum exactly when `a > 0`** (essay handle `nmin`).

    The `↔` is the point: extremal is not the same as minimal, so "the universe prefers
    this history" already needs a sign condition before it means anything at all. For
    `a < 0` the same unique stationary path is the WORST history in the family. -/
theorem action_min_iff (a b c : ℝ) (ha : a ≠ 0) :
    (∀ x : ℝ, a * (-b / (2 * a)) ^ 2 + b * (-b / (2 * a)) + c ≤ a * x ^ 2 + b * x + c)
      ↔ 0 < a := by
  constructor
  · intro h
    have hx := h (-b / (2 * a) + 1)
    rw [action_shift a b c (-b / (2 * a) + 1) ha] at hx
    have hsq : (-b / (2 * a) + 1 + b / (2 * a)) = 1 := by ring
    rw [hsq] at hx
    have h0 : 0 ≤ a := by nlinarith [hx]
    exact lt_of_le_of_ne h0 (Ne.symm ha)
  · intro hpos x
    rw [action_shift a b c x ha]
    nlinarith [sq_nonneg (x + b / (2 * a)), hpos]

/-! ## 3. The two-part code, and how little it buys

The essay's candidate rescue of "a good story is a short story" is MDL's two-part code:
a story is a short MODEL plus a few dramatic exceptions. The two facts below are
bookkeeping, deliberately: their whole point is that the rescue is bookkeeping. -/

variable {Model Data : Type*}

/-- The best two-part description length of `d`: minimise model length plus conditional
    length over all models. `Nonempty Model` because there is always at least the null
    model ("no story, just the events"). -/
noncomputable def bestTwoPart [Fintype Model] [Nonempty Model]
    (Lm : Model → ℕ) (Lcond : Model → Data → ℕ) (d : Data) : ℕ :=
  Finset.univ.inf' Finset.univ_nonempty (fun m => Lm m + Lcond m d)

/-- Any particular model is an upper bound: choosing a story never beats the best story. -/
theorem bestTwoPart_le [Fintype Model] [Nonempty Model]
    (Lm : Model → ℕ) (Lcond : Model → Data → ℕ) (m₀ : Model) (d : Data) :
    bestTwoPart Lm Lcond d ≤ Lm m₀ + Lcond m₀ d :=
  Finset.inf'_le _ (Finset.mem_univ m₀)

/-- **The rescue is bounded** (essay handle `ntwo`). If some model `m₀` is the null model,
    whose conditional code is just a given one-part code `L1`, then the two-part optimum
    beats nothing: it is at worst `L1 d` plus the null model's own length, and at best it
    is a genuine saving that the one-part code could have had by concatenation anyway.

    Read back: allowing "a short rule with exceptions" cannot rescue a claim that stories
    are short, because the exception list is charged at full price by `Lcond`. -/
theorem twopart_rescue_bounded [Fintype Model] [Nonempty Model]
    (Lm : Model → ℕ) (Lcond : Model → Data → ℕ) (L1 : Data → ℕ)
    (m₀ : Model) (hnull : ∀ d, Lcond m₀ d = L1 d) (d : Data) :
    bestTwoPart Lm Lcond d ≤ Lm m₀ + L1 d := by
  have := bestTwoPart_le Lm Lcond m₀ d
  rwa [hnull d] at this

/-- **Every two-part description pays for its model in full.** The optimum is attained at
    some actual model, and the model's length is part of the bill. There is no free
    narrative frame. -/
theorem bestTwoPart_pays_a_model [Fintype Model] [Nonempty Model]
    (Lm : Model → ℕ) (Lcond : Model → Data → ℕ) (d : Data) :
    ∃ m : Model, bestTwoPart Lm Lcond d = Lm m + Lcond m d ∧ Lm m ≤ bestTwoPart Lm Lcond d := by
  obtain ⟨m, -, hm⟩ :=
    Finset.exists_mem_eq_inf' (Finset.univ_nonempty (α := Model)) (fun m => Lm m + Lcond m d)
  have hb : bestTwoPart Lm Lcond d = Lm m + Lcond m d := hm
  refine ⟨m, hb, ?_⟩
  rw [hb]
  exact Nat.le_add_right _ _

/-! ## 4. The sharpest objection, in one line each

A good story is not a short story. A million-to-one chance coming off is a HIGH-surprisal
event, and surprisal is exactly what a Shannon code charges for. -/

/-- **Rarer means longer** (essay handle `nsurp`). Surprisal `-log p` is strictly
    decreasing in `p`, so the dramatic coincidence costs MORE description length, not
    less. This is the objection that breaks the simplicity-prior identification, and it
    is one `log` monotonicity away from trivial. -/
theorem surprisal_antitone {p q : ℝ} (hp : 0 < p) (hpq : p < q) :
    -Real.log q < -Real.log p := by
  have h := Real.log_lt_log hp hpq
  linarith

/-- A million-to-one chance costs between 19 and 20 bits to record. Exact, and stated in
    `ℕ` so no floating point or logarithm enters: `2^19 < 10^6 < 2^20`. The narrativium
    slogan says such events are common; the code says each one lengthens the history's
    description by about twenty bits. -/
theorem million_to_one_bits : 2 ^ 19 < 1000000 ∧ (1000000 : ℕ) < 2 ^ 20 := by
  constructor <;> norm_num

end Toesnail.Narrativium
