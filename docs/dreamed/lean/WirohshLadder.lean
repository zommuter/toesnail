/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/wirohsh-ladder.md` (round 2 of the WiRoHSH
  dreaming session), seeded from the owner's `physics/wirohsh.md` line

      "the Laplace equation can be solved as the superposition of solutions
       two dimensions lower!"

  and from round 1, `docs/dreamed/wirohsh-splats.md` (+ `lean/Wirohsh.lean`), which
  is NOT repeated here.

  Five clusters, each faithful to one line of the essay.

  1. `Ladder.bottom_add_two`, `Ladder.terminus`   (handle `ladder-parity`)
     The d -> d-2 ladder has two orbits. Iterating the step from d lands on 1 when
     d is odd and on 2 when d is even, and the step never changes which. Trivial
     arithmetic, but it is the essay's spine, so it is stated rather than assumed.

  2. `Nharm`, `Nharm_diff`                        (handle `harm-dim`)
     The dimension of the degree-`n` hyperspherical harmonics in `D = k+2`
     dimensions. `Nharm` is DEFINED in the subtraction-free Pascal form
     `C(n+k,k) + C(n+k-1,k)`; `Nharm_diff` proves it equals the owner-style
     difference `C(n+D-1,D-1) - C(n+D-3,D-1)`, restated as an ADDITION so that
     no truncated `Nat` subtraction appears anywhere in the statement.

  3. `Nharm_branching`                            (handle `ladder-count`)
     THE counting content of the ladder: summing the direction-sphere harmonic
     dimensions of every degree up to `n` reproduces the ambient count one
     dimension up,  `sum_{m<=n} N(D-1,m) = N(D,n)`.  Together with the SymPy
     computation of the Whittaker transform's kernel (`|m| > n` integrates to
     zero) this is the exact bookkeeping of the `D -> D-2` step.

  4. `radial3_reduction`, `radial3_dalembert`     (handle `radial-3d`)
     The concrete bottom rung: `u(r,t) = f(r - c t) / r` solves the 3D radial wave
     equation away from the origin, because `v = r u` solves the 1D one. Stated
     with `HasDerivAt` witnesses throughout (Mathlib `deriv` is junk-on-failure)
     and with `r <> 0` and `c <> 0` in NAMED hypotheses.

  5. `gegenbauer_deriv_one/two/three`             (handle `gegenbauer-ladder`)
     The algebraic form of one ladder step: `d/dx C_n^(l) = 2 l C_(n-1)^(l+1)`,
     a shift `l -> l+1`, i.e. `D -> D+2`. Mathlib (this vendoring, rev
     v4.30.0-rc2) has NO Gegenbauer, Legendre or Jacobi polynomials -- only
     `Mathlib.RingTheory.Polynomial.Chebyshev` -- so the low-degree polynomials
     are written out here and the relation is proved as a genuine `HasDerivAt`
     statement, not as formal symbolic differentiation.

  Identifier mapping (owner convention: a derivative is `<f>_<var>`, the subscript
  naming the differentiation variable; NOT `fd`/`fdd`; Lean rejects `f'`-style
  dotted letters):
      `f_x`, `f_xx`   <-> f', f''        (1D profile, argument named x)
      `u_r`, `u_rr`   <-> d_r u, d_r^2 u
      `u_tt`          <-> d_t^2 u
      `l`             <-> the Gegenbauer index lambda = (D-2)/2
      `k`             <-> D - 2  (so `Nharm k n` is the count in D = k+2 dims)
-/
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace WirohshLadder

/-! ## 1. The ladder has a parity (handle `ladder-parity`)

The owner's construction represents a solution of the `d`-dimensional wave equation
as a superposition over directions `e` of profiles obeying the `(d-1)`-dimensional
Laplace equation; Wick-rotating that Laplace equation back turns it into the
`(d-2)`-dimensional wave equation, so the ladder steps `d -> d-2`.

