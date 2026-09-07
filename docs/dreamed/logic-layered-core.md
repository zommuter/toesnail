---
title: A layered logic core
permalink: /dreamed/logic-layered-core
---

# A layered logic core: the architecture, specified

> **DREAMED, UNREVIEWED.** Written by an AI agent, not by the owner, and not yet read by him.
> See [`docs/dreamed/README.md`](README.md). Nothing here is theory, nothing here is decided, and
> nothing from it has been written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`. This essay works
> directly on the owner's own architecture idea, so **every proposal below is a recommendation for
> him to accept, amend or reject**, and the sections that bear on his own words are located and
> evidenced rather than asserted.

## Provenance

The seed is one sentence of the owner's, in his own idea pool, naming a standing backburner project
of his:

> *"the Bloch Truth (might need a better name) might be useful for the AI logic core in the second
> (ZFC?) layer where incompleteness applies (core layer should only be complete, e.g. ZF without
> C)"*
>
> `~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`,
> his turn, 2025-08-08 07:22 UTC.

Four sibling essays in this cluster orbited that sentence and established two things this one builds
on rather than rediscovers.

1. **The parenthetical is wrong, and it has already been filed for the owner's ruling**
   (`REVIEW_ME.md`, `id:251e`; [`logic-bloch-poles.md`](logic-bloch-poles.md) §7.1). Dropping the
   axiom of choice buys no completeness. Goedel I needs consistency, effective axiomatisation, and
   the interpretation of enough arithmetic; ZF has all three and AC is on none of the lists, so ZF
   is incomplete if consistent. Worse for the parenthetical, AC's own independence from ZF (Goedel
   1938 via the constructible universe, Cohen 1963 via forcing) *is* an instance of ZF's
   incompleteness. "ZF without C" is an example of the problem, not an escape from it. **The
   architecture survives with the boundary redrawn**, at *interprets arithmetic* versus *does not*.
2. **The machinery the design wants already exists.**
   [`logic-beyond-su3.md`](logic-beyond-su3.md) §3.3 found that provability logic **GL** is
   decidable (PSPACE-complete) while the theory it describes is not, and that Solovay (1976) proved
   GL arithmetically complete for PA: `GL ⊢ A` iff `PA ⊢ f(A)` for every arithmetical realisation
   `f`. A decidable metalayer reasoning soundly about an incomplete object layer is not an
   aspiration to be engineered. It is a theorem from 1976.

This essay does the remaining work: it specifies the architecture, adjudicates the interface, and
then tries to break it.

---

# 0. The architecture, stated and not teased

> **Recommendation, in one box.**
>
> **Layer 0, the Kernel.** A quantifier-free constraint language over an ordered field, plus
> propositional logic. Complete and decidable *because it is too weak to describe itself*. It holds
> no sentences of the upper layer, only reports about them.
>
> **Layer 1, the Theory.** Whatever the system actually reasons in: ZFC, or a dependent type theory,
> or a first-order theory with induction. Incomplete, by Goedel I, and that is accepted rather than
> mitigated.
>
> **The interface.** Layer 1 hands Layer 0 a **report** per sentence: a pair of rationals
> `(z, r)`, truth lean and settledness, constrained by `|z| ≤ r ≤ 1`. The four corners are proved,
> refuted, independent, open.
>
> **GL sits beside, not between.** It is the *audit language* for statements about Layer 1's
> provability operator. It does not compute reports and the Kernel does not run it in its hot path.

Four findings decide the shape, and three of them are negative.

1. **A core certificate is never a shortcut** (`certificate_is_no_shortcut`, §4.3). If the Kernel
   proves "if the Theory proves `a`, then `a`", the Theory has already proved `a`. The seductive
   reading of the owner's architecture, that a decidable core could adjudicate what the incomplete
   layer cannot, is closed off by Loeb's theorem in its cross-layer form.
2. **Exact reports are a provability oracle** (`exact_reports_decide`, §2.6). If the report says
   `proved` exactly when the sentence is provable, comparing two reports decides Layer 1's
   theoremhood, which is undecidable. So the interface must be *permitted to be under-confident*.
   That is a specification requirement, not a quality-of-implementation concession.
3. **No binary function on reports computes conjunction** (`no_truthfunctional_conj`, §2.4). `φ` and
   `¬φ` both independent report the same pair, yet `φ ∧ φ` is independent and `φ ∧ ¬φ` is refutable.
   The Kernel may *constrain* reports and must never *compute* with them.
4. **The positive half is cheap, and saying so is the honest part.** Interface soundness is one line
   of unfolding (`core_never_asserts_falsum`). All the difficulty sits in the hypothesis that the
   reporter is sound, and by finding 1 that is exactly what the Kernel cannot verify.

**And the architecture is not new.** §5 reports the sweep: this is **proof-carrying code**, and
Necula and Lee stated the owner's split in 1998 as "neither the compiler nor the prover need to be
correct". Milawa built the well-founded tower with eleven levels; Harrison's 1995 survey states both
the reflection limit and the escape this essay recommends, under the published name *partial
reflection schemas*; and Lean's own kernel, sitting in `verify/` in this repository, is a decidable
underapproximation of an undecidable relation, which is finding 2 arrived at independently. Only the
`(z, r)` report format has any claim to novelty. **That is a good outcome, not a disappointing one:
the owner's instinct located a real design pattern rather than a dead end.**

**And the ball does not survive.** Nothing in the architecture uses a third coordinate. §6 says so
plainly, and then says what of the owner's idea *does* survive, because a great deal does.

---

# 1. The two layers, named and specified

## 1.1 The redrawn boundary

The owner's instinct is that a system needs a floor it can trust and a ceiling where the
interesting, incomplete reasoning happens. That instinct is right and the literature agrees with it
under several names (§5). What has to change is the *criterion* for the floor.

The criterion is not "fewer axioms". Set theory does not become complete by shedding one, and no
amount of shedding helps, because what forfeits completeness is **interpreting arithmetic**.
Robinson's Q suffices, and Q is a finitely axiomatised fragment with no induction at all. Any theory
that interprets Q, if consistent and effectively axiomatised, is incomplete.

So the boundary is:

$$ \text{Layer 0} \;=\; \text{does not interpret arithmetic} \qquad
   \text{Layer 1} \;=\; \text{does} $$

That is a statement about **expressive weakness**, and it means the Kernel's completeness is bought,
not discovered. The design must be honest that a decidable core is decidable *precisely because it
cannot say very much*, and the price has to be stated at full strength before the candidates are
compared.

## 1.2 Candidates for the Kernel, with their costs

All classical, all quoted from the literature rather than proved here.

| Candidate | Complete | Decidable | Complexity of the decision problem | What it costs |
|---|---|---|---|---|
| Propositional logic | yes | yes | validity co-NP-complete (Cook 1971) | no quantifiers, no objects, no numbers at all |
| **Presburger arithmetic** (naturals with `+`, no `×`) | yes | yes | **doubly exponential** lower bound (Fischer-Rabin 1974); triple-exponential upper (Oppen 1978) | drop multiplication and you drop Goedel, but you also drop most of arithmetic |
| **Real closed fields** (Tarski 1948) | yes | yes | doubly exponential in general (Davenport-Heintz 1988); singly exponential for the existential fragment | reals only: no integers definable, so no counting, no induction, no syntax |
| **Tarski's elementary geometry** (1959) | yes | yes | as RCF, by interpretation | same, plus a fixed dimension |
| Algebraically closed fields of fixed characteristic | yes | yes | quantifier elimination | no order at all |
| Dense linear orders without endpoints | yes | yes | trivial | only order |
| **S1S / monadic second-order over one successor** (Buechi 1962) | yes | yes | **non-elementary** (Meyer 1975): the decision procedure's running time exceeds any fixed tower of exponentials | expressively rich and computationally hopeless, and its extension S2S (Rabin 1969) is worse |
| **GL** | yes | yes | **PSPACE-complete** | propositional only; theory-relative; `□` is a modality, not a value (§3) |

Two of these are traps and should be named as such.

**S1S is the trap for anyone who reads "decidable" as "usable".** Its decision procedure is
non-elementary: no tower of exponentials is tall enough to bound it. Decidability is a mathematical
property, not an engineering one.

**The RCF trap is subtler and it is the one this design has to avoid.** Real closed fields are
decidable, so it is tempting to make the Kernel RCF and let it reason about reports. That is
harmless right up to the moment someone lets it *quantify over sentences*. RCF is decidable because
the integers are not definable in it; add a predicate picking out ℤ and arithmetic is back and the
decidability is gone. Any Kernel that indexes reports by Goedel numbers and can quantify over that
index has done exactly this. §2.6 turns that into the essay's load-bearing check.

## 1.3 Recommendation: the Kernel is a constraint solver, not a theory

> **Recommended Kernel: quantifier-free linear arithmetic over an ordered field, plus propositional
> logic over report atoms. Call it the Report Calculus.**
>
> Concretely: variables range over the report coordinates; atoms are linear comparisons among them
> and rational constants; the propositional structure is unrestricted. This is a decidable fragment
> that off-the-shelf SMT solvers decide today (`QF_LRA`), and its decision problem is NP-complete
> rather than doubly exponential.

Why this rather than Presburger or RCF: because the Kernel's *job* is small. It compares reports,
checks admissibility, pools them, and schedules work. It never needs a quantifier over sentences, it
never needs multiplication of two unknowns, and it never needs induction. Choosing the smallest
fragment that does the job is what keeps the decidability from being an accident that a later
feature quietly revokes.

**What the Report Calculus cannot express, stated plainly because a decidable core is decidable
precisely because it is weak:**

- It cannot state "the Theory is consistent". There is no provability predicate in it and no
  arithmetisation of syntax, so `Con(T)` is not a sentence it has.
- It cannot state "for every sentence `a`". It has no quantifier over the sentence index. Everything
  it says is about the finitely many reports currently in front of it.
- It cannot define the integers, hence cannot count, hence cannot do induction or recursion.
- It cannot express its own soundness, or the Theory's. Both are schemata over sentences.
- It therefore **cannot be the system's reasoner**. It is a supervisor with a very short memory and
  no ability to describe what it supervises. Anyone hoping the Kernel would be the "safe core" that
  *checks* the reasoning has to accept that it can only check *arithmetic-free summaries* of the
  reasoning.

That last point is where the design either becomes honest or becomes wishful. §5 finds that the
honest version is standard practice with a name, and the wishful version has a literature of
failures behind it.

## 1.4 What Layer 1 is, and what it must supply

Layer 1 is whatever the system reasons in. Nothing in this architecture constrains it beyond three
things it must supply.

1. **A proof search with an observable state.** The report is a report *of the search*, not of the
   truth. This is the epistemic-status reading adjudicated in §2.1, and it is chosen because a
   running system plausibly has access to the state of its own proof search, whereas it has no
   access to a measure over the models of its theory. That is an engineering claim, not a theorem,
   and it should be marked as the weakest joint in the design.
2. **A monotone discipline.** Once the search has settled a sentence, it does not unsettle it. This
   makes the report's `r` coordinate monotone in time, which is what lets the Kernel treat a report
   as a lower bound (§2.6).
3. **Under-confidence rather than error.** Reporting `open` on a settled sentence is legal. Reporting
   `proved` on an unsettled one is a soundness violation. The asymmetry is forced, not chosen (§2.6).

---

# 2. The interface, which is the real design work

## 2.1 The fork, adjudicated for the interface specifically

Two sibling essays disagree about what the pair `(z, r)` is a state *of*, and they reach different
answers about what is reachable.

- [`logic-epistemic-state.md`](logic-epistemic-state.md) proposes a distribution over **epistemic
  statuses** of one sentence for one agent: proved, refuted, independent, open. Then
  `z = p_proved − p_refuted`, `r = 1 − p_open`, and the reachable set is the whole triangle
  `|z| ≤ r ≤ 1`.
- [`logic-models-ensemble.md`](logic-models-ensemble.md) proposes a measure over **completions** of
  the theory. A measure gives one number per sentence, the state is `diag(p, 1−p)`, and the
  reachable set is only `|z| = r`, a pair of segments. On that reading the pair collapses to a
  single number and the second coordinate is redundant.

[`logic-models-vs-epistemic.md`](logic-models-vs-epistemic.md) adjudicated the fork and this essay
adopts its verdict, for the interface, on one ground and states the ground rather than the verdict:

> Under the model-ensemble reading, `z = 0` forces `r = 0`. So *"I have a theorem saying this is
> undecidable here, stop asking"* and *"I have got nowhere yet, spend more budget"* are the **same
> point**. That is the one operational distinction a scheduler in the Kernel actually needs, and the
> reading that collapses it cannot be the interface, whatever its other merits.

That is a decision *for this architecture*, not a verdict on the readings. The model-ensemble
picture is exact and beautiful and it is where Goedel's phenomenon is visible as geometry; the
adjudicating essay's recommendation to keep it **as the semantics the report must be sound against**
is adopted here unchanged. Two objects, two jobs, a soundness map between them.

**One correction that matters and that this essay endorses.** The constraint `|z| ≤ r` is *not* a
Bloch fact. On the status simplex it is derived, `|a − b| ≤ a + b ≤ a + b + c`. The ball merely
happens to satisfy the same inequality for the unrelated reason that a vector component never
exceeds the norm. Two facts that agree numerically and share no proof are not evidence for
identifying the objects, and "the geometry enforces it for free" is therefore backwards as an
argument for the ball: the cheaper object enforces it *and derives it*.

## 2.2 The report type, specified

$$
\mathrm{Report} \;=\; \{\, (z, r) \in \mathbb{Q}^2 \;:\; |z| \le r \le 1 \,\}
\veq{report-triangle}\lean
$$

with the four corners

$$
\text{proved} \mapsto (1, 1),\quad
\text{refuted} \mapsto (-1, 1),\quad
\text{independent} \mapsto (0, 1),\quad
\text{open} \mapsto (0, 0).
$$

Three specification decisions, each with a reason.

**Rationals, not reals.** The Kernel has to *compare* reports, and the comparison has to be a
computation. There is no decidable equality on ℝ. This is not a convenience: it is what makes §2.6's
oracle argument bite, and a design that quietly used reals would have hidden the bite rather than
removed it.

**Admissibility is a checkable precondition, not a promise.** `Admissible` is decidable, and the
Kernel checks it on every incoming report. A layer returning `z = 0.9, r = 0.2` is making an
inadmissible report and is rejected by geometry rather than by policy. Machine-checked that the
check is non-vacuous in both directions: `(1/4, 3/4)` passes, `(9/10, 1/10)` fails.

**Two numbers and nothing else.** No sentence, no proof object, no Goedel number crosses the
boundary. That poverty is the design intent. §2.6 shows it is also necessary.

## 2.3 What the Kernel may do with reports

Three operations, all admissibility-preserving, all machine-checked.

| Operation | Definition | Preserves admissibility |
|---|---|---|
| Negation | `(z, r) ↦ (−z, r)` | `neg_admissible` |
| Pooling | `t·p + (1−t)·q` for `0 ≤ t ≤ 1` | `mix_admissible` |
| Comparison | decidable equality and the order on each coordinate | `DecidableEq Report` |

$$
0 \le t \le 1,\;\; p, q \in \mathrm{Report} \;\Longrightarrow\; t p + (1-t) q \in \mathrm{Report}
\veq{report-convex}\lean
$$

Pooling is available because the report triangle is **convex**, so averaging two reporters, or one
reporter at two times, never produces something the Kernel then has to reject. That is worth stating
because it is the one place where the geometry does honest work: the admissible set being convex is
a property of the triangle, and it would fail for many other plausible constraint shapes.

## 2.4 What the Kernel may not do, and this is the sharp edge

**No truth-functional connectives on reports.**

$$
\nexists\, f : \mathrm{Report}^2 \to \mathrm{Report} \;\text{ with }\;
f(\text{ind},\text{ind}) = \text{ind} \;\wedge\; f(\text{ind},\text{ind}) = \text{refuted}
\veq{no-conj}\lean
$$

The two constraints come from the logic, not from the arithmetic. Take `φ` independent. Then `¬φ` is
independent too, and negation fixes the independent report (`neg_ind`, machine-checked), so the
Kernel sees the same input pair in both of the following cases:

- `φ ∧ φ` is independent, so a truth-functional `f` must return `independent`;
- `φ ∧ ¬φ` is refutable, so the same `f` on the same inputs must return `refuted`.

The Lean content of `no_truthfunctional_conj` is `ind ≠ rf` and nothing more; the theorem is
arithmetically trivial and the file says so in its own docstring. **Its content is entirely in the
two hypotheses.** The value of stating it in Lean is that it is stated about *the exact interface
type this architecture proposes*, so it cannot be deflected as an argument about a different object.

**One reconciliation, added after [`logic-simplex.md`](logic-simplex.md) landed, because it stops
this section being over-read.** That essay builds a four-status conjunction table in which
`independent ∧ independent = open`, commutative, associative, monotone, with *refuted* absorbing and
*proved* as unit. That is not a counterexample to the theorem above: it is a **sound abstract
transformer** in the abstract-interpretation sense, which *loses* information deliberately rather
than computing the right answer. Both statements are true together, and the pair is the useful form:

> An **exact** truth-functional connective on reports does not exist. A **sound, lossy** one does,
> and it is the right thing to implement, provided the Kernel treats its output as an
> over-approximation. That same essay notes the table is not idempotent, hence not a meet, hence the
> statuses carry no lattice and no Heyting algebra.

This is the report-level form of the standard objection to Lukasiewicz logic and MV-algebras that
[`logic-beyond-su3.md`](logic-beyond-su3.md) §5.1 raises: **provability is not truth-functional.**
The design consequence is a hard rule:

> The Kernel may **constrain** reports (check, pool, compare, schedule, reject). It may never
> **compute** with them as though they were truth values. Any feature request of the form "let the
> core evaluate `φ ∧ ψ` from the reports" is asking for an object that does not exist.

## 2.5 Which sibling's format wins, and the honest cost of the winner

[`logic-epistemic-state.md`](logic-epistemic-state.md)'s four-status simplex is the sample space and
the two-number report is its affine image. That is the recommendation. Its cost is documented by the
essay that proposes it and confirmed by the adjudicator, and it is a real one:

$$
\text{report}(0, 0, 1, 0) \;=\; \text{report}(\tfrac12, \tfrac12, 0, 0) \;=\; (0, 1)
$$

The report cannot tell **"proved independent"** from **"the agent is certain the theory decides this
and has no idea which way"**. Both land on `(0, 1)`. Independence is the *midpoint of the top edge*
of the report triangle, not an extreme point of it, which is why an even split between proved and
refuted reaches it.

For a scheduler that difference is exactly as operational as the one the report *does* capture: one
says "stop", the other says "this is a coin flip, guess". So the two-number report **wins one
operational distinction and loses another**, and it loses it to the very simplex it is a projection
of.

**Recommendation, with the trade named.** Ship the two-number report as the *wire format* and keep
the three-number status vector `(p_proved, p_refuted, p_independent)` available as an extended
report on request. Two numbers is the cheap common case; when the scheduler's next decision turns on
the distinction the projection destroys, it asks for the third. If the owner rules that the
distinction is always needed, the honest consequence is that the object is a 3-simplex, the report
is three numbers, and **the geometry disappears entirely**. That would not be a defeat; it would be
the design telling the truth about its own requirements.

## 2.6 The load-bearing question: does incompleteness re-enter through the interface?

This is the question the whole architecture stands on. If arithmetic sneaks back in through the
report format, the Kernel's decidability was never real and the design fails. There are three
channels and they have different answers.

**Channel 1: the report's TYPE. Safe.** Two rationals with a linear constraint. The theory of
ordered fields is decidable (Tarski); the quantifier-free linear fragment is decided by any SMT
solver. Nothing in the type can express a provability predicate, because there is no predicate
symbol over sentences in the language at all.

**Channel 2: the arithmetic OF the values. Safe.** Comparison, negation, and convex combination stay
inside `QF_LRA`. Multiplication appears only against rational constants (the mixing weight), never
between two unknowns, so the design never even needs the full ordered-field decision procedure.

**Channel 3: the ACCURACY of the report. Not safe, and this is the finding.**

$$
(\forall a)\;\big[\, \rho(a) = \text{proved} \iff T \vdash a \,\big]
\;\Longrightarrow\;
\text{theoremhood in } T \text{ is decidable}
\veq{exact-oracle}\lean
$$

The proof is one line and that is the point: deciding `T ⊢ a` becomes *comparing two rationals*.
`Report` has decidable equality by construction, so an exact reporter hands the Kernel a decision
procedure for free. For any Layer 1 worth the name -- one that interprets arithmetic, hence whose
provability is Sigma-1-complete, hence undecidable by Church and Turing -- **the hypothesis is
false**. No exact reporter exists.

**The design consequence is a specification requirement, not a caveat:**

> The reporter must be permitted to return `open` on a sentence that is in fact settled. The Kernel
> must be written so that every report is a **lower bound on what is known**, never a fact about
> what is knowable. An interface contract specified as exact cannot be implemented, and a system
> whose scheduler assumes exactness has an unsound scheduler.

The mirror image is worth stating because it is where the asymmetry lives. **Soundness alone buys
nothing and costs nothing**: the reporter that always returns `open` is sound for every layer
whatsoever and decides exactly nothing (`constant_open_is_sound`, machine-checked as a witness).
The entire content of an interface specification lives in its *completeness* direction, and that is
the direction that provably cannot be had.

## 2.7 Interface verdict

The interface survives, with one mandatory weakening and one documented loss.

- **Survives:** the type is arithmetic-free, the operations are decidable, the admissibility check
  is real and cheap, and the soundness norm `|z| ≤ r` is derived rather than stipulated.
- **Mandatory weakening:** reports are lower bounds. Exactness is unimplementable.
- **Documented loss:** the two-number projection conflates proved-independence with a fair coin, and
  the fix costs the geometry.

---

# 3. Where GL sits, precisely

**GL sits beside the two layers, as an audit language. It is not the Kernel and it is not in the
hot path.**

GL is the modal logic `K` plus Loeb's axiom

$$ \Box(\Box A \to A) \to \Box A \ltag{loeb} $$

read with `□A = Prov_T(⌜A⌝)`. It rests on the Hilbert-Bernays-Loeb derivability conditions, which
PA's provability predicate satisfies. Three classical facts, quoted:

- **Segerberg 1971.** GL is modally complete for finite transitive irreflexive trees.
- **Decidability.** GL is decidable and **PSPACE-complete**.
- **Solovay 1976.** `GL ⊢ A` iff `PA ⊢ f(A)` for every arithmetical realisation `f`. Solovay's
  second theorem identifies the logic of arithmetical *truth* as `GLS = GL + (□A → A)`, which is
  sound but **not closed under necessitation**.

## 3.1 What GL's decidability actually buys

It buys **schematic audit**. Questions of the form "does this pattern of provability claims follow
from that one, for *every* theory satisfying the derivability conditions, and *every* substitution
of sentences?" are decided in PSPACE, and by Solovay the answers are exactly right about PA. That is
genuinely useful, and it is the right home for the architecture's design rules:

- "may the Kernel conclude `a` from a certificate of `□a → a`?" is a GL question, and the answer is
  no unless `a` is already a theorem;
- "does trusting the Theory's soundness schema cost consistency?" is a GL question, and the answer
  is yes;
- "is this proposed reflection principle strictly stronger than that one?" is a GL question.

So GL is where the architecture's *rules* are checked, once, at design time. It is a tool for the
designer and for a static analyser, not a runtime component.

## 3.2 The seductive error, named

> **GL is decidable. Deciding whether PA proves a given sentence is not. Conflating those two is
> this architecture's most seductive error, and it would be fatal.**

The two statements quantify over different things. GL's decision problem is: *given a modal formula,
is it a theorem of GL?* -- equivalently, by Solovay, is it provable in PA under **every**
arithmetical realisation. PA's decision problem is: *given an arithmetical sentence, does PA prove
it?* -- which is Sigma-1-complete and undecidable by Church and Turing.

The gap is the universal quantifier over realisations. GL knows everything about the *shape* of
provability and nothing whatever about any *particular* sentence's content. `□p → p` is not a GL
theorem, and that fact tells you nothing about whether PA proves any specific `p`.

An architecture that put GL in the Kernel and expected it to *answer questions about Layer 1's
sentences* would be committing precisely this error. It would look like it worked, because GL would
keep returning decisive answers -- to a different question than the one asked.

Two further limits, stated so the recommendation is not over-read:

- **GL is propositional.** It has no quantifiers and no term structure. The quantified provability
  logic of PA is Pi-0-2-complete (Vardanyan), hence not recursively axiomatisable, so there is no
  first-order GL to escalate to.
- **GL is theory-relative by construction.** `□` is `Prov_T` for a *fixed* `T`. That is a virtue for
  honesty and a cost for any system meant to reason across theories, which a layered system with an
  escalation path eventually is.

## 3.3 So the picture is three objects, not two

$$
\underbrace{\text{Report Calculus}}_{\text{Kernel, runtime, decidable}}
\;\longleftarrow\;
\underbrace{\text{the Theory}}_{\text{Layer 1, runtime, incomplete}}
\qquad\qquad
\underbrace{\text{GL}}_{\text{design time, decidable, schematic}}
$$

The owner's sentence describes two layers. The correct picture has a third thing, off to the side,
that neither layer contains: the language in which the *relationship between* the layers is audited.
That is a genuine amendment to his architecture and it is offered as one.

---

# 4. The reflection problem, stated honestly

This is where the design either survives contact with the mathematics or does not.

## 4.1 Loeb's theorem, and what it does to self-trust

From Loeb's axiom plus modus ponens and necessitation, **Loeb's rule** follows: if `T ⊢ □A → A` then
`T ⊢ A`. Necessitate the hypothesis, detach the axiom, detach the hypothesis. Setting `A := ⊥`, and
noting that `Con_T` *is* `□⊥ → ⊥`, gives Goedel II immediately.

The slogan version is the one the architecture must live with:

> A theory that can prove "if I can prove it, then it is true" has thereby already proved it.
> **Self-trust is never free.**

This is done over an abstract provability predicate in
[`lean/LogicBeyondSU3.lean`](lean/LogicBeyondSU3.lean) (`loeb_rule`, `godel_two`,
`no_global_reflection`) and this essay does not restate it. It is reproduced in
[`lean/LogicLayered.lean`](lean/LogicLayered.lean) only so that file compiles standalone, credited
there.

## 4.2 Reflection principles: local, uniform, and the ladder above them

The design's real question is not self-trust but *delegated* trust, and to ask it precisely the
vocabulary has to be right.

- **Local reflection**, `Rfn(T)`: the schema `Prov_T(⌜φ⌝) → φ`, one instance per sentence `φ`.
- **Uniform reflection**, `RFN(T)`: the single sentence `∀x (Prov_T(⌜φ(ẋ)⌝) → φ(x))` for each
  formula `φ`, quantifying over the *numeral* inside the provability predicate.
- **Consistency**, `Con(T)`: the weakest of the three. `Rfn(T)` proves `Con(T)`; `RFN(T)` proves
  `Rfn(T)`; both implications are strict.

Uniform reflection is strictly stronger than local reflection, and the strictness is not a
technicality: iterating local reflection and iterating uniform reflection climb the ordinal
hierarchy at different rates. Beklemishev's proof-theoretic analysis by iterated reflection makes
this quantitative. For the architecture the relevant reading is:

> **There is no single "trust the layer below" principle.** There is a graded family of them, and
> the design has to say which one it means. "The Kernel trusts the Theory" is not yet a
> specification.

## 4.3 The cross-layer form, which is the theorem this design actually needs

The sibling's `no_global_reflection` says a layer cannot certify *itself*. The owner's design never
asks it to. It asks whether a **separate, weaker, decidable core** can certify the upper layer on
its behalf. That is a different statement and it needs a different theorem, which is what
[`lean/LogicLayered.lean`](lean/LogicLayered.lean) supplies.

Model the situation as a **bridge** from core `C` to upper layer `U` with three components:

1. a translation `t` of core sentences into `U`'s language;
2. **transfer**: `C ⊢ a` implies `U ⊢ t(a)`. This is exactly what it means for the core to be
   *weaker*, and the architecture creates this condition **on purpose**, by choosing a decidable
   core;
3. **expressibility**: for each `U`-sentence `a` there is a core sentence `reflOf(a)` with
   `t(reflOf(a)) = □a → a`. Without this the core cannot even *state* the soundness claim the design
   wants from it, so it is a design requirement and not an artefact of the proof.

Then, machine-checked:

$$
C \vdash \mathrm{reflOf}(a) \;\Longrightarrow\; U \vdash a
\veq{cert-no-shortcut}\lean
$$

$$
U \text{ consistent} \;\Longrightarrow\; \neg\,\forall a\; \big[\, C \vdash \mathrm{reflOf}(a) \,\big]
\veq{no-core-cert}\lean
$$

**Read the first one carefully, because it kills the most attractive reading of the whole
architecture.** A core certificate is *never a shortcut*. Whatever the Kernel can certify about the
Theory's soundness, the Theory had already proved by itself. The Kernel cannot adjudicate a sentence
the Theory could not settle; it cannot act as a soundness oracle; it cannot break a tie. Putting the
certifier *underneath* does not evade Goedel II. It relocates it.

The second is the architecture's **binding constraint**: global certification across the bridge
collapses into upper-layer self-certification, and Loeb kills it. And the damage does not stay
upstairs: `certification_forces_inconsistency` says the certification simply cannot hold. Nor can
two layers vouch for each other (`no_mutual_certification`), which is why the literature's answer to
"who trusts whom" is an **ordinal hierarchy** rather than a pair (§4.5).

## 4.4 The escape, and exactly what it costs

The fatal argument has three conjuncts: certificate, transfer, expressibility. Give up any one and
it does not run. Which one is available?

**Not the certificate.** That is what the design wants.

**Not transfer, in general.** Transfer holds *because* the core is weak. Making the core
non-interpretable in the Theory means making it stronger than the Theory in some respect, at which
point it is not a decidable core any more.

**Expressibility is the one that is actually available, and it is available for free**, because the
Report Calculus of §1.3 has no provability predicate and no quantifier over sentences. It literally
cannot form `reflOf(a)`.

That is not a rhetorical escape; it is machine-checked in a concrete two-element model. A consistent
core can hold a universal certificate-shaped theorem with a consistent upper layer and nothing goes
wrong (`escape_needs_no_bridge`), and no bridge with a constant `reflOf` can exist, because
`expresses` would force one translated sentence to equal `□a → a` for every `a` at once
(`no_bridge_for_constant_certificate`).

$$
\text{cheap universal certificate} \;\Longleftrightarrow\; \text{the core cannot say what it is about}
\veq{bridge-price}\lean
$$

> **The design rule, and it is the essay's main recommendation on the reflection problem:**
> the Kernel's *inability to express the Theory's provability predicate* is not a limitation to be
> engineered around. **It is the safety property.** Any feature that gives the Kernel a
> sentence-indexed provability predicate converts a harmless supervisor into an inconsistent one.

This has a concrete consequence for implementation. A Kernel that logs `"report for sentence
#41823"` is fine; a Kernel that can quantify over `#n` and reason about `Prov(#n)` is not. The line
is not "does the report format contain a Goedel number" but "can the Kernel *quantify* over the
index". That distinction should be an explicit, tested invariant of any implementation.

