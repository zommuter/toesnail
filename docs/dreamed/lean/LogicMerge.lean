/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed ADJUDICATION
  `docs/dreamed/logic-models-vs-epistemic.md`.

  This file does not re-prove either side of the fork. It discharges the ADJUDICATION:
  the two sibling essays make claims about the SAME object -- the set of (z, r) reports a
  Bloch-valued truth can carry -- and those claims are incompatible. The incompatibility
  is exhibited here as a set-membership fact with a witness, proved both ways.

  The fork, in one line each. Both essays start from the owner's 2026-09-07 turn:

      "can the equator be considered any kind of 'unprovedness' instead, and the origin
       as maximum non-knowledge? don't just consider pure states but also mixed ones,
       i.e. Bloch with r<1 as well"

    (i)  `docs/dreamed/logic-models-ensemble.md` -- the density matrix is a state over
         MODELS. A measure over the complete consistent extensions of a theory hands you
         ONE number, p, so the state is diag(p, 1-p) and the reachable set is the SEGMENT
         `|z| = r`.
    (ii) `docs/dreamed/logic-epistemic-state.md` -- the density matrix is a state over
         EPISTEMIC STATUS. A distribution over four statuses (proved, refuted,
         independent, open) hands you three free numbers, so the reachable set is the
         two-dimensional WEDGE `|z| <= r <= 1`.

  Both cannot be the reachable set of the same object. `equator_separates` settles it
  with the point (z, r) = (0, 1): it is in (ii)'s set and not in (i)'s.

  ---------------------------------------------------------------------------
  SYMBOL MAP -- Lean name  <->  the adjudication's language
  ---------------------------------------------------------------------------

  PART A -- the two reachable sets, as bare predicates on a pair of reals.

    `ModelsReach z r`   `|z| = r  &  r <= 1`. Essay (i)'s reachable set. The equality is
                        the whole of (i)'s geometry: a measure supplies the diagonal
                        entries of rho and nothing else, so the Bloch vector is
                        (0, 0, 2p-1) and its norm IS |z|.
    `StatusReach z r`   `|z| <= r <= 1`. Essay (ii)'s reachable set, and also exactly the
                        (z, r) shadow of the full Bloch ball (`ball_shadow`), which is
                        why the ball contributes nothing to the report beyond an azimuth
                        three essays in this cluster now agree carries nothing.
    `models_subset_status`   (i)'s set is contained in (ii)'s. The disagreement is
                        therefore not a clash but a PROPER CONTAINMENT, which is the
                        adjudication's central structural finding: (ii) does not
                        contradict (i), it strictly extends it.
    `equator_separates` the witness. `(0, 1)` -- "unproved, and settled" -- is in
                        `StatusReach` and not in `ModelsReach`. This is the single point
                        the whole fork turns on. In (ii) it is the state of an agent
                        holding a Cohen-style independence proof. In (i) it does not
                        exist.

  PART B -- (i)'s side, re-derived here rather than taken from the sibling.

    `Bloch`, `nrm`      a bare triple of reals and its Euclidean norm. NO positivity, NO
                        trace, NO Hilbert space. See OUT OF SCOPE.
    `diag_nrm_eq_abs_z` a Bloch triple with `x = y = 0` has `nrm = |z|`. This is the one
                        line of (i)'s geometry, and it is an identity about square roots,
                        not a fact about logic.
    `modelReport`       the report a measure `p` produces: `(2p - 1, |2p - 1|)`.
    `modelReport_mem`   it always lands in `ModelsReach`. (i)'s claim, confirmed.
    `models_z_zero_forces_origin`
                        **The operational consequence, and the sharpest thing in the
                        file.** Inside (i), `z = 0` forces `r = 0`. So under (i) the two
                        reports a layered reasoner's scheduler must tell apart -- "I
                        proved this is undecidable here, stop asking" and "I have got
                        nowhere yet, allocate more budget" -- are the SAME point. That is
                        not an inconvenience of (i); it is a theorem about it.
    `status_z_zero_free`
                        the contrast: inside (ii) every `r` in [0, 1] is available at
                        `z = 0`, so the same two reports are the two ends of a radius.

  PART C -- (ii)'s side, re-derived here rather than taken from the sibling.

    `Status`            a probability distribution over the four epistemic statuses.
                        Fields `pv` (proved), `rf` (refuted), `ind` (independent), `op`
                        (open). Re-declared here on purpose: the adjudication must not
                        inherit the sibling's definitions if it is going to check the
                        sibling's arithmetic.
    `zz`, `rr`, `report`  truth lean `pv - rf`, settledness `pv + rf + ind`, and the pair.
    `report_mem`        every status distribution reports inside `StatusReach`.
    `vertex_coords`     **(ii)'s headline, checked independently.** The four statuses land
                        at (1,1), (-1,1), (0,1), (0,0): north pole, south pole,
                        equatorial circle, origin. CONFIRMED.
    `report_conflates`  **(ii)'s self-reported cost, checked independently.** The states
                        `independent = (0,0,1,0)` and `coin = (1/2,1/2,0,0)` are distinct
                        and report the same pair `(0,1)`. So the equatorial circle cannot
                        distinguish "proved independent" from "certainly decided, no idea
                        which way". CONFIRMED. The essay's honesty about its own cost
                        survives an adversarial check.

  PART D -- the two findings the adjudication adds, which neither sibling states.

    `enc`, `enc_injective`, `enc_lands`
                        **The pigeonhole of `logic-bloch-poles.md` §1 is dissolved by the
                        owner's own question.** That essay argues from
                        `no_two_pole_encoding` (no injection from three statuses into two
                        poles) to the recommendation that the poles be `provable` against
                        `not provable` (its encoding (b)). The Lean theorem is correct.
                        The inference needs a further premise -- that every status sits at
                        a POLE -- and admitting mixed states retracts it. Here is an
                        explicit injection from the three statuses into the report
                        triangle, with all three images admissible. Three things fit,
                        because the target is a triangle and not a two-element set.
                        This does NOT refute `no_two_pole_encoding`; it shows the
                        recommendation resting on it is not forced once `r < 1` is
                        allowed.
    `josangU`, `josang_gap`, `josang_eq_iff`, `josang_ne_at_independent`
                        **A located arithmetic error in `logic-epistemic-state.md` §7.**
                        That essay reports "Josang's `u` is (ii)'s `1 - r`". Josang's
                        uncertainty mass under the natural map is the non-located weight
                        `ind + op`; (ii)'s `1 - r` is `op` alone. They agree exactly when
                        `ind = 0` -- which is precisely the case in which (ii) reduces to
                        subjective logic and has nothing new to say. So (ii) UNDER-claims
                        its own novelty at the point where it concedes the most.
    `ball_shadow`       for every admissible report there is a Bloch triple realising it,
                        so `StatusReach` is exactly the ball's (z, r) shadow. Combined
                        with `models_subset_status`, this says the ball buys the report
                        NOTHING that the triangle `{|z| <= r <= 1}` does not already buy.

  ---------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE -- do not read this file as more than it is
  ---------------------------------------------------------------------------

    - NOTHING here is a theorem about quantum mechanics. `Bloch` is three reals. There is
      no density matrix, no trace, no positivity constraint, no Hilbert space, and no
      claim that `nrm` is the radius of anything physical. That `S = h((1+r)/2)` is the
      von Neumann entropy is arithmetic about eigenvalues and is asserted in prose in the
      siblings, not proved anywhere in this repo.
    - NOTHING here is a theorem about Goedel, Cohen, Stone duality, or measure theory.
      `Status.ind` is a real number. That the status it names is INHABITED for ZFC and CH
      is Cohen's business. That the Lindenbaum-Tarski algebra of PA is countable and
      atomless, hence that its Stone space is Cantor space, is essay (i)'s §1 prose and
      is proved nowhere here -- it is the largest unformalized load-bearing step in the
      whole cluster.
    - NOTHING here decides the fork. `equator_separates` shows the two reachable sets are
      different sets; WHICH of them the owner's construction should use is his ruling.
      A delegated agent's verdict is a recommendation, never a self-settling decision.
    - `enc_injective` is a statement about a triangle in the plane. It is NOT a claim that
      the three statuses are quantum states, that the triangle is a state space, or that
      `logic-bloch-poles.md`'s encoding (b) is wrong. It shows one argument for it does
      not survive the admission of mixed states, which is a narrower claim.
    - No Bauer simplex, no Choquet theory, no C*-algebra. Essay (i)'s claim that a
      unital C*-algebra's state space is a simplex iff the algebra is commutative is
      cited there from the literature and is not touched here.
