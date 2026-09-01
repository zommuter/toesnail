/-
  Lean attestation for the DREAMED essay `docs/dreamed/five-level-laser.md`.

  STATUS: dreamed / UNREVIEWED. See `docs/dreamed/README.md`. This file is NOT part of
  the `verify` lake target and is NOT wired to `physics/*.toml` sidecars; it cannot
  break `make test`. It attests claims in the dreamed essay only, never in `physics/`.

  The essay analyzes the owner's five-level laser-cooler seed (dictated 2026-09-01):
  base |0>, intermediate |1> (about half the gap), top |2>, upper laser level |3>,
  lower laser level |4>; stepwise pumping 0->1->2, a phonon step 2<->3, lasing 3->4,
  a phonon step 4<->0. For the cycle to draw heat from the lattice, |3> must sit
  ABOVE |2> by dlift = E3 - E2 > 0 (thermal lift), and the cycle's heat harvest is
  Q = dlift - E4 (setting E0 = 0). The laser photon is h*nu_L = Epump1 + Epump2 + Q.

  Claims attested (handles as in the essay; temperatures carry k_B folded in, i.e.
  every T below is k_B*T in energy units; all quantities are real numbers and the
  physics identification lives in docstrings):

    (dbal)   Detailed balance: a two-level steady state with up-rate u = d*exp(-x)
             sits at the Boltzmann ratio N1/N0 = exp(-x).
    (cons)   A rate matrix with vanishing column sums conserves total population.
    (ssdb)   Scovil & Schulz-DuBois, PRL 2, 262 (1959): for a three-level maser whose
             pump link is Boltzmann-distributed at T_h and whose idler link at T_c,
             population inversion on the signal transition holds IFF
             E_signal/E_pump < 1 - T_c/T_h, the Carnot efficiency.
    (nogain) The five-level chained-ratio bound: with saturable pump links
             (N1 <= N0, N2 <= N1), a detailed-balance-bounded lift
             (N3 <= N2*exp(-dlift/T)) and terminal reset (N4 >= N0*exp(-E4/T)),
             cooling (E4 < dlift) forbids inversion, and inversion forces heating.
    (5carnot) The generalized SSDB chain with a finite pump brightness temperature
             T_p: inversion forces (Ep1+Ep2)/T_p + (dlift-E4)/T_c < 0, equivalently
             E_L/E_pump < 1 - T_c/T_p. Cooling while lasing needs E_L/E_pump > 1,
             so it needs T_c < 0: Kelvin's statement, recovered from rate algebra.
    (cop)    From energy balance E_F = W + Q and the entropy inequality
             Q/T_c <= E_F/T_F, the fluorescence-mode COP obeys Q/W <= T_c/(T_F-T_c).
    (nfourth) Thermal terminal-level condition: exp(-E4/T) < eps iff
             E4 > T*log(1/eps).
    (lift)   The lift-rate trade-off (dlift-E4)*exp(-dlift/T) is maximized exactly
             at dlift = E4 + T, with maximum T*exp(-(E4+T)/T).

  Identifier mapping (owner convention, cf. `verify/Resogram.lean`): derivatives are
  spelled with a subscript-style `_t` (`N_t`), never `Nd`; Lean rejects dotted
  identifiers. `dlift` = E3 - E2, `E4` = terminal-level energy above base, `Tp`/`Tc`
  = pump-brightness / lattice temperature times k_B. ASCII throughout so the source
  greps cleanly.

  EXPLICITLY OUT OF SCOPE (not proven, not claimed):
    * that the hypotheses of (nogain)/(5carnot) hold in every steady state of the
      full 5x5 rate matrix. The essay derives them per link for forward link flux
      (SymPy: the exact gain numerator; 2*10^5-sample Monte Carlo incl. bypass
      decays found zero counterexamples); Lean attests the implication, not the
      steady-state solution itself.
    * every physical constant and numeric value in the essay.
    * Einstein A/B relations, cross-sections, Doppler widths, and everything about
      parasitics (EQE, ESA, background absorption).
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

namespace FiveLevel

