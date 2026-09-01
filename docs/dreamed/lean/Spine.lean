/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for the three `verify:lean` targets that `docs/rigor-debt.md`
  lists under `## physics/toesnail.md  *(the QM spine)*`. Every claim below is
  the OWNER's, transcribed from `physics/toesnail.md`; nothing here invents or
  amends physics. Companion essay: `docs/dreamed/spine.md`.

  Source handles (owner's `\ltag{...}` in `physics/toesnail.md`) → Lean names:

    `conjugate symmetry`   (l.87)  → `spine_conjugate_symmetry`
    `linearity`            (l.88)  → `spine_linearity`
    `positive-definiteness` (l.89) → `spine_positive_definiteness`
    zero-vector prose      (l.99)  → `spine_zero_add`
                           (l.100) → `spine_zero_smul`
    footnote `uniqueZero`  (l.118) → `spine_zero_unique_additive_identity`
                                     `spine_norm_eq_zero_iff`
    C-S prose sentence     (l.105) → `spine_cauchy_schwarz`
                                     `spine_cauchy_schwarz_unit`
                                     `spine_cauchy_schwarz_unit_eq_iff`

  Untagged prose that is nonetheless a claim: line 105 of `physics/toesnail.md`,
  "For two unit vectors, the length of the inner product is always <=1 and only
  exactly equal to one of the vectors are parallel or anti-parallel."  It carries
  no `\ltag`, so it has no handle yet; `docs/rigor-debt.md` lists it as the
  Cauchy-Schwarz `verify:lean` target. The essay proposes the handle `cs`.

  EXPLICITLY OUT OF SCOPE here:
  * The bra/dual-vector construction (`physics/toesnail.md` l.68). Mathlib's
    `InnerProductSpace.toDual` needs completeness (Riesz); the spine has not
    demanded completeness yet, so formalising the bra now would import structure
    the narrative has not paid for.
  * Non-normalizable vectors ("vectors of infinite norm", l.116). Those are not
    elements of a normed space at all; they need rigged Hilbert spaces, which
    Mathlib does not carry.
  * The `t1` coin equation (l.59). It is flagged in `docs/rigor-debt.md` as an
    owner-territory conceptual question (probabilities used where amplitudes
    belong); an AI must not formalise a reading of it and thereby pick a side.
  * Uniqueness of a norm-zero vector in a general NORMED space is proven here via
    the inner-product structure. In a bare normed space it is the norm's own
    axiom; the essay separates the two readings of the owner's footnote.

  CONVENTION FINDING (see the essay, "Surfaced for the owner"): Mathlib's
  `⟪·,·⟫` is conjugate-linear in the FIRST slot and linear in the SECOND
  (`InnerProductSpace.smul_left : ⟪r • x, y⟫ = conj r * ⟪x, y⟫`). The spine's
  `\ltag{linearity}` puts linearity in the SECOND slot, `⟪Xi | aPsi + bPhi⟫ =
  a⟪Xi|Psi⟫ + b⟪Xi|Phi⟫`. The two AGREE. This is the physics (Dirac) convention
  and it is the one Mathlib uses, so no translation layer is needed.

  Check (from `/home/tobias/src/toesnail/verify`):
      nice -n19 lake env lean --threads=2 \
        /home/tobias/src/toesnail/docs/dreamed/lean/Spine.lean
-/
import Mathlib.Analysis.InnerProductSpace.Basic

open scoped ComplexInnerProductSpace

namespace ToesnailSpine

/-! ## 1. The zero vector: the owner's two stated properties -/

section ZeroVector

variable {E : Type*} [NormedAddCommGroup E]

/-- `physics/toesnail.md` l.99: `∀ |Ψ⟩ : |Ψ⟩ + |0⟩ = |Ψ⟩`. -/
theorem spine_zero_add (x : E) : x + 0 = x := add_zero x

/-- `physics/toesnail.md` l.100: `∀ |Ψ⟩ : 0 · |Ψ⟩ = |0⟩`. Stated over `ℂ`
    because the spine has by then admitted complex coefficients. -/
theorem spine_zero_smul [Module ℂ E] (x : E) : (0 : ℂ) • x = 0 := zero_smul ℂ x

/-- Footnote `uniqueZero`, reading (a): "*the* vector and not *a* vector".
    If `z` behaves like the zero vector for the addition, it IS the zero vector.
    This is the group-identity uniqueness argument, and it needs NO norm and no
    inner product: it is one line, `z = z + 0 = 0`.

    The spine's own text (l.103, "behaves like the normal number zero by not
    changing anything it is added to") is exactly this hypothesis. -/
theorem spine_zero_unique_additive_identity {z : E} (h : ∀ x : E, x + z = x) :
    z = (0 : E) := by
  have := h 0
  simpa using this

end ZeroVector

/-! ## 2. Norm-zero uniqueness: the other reading of the footnote -/

section NormZero

-- NOTE (essay §4): no `InnerProductSpace` instance is needed in this section.
-- Mathlib bakes `‖x‖ = 0 → x = 0` into `NormedAddCommGroup` itself, so the
-- spine's `positive-definiteness` axiom is discharged one layer BELOW the inner
-- product. That is a fact about where the axiom lives, not a weakening.
variable {E : Type*} [NormedAddCommGroup E]

/-- Footnote `uniqueZero`, reading (b): "for a given vector space the vector of
    norm zero is unique". This is NOT the group-identity fact above; it is
    exactly the `positive-definiteness` axiom the spine already stated at l.89,
    read contrapositively. Only `‖0‖ = 0` is free; `‖x‖ = 0 → x = 0` is the
    content, and it is where the axiom is spent. -/
theorem spine_norm_eq_zero_iff (x : E) : ‖x‖ = 0 ↔ x = 0 := norm_eq_zero

/-- The uniqueness statement in the shape the footnote's wording suggests:
    any two norm-zero vectors coincide. Immediate from the previous lemma;
    recorded separately because it is the sentence the owner actually wrote. -/
theorem spine_norm_zero_unique {x y : E} (hx : ‖x‖ = 0) (hy : ‖y‖ = 0) : x = y := by
  rw [spine_norm_eq_zero_iff] at hx hy
  rw [hx, hy]

end NormZero

/-! ## 3. The three inner-product axioms, matched against Mathlib -/

section Axioms

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- `\ltag{conjugate symmetry}` (l.87): `⟪Φ|Ψ⟫ = conj ⟪Ψ|Φ⟫`.
    The owner writes the conjugated one on the right; Mathlib's
    `inner_conj_symm` states `conj ⟪y, x⟫ = ⟪x, y⟫`, the same equation read
    right-to-left. -/
theorem spine_conjugate_symmetry (Psi Phi : E) :
    ⟪Phi, Psi⟫ = (starRingEnd ℂ) ⟪Psi, Phi⟫ :=
  (inner_conj_symm (𝕜 := ℂ) Phi Psi).symm

/-- `\ltag{linearity}` (l.88): `⟪Ξ | aΨ + bΦ⟫ = a⟪Ξ|Ψ⟫ + b⟪Ξ|Φ⟫`.
    Linearity in the SECOND slot, verbatim as the owner wrote it, with the two
    scalars kept explicit rather than split into an additivity lemma plus a
    homogeneity lemma. It agrees with Mathlib's convention (see the header note). -/
theorem spine_linearity (Xi Psi Phi : E) (a b : ℂ) :
    ⟪Xi, a • Psi + b • Phi⟫ = a * ⟪Xi, Psi⟫ + b * ⟪Xi, Phi⟫ := by
  rw [inner_add_right, inner_smul_right, inner_smul_right]

/-- The conjugate-linearity of the FIRST slot, which the spine does not state.
    It is not an extra axiom: it FOLLOWS from `conjugate symmetry` plus
    `linearity`. Recorded here to make that dependency visible, since a reader
    of the spine may reasonably wonder whether the axiom list is complete. -/
theorem spine_first_slot_is_forced (Psi Phi : E) (a : ℂ) :
    ⟪a • Psi, Phi⟫ = (starRingEnd ℂ) a * ⟪Psi, Phi⟫ := by
  rw [← inner_conj_symm (𝕜 := ℂ) (a • Psi) Phi, inner_smul_right, map_mul,
    inner_conj_symm]

/-- `\ltag{positive-definiteness}` (l.89): `∀ |Ψ⟩ ≠ |0⟩ : ‖Ψ‖² := ⟪Ψ|Ψ⟫ > 0`.

    A translation note the spine's own text makes necessary. The owner's own
    footnote (l.79) observes that complex numbers cannot be ordered, so `> 0`
    for the complex quantity `⟪Ψ|Ψ⟫` is only meaningful once one knows the
    quantity is real. It is: conjugate symmetry with `Φ = Ψ` forces
    `⟪Ψ|Ψ⟫ = conj ⟪Ψ|Ψ⟫`. Lean therefore states the inequality on the real part,
    and the reality is recorded separately below. -/
theorem spine_positive_definiteness {Psi : E} (h : Psi ≠ 0) :
    0 < (⟪Psi, Psi⟫).re := by
  simpa using (re_inner_self_pos (𝕜 := ℂ) (x := Psi)).mpr h

/-- The reality of `⟪Ψ|Ψ⟫`, which the spine's `> 0` implicitly assumes and which
    the spine's own "complex numbers cannot be ordered" footnote makes a real
    obligation. It is a consequence of `conjugate symmetry`, not a new axiom. -/
theorem spine_inner_self_is_real (Psi : E) :
    (starRingEnd ℂ) ⟪Psi, Psi⟫ = ⟪Psi, Psi⟫ :=
  inner_conj_symm (𝕜 := ℂ) Psi Psi

/-- `physics/toesnail.md` l.110: `⟪Ψ|Ψ⟫ =: ‖Ψ‖²`, i.e. the norm the spine defines
    from the inner product is the norm Mathlib's structure carries. Stated on the
    real part for the reason given above. -/
theorem spine_norm_sq (Psi : E) : ‖Psi‖ ^ 2 = (⟪Psi, Psi⟫).re := by
  simpa using norm_sq_eq_re_inner (𝕜 := ℂ) Psi

end Axioms

/-! ## 4. Cauchy-Schwarz: the spine's l.105 sentence -/

section CauchySchwarz

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- Cauchy-Schwarz in general form. The spine does not state this; it states the
    unit-vector corollary below. Recorded as the lemma the corollary is cut from,
    because the "math on demand" question the spine has already posed (how similar
    are two states?) is answered by the RATIO `‖⟪x,y⟫‖ / (‖x‖‖y‖)`, which needs
    the general form to be well defined in `[0,1]`. -/
theorem spine_cauchy_schwarz (x y : E) : ‖⟪x, y⟫‖ ≤ ‖x‖ * ‖y‖ :=
  norm_inner_le_norm x y

/-- `physics/toesnail.md` l.105, first half, VERBATIM: "For two unit vectors, the
    length of the inner product is always `≤ 1`". -/
theorem spine_cauchy_schwarz_unit {x y : E} (hx : ‖x‖ = 1) (hy : ‖y‖ = 1) :
    ‖⟪x, y⟫‖ ≤ 1 := by
  have h := norm_inner_le_norm (𝕜 := ℂ) x y
  rw [hx, hy, one_mul] at h
  exact h

/-- `physics/toesnail.md` l.105, second half: "and only exactly equal to one if
    the vectors are parallel or anti-parallel".

    THE EQUALITY CASE, stated over `ℂ`. Equality holds iff `y = c • x` for a
    complex `c` of modulus one, i.e. iff the two vectors are LINEARLY DEPENDENT.

    "Parallel or anti-parallel" is the REAL equality condition, `c = ±1`. Over
    `ℂ` the set of admissible `c` is the whole unit circle, so it is strictly
    larger: `c = i` gives equality too, and `|Ψ⟩` and `i|Ψ⟩` are neither parallel
    nor anti-parallel in the everyday sense. This is a located finding about the
    owner's prose, surfaced in `docs/dreamed/spine.md`; it is NOT resolved here
    and the spine is not edited. -/
theorem spine_cauchy_schwarz_unit_eq_iff {x y : E} (hx : ‖x‖ = 1) (hy : ‖y‖ = 1) :
    ‖⟪x, y⟫‖ = 1 ↔ ∃ c : ℂ, ‖c‖ = 1 ∧ y = c • x := by
  have hx₀ : x ≠ 0 := by
    intro h; rw [h, norm_zero] at hx; exact one_ne_zero hx.symm
  have hy₀ : y ≠ 0 := by
    intro h; rw [h, norm_zero] at hy; exact one_ne_zero hy.symm
  constructor
  · intro h
    have h' : ‖⟪x, y⟫‖ = ‖x‖ * ‖y‖ := by rw [hx, hy, one_mul, h]
    obtain ⟨r, _, hr⟩ := (norm_inner_eq_norm_iff (𝕜 := ℂ) hx₀ hy₀).mp h'
    refine ⟨r, ?_, hr⟩
    have : ‖y‖ = ‖r‖ * ‖x‖ := by rw [hr, norm_smul]
    rw [hx, hy, mul_one] at this
    exact this.symm
  · rintro ⟨c, hc, rfl⟩
    have h' : ‖⟪x, c • x⟫‖ = ‖x‖ * ‖c • x‖ :=
      (norm_inner_eq_norm_iff (𝕜 := ℂ) hx₀ hy₀).mpr ⟨c, by
        intro h0; rw [h0, zero_smul] at hy₀; exact hy₀ rfl, rfl⟩
    rw [hx, one_mul] at h'
    rw [h', norm_smul, hc, hx, one_mul]

/-- The "similarity" reading the spine gives the inner product (l.122), in the
    form the narrative actually needs: for unit vectors the modulus of the inner
    product lands in `[0,1]`, so it can be read as a degree of overlap, and `0`
    is the orthogonal end of that range. -/
theorem spine_similarity_in_unit_interval {x y : E} (hx : ‖x‖ = 1) (hy : ‖y‖ = 1) :
    0 ≤ ‖⟪x, y⟫‖ ∧ ‖⟪x, y⟫‖ ≤ 1 :=
  ⟨norm_nonneg _, spine_cauchy_schwarz_unit hx hy⟩

/-- The Born-rule bound the spine will need the moment it calls `|⟪x,y⟫|²` a
    probability: that number is at most one. Stated as the immediate corollary
    of the unit-vector Cauchy-Schwarz, since that is the "what does it buy" the
    essay argues the demand-driven introduction should cash. -/
theorem spine_born_bound {x y : E} (hx : ‖x‖ = 1) (hy : ‖y‖ = 1) :
    ‖⟪x, y⟫‖ ^ 2 ≤ 1 := by
  have h := spine_cauchy_schwarz_unit hx hy
  nlinarith [norm_nonneg (⟪x, y⟫)]

end CauchySchwarz

end ToesnailSpine
