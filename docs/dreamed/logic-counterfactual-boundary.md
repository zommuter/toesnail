---
title: The counterfactual boundary
permalink: /dreamed/logic-counterfactual-boundary
---

# The counterfactual boundary: walking the line where arithmetic becomes incomplete

> **DREAMED, UNREVIEWED.** Written by an AI agent, not by the owner, and not yet read by him.
> See [`docs/dreamed/README.md`](README.md). Nothing here is theory, nothing here is decided, and
> nothing from it has been written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.
>
> **This essay is deliberately speculative in part.** It contains three *invented* counterfactual
> worlds, explored with real rigour but invented all the same. Every invented object carries the
> marker **[INVENTED]** at each appearance and is listed in the numbered inventory in §0.2.
> Everything not so marked is either a theorem from the literature with its source named, or a
> theorem discharged in [`lean/LogicBoundary.lean`](lean/LogicBoundary.lean) and badged `\lean`.
> **No citation here was invented.** Where the sweep found nothing it says "no prior art located",
> and where a recollection could not be verified in this session it says so and gives no
> attribution.

## Provenance

The seed is the sentence the whole Bloch Truth cluster orbits:

> *"the Bloch Truth (might need a better name) might be useful for the AI logic core in the second
> (ZFC?) layer where incompleteness applies (core layer should only be complete, e.g. ZF without
> C)"*
>
> `~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`, 2025-08-08.

Two prior results set this up and are not rediscovered. `REVIEW_ME.md id:251e` records that the
parenthetical is wrong: Goedel I needs consistency, effective axiomatisation and the interpretation
of arithmetic, and AC is on none of those lists, so dropping it buys no completeness.
[`logic-layered-core.md`](logic-layered-core.md) §1.1 and
[`logic-beyond-su3.md`](logic-beyond-su3.md) redrew the line at **interprets arithmetic versus does
not**. This essay walks that line. How thin is it, what is on each side, what would have to be
different for it to sit elsewhere, and, since this is a physics repository, is it the shadow of
something physical?

---

# 0. The headline, stated and not teased

## 0.1 Five findings

1. **Neither operation alone is fatal and the pair is.** Presburger arithmetic (addition, no
   multiplication) is complete and decidable, Presburger 1929. Skolem arithmetic (multiplication, no
   addition) is decidable, Mostowski 1952. Together you get Goedel 1931. Incompleteness belongs to
   the *interaction*, not to either operation. §1.

2. **The interaction is pairing, and pairing is where the second operation is spent.** Goedel
   numbering needs an injection $\mathbb{N}^2 \to \mathbb{N}$; **no affine map is one**
   (`affine_not_injective`), and Cantor's, which is, is quadratic. Separately, **multiplication is
   not definable from addition at all** (`mul_not_addTerm_definable`). §3.2.

3. **A located finding about a sibling essay.** [`logic-models-ensemble.md`](logic-models-ensemble.md)
   never mentions Tennenbaum's theorem (`grep` returns zero) and never states that the *points* of
   the space it puts a measure on are individually uncomputable. §2.

4. **The boundary is wide in expressiveness and sharp in verdict, and the two are routinely
   conflated.** §5.

5. **The owner's core layer cannot talk about proofs**, and the interface needs a fourth channel
   nobody has analysed. §6.

## 0.2 Inventory of Invented Objects

Every item is **[INVENTED]** by this essay. None is a theorem, none is prior art, none appears in
the Lean file.

| # | Name | What it is | What is real underneath |
|---|---|---|---|
| **I1** | **Flatland of Addition** | A world where $\langle \mathbb{N},+,\times\rangle$ is decidable. | Nothing: §3 argues the world is *incoherent*, and that is the finding. The theorems used to break it (Turing 1936, MRDP, Goedel 1931) are real. |
| **I2** | **The Oracle World** | A world where physics supplies a halting oracle. | The physics literature it is built on is real and cited: Hogarth 1992/1994/2004, Earman and Norton 1993, Etesi and Nemeti 2002, Welch 2006. The *world* is a framing device. |
| **I3** | **The ladder operation** $\circledast_k$ | $x \circledast_k y := x + y + V_k(x)$, proposed as strictly between $+$ and $\times$. | The structure underneath, $\langle \mathbb{N},+,V_k\rangle$, is **Buechi arithmetic**: real, decidable, cited. Only the packaging into one binary operation is invented. |
| **I4** | **The interpretive control parameter** $\lambda$ | An "order parameter" used in §7.1 to test the phase-transition framing. | Nothing. §7.1 **rejects** the framing and retires $\lambda$ in the section that introduces it. |
| **I5** | **The report index rule** | A design rule for the owner's architecture, §6.3. | Its justification, `affine_not_injective`, is machine-checked. The *rule* is a recommendation, not a theorem. |

---

# 1. Where the line actually is

## 1.1 The three landmarks

| Structure | Complete | Decidable | Attribution | Complexity |
|---|---|---|---|---|
| $\langle \mathbb{N}, + \rangle$, **Presburger** | yes | yes | Presburger 1929 | doubly exponential lower bound (Fischer and Rabin 1974); triply exponential upper (Oppen 1978); complete for alternating doubly exponential time with linearly many alternations (Berman 1980) |
| $\langle \mathbb{N}, \times \rangle$, **Skolem** | yes | yes | Mostowski 1952, *On direct products of theories*, JSL **17**(1), 1-31, via Feferman-Vaught decomposition | triply exponential (Ferrante and Rackoff 1979); quantifier-free satisfiability in NP (Graedel 1989) |
| $\langle \mathbb{N}, +, \times \rangle$ | **no** | **no** | Goedel 1931; Church and Turing 1936 | not applicable |

The middle row is the one most people who have heard of Goedel have never heard of, and it is what
makes the boundary vivid. Multiplication is not the villain. Addition is not the villain. **The
villain is the pair.**