/-- (dbal) Detailed balance gives the Boltzmann ratio: if the up-rate is the
    down-rate times `exp(-x)` (with `x = DeltaE/(k_B*T)`) and the two-level exchange
    is in steady state (`u*N0 = d*N1`), the population ratio is the Boltzmann factor. -/
theorem detailed_balance_boltzmann (u d N0 N1 x : ℝ)
    (hd : 0 < d) (hN0 : 0 < N0)
    (hu : u = d * Real.exp (-x))
    (hsteady : u * N0 = d * N1) :
    N1 / N0 = Real.exp (-x) := by
  rw [hu, mul_assoc] at hsteady
  have h := mul_left_cancel₀ (ne_of_gt hd) hsteady
  rw [div_eq_iff (ne_of_gt hN0)]
  linarith

/-- (cons) A rate matrix whose columns each sum to zero conserves total population:
    if `N_t i = sum_j M i j * N j` (the rate equation), then `sum_i N_t i = 0`.
    This is why the 5x5 of the essay has a nontrivial steady state at fixed total N. -/
theorem total_population_conserved (M : Fin 5 → Fin 5 → ℝ) (N N_t : Fin 5 → ℝ)
    (hcol : ∀ j, (∑ i, M i j) = 0)
    (hrate : ∀ i, N_t i = ∑ j, M i j * N j) :
    (∑ i, N_t i) = 0 := by
  simp_rw [hrate]
  rw [Finset.sum_comm]
  simp_rw [← Finset.sum_mul]
  simp [hcol]

/-- (ssdb) Scovil-Schulz-DuBois 1959, formalized: three-level maser, pump link of
    energy `Ep` Boltzmann-equilibrated with the hot bath at `Th`, idler link of energy
    `Ep - Es` with the cold bath at `Tc`; the signal transition carries `Es`.
    Population inversion on the signal transition (`N_upper > N_lower`) holds IFF the
    maser efficiency `Es/Ep` is below the Carnot efficiency `1 - Tc/Th`.
    Temperatures are in energy units (k_B folded in). -/
theorem ssdb_inversion_iff_carnot (Ep Es Tc Th N0 : ℝ)
    (hTc : 0 < Tc) (hTh : 0 < Th) (hEp : 0 < Ep) (hN0 : 0 < N0) :
    N0 * Real.exp (-((Ep - Es) / Tc)) < N0 * Real.exp (-(Ep / Th))
      ↔ Es / Ep < 1 - Tc / Th := by
  rw [mul_lt_mul_iff_right₀ hN0, Real.exp_lt_exp, neg_lt_neg_iff,
    div_lt_div_iff₀ hTh hTc, lt_sub_iff_add_lt,
    div_add_div _ _ (ne_of_gt hEp) (ne_of_gt hTh), div_lt_one (mul_pos hEp hTh)]
  constructor <;> intro h <;> nlinarith

/-- (nogain, direct form) Cooling forbids inversion. Hypotheses, each a per-link
    steady-state bound derived in the essay for forward link flux:
    pump saturation caps `N1 <= N0` and `N2 <= N1`; detailed balance on the phonon
    lift caps `N3 <= N2 * exp(-dlift/T)`; the thermal floor of the terminal level is
    `N4 >= N0 * exp(-E4/T)`. If the cycle draws net heat from the bath (`E4 < dlift`),
    the laser transition is strictly UNinverted. -/
theorem no_gain_when_cooling (N0 N1 N2 N3 N4 dlift E4 T : ℝ)
    (hT : 0 < T) (hN0 : 0 < N0)
    (h01 : N1 ≤ N0) (h12 : N2 ≤ N1)
    (h23 : N3 ≤ N2 * Real.exp (-(dlift / T)))
    (h40 : N0 * Real.exp (-(E4 / T)) ≤ N4)
    (hcool : E4 < dlift) :
    N3 < N4 := by
  have he3 : (0:ℝ) < Real.exp (-(dlift / T)) := Real.exp_pos _
  have hchain : N3 ≤ N0 * Real.exp (-(dlift / T)) :=
    le_trans h23 (mul_le_mul_of_nonneg_right (le_trans h12 h01) (le_of_lt he3))
  have hdiv : E4 / T < dlift / T := by
    have h := mul_lt_mul_of_pos_right hcool (inv_pos.mpr hT)
    rw [div_eq_mul_inv, div_eq_mul_inv]
    linarith
  have hstrict : N0 * Real.exp (-(dlift / T)) < N0 * Real.exp (-(E4 / T)) := by
    apply mul_lt_mul_of_pos_left _ hN0
    rw [Real.exp_lt_exp]
    linarith
  linarith

