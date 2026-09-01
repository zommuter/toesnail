/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/why-three-plus-one.md` (session of 2026-09-01,
  owner-authorised speculation, on the owner's own condition that every RESULT be
  sound). The essay speculates; this file may not. Everything here is either proved
  or absent.

  Four clusters.

  1. `Veff`, `VeffFirst`, `VeffSecond`, `veffSecond_at_stationary`  (handle `ehrenfest`)
     THE result. For the effective radial potential of a `1/r^(d-1)` central force in
     `d = q + 3` spatial dimensions,

         V_eff(r) = L^2/(2 m r^2) - k / r^(d-2),

     at ANY stationary radius the second derivative equals `(4 - d) L^2 / (m r^4)`.
     One line, exact, and it decides the whole Ehrenfest argument: positive (stable)
     iff `d < 4`. Corollaries give `d = 3` stable with its explicit radius `L^2/(k m)`,
     `d = 4` marginal AND only stationary at all when `L^2 = 2 k m`, and `d >= 5`
     unstable with the explicit `d = 5` radius `3 k m / L^2`.

  2. `sphereArea`, `gauss_field_magnitude`, `hasDerivAt_coulomb`  (handle `gauss`)
     Flux conservation through the `(d-1)`-sphere gives `|F| ~ r^(1-d)`, and that is
     exactly `-V'` for `V = -k/r^(d-2)`. The dimension-dependent constant
     `2 pi^(d/2) / Gamma(d/2)` is left ABSTRACT as `S`: only the `r` dependence is
     claimed, and `gauss_matches_coulomb` says precisely which constant matches which.

  3. `SharpHuygens`  (handle `huygens-parity`)
     The sharp-Huygens condition as a decidable predicate on `d`: `d % 2 = 1 AND
     3 <= d`. `d = 1` FAILS it, which is the whole content of the sibling essay
     `docs/dreamed/wirohsh-ladder.md` §2(a). `three_unique` pins the intersection with
     cluster 1: `d = 3` is the only dimension that is both stable-orbit-admitting
     (`d <= 3`) and sharp-Huygens.

  4. `PDEClass`, `pdeClass`  (handle `signature`)
     Tegmark's Figure 1 classification as ARITHMETIC on the signature counts `(n, m)`
     only. NO well-posedness claim is made or attempted; the link from
     `ultrahyperbolic` to "ill-posed initial value problem" is Asgeirsson's theorem
     and lives in the prose, not here.

  NOT proved here, and deliberately: that `Nharm`-style harmonic counts, the quantum
  Coulomb spectrum, Asgeirsson's theorem, and the wave-equation tail are what the
  essay says they are. Those rest on cited literature and on SymPy, and the essay
  says so at each point.

  Identifier mapping (house convention, `verify/Resogram.lean`): a derivative is
  `<f>_<var>`; here the radial derivatives of `Veff` are named `VeffFirst` /
  `VeffSecond` because they are DEFINITIONS carrying the essay's displayed formulas,
  not derivative witnesses. The witnesses are the `hasDerivAt_*` theorems, and every
  derivative statement in this file is a `HasDerivAt` (Mathlib `deriv` is
  junk-on-failure: it returns `0` off-domain and would silently model a false claim).
-/
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Algebra.Ring.Parity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace Dimensionality

/-! ## 0. One derivative helper

Everything below is built from `d/dr (1 / r^(n+1)) = -(n+1) / r^(n+2)`. Exponents are
written `n+1` / `n+2` so that no truncated `Nat` subtraction ever appears. -/

private lemma hasDerivAt_one_div_pow (n : ℕ) {r : ℝ} (hr : r ≠ 0) :
    HasDerivAt (fun x : ℝ => 1 / x ^ (n + 1)) (-((n : ℝ) + 1) / r ^ (n + 2)) r := by
  have hp : HasDerivAt (fun x : ℝ => x ^ (n + 1)) (((n : ℝ) + 1) * r ^ n) r := by
    simpa using hasDerivAt_pow (n + 1) r
  have h2 := hp.inv (pow_ne_zero _ hr)
  have heq : -(((n : ℝ) + 1) * r ^ n) / (r ^ (n + 1)) ^ 2 = -((n : ℝ) + 1) / r ^ (n + 2) := by
    field_simp
    ring
  rw [heq] at h2
  simpa [one_div] using h2