The Skolem mechanism explains why multiplication alone is harmless. By unique factorisation a
natural number is a finitely supported exponent vector over the primes, and multiplication is
*pointwise addition* of those vectors, so $\langle \mathbb{N},\times\rangle$ is a weak direct power
of $\langle \mathbb{N},+\rangle$ and decidability transfers. Multiplication alone is Presburger
arithmetic in disguise. What it lacks is any way to relate the exponent vector of $x$ to that of
$x+1$, and that relation is where all the difficulty lives.

## 1.2 The reals are decidable and the integers are not

Tarski's theorem on real closed fields (Tarski 1948) makes
$\langle \mathbb{R},+,\times,<,0,1\rangle$ complete and decidable, doubly exponential in general
(Davenport and Heintz 1988), singly exponential for the existential fragment. So the reals have both
operations and are decidable anyway.

That looks like a counterexample to §1.1 and is not, and why matters. Goedel I needs the theory to
**interpret arithmetic**: to define a copy of $\mathbb{N}$ with both operations. Real closed fields
cannot, because $\mathbb{Z}$ is not definable in the field of reals. No definable $\mathbb{N}$ means
no induction, no counting, no finite sequences, no syntax.

The rationals are the other side of that coin. **Julia Robinson** (1949, *Definability and Decision
Problems in Arithmetic*, JSL **14**(2), 98-114, her 1948 Berkeley thesis under Tarski) defined
$\mathbb{Z}$ inside $\mathbb{Q}$ by a first-order formula, so the theory of the rationals is
undecidable. Three fields, three verdicts:

$$
\mathbb{R} : \text{decidable} \qquad \mathbb{Q} : \text{undecidable} \qquad \mathbb{Z} : \text{undecidable}
$$

with $\mathbb{Q}$ between the other two and sharing an operation table with both. The line does not
run between simple and rich structures. It runs between structures that can point at their own
integers and structures that cannot.

## 1.3 The boundary is not the complexity

The natural first picture is a slope: weak theories easy, strong theories hard, hardness eventually
infinite. The complexity column refutes it. Presburger arithmetic is decidable, and Fischer and
Rabin 1974 showed that in the worst case even the shortest proof of a true sentence of length $n$
has length at least $2^{2^{cn}}$. That is a statement about proofs, not about a bad algorithm, so
Presburger is on the safe side and already unusable at scale. Worse still on the safe side: S1S, the
monadic second-order theory of one successor, is decidable (Buechi 1962) with a **non-elementary**
procedure bounded by no fixed tower of exponentials.
[`logic-layered-core.md`](logic-layered-core.md) §1.2 names that trap; its sharpest form:

> **Decidability is a mathematical property and not an engineering one.** Crossing the boundary
> changes a verdict without changing the difficulty of anything you were actually doing.

That invisibility from the complexity side is the first respect in which the line behaves like a
horizon. §7.2 takes that seriously and then trims it back.

---

# 2. Tennenbaum's theorem, and a located finding

## 2.1 The theorem

**Tennenbaum's theorem** (Stanley Tennenbaum, 1959): *no countable nonstandard model of first-order
Peano arithmetic is computable.* Sharper, and this is what makes it a jewel: **neither the addition
nor the multiplication of such a model can be computable**. Either operation alone, given as an
oracle on the codes, computes the characteristic function of a non-recursive set.

Set that against §1.1 and the symmetry is striking. Syntactically, addition alone is harmless and
multiplication alone is harmless. Semantically, in the nonstandard models, addition alone is already
fatal and multiplication alone is already fatal. The two operations that cannot separately produce
incompleteness cannot separately survive it either. Consequence: $\mathbb{N}$ is computable, and
**every other model of PA, up to isomorphism, is not.** Continuum many countable models, exactly one
computable isomorphism class.

## 2.2 The finding

[`logic-models-ensemble.md`](logic-models-ensemble.md) reads the owner's Bloch state as a state over
**models**, made precise as a finitely additive measure on the Stone space of the Lindenbaum-Tarski
algebra, whose points are the complete consistent extensions, and proves that space is Cantor space
because Goedel-Rosser makes the algebra atomless.

`grep -c -i "Tennenbaum" docs/dreamed/logic-models-ensemble.md` returns **0**.

That alone is not an error: Tennenbaum is about *models* and that essay's theorems are about
*theories*, so nothing it proves is affected. The finding is a caveat missing exactly where it makes
its central move, in two layers.

**Layer 1, the points.** Its §4.2 computability wall is good and correct: citing the MIRI literature
and Garrabrant et al. 2016, it establishes that a coherent measure has no computable approximation,
and C3 concludes direction (i) "is a description of a limit object that no machine occupies". That is
about the **measure**. One level down there is a second, more basic uncomputability it does not
state: **every point of its Stone space is an undecidable set of sentences.** A point is a complete
consistent extension of PA, and by Goedel-Rosser with the essential undecidability of Robinson's Q,
no such extension is decidable. Not one, including $\mathrm{Th}(\mathbb{N})$, which by Tarski is not
even arithmetically definable.

This matters *because of how the points are used*. Its derivation of the reachable segment (around
`logic-models-ensemble.md:194`) reads: if $\varphi$ is independent then $[\varphi]$ and its
complement are nonempty clopen, "so Dirac measures at points of each are available and every convex
combination of them is a measure". Dirac measures are the simplest possible choice and the natural
engineering reading of "just pick a model and believe it". Layer 1 closes that fallback too: the
simplicity of the measure rescues nothing, because what it concentrates on is already beyond
computation.

**Layer 2, the models.** The moment the prose slips from "complete extensions" to the word the title
uses, *models*, Tennenbaum applies and it is worse: up to isomorphism exactly one of the objects
quantified over is computable, and every other has both operations uncomputable.