## 4.5 The ordinal ladder, and why it is not a way out either

The classical response to "a theory cannot prove its own consistency" is to iterate. Turing's 1939
ordinal logics and Feferman's 1962 transfinite recursive progressions build
`T_0 ⊂ T_1 ⊂ ...` with `T_{α+1} = T_α + Con(T_α)` (or `+ Rfn(T_α)`), indexed along ordinal notations.
The results are genuinely strong: along a suitable path the progression is complete for `Pi-0-1`
sentences.

And then Feferman and Spector (1962) killed it as an *architecture*: the completeness is
**path-dependent**. It depends on the choice of ordinal notations, and there are paths through the
notations along which the progression proves every true `Pi-0-1` sentence and other paths where it
does not, with the "correct" path not being recursively identifiable. The completeness is achieved
by smuggling the answer into the choice of notation.

**Design reading, and it is a hard no.** The tower is real, the trust ordering it induces is
well-founded, and a *finite* tower is a perfectly sound design: `T_2` may prove `Con(T_1)` and
`T_1` may prove `Con(T_0)`, with nobody trusting themselves. What the tower cannot do is *reach
completeness*, and a system that plans to escalate its way out of undecidedness by climbing is
planning on Feferman-Spector's bad path without knowing which one it is on.

## 4.6 What a working system must therefore give up