-/
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace Toesnail.LogicMerge

/-! ## Part A. The two reachable sets.

The whole fork reduces to two predicates on a pair of reals. Everything else in the two
essays is the argument for one or the other; this section is the arithmetic that decides
whether they are the same set. They are not. -/

/-- **Essay (i)'s reachable set.** A state over models is diagonal in the truth basis, so
    its Bloch vector is `(0, 0, z)` and its length is exactly `|z|`. The reachable set is
    therefore the segment on which the constraint `|z| <= r` is SATURATED. -/
def ModelsReach (z r : ℝ) : Prop := |z| = r ∧ r ≤ 1

/-- **Essay (ii)'s reachable set.** A distribution over four epistemic statuses has three
    free parameters and reports two of them, so the constraint `|z| <= r` is available
    without being saturated. The set is the two-dimensional triangle with vertices
    `(1,1)`, `(-1,1)`, `(0,0)`. -/
def StatusReach (z r : ℝ) : Prop := |z| ≤ r ∧ r ≤ 1

/-- (i)'s set sits inside (ii)'s. The two essays are therefore not making contradictory
    claims about a shared object: (ii) strictly extends (i). Recording the containment
    matters, because it is what makes the fork adjudicable at all -- had the sets merely
    overlapped, "which is right" would have no answer. -/
