/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Companion to `docs/dreamed/measurement-routes.md`, which drafts the four
  candidate narratives for the stub section `## Observe` of
  `physics/toesnail.md` (l.135 to l.136).

  What this file formalises, and what it deliberately does NOT:

  * It formalises the STRUCTURAL content of Route B (POVM / resolution of
    identity): a POVM gives a probability distribution, and a family of
    orthogonal projections is a special case of a POVM. That is a statement
    about mathematics, not about the owner's physics.
  * It formalises the owner's coin as the two-outcome projective measurement on
    `EuclideanSpace ℂ (Fin 2)`, i.e. the Born identity
    `|⟪0|ψ⟫|² + |⟪1|ψ⟫|² = ‖ψ‖²`.
  * It exhibits a POVM that is NOT projective, which is the entire reason
    Route B differs from Route A.

  EXPLICITLY OUT OF SCOPE:
  * The owner's equation `t1` (`physics/toesnail.md` l.59) is NOT formalised.
    It writes probabilities where amplitudes belong; `docs/rigor-debt.md` marks
    that as owner territory, and formalising a reading of it would pick a side.
    What is proved below is the STRUCTURE a corrected `t1` would live in, with
    `p` never identified with an amplitude.
  * Naimark's dilation theorem itself. Mathlib has no Naimark/Stinespring
    dilation, and the honest small witness is the non-projective POVM below.
  * Gleason's theorem. Mathlib does NOT have it (checked: no `Gleason` in
    `Mathlib/Analysis/InnerProductSpace/`), so it is not stated here even as a
    signature. Route D's essay section says so in prose rather than faking it.
  * The bra/dual construction and completeness, out of scope in `Spine.lean`
    for the same reason and not re-imported here.

  Conventions are inherited from `docs/dreamed/lean/Spine.lean`: Mathlib's
  `⟪·,·⟫` is conjugate-linear in the FIRST slot, linear in the SECOND, which is
  the Dirac convention the spine uses. Nothing proved in `Spine.lean`
  (Cauchy-Schwarz, the three axioms, the zero vector) is reproved here.

  Check (from `/home/tobias/src/toesnail/verify`):
      nice -n19 lake env lean --threads=2 \
        /home/tobias/src/toesnail/docs/dreamed/lean/Measurement.lean
-/
import Mathlib.Analysis.InnerProductSpace.Symmetric
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Data.Complex.BigOperators

open scoped ComplexInnerProductSpace

namespace ToesnailMeasurement

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-! ## 1. What a measurement IS, structurally: a resolution of the identity

The owner's stated instinct at `physics/toesnail.md` l.136 is "measurement via
operators, but not the Eigenvalue-Approach, rather some product space or such".
The definition below is the operator side of that: a finite family of positive
self-adjoint operators summing to the identity. No eigenvalue appears anywhere
in it, and no outcome VALUE appears either: the outcomes are the INDICES. -/

/-- A finite POVM (positive operator-valued measure) with `n` outcomes on a
complex inner-product space. Self-adjointness is stated as Mathlib's
`LinearMap.IsSymmetric`, which is the `⟪T x, y⟫ = ⟪x, T y⟫` form and needs no
completeness hypothesis. Positivity is stated on the real part, for the reason
the spine's own l.79 footnote forces: `⟪x, T x⟫` is a complex number, and `0 ≤`
only means something once it is known to be real (it is, by symmetry). -/
structure POVM (n : ℕ) (E : Type*) [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] where
  /-- The effect operators `Eᵢ`. -/
  effect : Fin n → (E →ₗ[ℂ] E)
  /-- Each effect is self-adjoint. -/
  isSymmetric : ∀ i, (effect i).IsSymmetric
  /-- Each effect is positive. -/
  nonneg : ∀ i x, 0 ≤ (⟪x, effect i x⟫).re
  /-- The resolution of the identity, `Σᵢ Eᵢ = 𝟙`. This single equation is what
  makes the Born numbers a probability distribution. -/
  sum_eq_one : ∑ i, effect i = LinearMap.id

/-- The Born probability of outcome `i` in state `ψ`. -/
noncomputable def POVM.prob {n : ℕ} (M : POVM n E) (i : Fin n) (psi : E) : ℝ :=
  (⟪psi, M.effect i psi⟫).re

/-- Born probabilities are non-negative. This is exactly the `Eᵢ ≥ 0` half of
the definition, cashed. -/
theorem POVM.prob_nonneg {n : ℕ} (M : POVM n E) (i : Fin n) (psi : E) :
    0 ≤ M.prob i psi := M.nonneg i psi