**Recommended patch, not a correction of a falsehood:** C3 should say the uncomputability is
*stacked*. The measure is uncomputable (as stated); its points are uncomputable (Goedel-Rosser); and
read as models, all but one isomorphism class is uncomputable in each operation separately
(Tennenbaum 1959). For a running AI core the stack matters more than any single layer: a machine
cannot sample this space, name a point of it, or condition on one. That essay's own verdict is that
direction (i) describes a limit object no machine occupies, so this pushes the same way and gives it
a second independent proof. It overturns nothing and should not be filed as if it did.

---

# 3. **[INVENTED]** Counterfactual I: Flatland of Addition

## 3.1 The world

**[INVENTED] Flatland of Addition** is a world in which $\langle \mathbb{N},+,\times\rangle$ is
complete and decidable, otherwise as similar to ours as coherence permits. What breaks?

The seductive first answer is "self-reference, because Goedel numbering needs pairing and pairing
needs both operations". That is half right, and the wrong half is the instructive one.

## 3.2 The pairing half, which is right and is machine-checked

Goedel numbering is at bottom an injection $\mathbb{N}\times\mathbb{N}\to\mathbb{N}$, iterated to
encode sequences. The additive world has none:

$$
\neg\,\exists\, a, b, c \in \mathbb{N} : \ (x, y) \mapsto ax + by + c \ \text{ is injective on } \mathbb{N}^2
\veq{no-affine-pairing}\lean
$$

The witness needs no case analysis on size: the distinct points $(b,0)$ and $(0,a)$ both go to
$ab+c$, with $a=b=0$ handled by $(0,0)$ against $(1,0)$. That is `affine_not_injective`.

The lift from affine maps to all of Presburger arithmetic is **quoted, not proved**: every
Presburger-definable function is piecewise affine on semilinear pieces, so each piece is a copy of
the obstruction. The Lean file proves the core lemma and its header says the lift is not formalised.

The contrast is the other half. Cantor's pairing function *is* injective (`pair_injective`, using
Mathlib's `Nat.pair`) and its definition is quadratic. **Pairing is where the second operation is
spent.** Multiplication is not one of several tools Goedel happened to reach for. It buys the
encoding.

A second, independent and prettier proof that addition alone is too weak:

$$
\neg\, \exists\, t \in \mathrm{AddTerm}(2) \ \ \forall v : \ t(v) = v_0 \cdot v_1
\veq{mul-not-additive}\lean
$$

The whole argument is one asymmetry: $x \mapsto -x$ is an automorphism of the group $(\mathbb{Z},+)$
and not of the ring $(\mathbb{Z},+,\times)$, since $(-1)(-1) = +1$ while $-(1\cdot 1) = -1$. Every
term built from $0$, $+$ and unary minus commutes with negation; multiplication does not.
`AddTerm.eval_neg` and `mul_not_addTerm_definable` are the two halves. The step from *terms* to
*quantified formulas* uses the standard fact that a definable relation is preserved by every
automorphism, and that step is **quoted, not proved**, as the Lean header states.

## 3.3 The wrong half

**[INVENTED]** Flatland of Addition was specified as a world where $+$ *and* $\times$ together are
decidable. It has multiplication, hence Cantor pairing, hence Goedel numbering, hence an
arithmetisation of syntax. Everything in §3.2 says nothing about it. The counterfactual must break
somewhere else, and finding where is the interesting part.

## 3.4 Following it honestly: the world has no programmable computer

Suppose $\mathrm{Th}(\mathbb{N},+,\times)$ is decidable. Then:

1. By MRDP (Matiyasevich 1970, completing Davis, Putnam and Robinson) every recursively enumerable
   set is Diophantine, hence definable by an existential arithmetic formula.
2. The halting set is r.e., so it is so definable.
3. A decision procedure for arithmetic therefore decides halting.
4. But halting is undecidable by Turing's 1936 diagonal argument, which uses **no arithmetic at
   all**: only a universal machine and the ability to run a machine on its own description.

So the counterfactual is not a variation on arithmetic. It demands that **step 4** fail, and step 4
never mentions $+$ or $\times$. The only way out is that Flatland has no universal machine: no
device that takes a description of a device and simulates it. **[INVENTED] Flatland of Addition has
calculators and no computers.** Nothing in it is programmable: no compiler, no interpreter, no
operating system, because the stored-program architecture *is* the universal machine.

That is stranger and stronger than "no self-reference in mathematics", and it is the honest version.
The expectation that the counterfactual is really "a world without self-reference" is **confirmed
but relocated**: the self-reference that has to go is Turing's, not Goedel's, and Turing's costs the
world its computers.

**One thread flagged, not followed.** The diagonal argument uses *contraction*, the structural rule
that lets a hypothesis be used twice, so a contraction-free substructural logic might block it. This
session located no source establishing that and **states no attribution**; it is recorded as a
question. What is established, against the optimistic version: intuitionistic logic does not escape,
since Heyting arithmetic is incomplete by the same argument. "Change the logic" is not on its own a
route out.

---

# 4. **[INVENTED]** Counterfactual II: the Oracle World

## 4.1 The world and its real literature

**[INVENTED] The Oracle World** is one where physics supplies a halting oracle you can build, feed a
program, and read a bit from. The framing is invented; the physics it is built on is not.

The relevant real construction is the **Malament-Hogarth spacetime**, after David Malament and Mark
Hogarth: a spacetime containing a worldline of infinite proper time and an event whose past contains
all of it. An observer falls toward that event, a computer is left running forever on the infinite
worldline and signals only if it halts, and the observer learns the answer in finite proper time.
The literature, verified against the published record rather than recalled:

- **Hogarth, Mark L.** (1992). *Does general relativity allow an observer to view an eternity in a
  finite time?* Foundations of Physics Letters **5**(2), 173-181.