theorem models_subset_status {z r : ℝ} (h : ModelsReach z r) : StatusReach z r :=
  ⟨le_of_eq h.1, h.2⟩

/-- The witness for (ii): "unproved, and settled" is an admissible report. Under (ii) it
    is the state of an agent holding a proof that the theory decides neither way. -/
theorem equator_mem_status : StatusReach 0 1 := by
  constructor <;> norm_num

/-- The witness against (i): the same point is NOT in (i)'s reachable set, because
    `|0| = 0 ≠ 1`. Under a state over models there is no such state, and the reason is
    structural rather than accidental -- a measure supplies one number, and one number
    cannot say both "the completions split evenly" and "I am certain about the split". -/
theorem equator_not_mem_models : ¬ ModelsReach 0 1 := by
  rintro ⟨h, -⟩
  norm_num at h

/-- **The adjudication, stated as the set-membership fact it is.** The two sibling essays
    describe different sets, and `(z, r) = (0, 1)` is in one and not the other.

    This is the load-bearing disagreement of the whole fork. `logic-models-ensemble.md`
    §2 consequence 4 uses it to argue that `logic-bloch-poles.md` §7.3's two-coordinate
    thesis collapses to one number; `logic-epistemic-state.md` §0 item 4 uses it to argue
    the thesis survives. Both are right about their own reading, and the essays are
    therefore not in error -- the object they are readings OF is what has to be chosen. -/
theorem equator_separates : ∃ z r : ℝ, StatusReach z r ∧ ¬ ModelsReach z r :=
  ⟨0, 1, equator_mem_status, equator_not_mem_models⟩