Stated as a list because it is the section's whole deliverable.

1. **Give up the soundness oracle.** The Kernel cannot license what the Theory has not proved.
   Machine-checked. This is the largest concession and it should be made loudly, at the top of any
   design document, because it is the thing people re-invent.
2. **Give up exactness at the interface.** Reports are lower bounds. Machine-checked.
3. **Give up truth-functional connectives on reports.** Machine-checked.
4. **Give up self-trust anywhere in the tower.** No layer proves its own reflection principle. No
   two layers prove each other's.
5. **Give up expressibility in the Kernel, deliberately, and treat it as a security property**, not
   as technical debt to be paid off later.
6. **Give up completeness as a goal.** Not as an admission of defeat: as a specification. The system
   is *permitted* to return `open` forever, and any component whose correctness argument assumes
   eventual settlement is unsound.

What is *kept* is worth stating alongside, because the list reads like a demolition and is not one.
The system still gets a decidable supervisor whose decisions are cheap and total, a soundness norm
the supervisor enforces structurally, a scheduler that can distinguish "closed" from "unexplored",
and a design-time audit language that is exactly correct about the Theory's provability by Solovay's
theorem. That is a real architecture. It is just not one in which the core knows more than the layer
above it.

---

# 5. Prior art

The owner's standing instruction is to prefer existing tested tooling over fresh improvisation, so
this is the section whose findings matter most. It was written from a sweep of primary sources, not
from memory. Claims marked **[V]** were checked against a fetched primary source; **[S]** is a
reliable secondary; **[U]** could not be confirmed and is flagged rather than dropped.