- **Hogarth, Mark** (1994). *Non-Turing Computers and Non-Turing Computability.* PSA **1994**(1),
  126-138. And (2004), *Deciding Arithmetic Using SAD Computers*, BJPS **55**(4), 681-691.
- **Earman, John and Norton, John D.** (1993). *Forever is a Day: Supertasks in Pitowsky and
  Malament-Hogarth Spacetimes.* Philosophy of Science **60**(1), 22-42. The standard source for the
  physical objections, which are severe: the signal the observer receives is unboundedly
  blue-shifted, so the construction has an energy problem, not an engineering one.
- **Etesi, Gabor and Nemeti, Istvan** (2002). *Non-Turing Computations Via Malament-Hogarth
  Space-Times.* International Journal of Theoretical Physics **41**(2), 341-370. Moves the
  construction into **rotating Kerr black holes**.
- **Welch, P. D.** (2006). *The extent of computation in Malament-Hogarth spacetimes.*
  [arXiv:gr-qc/0609035](https://arxiv.org/abs/gr-qc/0609035).

Welch settles how far this goes, and his abstract states both directions verbatim:

> "Theorem A. If H is any hyperarithmetic predicate on integers, then there is an MH spacetime in
> which any query ? n ∈ H ? can be computed. In one sense this is best possible, as there is an
> upper bound to computational ability in any spacetime which is thus a universal constant of the
> space-time M. Theorem C. Assuming the (modest and standard) requirement that space-time manifolds
> be paracompact and Hausdorff, for any MH spacetime M there will be a countable ordinal upper
> bound, w(M), on the complexity of questions in the Borel hierarchy resolvable in it."

Read together, the Oracle World is bounded from the inside: a given spacetime carries a countable
ordinal ceiling that is a **constant of the spacetime**. You do not get all of mathematics. You get
a climb up the hyperarithmetic hierarchy, and how far is fixed by which universe you are in.

## 4.2 The sharp question: does the logic change, or only what we can compute?

**Only what we can compute. The logic does not change**, for three separate reasons of increasing
force.

**Reason 1: Goedel relativises.** Incompleteness needs the axiom set to be *effectively*
axiomatised. Give a theory an oracle $A$ and "effective" becomes "$A$-effective", and the theorem
returns verbatim one level up. The Turing jump is a ladder, not a door. Turing's own 1939 ordinal
logics were an attempt to climb it by iterating consistency statements, and the climb is transfinite
and never terminates.

**Reason 2: the escape that is not one.** There is a way to be complete: take
$\mathrm{Th}(\mathbb{N})$ itself as your axioms. That theory is complete and consistent and nothing
is contradicted, because it is not effectively axiomatised by anything. An oracle for it makes it
*usable*, not *axiomatisable*. The Oracle World buys access to a complete theory it still cannot
write down.

**Reason 3, decisive: Tarski's undefinability theorem is oracle-free.** Truth for the language of
arithmetic is not definable in the language of arithmetic, and the proof is pure diagonalisation on
formulas. It mentions no machine, no algorithm, no oracle, no complexity class. There is nothing in
it for physics to be handed, so **no apparatus whatsoever changes it.**

> **Physics can move the computability boundary. It cannot move the definability boundary, and the
> definability boundary is the one this essay is about.**

That is also the sharpest corrective to a family of arguments this repository has already handled.
[`weltformel-impossibility.md`](weltformel-impossibility.md) found that the papers it audits deduce
claims about *physics* from theorems about *formal systems*, and located two errors in the
deduction. This is the same distinction from the other side: grant the physics its most extravagant
computational wish and the logical results the argument leans on are untouched.

---

# 5. **[INVENTED]** Counterfactual III: is there anything in between?

## 5.1 The question, made precise

Is there an operation weaker than multiplication and stronger than addition, sitting exactly on the
boundary? The question is only sharp once "the boundary" is disambiguated, and that is where the
answer comes from. Two things are being asked:

- **(a) Expressive:** a structure strictly more expressive than $\langle\mathbb{N},+\rangle$ and
  strictly less than $\langle\mathbb{N},+,\times\rangle$?
- **(b) Verdict:** a structure that is *partly* decidable, or *slightly* incomplete?

The answers are **yes, richly** and **no, not at all**. Conflating the two is what makes people
think the boundary is sharp when it is only half sharp.

## 5.2 What is safe: the multiplication sign is a red herring

Presburger arithmetic is entirely happy with $3x$, $17x+4y$ and $\lfloor x/5\rfloor$. Multiplication
by a fixed numeral is iterated addition:

$$
k \cdot x \;=\; \textstyle\sum_{i=1}^{k} x
\veq{const-mul-additive}\lean
$$

(`const_mul_is_iterated_add`.) The boundary is not "a multiplication sign appears". It is "**both
factors are quantified**". Scalar multiplication is a family of unary functions, one per numeral,
each additive. Binary multiplication is one function of two arguments, a different kind of object.

## 5.3 The far side has no shallow end

Take any candidate intermediate operation. If it lets you square, you are finished:

$$
2(xy) + (x^2 + y^2) \;=\; (x+y)^2
\veq{mul-from-sq}\lean
$$

(`mul_from_sq`.) Addition plus squaring defines the graph of multiplication, hence interprets
Robinson's Q, hence Goedel applies. No partial credit.

Worse, the squaring *function* is not needed. The bare **set** of squares suffices, because
consecutive squares differ by an odd number that pins down which square you are at:

$$
(n+1)^2 = n^2 + (2n+1)
\veq{sq-step}\lean
$$

so "$y$ is a square, and $y+2n+1$ is the next square after $y$" defines $y = n^2$ using nothing but
addition and a unary predicate. The uniqueness step is the one needing proof and it is
machine-checked:

$$
m^2 = k^2 + (2n+1) \ \wedge\ (\forall j > k,\ m \le j) \;\Longrightarrow\; n = k
\veq{next-square-forces}\lean
$$

(`next_square_forces`.) A decidable additive core cannot be handed a squares predicate as a harmless
extra. It is the whole of arithmetic in disguise, arriving in the shape of a lookup table.

**This is the concrete sense in which the boundary is razor thin.** You do not cross it by adding
multiplication. You cross it by adding a set.

## 5.4 **[INVENTED]** The ladder operation, and the honest answer to (a)

For a fixed integer $k \ge 2$ define

$$
x \circledast_k y \;:=\; x + y + V_k(x)
$$

where $V_k(x)$ is the largest power of $k$ dividing $x$ (with $V_k(0)$ fixed by convention). **The
operation $\circledast_k$ is [INVENTED] here.** What is *not* invented is what it packages: from
$\circledast_k$ one recovers $+$ and hence $V_k$, so $\langle\mathbb{N},\circledast_k\rangle$ is
inter-definable with

$$
\langle \mathbb{N}, +, V_k \rangle \;=\; \textbf{Buechi arithmetic of base } k ,
$$

a real, named, studied and **decidable** object. The invented operation is a repackaging; the
mathematics underneath belongs to Buechi and the automata tradition.

Three real facts make this a genuine answer to (a):

1. **Strictly stronger than Presburger.** Every Presburger-definable subset of $\mathbb{N}$ is
   eventually periodic (the sets are semilinear). The set of powers of $k$ is not, and it *is*
   definable from $V_k$. So $\circledast_k$ genuinely buys expressive power.
2. **Strictly weaker than full arithmetic**, since it is decidable and full arithmetic is not.
3. **The zone contains an antichain, not just a chain.** The **Cobham-Semenov theorem** (Cobham,
   Alan, 1969, *On the base-dependence of sets of numbers recognizable by finite automata*,
   Mathematical Systems Theory **3**(2), 186-192; Semenov, A. L., 1977, *Presburgerness of
   predicates regular in two number systems*, Sibirskii Matematicheskii Zhurnal **18**, 403-418):
   a relation definable in Buechi arithmetic of base $k$ *and* of base $l$, for multiplicatively
   independent $k$ and $l$, is Presburger-definable. So the powers of $2$, definable in base $2$ and
   not Presburger-definable, are **not** definable in base $3$, and symmetrically. $\circledast_2$
   and $\circledast_3$ are incomparable, both strictly above Presburger and strictly below
   arithmetic.

Skolem arithmetic is a fourth incomparable point in the same zone, having multiplication and no
addition at all.

**Verdict on (a): the boundary is not sharp, and it is not even a line.** The region between the two
famous landmarks is populated, infinite, and partially ordered rather than linearly ordered.

## 5.5 Verdict on (b), and the essay's best result

**There is no theory that is slightly incomplete.** The threshold is interpreting Robinson's Q, and
Q is finitely axiomatised with no induction schema at all. Once a theory interprets Q and is
consistent and effectively axiomatised it gets the whole package at once: Goedel I, Goedel II,
Rosser, Tarski, Church. Nothing arrives separately or partially, and nothing about the *degree* of
strength above the threshold changes any of it. Q, PA and ZFC receive precisely the same verdict.

Together with §5.3 this is the essay's central claim:

> **The zone between addition and multiplication is wide, populated and partially ordered. Its far
> edge is a cliff and not a slope. And the cliff is reached by adding a set, not by adding an
> operation, which is why anyone building a deliberately weak core is in more danger than they
> think.**

**One question the sweep could not settle, recorded as open.** Is there a *maximal* decidable
extension of Presburger arithmetic, or does every decidable extension have a strictly stronger
decidable extension? No source located either way; nothing asserted. If the answer is "no maximum",
the zone has no far shore at all, only a cliff reached by falling rather than by walking.

---

# 6. What this does to the owner's architecture

## 6.1 The question, bluntly

The owner's layered core wants a complete lower layer. §1 says a complete layer is one that does not
interpret arithmetic; §§3.2 and 5.3 say what that costs. So:

> **Can a layer that does not interpret arithmetic talk about proofs at all?**

If it cannot, the version in the owner's own quote is in trouble, because there the core is where
the trustworthy reasoning lives and the second layer is where incompleteness is quarantined. A core
that cannot mention proofs cannot supervise the layer above it.

## 6.2 Checking [`logic-layered-core.md`](logic-layered-core.md) rather than repeating it

That essay's §2.6 asks the same question under "does incompleteness re-enter through the interface?"
and identifies three channels: the report's **type** (two rationals with a linear constraint, safe),
the **arithmetic of the values** (comparison, negation, convex combination, inside quantifier-free
linear real arithmetic, safe), and the report's **accuracy** (not safe, and it proves the finding:
an exact reporter hands the kernel a decision procedure for theoremhood, so reports must be
permitted to be under-confident, machine-checked as `exact_reports_decide`).