/-- Born probabilities sum to `‖ψ‖²`. This is the `Σ Eᵢ = 𝟙` half, cashed, and
it is the whole content of the sentence "measurement gives probabilities". -/
theorem POVM.prob_sum {n : ℕ} (M : POVM n E) (psi : E) :
    ∑ i, M.prob i psi = ‖psi‖ ^ 2 := by
  have hsum : ∑ i, M.effect i psi = psi := by
    have := congrArg (fun T : E →ₗ[ℂ] E => T psi) M.sum_eq_one
    simpa [LinearMap.sum_apply] using this
  calc ∑ i, M.prob i psi
      = (∑ i, ⟪psi, M.effect i psi⟫).re := by
        simp [POVM.prob, Complex.re_sum]
    _ = (⟪psi, ∑ i, M.effect i psi⟫).re := by rw [inner_sum]
    _ = (⟪psi, psi⟫).re := by rw [hsum]
    _ = ‖psi‖ ^ 2 := by
        simpa using (norm_sq_eq_re_inner (𝕜 := ℂ) psi).symm

/-- A NORMALIZED state gives an honest probability distribution: non-negative
numbers summing to one. Together with `POVM.prob_nonneg` this is the entire
"why is this a probability" obligation, discharged. -/
theorem POVM.prob_sum_one {n : ℕ} (M : POVM n E) {psi : E} (h : ‖psi‖ = 1) :
    ∑ i, M.prob i psi = 1 := by
  rw [M.prob_sum psi, h, one_pow]

/-! ## 2. Projective measurements are the special case

Route A's projective postulate is not DISCARDED by Route B; it is contained in
it. Here is the containment, as a theorem rather than as a remark. -/

/-- Any family of self-adjoint idempotents summing to the identity is a POVM.
Positivity is not an extra hypothesis: it FOLLOWS, because
`⟪x, P x⟫ = ⟪x, P (P x)⟫ = ⟪P x, P x⟫ = ‖P x‖² ≥ 0`. -/
def POVM.ofProjections {n : ℕ} (P : Fin n → (E →ₗ[ℂ] E))
    (hsym : ∀ i, (P i).IsSymmetric)
    (hidem : ∀ i x, P i (P i x) = P i x)
    (hsum : ∑ i, P i = LinearMap.id) : POVM n E where
  effect := P
  isSymmetric := hsym
  nonneg := by
    intro i x
    have h : ⟪x, P i x⟫ = ⟪P i x, P i x⟫ := by
      rw [(hsym i) x (P i x), hidem i x]
    have hn : ‖P i x‖ ^ 2 = (⟪P i x, P i x⟫).re := by
      simpa using norm_sq_eq_re_inner (𝕜 := ℂ) (P i x)
    rw [h, ← hn]
    exact sq_nonneg _
  sum_eq_one := hsum

/-! ## 3. The rank-one projection onto a unit vector

This is the operator the owner's "eigenvalues justify bases" reading needs: it
is built from a BASIS VECTOR, and no eigenvalue is used to build it. -/

/-- `proj e : x ↦ ⟪e, x⟫ • e`, the projection onto the line through `e`. -/
noncomputable def proj (e : E) : E →ₗ[ℂ] E := LinearMap.smulRight (innerₛₗ ℂ e) e

@[simp] theorem proj_apply (e x : E) : proj e x = ⟪e, x⟫ • e := rfl

/-- `proj e` is self-adjoint, for ANY `e` (no normalization needed). -/
theorem proj_isSymmetric (e : E) : (proj e).IsSymmetric := by
  intro x y
  simp only [proj_apply, inner_smul_left, inner_smul_right]
  rw [← inner_conj_symm x e]
  ring

/-- `proj e` is idempotent exactly because `e` is a UNIT vector. This is where
"normalize your states" earns its keep. -/
theorem proj_idem {e : E} (he : ‖e‖ = 1) (x : E) : proj e (proj e x) = proj e x := by
  simp only [proj_apply, inner_smul_right]
  rw [inner_self_eq_norm_sq_to_K (𝕜 := ℂ), he]
  simp

/-- The Born number of a rank-one projection is the familiar `|⟪e|ψ⟫|²`. This
is the bridge between the structural definition of §1 and the formula a reader
of any textbook expects. -/
theorem prob_proj (e psi : E) : (⟪psi, proj e psi⟫).re = ‖⟪e, psi⟫‖ ^ 2 := by
  simp only [proj_apply, inner_smul_right]
  rw [← inner_conj_symm psi e, Complex.mul_conj]
  simp [Complex.normSq_eq_norm_sq, ← Complex.ofReal_pow]

