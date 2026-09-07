/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-models-ensemble.md`, which
  argues direction (i) of the owner's 2026-09-07 fork: a Bloch-valued truth value is a
  state over MODELS of a theory, not over an agent's epistemic status.

  ------------------------------------------------------------------------------------
  SYMBOL MAP -- how the Lean names read back into the essay's language.
  ------------------------------------------------------------------------------------

    `B`  (a `BooleanAlgebra`)
            the LINDENBAUM-TARSKI algebra of a first-order theory `T`: sentences of the
            language modulo `T`-provable equivalence, with `⊔ ⊓ ᶜ` the classes of
            `∨ ∧ ¬`, `⊤` the class of the theorems and `⊥` the class of the refutable
            sentences. Nothing below constructs it; it is taken as given, exactly as the
            essay does. `B` is the ONLY logical input, and it is a distributive,
            complemented lattice -- that assumption is the whole cost of direction (i).

    `a : B`
            one sentence (strictly, its provable-equivalence class). `a = ⊤` is "T proves
            it", `a = ⊥` is "T refutes it", and `⊥ < a < ⊤` is "T decides neither".

    `FinProb B`
            a finitely additive probability on `B`. By Stone duality this is the same
            thing as a regular Borel probability measure on the Stone space of `B` -- the
            space of complete consistent extensions of `T`, i.e. the "space of models"
            the essay's direction (i) is a state over. That correspondence is CITED in
            the essay, not proved here: this file works on the algebra side only.

    `FinProb.m μ a`
            the measure of the set of models satisfying `a`; the essay's `p(a)`.

    `Bloch`
            a bare triple of reals `(x, y, z)`, read as the Bloch vector of
            `ρ = ½(I + r·σ)`. There is NO Hilbert space here, NO positivity constraint
            and NO density matrix: `Bloch` is a record with three fields.

    `Bloch.Diagonal b`
            `b.x = 0 ∧ b.y = 0`. For a genuine qubit this is exactly the statement that
            `ρ` is diagonal in the `{|0>, |1>}` basis, since `ρ`'s off-diagonal entry is
            `(x - i y)/2`. Here it is the definition, and the reading is the essay's.

    `Bloch.mix t a b`
            convex combination of Bloch vectors, which for density matrices is exactly
            `t ρ_a + (1-t) ρ_b` (the Bloch map is affine).

    `blochOf μ a`
            the state direction (i) assigns to sentence `a` under model-measure `μ`:
            `(0, 0, 2 μ(a) - 1)`. The essay's `z = 2p - 1`.

  ------------------------------------------------------------------------------------
  WHAT IS PROVED (the essay's load-bearing claims, and only those)
  ------------------------------------------------------------------------------------

    `mix_diagonal`, `diagonal_of_weighted_sum`
            a convex combination of diagonal states is diagonal -- binary, and then for
            an arbitrary finite family. This is direction (i)'s central structural cost:
            mixing over models can never leave the z-axis.
    `abs_z_le_r`, `abs_z_eq_r_iff_diagonal`
            `|z| ≤ r` always, with equality exactly on the diagonal states. So the
            diagonal set is precisely the segment where the "confidence" saturates the
            "information", and the rest of the ball is strictly off it.
    `blochOf_diagonal`, `blochOf_mix`
            every state direction (i) produces is diagonal, and the assignment is affine
            in the measure: mixing two model-measures mixes their Bloch vectors.
    `complete_theory_unique`, `complete_theory_poles_only`
            if the theory is COMPLETE (`B` is the two-element algebra: every sentence is
            provable or refutable) then the model-measure is unique and every sentence
            sits exactly at a pole. Incompleteness is the only thing that opens the
            segment at all.
    `undecided_of_strictly_between`
            contrapositive: a sentence with `-1 < z < 1` witnesses incompleteness.

  ------------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE -- do not read this file as more than it is
  ------------------------------------------------------------------------------------
    - NOTHING about quantum mechanics. No Hilbert space, no `ρ ≥ 0`, no trace, no
      entropy, no Born rule. `Bloch` is three reals; `r` is a square root of a sum of
      squares and is called a radius only by the essay.
    - NOTHING about Goedel. No arithmetic, no provability predicate, no diagonal lemma.
      `B` is an abstract Boolean algebra; that the Lindenbaum algebra of PA is countable
      and ATOMLESS is Goedel's business and is argued in the essay's prose, not here.
    - NO Stone duality. The bijection between `FinProb B` and Radon probability measures
      on `Stone B` is the essay's citation (Stone 1936; the automatic countable
      additivity of a finitely additive measure on a clopen algebra). It is used as a
      premise and proved nowhere in this repo.
    - NO claim that direction (i) is CORRECT. This file proves what direction (i) COSTS,
      which is the honest half. The sibling essay `logic-epistemic-state.md` argues the
      rival direction (ii) and a third agent adjudicates.
    - `complete_theory_*` assume `∀ a : B, a = ⊥ ∨ a = ⊤` as a HYPOTHESIS. That the
      Lindenbaum algebra of a complete theory has this form, and that Presburger
      arithmetic is such a theory, are cited facts, not results of this file.
-/
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Order.BooleanAlgebra.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace Toesnail.LogicModels

/-! ## 1. Bloch vectors as bare triples of reals -/

/-- A Bloch vector. Three reals, nothing else: no positivity, no Hilbert space. The
    reading `ρ = ½(I + r·σ)` is the essay's, not Lean's. -/
structure Bloch where
  x : ℝ
  y : ℝ
  z : ℝ

namespace Bloch

/-- The Bloch radius. For a genuine qubit, `S(ρ) = h((1+r)/2)`, so this is the
    information coordinate. Here it is just `√(x² + y² + z²)`. -/
noncomputable def r (b : Bloch) : ℝ := Real.sqrt (b.x ^ 2 + b.y ^ 2 + b.z ^ 2)

/-- Convex combination. For density matrices this is exactly `t ρ₁ + (1-t) ρ₂`, because
    the Bloch map is affine. -/
def mix (t : ℝ) (a b : Bloch) : Bloch :=
  ⟨t * a.x + (1 - t) * b.x, t * a.y + (1 - t) * b.y, t * a.z + (1 - t) * b.z⟩

/-- **Diagonal in the truth basis.** For a qubit the off-diagonal entry of `ρ` is
    `(x - i y)/2`, so vanishing off-diagonals is exactly `x = y = 0`. -/
def Diagonal (b : Bloch) : Prop := b.x = 0 ∧ b.y = 0

theorem r_nonneg (b : Bloch) : 0 ≤ b.r := Real.sqrt_nonneg _

/-- On the diagonal set the radius collapses to `|z|`: the state carries no information
    beyond its truth lean. -/
theorem diagonal_r (b : Bloch) (h : Diagonal b) : b.r = |b.z| := by
  have hx : b.x = 0 := h.1
  have hy : b.y = 0 := h.2
  simp [r, hx, hy, Real.sqrt_sq_eq_abs]

/-- `|z| ≤ r` always. A confident truth value is never cheaper than the information it
    would take to have it. -/
theorem abs_z_le_r (b : Bloch) : |b.z| ≤ b.r := by
  have h : |b.z| = Real.sqrt (b.z ^ 2) := (Real.sqrt_sq_eq_abs _).symm
  rw [h, r]
  apply Real.sqrt_le_sqrt
  nlinarith [sq_nonneg b.x, sq_nonneg b.y]

/-- **Equality in `|z| ≤ r` characterises the diagonal states exactly.** So the
    z-axis segment is not merely *contained* in the ball: it is the exact locus where
    the truth lean saturates the information. Everything direction (i) can produce lives
    on it, and nothing else does. -/
theorem abs_z_eq_r_iff_diagonal (b : Bloch) : |b.z| = b.r ↔ Diagonal b := by
  constructor
  · intro h
    have hnn : (0:ℝ) ≤ b.x ^ 2 + b.y ^ 2 + b.z ^ 2 := by positivity
    have hsq : b.z ^ 2 = b.x ^ 2 + b.y ^ 2 + b.z ^ 2 := by
      have := congrArg (fun s : ℝ => s ^ 2) h
      simpa [r, sq_abs, Real.sq_sqrt hnn] using this
    have hx2 : b.x ^ 2 = 0 := by nlinarith [sq_nonneg b.x, sq_nonneg b.y]
    have hy2 : b.y ^ 2 = 0 := by nlinarith [sq_nonneg b.x, sq_nonneg b.y]
    exact ⟨sq_eq_zero_iff.mp hx2, sq_eq_zero_iff.mp hy2⟩
  · intro h
    exact (diagonal_r b h).symm

/-- **The central structural fact of direction (i), binary form.** A mixture of two
    diagonal states is diagonal. Mixing over models cannot manufacture an off-diagonal
    term, so the equator and the phase are unreachable. -/
theorem mix_diagonal {a b : Bloch} (t : ℝ) (ha : Diagonal a) (hb : Diagonal b) :
    Diagonal (mix t a b) := by
  refine ⟨?_, ?_⟩ <;> simp [mix, ha.1, ha.2, hb.1, hb.2]

/-- `z` is affine under mixing, exactly as a probability is. -/
theorem mix_z (t : ℝ) (a b : Bloch) : (mix t a b).z = t * a.z + (1 - t) * b.z := rfl

/-- **The same fact for an arbitrary finite family**, which is the form the essay
    actually needs: no ensemble over models, however large, leaves the z-axis. -/
theorem diagonal_of_weighted_sum {ι : Type*} (s : Finset ι) (w : ι → ℝ) (f : ι → Bloch)
    (hf : ∀ i ∈ s, Diagonal (f i)) :
    Diagonal ⟨∑ i ∈ s, w i * (f i).x, ∑ i ∈ s, w i * (f i).y, ∑ i ∈ s, w i * (f i).z⟩ := by
  constructor
  · exact Finset.sum_eq_zero fun i hi => by simp [(hf i hi).1]
  · exact Finset.sum_eq_zero fun i hi => by simp [(hf i hi).2]

end Bloch

/-! ## 2. Finitely additive probabilities on a Lindenbaum-Tarski algebra -/

variable {B : Type*} [BooleanAlgebra B]

/-- A finitely additive probability on a Boolean algebra `B`. Read `B` as the
    Lindenbaum-Tarski algebra of a theory, and `m a` as the measure of the set of models
    satisfying the sentence `a`. By Stone duality (cited in the essay, not proved here)
    this is the same data as a regular Borel probability measure on the space of
    complete consistent extensions. -/
structure FinProb (B : Type*) [BooleanAlgebra B] where
  m : B → ℝ
  nonneg : ∀ a, 0 ≤ m a
  m_bot : m ⊥ = 0
  m_top : m ⊤ = 1
  m_add : ∀ a b, Disjoint a b → m (a ⊔ b) = m a + m b

namespace FinProb

variable (μ : FinProb B)

/-- Complementation is `1 - ·`, i.e. `p(¬a) = 1 - p(a)`. This is where classical
    two-valued semantics enters: it holds because `B` is complemented. -/
theorem m_compl (a : B) : μ.m aᶜ = 1 - μ.m a := by
  have hd : Disjoint a aᶜ := disjoint_compl_right
  have h := μ.m_add a aᶜ hd
  rw [sup_compl_eq_top, μ.m_top] at h
  linarith

theorem m_le_one (a : B) : μ.m a ≤ 1 := by
  have h := μ.m_compl a
  have := μ.nonneg aᶜ
  linarith

/-- Monotone: a stronger sentence has no more models. -/
theorem m_mono {a b : B} (h : a ≤ b) : μ.m a ≤ μ.m b := by
  have hsplit : a ⊔ (b ⊓ aᶜ) = b := by
    rw [sup_inf_left, sup_compl_eq_top, inf_top_eq, sup_eq_right.mpr h]
  have hd : Disjoint a (b ⊓ aᶜ) := disjoint_compl_right.mono_right inf_le_right
  have hadd := μ.m_add a (b ⊓ aᶜ) hd
  rw [hsplit] at hadd
  have hnn := μ.nonneg (b ⊓ aᶜ)
  linarith

/-- Mixing two model-measures is again a model-measure: the set of states direction (i)
    can produce is convex. -/
def mix (t : ℝ) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) (μ ν : FinProb B) : FinProb B where
  m := fun a => t * μ.m a + (1 - t) * ν.m a
  nonneg := fun a => by
    have h1 := μ.nonneg a
    have h2 := ν.nonneg a
    nlinarith
  m_bot := by simp [μ.m_bot, ν.m_bot]
  m_top := by rw [μ.m_top, ν.m_top]; ring
  m_add := fun a b hd => by
    rw [μ.m_add a b hd, ν.m_add a b hd]; ring

/-! ## 3. The state direction (i) assigns, and where it lives -/

/-- **Direction (i)'s assignment.** The Bloch vector of a sentence is the model-measure
    of its truth, affinely rescaled: `z = 2p - 1`, with both other coordinates zero
    because a measure supplies probabilities and nothing else. -/
noncomputable def blochOf (μ : FinProb B) (a : B) : Bloch := ⟨0, 0, 2 * μ.m a - 1⟩

/-- **Every state direction (i) produces is diagonal.** This is not a limitation of the
    construction: a measure carries exactly the probabilities, and off-diagonal terms are
    not probabilities of anything. -/
theorem blochOf_diagonal (μ : FinProb B) (a : B) : Bloch.Diagonal (blochOf μ a) :=
  ⟨rfl, rfl⟩

/-- The assignment is affine in the measure: mixing model-measures mixes Bloch vectors.
    Together with `blochOf_diagonal` this says the reachable set is exactly the z-axis
    segment and is closed under everything direction (i) can do to it. -/
theorem blochOf_mix (t : ℝ) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) (μ ν : FinProb B) (a : B) :
    blochOf (mix t ht0 ht1 μ ν) a = Bloch.mix t (blochOf μ a) (blochOf ν a) := by
  simp only [blochOf, Bloch.mix, mix]
  refine Bloch.mk.injEq .. ▸ ?_
  refine ⟨?_, ?_, ?_⟩ <;> ring

/-- `z` is confined to `[-1, 1]`, so the segment is the whole story. -/
theorem blochOf_z_mem (μ : FinProb B) (a : B) :
    -1 ≤ (blochOf μ a).z ∧ (blochOf μ a).z ≤ 1 := by
  have h0 := μ.nonneg a
  have h1 := μ.m_le_one a
  constructor <;> simp only [blochOf] <;> linarith

/-! ## 4. Completeness collapses the segment to the two poles -/

/-- **A complete theory has exactly one model-measure.** If every sentence is provable or
    refutable then `B` is the two-element algebra, and a probability on it is forced.
    The owner's layered architecture wants the core layer to be complete; this is what a
    complete layer's state space looks like. -/
theorem complete_theory_unique (h2 : ∀ a : B, a = ⊥ ∨ a = ⊤) (μ ν : FinProb B) (a : B) :
    μ.m a = ν.m a := by
  rcases h2 a with h | h
  · rw [h, μ.m_bot, ν.m_bot]
  · rw [h, μ.m_top, ν.m_top]

/-- **And every sentence sits at a pole.** No mixing, no segment, no ball: a complete
    theory's Bloch picture is the classical bit `{-1, +1}`. Whatever the interior of the
    segment means, it means INCOMPLETENESS. -/
theorem complete_theory_poles_only (h2 : ∀ a : B, a = ⊥ ∨ a = ⊤) (μ : FinProb B) (a : B) :
    (blochOf μ a).z = -1 ∨ (blochOf μ a).z = 1 := by
  rcases h2 a with h | h
  · left
    show 2 * μ.m a - 1 = -1
    rw [h, μ.m_bot]; norm_num
  · right
    show 2 * μ.m a - 1 = 1
    rw [h, μ.m_top]; norm_num

/-- Contrapositive, the form the essay quotes: a sentence strictly inside the segment is
    a WITNESS to incompleteness. It is neither provable nor refutable. -/
theorem undecided_of_strictly_between (μ : FinProb B) (a : B)
    (hlo : -1 < (blochOf μ a).z) (hhi : (blochOf μ a).z < 1) :
    a ≠ ⊥ ∧ a ≠ ⊤ := by
  constructor
  · intro h
    rw [show (blochOf μ a).z = 2 * μ.m a - 1 from rfl, h, μ.m_bot] at hlo
    linarith
  · intro h
    rw [show (blochOf μ a).z = 2 * μ.m a - 1 from rfl, h, μ.m_top] at hhi
    linarith

/-! ## 5. The Dirac fallback: picking one model is dogmatic

    ADDED after publication, 2026-09-07, alongside the essay's Section 4.4 (the
    Tennenbaum strengthening located by `logic-counterfactual-boundary.md` Section 2.2).

    The essay's Section 1 opens the segment by taking Dirac measures at points of a
    proper clopen set. A Dirac measure is the engineering fallback "never mind which
    measure, just pick one complete extension and believe it". These lemmas say what
    that fallback reports, and the answer is the reason the fallback slips the
    computability wall of Section 4.2: that wall is quoted with a NON-DOGMATIC
    hypothesis, and a Dirac state is exactly a dogmatic one.

    NOT claimed here: anything about computability. That a two-valued state is
    uncomputable is Goedel-Rosser (points) and Tennenbaum (models), both cited in the
    essay and neither formalised anywhere in this repo. -/

/-- Two general facts about any finitely additive probability, needed below. A sentence
    of measure one has a complement of measure zero. -/
theorem m_compl_eq_zero {a : B} (ha : μ.m a = 1) : μ.m aᶜ = 0 := by
  rw [μ.m_compl, ha]; norm_num

/-- And two sentences of measure one have a conjunction of measure one, so the
    measure-one set is closed under conjunction (deductive closure, in the reading). -/
theorem m_inf_eq_one {a b : B} (ha : μ.m a = 1) (hb : μ.m b = 1) : μ.m (a ⊓ b) = 1 := by
  have hsplit : (a ⊓ b) ⊔ (a ⊓ bᶜ) = a := by
    rw [← inf_sup_left, sup_compl_eq_top, inf_top_eq]
  have hd : Disjoint (a ⊓ b) (a ⊓ bᶜ) :=
    disjoint_compl_right.mono inf_le_right inf_le_right
  have hadd := μ.m_add (a ⊓ b) (a ⊓ bᶜ) hd
  rw [hsplit] at hadd
  have hle : μ.m (a ⊓ bᶜ) ≤ μ.m bᶜ := μ.m_mono inf_le_right
  have hc : μ.m bᶜ = 0 := μ.m_compl_eq_zero hb
  have hnn := μ.nonneg (a ⊓ b)
  have hnn2 := μ.nonneg (a ⊓ bᶜ)
  linarith

/-- **A Dirac state**: two-valued, i.e. concentrated on a single point of the Stone
    space. Equivalently, in the essay's reading, a single complete consistent extension
    picked and believed. -/
def IsDirac : Prop := ∀ a : B, μ.m a = 0 ∨ μ.m a = 1

/-- A Dirac state decides every sentence: it is a COMPLETE extension. -/
theorem dirac_decides (h : μ.IsDirac) (a : B) : μ.m a = 1 ∨ μ.m aᶜ = 1 := by
  rcases h a with h0 | h1
  · right; rw [μ.m_compl, h0]; norm_num
  · left; exact h1

/-- And it is consistent: `⊥` never gets measure one. Nothing here needs `IsDirac`; it
    is recorded so the triple complete-consistent-closed is visible in one place, the
    third leg being `m_inf_eq_one`. -/
theorem m_bot_ne_one : μ.m ⊥ ≠ 1 := by
  rw [μ.m_bot]; norm_num

/-- **The finding, machine-checked.** Under the Dirac fallback every sentence sits at a
    pole, INCLUDING the independent ones that opened the segment in the first place. So
    picking a model does not report "undecided"; it reports proven-true or proven-false
    about everything. -/
theorem dirac_poles_only (h : μ.IsDirac) (a : B) :
    (blochOf μ a).z = -1 ∨ (blochOf μ a).z = 1 := by
  rcases h a with h0 | h1
  · left; show 2 * μ.m a - 1 = -1; rw [h0]; norm_num
  · right; show 2 * μ.m a - 1 = 1; rw [h1]; norm_num

/-- Same fact in the report coordinates: a Dirac state has `r = 1` for every sentence,
    i.e. maximal claimed certainty everywhere. This is what makes it DOGMATIC, which is
    precisely the hypothesis the Section 4.2 computability wall assumes away. -/
theorem dirac_r_one (h : μ.IsDirac) (a : B) : (blochOf μ a).r = 1 := by
  rw [Bloch.diagonal_r _ (blochOf_diagonal μ a)]
  rcases dirac_poles_only μ h a with hz | hz <;> rw [hz] <;> norm_num

end FinProb

end Toesnail.LogicModels