**The headline of this section is a negative one, and it is the valuable outcome:**

> **The architecture is not new. It is proof-carrying code, and it is thirty years old.** The
> owner's sentence describes, correctly and independently, the standard design of *certifying
> algorithms*: an untrusted, powerful producer emits an answer plus a witness, and a small,
> trusted, decidable checker validates the witness. The recommendation is to adopt that vocabulary
> and that literature rather than build a fresh one.

## 5.1 Proof-carrying code: the same split, named in 1996

Necula and Lee, *Safe Kernel Extensions Without Run-Time Checking*, OSDI 1996 **[V]**. Proofs are
encoded in the Edinburgh Logical Framework, and "proof validation amounts to typechecking";
"typechecking is decidable and is described by a few simple rules". The checker is about five pages
of C, and validating a packet-filter safety proof took 1.4 ms.

The certifying-compiler split is stated in *The Design and Implementation of a Certifying Compiler*,
PLDI 1998 **[V]**, in a sentence the owner should read as a description of his own idea:

> "the code that is relied upon ... includes only the VCGen and the proof checker. **Neither the
> compiler nor the prover need to be correct.**"

That is Layer 0 and Layer 1 exactly: an incomplete, heuristic, arbitrarily clever producer, and a
decidable consumer that trusts nothing it is told.

**And the literature already found the failure mode this architecture has.** Appel's *Foundational
Proof-Carrying Code*, LICS 2001 **[V]**, observes that in the Cedilla implementation the
verification-condition generator was "23,000 lines of C", and "a bug in the VCgen will lead to the
wrong formula being proved and checked". Appel, Michael, Stump and Virga (JAR 31, 2003) got the
trusted base to "less than 2,700 lines of code" **[V]**.

**The one documented soundness break is the most instructive item in the whole sweep.** League,
Shao and Trifonov, CC 2003 **[V]**, found that the SpecialJ certifying compiler's type system "does
not properly enforce the necessary invariant on self-application", with a concrete exploit: "**the
consumer's proof checker will accept the malicious code given above**". The checker was sound. The
*axioms it was handed* were not. Translated into this architecture: the risk does not sit in the
Kernel's decision procedure, it sits in the interface specification, which is where §2.6 also
located it.

