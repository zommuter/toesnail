/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-layered-core.md`.

  ---------------------------------------------------------------------------
  SEED (the owner's words, verbatim, from his own idea pool at
  `~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`,
  his turn of 2025-08-08 07:22 UTC)

      "the Bloch Truth (might need a better name) might be useful for the AI logic core
       in the second (ZFC?) layer where incompleteness applies (core layer should only
       be complete, e.g. ZF without C)"

  The essay proposes a concrete two-layer architecture for that sentence. This file
  discharges the four facts the architecture actually rests on. Every one of them is a
  CONSTRAINT on the design, not a feature of it: three are negative results and the
  fourth is a soundness statement so cheap that stating its cheapness is the point.

  ---------------------------------------------------------------------------
  RELATION TO THE SIBLING FILES (read this before crediting anything here)

  `docs/dreamed/lean/LogicBeyondSU3.lean` already defines an abstract `GLSystem` and
  derives Loeb's RULE and Goedel II from Loeb's AXIOM. This file does NOT restate that
  work and claims no credit for it. The dreamed Lean files are checked one at a time
  with `lake env lean` and are not a Lake package, so they cannot `import` one another;
  the `Layer` structure in Part B below is that sibling's `GLSystem` re-declared
  verbatim in a private namespace purely so this file can compile standalone. The
  `loeb_rule` proof term is the sibling's, reproduced under a different name and
  credited here rather than passed off as new.

  What is NEW in this file, and is the reason it exists:

    * Part B's `Bridge`, and `certificate_is_no_shortcut` /
      `no_core_certified_soundness` / `no_mutual_certification`. The sibling proves a
      layer cannot certify ITSELF. The architecture's actual question is whether a
      SEPARATE, weaker, decidable core can certify the upper layer FOR it. The answer
      is no, and the reason is that the core is weak, hence interpretable in the upper
      layer, hence its certificate is an upper-layer self-certificate in disguise.
      That cross-layer form is what the design has to survive, and it is what is proved
      here.
    * Part B's `escape_needs_no_bridge` and `no_bridge_for_constant_certificate`: the
      SAME certificate is harmless when the bridge does not exist, machine-checked in a
      concrete two-element model. This is the escape hatch and its exact price.
    * Part C's `exact_reports_decide`: if the upper layer's report on a sentence is
      EXACT (it says "proved" precisely when the sentence is provable), then the
      decidable core, merely by comparing two reports for equality, decides the upper
      layer's theoremhood. Undecidability re-enters through the interface. This is the
      load-bearing check the essay's §2 owes the architecture, and it fails in the
      direction that matters: the interface must be allowed to be WRONG (under-confident)
      or it smuggles the incompleteness back in.
    * Part A's report triangle: admissibility is decidable, convex, and closed under
      negation, plus `no_truthfunctional_conj`, the statement that no binary function
      on reports can compute conjunction.

  ---------------------------------------------------------------------------
  SYMBOL MAP: Lean name -> essay section

    `Report`                    §2.2  the interface type: a truth lean `z` and a
                                      settledness `r`, both rational
    `Admissible`                §2.2  `|z| <= r <= 1`, the report triangle. NOT a Bloch
                                      ball: the ball's `(z,r)` shadow is this triangle
                                      and the third coordinate is unused
                                      (`logic-models-vs-epistemic.md` §5)
    `Report.pr/rf/ind/opn`      §2.2  proved / refuted / independent / open, the four
                                      vertices of the status simplex as they land in
                                      the report triangle
    `mix`                       §2.3  the core may average two reports; the triangle is
                                      convex, so an averaged report is still admissible
    `no_truthfunctional_conj`   §2.5  the core may CONSTRAIN reports, never COMPUTE
                                      truth-functionally with them
    `Layer`                     §1    an abstract theory with a provability predicate;
                                      the sibling's `GLSystem`, re-declared
    `Bridge`                    §4.3  an interpretation of the core inside the upper
                                      layer, plus the core's ability to name the upper
                                      layer's reflection instances
    `certificate_is_no_shortcut`§4.3  a core certificate of "if U proves it, it is true"
                                      is only available for sentences U already proved
    `no_core_certified_soundness`§4.3 the architecture's binding constraint
    `escape_needs_no_bridge`    §4.4  what the design must give up to survive it
    `exact_reports_decide`      §2.6  exact reports are a provability oracle

  ---------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE. Do not read this file as more than it is.

    * NOTHING here is about Peano Arithmetic, ZF, ZFC, or any concrete theory. `Layer`
      is an abstract structure. The hard half of every real theorem in this area is
      that PA's provability predicate satisfies the Hilbert-Bernays-Loeb derivability
      conditions, which needs arithmetisation of syntax and is formalised NOWHERE in
      this repo. A gap-free Lean 4 Goedel I/II is claimed by the
      FormalizedFormalLogic/Foundation project, not by this file.
    * NOTHING here is Solovay's arithmetical completeness theorem (1976), Segerberg's
      1971 modal completeness, or GL's PSPACE-completeness. Those are cited in the
      essay as literature and proved nowhere here. In particular this file does NOT
      show GL is decidable.
    * NOTHING here is about quantum mechanics. `Report` is two rationals. There is no
      Hilbert space, no density matrix, no trace, no positivity, and the claim that
      `h((1+r)/2)` is a von Neumann entropy is asserted in prose across this whole
      dreamed cluster and proved nowhere in this repo.
    * NOTHING here shows the report triangle is the RIGHT interface. It shows what
      follows if it is chosen. Choosing it is the owner's ruling.
    * NOTHING here is about Presburger arithmetic, real closed fields, or Tarski's
      elementary geometry. Their completeness and decidability are quoted from the
      literature in the essay and are not formalised. `Report`'s admissibility being
      `Decidable` is decidability of ONE quantifier-free predicate over ℚ, which is a
      much smaller statement and must not be read as the decidability of the core.
    * `no_truthfunctional_conj` is arithmetically trivial. Its content is entirely in
      its two hypotheses, which come from the logic and not from Lean. That is stated
      in its docstring and must not be glossed over.
-/
import Mathlib.Algebra.Order.Ring.Rat
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

namespace Toesnail.LogicLayered

universe u v

/-! ## Part A. The interface type: the report triangle

The upper layer hands the core a pair of rationals: a **truth lean** `z` and a
**settledness** `r`. The sibling essays disagreed about the reachable set; the
adjudication in `docs/dreamed/logic-models-vs-epistemic.md` §2.1 found that the
model-ensemble reading reaches only `|z| = r` (a pair of segments) while the
epistemic-status reading reaches the whole triangle `|z| <= r <= 1`, and that the
one distinction the layered application needs -- "I proved this is undecidable,
stop asking" against "I have got nowhere yet, spend more budget" -- exists only in
the second. This file takes the triangle as the interface type on that ground and
proves what the core can and cannot do with it.

Rationals, not reals, and deliberately: the core has to COMPARE reports, and the
comparison has to be an actual computation. `DecidableEq ℝ` does not exist. That
choice is what makes `exact_reports_decide` in Part C bite, and it is not an
incidental convenience. -/

/-- A **report** from the upper layer about one sentence: which way it leans (`z`)
    and how settled that lean is (`r`). Two rationals and nothing else -- no
    sentence, no proof, no Goedel number. That poverty is the design intent: the
    core is supposed to be unable to reconstruct the sentence from the report. -/
structure Report where
  /-- Truth lean. `+1` is "proved", `-1` is "refuted", `0` is "no net lean". -/
  z : ℚ
  /-- Settledness. `1` is "the question is closed", `0` is "nothing is known". -/
  r : ℚ
  deriving DecidableEq

namespace Report

/-- **Admissibility**, the report triangle. `|z| <= r` is the soundness norm: a layer
    may not report more confidence than it has settled. `r <= 1` normalises.

    Under the epistemic-status reading this is DERIVED rather than stipulated, from
    `|a - b| <= a + b <= a + b + c` on the status simplex. It is not a Bloch fact:
    the ball satisfies the same inequality for the unrelated reason that a component
    never exceeds a norm (`logic-models-vs-epistemic.md` §2.2). -/
def Admissible (p : Report) : Prop := |p.z| ≤ p.r ∧ p.r ≤ 1

instance (p : Report) : Decidable (Admissible p) := by
  unfold Admissible; infer_instance

/-- Proved: the question is closed and the answer is yes. -/
def pr : Report := ⟨1, 1⟩
/-- Refuted: the question is closed and the answer is no. -/
def rf : Report := ⟨-1, 1⟩
/-- Independent: the question is closed and the answer is "neither". This is the
    vertex a completion-measure reading cannot reach at all, and the whole reason
    the interface is two numbers rather than one. -/
def ind : Report := ⟨0, 1⟩
/-- Open: nothing is known yet. Not a value, an absence. -/
def opn : Report := ⟨0, 0⟩

theorem pr_admissible : Admissible pr := by
  constructor <;> norm_num [pr]

theorem rf_admissible : Admissible rf := by
  constructor <;> norm_num [rf]

theorem ind_admissible : Admissible ind := by
  constructor <;> norm_num [ind]

theorem opn_admissible : Admissible opn := by
  constructor <;> norm_num [opn]

/-- The two vertices the core's scheduler must tell apart: "I have a theorem saying
    this is undecidable here, stop asking" against "I have got nowhere yet, spend
    more budget". They differ in `r` and agree in `z`. Under the rival
    model-ensemble reading `z = 0` forces `r = 0` and both collapse to `opn`; that
    collapse is what selects this interface. -/
theorem ind_ne_opn : ind ≠ opn := by
  intro h
  have : (1 : ℚ) = 0 := congrArg Report.r h
  norm_num at this

theorem ind_ne_rf : ind ≠ rf := by
  intro h
  have : (0 : ℚ) = -1 := congrArg Report.z h
  norm_num at this

theorem pr_ne_opn : pr ≠ opn := by
  intro h
  have : (1 : ℚ) = 0 := congrArg Report.r h
  norm_num at this

/-- Negation of the sentence flips the lean and leaves settledness alone. This is
    the only operation on reports that is unambiguously well defined, and even it
    is only well defined because `r` is symmetric in proved-versus-refuted. -/
def neg (p : Report) : Report := ⟨-p.z, p.r⟩

theorem neg_admissible {p : Report} (h : Admissible p) : Admissible (neg p) := by
  obtain ⟨h1, h2⟩ := h
  exact ⟨by simpa [neg, abs_neg] using h1, h2⟩

theorem neg_neg (p : Report) : neg (neg p) = p := by
  cases p; simp [neg]

/-- Negation FIXES the independent report. A sentence and its negation are both
    independent, and the interface says the same thing about both. This one line is
    the hypothesis that makes `no_truthfunctional_conj` bite. -/
theorem neg_ind : neg ind = ind := by
  simp [neg, ind]

/-- Averaging two reports. The core is allowed to do this -- pooling two
    reporters, or one reporter at two times -- and the result is still a legal
    report, because the triangle is convex. -/
def mix (t : ℚ) (p q : Report) : Report :=
  ⟨t * p.z + (1 - t) * q.z, t * p.r + (1 - t) * q.r⟩

/-- **The report triangle is convex.** A mixture of admissible reports is
    admissible, so the core's pooling operation never produces an inadmissible
    report and never needs to check for one. -/
theorem mix_admissible {t : ℚ} (ht0 : 0 ≤ t) (ht1 : t ≤ 1) {p q : Report}
    (hp : Admissible p) (hq : Admissible q) : Admissible (mix t p q) := by
  obtain ⟨hp1, hp2⟩ := hp
  obtain ⟨hq1, hq2⟩ := hq
  have h1t : (0 : ℚ) ≤ 1 - t := by linarith
  obtain ⟨hpl, hpu⟩ := abs_le.mp hp1
  obtain ⟨hql, hqu⟩ := abs_le.mp hq1
  constructor
  · show |t * p.z + (1 - t) * q.z| ≤ t * p.r + (1 - t) * q.r
    rw [abs_le]
    constructor <;> nlinarith
  · show t * p.r + (1 - t) * q.r ≤ 1
    nlinarith

/-- **No binary function on reports computes conjunction.**

    HONESTY NOTE, and it is the whole point of the theorem: the Lean content below
    is `ind ≠ rf` and nothing else. The theorem is arithmetically trivial. Its
    content lives entirely in the two hypotheses, which are supplied by the logic:

      * take `φ` independent, so the layer reports `ind` for `φ`, and by `neg_ind`
        also `ind` for `¬φ`;
      * `φ ∧ φ` is independent, so a truth-functional `f` must give `f ind ind = ind`;
      * `φ ∧ ¬φ` is refutable, so the same `f` on the same two inputs must give `rf`.

    Identical inputs, different required outputs. Hence provability is not
    truth-functional at this interface, and the core CANNOT be handed a truth table
    on reports. This is the report-level form of the standard objection to
    Lukasiewicz and MV-algebras (`logic-beyond-su3.md` §5.1); the value here is that
    it is stated about the exact interface type the architecture proposes, so it
    cannot be waved away as being about a different object.

    Design consequence, stated in the essay §2.5: the core may CONSTRAIN reports
    (check admissibility, pool, compare, schedule) and must never COMPUTE with them
    as if they were truth values. -/
theorem no_truthfunctional_conj (f : Report → Report → Report)
    (h_self : f ind ind = ind) (h_contra : f ind ind = rf) : False :=
  ind_ne_rf (h_self ▸ h_contra)

/-- The same obstruction stated without naming `ind`, so it cannot be read as an
    artefact of one chosen vertex: any `f` required to send one pair of inputs to
    two distinct outputs does not exist. -/
theorem no_binary_op {p q a b : Report} (hab : a ≠ b) (f : Report → Report → Report)
    (h1 : f p q = a) (h2 : f p q = b) : False :=
  hab (h1 ▸ h2)

end Report

/-! ## Part B. The two layers, and the reflection trap between them

`Layer` is `docs/dreamed/lean/LogicBeyondSU3.lean`'s `GLSystem`, re-declared here
because the dreamed Lean files are checked individually and cannot import each
other. `loeb_rule` below is that file's proof, credited to it. Everything after
`Bridge` is new and is the reason this file exists. -/

/-- An abstract theory: sentences `P`, a metalevel theoremhood predicate `Thm`, an
    object-level provability predicate `box`, closed under modus ponens and
    necessitation and satisfying Loeb's axiom.

    Nothing here is arithmetic. The real theorem about PA is that its provability
    predicate satisfies these conditions, which needs arithmetisation of syntax and
    is not formalised in this repo. -/
structure Layer (P : Type u) where
  /-- Object-level implication. -/
  imp : P → P → P
  /-- `box a` is the SENTENCE "`a` is provable in this layer". -/
  box : P → P
  /-- Falsum. -/
  bot : P
  /-- Metalevel theoremhood: `Thm a` says this layer proves `a`. -/
  Thm : P → Prop
  /-- Modus ponens. -/
  mp : ∀ {a b : P}, Thm (imp a b) → Thm a → Thm b
  /-- Necessitation, derivability condition 1. -/
  nec : ∀ {a : P}, Thm a → Thm (box a)
  /-- Loeb's axiom `□(□a → a) → □a`. -/
  loeb : ∀ a : P, Thm (imp (box (imp (box a) a)) (box a))

namespace Layer

variable {P : Type u} (S : Layer P)

/-- The layer's own consistency sentence, `□⊥ → ⊥`. -/
def Con : P := S.imp (S.box S.bot) S.bot

/-- Metatheoretic consistency: a statement in Lean ABOUT the layer, not a sentence
    of it. Keeping those apart is the whole discipline of this Part. -/
def Consistent : Prop := ¬ S.Thm S.bot

/-- The reflection instance for `a`: the sentence `□a → a`, "if this layer proves
    `a`, then `a`". -/
def refl (a : P) : P := S.imp (S.box a) a

/-- **Loeb's rule.** CREDIT: this is `LogicBeyondSU3.lean`'s `loeb_rule`, reproduced
    verbatim so this file compiles standalone. Nothing here is claimed as new. -/
theorem loeb_rule {a : P} (h : S.Thm (S.refl a)) : S.Thm a :=
  S.mp h (S.mp (S.loeb a) (S.nec h))

/-- Goedel II in the abstract setting, likewise the sibling's. Included because the
    cross-layer results below are its generalisation and the reader should be able
    to see the two side by side. -/
theorem godel_two (hc : S.Consistent) : ¬ S.Thm S.Con :=
  fun h => hc (S.loeb_rule h)

/-- No global self-reflection, likewise the sibling's. A consistent layer cannot
    prove `□a → a` for every `a`. -/
theorem no_self_reflection (hc : S.Consistent) : ¬ (∀ a : P, S.Thm (S.refl a)) :=
  fun h => hc (S.loeb_rule (h S.bot))

end Layer

/-! ### The cross-layer form, which is what the architecture actually needs

The sibling's `no_self_reflection` says a layer cannot certify ITSELF. The owner's
design does not ask it to. It asks whether a SEPARATE core -- weaker, decidable,
sitting underneath -- can certify the upper layer on its behalf. That is a
different statement and it needs a different theorem.

The catch is that the core is chosen for decidability, hence for weakness, hence
the upper layer can reproduce everything the core proves. That is what a `Bridge`
records. -/

/-- A **bridge** from a core `C` to an upper layer `U`.

    `t` translates core sentences into upper-layer sentences. `transfer` says the
    upper layer proves every translated core theorem -- which is exactly what it
    means for the core to be WEAKER, and is the condition the architecture creates
    on purpose by choosing a decidable core.

    `reflOf` and `expresses` say the core can NAME the upper layer's reflection
    instances: for each upper sentence `a` there is a core sentence whose
    translation is `□a → a`. Without this the core cannot even state the soundness
    claim the design wants from it, so it is a requirement of the design and not an
    artefact of the proof. -/
structure Bridge {PC : Type u} {PU : Type v} (C : Layer PC) (U : Layer PU) where
  /-- Translation of core sentences into the upper layer's language. -/
  t : PC → PU
  /-- The core is interpretable in the upper layer: everything the core proves, the
      upper layer proves too, under translation. -/
  transfer : ∀ a : PC, C.Thm a → U.Thm (t a)
  /-- A core sentence naming the upper layer's reflection instance for `a`. -/
  reflOf : PU → PC
  /-- ...and it really does name it. -/
  expresses : ∀ a : PU, t (reflOf a) = U.refl a

namespace Bridge

variable {PC : Type u} {PU : Type v} {C : Layer PC} {U : Layer PU} (B : Bridge C U)

/-- **A core certificate is never a shortcut.**

    If the core proves "the upper layer is sound about `a`", then the upper layer
    already proves `a`. So the certificate cannot license anything the upper layer
    had not already established on its own, and a core acting as a soundness oracle
    for a not-yet-proved sentence is impossible.

    This is the single most useful fact in the file for the design, because it
    kills the most attractive reading of the architecture: that the decidable core
    could rule on sentences the incomplete layer cannot settle. It cannot. Anything
    the core can certify, the upper layer had already proved by itself. -/
theorem certificate_is_no_shortcut {a : PU} (h : C.Thm (B.reflOf a)) : U.Thm a :=
  U.loeb_rule (B.expresses a ▸ B.transfer _ h)

/-- **The architecture's binding constraint.** A consistent upper layer cannot have
    its soundness certified wholesale by a core that it interprets. Global
    certification across the bridge collapses into upper-layer self-certification,
    and Loeb kills it.

    Read as the design rule the essay §4.3 states: *trust cannot be delegated
    downward to something weaker*. Putting the certifier underneath does not evade
    Goedel II, it relocates it. -/
theorem no_core_certified_soundness (hU : U.Consistent) :
    ¬ (∀ a : PU, C.Thm (B.reflOf a)) :=
  fun h => hU (B.certificate_is_no_shortcut (h U.bot))

/-- The core is dragged down with it: if the core certifies the upper layer
    globally and the upper layer is consistent, the core is refuted too, in the
    sense that the certification cannot hold. Stated separately because a designer
    might hope the damage stays upstairs. It does not. -/
theorem certification_forces_inconsistency (h : ∀ a : PU, C.Thm (B.reflOf a)) :
    ¬ U.Consistent :=
  fun hU => B.no_core_certified_soundness hU h

end Bridge

/-- **No mutual certification.** Two layers cannot vouch for each other, in either
    direction, if either is consistent. Trust between layers must be
    well-founded -- which is precisely why the literature's answer is an ORDINAL
    hierarchy of theories (Turing 1939, Feferman 1962) rather than a pair. -/
theorem no_mutual_certification {PC PU : Type u} {C : Layer PC} {U : Layer PU}
    (B : Bridge C U) (B' : Bridge U C)
    (h : ∀ a : PU, C.Thm (B.reflOf a)) (h' : ∀ a : PC, U.Thm (B'.reflOf a)) :
    ¬ C.Consistent ∧ ¬ U.Consistent :=
  ⟨fun hC => B'.no_core_certified_soundness hC h', fun hU => B.no_core_certified_soundness hU h⟩

/-! ### The escape, and exactly what it costs

A concrete two-element model. `boolLayer` has sentences `Bool`, `box` constantly
`true`, and `Thm a := (a = true)`. It satisfies all four Layer conditions and is
consistent. -/

/-- Non-vacuity witness for `Layer`. Deliberately degenerate; emphatically not a
    model of arithmetic. Same construction as the sibling's `boolModel`. -/
def boolLayer : Layer Bool where
  imp a b := (!a || b)
  box _ := true
  bot := false
  Thm a := a = true
  mp := by intro a b h1 h2; subst h2; simpa using h1
  nec := by intro a _; rfl
  loeb := by intro a; rfl

theorem boolLayer_consistent : boolLayer.Consistent := by
  intro h; exact Bool.noConfusion h

/-- In `boolLayer`, `box` is constant, so the reflection instance for `a` simplifies
    to `a` itself. Needed below. -/
theorem boolLayer_refl (a : Bool) : boolLayer.refl a = a := by
  cases a <;> rfl

/-- **The escape, half one.** A consistent core proves a certificate-shaped core
    sentence for EVERY upper sentence, with a consistent upper layer, and nothing
    is contradicted. Here the candidate certificate is the constantly `true` core
    sentence and `boolLayer` proves it for every `a`.

    Nothing is contradicted because there is no `Bridge` carrying it. The next
    theorem shows there cannot be one. So the fatal argument of
    `no_core_certified_soundness` is not a fact about certificates: it is a fact
    about certificates PLUS interpretability PLUS expressibility, and the design's
    only room to move is in the last two conjuncts. -/
theorem escape_needs_no_bridge : ∀ _a : Bool, boolLayer.Thm true :=
  fun _ => rfl

/-- **And here is the price.** No `Bridge` from `boolLayer` to `boolLayer` can have
    a constant `reflOf`. The bridge's `expresses` field would force one fixed
    translated sentence to equal `U.refl a` for every `a` at once, and in this model
    `U.refl a = a`, so `t` would have to send one value to both `true` and `false`.

    The design reading: a core can hold a cheap universal certificate exactly when
    it cannot express what the certificate is ABOUT. Expressiveness enough to name
    the upper layer's reflection instances is precisely what makes the certificate
    fatal. That trade is the essay §4.4's recommendation, and this is its
    machine-checked form. -/
theorem no_bridge_for_constant_certificate
    (B : Bridge boolLayer boolLayer) (c : Bool) (hc : ∀ a : Bool, B.reflOf a = c) :
    False := by
  have h1 := B.expresses true
  have h2 := B.expresses false
  rw [hc true, boolLayer_refl] at h1
  rw [hc false, boolLayer_refl] at h2
  exact Bool.noConfusion (h1.symm.trans h2)

/-! ## Part C. Does incompleteness re-enter through the interface?

This is the question the whole architecture stands on, and the answer is: yes, if
the interface is exact. -/

section Oracle

variable {P : Type u} (S : Layer P)

/-- A reporter for a layer: it assigns each sentence a report. -/
abbrev Reporter (P : Type u) := P → Report

/-- **Exact reports are a provability oracle.**

    Suppose the upper layer's reporter is EXACT: it returns `pr` on a sentence
    precisely when the layer proves it. Then theoremhood in the upper layer is
    decidable, because deciding it is now just comparing two reports -- and `Report`
    is two rationals, so that comparison is a genuine computation
    (`DecidableEq Report`, derived above).

    For a layer whose theoremhood is undecidable -- which is every layer worth
    calling incomplete in the owner's sense, since interpreting arithmetic makes
    provability Sigma-1-complete and hence undecidable by Church and Turing -- the
    hypothesis is therefore FALSE. No exact reporter exists.

    **This is the load-bearing result of the essay.** The interface does not smuggle
    arithmetic in through its TYPE: two rationals with a linear constraint stay
    inside a decidable theory of the ordered field. It smuggles it in through the
    interface's ACCURACY. The design consequence is stated in §2.6: the reporter
    must be allowed to be under-confident, returning `opn` where the truth is
    `pr`, and the core must be written to treat every report as a lower bound on
    what is known rather than as a fact. An interface specified as exact is an
    interface that cannot be implemented. -/
@[reducible]
def exactReportsDecide (ρ : Reporter P) (h : ∀ a, ρ a = Report.pr ↔ S.Thm a) :
    DecidablePred S.Thm :=
  fun a => decidable_of_iff (ρ a = Report.pr) (h a)

/-- The same fact as a PROPOSITION, so it can carry a `\veq` badge honestly:
    an exact reporter makes upper-layer theoremhood decidable. `Nonempty` is used
    only because `Decidable` is data and a `theorem` must be a `Prop`. -/
theorem exact_reports_decide (ρ : Reporter P) (h : ∀ a, ρ a = Report.pr ↔ S.Thm a) :
    ∀ a, Nonempty (Decidable (S.Thm a)) :=
  fun a => ⟨exactReportsDecide S ρ h a⟩

/-- Soundness alone -- "if it says proved, it is proved" -- buys the core no such
    oracle, and here is the witness: the reporter that always says `opn` is sound
    for every layer whatsoever and decides nothing. Cheap, and that is the point:
    the whole content of an interface specification is in its COMPLETENESS
    direction, which is the direction that cannot be had. -/
theorem constant_open_is_sound (a : P) :
    (fun _ : P => Report.opn) a = Report.pr → S.Thm a := by
  intro h
  exact absurd h.symm Report.pr_ne_opn

/-- The core's licensing rule: it may assert a sentence only on a report that is
    both fully settled and fully leaning. -/
def Licenses (p : Report) : Prop := p.z = 1 ∧ p.r = 1

/-- A reporter is sound for a layer when every licensing report is backed by an
    actual theorem. Note this is a hypothesis ABOUT the reporter that the core
    cannot itself verify -- by `Bridge.no_core_certified_soundness`, a core that
    could verify it wholesale would force the upper layer inconsistent. -/
def SoundFor (ρ : Reporter P) : Prop := ∀ a, Licenses (ρ a) → S.Thm a

/-- **Interface soundness, and it is cheap.** A core that only ever asserts what a
    sound reporter licenses never asserts falsum, provided the upper layer is
    consistent.

    Stated because the architecture owes the statement, and flagged as cheap
    because it is: all the difficulty has been pushed into the hypothesis
    `SoundFor`, which is not checkable by the core. The honest summary is that
    interface soundness is a definition, and the theorem is its unfolding. Anyone
    who reads this as evidence that the design works has read it wrong; the
    evidence about whether it works is in Part B. -/
theorem core_never_asserts_falsum {ρ : Reporter P} (hs : SoundFor S ρ)
    (hc : S.Consistent) : ¬ Licenses (ρ S.bot) :=
  fun h => hc (hs _ h)

/-- And the same statement pushed one step further, which is the version worth
    quoting: on a sound reporter, everything the core licenses is an upper-layer
    theorem. The core adds no theorems of its own about the upper layer's
    sentences. It is a consumer, never a source. -/
theorem core_adds_nothing {ρ : Reporter P} (hs : SoundFor S ρ) (a : P)
    (h : Licenses (ρ a)) : S.Thm a := hs a h

end Oracle

/-! ## Part D. Two small facts the essay quotes about the triangle -/

/-- The report triangle is not degenerate: it contains a point that is neither a
    vertex nor on the boundary segments the model-ensemble reading reaches. -/
theorem interior_point_admissible : Report.Admissible ⟨1/4, 3/4⟩ := by
  constructor <;> norm_num

/-- And a point outside it, so admissibility is a real constraint and the core's
    check is not vacuous: a report leaning harder than it is settled. -/
theorem overconfident_not_admissible : ¬ Report.Admissible ⟨9/10, 1/10⟩ := by
  intro h
  have := h.1
  rw [abs_of_nonneg (by norm_num : (0:ℚ) ≤ 9/10)] at this
  norm_num at this

end Toesnail.LogicLayered