/-! ## 1. Ehrenfest 1917 (handle `ehrenfest`)

Spatial dimension is `d = q + 3` with `q : ℕ`, so the Gauss-law potential exponent is
`d - 2 = q + 1` and the force exponent is `d - 1 = q + 2`. This parametrisation is what
keeps every exponent a genuine `Nat` sum; `q = 0` is `d = 3`. -/

/-- The effective radial potential, `V_eff(r) = L^2/(2 m r^2) - k/r^(d-2)` with
`d = q + 3`. `L` is angular momentum, `m` reduced mass, `k > 0` the attractive
coupling. -/
noncomputable def Veff (L m k : ℝ) (q : ℕ) (r : ℝ) : ℝ :=
  L ^ 2 / (2 * m * r ^ 2) - k / r ^ (q + 1)

/-- `V_eff'(r) = -L^2/(m r^3) + (d-2) k / r^(d-1)`. -/
noncomputable def VeffFirst (L m k : ℝ) (q : ℕ) (r : ℝ) : ℝ :=
  -(L ^ 2) / (m * r ^ 3) + k * ((q : ℝ) + 1) / r ^ (q + 2)

/-- `V_eff''(r) = 3 L^2/(m r^4) - (d-2)(d-1) k / r^d`. -/
noncomputable def VeffSecond (L m k : ℝ) (q : ℕ) (r : ℝ) : ℝ :=
  3 * L ^ 2 / (m * r ^ 4) - k * ((q : ℝ) + 1) * ((q : ℝ) + 2) / r ^ (q + 3)

theorem hasDerivAt_Veff (L m k : ℝ) (q : ℕ) {r : ℝ} (hr : r ≠ 0) :
    HasDerivAt (Veff L m k q) (VeffFirst L m k q r) r := by
  have hfun : Veff L m k q
      = fun x : ℝ => L ^ 2 / (2 * m) * (1 / x ^ (1 + 1)) - k * (1 / x ^ (q + 1)) := by
    funext x
    simp only [Veff]
    ring
  have h1 := (hasDerivAt_one_div_pow 1 hr).const_mul (L ^ 2 / (2 * m))
  have h2 := (hasDerivAt_one_div_pow q hr).const_mul k
  rw [hfun]
  have h := h1.sub h2
  convert h using 1
  rw [VeffFirst]
  field_simp
  ring

theorem hasDerivAt_VeffFirst (L m k : ℝ) (q : ℕ) {r : ℝ} (hr : r ≠ 0) :
    HasDerivAt (VeffFirst L m k q) (VeffSecond L m k q r) r := by
  have hfun : VeffFirst L m k q
      = fun x : ℝ => -(L ^ 2) / m * (1 / x ^ (2 + 1)) + k * ((q : ℝ) + 1) * (1 / x ^ (q + 1 + 1)) := by
    funext x
    simp only [VeffFirst]
    ring
  have h1 := (hasDerivAt_one_div_pow 2 hr).const_mul (-(L ^ 2) / m)
  have h2 := (hasDerivAt_one_div_pow (q + 1) hr).const_mul (k * ((q : ℝ) + 1))
  rw [hfun]
  have h := h1.add h2
  convert h using 1
  rw [VeffSecond]
  push_cast
  field_simp
  ring

/-- **The Ehrenfest identity.** At ANY stationary radius of the effective potential,

    `V_eff''(r0) = (4 - d) * L^2 / (m * r0^4)`,   `d = q + 3`.

