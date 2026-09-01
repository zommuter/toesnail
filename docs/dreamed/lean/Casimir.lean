/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/casimir-field-equations.md`, seeded from the
  owner's own physics.SE question q/27195, "Can symmetry generators be used for
  quantization?" (`docs/se-corpus.md` row P-C, promoted 2026-07-08, ratified as the
  step-5 headline in `docs/meeting-notes/2026-07-08-1056-...` section 5b).

  The essay tests how far the slogan "the Casimir eigenvalue equations ARE the free
  field equations" survives. The three places it can be settled by computation rather
  than by assertion are settled here.

  RELATION TO THE SIBLING FILE. `docs/dreamed/lean/Q2Symmetry.lean` already proved
  `casimir_poincare`, `casimir_unique` and `casimir_galilei_blind` -- the 1+1
  Lie-algebra / cohomology side, `ad_K` on quadratics in `H, P`. Nothing here repeats
  that. This file is the CONCRETE 3+1 side: explicit 4x4 gamma matrices, the explicit
  Levi-Civita symbol, and the Pauli-Lubanski vector as an explicit finite sum. The two
  files are disjoint and complementary.

  ============================ CONVENTIONS, STATED ============================
  Sign conventions are the single largest source of confusion in this material, so
  every one used below is fixed here and nowhere else.

  * METRIC: mostly-minus, `eta = diag(+1, -1, -1, -1)`, indices 0,1,2,3 with 0 the
    time direction. This is the convention forced by the owner's own q/27195 text,
    which writes `p^2 = -d_mu d^mu` and reads off `(box + m_0^2) psi = 0`: with
    `P_mu = i d_mu` and mostly-minus, `P^2 = -d^mu d_mu = -box`, so `P^2 = m^2`
    is exactly `(box + m^2) psi = 0`. The owner's stated signs are self-consistent.
  * LEVI-CIVITA: `eps_{0123} = +1` (lower indices). `eps` below is that symbol,
    valued in `Int`, indexed by `Nat` for cheap kernel reduction.
  * PAULI-LUBANSKI: `W_mu = -(1/2) eps_{mu nu rho sigma} J^{nu rho} P^sigma`.
    NOTE the owner's q/27195 writes `W_mu = +(1/2) eps_{mu nu rho sigma} M^{nu rho}
    P^sigma`, i.e. the opposite overall sign. That flips `W_mu` and leaves `W^2`
    and `W . P` untouched, so nothing below depends on the choice. It is recorded
    because the essay quotes the owner's formula verbatim.
  * GAMMA MATRICES: Dirac (standard) basis, `gamma^0 = diag(1,1,-1,-1)`,
    `gamma^k = [[0, sigma^k], [-sigma^k, 0]]` in 2x2 blocks.
  * SLASH: `slash p = p_mu gamma^mu`, so the argument `p` carries LOWER indices and
    `slash p * slash p = (p_0^2 - p_1^2 - p_2^2 - p_3^2) * 1 = (p . p) * 1`.

  Derivative-name convention (owner's, `CLAUDE.md` memory `lean-derivative-naming`):
  a derivative is `f_x`, subscript naming the differentiation variable. No derivatives
  appear in this file; recorded so a later extension does not invent `xd`.

  ============================== WHAT IS PROVED ==============================
  1. `cliff_00 .. cliff_33`
                         `{gamma^mu, gamma^nu} = 2 eta^{mu nu}` for the ten
                         independent index pairs (the anticommutator is symmetric,
                         so ten cover sixteen), by entrywise computation.
  2. `slash_sq`          `(p_mu gamma^mu)^2 = (p . p) * 1`. THE headline: the
                         first-order Dirac operator squares to the mass-shell scalar.
  3. `dirac_implies_mass_shell`
                         if `slash p . v = m . v` for a spinor `v`, then
                         `(p . p) . v = m^2 . v`. This is "Dirac implies
                         Klein-Gordon" with no extra hypothesis, and it is one
                         direction only -- the converse is false and is not proved.
  4. `spin_half_su2`, `spin_half_casimir`
                         the rest-frame spin matrices built FROM the gammas satisfy
                         `[S_1, S_2] = i S_3` and `S_1^2 + S_2^2 + S_3^2 = 3/4`.
                         The `3/4 = s(s+1)` at `s = 1/2` is computed, not assumed.
  5. `W_dot_P`           `W_mu P^mu = 0` identically, for EVERY `J` and every `P`.
                         Pure Levi-Civita antisymmetry; no antisymmetry of `J`, no
                         Lie algebra, no representation is used.
  6. `rest_W0 .. rest_W3`, `rest_Wsq`
                         at `P = (m,0,0,0)`: `W_0 = 0`, `W_k = m S_k`, and
                         `W^2 = -m^2 (S_1^2 + S_2^2 + S_3^2)`.
  7. `rest_Wsq_spin_half`
                         combining 4 and 6: `W^2 = -(3/4) m^2` for spin 1/2, as an
                         identity of 4x4 matrices.
  8. `null_W0_eq_neg_W3`, `null_Wsq`, `null_helicity`
                         THE SEAM. At the null momentum `P = (E,0,0,E)`:
                         `W_0 = -W_3` for every `J`, hence `W^2 = -(W_1^2 + W_2^2)`,
                         and `W_1`, `W_2` are the two ISO(2) generators. `W^2 = 0`
                         does NOT follow from masslessness alone: it follows exactly
                         when `W_1 = W_2 = 0`, and under that hypothesis
                         `W_mu = lambda P_mu` with `lambda` the helicity, computed.
                         Discarding continuous-spin representations IS the assumption
                         `W_1 = W_2 = 0`; this file makes that visible instead of
                         hiding it.

  ============================ WHAT IS NOT PROVED ============================
  * No Lie algebra. `J` is an arbitrary array of reals (or of matrices, where the
    spin half needs it); the Poincare brackets are never used, so nothing here says
    `W^2` is a Casimir. That `W^2` COMMUTES with the algebra is asserted in the
    essay and not proved anywhere in this repo.
  * No representation theory. Wigner's classification is quoted, never derived.
  * No differential operators. `P_mu = i d_mu` is a doc-comment remark; the passage
    from `P^2 = m^2` to `(box + m^2) psi = 0` is not formalised. `slash_sq` is the
    algebraic core of it and stops there.
  * `dirac_implies_mass_shell` is one-directional by design. The essay's central
    negative claim -- that `W^2 = -(3/4) m^2` does NOT determine the Dirac equation
    -- is an absence, and this file does not prove absences.
  * The spin matrices are the specific `(1/2, 0) + (0, 1/2)` Dirac rep. Nothing
    proves it is the only rep with `s = 1/2`; it is not (Weyl is another), which is
    itself the essay's point.
-/
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace ToesnailDreamed.Casimir

open Complex Matrix

/-! ## 1. The Minkowski metric, mostly-minus -/

/-- `eta μ ν` for the mostly-minus signature `diag(+1,-1,-1,-1)`. Both index
positions agree numerically for a diagonal metric with entries `±1`, so one
definition serves for `eta_{μν}` and `eta^{μν}`. -/
def eta (μ ν : Fin 4) : ℂ := if μ = ν then (if μ = 0 then 1 else -1) else 0

/-- Minkowski square of a covector `p_μ`: `p . p = p_0^2 - p_1^2 - p_2^2 - p_3^2`. -/
def mink (p : Fin 4 → ℂ) : ℂ := p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2

/-! ## 2. Gamma matrices in the Dirac basis -/

noncomputable def g0 : Matrix (Fin 4) (Fin 4) ℂ :=
  !![1,0,0,0; 0,1,0,0; 0,0,-1,0; 0,0,0,-1]

noncomputable def g1 : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0,0,0,1; 0,0,1,0; 0,-1,0,0; -1,0,0,0]

noncomputable def g2 : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0,0,0,-I; 0,0,I,0; 0,I,0,0; -I,0,0,0]

noncomputable def g3 : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0,0,1,0; 0,0,0,-1; -1,0,0,0; 0,1,0,0]

/-- **The Clifford relation**, `gamma^mu gamma^nu + gamma^nu gamma^mu = 2 eta^{mu nu}`,
as the ten independent index pairs. The anticommutator is symmetric in `mu, nu`, so
these ten cover all sixteen. Each is checked entry by entry in the Dirac basis: this
is the whole content of "the Dirac matrices know the metric".

Stated as ten lemmas rather than one `forall mu nu` statement over an indexed family
`![g0,g1,g2,g3]`: the family version was written and does typecheck as a goal, but
`fin_cases mu <;> fin_cases nu` on it exceeded the heartbeat budget at 256 leaf goals.
That is a proof-engineering weakening, not a mathematical one, and it is stated in the
essay's "what was weakened" list. -/
theorem cliff_00 : g0 * g0 + g0 * g0 = (2 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g0, Complex.ext_iff] <;> ring

theorem cliff_11 : g1 * g1 + g1 * g1 = (-2 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g1, Complex.ext_iff] <;> ring

theorem cliff_22 : g2 * g2 + g2 * g2 = (-2 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g2, Complex.ext_iff] <;> ring

theorem cliff_33 : g3 * g3 + g3 * g3 = (-2 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g3, Complex.ext_iff] <;> ring

theorem cliff_01 : g0 * g1 + g1 * g0 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g0, g1]

theorem cliff_02 : g0 * g2 + g2 * g0 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g0, g2]

theorem cliff_03 : g0 * g3 + g3 * g0 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g0, g3]

theorem cliff_12 : g1 * g2 + g2 * g1 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g1, g2]

theorem cliff_13 : g1 * g3 + g3 * g1 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g1, g3]

theorem cliff_23 : g2 * g3 + g3 * g2 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [g2, g3]

/-! ## 3. Feynman slash and the mass shell -/

/-- `slash p = p_mu gamma^mu`. The argument carries LOWER indices (see the header). -/
noncomputable def slash (p : Fin 4 → ℂ) : Matrix (Fin 4) (Fin 4) ℂ :=
  p 0 • g0 + p 1 • g1 + p 2 • g2 + p 3 • g3

/-- **The slash-squared identity.** `(p_mu gamma^mu)^2 = (p . p) * 1`.

This is the exact sense in which "Dirac squares to Klein-Gordon": the first-order
operator is a square root of the second-order mass-shell scalar. It is a matrix
identity, true for every `p`, with no equation of motion assumed. -/
theorem slash_sq (p : Fin 4 → ℂ) :
    slash p * slash p = (mink p) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [slash, mink, g0, g1, g2, g3, Complex.ext_iff,
      pow_two, Complex.mul_re, Complex.mul_im] <;>
    refine ⟨?_, ?_⟩ <;> first | trivial | ring

/-- **Dirac implies the mass shell.** If a spinor `v` satisfies the (momentum-space)
Dirac equation `slash p . v = m . v`, then it satisfies the Klein-Gordon condition
`(p . p) . v = m^2 . v`.

One direction only, deliberately. The converse is false: a solution of the mass-shell
condition need not solve any first-order equation, which is precisely the essay's
point that `P^2 = m^2` is the universal condition and Dirac carries strictly more. -/
theorem dirac_implies_mass_shell (p : Fin 4 → ℂ) (m : ℂ) (v : Fin 4 → ℂ)
    (h : (slash p).mulVec v = m • v) :
    (mink p) • v = (m ^ 2) • v := by
  have h2 : (slash p).mulVec ((slash p).mulVec v) = (m ^ 2) • v := by
    rw [h, Matrix.mulVec_smul, h, smul_smul, sq]
  rw [Matrix.mulVec_mulVec, slash_sq, Matrix.smul_mulVec, Matrix.one_mulVec] at h2
  exact h2

/-! ## 4. Rest-frame spin, built out of the gammas -/

/-- `S_1 = (i/2) gamma^2 gamma^3`. In 2x2 blocks this is `diag(sigma_1/2, sigma_1/2)`,
but it is DEFINED from the gammas so that the spin content is derived from the
Clifford algebra rather than posited alongside it. -/
noncomputable def S1 : Matrix (Fin 4) (Fin 4) ℂ := (I / 2) • (g2 * g3)
/-- `S_2 = (i/2) gamma^3 gamma^1`. -/
noncomputable def S2 : Matrix (Fin 4) (Fin 4) ℂ := (I / 2) • (g3 * g1)
/-- `S_3 = (i/2) gamma^1 gamma^2`. -/
noncomputable def S3 : Matrix (Fin 4) (Fin 4) ℂ := (I / 2) • (g1 * g2)

/-- The spin matrices close on `su(2)`: `[S_1, S_2] = i S_3`. -/
theorem spin_half_su2 : S1 * S2 - S2 * S1 = I • S3 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [S1, S2, S3, g1, g2, g3, Complex.ext_iff] <;> ring

/-- **The spin Casimir at `s = 1/2`.** `S_1^2 + S_2^2 + S_3^2 = (3/4) * 1`.

`3/4 = s(s+1)` at `s = 1/2` is here a computed number, not a quoted formula. -/
theorem spin_half_casimir :
    S1 * S1 + S2 * S2 + S3 * S3 = ((3 : ℂ) / 4) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [S1, S2, S3, g1, g2, g3, Complex.ext_iff] <;> ring

/-- **`W^2 = -(3/4) m^2` for spin 1/2**, as a 4x4 matrix identity, given the rest-frame
components `W_k = m S_k` established below in `rest_W1`-`rest_W3`.

This is the whole "`W^2` gives the spin" half of the slogan, and it is exactly this
much: a number, `s(s+1)`. -/
theorem rest_Wsq_spin_half (m : ℂ) :
    (m • S1) * (m • S1) + (m • S2) * (m • S2) + (m • S3) * (m • S3)
      = (-((3 : ℂ) / 4) * m ^ 2) • (-1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [S1, S2, S3, g1, g2, g3, Complex.ext_iff,
      pow_two, Complex.mul_re, Complex.mul_im] <;>
    refine ⟨?_, ?_⟩ <;> first | trivial | ring

/-! ## 5. The Levi-Civita symbol and the Pauli-Lubanski vector -/

/-- `eps_{μνρσ}` with `eps_{0123} = +1`, all 24 even/odd permutations written out and
everything else zero. Indexed by `Nat` (not `Fin 4`) purely so that kernel reduction
inside `decide`/`norm_num` stays cheap; callers coerce. -/
def eps : ℕ → ℕ → ℕ → ℕ → ℤ
  | 0,1,2,3 => 1  | 0,2,3,1 => 1  | 0,3,1,2 => 1
  | 1,0,3,2 => 1  | 1,2,0,3 => 1  | 1,3,2,0 => 1
  | 2,0,1,3 => 1  | 2,1,3,0 => 1  | 2,3,0,1 => 1
  | 3,0,2,1 => 1  | 3,1,0,2 => 1  | 3,2,1,0 => 1
  | 0,1,3,2 => -1 | 0,2,1,3 => -1 | 0,3,2,1 => -1
  | 1,0,2,3 => -1 | 1,2,3,0 => -1 | 1,3,0,2 => -1
  | 2,0,3,1 => -1 | 2,1,0,3 => -1 | 2,3,1,0 => -1
  | 3,0,1,2 => -1 | 3,1,2,0 => -1 | 3,2,0,1 => -1
  | _,_,_,_ => 0

/-- Antisymmetry in the OUTER pair of slots. This is the one property of `eps` that
`W_dot_P` needs, and it is checked exhaustively over all 256 index tuples. -/
theorem eps_swap_outer (a b c d : Fin 4) : eps a b c d = - eps d b c a := by
  revert a b c d; decide

/-- The Pauli-Lubanski covector `W_mu = -(1/2) eps_{mu nu rho sigma} J^{nu rho} P^sigma`,
written as the explicit triple sum. `J` is an arbitrary array: no antisymmetry, no
Lie-algebra structure and no representation is assumed anywhere below unless a
theorem says so. -/
noncomputable def Wlow (J : Fin 4 → Fin 4 → ℝ) (P : Fin 4 → ℝ) (μ : Fin 4) : ℝ :=
  -(1/2) * ∑ ν : Fin 4, ∑ ρ : Fin 4, ∑ σ : Fin 4,
      (eps (μ : ℕ) (ν : ℕ) (ρ : ℕ) (σ : ℕ) : ℝ) * J ν ρ * P σ

/-- `W^2 = W^mu W_mu = W_0^2 - W_1^2 - W_2^2 - W_3^2` (mostly-minus). -/
noncomputable def Wsq (J : Fin 4 → Fin 4 → ℝ) (P : Fin 4 → ℝ) : ℝ :=
  (Wlow J P 0)^2 - (Wlow J P 1)^2 - (Wlow J P 2)^2 - (Wlow J P 3)^2

set_option maxHeartbeats 1000000 in
/-- **`W . P = 0`, identically.** For every `J` and every `P`. The Levi-Civita symbol
is antisymmetric under exchange of its first and last slot while `P^mu P^sigma` is
symmetric, so the contraction dies term by term.

Consequence for the essay: `W` never has four independent components. In the massive
rest frame it has three (`W_0 = 0`), which is what leaves room for exactly one spin
Casimir; in the massless frame it has two, which is where the pattern breaks. -/
theorem W_dot_P (J : Fin 4 → Fin 4 → ℝ) (P : Fin 4 → ℝ) :
    ∑ μ, Wlow J P μ * P μ = 0 := by
  simp only [Wlow, Fin.sum_univ_four]
  norm_num [eps]
  ring

/-! ### 5a. The massive rest frame `P^sigma = (m, 0, 0, 0)`

The rest frame is given by HYPOTHESES on `P` rather than by substituting the literal
`![m,0,0,0]`: the literal form forces `simp` to reduce `Matrix.cons` applications
inside a 256-term sum, which it does not do reliably. Mathematically identical. -/

variable {J : Fin 4 → Fin 4 → ℝ} {P : Fin 4 → ℝ}

set_option maxHeartbeats 1000000 in
/-- `W_0 = 0` in the rest frame: the Pauli-Lubanski covector is purely spatial. -/
theorem rest_W0 (m : ℝ) (h0 : P 0 = m) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = 0) :
    Wlow J P 0 = 0 := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]

set_option maxHeartbeats 1000000 in
/-- `W_1 = (m/2)(J^{23} - J^{32})`, which is `m J^{23}` on an antisymmetric `J`. -/
theorem rest_W1 (m : ℝ) (h0 : P 0 = m) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = 0) :
    Wlow J P 1 = m / 2 * (J 2 3 - J 3 2) := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]
  ring

set_option maxHeartbeats 1000000 in
/-- `W_2 = (m/2)(J^{31} - J^{13})`, which is `m J^{31}` on an antisymmetric `J`. -/
theorem rest_W2 (m : ℝ) (h0 : P 0 = m) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = 0) :
    Wlow J P 2 = m / 2 * (J 3 1 - J 1 3) := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]
  ring

set_option maxHeartbeats 1000000 in
/-- `W_3 = (m/2)(J^{12} - J^{21})`, which is `m J^{12}` on an antisymmetric `J`. -/
theorem rest_W3 (m : ℝ) (h0 : P 0 = m) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = 0) :
    Wlow J P 3 = m / 2 * (J 1 2 - J 2 1) := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]
  ring

/-- **`W^2` in the rest frame**, with no antisymmetry assumed. -/
theorem rest_Wsq (m : ℝ) (h0 : P 0 = m) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = 0) :
    Wsq J P = -(m^2/4) *
      ((J 2 3 - J 3 2)^2 + (J 3 1 - J 1 3)^2 + (J 1 2 - J 2 1)^2) := by
  simp only [Wsq, rest_W0 m h0 h1 h2 h3, rest_W1 m h0 h1 h2 h3,
    rest_W2 m h0 h1 h2 h3, rest_W3 m h0 h1 h2 h3]
  ring

/-- **`W^2 = -m^2 (S_1^2 + S_2^2 + S_3^2)` in the rest frame** for antisymmetric `J`,
with `S_1 = J^{23}`, `S_2 = J^{31}`, `S_3 = J^{12}`.

The `-m^2 s(s+1)` of the textbooks is this, once the sum of squares of the spin
generators is known. Note what carries the physics: the number `s(s+1)` comes from
the REPRESENTATION (`spin_half_casimir`), never from this equation. -/
theorem rest_Wsq_antisym (m : ℝ) (h0 : P 0 = m) (h1 : P 1 = 0) (h2 : P 2 = 0)
    (h3 : P 3 = 0) (hJ : ∀ a b, J a b = - J b a) :
    Wsq J P = - m^2 * ((J 2 3)^2 + (J 3 1)^2 + (J 1 2)^2) := by
  rw [rest_Wsq m h0 h1 h2 h3, hJ 3 2, hJ 1 3, hJ 2 1]
  ring

/-! ### 5b. The massless seam, `P^sigma = (E, 0, 0, E)` -/

set_option maxHeartbeats 1000000 in
/-- `W_0 = -W_3` on a null momentum along `z`, for EVERY `J`. Together with `null_Wsq`
this is why the two transverse components carry all of `W^2`. -/
theorem null_W0_eq_neg_W3 (E : ℝ) (h0 : P 0 = E) (h1 : P 1 = 0) (h2 : P 2 = 0)
    (h3 : P 3 = E) : Wlow J P 0 = - Wlow J P 3 := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]
  ring

/-- **The seam.** On a null momentum, `W^2 = -(W_1^2 + W_2^2)`. The time and `z`
components cancel identically, so masslessness alone does NOT give `W^2 = 0`: that
requires the two transverse components to vanish. -/
theorem null_Wsq (E : ℝ) (h0 : P 0 = E) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = E) :
    Wsq J P = - ((Wlow J P 1)^2 + (Wlow J P 2)^2) := by
  simp only [Wsq, null_W0_eq_neg_W3 E h0 h1 h2 h3]
  ring

set_option maxHeartbeats 1000000 in
/-- `W_1 = (E/2)(J^{23} - J^{32} + J^{02} - J^{20})`, i.e. `E (J^{23} + J^{02})` for
antisymmetric `J`. With `S_k` the rotations and `K_k = J^{0k}` the boosts this is
`E (S_1 + K_2)`: one of the two `ISO(2)` "translations" of the massless little group. -/
theorem null_W1 (E : ℝ) (h0 : P 0 = E) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = E) :
    Wlow J P 1 = E / 2 * (J 2 3 - J 3 2 + J 0 2 - J 2 0) := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]
  ring

set_option maxHeartbeats 1000000 in
/-- `W_2 = (E/2)(J^{31} - J^{13} - J^{01} + J^{10})`, i.e. `E (J^{31} - J^{01})` for
antisymmetric `J`: `E (S_2 - K_1)`, the other `ISO(2)` generator. -/
theorem null_W2 (E : ℝ) (h0 : P 0 = E) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = E) :
    Wlow J P 2 = E / 2 * (J 3 1 - J 1 3 - J 0 1 + J 1 0) := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]
  ring

set_option maxHeartbeats 1000000 in
/-- `W_3 = (E/2)(J^{12} - J^{21})` on the null momentum: the helicity component. -/
theorem null_W3 (E : ℝ) (h0 : P 0 = E) (h1 : P 1 = 0) (h2 : P 2 = 0) (h3 : P 3 = E) :
    Wlow J P 3 = E / 2 * (J 1 2 - J 2 1) := by
  simp only [Wlow, Fin.sum_univ_four, h0, h1, h2, h3]
  norm_num [eps]
  ring

/-- **Helicity, and the assumption it hides.** IF the two `ISO(2)` generators
annihilate the state (`W_1 = W_2 = 0`), THEN `W^2 = 0` and `W_mu = lambda P_mu` with
`lambda = -(1/2)(J^{12} - J^{21})`, the helicity. The covariant momentum is
`P_mu = (E, 0, 0, -E)`, which is why the last component carries the extra sign.

The hypothesis is not a theorem of the Poincare algebra. Dropping it gives Wigner's
continuous-spin representations, which are discarded on PHYSICAL grounds, not
mathematical ones. This statement is written so that the assumption appears as a
hypothesis rather than as an omission. -/
theorem null_helicity (E : ℝ) (h0 : P 0 = E) (h1 : P 1 = 0) (h2 : P 2 = 0)
    (h3 : P 3 = E) (hw1 : Wlow J P 1 = 0) (hw2 : Wlow J P 2 = 0) :
    Wsq J P = 0 ∧
      Wlow J P 0 = (-(1/2) * (J 1 2 - J 2 1)) * E ∧
      Wlow J P 1 = (-(1/2) * (J 1 2 - J 2 1)) * 0 ∧
      Wlow J P 2 = (-(1/2) * (J 1 2 - J 2 1)) * 0 ∧
      Wlow J P 3 = (-(1/2) * (J 1 2 - J 2 1)) * (-E) := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · rw [null_Wsq E h0 h1 h2 h3, hw1, hw2]; ring
  · rw [null_W0_eq_neg_W3 E h0 h1 h2 h3, null_W3 E h0 h1 h2 h3]; ring
  · rw [hw1]; ring
  · rw [hw2]; ring
  · rw [null_W3 E h0 h1 h2 h3]; ring

end ToesnailDreamed.Casimir