/-- (nogain, contrapositive) Inversion forces heating: if the laser transition is
    inverted (`N4 < N3`) under the same per-link bounds, then `dlift <= E4`, i.e.
    the cycle dumps net heat `E4 - dlift >= 0` into the bath, and by the glue
    identity below the laser photon carries at most the pump energy. -/
theorem gain_implies_heating (N0 N1 N2 N3 N4 dlift E4 T : ℝ)
    (hT : 0 < T) (hN0 : 0 < N0)
    (h01 : N1 ≤ N0) (h12 : N2 ≤ N1)
    (h23 : N3 ≤ N2 * Real.exp (-(dlift / T)))
    (h40 : N0 * Real.exp (-(E4 / T)) ≤ N4)
    (hgain : N4 < N3) :
    dlift ≤ E4 := by
  by_contra hlt
  rw [not_le] at hlt
  have := no_gain_when_cooling N0 N1 N2 N3 N4 dlift E4 T hT hN0 h01 h12 h23 h40 hlt
  linarith

/-- Glue identity: with `E3 = E2 + dlift` and the laser photon `E_L = E3 - E4`,
    the cooling condition `E_L > E2` (laser photon exceeds the summed pump photons)
    is exactly `E4 < dlift`, the hypothesis of `no_gain_when_cooling`. -/
theorem cooling_iff_lift_exceeds_terminal (E2 dlift E4 : ℝ) :
    E2 < (E2 + dlift) - E4 ↔ E4 < dlift := by
  constructor <;> intro h <;> linarith

/-- (5carnot) The generalized Scovil-Schulz-DuBois chain for the five-level scheme
    with a FINITE pump brightness temperature `Tp`: the two pump links are bounded by
    Boltzmann ratios at `Tp` (a laser pump is the limit `Tp -> infinity`, where the
    bounds relax to `N1 <= N0` etc.), the two phonon links by Boltzmann ratios at the
    lattice temperature `Tc`. Inversion (`N4 < N3`) forces
    `(Ep1+Ep2)/Tp + (dlift-E4)/Tc < 0`. (Positivity of the temperatures is not
    needed for the chain algebra; it enters only the physical reading.) -/