/-- An orthonormal BASIS gives a projective measurement: the rank-one
projections onto its vectors form a POVM. `dim` is arbitrary here, so this
covers the coin (`n = 2`) with no exception, which is precisely what Gleason
cannot do. -/
noncomputable def POVM.ofOrthonormalBasis {n : ℕ}
    (b : OrthonormalBasis (Fin n) ℂ E) : POVM n E :=
  POVM.ofProjections (fun i => proj (b i)) (fun i => proj_isSymmetric (b i))
    (fun i => proj_idem (by simpa using b.orthonormal.1 i))
    (by
      ext x
      simp only [LinearMap.sum_apply, proj_apply, LinearMap.id_coe, id_eq]
      exact b.sum_repr' x)

/-- The Born rule for an orthonormal basis, in the shape the spine will want:
the squared overlaps with a basis sum to `‖ψ‖²`. -/
theorem born_orthonormalBasis {n : ℕ} (b : OrthonormalBasis (Fin n) ℂ E)
    (psi : E) : ∑ i, ‖⟪b i, psi⟫‖ ^ 2 = ‖psi‖ ^ 2 := by
  have h := (POVM.ofOrthonormalBasis b).prob_sum psi
  rw [← h]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  simpa [POVM.prob, POVM.ofOrthonormalBasis, POVM.ofProjections]
    using (prob_proj (b i) psi).symm

/-! ## 4. The owner's coin, concretely

`physics/toesnail.md` l.57: "the outcome can be either `|heads⟩` or `|tails⟩`".
Two outcomes, so a qubit. -/

section Coin

/-- The coin's state space. `heads = 0`, `tails = 1`. -/
abbrev Coin : Type := EuclideanSpace ℂ (Fin 2)

/-- `|heads⟩`. -/
noncomputable def heads : Coin := EuclideanSpace.single 0 1

/-- `|tails⟩`. -/
noncomputable def tails : Coin := EuclideanSpace.single 1 1

theorem heads_norm : ‖heads‖ = 1 := by simp [heads]

theorem tails_norm : ‖tails‖ = 1 := by simp [tails]

/-- Heads and tails are orthogonal, which is the formal content of "the outcome
can be EITHER". -/
theorem heads_inner_tails : ⟪heads, tails⟫ = 0 := by
  simp [heads, tails, EuclideanSpace.inner_single_left]

/-- The two coin projections. -/
noncomputable def coinPOVM : POVM 2 Coin :=
  POVM.ofOrthonormalBasis (EuclideanSpace.basisFun (Fin 2) ℂ)

/-- The coin's measurement is genuinely PROJECTIVE: each effect is idempotent. -/
theorem coinPOVM_idem (i : Fin 2) (x : Coin) :
    coinPOVM.effect i (coinPOVM.effect i x) = coinPOVM.effect i x := by
  refine proj_idem ?_ x
  simpa using (EuclideanSpace.basisFun (Fin 2) ℂ).orthonormal.1 i

/-- **The coin's Born identity.** `|⟪heads|ψ⟫|² + |⟪tails|ψ⟫|² = ‖ψ‖²`, so for
a normalized `ψ` the two numbers are a probability distribution over the two
faces. This is the honest formal content of the owner's `t1` equation's INTENT
(`physics/toesnail.md` l.59), with the amplitude-versus-probability question
left untouched: the probabilities here are the squared moduli, not the
coefficients. -/
theorem coin_born (psi : Coin) :
    ‖⟪heads, psi⟫‖ ^ 2 + ‖⟪tails, psi⟫‖ ^ 2 = ‖psi‖ ^ 2 := by
  have h := born_orthonormalBasis (EuclideanSpace.basisFun (Fin 2) ℂ) psi
  rw [Fin.sum_univ_two] at h
  simpa [heads, tails, EuclideanSpace.basisFun_apply] using h

/-- The same statement in coordinates: `p(heads) + p(tails) = ‖ψ‖²` where the
two probabilities are the squared moduli of the components. -/
theorem coin_born_coords (psi : Coin) :
    ‖psi 0‖ ^ 2 + ‖psi 1‖ ^ 2 = ‖psi‖ ^ 2 := by
  have h := coin_born psi
  simpa [heads, tails, EuclideanSpace.inner_single_left] using h

/-- For a normalized coin state the two Born numbers are a probability
distribution: `p + (1 - p) = 1` is not assumed, it is derived. -/
theorem coin_born_normalized {psi : Coin} (h : ‖psi‖ = 1) :
    ‖⟪heads, psi⟫‖ ^ 2 + ‖⟪tails, psi⟫‖ ^ 2 = 1 := by
  rw [coin_born psi, h, one_pow]

end Coin

/-! ## 5. A POVM that is NOT projective

This is the small theorem that carries Route B's whole argument: if every POVM
were projective, Route B would be Route A in heavier notation. It is not.

The example is the "totally unsharp" or coin-flip detector: with probability
`p` it reports outcome 0 no matter what the state is. It is a legitimate
measurement (a broken detector is still a detector) and it has no eigenvalue
story at all. -/

section Unsharp

/-- The "grey" effect `c · 𝟙` for a real weight `c`. -/
noncomputable def scalarEffect (c : ℝ) : E →ₗ[ℂ] E := (c : ℂ) • LinearMap.id

@[simp] theorem scalarEffect_apply (c : ℝ) (x : E) :
    scalarEffect c x = (c : ℂ) • x := rfl

theorem scalarEffect_isSymmetric (c : ℝ) : (scalarEffect (E := E) c).IsSymmetric := by
  intro x y
  simp only [scalarEffect_apply, inner_smul_left, inner_smul_right,
    Complex.conj_ofReal]

theorem scalarEffect_nonneg {c : ℝ} (hc : 0 ≤ c) (x : E) :
    0 ≤ (⟪x, scalarEffect c x⟫).re := by
  have hn : ‖x‖ ^ 2 = (⟪x, x⟫).re := by
    simpa using norm_sq_eq_re_inner (𝕜 := ℂ) x
  simp only [scalarEffect_apply, inner_smul_right, Complex.mul_re,
    Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, ← hn]
  exact mul_nonneg hc (sq_nonneg _)

variable (p : ℝ)

/-- The unsharp two-outcome POVM `E₀ = p·𝟙`, `E₁ = (1-p)·𝟙`: a detector that
reports outcome `0` with probability `p` whatever the state is. It is a broken
detector, and a broken detector is still a detector. -/
noncomputable def unsharpEffect (i : Fin 2) : E →ₗ[ℂ] E :=
  scalarEffect (if i = 0 then p else 1 - p)

theorem unsharpEffect_zero : unsharpEffect (E := E) p 0 = scalarEffect p := by
  simp [unsharpEffect]

theorem unsharpEffect_one : unsharpEffect (E := E) p 1 = scalarEffect (1 - p) := by
  simp [unsharpEffect]

/-- The unsharp family really is a POVM, for any `0 ≤ p ≤ 1`. -/
noncomputable def unsharpPOVM (h0 : 0 ≤ p) (h1 : p ≤ 1) : POVM 2 E where
  effect := unsharpEffect p
  isSymmetric := fun i => scalarEffect_isSymmetric _
  nonneg := by
    intro i x
    refine scalarEffect_nonneg ?_ x
    by_cases h : i = 0 <;> simp [h] <;> linarith
  sum_eq_one := by
    ext x
    rw [LinearMap.sum_apply, Fin.sum_univ_two, unsharpEffect_zero,
      unsharpEffect_one]
    simp only [scalarEffect_apply]
    rw [← add_smul]
    push_cast
    simp

/-- **The unsharp POVM is not projective.** For `0 < p < 1` the effect `E₀` is
not idempotent, so this measurement is not a projective measurement in disguise.
This is why Route B is strictly larger than Route A: the projections of §2 are a
proper subset of the effects of §1. -/
theorem unsharp_not_idempotent {x : E} (hx : x ≠ 0) (h0 : 0 < p) (h1 : p < 1) :
    unsharpEffect p (0 : Fin 2) (unsharpEffect p (0 : Fin 2) x)
      ≠ unsharpEffect p (0 : Fin 2) x := by
  rw [unsharpEffect_zero]
  simp only [scalarEffect_apply, smul_smul]
  intro h
  have hz : ((p : ℂ) * (p : ℂ) - (p : ℂ)) • x = 0 := by
    rw [sub_smul, h, sub_self]
  rcases smul_eq_zero.mp hz with hc | hxz
  · have hp : (p : ℂ) * (p : ℂ) = (p : ℂ) := sub_eq_zero.mp hc
    have : p * p = p := by exact_mod_cast hp
    nlinarith
  · exact hx hxz

end Unsharp

/-! ## 6. Gleason: deliberately absent

Mathlib as vendored here (`leanprover/lean4:v4.30.0-rc2`) has NO Gleason
theorem: there is no frame-function development and no derivation of the Born
rule from the projection lattice. Stating `theorem gleason ... := sorry` would
be a fake attestation, so nothing is stated. `docs/dreamed/measurement-routes.md`
§Route D says the same in prose and prices the gap.

What IS available here is the direction Gleason runs the other way: given the
Born formula, the numbers ARE a probability distribution (`POVM.prob_sum_one`).
Gleason's content is the converse, that no other assignment exists. The converse
is not proved anywhere in this file, and the essay's `[input]` tag marks exactly
that missing implication. -/

end ToesnailMeasurement
