/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-simplex.md`.

  ---------------------------------------------------------------------------------------
  WHAT THIS FILE IS ABOUT

  The owner's backburner idea "Bloch Truth" puts the status of a mathematical sentence on
  a Bloch ball: a truth lean `z` (which way it leans) and a radius `r` (how settled it
  is). Four sibling essays in this cluster independently concluded that the object he
  wants is not a ball but a SIMPLEX. This essay builds the simplex, and this file checks
  the load-bearing arithmetic of that construction.

  The seed, his own words, `conv-falsifiability.md:366` (2025-08-16):

      "What states can there actually be for statements in terms of complete logic?
       Proven true, false, probable but undetermined, unprovable, ....?"

  The construction takes that list at face value and makes it a vertex set of FOUR
  mutually exclusive statuses, so a state is a point of the 3-simplex.

  ---------------------------------------------------------------------------------------
  SYMBOL MAP: Lean name  ->  essay meaning

    `Status`             the four vertices. `proved` = the agent holds a proof of P in T;
                         `refuted` = it holds a proof of not-P; `indep` = it holds a
                         METATHEORETIC proof that T settles neither (Cohen-style);
                         `opn` = it holds nothing yet. Essay section 1.
    `St`                 a point of the 3-simplex: four non-negative weights summing to 1.
                         Essay section 2. Field `opn` is `open` renamed, `open` being a
                         Lean keyword.
    `z s`                the TRUTH LEAN, `p_proved - p_refuted`. Essay eq `zr-cone`.
    `r s`                SETTLEDNESS, `p_proved + p_refuted + p_indep = 1 - p_open`.
    `abs_z_le_r`         the owner's Bloch constraint |z| <= r, DERIVED from p >= 0
                         instead of stipulated. Essay section 2.2, the cornerstone.
    `vertex_coords`      where the four statuses land in (z,r): north pole, south pole,
                         equatorial circle, origin. Essay section 2.3.
    `report_conflates`   the (z,r) report identifies "proved independent" with "certainly
                         decided, no idea which way". Essay section 2.4.
    `conflation_forced`  the sharper version, and the file's centrepiece: the conflation
                         is NOT an artefact of discarding the azimuth. ANY map that
                         respects mixing and places `open` at the midpoint of
                         proved/refuted -- which is exactly what the Bloch ball does, its
                         centre being the equal mixture of its poles -- identifies two
                         distinct states. Essay section 3.2.
    `sand` `sor` `sneg`  the connectives on statuses. Essay section 4.
    `sand_mono`          soundness in the information order: learning more about the parts
                         never invalidates the computed status of the compound.
    `sand_indep_not_idem`  the decisive negative: `indep AND indep = opn`, so AND is not
                         idempotent, so the four statuses are NOT a lattice and carry no
                         Heyting algebra. Essay section 4.3.
    `k3_fragment`        the three-status fragment {proved, refuted, opn} is EXACTLY
                         Kleene's strong three-valued table with `opn` relabelled from
                         "undefined". Stated plainly rather than dressed up. Essay 4.4.
    `wPr` `wRf` `wInd`   the multilinear (independent-product) extension of the AND table
                         to the interior of the simplex. Essay section 5.
    `wRf_inclusion_exclusion`  the extension's refuted-weight is `b + b' - b b'`, ordinary
                         inclusion-exclusion. The proved-weight multiplies, the refuted-
                         weight adds. Essay eq `and-weights`.
    `Learn` `step`       learning as a stochastic map that FIXES the three settled
                         vertices and redistributes the open weight. Essay section 6.
    `learn_r_mono`       learning never decreases settledness.
    `learn_no_undo`      and cannot be undone by further learning, so the dynamics is an
                         irreversible monoid, not the unitary group the sibling gate
                         essay assumed. Essay section 6.3.

  ---------------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE -- do not read this file as more than it is

    - NOTHING here is a theorem about provability, Goedel, or arithmetic. `Status` is a
      four-element inductive type. No provability predicate, no theory, no arithmetisation
      appears below. The reading of `proved`/`indep` as proof-search verdicts is the
      ESSAY's interpretation and is argued there, not proved here.
    - NOTHING here shows the connectives are a LOGIC. They are not: they are sound
      abstract transformers on a four-element domain. Goedel 1932 proved intuitionistic
      propositional logic has NO finite characteristic matrix, so no table on finitely
      many statuses can be intuitionistic logic. That result is quoted in the essay and
      proved nowhere in this repo.
    - `conflation_forced` is a statement about MIXING-RESPECTING maps into a real vector
      space. It is not a statement about density matrices, quantum states, or the Bloch
      ball as such. The bridge -- that the ball's centre is the equal mixture of its poles
      -- is elementary and is asserted in the essay, not formalised here.
    - The multilinear extension below encodes an INDEPENDENCE assumption between the
      agent's uncertainty about P and about Q. The essay argues at length that this
      assumption is a choice, and a false one for logically related sentences. Nothing
      here justifies it; the definitions merely make the choice explicit.
    - `Learn` assumes knowledge is MONOTONE (a held proof is never withdrawn). Retraction
      is real and is out of scope; the essay says so.
    - No claim of novelty. The flat information order with a bottom is the standard
      abstract-interpretation domain, and Kleene's tables are from 1938.
-/
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.DeriveFintype
import Mathlib.Tactic.Module
import Mathlib.Logic.Function.Basic
import Mathlib.Algebra.Module.Basic

namespace Toesnail.LogicSimplex

/-! ## 1. The vertex set

Four mutually exclusive statuses. The essay defends this count against three (which
kills the radius, see `three_status_collapse`) and against five (where the fifth,
Belnap's glut, is argued to be a property of the THEORY rather than of the sentence). -/

/-- The four epistemic statuses. `opn` is `open` renamed (`open` is a Lean keyword). -/
inductive Status where
  /-- The agent holds a proof of `P` in `T`. -/
  | proved
  /-- The agent holds a proof of `¬P` in `T`. -/
  | refuted
  /-- The agent holds a metatheoretic proof that `T` settles neither. -/
  | indep
  /-- The agent holds nothing yet. -/
  | opn
  deriving DecidableEq, Fintype, Repr

open Status

/-! ## 2. The simplex, the two coordinates, and the owner's constraint -/

/-- A point of the 3-simplex: a probability distribution over the four statuses. -/
structure St where
  pr : ℝ
  rf : ℝ
  ind : ℝ
  opn : ℝ
  pr_nn : 0 ≤ pr
  rf_nn : 0 ≤ rf
  ind_nn : 0 ≤ ind
  opn_nn : 0 ≤ opn
  tot : pr + rf + ind + opn = 1

/-- **Truth lean.** Which way the sentence leans: located-proved minus located-refuted. -/
def z (s : St) : ℝ := s.pr - s.rf

/-- **Settledness.** Everything except pure ignorance. -/
def r (s : St) : ℝ := s.pr + s.rf + s.ind

theorem r_eq_one_sub_opn (s : St) : r s = 1 - s.opn := by
  have h := s.tot; simp only [r]; linarith

/-- **The cornerstone.** The owner's Bloch constraint `|z| ≤ r` is not an extra axiom on
    the simplex: it is componentwise non-negativity, nothing more. -/
theorem abs_z_le_r (s : St) : |z s| ≤ r s := by
  rw [abs_le]
  constructor <;> · simp only [z, r]; linarith [s.pr_nn, s.rf_nn, s.ind_nn]

theorem r_le_one (s : St) : r s ≤ 1 := by
  have h := s.tot; simp only [r]; linarith [s.opn_nn]

theorem r_nonneg (s : St) : 0 ≤ r s := by
  simp only [r]; linarith [s.pr_nn, s.rf_nn, s.ind_nn]

/-- An agent who knows nothing cannot lean: the origin is on the equator by necessity. -/
theorem r_zero_imp_z_zero (s : St) (h : r s = 0) : z s = 0 := by
  have h1 : |z s| ≤ 0 := h ▸ abs_z_le_r s
  exact abs_eq_zero.mp (le_antisymm h1 (abs_nonneg _))

/-! ### 2.1 The four vertices, and where they land -/

def vProved : St := ⟨1, 0, 0, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩
def vRefuted : St := ⟨0, 1, 0, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩
def vIndep : St := ⟨0, 0, 1, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩
def vOpen : St := ⟨0, 0, 0, 1, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- The even mixture of `proved` and `refuted`: "certainly decided, no idea which way". -/
noncomputable def vEven : St :=
  ⟨1/2, 1/2, 0, 0, by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

/-- **North pole, south pole, equatorial circle, origin.** The owner's picture, recovered
    on the simplex by computation rather than by analogy. -/
theorem vertex_coords :
    (z vProved = 1 ∧ r vProved = 1) ∧
    (z vRefuted = -1 ∧ r vRefuted = 1) ∧
    (z vIndep = 0 ∧ r vIndep = 1) ∧
    (z vOpen = 0 ∧ r vOpen = 0) := by
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ?_, ?_⟩ <;>
    norm_num [z, r, vProved, vRefuted, vIndep, vOpen]

/-! ### 2.2 Three vertices would kill the radius

With only {proved, refuted, indep} there is no open weight, so `r = 1` identically and
the owner's "how settled" axis does not exist. This is the essay's first argument for
four vertices rather than three. -/

theorem three_status_collapse (s : St) (h : s.opn = 0) : r s = 1 := by
  rw [r_eq_one_sub_opn, h]; ring

/-! ## 3. What the (z,r) report loses, and why the ball cannot avoid it -/

/-- The two-number report identifies proved-independence with a known-fair coin. -/
theorem report_conflates : (z vEven = z vIndep ∧ r vEven = r vIndep) ∧ vEven.pr ≠ vIndep.pr := by
  refine ⟨⟨?_, ?_⟩, ?_⟩ <;> norm_num [z, r, vEven, vIndep]

/-- **The centrepiece.** The conflation above is not an artefact of throwing away the
    azimuth. Let `f` be ANY map from the simplex into a real vector space that respects
    mixing (it sends a distribution to the corresponding combination of the four vertex
    images) and that places `open` at the MIDPOINT of the proved and refuted images.
    That midpoint condition is exactly what the Bloch reading demands: the maximally
    mixed state, which the owner reads as "no information", is the equal mixture of the
    two poles. Then `f` cannot tell "certainly decided, no idea which way" from "nothing
    established at all". -/
theorem conflation_forced {V : Type*} [AddCommGroup V] [Module ℝ V]
    (P R I : V) (f : St → V)
    (hf : ∀ s : St, f s =
      s.pr • P + s.rf • R + s.ind • I + s.opn • ((2 : ℝ)⁻¹ • P + (2 : ℝ)⁻¹ • R)) :
    f vEven = f vOpen := by
  rw [hf, hf]
  simp only [vEven, vOpen]
  norm_num

/-- Restated as the failure it is: no such `f` is injective. -/
theorem conflation_not_injective {V : Type*} [AddCommGroup V] [Module ℝ V]
    (P R I : V) (f : St → V)
    (hf : ∀ s : St, f s =
      s.pr • P + s.rf • R + s.ind • I + s.opn • ((2 : ℝ)⁻¹ • P + (2 : ℝ)⁻¹ • R)) :
    ¬ Function.Injective f := by
  intro hinj
  have h := hinj (conflation_forced P R I f hf)
  have h2 : vEven.pr = vOpen.pr := congrArg St.pr h
  simp only [vEven, vOpen] at h2
  norm_num at h2

/-! ## 4. The connectives

The decisive test the Bloch body failed. `logic-beyond-su3.md` showed distinct density
matrices of equal trace are never Loewner-comparable, so the Bloch body is an antichain:
no meets, no joins, no implication. The simplex has a finite vertex set, so a table CAN
be written. This section writes it and then reports what it is and is not. -/

/-- Negation. Independence is a property of `P` and `¬P` alike, so `indep` is fixed;
    ignorance is likewise symmetric. -/
def sneg : Status → Status
  | proved => refuted
  | refuted => proved
  | indep => indep
  | opn => opn

/-- Conjunction, as the BEST STATUS GUARANTEED by the statuses of the parts.

    `refuted` is absorbing: a refutation of one conjunct refutes the conjunction.
    `proved` is a unit: with one conjunct proved, the conjunction inherits the other's
    status. `indep AND indep` is `opn`, and that entry is the whole content of the
    section: two independent sentences may have a conjunction that is independent
    (take `Q = P`) or refuted (take `Q = ¬P`), so nothing is guaranteed. -/
def sand : Status → Status → Status
  | proved,  proved  => proved
  | proved,  refuted => refuted
  | proved,  indep   => indep
  | proved,  opn     => opn
  | refuted, _       => refuted
  | indep,   proved  => indep
  | indep,   refuted => refuted
  | indep,   indep   => opn
  | indep,   opn     => opn
  | opn,     proved  => opn
  | opn,     refuted => refuted
  | opn,     indep   => opn
  | opn,     opn     => opn

/-- Disjunction, defined by De Morgan so that the duality is not an assumption. -/
def sor (x y : Status) : Status := sneg (sand (sneg x) (sneg y))

theorem sneg_involutive : ∀ x, sneg (sneg x) = x := by decide

theorem sand_comm : ∀ x y, sand x y = sand y x := by decide

theorem sand_assoc : ∀ x y w, sand (sand x y) w = sand x (sand y w) := by decide

theorem sand_proved_unit : ∀ x, sand proved x = x := by decide

theorem sand_refuted_absorbing : ∀ x, sand refuted x = refuted := by decide

theorem sor_comm : ∀ x y, sor x y = sor y x := by decide

theorem sor_assoc : ∀ x y w, sor (sor x y) w = sor x (sor y w) := by decide

theorem sor_refuted_unit : ∀ x, sor refuted x = x := by decide

theorem sor_proved_absorbing : ∀ x, sor proved x = proved := by decide

/-- De Morgan, both directions, by construction on one side and by check on the other. -/
theorem de_morgan : ∀ x y, sneg (sor x y) = sand (sneg x) (sneg y) := by decide

/-! ### 4.1 Agreement with classical logic on the two located vertices

The table is a conservative extension: restricted to {proved, refuted}, read as
{true, false}, it is the ordinary two-valued table. -/

theorem classical_on_located :
    sand proved proved = proved ∧ sand proved refuted = refuted ∧
    sand refuted proved = refuted ∧ sand refuted refuted = refuted ∧
    sor proved proved = proved ∧ sor proved refuted = proved ∧
    sor refuted proved = proved ∧ sor refuted refuted = refuted ∧
    sneg proved = refuted ∧ sneg refuted = proved := by decide

/-! ### 4.2 Soundness: monotone in the information order

The four statuses carry a FLAT order: `opn` is bottom, and `proved`, `refuted`, `indep`
are three incomparable maximal elements. Monotonicity says the table never has to be
retracted: if the agent learns more about the parts, the computed status of the compound
only becomes more informative. This is the soundness condition of an abstract domain. -/

/-- `infoLe x y` : `x` is no more informative than `y`, in the flat order with bottom
    `opn`. -/
def infoLe : Status → Status → Bool
  | opn, _ => true
  | x, y => x == y

theorem infoLe_refl : ∀ x, infoLe x x = true := by decide

theorem infoLe_trans : ∀ x y w, infoLe x y = true → infoLe y w = true → infoLe x w = true := by
  decide

/-- **Soundness of the abstract transformer.** -/
theorem sand_mono : ∀ x x' y y', infoLe x x' = true → infoLe y y' = true →
    infoLe (sand x y) (sand x' y') = true := by decide

theorem sor_mono : ∀ x x' y y', infoLe x x' = true → infoLe y y' = true →
    infoLe (sor x y) (sor x' y') = true := by decide

/-- Negation is an order ISOMORPHISM of the information order: it moves the truth lean
    and cannot move the information. -/
theorem sneg_info_iso : ∀ x y, infoLe (sneg x) (sneg y) = infoLe x y := by decide

/-! ### 4.3 The decisive negative: AND is not idempotent

`P ∧ P` has the status of `P`. The table says `indep AND indep = opn`. So the table is
NOT idempotent, hence `sand` is not a meet, hence the four statuses carry no lattice,
hence no Heyting algebra and no Boolean algebra. The reason is not subtle and is not
repairable inside the table: the table takes two statuses and cannot know the two
sentences are the same one. -/

theorem sand_indep_not_idem : sand indep indep ≠ indep := by decide

theorem sand_not_idempotent : ¬ (∀ x, sand x x = x) := by decide

/-- Consequence: `{proved, refuted, indep}` is not closed under conjunction. This is the
    essay's SECOND argument for four vertices rather than three, independent of
    `three_status_collapse`. -/
theorem three_statuses_not_closed :
    sand indep indep = opn ∧ opn ≠ proved ∧ opn ≠ refuted ∧ opn ≠ indep := by decide

/-- Idempotence does hold on the other three vertices, so `indep` is exactly where it
    fails. -/
theorem idem_off_indep :
    sand proved proved = proved ∧ sand refuted refuted = refuted ∧ sand opn opn = opn := by
  decide

/-! ### 4.4 The three-status fragment IS Kleene K3, relabelled

Stated plainly, as the essay promised. Drop `indep` and the table on
{proved, refuted, opn} is Kleene's strong three-valued matrix with `opn` in the role of
the undefined value: `true ∧ ⊥ = ⊥`, `false ∧ ⊥ = false`, `⊥ ∧ ⊥ = ⊥`, and dually.
The new content of the four-status system is therefore ENTIRELY the `indep` row, and
within that row entirely the failure of idempotence above. -/

theorem k3_fragment :
    sand proved opn = opn ∧ sand refuted opn = refuted ∧ sand opn opn = opn ∧
    sor proved opn = proved ∧ sor refuted opn = opn ∧ sor opn opn = opn ∧
    sneg opn = opn := by decide

/-- And the fragment is genuinely closed, so it is a sub-table and not a coincidence of
    three entries. -/
theorem k3_fragment_closed : ∀ x y, x ≠ indep → y ≠ indep → sand x y ≠ indep := by decide

/-! ## 5. Convexity: the multilinear extension to the interior

A point in the interior of the simplex is a mixture, and this is the one thing a simplex
has that a truth table does not. Extending the table to mixtures requires pushing the
product distribution forward through the table, which is affine in each argument
separately. That separate affineness is an INDEPENDENCE assumption, and the essay argues
it is a choice rather than a consequence. -/

/-- Weight the extension puts on `proved`: only `proved AND proved` lands there. -/
def wPr (p q : St) : ℝ := p.pr * q.pr

/-- Weight on `refuted`: every pair with a refuted component. -/
def wRf (p q : St) : ℝ :=
  p.rf * (q.pr + q.rf + q.ind + q.opn) + (p.pr + p.ind + p.opn) * q.rf

/-- Weight on `indep`: `proved AND indep` and its mirror. -/
def wInd (p q : St) : ℝ := p.pr * q.ind + p.ind * q.pr

/-- **The extension's arithmetic, in one line.** The proved-weight MULTIPLIES; the
    refuted-weight ADDS by inclusion-exclusion. -/
theorem wRf_inclusion_exclusion (p q : St) : wRf p q = p.rf + q.rf - p.rf * q.rf := by
  have h1 := p.tot
  have h2 := q.tot
  simp only [wRf]
  linear_combination p.rf * h2 + q.rf * h1

/-- Settledness of the conjunction. -/
def rAnd (p q : St) : ℝ := wPr p q + wRf p q + wInd p q

/-- Truth lean of the conjunction. -/
def zAnd (p q : St) : ℝ := wPr p q - wRf p q

theorem zAnd_formula (p q : St) : zAnd p q = p.pr * q.pr - (p.rf + q.rf - p.rf * q.rf) := by
  simp only [zAnd, wPr, wRf_inclusion_exclusion]

/-- The extension agrees with the table at the vertices: `proved AND indep = indep` puts
    all the weight on `indep` and none anywhere else. -/
theorem extension_agrees_proved_indep :
    wPr vProved vIndep = 0 ∧ wRf vProved vIndep = 0 ∧ wInd vProved vIndep = 1 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [wPr, wRf, wInd, vProved, vIndep]

/-- **Conjunction destroys settledness.** Two sentences each PROVED independent have a
    conjunction about which nothing whatever is guaranteed: `r` falls from 1 to 0. -/
theorem and_of_two_independents : r vIndep = 1 ∧ rAnd vIndep vIndep = 0 := by
  constructor <;> norm_num [r, rAnd, wPr, wRf, wInd, vIndep]

/-- **And conjunction can also CREATE settledness**, so `r` is not monotone under AND in
    either direction. A refuted conjunct settles the conjunction no matter how open the
    other one is. Reported as the honest anti-theorem it is. -/
theorem and_can_increase_settledness : r vOpen = 0 ∧ rAnd vRefuted vOpen = 1 := by
  constructor <;> norm_num [r, rAnd, wPr, wRf, wInd, vRefuted, vOpen]

/-! ## 6. Dynamics: what learning is on the simplex

The three settled statuses are ABSORBING: a proof, once held, is held. So a learning map
fixes `proved`, `refuted` and `indep`, and is determined entirely by how it redistributes
the open weight. The legitimate learning maps are therefore themselves a 3-simplex. -/

/-- A learning map, given by where it sends the open weight. -/
structure Learn where
  a : ℝ
  b : ℝ
  c : ℝ
  d : ℝ
  a_nn : 0 ≤ a
  b_nn : 0 ≤ b
  c_nn : 0 ≤ c
  d_nn : 0 ≤ d
  tot : a + b + c + d = 1

/-- Applying a learning map. The settled weights only grow; the open weight is scaled
    by `d`, the fraction of the open case the step failed to resolve. -/
def step (L : Learn) (s : St) : St where
  pr := s.pr + s.opn * L.a
  rf := s.rf + s.opn * L.b
  ind := s.ind + s.opn * L.c
  opn := s.opn * L.d
  pr_nn := add_nonneg s.pr_nn (mul_nonneg s.opn_nn L.a_nn)
  rf_nn := add_nonneg s.rf_nn (mul_nonneg s.opn_nn L.b_nn)
  ind_nn := add_nonneg s.ind_nn (mul_nonneg s.opn_nn L.c_nn)
  opn_nn := mul_nonneg s.opn_nn L.d_nn
  tot := by
    have h1 := s.tot
    have h2 := L.tot
    linear_combination h1 + s.opn * h2

theorem step_opn (L : Learn) (s : St) : (step L s).opn = s.opn * L.d := rfl

theorem learn_d_le_one (L : Learn) : L.d ≤ 1 := by
  have := L.tot; linarith [L.a_nn, L.b_nn, L.c_nn]

/-- **Learning never decreases settledness.** -/
theorem learn_r_mono (L : Learn) (s : St) : r s ≤ r (step L s) := by
  rw [r_eq_one_sub_opn, r_eq_one_sub_opn, step_opn]
  nlinarith [s.opn_nn, learn_d_le_one L]

/-- Equality exactly when there was nothing open, or nothing was resolved. -/
theorem learn_r_eq_iff (L : Learn) (s : St) :
    r (step L s) = r s ↔ s.opn = 0 ∨ L.d = 1 := by
  rw [r_eq_one_sub_opn, r_eq_one_sub_opn, step_opn]
  constructor
  · intro h
    have h2 : s.opn * (1 - L.d) = 0 := by linarith
    rcases mul_eq_zero.mp h2 with h3 | h3
    · exact Or.inl h3
    · exact Or.inr (by linarith)
  · rintro (h | h) <;> rw [h] <;> ring

/-- **Learning is irreversible: an unresolved-fraction step cannot be undone.** Once a
    step has moved weight off `open`, no further learning map brings the state back to
    total ignorance. So the dynamics is a monoid with no inverses, not the unitary group
    the sibling gate essay (CNOT, TOFFOLI) works in. -/
theorem learn_no_undo (L L' : Learn) (h : L.d < 1) : r vOpen < r (step L' (step L vOpen)) := by
  have h0 : r vOpen = 0 := by norm_num [r, vOpen]
  have h1 : r (step L vOpen) = 1 - L.d := by
    rw [r_eq_one_sub_opn, step_opn]; norm_num [vOpen]
  have h2 : r (step L vOpen) ≤ r (step L' (step L vOpen)) := learn_r_mono L' _
  rw [h0]
  linarith

/-- Negation acts on a state by swapping the located weights: it moves the truth lean and
    leaves the settledness alone. The lattice-side sibling proves the same thing as
    `neg_monotone_K`; here it is arithmetic. -/
def dual (s : St) : St where
  pr := s.rf
  rf := s.pr
  ind := s.ind
  opn := s.opn
  pr_nn := s.rf_nn
  rf_nn := s.pr_nn
  ind_nn := s.ind_nn
  opn_nn := s.opn_nn
  tot := by have := s.tot; linarith

theorem dual_z (s : St) : z (dual s) = -z s := by simp only [z, dual]; ring

theorem dual_r (s : St) : r (dual s) = r s := by simp only [r, dual]; ring

end Toesnail.LogicSimplex