**Where I agree, and it is most of it.** Channels 1 and 2 are correct and the arguments are sound.
Channel 3 is a genuinely good finding and its design consequence, that reports are lower bounds and
never facts about what is knowable, is right. Its companion `no_truthfunctional_conj`, that no binary
function on reports computes conjunction, is correct and the right shape of result.

**Where I disagree: the analysis is incomplete, and the missing piece is §3.2.** The three channels
cover the report's *type*, *values* and *accuracy*. They do not cover its **address**. The interface
is specified as "a report per sentence", so something identifies the sentence. Call it the index. The
index is a fourth channel, and it is where arithmetic actually gets back in, because an index that
supports the operations one naturally wants is a Goedel numbering by another name.

## 6.3 **[INVENTED]** The report index rule

Offered as a design rule for the owner to accept, amend or reject:

> **Index rule.** The core's sentence index must carry no definable pairing function. It may compare
> indices for equality, may order them, and may hold finitely many at once. It must have no
> definable binary operation on indices with injective graph, and in particular no definable
> substitution or subformula operation.

Why this is the right line and not arbitrary conservatism:

- Equality and order are free. $\langle\mathbb{N},<,+\rangle$ is Presburger arithmetic: complete and
  decidable. An index supporting counting and comparison is safe.
- A **pairing** function is not free. It is precisely what turns an index into a Goedel numbering:
  pairing gives sequences, sequences give syntax, syntax gives the diagonal lemma.
  `affine_not_injective` says an additive index has none and `pair_injective` says the standard one
  costs multiplication, so the rule is checkable by inspecting the index's operations rather than by
  a global argument about the core.