A step-2 recursion on `ℕ` has exactly two orbits. `bottom d` records which. -/

/-- Where the `d -> d-2` ladder terminates: `1` (transverse Laplacian is
`0`-dimensional, hence vacuous, hence the profile is ARBITRARY) for odd `d`, and
`2` (transverse Laplacian is `1`-dimensional, hence the profile is LINEAR in the
transverse coordinate) for even `d`. -/
def bottom (d : ℕ) : ℕ := if d % 2 = 1 then 1 else 2

theorem bottom_odd {d : ℕ} (h : d % 2 = 1) : bottom d = 1 := by
  simp [bottom, h]

theorem bottom_even {d : ℕ} (h : d % 2 = 0) : bottom d = 2 := by
  simp [bottom, h]

/-- **One rung of the ladder does not change the terminus.**  Stated upward
(`d` versus `d+2`) so that no truncated `Nat` subtraction occurs. -/
theorem bottom_add_two (d : ℕ) : bottom (d + 2) = bottom d := by
  simp [bottom, Nat.add_mod_right]

/-- **The ladder's parity, in one line.**  Every `d ≥ 1` is exactly `bottom d` plus
an even number, i.e. iterating `d -> d-2` from `d` reaches `1` when `d` is odd and
`2` when `d` is even, and reaches nothing else. -/
theorem terminus (d : ℕ) (hd : 1 ≤ d) : ∃ k : ℕ, d = 2 * k + bottom d := by
  rcases Nat.even_or_odd d with he | ho
  · obtain ⟨m, hm⟩ := he
    have hmod : d % 2 = 0 := by omega
    refine ⟨m - 1, ?_⟩
    rw [bottom_even hmod]
    omega
  · obtain ⟨m, hm⟩ := ho
    have hmod : d % 2 = 1 := by omega
    refine ⟨m, ?_⟩
    rw [bottom_odd hmod]
    omega

/-- The two termini are genuinely different conditions, and there are only two. -/
theorem bottom_eq_one_or_two (d : ℕ) : bottom d = 1 ∨ bottom d = 2 := by
  unfold bottom; split <;> simp

/-! ## 2. Hyperspherical harmonic dimensions (handle `harm-dim`)

`Nharm k n` is the dimension of the space of degree-`n` hyperspherical harmonics in
`D = k + 2` ambient dimensions.  It is DEFINED in the Pascal form, which is
subtraction-free and therefore trap-free on `ℕ`; the owner-style difference of two
binomials is then a theorem, not a definition. -/

/-- `Nharm k n = dim H_n(S^(k+1))`, the degree-`n` harmonics in `D = k+2` dimensions.

    Pascal form: `C(n+k, k) + C(n+k-1, k)`, written by cases on `n` so that the
    `n - 1` never has to be taken on `ℕ`.  Sanity: `Nharm 1 n = 2n+1` (D = 3),
    `Nharm 0 n = 2` for `n ≥ 1` (D = 2), `Nharm k 0 = 1` for all `k`. -/
def Nharm (k : ℕ) : ℕ → ℕ
  | 0 => 1
  | (n + 1) => (n + 1 + k).choose k + (n + k).choose k

@[simp] theorem Nharm_zero (k : ℕ) : Nharm k 0 = 1 := rfl

