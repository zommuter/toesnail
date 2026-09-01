/-
  Lean attestation for the DREAMED essay `docs/dreamed/lasercool.md`.

  STATUS: dreamed / UNREVIEWED. See `docs/dreamed/README.md`. This file is NOT part of
  the `verify` lake target and is NOT wired to `physics/*.toml` sidecars; it cannot
  break `make test`. It attests claims in the dreamed essay only, never in `physics/`.

  Sources of the claims, all from `docs/dreamed/lasercool.md`:

    (dopmin) The Doppler-molasses steady-state temperature, derived there from the
             low-intensity friction coefficient and the momentum diffusion coefficient,

                 k_B T(delta) = hbar*(Gamma^2 + 4*delta^2) / (8*|delta|)
                              = (hbar*Gamma/2) * (Gamma^2/4 + delta^2)/(|delta|*Gamma),

             so in units of the Doppler temperature hbar*Gamma/(2*k_B) the dimensionless
             temperature is  r(Gamma, delta) = (Gamma^2/4 + delta^2)/(|delta|*Gamma).
             CLAIM: r >= 1 for every red detuning, with equality exactly at |delta| = Gamma/2.

    (bosnn) The Bose entropy per mode  s(n) = (1+n)*log(1+n) - n*log n  is nonnegative
            on n > 0. Used in the essay's per-photon entropy budget.

    (margin) The per-scattering-event entropy budget. The essay derives
             sigma_atom = (T_rec/T_D) * (1 - T_D/T)  in units of k_B (entropy removed
             from the atomic motion per scattered photon at gas temperature T), and
             sigma_field = s(nbar)/nbar (entropy handed to the radiation field per
             photon). CLAIM: whenever 0 < T_rec < T_D and the field takes at least one
             k_B per photon, the field's gain strictly exceeds the atoms' loss.

    (tdrec) The identity T_D / T_rec = Gamma * m / (2 * hbar * k^2), i.e. the second-law
            margin of (margin) is the inverse of the recoil-to-linewidth ratio.

  Identifier mapping (owner convention, cf. `verify/Resogram.lean`: derivatives would be
  spelled `x_t`, `x_tt`, never `xd`; Lean rejects the combining-dot letters). No
  derivatives occur here. Physical symbols are spelled as in the essay:
      `Gamma` <-> Gamma (natural linewidth, rad/s),   `delta` <-> delta (detuning),
      `n`     <-> nbar  (photon occupation per mode),
      `Trec`, `TD`, `T` <-> T_rec, T_D, T,  `sph` <-> s(nbar)/nbar.
  Greek `Γ` is a legal Lean identifier but is avoided so the ASCII source greps cleanly.

  EXPLICITLY OUT OF SCOPE (not proven, not claimed here):
    * that the stated k_B T(delta) IS the steady state of the Fokker-Planck equation.
      The friction/diffusion derivation is SymPy-checked in the essay, not Lean-checked;
      only the extremum of the resulting expression is formalized.
    * every physical constant, unit, and numeric value in the essay. Nothing numeric
      is attested; all five theorems are dimensionless statements about real numbers.
    * the O(1) normalization of the diffusion coefficient (dipole-pattern factor), which
      the essay flags as convention-dependent.
    * concavity/monotonicity of s(n), the sub-Doppler mechanisms, and everything about
      physics.SE q/669175 and q/817764.
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

namespace Lasercool

/-- Dimensionless Doppler-molasses temperature, in units of `T_D = hbar*Gamma/(2*k_B)`:
    `r Gamma delta = (Gamma^2/4 + delta^2) / (|delta| * Gamma)`. -/
noncomputable def r (Gamma delta : ℝ) : ℝ := (Gamma ^ 2 / 4 + delta ^ 2) / (|delta| * Gamma)

/-- (dopmin, lower bound) For any positive linewidth and any red detuning, the
    dimensionless molasses temperature is at least 1, i.e. `T >= hbar*Gamma/(2*k_B)`.
    The Doppler limit is a genuine lower bound over all detunings, not a special value. -/
theorem doppler_ratio_ge_one (Gamma delta : ℝ) (hG : 0 < Gamma) (hd : delta < 0) :
    1 ≤ r Gamma delta := by
  have habs : |delta| = -delta := abs_of_neg hd
  have hpos : 0 < |delta| * Gamma := by
    rw [habs]; exact mul_pos (by linarith) hG
  rw [r, le_div_iff₀ hpos, habs]
  nlinarith [sq_nonneg (-delta - Gamma / 2)]

/-- (dopmin, attained) At the optimal red detuning `delta = -Gamma/2` the bound is met:
    the molasses temperature equals the Doppler temperature exactly. -/