Every dependence on the coupling `k` has cancelled: the sign is decided by `d` alone.
`m > 0` and `r0 > 0` are NAMED hypotheses; no positivity of `L` or `k` is needed. -/
theorem veffSecond_at_stationary (L m k : ℝ) (q : ℕ) {r : ℝ} (hr : 0 < r) (hm : 0 < m)
    (hstat : VeffFirst L m k q r = 0) :
    VeffSecond L m k q r = (1 - (q : ℝ)) * L ^ 2 / (m * r ^ 4) := by
  have hr' : r ≠ 0 := ne_of_gt hr
  have hm' : m ≠ 0 := ne_of_gt hm
  have h1 : k * ((q : ℝ) + 1) / r ^ (q + 2) = L ^ 2 / (m * r ^ 3) := by
    rw [VeffFirst, neg_div] at hstat
    linarith
  have h2 : k * ((q : ℝ) + 1) / r ^ (q + 3) = L ^ 2 / (m * r ^ 4) := by
    have hpow : r ^ (q + 3) = r ^ (q + 2) * r := by ring
    rw [hpow, ← div_div, h1, div_div]
    ring_nf
  have h3 : k * ((q : ℝ) + 1) * ((q : ℝ) + 2) / r ^ (q + 3)
      = ((q : ℝ) + 2) * (L ^ 2 / (m * r ^ 4)) := by
    rw [show k * ((q : ℝ) + 1) * ((q : ℝ) + 2) / r ^ (q + 3)
        = ((q : ℝ) + 2) * (k * ((q : ℝ) + 1) / r ^ (q + 3)) by ring, h2]
  rw [VeffSecond, h3]
  field_simp
  ring

/-- Stationarity with the denominators cleared. Used to exhibit the stationary radius
in each dimension without carrying a division. -/
theorem veffFirst_eq_zero_iff (L m k : ℝ) (q : ℕ) {r : ℝ} (hr : 0 < r) (hm : 0 < m) :
    VeffFirst L m k q r = 0
      ↔ L ^ 2 * r ^ (q + 2) = k * ((q : ℝ) + 1) * (m * r ^ 3) := by
  have hr' : r ≠ 0 := ne_of_gt hr
  have h1 : r ^ (q + 2) ≠ 0 := pow_ne_zero _ hr'
  have h2 : m * r ^ 3 ≠ 0 := ne_of_gt (mul_pos hm (pow_pos hr 3))
  rw [VeffFirst, neg_div, neg_add_eq_zero, div_eq_div_iff h2 h1]

/-- `d = 3` (`q = 0`): the stationary radius is `r0 = L^2 / (k m)`, written as
`k m r0 = L^2`. Checked, not assumed. -/
theorem stationary_radius_dim_three (L m k r : ℝ) (hr : 0 < r) (hm : 0 < m)
    (hkey : k * m * r = L ^ 2) : VeffFirst L m k 0 r = 0 := by
  rw [veffFirst_eq_zero_iff L m k 0 hr hm]
  push_cast
  linear_combination (-r ^ 2) * hkey

/-- `d = 3` is STABLE: at a stationary radius, `V_eff'' = L^2/(m r^4) > 0`. -/
theorem stable_dim_three (L m k : ℝ) {r : ℝ} (hr : 0 < r) (hm : 0 < m) (hL : L ≠ 0)
    (hstat : VeffFirst L m k 0 r = 0) : 0 < VeffSecond L m k 0 r := by
  rw [veffSecond_at_stationary L m k 0 hr hm hstat, Nat.cast_zero, sub_zero, one_mul]
  have hL2 : 0 < L ^ 2 := lt_of_le_of_ne (sq_nonneg L) (Ne.symm (pow_ne_zero 2 hL))
  exact div_pos hL2 (mul_pos hm (pow_pos hr 4))

/-- `d = 4` (`q = 1`) is MARGINAL: the second derivative vanishes identically at any
stationary radius. The centrifugal barrier and the attraction scale the same way. -/
theorem marginal_dim_four (L m k : ℝ) {r : ℝ} (hr : 0 < r) (hm : 0 < m)
    (hstat : VeffFirst L m k 1 r = 0) : VeffSecond L m k 1 r = 0 := by
  rw [veffSecond_at_stationary L m k 1 hr hm hstat]
  push_cast
  ring