One caution, since the owner's instruction is to check a publication's real scope: the POPL 1997
paper does **not** claim linear-time checking, and notes that definitional equality is "responsible
for the exponential worst case complexity of LF type checking" **[V]**. And no decidability theorem
for typed assembly language appears in Morrisett et al., POPL 1998 or TOPLAS 1999 **[V, negative]**.

## 5.2 LCF kernels, and the instance sitting in this very repo

The LCF discipline (Gordon, Milner, Wadsworth 1979) makes `thm` an abstract type whose values can
only be built by primitive rules. Isabelle's own implementation manual states it verbatim **[V]**.
HOL Light's kernel is "about 400 lines of mostly functional OCaml" (Harrison, IJCAR 2006) **[V]**.

**Lean is the live example, and it is in `verify/` in this repository.** Measured on current
`leanprover/lean4` master: `src/kernel/` is 36 files, **8,028 lines** **[V, direct measurement]**.
Its axioms are `propext`, `Quot.sound`, `Classical.choice` and `sorryAx`; `native_decide` puts the
entire Lean compiler into the trusted base, which Lean's own reference says explicitly **[V]**.

Two findings here bear directly on the architecture and one of them is a near-exact match for §2.6.

- **Carneiro, *The Type Theory of Lean* (2019) [V]** proves consistency relative to
  ZFC plus `n` inaccessibles for `n < ω`, and shows that is optimal. It also proves that **type
  checking is undecidable**, and that the implementation is a "**decidable non-transitive
  underapproximation** of the typing judgment". (Institution and degree could not be confirmed from
  the PDF **[U]**; cite it as author, title, year.)
- **That underapproximation has bitten in practice.** `leanprover/lean4` issue **#14806** **[V]**:
  the `is_def_eq` union-find cache made results order-dependent "because the implemented `is_def_eq`
  is sound but incomplete, and therefore not transitive", and a crafted input derived `False`.

> **The convergence is worth stating plainly.** Lean's kernel is a decidable *underapproximation*
> of an undecidable relation. That is the same shape as this essay's §2.6 rule that reports must be
> **lower bounds** on what is known. The one real production instance of this architecture that the
> owner already runs solved the problem the same way -- and issue #14806 shows what the failure
> looks like when the underapproximation is not carefully maintained.

External checking is thinner than one might hope: `trepplein` is dormant and targets the Lean 3
export format; `lean4checker` is archived and its own README says "**this is not an external
verifier, as it uses the Lean kernel itself**"; `lean4lean` is active but its author writes that it
is "derived directly from the C++ kernel implementation, and as such likely shares some
implementation bugs with it" **[V]**.

## 5.3 Milawa: the well-founded tower, actually built

Jared Davis, *A Self-Verifying Theorem Prover*, PhD dissertation, UT Austin, 2009, supervised by
J Strother Moore; Davis and Myreen, JAR 55(2):117-183, 2015 **[V]**.

The mechanism is exactly §4.5's finite tower, implemented. There are **eleven levels**, numbered
1 to 11 (the letters A, B, C in the paper name the three properties proved, not levels). Level 1 is
`logic.proofp`, a checker whose steps are the primitive rules. A new checker replaces the installed
one only through the kernel's `switch` command, which requires the user to have proved, **using the
currently installed checker**, that every appeal the new checker accepts has a corresponding Level 1
proof with the same conclusion.

That is a well-founded trust order with no self-trust anywhere, and it is the constructive answer to
§4.3. The bottom is verified separately in HOL4: a 1,700-line Jitawa Lisp kernel over an 8,200-line
verified x86 runtime, with a total-correctness machine-code Hoare triple at the top **[V]**. What
remains trusted is enumerated in the paper's §14: HOL4 itself, its ML runtime, C compiler, OS and
hardware; the HOL4 x86 model; and a 200-line unverified C wrapper. Roughly four man-years.

## 5.4 Reflection in ACL2 and Coq, and the theorem that states the limit

**ACL2** has run verified metafunctions since Boyer and Moore 1981 **[V]**. Two details apply
directly. The evaluator is necessarily *partial*: "one cannot define a single closed-form function
axiomatized to be an evaluator for an arbitrary set of functions. Thus, in ACL2, one must define
**separate evaluators for different (fixed) sets of functions**" **[V]**. And ACL2's *trusted*
clause processors require a `defttag` and are tracked and reported: an untrusted oracle, admitted
deliberately and *labelled* **[V]**.

**Coq's small-scale reflection** (Gonthier and Mahboubi, JFR 3(2), 2010) and the four-colour proof
(Gonthier, *Notices of the AMS* 55(11), 2008) show the payoff and the price: conversion is a
subsumption rule, so "arbitrary long computations can thus be elided from a proof", while
`native_compute`'s own source paper says the compiler's "entire code enters the trusted base"
**[V]**.

**The theorem the owner should read, if he reads one thing from this section:** John Harrison,
*Metatheory and Reflection in Theorem Proving: A Survey and Critique*, SRI Technical Report CRC-053,
1995 **[V]**. It states the limit and the escape in the same document.

- Loeb, quoted there: an instance of the local reflection schema is provable "precisely when the
  corresponding φ is itself already provable". This is §4.3's `certificate_is_no_shortcut`, in the
  literature, in 1995.
- Kreisel and Levy, quoted there: "**If a system T can prove the reflection principle for S, then T
  is properly stronger than S.**" That is the cross-layer constraint of §4.3 stated as a
  strength ordering, and it says the certifier must be *above*, never below.
- On adding a reflection rule: "**It is not possible to close up this procedure with a single
  syntactic notion of provability `Pr`** which satisfies the three derivability conditions."
- **And the escape, which is this architecture's own:** "although the full reflection schema is
  unprovable, it may happen that by suitably restricting the kinds of provability allowed in
  `Prov`, the analogous schema becomes provable. In particular, this happens in Peano Arithmetic and
  Zermelo-Fraenkel set theory, **if provability is only allowed from a fixed finite set of the
  axioms**."

**Partial reflection schemas are the published name for what §4.4 recommends.** The recommendation
here is therefore not "build this" but "use this name", and read Harrison before designing anything.

## 5.5 MIRI's tiling agents: the same problem, and an honest record of what failed

Yudkowsky and Herreshoff, *Tiling Agents for Self-Modifying AI, and the Loebian Obstacle*, 2013
**[V]**, is still marked "(Early Draft)" and was never finished. It states the obstacle as **Loeb's
theorem, not Goedel II** (Goedel II is the `φ = ⊥` instance), and draws the consequence this essay
draws in §4.3: "an agent can only trust the reasoning of successors that use weaker mathematical
systems than its own ... an agent architecture can only tile a finite chain of successors".

The paper's own verdict on itself, verbatim: it obtains "the first and second desiderata, **but not
yet the third and fourth**, nor yet by fundamental rather than technical means" **[V]**.

What was tried and what became of it:

- **Infinitely descending soundness schemas** were abandoned *by the paper itself*: the resulting
  `T-0` has only nonstandard models and believes ZF inconsistent **[V]**.
- **Model polymorphism and parametric polymorphism are one technique under two names** (Fallenstein
  2012, published 2013, renamed in 2015), not two proposals **[V]**. Its authors' own assessment: it
  "only works in systems where time can be divided into discrete steps" and is "by no means a fully
  satisfactory solution".
- **Fallenstein and Kumar, ITP 2015 [V]**, actually built a reflection principle in HOL4 and paid
  for it exactly as Goedel requires: with a strongly inaccessible cardinal, and "**the large-cardinal
  assumption used in outer HOL to justify reflection cannot be used again in inner HOL to justify
  further reflection**". One rung per cardinal.
- **The probabilistic route did not survive either, and the reason is not the one usually reported.**
  Christiano, Yudkowsky, Herreshoff and Barasz (2013) **[V]** has **no erratum and no retraction**;
  its reflection principle is an *implication* (the biconditional is shown contradictory) and the
  paper states its own uncomputability. The applied defect is Fallenstein's **procrastination
  paradox** (2014): the system believes with probability 1 that it will act eventually, and never
  does. Too much self-trust, not too little **[V]**.
- The failure pair, from Demski and Garrabrant, arXiv:1902.09469 **[V]**: the Loebian obstacle on
  one side, the procrastination paradox on the other, with results so far applying "only to limited
  sorts of decision procedures".

**Design reading.** This is the only body of work that attacked the owner's exact problem *as an
architecture for an AI system*, and after a decade it has an honest partial result and two named
failure modes. That is a reason to adopt the failure modes as design constraints, not a reason to
retry the programme.

## 5.6 Logical induction, with its record corrected

Garrabrant, Benson-Tilsen, Critch, Soares and Taylor, *Logical Induction*, arXiv:1609.03543 (v5,
2020) **[V]**. The criterion: a market satisfies it, relative to a deductive process, if no
**polynomial-time** trader can exploit it, where exploitation means unbounded returns off a finite
investment. The main theorem gives a computable belief sequence satisfying it, via Brouwer's fixed
point theorem.

Three corrections, all of which would have been citation errors and all of which cut against using
it here.

1. **The paper never mentions Loeb or tiling.** Zero occurrences of either in v5 **[V, negative]**.
   The claim that logical induction dissolves the Loebian obstacle is not in the paper.
2. **The computational cost is not quantified anywhere.** The paper says its own runtime is
   "underspecified" **[V, negative]**. The precise thing to cite instead is **Proposition 5.5.1**:
   any function bounding convergence rates **must be uncomputable**, for any logical inductor
   whatsoever **[V]**.