theorem doppler_ratio_at_optimum (Gamma : ℝ) (hG : 0 < Gamma) :
    r Gamma (-(Gamma / 2)) = 1 := by
  have habs : |(-(Gamma / 2) : ℝ)| = Gamma / 2 := by
    rw [abs_of_neg (by linarith)]; ring
  rw [r, habs]
  field_simp
  ring

/-- (dopmin, uniqueness) Equality holds ONLY at `|delta| = Gamma/2`; every other red
    detuning is strictly hotter. This is the sense in which `-Gamma/2` is *the* optimum. -/
theorem doppler_ratio_eq_one_iff (Gamma delta : ℝ) (hG : 0 < Gamma) (hd : delta < 0) :
    r Gamma delta = 1 ↔ |delta| = Gamma / 2 := by
  have habs : |delta| = -delta := abs_of_neg hd
  have hpos : 0 < |delta| * Gamma := by
    rw [habs]; exact mul_pos (by linarith) hG
  rw [r, div_eq_one_iff_eq (ne_of_gt hpos), habs]
  constructor
  · intro h
    have hsq : (-delta - Gamma / 2) ^ 2 = 0 := by nlinarith
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hsq
    linarith
  · intro h
    have hg : Gamma = -2 * delta := by linarith
    rw [hg]; ring

/-- (bosnn) The Bose entropy per mode `s(n) = (1+n) log(1+n) - n log n` is nonnegative
    for `n > 0`. Proof: `log` is monotone and `log (1+n) >= 0`, so
    `n * log n <= n * log (1+n) <= (1+n) * log (1+n)`. -/
theorem bose_entropy_nonneg (n : ℝ) (hn : 0 < n) :
    0 ≤ (1 + n) * Real.log (1 + n) - n * Real.log n := by
  have h1 : Real.log n ≤ Real.log (1 + n) :=
    Real.log_le_log hn (by linarith)
  have h2 : 0 ≤ Real.log (1 + n) := Real.log_nonneg (by linarith)
  nlinarith [mul_le_mul_of_nonneg_left h1 (le_of_lt hn)]

/-- (margin) The per-scattering-event second-law margin. With
    `sigma_atom = (Trec/TD) * (1 - TD/T)` the entropy removed from the atomic motion per
    scattered photon (essay eq. `budget`) and `sph` the entropy handed to the radiation
    field per photon, both in units of `k_B`: if the recoil temperature is below the
    Doppler temperature and the field takes at least one `k_B` per photon, then the
    field's gain STRICTLY exceeds the atoms' loss.

    Note what carries the argument: `sigma_atom <= Trec/TD < 1` needs only `T > 0`, so the
    margin holds at every point of the cooling trajectory, not just near the limit. -/
theorem entropy_margin (Trec TD T sph : ℝ)
    (hTrec : 0 < Trec) (hTD : Trec < TD) (hT : 0 < T) (hs : 1 ≤ sph) :
    (Trec / TD) * (1 - TD / T) < sph := by
  have hTDpos : 0 < TD := lt_trans hTrec hTD
  have hratio : Trec / TD < 1 := (div_lt_one hTDpos).mpr hTD
  have hrpos : 0 < Trec / TD := div_pos hTrec hTDpos
  have hfac : 1 - TD / T ≤ 1 := by
    have : 0 ≤ TD / T := le_of_lt (div_pos hTDpos hT)
    linarith
  calc (Trec / TD) * (1 - TD / T) ≤ (Trec / TD) * 1 :=
        mul_le_mul_of_nonneg_left hfac (le_of_lt hrpos)
    _ = Trec / TD := by ring
    _ < 1 := hratio
    _ ≤ sph := hs

/-- (tdrec) The margin ratio is the inverse recoil-to-linewidth ratio:
    with `TD = hbar*Gamma/(2*kB)` and `Trec = hbar^2*k^2/(m*kB)`,
    `Trec / TD = 2*hbar*k^2/(Gamma*m)`. Pure algebra; the physical content is that the
    quantity bounding `sigma_atom` in `entropy_margin` is `4*omega_rec/Gamma`, the
    (inverse) sideband-resolution parameter. -/
theorem Trec_div_TD (hbar kwave m Gamma kB : ℝ)
    (hh : 0 < hbar) (hk : 0 < kwave) (hm : 0 < m) (hG : 0 < Gamma) (hkB : 0 < kB) :
    (hbar ^ 2 * kwave ^ 2 / (m * kB)) / (hbar * Gamma / (2 * kB))
      = 2 * hbar * kwave ^ 2 / (Gamma * m) := by
  field_simp

end Lasercool