/-! ## Part B. Essay (i)'s side, re-derived. -/

/-- A bare triple of reals. No positivity, no trace, no Hilbert space, no density matrix.
    Same convention as the sibling files' Part C. -/
structure Bloch where
  /-- First coordinate. -/
  x : ℝ
  /-- Second coordinate. -/
  y : ℝ
  /-- Third coordinate, read by the cluster as the truth lean. -/
  z : ℝ

/-- Euclidean length of the triple. -/
noncomputable def nrm (b : Bloch) : ℝ := Real.sqrt (b.x ^ 2 + b.y ^ 2 + b.z ^ 2)

/-- **(i)'s one line of geometry.** A diagonal state has `x = y = 0`, so its length is
    exactly `|z|`. This is an identity about square roots; nothing about logic, models or
    incompleteness enters. It is why (i)'s reachable set saturates `|z| <= r`. -/
theorem diag_nrm_eq_abs_z (b : Bloch) (hx : b.x = 0) (hy : b.y = 0) : nrm b = |b.z| := by
  simp only [nrm, hx, hy]
  rw [show (0:ℝ) ^ 2 + 0 ^ 2 + b.z ^ 2 = b.z ^ 2 by ring]
  exact Real.sqrt_sq_eq_abs b.z

/-- The report a model-measure `p` produces: truth lean `2p - 1`, settledness `|2p - 1|`
    (the length of the diagonal Bloch vector, by `diag_nrm_eq_abs_z`). -/
noncomputable def modelReport (p : ℝ) : ℝ × ℝ := (2 * p - 1, |2 * p - 1|)

/-- Every model-measure lands in `ModelsReach`. Essay (i)'s claim, confirmed. -/
theorem modelReport_mem {p : ℝ} (h0 : 0 ≤ p) (h1 : p ≤ 1) :
    ModelsReach (modelReport p).1 (modelReport p).2 := by
  refine ⟨rfl, ?_⟩
  simp only [modelReport]
  rw [abs_le]
  constructor <;> linarith

/-- **Under (i), "unproved" forces "maximally ignorant".**

    This is the theorem the adjudication turns on operationally. The owner's stated
    application is a layered reasoner whose decidable core consumes the incomplete
    layer's reports. Its scheduler must distinguish

      "I proved this is undecidable here"   -> stop asking, escalate or accept
      "I have got nowhere yet"              -> allocate more budget, ask again

    Under (i) both report `z = 0`, and `z = 0` forces `r = 0`, so both are the origin.
    The single operational distinction the stated application needs is the one this
    reading provably collapses. Essay (i) states the cost itself (its §7 C2, C4); this
    is the arithmetic behind it. -/
theorem models_z_zero_forces_origin {z r : ℝ} (h : ModelsReach z r) (hz : z = 0) :
    r = 0 := by
  rw [← h.1, hz, abs_zero]

/-- The contrast, for the same two reports. Under (ii) every settledness in `[0,1]` is
    available at `z = 0`, so the scheduler's two cases are the two ends of one radius. -/
theorem status_z_zero_free {r : ℝ} (h0 : 0 ≤ r) (h1 : r ≤ 1) : StatusReach 0 r :=
  ⟨by simpa using h0, h1⟩

/-! ## Part C. Essay (ii)'s side, re-derived rather than imported.

The definitions below deliberately duplicate `lean/LogicEpistemic.lean`. An adjudicator
that imports the essay's own definitions cannot check the essay's arithmetic. -/

/-- A probability distribution over the four mutually exclusive epistemic statuses an
    agent may hold about one fixed sentence of one fixed theory. -/
structure Status where
  /-- Weight on "the agent holds a proof". -/
  pv : ℝ
  /-- Weight on "the agent holds a refutation". -/
  rf : ℝ
  /-- Weight on "the agent holds a proof that the theory settles neither". -/
  ind : ℝ
  /-- Weight on "the agent holds nothing at all". -/
  op : ℝ
  pv_nonneg : 0 ≤ pv
  rf_nonneg : 0 ≤ rf
  ind_nonneg : 0 ≤ ind
  op_nonneg : 0 ≤ op
  sum_one : pv + rf + ind + op = 1