- A **subformula or substitution** operation is a pairing in disguise, relating the index of
  $\varphi \wedge \psi$ injectively to those of $\varphi$ and $\psi$.

This gives `no_truthfunctional_conj` a second and deeper reading. It says the kernel may constrain
reports and never compute with them, because reports are not truth-functional. Correct. The index
rule says something structurally prior: **the kernel could not compute over the connective structure
even if reports were truth-functional**, because doing so needs an operation relating a
conjunction's index to its conjuncts', that operation is a pairing, and a core with a pairing is not
a decidable core. The truth-functionality obstruction is about values; the index obstruction is
about addresses, and it binds first.

## 6.4 The answer

**No, not in any general sense, and yes in one narrow sense much weaker than the owner's quote
suggests.**

What the core *can* do: hold a bounded table of reports about a fixed, externally supplied, finite
list of sentences, and compute over the two rationals in each row. That is real and useful and the
layered-core essay specifies it correctly. What it *cannot* do:

1. **Quantify over sentences.** "Every sentence the theory has settled is true" is not expressible.
   Neither is $\mathrm{Con}(T)$.
2. **Relate a sentence to its parts.** Given rows for $\varphi$ and $\psi$, it cannot know a third
   row is about $\varphi \wedge \psi$. The connection is supplied from outside, per row, by the
   untrusted layer.
3. **Say anything about proofs as objects.** A proof is a finite sequence of formulas, which is a
   pairing, which the core does not have.
4. **Verify that reports are about what they claim to be about.** The sentence-to-report association
   is entirely a promise from the layer that is not trusted.

So the core is a **bounded dashboard**, not a supervisor. The meter, not the inspector. That is a
serious constraint on the layered design and it bears directly on the owner's own formulation: the
picture in which the complete core is where reliable reasoning happens and the incomplete layer is
quarantined above it **does not survive**, because the core cannot reason about that layer at all.
What survives is the picture the layered-core essay's §5 identified as standard practice,
**proof-carrying code**: a weak decidable checker validating a witness from a powerful untrusted
producer. There the checker never reasons *about* the producer, it re-runs a check, and re-running a
check is something a bounded dashboard can do provided the check is arithmetic-free.

Lean's own kernel, in this repository's `verify/`, is not a counterexample: it *does* interpret
arithmetic, and it is a decidable underapproximation of an undecidable relation rather than a
complete core. The layered-core essay found the same convergence from the other direction. Both
times the lesson is that the real design pattern is under-approximation, not completeness.

---

# 7. The physics analogue, with the analogies labelled

## 7.1 **[INVENTED]** Undecidability as a phase transition: developed, then rejected

The framing: let $\lambda$ be **[INVENTED]** the "interpretive strength" of a language, a control
parameter; let decidability be the order parameter; read §1.1 as a transition at a critical
$\lambda_c$. Developed properly it fails, for instructive rather than pedantic reasons.

- **The control parameter is not a parameter.** §5.4 showed the intermediate zone is *partially
  ordered*, containing an antichain of pairwise incomparable decidable theories. A control parameter
  is a real number and a real number cannot index an antichain. There is no $\lambda$.
- **The order parameter has no fluctuations.** Decidability is two-valued with nothing near it: no
  susceptibility, no correlation length, no critical region. §5.5's "no gradations" is precisely the
  statement that there is no critical region.
- **There is no thermodynamic limit.** A phase transition is a singularity existing only in the
  infinite-volume limit of a family of finite systems. Nothing here is a limit of anything.

**Verdict: reject**, and **[INVENTED]** $\lambda$ is retired in the section that introduced it. What
survives is much weaker and is analogy, not theorem: the *complexity* column of §1.1 varies over
many orders, from co-NP through doubly exponential to non-elementary, which is at least the right
shape for a **crossover**, and a crossover is not a phase transition and has no critical point.

## 7.2 The boundary as a horizon: kept weakly, labelled

The good half is genuine and was already visible in §1.3: **nothing local marks the crossing.** A
theory does not feel itself become incomplete. Adding a squares predicate to a decidable additive
core looks like adding a lookup table, and §5.3 shows it is the whole of arithmetic. That is exactly
the no-drama property of a horizon, which is defined globally, by what can escape, not locally.

The disanalogy is decisive for anyone tempted to build on it. **Horizons are observer-dependent**: a
Rindler horizon exists for the accelerated observer and not the inertial one. The arithmetic
boundary is not observer-dependent in any sense. Interpretability of Q is a property of the theory,
full stop, and no change of frame moves it. §4.2 is the strongest form of that point: even a
physically supplied oracle, the largest change of "observer" the counterfactual allows, does not
move it.

**Verdict: keep as a rhetorical device for the no-drama property only, label it analogy, build
nothing on it.**

## 7.3 The real physical instance: undecidability of the spectral gap

This one is not an analogy, and it is why the section exists.