/-- `d = 4` is worse than marginal: a stationary radius exists at all only on the
measure-zero locus `L^2 = 2 k m`, and then EVERY radius is stationary. -/
theorem dim_four_stationary_forces (L m k : ℝ) {r : ℝ} (hr : 0 < r) (hm : 0 < m)
    (hstat : VeffFirst L m k 1 r = 0) : L ^ 2 = 2 * k * m := by
  rw [veffFirst_eq_zero_iff L m k 1 hr hm] at hstat
  push_cast at hstat
  have h2 : r ^ 3 * (L ^ 2 - 2 * k * m) = 0 := by linear_combination hstat
  have h3 : r ^ 3 ≠ 0 := ne_of_gt (pow_pos hr 3)
  rcases mul_eq_zero.mp h2 with h | h
  · exact absurd h h3
  · linarith

/-- `d >= 5` (`q >= 2`) is UNSTABLE: at any stationary radius the second derivative is
strictly negative, so the circular orbit is a maximum of `V_eff`. -/
theorem unstable_dim_ge_five (L m k : ℝ) (q : ℕ) (hq : 2 ≤ q) {r : ℝ} (hr : 0 < r)
    (hm : 0 < m) (hL : L ≠ 0) (hstat : VeffFirst L m k q r = 0) :
    VeffSecond L m k q r < 0 := by
  rw [veffSecond_at_stationary L m k q hr hm hstat]
  have hL2 : 0 < L ^ 2 := lt_of_le_of_ne (sq_nonneg L) (Ne.symm (pow_ne_zero 2 hL))
  have hmr : 0 < m * r ^ 4 := mul_pos hm (pow_pos hr 4)
  have hqr : (1 : ℝ) - (q : ℝ) < 0 := by
    have : (2 : ℝ) ≤ (q : ℝ) := by exact_mod_cast hq
    linarith
  have : (1 - (q : ℝ)) * L ^ 2 < 0 := mul_neg_of_neg_of_pos hqr hL2
  exact div_neg_of_neg_of_pos this hmr

/-- `d = 5` (`q = 2`): the stationary radius exists and is `r0 = 3 k m / L^2`, written
as `L^2 r0 = 3 k m`. So `unstable_dim_ge_five` is not vacuous. -/
theorem stationary_radius_dim_five (L m k r : ℝ) (hr : 0 < r) (hm : 0 < m)
    (hkey : L ^ 2 * r = 3 * k * m) : VeffFirst L m k 2 r = 0 := by
  rw [veffFirst_eq_zero_iff L m k 2 hr hm]
  push_cast
  linear_combination (r ^ 3) * hkey

/-- `d = 6` (`q = 3`): stationary radius `r0 = 2 sqrt(k m) / L`, written here in the
squared form `L^2 r0^2 = 4 k m` to avoid a square root. -/
theorem stationary_radius_dim_six (L m k r : ℝ) (hr : 0 < r) (hm : 0 < m)
    (hsq : L ^ 2 * r ^ 2 = 4 * k * m) : VeffFirst L m k 3 r = 0 := by
  rw [veffFirst_eq_zero_iff L m k 3 hr hm]
  push_cast
  linear_combination (r ^ 3) * hsq

/-! ## 2. The Gauss-law origin of the exponent (handle `gauss`)

The `(d-1)`-sphere of radius `r` in `d = q+3` spatial dimensions has area
`2 pi^(d/2) / Gamma(d/2) * r^(d-1)`. The constant is DROPPED (kept abstract as `S`):
only the `r` dependence is claimed here, because only the `r` dependence enters
cluster 1. Nothing below computes a Gamma function. -/

/-- Area of the sphere of radius `r` in `d = q + 3` spatial dimensions, with the
dimension constant `2 pi^(d/2)/Gamma(d/2)` abstracted to `S`. -/
noncomputable def sphereArea (S : ℝ) (q : ℕ) (r : ℝ) : ℝ := S * r ^ (q + 2)