/-- Truth lean: only the two LOCATED statuses contribute. -/
def zz (s : Status) : ℝ := s.pv - s.rf

/-- Settledness: every status except ignorance contributes, independence included. That
    single definitional choice is essay (ii)'s entire thesis. -/
def rr (s : Status) : ℝ := s.pv + s.rf + s.ind

/-- The pair the layer hands its consumer. -/
def report (s : Status) : ℝ × ℝ := (zz s, rr s)

/-- Every status distribution reports inside (ii)'s wedge. -/
theorem report_mem (s : Status) : StatusReach (report s).1 (report s).2 := by
  have h := s.sum_one
  refine ⟨?_, ?_⟩
  · simp only [report, zz, rr]
    rw [abs_le]
    exact ⟨by linarith [s.pv_nonneg, s.rf_nonneg, s.ind_nonneg],
           by linarith [s.pv_nonneg, s.rf_nonneg, s.ind_nonneg]⟩
  · simp only [report, rr]
    linarith [s.op_nonneg]

/-- The agent holds a proof. -/
def proved : Status := ⟨1, 0, 0, 0, by norm_num, le_refl 0, le_refl 0, le_refl 0, by norm_num⟩

/-- The agent holds a refutation. -/
def refuted : Status := ⟨0, 1, 0, 0, le_refl 0, by norm_num, le_refl 0, le_refl 0, by norm_num⟩

/-- The agent holds a proof that the theory settles neither way -- Cohen for CH in ZFC. -/
def independent : Status := ⟨0, 0, 1, 0, le_refl 0, le_refl 0, by norm_num, le_refl 0, by norm_num⟩

/-- The agent holds nothing. Goldbach today. -/
def openq : Status := ⟨0, 0, 0, 1, le_refl 0, le_refl 0, le_refl 0, by norm_num, by norm_num⟩

/-- "Certainly decided, no idea which way": Ellsberg's known-fair coin, and Josang's
    `b = d = 1/2`, `u = 0` opinion. It is NOT an independence proof. -/
noncomputable def coin : Status :=
  ⟨1/2, 1/2, 0, 0, by norm_num, by norm_num, le_refl 0, le_refl 0, by norm_num⟩

/-- **Essay (ii)'s headline, checked independently: CONFIRMED.**

    The four statuses land at north pole, south pole, equatorial circle and origin. Both
    middle entries are "unproved" in the exact sense that `p(true) = (1+z)/2 = 1/2`, and
    only `r` separates them. This is the fact the owner's question was reaching for, and
    the arithmetic is elementary enough that it survives any adversarial reading. -/
theorem vertex_coords :
    report proved = (1, 1) ∧ report refuted = (-1, 1) ∧
    report independent = (0, 1) ∧ report openq = (0, 0) := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    simp [report, zz, rr, proved, refuted, independent, openq]

/-- Independence and openness differ, and they differ in `r` alone. -/
theorem independent_ne_open_in_r : zz independent = zz openq ∧ rr independent ≠ rr openq := by
  refine ⟨by simp [zz, independent, openq], ?_⟩
  simp [rr, independent, openq]

/-- **Essay (ii)'s self-reported cost, checked independently: CONFIRMED.**

    `report` is not injective, and the two states it identifies are exactly the two the
    essay names. "Proved independent" and "certainly decided, no idea which way" both
    report `(0, 1)`. So the equatorial circle cannot distinguish a Cohen-style
    independence proof from an Ellsberg known-fair coin.

    Worth stating why this matters to the adjudication rather than only to essay (ii):
    the scheduler distinction of `models_z_zero_forces_origin` is the one (ii) DOES make,
    and this is a second distinction it does NOT make. (ii) therefore wins the fork on
    one distinction and loses a different one, and the loss is to a CLASSICAL model, not
    to essay (i). -/