/-- Unfolding lemma for the successor branch, so that no proof below needs `simp [Nharm]`
    (which loops on the equation compiler's equations). -/
theorem Nharm_succ (k n : ℕ) :
    Nharm k (n + 1) = (n + 1 + k).choose k + (n + k).choose k := rfl

/-- D = 3: the familiar `2n+1`. -/
theorem Nharm_three (n : ℕ) : Nharm 1 n = 2 * n + 1 := by
  cases n with
  | zero => rfl
  | succ m =>
      rw [Nharm_succ, Nat.choose_one_right, Nat.choose_one_right]
      omega

/-- D = 2: two independent harmonics `e^(±i n φ)` at every degree `n ≥ 1`. -/
theorem Nharm_two (n : ℕ) : Nharm 0 (n + 1) = 2 := by
  rw [Nharm_succ, Nat.choose_zero_right, Nat.choose_zero_right]

/-- Pascal's rule in the exact index shape used below. -/
private theorem pascal (a k : ℕ) :
    (a + 1).choose (k + 1) = a.choose k + a.choose (k + 1) :=
  Nat.choose_succ_succ' a k

/-- **The owner's difference formula.**  In `D = k+2` dimensions,

        N(D,n) = C(n+D-1, D-1) - C(n+D-3, D-1),

    restated additively (at `n + 2`, so that both `Nat` subtractions in the original
    are avoided outright) as

        C(n+k+1, k+1) + Nharm k (n+2) = C(n+k+3, k+1).

    Proved by Pascal twice; no truncated subtraction appears anywhere. -/
theorem Nharm_diff (k n : ℕ) :
    (n + k + 1).choose (k + 1) + Nharm k (n + 2) = (n + k + 3).choose (k + 1) := by
  have h3 : n + k + 3 = (n + k + 2) + 1 := by omega
  have h2 : n + k + 2 = (n + k + 1) + 1 := by omega
  have e1 : (n + k + 3).choose (k + 1)
      = (n + k + 2).choose k + (n + k + 2).choose (k + 1) := by
    rw [h3]; exact pascal (n + k + 2) k
  have e2 : (n + k + 2).choose (k + 1)
      = (n + k + 1).choose k + (n + k + 1).choose (k + 1) := by
    conv_lhs => rw [h2]
    exact pascal (n + k + 1) k
  have e3 : Nharm k (n + 2) = (n + k + 2).choose k + (n + k + 1).choose k := by
    rw [Nharm_succ]
    have i1 : n + 1 + 1 + k = n + k + 2 := by omega
    have i2 : n + 1 + k = n + k + 1 := by omega
    rw [i1, i2]
  rw [e1, e2, e3]
  omega

/-! ## 3. The ladder's counting statement (handle `ladder-count`) -/

/-- **`sum_{m ≤ n} N(D-1, m) = N(D, n)`.**

    The owner's construction integrates a profile over the direction sphere
    `S^(D-2)`.  Expanding that profile in harmonics ON the direction sphere gives, at
    each degree `m`, exactly `N(D-1,m)` independent directions; the SymPy run in the
    essay shows the transform annihilates every `m > n`.  This theorem says the
    survivors are counted EXACTLY right: summing `m = 0 … n` reproduces `N(D,n)`.

    Here `Nharm k m` is the direction-sphere count (`D - 1 = k + 2`) and
    `Nharm (k+1) n` is the ambient one (`D = k + 3`). -/
theorem Nharm_branching (k n : ℕ) :
    ∑ m ∈ Finset.range (n + 1), Nharm k m = Nharm (k + 1) n := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      cases n with
      | zero =>
          rw [Nharm_zero, Nharm_succ, Nharm_succ]
          have i1 : 0 + 1 + k = k + 1 := by omega
          have i2 : 0 + k = k := by omega
          have i3 : 0 + 1 + (k + 1) = (k + 1) + 1 := by omega
          have i4 : 0 + (k + 1) = k + 1 := by omega
          rw [i1, i2, i3, i4, Nat.choose_self, Nat.choose_self,
            Nat.choose_succ_self_right, Nat.choose_succ_self_right]
          omega
      | succ m =>
          rw [Nharm_succ, Nharm_succ, Nharm_succ]
          have i1 : m + 1 + (k + 1) = m + k + 2 := by omega
          have i2 : m + (k + 1) = m + k + 1 := by omega
          have i3 : m + 1 + 1 + k = m + k + 2 := by omega
          have i4 : m + 1 + k = m + k + 1 := by omega
          have i5 : m + 1 + 1 + (k + 1) = m + k + 3 := by omega
          rw [i5, i1, i2, i3, i4]
          have h3 : m + k + 3 = (m + k + 2) + 1 := by omega
          have h2 : m + k + 2 = (m + k + 1) + 1 := by omega
          have pa : (m + k + 3).choose (k + 1)
              = (m + k + 2).choose k + (m + k + 2).choose (k + 1) := by
            rw [h3]; exact pascal (m + k + 2) k
          have pb : (m + k + 2).choose (k + 1)
              = (m + k + 1).choose k + (m + k + 1).choose (k + 1) := by
            conv_lhs => rw [h2]
            exact pascal (m + k + 1) k
          rw [pa, pb]
          omega

/-! ## 4. The concrete rung: 3D radial = 1D in disguise (handle `radial-3d`) -/

/-- **`v = r u` is the whole content of the 3D radial wave equation.**

    If `v` is twice differentiable on the `r`-slice with witnesses `v_r`, `v_rr`,
    then `u = v / r` satisfies

        u_rr + (2/r) u_r  =  v_rr / r         (r ≠ 0)

    and the two derivatives of `u` are DELIVERED as `HasDerivAt` witnesses, not
    assumed.  The `1/r^2` and `1/r^3` terms cancel exactly; that cancellation is the
    reason `d = 3` is special, and it is the bottom rung the classical
    `(1/r ∂_r)` ladder is built on. -/
theorem radial3_reduction (r : ℝ) (hr : r ≠ 0) (v v_r v_rr : ℝ → ℝ)
    (hv : ∀ s, HasDerivAt v (v_r s) s) (hv2 : ∀ s, HasDerivAt v_r (v_rr s) s) :
    HasDerivAt (fun s : ℝ => v s / s) (v_r r / r - v r / r ^ 2) r
    ∧ HasDerivAt (fun s : ℝ => v_r s / s - v s / s ^ 2)
        (v_rr r / r - 2 * v_r r / r ^ 2 + 2 * v r / r ^ 3) r
    ∧ (v_rr r / r - 2 * v_r r / r ^ 2 + 2 * v r / r ^ 3)
        + (2 / r) * (v_r r / r - v r / r ^ 2) = v_rr r / r := by
  have hid : HasDerivAt (fun s : ℝ => s) (1 : ℝ) r := hasDerivAt_id r
  have hsq : HasDerivAt (fun s : ℝ => s ^ 2) (2 * r) r := by
    simpa using (hasDerivAt_pow 2 r)
  have hr2 : (r : ℝ) ^ 2 ≠ 0 := pow_ne_zero 2 hr
  refine ⟨?_, ?_, ?_⟩
  · have := (hv r).div hid hr
    refine this.congr_deriv ?_
    field_simp
  · have hA : HasDerivAt (fun s : ℝ => v_r s / s)
        ((v_rr r * r - v_r r * 1) / r ^ 2) r := (hv2 r).div hid hr
    have hB : HasDerivAt (fun s : ℝ => v s / s ^ 2)
        ((v_r r * r ^ 2 - v r * (2 * r)) / (r ^ 2) ^ 2) r := (hv r).div hsq hr2
    have := hA.sub hB
    refine this.congr_deriv ?_
    field_simp
    ring
  · field_simp
    ring

/-- **The classic: `u(r,t) = f(r - c t) / r` solves the 3D radial wave equation.**

    `f` carries named first- and second-derivative witnesses `f_x`, `f_xx`; `r ≠ 0`
    and `c ≠ 0` are named hypotheses.  All three second derivatives are delivered,
    and the residual

        u_rr + (2/r) u_r - (1/c^2) u_tt

    is proved to be `0`.  This is the ladder's bottom rung on the odd branch: the
    profile `f` is ARBITRARY (twice differentiable), which is exactly the `d = 1`
    terminus of the essay's `d -> d-2` ladder.

    OUT OF SCOPE: the converse (every radial solution has this form), and the
    `(1/r ∂_r)` step to `d = 5` (SymPy only; see the essay's `computation` block). -/
theorem radial3_dalembert (c r t : ℝ) (hc : c ≠ 0) (hr : r ≠ 0)
    (f f_x f_xx : ℝ → ℝ)
    (hf : ∀ s, HasDerivAt f (f_x s) s) (hf2 : ∀ s, HasDerivAt f_x (f_xx s) s) :
    -- first r-derivative of the r-slice of u
    HasDerivAt (fun s : ℝ => f (s - c * t) / s)
      (f_x (r - c * t) / r - f (r - c * t) / r ^ 2) r
    -- second r-derivative
    ∧ HasDerivAt (fun s : ℝ => f_x (s - c * t) / s - f (s - c * t) / s ^ 2)
        (f_xx (r - c * t) / r - 2 * f_x (r - c * t) / r ^ 2
          + 2 * f (r - c * t) / r ^ 3) r
    -- second t-derivative (delivered from the first t-derivative map)
    ∧ HasDerivAt (fun s : ℝ => -c * f_x (r - c * s) / r)
        (c ^ 2 * f_xx (r - c * t) / r) t
    -- and the 3D radial wave equation holds
    ∧ (f_xx (r - c * t) / r - 2 * f_x (r - c * t) / r ^ 2
          + 2 * f (r - c * t) / r ^ 3)
        + (2 / r) * (f_x (r - c * t) / r - f (r - c * t) / r ^ 2)
        - (1 / c ^ 2) * (c ^ 2 * f_xx (r - c * t) / r) = 0 := by
  -- the r-slice is `v s = f (s - c t)`, with derivatives shifted by the same amount
  set v : ℝ → ℝ := fun s => f (s - c * t) with hvdef
  set v_r : ℝ → ℝ := fun s => f_x (s - c * t) with hvrdef
  set v_rr : ℝ → ℝ := fun s => f_xx (s - c * t) with hvrrdef
  have hv : ∀ s, HasDerivAt v (v_r s) s := by
    intro s
    simpa [hvdef, hvrdef] using (hf (s - c * t)).comp s ((hasDerivAt_id s).sub_const (c * t))
  have hv2 : ∀ s, HasDerivAt v_r (v_rr s) s := by
    intro s
    simpa [hvrdef, hvrrdef] using (hf2 (s - c * t)).comp s ((hasDerivAt_id s).sub_const (c * t))
  obtain ⟨h1, h2, h3⟩ := radial3_reduction r hr v v_r v_rr hv hv2
  refine ⟨h1, h2, ?_, ?_⟩
  · -- t-slice: d_t [ -c f_x(r - c s) / r ] = c^2 f_xx(r - c t) / r
    have inner : HasDerivAt (fun s : ℝ => r - c * s) (-c) t := by
      simpa using ((hasDerivAt_id t).const_mul c).const_sub r
    have hcomp : HasDerivAt (fun s : ℝ => f_x (r - c * s)) (f_xx (r - c * t) * (-c)) t :=
      (hf2 (r - c * t)).comp t inner
    have := (hcomp.const_mul (-c)).div_const r
    refine this.congr_deriv ?_
    field_simp
  · have := h3
    field_simp at this ⊢
    linarith [this]

/-! ## 5. The Gegenbauer ladder (handle `gegenbauer-ladder`)

`C_n^(l)` are the hyperspherical harmonics' radial/angular polynomials with
`l = (D-2)/2`, so a shift `l -> l+1` IS a shift `D -> D+2`: one rung of the ladder.
The classical relation

    d/dx C_n^(l)(x) = 2 l C_(n-1)^(l+1)(x)

says that rung is, algebraically, a single differentiation.

Mathlib (rev `v4.30.0-rc2`) has no Gegenbauer/Legendre/Jacobi family, so the
low-degree polynomials are written out.  The statements are genuine `HasDerivAt`
claims, not formal symbolic differentiation. -/

/-- `C_0^(l)(x) = 1`. -/
def geg0 (_l _x : ℝ) : ℝ := 1

/-- `C_1^(l)(x) = 2 l x`. -/
def geg1 (l x : ℝ) : ℝ := 2 * l * x

/-- `C_2^(l)(x) = 2 l^2 x^2 + 2 l x^2 - l`. -/
def geg2 (l x : ℝ) : ℝ := 2 * l ^ 2 * x ^ 2 + 2 * l * x ^ 2 - l

/-- `C_3^(l)(x) = (4/3) l^3 x^3 + 4 l^2 x^3 - 2 l^2 x + (8/3) l x^3 - 2 l x`. -/
noncomputable def geg3 (l x : ℝ) : ℝ :=
  4 * l ^ 3 / 3 * x ^ 3 + 4 * l ^ 2 * x ^ 3 - 2 * l ^ 2 * x + 8 * l / 3 * x ^ 3 - 2 * l * x

/-- `d/dx C_1^(l) = 2 l C_0^(l+1)`. -/
theorem gegenbauer_deriv_one (l x : ℝ) :
    HasDerivAt (fun s : ℝ => geg1 l s) (2 * l * geg0 (l + 1) x) x := by
  have h : HasDerivAt (fun s : ℝ => 2 * l * s) (2 * l * 1) x :=
    (hasDerivAt_id x).const_mul (2 * l)
  have hd : 2 * l * 1 = 2 * l * geg0 (l + 1) x := by unfold geg0; ring
  exact h.congr_deriv hd

/-- `d/dx C_2^(l) = 2 l C_1^(l+1)`.  Note the right-hand side lives one rung UP:
its index is `l + 1`, i.e. two ambient dimensions higher. -/
theorem gegenbauer_deriv_two (l x : ℝ) :
    HasDerivAt (fun s : ℝ => geg2 l s) (2 * l * geg1 (l + 1) x) x := by
  have hx2 : HasDerivAt (fun s : ℝ => s ^ 2) (2 * x) x := by
    simpa using (hasDerivAt_pow 2 x)
  have h : HasDerivAt (fun s : ℝ => 2 * l ^ 2 * s ^ 2 + 2 * l * s ^ 2 - l)
      (2 * l ^ 2 * (2 * x) + 2 * l * (2 * x)) x :=
    ((hx2.const_mul (2 * l ^ 2)).add (hx2.const_mul (2 * l))).sub_const l
  have hd : 2 * l ^ 2 * (2 * x) + 2 * l * (2 * x) = 2 * l * geg1 (l + 1) x := by
    unfold geg1; ring
  exact h.congr_deriv hd

/-- `d/dx C_3^(l) = 2 l C_2^(l+1)`. -/
theorem gegenbauer_deriv_three (l x : ℝ) :
    HasDerivAt (fun s : ℝ => geg3 l s) (2 * l * geg2 (l + 1) x) x := by
  have hx3 : HasDerivAt (fun s : ℝ => s ^ 3) (3 * x ^ 2) x := by
    simpa using (hasDerivAt_pow 3 x)
  have hx1 : HasDerivAt (fun s : ℝ => s) (1 : ℝ) x := hasDerivAt_id x
  have step :=
    ((((hx3.const_mul (4 * l ^ 3 / 3)).add (hx3.const_mul (4 * l ^ 2))).sub
      (hx1.const_mul (2 * l ^ 2))).add (hx3.const_mul (8 * l / 3))).sub
      (hx1.const_mul (2 * l))
  have hd : (4 * l ^ 3 / 3) * (3 * x ^ 2) + (4 * l ^ 2) * (3 * x ^ 2) - (2 * l ^ 2) * 1
      + (8 * l / 3) * (3 * x ^ 2) - (2 * l) * 1 = 2 * l * geg2 (l + 1) x := by
    unfold geg2; ring
  exact step.congr_deriv hd

end WirohshLadder