3. The paper's own summary is "a theoretically interesting but ultimately impractical account", with
   "abysmal runtime and uncomputable convergence bounds" **[V]**.

Its relevance to this architecture is nonetheless real, and it is a warning: a logical inductor's
finite-time belief state is **incoherent** (it may price `φ` and `¬φ` at 0.3 each), so it corresponds
to no measure over completions. That is why §2.1's model-ensemble reading cannot be rescued by
appeal to it.

## 5.7 The deployed instances of exactly this shape

- **Certifying algorithms** are the umbrella: McConnell, Mehlhorn, Naeher and Schweitzer, *Computer
  Science Review* 5(2), 2011 **[V]**; Alkassar et al. (2011) build the exact pipeline, with the
  checker verified in VCC and the witness predicate exported to Isabelle/HOL **[V]**. Translation
  validation (TACAS 1998) is the same idea per-run **[V]**.
- **SMTCoq** (Ekici et al., CAV 2017) **[V]** is the closest deployed relative of the recommended
  design, and its trust story is the one to copy: "the soundness of the checker yields, by
  computational reflection, a Coq proof of the original goal ... **the trusted base consists only of
  Coq itself**", and the untrusted certificate preprocessor can only cause *failure*, never
  unsoundness. Compare `constant_open_is_sound` in §2.6: a report that under-claims is always safe.
- **Sledgehammer** and Boehme-Weber's Z3 reconstruction (ITP 2010) are the same architecture at
  scale: untrusted oracle, kernel-checked replay **[S]**.
- **What the bottom of a real tower costs.** seL4's TOCS 2014 assumptions section **[V]** still
  assumes TLB and cache-flushing correctness, hand-written assembly, and hardware, and its binary
  verification "replaced our previous assumption, that the compiler and linker execute correctly ...
  with the new, **second-order assumption that the binary verification tool does not exhibit a
  soundness bug**". Assumptions are relocated, never eliminated. CakeML and CompCert are the
  corresponding compiler results **[V/S]**.
- **Has GL ever been a decision procedure in a deployed system? No: prototypes only.** Maggesi and
  Perini Brogi, JAR 67(3), 2023, built a HOL Light tactic implementing proof search in the labelled
  sequent calculus G3KGL, which succeeds with a theorem or returns a falsifying model, and describe
  it as a prototype **[V]**. Barasz, Christiano, Fallenstein, Herreshoff, LaVictoire and Yudkowsky,
  arXiv:1401.5577, checked their modal-agent results with a program, but claim no general
  decidability **[V]**. GL's PSPACE-completeness is standard, though the attribution could not be
  pinned to a specific author **[U]**.
- **The most directly useful unexplored lead:** Critch, "A parametric, resource-bounded
  generalization of Loeb's theorem", JSL 84(4), 2019 **[S, not fetched]**, an effective Loeb's
  theorem for agents searching proofs up to a bounded length. That is the version a real scheduler
  would need, and this essay does not use it.

## 5.8 What would genuinely be new

Almost nothing structural. Stated honestly:

| Component | Status |
|---|---|
| Weak decidable checker, powerful untrusted producer | **Solved.** Proof-carrying code, 1996. Adopt the name. |
| Small trusted kernel | **Solved.** LCF 1979 onward; Lean's is in this repo. |
| Well-founded tower of checkers with no self-trust | **Solved and built.** Milawa, 11 levels. |
| The reflection limit and its escape | **Stated, 1995.** Harrison CRC-053, partial reflection schemas. |
| Untrusted oracle behind a reflective checker | **Deployed.** SMTCoq, Sledgehammer, ACL2 clause processors. |
| Applying all this to an *AI reasoner's own* self-modification | **Attempted, partial.** MIRI, 2013-2015, with two named failure modes. |
| The Bloch picture itself (true/false poles, undecidable equator, double cone) | **Published, 2018.** Sperling and Walmsley, Phys. Rev. A **97**, 062327, §IV.3, located by [`citation-audit.md`](citation-audit.md). No provability predicate in it. |
| **The `(z, r)` report format as the interface** | **Not found.** No prior art located for a two-number settledness report between a decidable checker and an incomplete reasoner. |
| **"Reports are lower bounds" as a specification requirement** | **Present in substance, not as a stated rule.** It is what Lean's kernel does (a decidable underapproximation) and what SMTCoq's preprocessor guarantee amounts to, but the sweep found no source that states it as a *design rule for a report interface*. |

So the honest recommendation is: **the architecture is prior art and should be built on the prior
art's vocabulary; the interface format is the only part with any claim to novelty, and its novelty
is modest.** A finding that the idea is essentially solved is a good outcome, not a disappointing
one: it means the owner's instinct located a real design pattern rather than a dead end, and it
means the remaining work is small and known.

---

# 6. Does Bloch geometry survive?

**No. The architecture does not need the ball, and the essay owes the owner that answer plainly
rather than politely.**

The reasons are cumulative and none of them is this essay's own.

- **The report is two numbers, and the admissible pairs form a triangle**, `|z| ≤ r ≤ 1`, with
  vertices `(1,1)`, `(−1,1)`, `(0,0)`. That is a 2-simplex.
- **The ball's `(z, r)` shadow is exactly that triangle**, checked in both directions by the
  adjudicating sibling. Every admissible pair is realised by some Bloch triple and no Bloch triple
  reports outside the wedge. So the ball carries the same information as the triangle and nothing
  more, except the azimuth.
- **The azimuth has failed four separate auditions.**
  [`logic-bloch-gates.md`](logic-bloch-gates.md) machine-checks that no rotation-covariant order on
  the equator exists; [`logic-bloch-phase.md`](logic-bloch-phase.md) tests six candidate meanings
  and finds three routes landing on `{±1}` rather than on a circle; the model-ensemble reading finds
  the phase undefined on its entire reachable set; the epistemic reading finds the report map's
  fibre is an interval where the ball's is a circle.
- **The entropy does not rescue it.** `S = h((1+r)/2)` is a monotone reparametrisation of
  `1 − p_open` and is not the entropy of anything in the model: the Shannon entropy of the status
  distribution at the origin, where `p_open = 1`, is **zero**, while `h(1/2) = log 2`.
- **The constraint `|z| ≤ r` is derived on the simplex and merely satisfied on the ball** (§2.1).
  The strongest argument for the ball turns out to be an argument against it.