theorem report_conflates : report independent = report coin ∧ independent ≠ coin := by
  constructor
  · simp [report, zz, rr, independent, coin]
    norm_num
  · intro h
    have hi : independent.ind = coin.ind := congrArg Status.ind h
    simp [independent, coin] at hi

/-- Stated affinely: independence is NOT an extreme point of the report triangle. It is
    the midpoint of the top edge, which is why an even mixture of `proved` and `refuted`
    reaches it. The three extreme points are `proved`, `refuted`, `openq`. -/
theorem independent_is_midpoint :
    report independent = ((report proved).1 / 2 + (report refuted).1 / 2,
                          (report proved).2 / 2 + (report refuted).2 / 2) := by
  simp [report, zz, rr, independent, proved, refuted]
  norm_num

/-! ## Part D. What the adjudication adds. -/

/-- The three theory-relative statuses of a sentence. -/
inductive Trichotomy
  /-- The theory proves the sentence. -/
  | provable : Trichotomy
  /-- The theory refutes the sentence. -/
  | refutable : Trichotomy
  /-- The theory settles neither way. -/
  | independent : Trichotomy
  deriving DecidableEq

/-- An encoding of the three statuses as reports, using the interior of the report
    triangle rather than only its two poles. -/
def enc : Trichotomy → ℝ × ℝ
  | .provable => (1, 1)
  | .refutable => (-1, 1)
  | .independent => (0, 1)

/-- **The pigeonhole of `logic-bloch-poles.md` §1 is dissolved by the owner's own
    question, and this is the injection that dissolves it.**

    That essay's `no_two_pole_encoding` proves there is no injection from three statuses
    into two poles, and infers that the poles must be `provable` against `not provable`
    (its encoding (b)), paying the cost that the south pole then conflates refutable with
    independent. The Lean theorem is correct and is not disputed. The INFERENCE carries a
    further premise -- that every status must be assigned to a POLE, i.e. to an outcome
    of one sharp measurement -- and the owner's 2026-09-07 instruction to admit `r < 1`
    retracts exactly that premise.

    With mixed states admitted, the three statuses need only be assigned to distinct
    STATES, and here they are: `provable` and `refutable` at the poles, `independent` on
    the equatorial circle. No conflation, no dropped status, and the argument that forced
    encoding (b) no longer forces it. -/
theorem enc_injective : Function.Injective enc := by
  intro a b h
  cases a <;> cases b <;>
    first
      | rfl
      | (exfalso; norm_num [enc, Prod.ext_iff] at h)

/-- All three encoded statuses are admissible reports, so the injection lands where it
    has to. Note that all three sit at `r = 1`: they are the SETTLED statuses, and the
    theory-relative trichotomy has no fourth member for an agent's ignorance. That fourth
    member is what essay (ii) adds and essay (i) cannot. -/
theorem enc_lands (t : Trichotomy) : StatusReach (enc t).1 (enc t).2 := by
  cases t <;> refine ⟨?_, ?_⟩ <;> norm_num [enc]

/-- The same three statuses cannot be so encoded inside essay (i)'s reachable set: the
    image of `independent` is the point `equator_not_mem_models` rules out. So the
    dissolution of the pigeonhole is available to (ii) and not to (i). -/
theorem enc_independent_not_models :
    ¬ ModelsReach (enc Trichotomy.independent).1 (enc Trichotomy.independent).2 :=
  equator_not_mem_models

/-- Josang's uncertainty mass under the natural map from a `Status`: the weight that is
    not located on one side or the other. -/
def josangU (s : Status) : ℝ := s.ind + s.op

