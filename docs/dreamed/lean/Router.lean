/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/zelegator-helferli.md`, which is
  about TWO OTHER REPOSITORIES (`~/src/zelegator`, `~/src/helferli`) and is filed here only
  because the owner asked that this batch of dreaming land in toesnail.

  The essay's quantitative spine is information-theoretic, so the theorems are too. What is
  discharged here, and what deliberately is NOT:

    PROVED
      * `router_pigeonhole`      two distinct intents collide when intents outnumber tools
      * `router_mistakes_someone` a decode-after-route rule is wrong on at least one intent
      * `correct_card_le_tools`  at most `card Tool` intents can be routed correctly
      * `error_ge_of_card`       hence `P_e >= 1 - N/M` for a uniform intent prior
      * `uniform_entropy_eq_log_card`  the EQUALITY case of the channel bound
      * `logb_two_pow`, `bits_of_card_pow_two`  the `N = 2^k` bit-count corollary
      * `log_ten_between`        `3 log 2 < log 10 < 4 log 2`, the actual 10-tool number
      * `landauer_decision`      `log2(N) * (kB T log 2) = kB T log N`, with `T > 0` NAMED

    NOT PROVED, AND SAID SO PLAINLY
      * **Fano's inequality is NOT proved here.** `H(X | Y) <= H(P_e) + P_e log(|X| - 1)`
        needs conditional Shannon entropy over a joint distribution, which this file does
        not build. What IS proved is the counting bound the essay actually uses:
        `correct_card_le_tools` / `error_ge_of_card`. That bound is strictly weaker than
        Fano (it is cardinality-only, and says nothing about a router with ENOUGH outputs
        but a noisy channel), and the essay states the numerical Fano check as an
        arithmetic remark, not as a theorem. Do not read this file as containing Fano.
      * The channel bound `H(output) <= log2 N` is NOT reproved: it is
        `Toesnail.InfoWing.entropy_le_log_card` in the sibling file
        `docs/dreamed/lean/InfoWing.lean`, and the essay cites it there. This file proves
        the two things that file did not: the equality condition, and the `N = 2^k`
        bit-count corollary.
      * Nothing here is a claim about zelegator's CODE. A router is modelled as a bare
        function `Intent -> Tool`; no accuracy figure, latency, parameter count, or energy
        number in the essay is formalised, and none could be by a theorem.

  Notation map, Lean back to the essay:

    `Intent`   the classes a user can mean. `Fintype.card Intent = M` in the essay.
    `Tool`     zelegator's tool slots, `data/tools.yaml`. `Fintype.card Tool = N = 10`.
    `r`        the router, an arbitrary total function. No structure assumed: the bounds
               below hold for the voter, for a keyword table, for a 22M-parameter encoder,
               and for a coin.
    `dec`      the reader's decode of a tool back to an intent. Named so that "correct"
               has a meaning at all when the two carriers are different types.
    `kB, T, Q` Boltzmann constant, ambient temperature, heat. Same names as
               `InfoWing.landauer_heat`, whose `Q >= kB T log 2` this file scales by
               `log2 N` and does not re-derive.
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Base
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic

namespace Toesnail.Router

open Finset

/-! ## 1. The boundary of item 1, as a theorem

A router with `N` outputs is a function into an `N`-element type. Everything in this
section follows from that alone, so it applies to every routing scheme zelegator has or
could have, including one that is not a model at all. -/

variable {Intent Tool : Type*} [Fintype Intent] [Fintype Tool] [DecidableEq Intent]

omit [DecidableEq Intent] in
/-- **Pigeonhole for the router.** If there are strictly more intents than tools, some two
    distinct intents land on the same tool. The router cannot separate them, whatever it
    is made of. -/
theorem router_pigeonhole (r : Intent → Tool)
    (h : Fintype.card Tool < Fintype.card Intent) :
    ∃ i j : Intent, i ≠ j ∧ r i = r j :=
  Fintype.exists_ne_map_eq_of_card_lt r h

omit [DecidableEq Intent] in
/-- **A router with too few outputs is wrong about someone.** Given any decode `dec` of a
    tool back to an intent -- which is what "the router got it right" silently assumes --
    at least one intent is misread whenever tools are outnumbered. This is item 1's
    boundary: no accuracy improvement, training budget, or model size moves it. -/
theorem router_mistakes_someone (r : Intent → Tool) (dec : Tool → Intent)
    (h : Fintype.card Tool < Fintype.card Intent) :
    ∃ i : Intent, dec (r i) ≠ i := by
  by_contra hcon
  push Not at hcon
  have hinj : Function.Injective r := by
    intro a b hab
    have ha := hcon a
    have hb := hcon b
    rw [← ha, ← hb, hab]
  have := Fintype.card_le_of_injective r hinj
  omega

/-! ## 2. The counting bound the essay uses in place of Fano

Fano's inequality bounds the error probability below by the conditional entropy. It is the
right instrument and it is not proved here (see the header). The bound below is the
cardinality-only shadow of it: it is exact, it needs no probability measure to state, and
it is the one the essay's `P_e >= 1 - N/M` line actually rests on. -/

/-- **At most `card Tool` intents can be correct.** The intents on which decode-after-route
    is correct inject into the tools, so there are at most `N` of them. -/
theorem correct_card_le_tools (r : Intent → Tool) (dec : Tool → Intent) :
    (univ.filter (fun i : Intent => dec (r i) = i)).card ≤ Fintype.card Tool := by
  have hinj : ∀ a ∈ univ.filter (fun i : Intent => dec (r i) = i),
      ∀ b ∈ univ.filter (fun i : Intent => dec (r i) = i), r a = r b → a = b := by
    intro a ha b hb hab
    simp only [mem_filter] at ha hb
    rw [← ha.2, ← hb.2, hab]
  exact Finset.card_le_card_of_injOn r (fun a _ => mem_univ (r a)) hinj

/-- **The error floor.** With a uniform prior over `M = card Intent` intents, the accuracy
    of any decode-after-route rule is at most `N / M`, so the error probability is at least
    `1 - N / M`. Stated with the count on the left so no division by `M` is needed to read
    it: `correct <= N` means `M - correct >= M - N`.

    This is the honest, provable statement standing in for Fano. It is strictly weaker:
    it says nothing at all when `N >= M`, where Fano still bites. -/
theorem error_ge_of_card (r : Intent → Tool) (dec : Tool → Intent) :
    Fintype.card Intent - Fintype.card Tool
      ≤ Fintype.card Intent - (univ.filter (fun i : Intent => dec (r i) = i)).card := by
  have := correct_card_le_tools r dec
  omega

/-- The same floor as a real number, for the essay's `P_e` arithmetic. `M > 0` is NAMED
    because the statement divides by it. -/
theorem error_rate_ge (r : Intent → Tool) (dec : Tool → Intent)
    (hM : 0 < Fintype.card Intent) :
    1 - (Fintype.card Tool : ℝ) / (Fintype.card Intent : ℝ)
      ≤ 1 - ((univ.filter (fun i : Intent => dec (r i) = i)).card : ℝ)
            / (Fintype.card Intent : ℝ) := by
  have hMR : (0 : ℝ) < (Fintype.card Intent : ℝ) := by exact_mod_cast hM
  have hcard : ((univ.filter (fun i : Intent => dec (r i) = i)).card : ℝ)
      ≤ (Fintype.card Tool : ℝ) := by exact_mod_cast correct_card_le_tools r dec
  have hinv : (0 : ℝ) ≤ ((Fintype.card Intent : ℝ))⁻¹ := inv_nonneg.mpr hMR.le
  have key := mul_le_mul_of_nonneg_right hcard hinv
  simp only [div_eq_mul_inv]
  linarith

/-! ## 3. The channel bound, and the two things `InfoWing.lean` did not prove

`Toesnail.InfoWing.entropy_le_log_card` (`docs/dreamed/lean/InfoWing.lean`) already gives
`H(p) <= log |s|` for any probability vector on a finite set. Applied to the router's
OUTPUT distribution over `Tool`, that is exactly "a router with `N` outputs conveys at most
`log N` nats per query". It is cited, not reproved. What follows is the equality condition
and the bit-count corollary. -/

/-- **The equality condition.** The uniform distribution attains `log |s|` exactly, so the
    channel bound is a maximum and not merely an upper bound. Together with the cited
    `entropy_le_log_card`, this is "at most `log2 N` bits, with equality iff uniform" in
    its attainment half. -/
theorem uniform_entropy_eq_log_card {ι : Type*} (s : Finset ι) (hs : s.Nonempty) :
    ∑ _i ∈ s, -((1 / (s.card : ℝ)) * Real.log (1 / (s.card : ℝ))) = Real.log s.card := by
  have hcard : (0 : ℝ) < (s.card : ℝ) := by exact_mod_cast Finset.card_pos.mpr hs
  have hlog : Real.log (1 / (s.card : ℝ)) = -Real.log s.card := by
    rw [Real.log_div one_ne_zero (ne_of_gt hcard), Real.log_one]
    ring
  rw [Finset.sum_const, nsmul_eq_mul, hlog]
  field_simp

/-- `logb 2 (2 ^ k) = k`. The bookkeeping behind "bits". -/
theorem logb_two_pow (k : ℕ) : Real.logb 2 ((2 : ℝ) ^ k) = k := by
  have h : Real.log 2 ≠ 0 := ne_of_gt (Real.log_pos (by norm_num))
  rw [Real.logb, Real.log_pow]
  field_simp

/-- **The `N = 2^k` bit-count corollary.** A router whose tool set has exactly `2^k`
    members has a capacity of exactly `k` bits per query -- no rounding, no slack. With
    `k = 3` that is 8 tools; zelegator ships 10, which is why the next theorem is an
    inequality pair rather than an equality. -/
theorem bits_of_card_pow_two {ι : Type*} [Fintype ι] (k : ℕ)
    (h : Fintype.card ι = 2 ^ k) :
    Real.logb 2 (Fintype.card ι : ℝ) = k := by
  rw [h]
  push_cast
  exact logb_two_pow k

/-- **The actual 10-tool number, bracketed exactly.** `data/tools.yaml` ships ten tools, and
    `8 < 10 < 16` gives `3 < log2 10 < 4` with no numerical approximation anywhere: the
    router's per-query capacity is strictly between three and four bits. -/
theorem log_ten_between :
    3 * Real.log 2 < Real.log 10 ∧ Real.log 10 < 4 * Real.log 2 := by
  constructor
  · have h : Real.log ((2 : ℝ) ^ (3 : ℕ)) < Real.log 10 :=
      Real.log_lt_log (by positivity) (by norm_num)
    rwa [Real.log_pow] at h
  · have h : Real.log 10 < Real.log ((2 : ℝ) ^ (4 : ℕ)) :=
      Real.log_lt_log (by norm_num) (by norm_num)
    rwa [Real.log_pow] at h

/-- The same bracket in `logb` form, which is how the essay writes it. -/
theorem logb_ten_between : 3 < Real.logb 2 10 ∧ Real.logb 2 10 < 4 := by
  have hl2 : (0 : ℝ) < Real.log 2 := Real.log_pos (by norm_num)
  obtain ⟨hlo, hhi⟩ := log_ten_between
  constructor
  · rw [Real.logb, lt_div_iff₀ hl2]; linarith
  · rw [Real.logb, div_lt_iff₀ hl2]; linarith

/-! ## 4. Landauer for one routing decision

`InfoWing.landauer_heat` gives `kB T log 2 <= Q` for one erased bit, with the second law as
a NAMED hypothesis. That is cited, not re-derived. All that is added here is the scaling to
a whole routing decision, which is arithmetic -- and saying so is the point, because the
essay quotes the resulting joules figure and it must be traceable to exactly this. -/

/-- **The floor for one routing decision.** `log2 N` bits at `kB T log 2` each is
    `kB T log N`.

    `T > 0` and `N > 0` are NAMED although the proof does not consume them, and that gap is
    deliberate rather than sloppy: `Real.log` is a TOTAL function that returns `0` outside
    its mathematical domain, so the identity below happens to hold even at `N <= 0`, where
    it means nothing physically. The hypotheses record the domain on which the equation is
    a statement about heat rather than about Lean's junk value. Lean's linter flags them as
    unused; that warning is the correct report and the hypotheses stay. -/
theorem landauer_decision (kB T N : ℝ) (hT : 0 < T) (hN : 0 < N) :
    Real.logb 2 N * (kB * T * Real.log 2) = kB * T * Real.log N := by
  have hl2 : Real.log 2 ≠ 0 := ne_of_gt (Real.log_pos (by norm_num))
  rw [Real.logb]
  field_simp

/-- **The floor, chained to the second law rather than assumed.** If each of the `k` bits a
    decision erases obeys the Landauer bound `kB T log 2 <= q`, then the decision's total
    heat obeys `k * kB T log 2 <= Q`. Stated over `k : ℕ` bits with a per-bit heat `q` so
    that nothing is smuggled in: the physics is still entirely in `InfoWing.landauer_heat`,
    and this is the multiplication. `T > 0` is named for the same reason as above and is
    likewise not consumed -- the ordering does all the work once `h_bit` is granted. -/
theorem landauer_decision_bound (kB T q Q : ℝ) (k : ℕ) (hT : 0 < T)
    (h_bit : kB * T * Real.log 2 ≤ q) (h_total : Q = k * q) :
    (k : ℝ) * (kB * T * Real.log 2) ≤ Q := by
  rw [h_total]
  have hk : (0 : ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  exact mul_le_mul_of_nonneg_left h_bit hk

/-- **The 10-tool floor, bracketed.** With `T > 0` and `kB > 0`, one ten-way routing
    decision costs strictly more than three and strictly less than four bit-erasures'
    worth of heat. This is the theorem behind the essay's `9.54 zJ` at 300 K; the constants
    themselves are arithmetic the essay does, not a Lean claim. -/
theorem landauer_ten_between (kB T : ℝ) (hkB : 0 < kB) (hT : 0 < T) :
    3 * (kB * T * Real.log 2) < kB * T * Real.log 10 ∧
      kB * T * Real.log 10 < 4 * (kB * T * Real.log 2) := by
  have hpos : 0 < kB * T := mul_pos hkB hT
  obtain ⟨hlo, hhi⟩ := log_ten_between
  constructor
  · nlinarith [hlo, hpos]
  · nlinarith [hhi, hpos]

end Toesnail.Router