**Cubitt, Toby S., Perez-Garcia, David, and Wolf, Michael M.** (2015). *Undecidability of the
spectral gap.* Nature **528**(7581), 207-211, doi `10.1038/nature16059`; full version
[arXiv:1502.04573](https://arxiv.org/abs/1502.04573), later Forum of Mathematics Pi (2022). The
citation is confirmed against the published article by this repository's own
[`citation-audit.md`](citation-audit.md), which quotes the scope verbatim: *"families of quantum
spin systems on a two-dimensional lattice with translationally invariant, nearest-neighbour
interactions, for which the spectral gap problem is undecidable"*.

Why it belongs here rather than in a general list of undecidability results: **its mechanism is
exactly this essay's mechanism.** The construction builds a family of Hamiltonians whose ground
state encodes a Turing machine's tape, so the spectral gap in the thermodynamic limit depends on
whether the machine halts. The physical system is made to *interpret arithmetic*. The line is
crossed by the encoding, and undecidability follows from the crossing, precisely as §5.3 says it
must.

The scope discipline that goes with it, since this result is frequently overstated in popular
accounts:

- Undecidability is **for a family**, parametrised by a machine description, not for any single
  fixed Hamiltonian. Asking whether *this* material is gapped is not an undecidable question.
- It is a statement about the **thermodynamic limit**. Every finite lattice is a finite-dimensional
  eigenvalue problem and is decidable.
- The interactions are engineered to carry the encoding. Nothing says a Hamiltonian a physicist
  would write down for a real material lands near the construction.

With that stated, the result is the physical statement the essay wants, and it is a theorem:

> **A physical system expressive enough to encode arithmetic inherits arithmetic's undecidability,
> and for a quantum spin system "expressive enough" means translation-invariant nearest-neighbour
> interactions on a 2D lattice. This boundary is not confined to formal languages. It runs through
> condensed matter physics, and Cubitt, Perez-Garcia and Wolf located it there.**

[`weltformel-impossibility.md`](weltformel-impossibility.md) reaches the same conclusion from the
opposite direction, calling this paper "a sharper honest bound" than the papers it audits. Worth
recording and worth not overselling: it is one paper being the best available instance, not two
independent confirmations of anything.

---

# 8. The Lean companion

[`lean/LogicBoundary.lean`](lean/LogicBoundary.lean), checked with `lake env lean` from `verify/`
under `capped.sh`. **Exit 0, zero `sorry`.**

| Lean name | Section | What it discharges |
|---|---|---|
| `AddTerm`, `AddTerm.eval` | 3.2 | The additive term language over $\mathbb{Z}$, as a term algebra. |
| `AddTerm.eval_neg` | 3.2 | Equivariance: every additive term commutes with $x \mapsto -x$. |
| `mul_not_addTerm_definable` | 3.2, $\eqref{mul-not-additive}$ | Multiplication is not an additive term. |
| `affine_not_injective` | 3.2, $\eqref{no-affine-pairing}$ | No affine map $\mathbb{N}^2 \to \mathbb{N}$ is injective. |
| `pair_injective` | 3.2 | Cantor's pairing function is injective: the quadratic contrast. |
| `mul_from_sq` | 5.3, $\eqref{mul-from-sq}$ | Squaring plus addition recovers multiplication. |
| `sq_step`, `next_square_forces` | 5.3, $\eqref{sq-step}$, $\eqref{next-square-forces}$ | The bare set of squares defines the graph of squaring. |
| `const_mul_is_iterated_add` | 5.2, $\eqref{const-mul-additive}$ | Multiplication by a numeral is iterated addition. |

**What the file does NOT contain**, stated here as well as in its own header: no formalisation of
Goedel I, of Presburger decidability, of Tarski on real closed fields, or of Tennenbaum. All four are
quoted from the literature. No formalisation of first-order definability, so
`mul_not_addTerm_definable` is the term-level statement and the lift to quantified formulas is
quoted. **No invented object appears in the file at all:** Flatland of Addition, the Oracle World,
$\circledast_k$, $\lambda$ and the index rule are absent by design.

The badges are `\lean` and not `\sympylean` because every badged claim is a structural or
definability statement, the tier ladder's Lean case (`CONVENTIONS.md` §2). None was run through
SymPy and none claims to have been. Per [`docs/dreamed/README.md`](README.md) these badges are claims
about the dreamed Lean file only and are deliberately not wired into `physics/*.toml` or
`tests/test_verify.sh`.

---

# 9. Prior-art sweep

**[V]** = verified against a primary or authoritative source in this session. **[R]** =
repository-internal, verified by reading the file named.

| Claim | Status |
|---|---|
| Presburger 1929: complete and decidable | **[V]** |
| Fischer and Rabin 1974: $2^{2^{cn}}$ proof-length lower bound | **[V]** |
| Oppen 1978 triply exponential upper; Berman 1980 exact characterisation | **[V]** |
| Mostowski 1952, JSL **17**(1), 1-31: Skolem arithmetic decidable | **[V]** |
| Ferrante and Rackoff 1979; Graedel 1989 (quantifier-free fragment in NP) | **[V]** |
| Tarski 1948 real closed fields; Davenport and Heintz 1988 | **[R]** via `logic-layered-core.md` §1.2, not re-verified here |
| Julia Robinson 1949, JSL **14**(2), 98-114: $\mathbb{Z}$ definable in $\mathbb{Q}$ | **[V]** |
| Tennenbaum 1959: no computable countable nonstandard model of PA; **neither** operation computable | **[V]** |
| Buechi arithmetic decidable; Cobham 1969 and Semenov 1977 | **[V]** |
| Hogarth 1992/1994/2004; Earman and Norton 1993; Etesi and Nemeti 2002 | **[V]** |
| Welch 2006, arXiv:gr-qc/0609035, Theorems A and C quoted verbatim | **[V]** |
| Cubitt, Perez-Garcia and Wolf, Nature **528**, 207-211 (2015) | **[R]**, confirmed by `citation-audit.md` against the published article |
| MRDP: every r.e. set is Diophantine (Matiyasevich 1970, after Davis, Putnam, Robinson) | **[V]** as standard; no primary source re-read this session |
| A *maximal* decidable extension of Presburger arithmetic | **No prior art located.** Open in §5.5; nothing asserted. |
| Whether a contraction-free logic blocks the Goedel or Turing diagonal | **No prior art located.** A question in §3.4, **no attribution**. |
| Tennenbaum for weak fragments below full induction | **Not verified this session.** No source, no attribution, no claim. |
| **[INVENTED]** $\circledast_k$ as a named object | **No prior art located**, and none expected: it repackages Buechi arithmetic, which *is* the prior art. |
| **[INVENTED]** the index rule of §6.3 | **No prior art located.** Its ingredients are standard; the packaging as an interface condition is not, and `logic-layered-core.md` §5 found no report-interface prior art either. |

**Honesty note.** This session's web-search budget was exhausted partway through, so several **[V]**
items were verified by fetching a specific authoritative page rather than by broad search, and the
last four rows report gaps rather than negative results. A gap in this sweep is not evidence that no
prior art exists. It is evidence that this session did not find any.

---

# 10. Surfaced for the owner

Each item is a **recommendation awaiting your ruling**, never a settled decision, and none has been
written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`.

1. **HEADLINE, and it constrains the architecture rather than confirming it. Your core layer cannot
   talk about proofs.** A layer that does not interpret arithmetic can hold a bounded table of
   opaque per-sentence reports and do arithmetic on the two rationals in each row. It cannot
   quantify over sentences, relate a sentence to its subformulas, represent a proof, or verify that
   a report is about the sentence it claims to be about. The picture in your 2025-08-08 quote, where
   the complete core is the trustworthy reasoner and incompleteness is quarantined above it, **does
   not survive** in that form. What survives is proof-carrying code: the core re-runs an
   arithmetic-free check on a witness and never reasons about the producer. **Ruling needed:**
   accept the reframing from *supervisor* to *bounded checker*, or reject it.

2. **Neither addition nor multiplication alone is fatal, and this is the strongest one-line
   statement of your boundary available.** Presburger arithmetic (1929) and Skolem arithmetic
   (Mostowski 1952) are each complete and decidable; their combination is not. If the layered
   architecture is ever written up, that pair is the sentence to lead with, because it says the
   phenomenon lives in the interaction.

3. **A located finding about a sibling essay, offered as a strengthening.**
   [`logic-models-ensemble.md`](logic-models-ensemble.md) has no mention of Tennenbaum and does not
   state that the *points* of the space it puts a measure over are individually uncomputable. Its
   §4.2 wall is about the measure. The points are a second, independent uncomputability, and the
   essay uses Dirac measures *at those points* to derive its central segment, so the engineering
   fallback of "pick one and believe it" is closed off too. **Ruling needed:** whether that essay's
   C3 should be amended to say the uncomputability is stacked. No amendment was made by me.

4. **A concrete, checkable design rule, [INVENTED], needing your decision.** §6.3's index rule: the
   core's sentence index may carry equality and order and must carry **no definable pairing**, no
   substitution, no subformula operation. Its justification is machine-checked
   (`affine_not_injective`, `pair_injective`). It is a fourth interface channel that
   [`logic-layered-core.md`](logic-layered-core.md) §2.6 does not analyse, and it binds *before* that
   essay's truth-functionality obstruction. **Ruling needed:** adopt, amend, or reject.

5. **The boundary is wide in expressiveness and sharp in verdict.** A genuinely intermediate zone
   exists (Buechi arithmetic, with an antichain in it by Cobham-Semenov), so "is the boundary
   sharp?" is **no** for expressive power. But interpreting Robinson's Q is a threshold with nothing
   on it and there is no partly-incomplete theory. §5.3 shows the cliff is reached by adding a
   *set*, not an operation: addition plus the bare predicate "is a square" is already the whole of
   arithmetic, machine-checked. **This is the item most likely to bite a real implementation**, and
   it is why item 4 is stated as a prohibition on operations rather than a budget on strength.

6. **Physics can move the computability boundary and cannot move the definability boundary.** Even
   granting a halting oracle: Goedel relativises (the Turing jump is a ladder, not a door), the
   complete theory bought is still not axiomatisable, and Tarski's undefinability theorem is
   oracle-free because its proof is pure diagonalisation. Welch 2006 bounds even the optimistic case
   by a countable ordinal that is a constant of the spacetime. This is the same distinction
   [`weltformel-impossibility.md`](weltformel-impossibility.md) enforces from the other side, and it
   may be worth stating once, in one place, for the whole cluster.

7. **The physics analogue is one theorem and two rejected metaphors.** Cubitt, Perez-Garcia and Wolf
   (Nature **528**, 2015) is a real physical instance of this line, and its mechanism is this
   essay's mechanism: the spin system is made to encode a Turing machine's tape, which is to say
   made to interpret arithmetic. The phase-transition framing is **rejected** (no control parameter,
   because the zone is an antichain; no fluctuations; no thermodynamic limit). The horizon framing
   is kept only for the no-drama property and labelled analogy. **Ruling needed:** whether the
   Cubitt result deserves a place in `physics/`, given that this makes two essays independently
   pointing at it.

8. **One counterfactual result possibly worth keeping as prose.** A world in which
   $\langle\mathbb{N},+,\times\rangle$ is decidable is not a world with different mathematics. By
   MRDP it decides halting, and halting's undecidability is Turing's diagonal argument, which uses
   no arithmetic. So the counterfactual forbids the universal machine, which is to say the
   stored-program computer. **[INVENTED] Flatland of Addition** has calculators and no computers. If
   the essay wing ever wants a single image for why incompleteness is not a defect of mathematics,
   that is it: the price of removing it is every programmable device.
