/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-epistemic-state.md`.

  Seed (owner-authored). Two turns, both his own words.

  (1) The founding Bloch question, claude.ai "Falsifiability and Logical Boundaries",
      2025-08-16, `conv-falsifiability.md:116`, verbatim:

          "What about the Bloch sphere instead of a qutrit? Would the origin encode
           unprovable or provable but not yet determined or something entirely different?
           What about the circle at z=0 i.e. as far from proven truth and falsehood as
           possible?"

  (2) The status enumeration, same conversation, `conv-falsifiability.md:366`, verbatim:

          "What states can there actually be for statements in terms of complete logic?
           Proven true, false, probable but undetermined, unprovable, ....?"

  (3) The 2026-09-07 session turn that forked this essay off its sibling, verbatim:

          "can the equator be considered any kind of 'unprovedness' instead, and the
           origin as maximum non-knowledge? don't just consider pure states but also
           mixed ones, i.e. Bloch with r<1 as well"

  This file discharges the SMALL, PURELY STRUCTURAL claims the essay leans on. It proves
  nothing about quantum mechanics, nothing about Goedel, and nothing about whether the
  epistemic reading is the RIGHT reading -- that is the owner's ruling, and the essay
  argues one side of a deliberate fork whose other side is `logic-models-ensemble.md`.

  ---------------------------------------------------------------------------
  SYMBOL MAP -- Lean name  <->  essay language
  ---------------------------------------------------------------------------

  PART A -- the epistemic simplex, which is the essay's proposed sample space.

    `EpiState`         a probability distribution over FOUR mutually exclusive epistemic
                       statuses that an agent may assign to one fixed sentence of one
                       fixed theory. This is direction (ii): the randomness is over WHAT
                       THE AGENT KNOWS, not over which model the agent is in.
                         `pr`   proved      -- the agent holds a proof.
                         `rf`   refuted     -- the agent holds a refutation.
                         `ind`  independent -- the agent holds a proof that the theory
                                               settles neither, e.g. Cohen for CH in ZFC.
                                               SETTLED KNOWLEDGE, and this is the whole
                                               point of the essay.
                         `op`   open        -- the agent holds nothing. Goldbach today.
                       The four are exclusive BY CONSTRUCTION (they are the outcomes of a
                       distribution), which is why no "glut" appears anywhere below; see
                       OUT OF SCOPE.

    `z e`              the TRUTH LEAN, `pr - rf`. Essay's z coordinate; the essay reads it
                       as a Born probability via `p(true) = (1 + z)/2`.
    `r e`              the SETTLEDNESS, `pr + rf + ind`, equivalently `1 - op`. Essay's
                       Bloch radius. NOTE the definitional choice: `ind` counts toward
                       settledness. That single decision is the essay's whole thesis, and
                       everything below is a consequence of it, not evidence for it.

    `r_eq_one_sub_open`   `r = 1 - op`. Settledness is exactly the non-open mass.
    `r_nonneg`, `r_le_one`   `r` lands in [0,1], so it is a legal Bloch radius.
    `abs_z_le_r`       `|z| <= r`. Essay handle `zr-cone`. DERIVED from the simplex, not
                       imposed: `|pr - rf| <= pr + rf <= pr + rf + ind`. This is the
                       essay's strongest structural argument, because the Bloch ball
                       enforces exactly this constraint for free and an unconstrained pair
                       of reals does not.
    `r_zero_imp_z_zero`   `r = 0 -> z = 0`. Essay handle `origin-on-equator`. The owner
                       proposed "equator = unprovedness" and "origin = maximum
                       non-knowledge" as two suggestions; this says they are NOT
                       independent -- the origin lies on the equator necessarily, so the
                       second follows from the first.
    `proved`, `refuted`, `independent`, `openQ`
                       the four vertex states, with `vertex_coords` computing their
                       (z, r) pairs to (1,1), (-1,1), (0,1), (0,0). Essay handle
                       `four-corners`. The two middle rows ARE the essay's headline: both
                       have z = 0, and they differ only in r.
    `dual`             swap `pr` and `rf`: the agent's state about the NEGATION of the
                       sentence. `dual_z`, `dual_r`: z flips sign, r is invariant. Essay
                       handle `neg-fixes-r`. Matches `LogicBloch.lean`'s
                       `neg_monotone_K`: negation moves truth and cannot move information.
    `report_conflates` the essay's stated COST, machine-checked rather than admitted in
                       prose only: two DISTINCT epistemic states share the same (z, r)
                       report. "Proved independent" and "certainly decided, no idea which
                       way" both sit on the equatorial circle. Essay handle `conflation`.

  PART B -- entropy, which is what makes "r measures how settled" well defined.

    `settledEntropy t`   `binEntropy ((1 + t)/2)`. For a qubit density matrix with Bloch
                       radius t this is the von Neumann entropy in nats, because the
                       eigenvalues are `(1 +- t)/2`. That identification is ASSERTED in
                       the essay's prose; below, `settledEntropy` is just a real function.
    `settledEntropy_strictAntiOn`   strictly decreasing on [0,1]. Essay handle
                       `entropy-anti`. Without this, "r measures how settled" is a slogan;
                       with it, r and entropy are order-isomorphic on the admissible range
                       and either may be quoted.
    `settledEntropy_zero`, `settledEntropy_one`   the two endpoints: `log 2` (one full bit
                       of ignorance) at the origin, `0` at the surface.

  PART C -- the same two facts on a bare Bloch triple, with no epistemic reading.

    `Bloch`, `rsq`, `zc`   as in the sibling `lean/LogicBloch.lean` Part C: a bare triple
                       of reals, NO positivity, NO density matrix.
    `zc_sq_le_rsq`     `z^2 <= |r|^2` for any triple. The geometric twin of `abs_z_le_r`,
                       holding for a reason that has nothing to do with logic.
    `rsq_zero_imp_zc_zero`   `|r| = 0 -> z = 0`, i.e. the origin is on the equator, as
                       geometry rather than as epistemology.

  ---------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE -- do not read this file as more than it is
  ---------------------------------------------------------------------------

    - NOTHING here is a theorem about quantum mechanics. No Hilbert space, no density
      matrix, no Hermitian 2x2 matrix, no trace, no positivity. `Bloch` is three reals.
      The claim that `binEntropy ((1+r)/2)` IS the von Neumann entropy of the qubit state
      with Bloch radius r is arithmetic about eigenvalues and is asserted in the essay's
      prose, not proved here.
    - NOTHING here is a theorem about Goedel. No arithmetic, no provability predicate, no
      consistency hypothesis, no diagonal lemma. `EpiState.ind` is a real number; that the
      status it names is INHABITED for ZFC and CH is Cohen's business, not this file's.
    - NOTHING here shows the epistemic simplex is the RIGHT sample space. `EpiState` is a
      3-simplex and the Bloch ball is not a simplex -- 4 extreme points against a
      continuum -- so the two convex bodies are NOT isomorphic and no map between them is
      constructed below. The essay concedes this at length and states the surplus
      explicitly: only the 2-dimensional (z, r) wedge is used, and the azimuth is unearned.
    - `report_conflates` is a COST, not a defect of the proof. It is included precisely
      because an adjudicating reader should be able to check the essay's stated weakness
      mechanically instead of taking the prose's word for it.
    - No glut appears anywhere, and none can: the four statuses are the outcomes of one
      probability distribution, hence exclusive by construction. That is an INDEPENDENT
      route to the sibling `logic-bloch-poles.md`'s "the ball is Kleene, not Belnap"
      verdict, and it does not overturn it. Nothing here proves a Belnap claim.
    - Strict monotonicity of `settledEntropy` is imported from Mathlib
      (`Real.binEntropy_strictAntiOn`); this file supplies only the change of variable.
-/
import Mathlib.Analysis.SpecialFunctions.BinaryEntropy
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace Toesnail.LogicEpistemic

open Real Set

/-! ## Part A. The epistemic simplex. -/

/-- A probability distribution over the four mutually exclusive epistemic statuses an
    agent may assign to one fixed sentence of one fixed theory.

    This is direction (ii) of the essay's fork: the randomness is over WHAT THE AGENT
    KNOWS, not over which model of the theory obtains. The decisive difference is that
    `ind` -- "the agent has a proof that the theory settles neither way" -- is a status
    at all. Under a model-ensemble reading it is not, because a sentence independent of
    the theory is still true or false in each individual model. -/
structure EpiState where
  /-- Weight on "the agent holds a proof". -/
  pr : ℝ
  /-- Weight on "the agent holds a refutation". -/
  rf : ℝ
  /-- Weight on "the agent holds a proof of independence". Settled knowledge. -/
  ind : ℝ
  /-- Weight on "the agent holds nothing at all". -/
  op : ℝ
  pr_nonneg : 0 ≤ pr
  rf_nonneg : 0 ≤ rf
  ind_nonneg : 0 ≤ ind
  op_nonneg : 0 ≤ op
  sum_one : pr + rf + ind + op = 1

namespace EpiState

/-- **The truth lean.** The essay reads it as a Born probability, `p(true) = (1 + z)/2`.
    Only the two located statuses contribute; independence and openness are silent about
    which way, which is the entire reason they share `z = 0`. -/
def z (e : EpiState) : ℝ := e.pr - e.rf

/-- **The settledness.** All three SETTLED statuses contribute, including independence.
    This single definitional choice is the essay's thesis; every result below is a
    consequence of it and none of them is evidence for it. -/
def r (e : EpiState) : ℝ := e.pr + e.rf + e.ind

/-- Settledness is exactly the complement of the open weight. -/
theorem r_eq_one_sub_open (e : EpiState) : r e = 1 - e.op := by
  have := e.sum_one; simp only [r]; linarith

theorem r_nonneg (e : EpiState) : 0 ≤ r e := by
  simp only [r]; linarith [e.pr_nonneg, e.rf_nonneg, e.ind_nonneg]

theorem r_le_one (e : EpiState) : r e ≤ 1 := by
  rw [r_eq_one_sub_open]; linarith [e.op_nonneg]

/-- **The cone constraint, derived rather than imposed** (essay handle `zr-cone`).

    `|z| ≤ r`, because `|pr - rf| ≤ pr + rf ≤ pr + rf + ind`. The Bloch ball enforces
    exactly this for free (a component never exceeds the norm) and an unconstrained pair
    of reals does not, which is the essay's strongest structural argument for using the
    ball as the container of the report.

    Read epistemically: a report can never be more CONFIDENT than it is SETTLED. -/
theorem abs_z_le_r (e : EpiState) : |z e| ≤ r e := by
  rw [abs_le]
  constructor <;> simp only [z, r] <;>
    linarith [e.pr_nonneg, e.rf_nonneg, e.ind_nonneg]

/-- **The owner's two proposals are not independent** (essay handle `origin-on-equator`).

    He asked whether the equator could be "unprovedness" and, separately, whether the
    origin could be "maximum non-knowledge". Since `|z| ≤ r`, an `r = 0` state has
    `z = 0`, so the origin lies ON the equatorial disc necessarily. The second suggestion
    is therefore a consequence of the first, not a second axis of the design. -/
theorem r_zero_imp_z_zero (e : EpiState) (h : r e = 0) : z e = 0 :=
  abs_nonpos_iff.mp (h ▸ abs_z_le_r e)

/-! ### The four vertices, and where they land. -/

/-- The agent holds a proof. -/
def proved : EpiState :=
  ⟨1, 0, 0, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- The agent holds a refutation. -/
def refuted : EpiState :=
  ⟨0, 1, 0, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- The agent holds a proof of INDEPENDENCE. Settled knowledge, and the whole point. -/
def independent : EpiState :=
  ⟨0, 0, 1, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- The agent holds nothing. -/
def openQ : EpiState :=
  ⟨0, 0, 0, 1, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **The essay's headline, computed** (essay handle `four-corners`).

    North pole, south pole, EQUATORIAL CIRCLE, ORIGIN. The two middle rows are the claim
    the essay exists to test: `independent` and `openQ` both have `z = 0`, so both are
    "unproved", and they are separated by `r` alone -- proved independence is settled
    (r = 1) and an open question is not (r = 0). -/
theorem vertex_coords :
    (z proved = 1 ∧ r proved = 1) ∧
    (z refuted = -1 ∧ r refuted = 1) ∧
    (z independent = 0 ∧ r independent = 1) ∧
    (z openQ = 0 ∧ r openQ = 0) := by
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ?_, ?_⟩ <;>
    simp [z, r, proved, refuted, independent, openQ]

/-- The two states the essay says must be told apart really are told apart by `r`, and
    really are NOT told apart by `z`. -/
theorem independent_ne_open_in_r :
    z independent = z openQ ∧ r independent ≠ r openQ := by
  constructor
  · simp [z, independent, openQ]
  · simp [r, independent, openQ]

/-! ### Negation moves the truth lean and cannot move the settledness. -/

/-- The agent's state about the NEGATION of the sentence: proofs and refutations swap,
    independence and openness are unmoved (if the theory settles neither `P` nor `¬P`,
    that is one fact about both; likewise if nothing is known). -/
def dual (e : EpiState) : EpiState :=
  ⟨e.rf, e.pr, e.ind, e.op, e.rf_nonneg, e.pr_nonneg, e.ind_nonneg, e.op_nonneg,
    by have := e.sum_one; linarith⟩

theorem dual_z (e : EpiState) : z (dual e) = -z e := by simp only [z, dual]; ring

/-- **Settledness is negation-invariant** (essay handle `neg-fixes-r`). Knowing more about
    `P` is knowing more about `¬P`; only the direction flips. This is the same fact the
    sibling `lean/LogicBloch.lean` proves for Belnap's knowledge order as
    `neg_monotone_K`, reached here from the probability side instead of the lattice side. -/
theorem dual_r (e : EpiState) : r (dual e) = r e := by simp only [r, dual]; ring

theorem dual_dual (e : EpiState) : dual (dual e) = e := rfl

/-! ### The cost, machine-checked rather than merely admitted. -/

/-- "Certainly decided, no idea which way": half the weight on a proof, half on a
    refutation, nothing on independence. -/
noncomputable def splitDecided : EpiState :=
  ⟨1/2, 1/2, 0, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **The (z, r) report is lossy** (essay handle `conflation`).

    `independent` and `splitDecided` are DIFFERENT epistemic states -- "the theory settles
    nothing, and I proved that" against "the theory settles it, and I have no idea which
    way" -- and they produce the SAME report. Both land on the equatorial circle.

    This is the essay's own stated cost, included so an adjudicating reader can check it
    mechanically instead of trusting the prose. It is the residue of a dimension count:
    the epistemic simplex is 3-dimensional, the report is 2-dimensional, so exactly one
    dimension is discarded, and this is a witness that it is a MEANINGFUL one. -/
theorem report_conflates :
    independent ≠ splitDecided ∧
    z independent = z splitDecided ∧
    r independent = r splitDecided := by
  refine ⟨?_, ?_, ?_⟩
  · intro h
    have : (independent.ind : ℝ) = splitDecided.ind := by rw [h]
    simp [independent, splitDecided] at this
  · simp [z, independent, splitDecided]
  · norm_num [r, independent, splitDecided]

end EpiState

/-! ## Part B. Entropy, which is what makes "r measures how settled" well defined. -/

/-- Binary entropy of the eigenvalue pair `(1 ± t)/2`, in nats. For a qubit density
    matrix with Bloch radius `t` this is the von Neumann entropy -- an arithmetic fact
    about eigenvalues that the essay asserts in prose and this file does not prove. Here
    it is simply a real function of a real. -/
noncomputable def settledEntropy (t : ℝ) : ℝ := binEntropy ((1 + t) / 2)

/-- Maximum ignorance at the origin: one full bit, `log 2` nats. -/
theorem settledEntropy_zero : settledEntropy 0 = Real.log 2 := by
  have h : ((1:ℝ) + 0) / 2 = 2⁻¹ := by norm_num
  simp only [settledEntropy, h, binEntropy_two_inv]

/-- Zero entropy on the surface: a pure state, whichever direction it points. Note this
    holds at the EQUATOR as much as at the poles, which is exactly the essay's separation
    of "settled" from "true". -/
theorem settledEntropy_one : settledEntropy 1 = 0 := by
  simp only [settledEntropy]
  norm_num

/-- **`r` and entropy are order-isomorphic on the admissible range** (essay handle
    `entropy-anti`): `settledEntropy` is STRICTLY decreasing on `[0,1]`.

    Without this, "the radius measures how settled the agent is" is a slogan; with it,
    the two quantities are interchangeable as a settledness scale, and the essay may
    quote whichever is convenient. Strictness is what rules out plateaus, i.e. rules out
    a range of radii that all mean the same thing. -/
theorem settledEntropy_strictAntiOn : StrictAntiOn settledEntropy (Icc (0:ℝ) 1) := by
  intro a ha b hb hab
  simp only [mem_Icc] at ha hb
  refine binEntropy_strictAntiOn ?_ ?_ ?_
  · exact ⟨by norm_num; linarith [ha.1], by linarith [ha.2]⟩
  · exact ⟨by norm_num; linarith [hb.1], by linarith [hb.2]⟩
  · linarith

/-! ## Part C. The same two facts on a bare Bloch triple, with no epistemic reading. -/

/-- A Bloch vector as a bare triple of reals. As in the sibling `lean/LogicBloch.lean`:
    no positivity constraint, no density matrix, no Hilbert space. -/
abbrev Bloch := ℝ × ℝ × ℝ

namespace Bloch

/-- Squared Bloch radius. -/
def rsq (v : Bloch) : ℝ := v.1 ^ 2 + v.2.1 ^ 2 + v.2.2 ^ 2

/-- The z coordinate. -/
def zc (v : Bloch) : ℝ := v.2.2

/-- The geometric twin of `EpiState.abs_z_le_r`: a component never exceeds the norm.
    Stated squared so no square root is needed. The point of proving it twice is that the
    two proofs share nothing: one is convexity of a probability simplex, the other is
    Pythagoras. The essay's constraint therefore holds on both sides of the proposed
    correspondence for independent reasons, which is why the ball is a SOUND container
    for the report even though it is not a faithful one. -/
theorem zc_sq_le_rsq (v : Bloch) : zc v ^ 2 ≤ rsq v := by
  simp only [zc, rsq]
  nlinarith [sq_nonneg v.1, sq_nonneg v.2.1]

/-- **The origin is on the equator**, as geometry rather than as epistemology. This is
    `EpiState.r_zero_imp_z_zero` again, and again the two proofs share nothing. -/
theorem rsq_zero_imp_zc_zero (v : Bloch) (h : rsq v = 0) : zc v = 0 := by
  have h1 : zc v ^ 2 ≤ 0 := h ▸ zc_sq_le_rsq v
  nlinarith [sq_nonneg (zc v)]

/-- The equatorial DISC, the essay's proposed "unproved" set: every point with `z = 0`,
    at any radius. The circle `rsq = 1` and the origin `rsq = 0` are both in it, and they
    are the essay's two headline inhabitants. -/
def equatorialDisc (v : Bloch) : Prop := zc v = 0 ∧ rsq v ≤ 1

theorem origin_mem_disc : equatorialDisc (0, 0, 0) := by
  constructor <;> simp [zc, rsq]

theorem circle_mem_disc : equatorialDisc (1, 0, 0) := by
  constructor <;> simp [zc, rsq]

/-- The two headline inhabitants are distinct points of the same disc, separated by the
    radius alone. This is `EpiState.independent_ne_open_in_r` transported to geometry. -/
theorem disc_two_kinds :
    ∃ a b : Bloch, equatorialDisc a ∧ equatorialDisc b ∧ rsq a ≠ rsq b := by
  refine ⟨(1, 0, 0), (0, 0, 0), circle_mem_disc, origin_mem_disc, ?_⟩
  simp only [rsq]
  norm_num

end Bloch

end Toesnail.LogicEpistemic
