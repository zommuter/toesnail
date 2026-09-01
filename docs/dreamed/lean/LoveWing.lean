/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/love-wing.md`, seeded from the owner's own
  material: the "L" in TOESNAIL (`physics/toesnail.md`, "all is full of love"),
  ratification D5 (`docs/meeting-notes/2026-07-07-1228-toe-roadmap-evaluation.md`,
  love wing = game theory / simulations + essays), and open question Q11
  (`docs/meeting-notes/2026-07-07-1257-corpus-dreaming-session.md` §4, the proposed
  7-stage arc Resogram -> Strogatz -> Kuramoto -> games -> Gottman).

  Nothing here is theory. These are the mechanically checkable fragments of the
  proposed arc's stages 2, 3 and 4. Stage 1 (Resogram) already has `verify/Resogram.lean`;
  stage 5 (Gottman) is deliberately ABSENT, and that absence is the essay's finding:
  a fitted empirical model has no theorem to state.

  Notation mapping (Strogatz, "Love Affairs and Differential Equations", Math. Mag. 61,
  35 (1988)). Romeo's feeling `R`, Juliet's feeling `J`, linear dynamics

      R_t = a R + b J
      J_t = c R + d J

  Owner convention: derivatives carry a `_<var>` subscript naming the differentiation
  variable (`R_t`, not `Rd`); Lean rejects the combining-dot forms. `T = a + d` is the
  trace, `D = a*d - b*c` the determinant.

  Contents.
    1. `strogatz_charpoly`      -- (a-l)(d-l) - bc = l^2 - T l + D.
    2. `strogatz_root_add`/`_sub`, `strogatz_sum`, `strogatz_prod`
                                -- the quadratic formula for the real-discriminant case.
    3. `real_pair_neg_iff`      -- two reals are both negative iff sum < 0 and product > 0.
    4. `strogatz_stable_iff`    -- EVERY complex root has negative real part iff
                                   T < 0 and D > 0 (Routh-Hurwitz in 2D, both directions,
                                   with the roots constructed rather than assumed).
    5. `out_of_touch_center`    -- a = d = 0, b*c < 0: every root is purely imaginary and
                                   nonzero (the eternal cycle of love and hate).
       `out_of_touch_saddle`    -- a = d = 0, 0 < b*c: the roots are the reals
                                   ±sqrt(b*c), one growing and one decaying (runaway).
       `out_of_touch_invariant` -- with a = d = 0 the quantity c*R^2 - b*J^2 is CONSERVED
                                   along the flow. This is the essay's candidate
                                   "energy function" at stage 2, proved with a
                                   `HasDerivAt` witness (Mathlib `deriv` is
                                   junk-on-failure and would silently model a false claim).
    6. `kuramoto_order_le_one`  -- the Kuramoto order parameter has modulus at most 1.
    7. `kuramoto_Kc_lorentzian` -- K_c = 2/(pi g(0)) with g(0) = 1/(pi*gamma) gives 2*gamma.
    8. `potential_game_*`       -- an exact-potential 2x2 game: unilateral payoff changes
                                   equal potential changes; better-response dynamics is
                                   strictly monotone in the potential; a maximiser of the
                                   potential is a pure Nash equilibrium.

  OUT OF SCOPE, deliberately.
    * That the linear system above models anything about people. It does not; it is
      Strogatz's teaching device and the essay says so.
    * The Kuramoto self-consistency equation itself (r = K r int cos^2 th g(K r sin th) dth)
      and the bifurcation at K_c. Only the ALGEBRA of the Lorentzian K_c is proved here;
      the self-consistency solution is checked numerically in the essay, not in Lean.
    * Everything at stage 5 (Gottman/Murray/Swanson). Its parameters are fitted, not
      derived, so there is no statement to prove.
-/
import Mathlib.Analysis.Complex.Trigonometric
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Data.Fintype.Order

open Finset

namespace LoveWing

/-! ## 1-2. Stage 2: Strogatz's two-body linear model -/

/-- The characteristic polynomial of `[[a,b],[c,d]]` in trace/determinant form.
    Pure algebra, stated exactly as the classification uses it. -/
theorem strogatz_charpoly (a b c d l : ℝ) :
    (a - l) * (d - l) - b * c = l ^ 2 - (a + d) * l + (a * d - b * c) := by
  ring

/-- The `+` branch of the quadratic formula is a root, given a nonnegative discriminant.
    `hdisc` is the NAMED positivity hypothesis; without it `Real.sqrt` truncates to 0 and
    the statement would be false. -/
theorem strogatz_root_add (T D : ℝ) (hdisc : 0 ≤ T ^ 2 - 4 * D) :
    ((T + Real.sqrt (T ^ 2 - 4 * D)) / 2) ^ 2
      - T * ((T + Real.sqrt (T ^ 2 - 4 * D)) / 2) + D = 0 := by
  have hs : Real.sqrt (T ^ 2 - 4 * D) ^ 2 = T ^ 2 - 4 * D := Real.sq_sqrt hdisc
  nlinarith [hs]

/-- The `-` branch of the quadratic formula is a root. -/
theorem strogatz_root_sub (T D : ℝ) (hdisc : 0 ≤ T ^ 2 - 4 * D) :
    ((T - Real.sqrt (T ^ 2 - 4 * D)) / 2) ^ 2
      - T * ((T - Real.sqrt (T ^ 2 - 4 * D)) / 2) + D = 0 := by
  have hs : Real.sqrt (T ^ 2 - 4 * D) ^ 2 = T ^ 2 - 4 * D := Real.sq_sqrt hdisc
  nlinarith [hs]

/-- The two real branches sum to the trace. -/
theorem strogatz_sum (T D : ℝ) :
    (T + Real.sqrt (T ^ 2 - 4 * D)) / 2 + (T - Real.sqrt (T ^ 2 - 4 * D)) / 2 = T := by
  ring

/-- The two real branches multiply to the determinant. -/
theorem strogatz_prod (T D : ℝ) (hdisc : 0 ≤ T ^ 2 - 4 * D) :
    ((T + Real.sqrt (T ^ 2 - 4 * D)) / 2) * ((T - Real.sqrt (T ^ 2 - 4 * D)) / 2) = D := by
  have hs : Real.sqrt (T ^ 2 - 4 * D) ^ 2 = T ^ 2 - 4 * D := Real.sq_sqrt hdisc
  nlinarith [hs]

/-- Two reals are both negative iff their sum is negative and their product positive.
    This is the real-eigenvalue half of the stability classification, isolated so the
    classification reads as trace/determinant conditions and nothing else. -/
theorem real_pair_neg_iff (u v : ℝ) :
    (u < 0 ∧ v < 0) ↔ (u + v < 0 ∧ 0 < u * v) := by
  constructor
  · rintro ⟨hu, hv⟩
    exact ⟨by linarith, mul_pos_of_neg_of_neg hu hv⟩
  · rintro ⟨hsum, hprod⟩
    constructor <;> nlinarith

/-- Real and imaginary parts of the characteristic equation for a complex root. -/
private theorem root_re_im {T D : ℝ} {z : ℂ} (hz : z ^ 2 - (T : ℂ) * z + (D : ℂ) = 0) :
    z.re ^ 2 - z.im ^ 2 - T * z.re + D = 0 ∧ 2 * z.re * z.im - T * z.im = 0 := by
  rw [Complex.ext_iff] at hz
  simp [pow_two, Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.sub_re, Complex.sub_im] at hz
  obtain ⟨h1, h2⟩ := hz
  constructor <;> nlinarith [h1, h2]

/-- **Routh-Hurwitz in two dimensions.** Every complex root of `l^2 - T l + D` has strictly
    negative real part exactly when the trace is negative and the determinant positive.
    In Strogatz's terms: the affair decays to mutual indifference (the origin is a stable
    node or spiral) iff `a + d < 0` and `a d - b c > 0`.

    The forward direction genuinely CONSTRUCTS a root (real branches when the discriminant
    is nonnegative, a complex-conjugate pair otherwise), so the statement is not vacuous. -/
theorem strogatz_stable_iff (T D : ℝ) :
    (∀ z : ℂ, z ^ 2 - (T : ℂ) * z + (D : ℂ) = 0 → z.re < 0) ↔ (T < 0 ∧ 0 < D) := by
  constructor
  · intro h
    rcases le_or_gt 0 (T ^ 2 - 4 * D) with hdisc | hdisc
    · -- real roots: both negative, so sum < 0 and product > 0
      set s := Real.sqrt (T ^ 2 - 4 * D) with hs_def
      have hs : s ^ 2 = T ^ 2 - 4 * D := Real.sq_sqrt hdisc
      have hp : (((T + s) / 2 : ℝ) : ℂ) ^ 2 - (T : ℂ) * (((T + s) / 2 : ℝ) : ℂ) + (D : ℂ) = 0 := by
        have := strogatz_root_add T D hdisc
        rw [← hs_def] at this
        exact_mod_cast congrArg (fun x : ℝ => (x : ℂ)) this
      have hm : (((T - s) / 2 : ℝ) : ℂ) ^ 2 - (T : ℂ) * (((T - s) / 2 : ℝ) : ℂ) + (D : ℂ) = 0 := by
        have := strogatz_root_sub T D hdisc
        rw [← hs_def] at this
        exact_mod_cast congrArg (fun x : ℝ => (x : ℂ)) this
      have h1 : (T + s) / 2 < 0 := by simpa using h _ hp
      have h2 : (T - s) / 2 < 0 := by simpa using h _ hm
      have := (real_pair_neg_iff ((T + s) / 2) ((T - s) / 2)).mp ⟨h1, h2⟩
      constructor
      · nlinarith [this.1]
      · nlinarith [this.2, hs]
    · -- complex-conjugate pair with real part T/2
      have hpos : 0 ≤ 4 * D - T ^ 2 := by linarith
      set r := Real.sqrt (4 * D - T ^ 2) with hr_def
      have hr : r ^ 2 = 4 * D - T ^ 2 := Real.sq_sqrt hpos
      have hroot : (⟨T / 2, r / 2⟩ : ℂ) ^ 2 - (T : ℂ) * (⟨T / 2, r / 2⟩ : ℂ) + (D : ℂ) = 0 := by
        apply Complex.ext <;>
          simp [pow_two, Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
            Complex.sub_re, Complex.sub_im] <;>
          nlinarith [hr]
      have hre : (⟨T / 2, r / 2⟩ : ℂ).re < 0 := h _ hroot
      simp only [] at hre
      exact ⟨by linarith [hre], by nlinarith⟩
  · rintro ⟨hT, hD⟩ z hz
    obtain ⟨h1, h2⟩ := root_re_im hz
    rcases eq_or_ne z.im 0 with him | him
    · rw [him] at h1
      nlinarith
    · have : 2 * z.re - T = 0 := by
        rcases mul_eq_zero.mp (by nlinarith [h2] : (2 * z.re - T) * z.im = 0) with h | h
        · exact h
        · exact absurd h him
      linarith

/-! ## 5. Stage 2's charming special case: "out of touch with their own feelings"

Strogatz's `a = d = 0` case: neither lover responds to their own state, only to the
other's. The characteristic equation collapses to `l^2 = b*c`, and the SIGN of the
single product `b*c` decides everything. -/

/-- `a = d = 0`, `b*c < 0` (the lovers respond to each other with OPPOSITE signs: one
    is drawn by warmth, the other repelled by it). Every eigenvalue is purely imaginary
    and nonzero: a centre. The orbit is an eternal cycle of love and hate, neither
    growing nor decaying. -/
theorem out_of_touch_center (b c : ℝ) (hbc : b * c < 0) (z : ℂ)
    (hz : z ^ 2 = ((b * c : ℝ) : ℂ)) : z.re = 0 ∧ z ≠ 0 := by
  rw [Complex.ext_iff] at hz
  simp [pow_two, Complex.mul_re, Complex.mul_im] at hz
  obtain ⟨h1, h2⟩ := hz
  have hre : z.re = 0 := by
    rcases mul_eq_zero.mp (by nlinarith [h2] : z.re * z.im = 0) with h | h
    · exact h
    · exfalso; rw [h] at h1; nlinarith
  refine ⟨hre, ?_⟩
  intro hzero
  have him : z.im = 0 := by rw [hzero]; simp
  rw [hre, him] at h1
  linarith

/-- `a = d = 0`, `0 < b*c` (both respond to the other with the SAME sign: either mutual
    encouragement, or mutual withdrawal). The eigenvalues are the reals `±sqrt(b*c)`,
    one strictly positive and one strictly negative: a saddle, hence runaway along the
    unstable direction. -/
theorem out_of_touch_saddle (b c : ℝ) (hbc : 0 < b * c) :
    0 < Real.sqrt (b * c) ∧ Real.sqrt (b * c) ^ 2 = b * c
      ∧ (-Real.sqrt (b * c)) ^ 2 = b * c ∧ -Real.sqrt (b * c) < 0 := by
  have hs : Real.sqrt (b * c) ^ 2 = b * c := Real.sq_sqrt hbc.le
  have hpos : 0 < Real.sqrt (b * c) := Real.sqrt_pos.mpr hbc
  exact ⟨hpos, hs, by nlinarith [hs], by linarith⟩

/-- **The stage-2 conserved quantity.** With `a = d = 0` the flow `R_t = b J`,
    `J_t = c R` conserves `Q = c R^2 - b J^2` exactly. When `b*c < 0` this `Q` is a
    definite quadratic form, so its level sets are ellipses: the "energy" whose
    constancy IS the centre of `out_of_touch_center`.

    Stated with `HasDerivAt` witnesses rather than `deriv`, because Mathlib's `deriv`
    returns `0` for non-differentiable functions and would let a false claim through. -/
theorem out_of_touch_invariant (b c : ℝ) (R J : ℝ → ℝ) (t : ℝ)
    (hR : HasDerivAt R (b * J t) t) (hJ : HasDerivAt J (c * R t) t) :
    HasDerivAt (fun s => c * (R s) ^ 2 - b * (J s) ^ 2) 0 t := by
  have h1 : HasDerivAt (fun s => c * (R s) ^ 2) (c * (2 * R t ^ 1 * (b * J t))) t :=
    ((hR.pow 2).const_mul c)
  have h2 : HasDerivAt (fun s => b * (J s) ^ 2) (b * (2 * J t ^ 1 * (c * R t))) t :=
    ((hJ.pow 2).const_mul b)
  have := h1.sub h2
  convert this using 1
  ring

/-! ## 6-7. Stage 3: Kuramoto -/

/-- **The Kuramoto order parameter is bounded by 1.** `r e^{i psi} = (1/N) sum_j e^{i theta_j}`;
    the modulus `r` measures coherence, `r = 1` being perfect synchrony and `r = 0`
    incoherence. The bound is the triangle inequality plus `|e^{i theta}| = 1`.

    This is the essay's candidate love-wing analogue of the Resogram's energy: an
    aggregate scalar summarising the whole population. Note what the bound does NOT
    say: `r` is not conserved, and it is not a Lyapunov function for the general
    (heterogeneous-frequency) Kuramoto flow. -/
theorem kuramoto_order_le_one (N : ℕ) (hN : 0 < N) (θ : Fin N → ℝ) :
    ‖((N : ℂ))⁻¹ * ∑ j, Complex.exp ((θ j : ℂ) * Complex.I)‖ ≤ 1 := by
  have hNne : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hN.ne'
  have hsum : ‖∑ j, Complex.exp ((θ j : ℂ) * Complex.I)‖ ≤ (N : ℝ) := by
    calc ‖∑ j, Complex.exp ((θ j : ℂ) * Complex.I)‖
        ≤ ∑ _j : Fin N, (1 : ℝ) := by
          refine (norm_sum_le _ _).trans (le_of_eq ?_)
          exact Finset.sum_congr rfl fun j _ => Complex.norm_exp_ofReal_mul_I (θ j)
      _ = (N : ℝ) := by simp
  rw [norm_mul, norm_inv, Complex.norm_natCast]
  rw [inv_mul_le_one₀ (by positivity)]
  exact hsum

/-- **Lorentzian critical coupling.** The mean-field onset of synchronisation is at
    `K_c = 2 / (pi * g(0))` for a symmetric unimodal frequency density `g`. For the
    Lorentzian of half-width `gamma`, `g(0) = 1/(pi*gamma)`, so `K_c = 2*gamma`.
    `hγ` is the NAMED positivity hypothesis; the algebra is false at `gamma = 0`. -/
theorem kuramoto_Kc_lorentzian (γ g0 Kc : ℝ) (hγ : 0 < γ)
    (hg0 : g0 = 1 / (Real.pi * γ)) (hKc : Kc = 2 / (Real.pi * g0)) : Kc = 2 * γ := by
  have hπ : Real.pi ≠ 0 := Real.pi_ne_zero
  subst hg0; subst hKc
  field_simp

/-- **Two-oscillator Kuramoto is a gradient flow.** For `N = 2` the phase difference
    `phi = theta_1 - theta_2` obeys Adler's equation `phi_t = dw - K sin phi`, and this
    is minus the derivative of the potential `V(phi) = -dw*phi - K cos phi`.

    This is the honest form of the essay's "the energy function threads the arc" claim
    at stage 3: a potential exists, but `V` is not periodic in `phi` unless `dw = 0`,
    so it is a *tilted* washboard, not a conserved energy. -/
theorem kuramoto_two_gradient (dw K φ : ℝ) :
    HasDerivAt (fun p => -dw * p - K * Real.cos p) (-(dw - K * Real.sin φ)) φ := by
  have h1 : HasDerivAt (fun p : ℝ => -dw * p) (-dw) φ := by
    simpa using (hasDerivAt_id φ).const_mul (-dw)
  have h2 : HasDerivAt (fun p : ℝ => K * Real.cos p) (K * (-Real.sin φ)) φ :=
    (Real.hasDerivAt_cos φ).const_mul K
  have := h1.sub h2
  convert this using 1
  ring

/-! ## 8. Stage 4: games

An exact-potential game. `Φ` is a shared interaction matrix; each player's payoff is
`Φ` plus a term the player cannot influence. Then unilateral payoff differences ARE
potential differences, so better-response dynamics ascends `Φ` monotonically and a
maximiser of `Φ` is a pure Nash equilibrium. Strategies are `Bool` (two per player);
nothing below uses more than that finiteness. -/

variable {Φ : Bool → Bool → ℝ} {f g : Bool → ℝ} {u₁ u₂ : Bool → Bool → ℝ}

/-- Unilateral payoff differences equal potential differences, for both players. -/
theorem potential_game_exact
    (hu₁ : ∀ x y, u₁ x y = Φ x y + f y) (hu₂ : ∀ x y, u₂ x y = Φ x y + g x) :
    (∀ x x' y, u₁ x' y - u₁ x y = Φ x' y - Φ x y)
      ∧ (∀ x y y', u₂ x y' - u₂ x y = Φ x y' - Φ x y) := by
  constructor
  · intro x x' y; rw [hu₁, hu₁]; ring
  · intro x y y'; rw [hu₂, hu₂]; ring

/-- Better-response dynamics is strictly monotone in the potential: whenever a player
    unilaterally switches to a strictly better reply, `Φ` strictly increases. This is
    the stage-4 analogue of "energy goes up only if you push in phase". -/
theorem potential_game_monotone
    (hu₁ : ∀ x y, u₁ x y = Φ x y + f y) {x x' y : Bool} (h : u₁ x y < u₁ x' y) :
    Φ x y < Φ x' y := by
  rw [hu₁, hu₁] at h; linarith

/-- A maximiser of the potential is a pure Nash equilibrium. Existence is by finiteness
    of `Bool × Bool`, so the game HAS a pure equilibrium. Contrast with a general
    two-player game, which need not (matching pennies). -/
theorem potential_game_nash
    (hu₁ : ∀ x y, u₁ x y = Φ x y + f y) (hu₂ : ∀ x y, u₂ x y = Φ x y + g x) :
    ∃ x y, (∀ x', u₁ x' y ≤ u₁ x y) ∧ (∀ y', u₂ x y' ≤ u₂ x y) := by
  obtain ⟨p, hp⟩ := Finite.exists_max (fun q : Bool × Bool => Φ q.1 q.2)
  refine ⟨p.1, p.2, fun x' => ?_, fun y' => ?_⟩
  · have := hp (x', p.2); rw [hu₁, hu₁]; simpa using by linarith [this]
  · have := hp (p.1, y'); rw [hu₂, hu₂]; simpa using by linarith [this]

end LoveWing