theorem five_level_carnot (N0 N1 N2 N3 N4 Ep1 Ep2 dlift E4 Tp Tc : ℝ)
    (hN0 : 0 < N0)
    (h01 : N1 ≤ N0 * Real.exp (-(Ep1 / Tp)))
    (h12 : N2 ≤ N1 * Real.exp (-(Ep2 / Tp)))
    (h23 : N3 ≤ N2 * Real.exp (-(dlift / Tc)))
    (h40 : N0 * Real.exp (-(E4 / Tc)) ≤ N4)
    (hgain : N4 < N3) :
    (Ep1 + Ep2) / Tp + (dlift - E4) / Tc < 0 := by
  have e1 := Real.exp_pos (-(Ep1 / Tp))
  have e2 := Real.exp_pos (-(Ep2 / Tp))
  have e3 := Real.exp_pos (-(dlift / Tc))
  have hch2 : N2 ≤ N0 * (Real.exp (-(Ep1 / Tp)) * Real.exp (-(Ep2 / Tp))) := by
    calc N2 ≤ N1 * Real.exp (-(Ep2 / Tp)) := h12
      _ ≤ (N0 * Real.exp (-(Ep1 / Tp))) * Real.exp (-(Ep2 / Tp)) :=
          mul_le_mul_of_nonneg_right h01 (le_of_lt e2)
      _ = N0 * (Real.exp (-(Ep1 / Tp)) * Real.exp (-(Ep2 / Tp))) := by ring
  have hch3 : N3 ≤ N0 * (Real.exp (-(Ep1 / Tp)) * Real.exp (-(Ep2 / Tp))
      * Real.exp (-(dlift / Tc))) := by
    calc N3 ≤ N2 * Real.exp (-(dlift / Tc)) := h23
      _ ≤ (N0 * (Real.exp (-(Ep1 / Tp)) * Real.exp (-(Ep2 / Tp))))
            * Real.exp (-(dlift / Tc)) :=
          mul_le_mul_of_nonneg_right hch2 (le_of_lt e3)
      _ = N0 * (Real.exp (-(Ep1 / Tp)) * Real.exp (-(Ep2 / Tp))
            * Real.exp (-(dlift / Tc))) := by ring
  have hlt : N0 * Real.exp (-(E4 / Tc))
      < N0 * (Real.exp (-(Ep1 / Tp)) * Real.exp (-(Ep2 / Tp))
        * Real.exp (-(dlift / Tc))) := by
    calc N0 * Real.exp (-(E4 / Tc)) ≤ N4 := h40
      _ < N3 := hgain
      _ ≤ _ := hch3
  have hexp : Real.exp (-(E4 / Tc))
      < Real.exp (-(Ep1 / Tp) + -(Ep2 / Tp) + -(dlift / Tc)) := by
    have h := lt_of_mul_lt_mul_left hlt (le_of_lt hN0)
    rwa [← Real.exp_add, ← Real.exp_add] at h
  rw [Real.exp_lt_exp] at hexp
  have hsplit : (Ep1 + Ep2) / Tp = Ep1 / Tp + Ep2 / Tp := add_div Ep1 Ep2 Tp
  have hsplit2 : (dlift - E4) / Tc = dlift / Tc - E4 / Tc := sub_div dlift E4 Tc
  linarith

/-- (5carnot, Carnot form) Rearranging the chain inequality: with total pump energy
    `Ep > 0` and laser photon `EL = Ep + dlift - E4`, inversion's requirement
    `Ep/Tp + (EL - Ep)/Tc < 0` is the Carnot efficiency bound
    `EL/Ep < 1 - Tc/Tp`. Cooling needs `EL/Ep > 1`, so lasing-while-cooling would
    need `Tc/Tp < 0`: Kelvin's statement of the second law, recovered.
    (`0 < Tp` is not needed for the rearrangement itself.) -/
theorem gain_bounds_laser_energy (Ep EL Tp Tc : ℝ)
    (hTc : 0 < Tc) (hEp : 0 < Ep)
    (h : Ep / Tp + (EL - Ep) / Tc < 0) :
    EL / Ep < 1 - Tc / Tp := by
  rw [div_lt_iff₀ hEp]
  have h2 : (EL - Ep) / Tc < -(Ep / Tp) := by linarith
  have h3 : EL - Ep < -(Ep / Tp) * Tc := (div_lt_iff₀ hTc).mp h2
  have h4 : -(Ep / Tp) * Tc = -(Tc / Tp * Ep) := by ring
  have h5 : (1 - Tc / Tp) * Ep = Ep - Tc / Tp * Ep := by ring
  linarith

/-- (cop) The Carnot bound on the fluorescence-mode coefficient of performance.
    Energy balance: the fluorescence carries `E_F = W + Q` (pump work plus harvested
    heat). Second law: the entropy drawn from the lattice at `Tc` is bounded by what
    the fluorescence exports at its flux temperature `TF`, `Q/Tc <= (W+Q)/TF`.
    Then `COP = Q/W <= Tc/(TF - Tc)`. -/