- **The conflation of §2.5 is forced by the ball, not incidental to it.**
  [`logic-simplex.md`](logic-simplex.md) locates the exact structural cause: on the ball `r` is a
  *norm*, hence convex, so mixing two settled states can produce an unsettled one; on the simplex
  `r = 1 − p_open` is *affine*, so it cannot. Any mixing-respecting map putting *open* at the centre
  and *proved*/*refuted* at the poles is therefore non-injective, because in the ball the centre
  already **is** the even mixture of the poles.

**One piece of prior art that must be reported here, because it is the closest thing in existence
to the owner's picture.** [`citation-audit.md`](citation-audit.md) located Sperling and Walmsley,
*Quasiprobability representation of quantum coherence*, Phys. Rev. A **97**, 062327 (2018),
arXiv:1803.04747, whose §IV.3 is titled *"True, false, and undecidable"* and puts true and false at
the Bloch poles, an "undecidable" continuum at the equator, and a **double cone** as the convex hull
of that classical set. So **the geometry is published prior art from 2018**. What is not there is any
logic: no provability predicate, no arithmetic, no modal operator. That sharpens rather than softens
this section's verdict: the picture exists, it was not invented here, and it still carries no
provability reading.

So: no ball, no qubit, no von Neumann entropy, no SU(2). Four essays in this batch now argue the
object is a simplex and none argues it is a ball.

## 6.1 What of the owner's idea survives, and it is most of it

This matters more than the demolition, and the demolition is not the interesting part.

1. **The two-layer instinct is right and it is the architecture.** A weak, decidable floor and an
   expressive, incomplete ceiling, with the floor consuming the ceiling's summaries, is exactly what
   the literature converged on independently under several names (§5). He got the shape right in one
   sentence in a project-management conversation.
2. **The report-with-confidence interface is right, and its constraint is right.** The pair (which
   way it leans, how settled it is) with "confidence never exceeds settledness" is the correct
   interface, and the constraint he reached for geometrically is derivable from the simplex. The
   *norm* survives its container.
3. **"Incompleteness applies in the second layer" is the correct diagnosis, and treating it as a
   boundary condition rather than a defect is the correct stance.** Everything in §4 is a
   consequence of taking that seriously instead of trying to engineer around it. The essays that
   tried to engineer around it are the ones §5 records as having failed.
4. **The "core layer should only be complete" requirement survives with its justification replaced.**
   Completeness *is* the right property to demand of the core. The parenthetical picked the wrong
   mechanism for getting it (dropping AC), and the right mechanism is expressive weakness. That is
   an amendment to one clause, not a rejection of the requirement.
5. **His own "(might need a better name)" is now load-bearing.** He wrote it himself. The evidence
   is that the container the name commits to is the part that does not survive. That is a note, not
   authorisation to rename anything, and this essay renames nothing.

---

# 7. `id:4bb2`: a candidate thesis statement

`TODO.md:127` records the "Bloch Truth" essay as **BLOCKED** because the 2026-07-17 `.mw` meeting
found no thesis statement exists in 412 session files. Three sibling essays now offer candidate
theses and they are not compatible with each other. This architecture supplies a fourth, and it is
offered as a candidate unblocker only.

> **Candidate thesis.** *Incompleteness is an interface problem, not a foundations problem: a
> reasoning system survives it by splitting into a decidable supervisor that cannot express what it
> supervises and an incomplete reasoner that reports its own settledness, with the supervisor's
> inexpressiveness as the safety property that keeps the split consistent.*

Why this one rather than the siblings'. It is the only candidate that states what the *architecture*
claims rather than what the *object* is, and `id:4bb2` is blocked for want of a thesis, which is a
claim, not an object. It also has the property an essay needs: it is falsifiable, and §4.3 and §2.6
are the two places it would break. If either the transfer condition or the lower-bound reading of
reports turns out to be avoidable, the thesis is wrong in an identifiable way.

**Ruling needed, and nothing has been written to any ledger.** Whether to unblock `id:4bb2` on this
thesis, on one of the siblings', on a synthesis, or not at all, is entirely the owner's call. The
`REVIEW_ME.md` `id:251e` item about the parenthetical is already filed and untouched by this essay.

---

# 8. Lean attestation

[`lean/LogicLayered.lean`](lean/LogicLayered.lean), namespace `Toesnail.LogicLayered`. Checked from
`verify/` with

```
../docs/dreamed/capped.sh -m 4G -c 100 -- \
    lake env lean --threads=1 ../docs/dreamed/lean/LogicLayered.lean
```

**Exit code 0, zero `sorry`.**

| Handle | Theorem | Content |
|---|---|---|
| `report-triangle` | `pr/rf/ind/opn_admissible`, `ind_ne_opn`, `interior_point_admissible`, `overconfident_not_admissible` | the interface type, its four corners, and a non-vacuous admissibility check in both directions |
| `report-convex` | `mix_admissible`, `neg_admissible` | the Kernel's pooling and negation preserve admissibility |
| `no-conj` | `no_truthfunctional_conj`, `no_binary_op`, `neg_ind` | no binary function on reports computes conjunction |
| `cert-no-shortcut` | `certificate_is_no_shortcut` | **a core certificate licenses nothing the upper layer had not already proved** |
| `no-core-cert` | `no_core_certified_soundness`, `certification_forces_inconsistency`, `no_mutual_certification` | the architecture's binding constraint, and no mutual vouching |
| `bridge-price` | `escape_needs_no_bridge`, `no_bridge_for_constant_certificate` | the escape exists exactly when the core cannot express what it certifies |
| `exact-oracle` | `exact_reports_decide`, `constant_open_is_sound` | **exact reports are a provability oracle**; soundness alone buys nothing |
| (no handle) | `core_never_asserts_falsum`, `core_adds_nothing` | interface soundness, and its own docstring says it is cheap |

**What the file does not prove, stated because a badge is easy to over-read.** Nothing about PA, ZF
or ZFC: `Layer` is abstract, and the hard half of every real theorem here is that PA's `Prov`
satisfies the derivability conditions, which needs arithmetisation of syntax and is formalised
nowhere in this repo. Nothing about Solovay, Segerberg, or GL's PSPACE-completeness. Nothing about
quantum mechanics: `Report` is two rationals. Nothing about Presburger, real closed fields, or
Tarski's geometry: their decidability is quoted from the literature, and `Report`'s admissibility
being `Decidable` is decidability of one quantifier-free predicate over ℚ, which is a far smaller
statement. And `no_truthfunctional_conj` is arithmetically trivial: all its content is in its
hypotheses, which come from the logic and not from Lean.

---

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. **None of these is decided, and none has been
written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.** Several bear directly on the owner's own
words, and those are marked.

1. **HEADLINE, and it constrains his architecture rather than confirming it. A decidable core cannot
   act as a soundness oracle for the layer above it.** Located: §4.3,
   `certificate_is_no_shortcut` and `no_core_certified_soundness`. If the core can prove "if the
   Theory proves `a` then `a`", the Theory has already proved `a`; and global certification forces
   the Theory inconsistent. The condition that makes this bite, *transfer*, is created deliberately
   by choosing a weak core, so it is not avoidable by better engineering. **Ruling:** accept that
   the core is a supervisor and never an adjudicator, or identify which of transfer, expressibility
   or the certificate he wants to give up instead.

2. **ON HIS OWN WORDS, and already filed. The parenthetical "core layer should only be complete,
   e.g. ZF without C" does not hold.** Located: the origin quote at
   `2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`; the correction is `REVIEW_ME.md`
   `id:251e` and `logic-bloch-poles.md` §7.1. ZF interprets Robinson's Q, so Goedel I applies to it
   exactly as to ZFC, and AC's independence from ZF is itself an instance of ZF's incompleteness.
   **This essay does not re-file it and has not touched `REVIEW_ME.md`.** **Ruling:** whether to
   accept the redrawn boundary (§1.1), *interprets arithmetic* versus *does not*, as the replacement
   criterion. The requirement he stated survives; only its mechanism changes.

3. **The load-bearing check, and it comes back with a specification requirement. Exact reports are a
   provability oracle.** Located: §2.6, `exact_reports_decide`. If the interface says `proved`
   precisely when the sentence is provable, comparing two rationals decides Layer 1's theoremhood,
   which is undecidable. **Ruling:** accept that reports are lower bounds on what is known and that
   under-confidence is legal by specification, or reject the interface. There is no third option
   that keeps exactness.

4. **The interface must not compute.** Located: §2.4, `no_truthfunctional_conj`. `φ` and `¬φ` both
   independent give identical reports; `φ ∧ φ` is independent and `φ ∧ ¬φ` is refutable. So no
   binary function on reports computes conjunction. **Honesty note carried into the ruling:** the
   Lean content is `ind ≠ rf` and the substance is in the two hypotheses, which come from the logic.
   **Ruling:** whether "the core constrains, never computes" is adopted as a hard rule on any
   implementation.

5. **RECOMMENDED AMENDMENT to his two-layer picture: there is a third object, and it sits beside
   rather than between.** Located: §3.3. GL is the design-time audit language for the *relationship*
   between the layers. It is decidable in PSPACE and, by Solovay 1976, exactly correct about PA's
   provability. **Ruling:** accept the third object, or keep the two-layer framing and say where the
   audit lives instead.

6. **The error that would look like success. GL's decidability is not decidability of provability.**
   Located: §3.2. GL decides *schematic* validity, quantified over all arithmetical realisations;
   `PA ⊢ φ` for a given `φ` is Sigma-1-complete and undecidable. A Kernel running GL and expecting
   answers about particular Layer 1 sentences would return confident answers to a different
   question. **Ruling:** whether to record this as a durable design caution, since it is the failure
   mode most likely to be re-invented by a future implementer, including a future AI one.

7. **The escape from item 1, and it inverts a usual instinct: the Kernel's inexpressiveness is the
   safety property.** Located: §4.4, `no_bridge_for_constant_certificate`. The fatal argument needs
   the core to be able to *name* the upper layer's reflection instances; the Report Calculus cannot,
   and that is why it stays consistent. **Ruling:** whether to adopt "the Kernel may not quantify
   over the sentence index" as a tested invariant of any implementation, rather than as a stylistic
   preference.

8. **NEGATIVE RESULT the essay would most like tested. The ball does not survive.** Located: §6.
   The report is a triangle; the ball's `(z, r)` shadow is that same triangle; the azimuth has failed
   four independent auditions across this cluster; and the entropy reading is a monotone
   reparametrisation of `1 − p_open` whose fine-grained Shannon entropy at the origin is zero where
   `h(1/2) = log 2`. Added after the fact and cutting the same way: the Bloch picture itself is
   **published prior art**, Sperling and Walmsley, Phys. Rev. A **97**, 062327 (2018) §IV.3, with
   the poles, the undecidable equatorial continuum and the double cone, and with no logic attached.
   **Ruling:** if accepted, "Bloch Truth" contains no Bloch sphere and his own
   "(might need a better name)" becomes load-bearing. If rejected, he should name which of
   interference, entanglement, or non-unique ensemble decomposition he wants as *content* rather
   than as tooling. This essay renames nothing.

9. **What survives, offered so the demolition is not read as a verdict on the idea.** Located: §6.1.
   The two-layer instinct is the architecture; the report-with-confidence interface is the right
   interface; the soundness norm is right and is *derivable* on the simplex rather than merely
   satisfied on the ball; and treating incompleteness as a boundary condition rather than a defect
   is the correct stance and is what makes §4 tractable. **Ruling:** confirm that this is a fair
   reading of what he meant, since only he knows.

10. **The interface's documented loss, and a cheap mitigation.** Located: §2.5. The two-number
    report cannot distinguish proved independence from a fair coin; independence is the midpoint of
    the triangle's top edge, so an even split between proved and refuted reaches it. Recommendation:
    ship two numbers as the wire format and expose the three-number status vector on request.
    **Ruling:** whether the distinction is always needed. If it is, the object is a 3-simplex, the
    report is three numbers, and the geometry disappears entirely.

11. **The ordinal ladder is sound as a finite tower and unsound as a plan.** Located: §4.5. Turing
    1939 and Feferman 1962 give progressions complete for `Pi-0-1` sentences along a path; Feferman
    and Spector 1962 showed the completeness is path-dependent on the choice of ordinal notations,
    so it smuggles the answer into the notation. **Ruling:** whether to record that no escalation
    policy may cite completeness as its justification, only strength.

12. **`id:4bb2` candidate unblocker.** Located: §7. One sentence: *incompleteness is an interface
    problem, not a foundations problem, and a system survives it by splitting into a decidable
    supervisor that cannot express what it supervises and an incomplete reasoner that reports its own
    settledness.* Three sibling essays offer incompatible alternatives. **Ruling:** unblock on this
    thesis, on a sibling's, on a synthesis, or leave blocked. **Nothing has been written to any
    ledger.**

13. **PRIOR ART, and it is the most consequential item here. The architecture already exists and is
    called proof-carrying code.** Located: §5.1, §5.8. Necula and Lee's PLDI 1998 sentence
    "**neither the compiler nor the prover need to be correct**" is the owner's split, stated in
    1998, with a decidable checker and a 1.4 ms validation time. The recommendation is to adopt that
    vocabulary and the certifying-algorithms literature wholesale. **Ruling:** whether to re-frame
    "Bloch Truth" as a certifying-architecture project rather than a foundations project. Only the
    `(z, r)` report format has any claim to novelty, and the claim is modest.

14. **The repo already runs an instance of this architecture, and it solved §2.6 the same way.**
    Located: §5.2. Carneiro (2019) proves Lean's type checking is undecidable and that the
    implemented checker is a "decidable non-transitive underapproximation" of it; `leanprover/lean4`
    issue #14806 is that non-transitivity deriving `False` in practice. That is §2.6's "reports are
    lower bounds" rule, discovered independently by the system in `verify/`. **Ruling:** whether to
    treat Lean's kernel as the reference implementation of the Kernel's contract, and to study
    #14806 as the canonical failure mode before writing any specification.

15. **The single most useful thing to read, and it predates everything in this cluster.** Located:
    §5.4. Harrison's SRI CRC-053 (1995) states Loeb's limit, quotes Kreisel and Levy's "if T proves
    the reflection principle for S then T is properly stronger than S", proves the tower cannot be
    closed by a single provability predicate, **and** gives the escape this essay recommends:
    restricting `Prov` to a fixed finite set of axioms makes the reflection schema provable. That
    escape has a published name, *partial reflection schemas*. **Ruling:** whether to read it before
    any further development, and whether to adopt its terminology in place of this essay's.

16. **The AI-specific attempt has a decade of record and two named failure modes.** Located: §5.5.
    The MIRI tiling-agents line reached a partial result and stopped, with the Loebian obstacle on
    one side and the procrastination paradox on the other. Three framings commonly attached to it
    are wrong and are corrected here: model polymorphism and parametric polymorphism are one
    technique under two names; the probabilistic-reflection paper was never retracted and its real
    defect is the procrastination paradox; and *Logical Induction* never mentions Loeb or tiling at
    all. **Ruling:** whether to adopt the two failure modes as explicit design constraints, which is
    this essay's recommendation, rather than retrying the programme.

17. **The weakest joint, named so it is not discovered later.** Located: §1.4, item 1. The whole
    design rests on Layer 1 having an *observable proof-search state* to report. That is an
    engineering claim about implementations, not a theorem, and it is the one load-bearing premise
    in this essay with no machine-checked or literature support. **Ruling:** whether a prototype
    should be built to test precisely that, before anything else here is developed further.

---

# Sources consulted

Classical results are quoted from standard references and are not reproved here.

- Goedel 1931 (incompleteness), Goedel 1938 (`L`, `Con(ZF) → Con(ZFC)`), Cohen 1963 (forcing);
  Robinson's Q as the arithmetic-interpretation threshold for Goedel I.
- Presburger 1929 (completeness and decidability of `⟨ℕ, +⟩`); Fischer and Rabin 1974 (doubly
  exponential lower bound); Oppen 1978 (triple-exponential upper bound).
- Tarski 1948 (real closed fields, quantifier elimination), Tarski 1959 (elementary geometry);
  Davenport and Heintz 1988 (doubly exponential lower bound for RCF).
- Buechi 1962 (S1S), Rabin 1969 (S2S), Meyer 1975 (non-elementary lower bound for S1S).
- Loeb 1955; the Hilbert-Bernays-Loeb derivability conditions; Segerberg 1971 (modal completeness of
  GL for finite transitive irreflexive trees); Solovay 1976 (arithmetical soundness and completeness,
  and `GLS`); Vardanyan (quantified provability logic of PA is `Pi-0-2`-complete); the Stanford
  Encyclopedia entry *Provability Logic* (Verbrugge) as the entry point.
- Turing 1939 (ordinal logics); Feferman 1962 (transfinite recursive progressions); Feferman and
  Spector 1962 (path-dependence); Beklemishev 2003 (proof-theoretic analysis by iterated reflection,
  local versus uniform reflection).
- Church 1936 and Turing 1936 for the undecidability of first-order provability.
- Cook 1971 for co-NP-completeness of propositional validity.

Prior art fetched from primary sources for §5, where the per-claim confidence markers live. The
load-bearing ones: **Harrison, SRI CRC-053, 1995** (the reflection limit and the partial-reflection
escape); Necula and Lee, OSDI 1996 and PLDI 1998, and Necula, POPL 1997 (proof-carrying code);
Appel, LICS 2001, and Appel, Michael, Stump and Virga, JAR 31, 2003 (the trusted base); League, Shao
and Trifonov, CC 2003 (the SpecialJ unsoundness); Carneiro, *The Type Theory of Lean*, 2019, with
`leanprover/lean4` issue #14806; Davis, UT Austin 2009, and Davis and Myreen, JAR 55(2), 2015
(Milawa); Kaufmann, Moore, Ray and Reeber, *Journal of Applied Logic* 7(1), 2009 (ACL2 clause
processors); Ekici et al., CAV 2017 (SMTCoq); Yudkowsky and Herreshoff 2013, Fallenstein and Soares,
MIRI TR 2015-2, Fallenstein and Kumar, ITP 2015, Christiano et al. 2013, Fallenstein 2014, and
Demski and Garrabrant, arXiv:1902.09469 (the MIRI line); Garrabrant et al., arXiv:1609.03543 v5
(logical induction); Klein et al., ACM TOCS 32(1), 2014 (seL4's assumptions); Maggesi and Perini
Brogi, JAR 67(3), 2023, and Barasz et al., arXiv:1401.5577 (GL implementations); Critch, JSL 84(4),
2019 (resource-bounded Loeb, not fetched).

Sibling dreamed essays relied on and, where noted, disagreed with:
[`logic-bloch-poles.md`](logic-bloch-poles.md) §7 (the layered-core framing, the "ZF without C"
correction, the report-format thesis), [`logic-beyond-su3.md`](logic-beyond-su3.md) §3 and §8 (GL,
the simplex, the truth-functionality objection), [`logic-epistemic-state.md`](logic-epistemic-state.md)
§9 (the status simplex and the report format), [`logic-models-ensemble.md`](logic-models-ensemble.md)
§2 (diagonality and the segment), [`logic-models-vs-epistemic.md`](logic-models-vs-epistemic.md)
(the adjudication this essay adopts), [`logic-bloch-gates.md`](logic-bloch-gates.md) and
[`logic-bloch-phase.md`](logic-bloch-phase.md) (the azimuth auditions), and, landing while this
essay was being written and incorporated in §2.4 and §6, [`logic-simplex.md`](logic-simplex.md) (the
sound-but-lossy conjunction table, and the affine-versus-norm diagnosis of the conflation) and
[`citation-audit.md`](citation-audit.md) (Sperling and Walmsley 2018 as published prior art for the
Bloch geometry). [`logic-z2-grading.md`](logic-z2-grading.md) landed too and does not bear on this
essay's argument.

---

# A future `.mw` sketch

```
# handle: report-triangle. The interface type and its four corners.
# |z| <= r <= 1 over the rationals; proved (1,1), refuted (-1,1),
# independent (0,1), open (0,0).

# handle: report-convex. Pooling and negation preserve admissibility.

# handle: no-conj. No binary function on reports computes conjunction.
# The content is in the two hypotheses, not in the arithmetic.

# handles: cert-no-shortcut, no-core-cert. The binding constraint:
# a weaker core's soundness certificate is the upper layer's own,
# and Loeb closes it.

# handle: bridge-price. The escape is inexpressiveness, machine-checked
# in a two-element model.

# handle: exact-oracle. Exactness at the interface is a provability
# oracle, hence unimplementable; reports are lower bounds.
```

# Follow-up leads

- Build the `QF_LRA` Kernel of §1.3 against an off-the-shelf SMT solver and measure whether the
  scheduler's decisions genuinely stay inside the fragment under real workloads. The design's claim
  is that they do; nothing here tests it.
- Test item 13's premise directly: instrument a real proof search and see whether its state
  projects onto the four statuses at all, or whether the honest report is something else entirely.
- Read the topological semantics of provability (Esakia, Simmons; the Beklemishev-Gabelaia survey)
  before any further geometric development, since it is the place where provability *does* have a
  standard geometry, and it is order-topological rather than convex.