/-- Flux conservation: a radial field whose flux through every sphere is the same `Q`
has magnitude proportional to `r^(1-d)`. -/
theorem gauss_field_magnitude (S Q F : ℝ) (q : ℕ) {r : ℝ} (hr : 0 < r) (hS : S ≠ 0)
    (hflux : F * sphereArea S q r = Q) : F = Q / S * (1 / r ^ (q + 2)) := by
  have hr' : r ≠ 0 := ne_of_gt hr
  have hp : r ^ (q + 2) ≠ 0 := pow_ne_zero _ hr'
  rw [sphereArea] at hflux
  field_simp
  linarith [hflux]

/-- The Coulomb potential `V = -k/r^(d-2)` has `-V'(r) = -(d-2) k / r^(d-1)`: the
attraction, with exactly the Gauss-law exponent. -/
theorem hasDerivAt_coulomb (k : ℝ) (q : ℕ) {r : ℝ} (hr : r ≠ 0) :
    HasDerivAt (fun x : ℝ => -k / x ^ (q + 1)) (k * ((q : ℝ) + 1) / r ^ (q + 2)) r := by
  have h := (hasDerivAt_one_div_pow q hr).const_mul (-k)
  have hfun : (fun x : ℝ => -k / x ^ (q + 1)) = fun x : ℝ => -k * (1 / x ^ (q + 1)) := by
    funext x; rw [mul_one_div]
  rw [hfun]
  convert h using 1
  field_simp

/-- Which constant matches which: the Gauss-law magnitude and the Coulomb magnitude
agree at every radius exactly when `Q/S = (d-2) k`. This is the whole content of
"the inverse-square law IS the `d = 3` Gauss law", with the constants named. -/
theorem gauss_matches_coulomb (S Q k : ℝ) (q : ℕ) {r : ℝ} (hr : 0 < r) :
    Q / S * (1 / r ^ (q + 2)) = k * ((q : ℝ) + 1) / r ^ (q + 2) ↔ Q / S = k * ((q : ℝ) + 1) := by
  have hr' : r ≠ 0 := ne_of_gt hr
  have hp : r ^ (q + 2) ≠ 0 := pow_ne_zero _ hr'
  rw [mul_one_div, div_eq_div_iff hp hp]
  constructor
  · intro h
    have := mul_right_cancel₀ hp h
    exact this
  · intro h; rw [h]

/-! ## 3. Sharp Huygens as arithmetic (handle `huygens-parity`)

The sharp-Huygens condition for the flat wave equation. The `3 <= d` clause is NOT
decoration: `d = 1` is odd and is NOT sharp-Huygens (d'Alembert's initial-velocity
term integrates over the whole interval), which is the separator the sibling essay
`docs/dreamed/wirohsh-ladder.md` §2(a) used to refute the identification of the
WiRoHSH ladder's parity with Huygens' principle. Nothing here proves the analytic
fact; it fixes the PREDICATE, exactly, including its exception. -/

/-- `d` admits sharp Huygens for the flat wave equation: `d` odd AND `d >= 3`. -/
def SharpHuygens (d : ℕ) : Prop := d % 2 = 1 ∧ 3 ≤ d

instance decidableSharpHuygens (d : ℕ) : Decidable (SharpHuygens d) :=
  inferInstanceAs (Decidable (d % 2 = 1 ∧ 3 ≤ d))

theorem sharpHuygens_three : SharpHuygens 3 := by decide
theorem sharpHuygens_five : SharpHuygens 5 := by decide
theorem not_sharpHuygens_one : ¬ SharpHuygens 1 := by decide
theorem not_sharpHuygens_two : ¬ SharpHuygens 2 := by decide
theorem not_sharpHuygens_four : ¬ SharpHuygens 4 := by decide

/-- Sharp Huygens implies odd, but odd does NOT imply sharp Huygens: `d = 1` is the
counterexample (`not_sharpHuygens_one`), and it is the only one. -/
theorem sharpHuygens_odd {d : ℕ} (h : SharpHuygens d) : Odd d := Nat.odd_iff.mpr h.1