theorem carnot_cop_bound (Q W Tc TF : ℝ)
    (hTc : 0 < Tc) (hTF : Tc < TF) (hW : 0 < W)
    (hS : Q / Tc ≤ (W + Q) / TF) :
    Q / W ≤ Tc / (TF - Tc) := by
  have hTFpos : 0 < TF := lt_trans hTc hTF
  have h1 : Q * TF ≤ (W + Q) * Tc := (div_le_div_iff₀ hTc hTFpos).mp hS
  rw [div_le_div_iff₀ hW (by linarith : (0:ℝ) < TF - Tc)]
  nlinarith

/-- (nfourth) The thermal-population condition on the terminal laser level:
    `N4/N0 = exp(-E4/T) < eps` iff `E4 > T*log(1/eps)`. At `eps = 10^-2` and 300 K
    this is the essay's `E4 > 119 meV`; at 100 K, `E4 > 40 meV`. -/
theorem thermal_terminal_level (E4 T eps : ℝ) (hT : 0 < T) (heps : 0 < eps) :
    Real.exp (-(E4 / T)) < eps ↔ T * Real.log (1 / eps) < E4 := by
  rw [← Real.lt_log_iff_exp_lt heps, one_div, Real.log_inv, neg_lt, lt_div_iff₀ hT]
  constructor <;> intro h <;> linarith

/-- Helper for the lift optimum: `x * exp(-x) <= exp(-1)` for every real `x`,
    from `x <= exp(x-1)` (Mathlib's `add_one_le_exp` shifted by one). -/
theorem mul_exp_neg_le (x : ℝ) : x * Real.exp (-x) ≤ Real.exp (-1) := by
  have h := Real.add_one_le_exp (x - 1)
  have h2 : x ≤ Real.exp (x - 1) := by linarith
  calc x * Real.exp (-x) ≤ Real.exp (x - 1) * Real.exp (-x) :=
        mul_le_mul_of_nonneg_right h2 (le_of_lt (Real.exp_pos _))
    _ = Real.exp (-1) := by
        rw [← Real.exp_add]
        congr 1
        ring

/-- (lift) The lift-versus-rate trade-off. Cooling power per ion in fluorescence
    mode scales as `(dlift - E4) * exp(-dlift/T)` (harvest times Boltzmann-taxed
    lift rate); this is bounded by its value at `dlift = E4 + T`. -/
theorem lift_power_bound (dlift E4 T : ℝ) (hT : 0 < T) :
    (dlift - E4) * Real.exp (-(dlift / T)) ≤ T * Real.exp (-((E4 + T) / T)) := by
  have hx : dlift - E4 = T * ((dlift - E4) / T) := by field_simp
  have hexp : Real.exp (-(dlift / T))
      = Real.exp (-(E4 / T)) * Real.exp (-((dlift - E4) / T)) := by
    rw [← Real.exp_add]
    congr 1
    field_simp
    ring
  have hrhs : Real.exp (-((E4 + T) / T))
      = Real.exp (-(E4 / T)) * Real.exp (-1) := by
    rw [← Real.exp_add]
    congr 1
    field_simp
    ring
  rw [hx, hexp, hrhs]
  have hb := mul_exp_neg_le ((dlift - E4) / T)
  have hE : (0:ℝ) ≤ Real.exp (-(E4 / T)) := le_of_lt (Real.exp_pos _)
  calc T * ((dlift - E4) / T) * (Real.exp (-(E4 / T))
        * Real.exp (-((dlift - E4) / T)))
      = T * Real.exp (-(E4 / T))
        * ((dlift - E4) / T * Real.exp (-((dlift - E4) / T))) := by ring
    _ ≤ T * Real.exp (-(E4 / T)) * Real.exp (-1) := by
        apply mul_le_mul_of_nonneg_left hb
        positivity
    _ = T * (Real.exp (-(E4 / T)) * Real.exp (-1)) := by ring

/-- (lift, attained) At `dlift = E4 + T` the bound is met exactly, so `E4 + T` IS
    the optimum: harvest one k_B*T more than the terminal level costs. -/
theorem lift_power_at_optimum (E4 T : ℝ) :
    ((E4 + T) - E4) * Real.exp (-((E4 + T) / T)) = T * Real.exp (-((E4 + T) / T)) := by
  ring_nf

end FiveLevel