/-- **A located arithmetic error in `logic-epistemic-state.md` §7.**

    That essay writes "Josang's `u` is (ii)'s `1 - r`". It is not. Josang's opinion
    `(b, d, u)` with `b + d + u = 1` maps to `(pv, rf, ind + op)`, so `u = ind + op`,
    while `1 - r = op`. The gap is exactly `ind`. -/
theorem josang_gap (s : Status) : josangU s = (1 - rr s) + s.ind := by
  have h := s.sum_one
  simp only [josangU, rr]
  linarith

/-- The identification holds exactly when the independence weight vanishes -- which is
    precisely the case in which essay (ii) reduces to subjective logic and has nothing
    new to say. So the essay UNDER-claims its own novelty at the point where it concedes
    the most: it is not subjective logic, it is subjective logic with `u` SPLIT into
    "proved independent" and "untouched". -/
theorem josang_eq_iff (s : Status) : josangU s = 1 - rr s ↔ s.ind = 0 := by
  rw [josang_gap]
  constructor <;> intro h <;> linarith

/-- The witness: at "proved independent" Josang's uncertainty mass is 1 and `1 - r` is 0.
    They are as far apart as they can be, at exactly the state the essay exists to
    describe. -/
theorem josang_ne_at_independent : josangU independent ≠ 1 - rr independent := by
  simp [josangU, rr, independent]

/-- **The ball buys the report nothing.**

    Every admissible report is realised by an actual Bloch triple, so `StatusReach` is
    exactly the `(z, nrm)` shadow of the full ball. Together with `models_subset_status`,
    this says: whatever the owner's construction turns out to be a state OF, the ball
    contributes to the report only the azimuth, and `logic-bloch-gates.md`,
    `logic-bloch-phase.md` and both fork essays now independently report that the azimuth
    carries nothing. The honest container for the report is the triangle
    `{|z| <= r <= 1}`, which is a 2-simplex. -/
theorem ball_shadow {z r : ℝ} (h : StatusReach z r) :
    ∃ b : Bloch, b.z = z ∧ nrm b = r := by
  obtain ⟨hzr, -⟩ := h
  have hr0 : 0 ≤ r := le_trans (abs_nonneg z) hzr
  have h1 : z ≤ r := le_trans (le_abs_self z) hzr
  have h2 : -r ≤ z := by linarith [neg_abs_le z]
  have hd : 0 ≤ r ^ 2 - z ^ 2 := by nlinarith
  refine ⟨⟨Real.sqrt (r ^ 2 - z ^ 2), 0, z⟩, rfl, ?_⟩
  simp only [nrm]
  rw [show Real.sqrt (r ^ 2 - z ^ 2) ^ 2 + (0:ℝ) ^ 2 + z ^ 2
        = Real.sqrt (r ^ 2 - z ^ 2) ^ 2 + z ^ 2 by ring,
      Real.sq_sqrt hd,
      show r ^ 2 - z ^ 2 + z ^ 2 = r ^ 2 by ring,
      Real.sqrt_sq hr0]

/-- The converse half, for completeness: no Bloch triple reports outside the wedge, since
    a component never exceeds the norm. The two halves together are the exact statement
    that the wedge IS the shadow. -/
theorem shadow_sound (b : Bloch) (h : nrm b ≤ 1) : StatusReach b.z (nrm b) := by
  refine ⟨?_, h⟩
  have hsq : b.z ^ 2 ≤ b.x ^ 2 + b.y ^ 2 + b.z ^ 2 := by nlinarith [sq_nonneg b.x, sq_nonneg b.y]
  have : |b.z| = Real.sqrt (b.z ^ 2) := (Real.sqrt_sq_eq_abs b.z).symm
  rw [this]
  exact Real.sqrt_le_sqrt hsq

#print axioms equator_separates
#print axioms vertex_coords
#print axioms report_conflates
#print axioms enc_injective
#print axioms models_z_zero_forces_origin
#print axioms josang_eq_iff
#print axioms ball_shadow

end Toesnail.LogicMerge