theorem odd_not_sharpHuygens_iff {d : ℕ} (h : Odd d) : ¬ SharpHuygens d ↔ d = 1 := by
  have h1 : d % 2 = 1 := Nat.odd_iff.mp h
  constructor
  · intro hns
    by_contra hne
    exact hns ⟨h1, by omega⟩
  · rintro rfl
    exact not_sharpHuygens_one

/-- **The intersection of the two arguments.** `d = 3` is the unique spatial dimension
that both admits stable circular orbits (`d <= 3`, cluster 1) and supports
distortion-free wave propagation (`SharpHuygens d`). The `d <= 3` side is an INPUT
here, imported from `veffSecond_at_stationary`; this theorem only intersects. -/
theorem three_unique (d : ℕ) : (SharpHuygens d ∧ d ≤ 3) ↔ d = 3 := by
  constructor
  · rintro ⟨⟨_, h2⟩, h3⟩
    omega
  · rintro rfl
    exact ⟨sharpHuygens_three, le_refl 3⟩

/-! ## 4. Signature counts (handle `signature`)

Tegmark 1997, Figure 1, as pure arithmetic on `(n, m) = (space, time)` counts. The
classification of a second-order linear PDE by the eigenvalue signs of its principal
symbol is standard (Courant and Hilbert); for the covariant field equations of a
metric of signature `(n, m)` the symbol has `n` eigenvalues of one sign and `m` of the
other.

WHAT IS NOT CLAIMED HERE: that ultrahyperbolic implies an ill-posed initial value
problem. That is Asgeirsson's theorem (Math. Ann. 113, 321, 1936), it is analysis, and
it stays in the prose. This section is bookkeeping only. -/

inductive PDEClass
  | elliptic
  | hyperbolic
  | ultrahyperbolic
  deriving DecidableEq, Repr

/-- Signs-of-the-symbol classification: elliptic when all eigenvalues share a sign,
hyperbolic when exactly one is opposite, ultrahyperbolic otherwise. -/
def pdeClass (n m : ℕ) : PDEClass :=
  if n = 0 ∨ m = 0 then PDEClass.elliptic
  else if n = 1 ∨ m = 1 then PDEClass.hyperbolic
  else PDEClass.ultrahyperbolic

theorem pdeClass_our_world : pdeClass 3 1 = PDEClass.hyperbolic := by decide
theorem pdeClass_no_time : pdeClass 3 0 = PDEClass.elliptic := by decide
theorem pdeClass_two_times : pdeClass 3 2 = PDEClass.ultrahyperbolic := by decide
theorem pdeClass_tachyon_case : pdeClass 1 3 = PDEClass.hyperbolic := by decide

theorem pdeClass_hyperbolic_of_one_time {n : ℕ} (hn : 1 ≤ n) :
    pdeClass n 1 = PDEClass.hyperbolic := by
  have h0 : ¬ (n = 0) := by omega
  simp [pdeClass, h0]

theorem pdeClass_ultrahyperbolic_of {n m : ℕ} (hn : 2 ≤ n) (hm : 2 ≤ m) :
    pdeClass n m = PDEClass.ultrahyperbolic := by
  have h1 : ¬ (n = 0 ∨ m = 0) := by omega
  have h2 : ¬ (n = 1 ∨ m = 1) := by omega
  simp [pdeClass, h1, h2]

/-- Two or more time dimensions alongside two or more space dimensions is never
hyperbolic. This is the arithmetic half of "why one time dimension"; the physical
half (no well-posed initial value problem) is Asgeirsson, not this file. -/
theorem not_hyperbolic_of_two_times {n m : ℕ} (hn : 2 ≤ n) (hm : 2 ≤ m) :
    pdeClass n m ≠ PDEClass.hyperbolic := by
  rw [pdeClass_ultrahyperbolic_of hn hm]
  decide

end Dimensionality
