---
title: Choice, BPI, and the countable case
permalink: /dreamed/logic-bpi
---

# Choice, BPI, and the countable case

**DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](README.md). This page was written by an
AI agent, not by the owner, and nothing in it is toesnail's theory. It is a verification pass,
not a proposal.

Companion Lean file: `docs/dreamed/lean/LogicBPI.lean` (exit 0, zero `sorry`).

---

# 0. The headline, stated and not teased

[`logic-z2-grading.md`](logic-z2-grading.md) section 4.3 noticed that picking a coherent truth
assignment on a Boolean algebra is exactly what the Boolean Prime Ideal theorem (BPI) does, that
BPI is a choice principle, and that it is strictly weaker than the full axiom of choice. It then
observed that the owner's origin quote for this whole project asks for a core layer in "ZF
without C", flagged the convergence as striking, and flagged it as **unverified against the
literature**. This page is the focused pass the 2026-09-07 rulings adopted as D4.1.

**The verdict is (b): the theorem is real, and it is a theorem about the wrong object.**

Every set-theoretic fact section 4.3 asserted checks out. BPI really is what produces a coherent
truth assignment on a *general* Boolean algebra; it really is unprovable in ZF; it really is
strictly weaker than AC. But the algebra this project cares about is the Lindenbaum-Tarski algebra
of a theory in a countable language, and such an algebra is **countable**. For a countable Boolean
algebra a prime ideal is built by walking an enumeration and deciding one element at a time, in ZF
alone. There is no limit stage, so there is nothing for a choice principle to do. The construction
is written out and machine-checked in the companion Lean file.

So the convergence dissolves. In the regime the origin quote names, choice is not withheld from
you, because you never needed it.

Three things survive, and they are worth more than the lead was.

1. **The sharp condition is well-orderability, not countability.** ZF proves the ultrafilter
   theorem for every *well-orderable* Boolean algebra. BPI's entire content is the case of an
   algebra that cannot be well-ordered. Nothing in the toesnail architecture reaches that case,
   because every language in it is countable.
2. **The real obstruction at the countable case is computational, not set-theoretic.** The
   completion the construction produces is not computable, and cannot be: a computable complete
   consistent extension of PA would contradict Gödel-Rosser. In reverse mathematics the exact
   strength of the countable completeness theorem is **WKL<sub>0</sub>**, weak König's lemma, which
   is a compactness principle about infinite binary trees and has nothing to do with choice.
   *That* is the honest formal home of the owner's instinct.
3. **If choice bites in [`logic-models-ensemble.md`](logic-models-ensemble.md), it bites as
   dependent choice, not as BPI.** That essay's object is a measure on a Stone space, and routine
   measure theory leans on countable and dependent choice. DC and BPI are incomparable: Solovay's
   model satisfies DC and refutes BPI, and the Halpern-Levy model satisfies BPI and refutes
   countable choice.

---

# 1. What was claimed, verbatim

From [`logic-z2-grading.md`](logic-z2-grading.md) section 4.3, quoted in full so the scope of the
correction is visible:

> **The negation cover** is section 3.2's $B \to B/{\sim}$, whose *coherent* sections are
> ultrafilters. In ZFC one always exists (Boolean Prime Ideal theorem), so the obstruction
> vanishes. **In ZF it need not**: BPI is not provable from ZF and is strictly weaker than choice.
> So "does this Boolean algebra admit a coherent sign?" is non-trivial exactly when the ambient set
> theory is choiceless, which is exactly the regime the owner's origin quote names: *"core layer
> should only be complete, e.g. ZF without C"*. I flag that convergence as striking and as
> **unverified against the literature by me**: I found no one reading BPI as a $\mathbb{Z}_2$
> obstruction, and I am not claiming they have.

Note what is and is not asserted there. It does not claim a citation; it claims a convergence and
labels it unverified. That was the right way to write it, and every sentence in it is true as a
statement about a general Boolean algebra. The defect is a quantifier the passage never states:
*which* Boolean algebra.

`REVIEW_ME.md id:251e` already records the first correction to the origin quote: dropping C does
not buy completeness, because ZF and ZFC are both incomplete and for the same reason. Section 4.3's
lead was, in effect, the hope that the quote was pointing at something else that *is* real. This
page tests that hope.

---

# 2. The equivalences, each checked

BPI, in the form used here: **every nontrivial Boolean algebra has a prime ideal**; equivalently,
every proper filter extends to an ultrafilter. Prime and maximal coincide for Boolean algebras,
which Mathlib records in both directions (`Order.Ideal.IsMaximal.isPrime`,
`Order.Ideal.IsPrime.isMaximal`), so nothing turns on which is named.

| Statement | Relation to BPI over ZF | Status |
|---|---|---|
| Ultrafilter lemma (every proper filter extends to an ultrafilter) | **Equivalent** | Confirmed |
| Stone representation theorem for Boolean algebras | **Equivalent** | Confirmed |
| Compactness theorem for propositional logic | **Equivalent** | Confirmed |
| Consistency theorem for propositional logic | **Equivalent** | Confirmed |
| Compactness theorem for first-order logic, arbitrary signature | **Equivalent** | Confirmed |
| Completeness theorem for first-order logic, arbitrary signature | **Equivalent** | Confirmed |
| Tychonoff's theorem for **compact Hausdorff** spaces | **Equivalent** | Confirmed |
| Compactness of $2^S$ in the product topology, arbitrary $S$ | **Equivalent** | Confirmed |
| Tychonoff's theorem in general | Strictly stronger: **equivalent to AC** | Confirmed |
| Hahn-Banach theorem | **Implied by** BPI, not equivalent | Confirmed as an implication |
| Ordering principle (every set is linearly orderable) | **Implied by** BPI, not equivalent | Not verified here |

Sources for the confirmed rows: the Stanford Encyclopedia entry
[*The Axiom of Choice*](https://plato.stanford.edu/entries/axiom-choice/) for the Stone,
compactness, completeness and Hausdorff-Tychonoff equivalences and the AC-equivalence of full
Tychonoff; the nLab page
[*ultrafilter theorem*](https://ncatlab.org/nlab/show/ultrafilter+theorem) for the propositional
rows and $2^S$, and for listing Hahn-Banach as a consequence rather than an equivalence; and
[*Boolean prime ideal theorem*](https://en.wikipedia.org/wiki/Boolean_prime_ideal_theorem) for the
ultrafilter lemma being equivalent "in ZF set theory without the axiom of choice".

**The one that matters most here.** The first-order completeness and compactness theorems are
equivalent to BPI **for arbitrary signatures**. That qualifier is load-bearing and is where the
whole page turns. For a *countable* language both are provable in ZF outright: Henkin's
construction needs an enumeration of the sentences in order to add witnesses and decide sentences
one at a time, and when the language is countable that enumeration is handed to you, making the
construction a plain recursion on $\omega$. For an arbitrary language you must run a transfinite
argument over a set you cannot enumerate, and that is exactly the gap BPI fills.

The row "compactness of $2^S$" matters again in section 5.3.

---

# 3. Strictly weaker than AC, and what that means formally

Two facts, often run together.

**AC implies BPI, in ZF.** Order the proper filters extending a given one by inclusion; a chain's
union is again proper, because properness is a condition on finite meets and so has finite
character; Zorn gives a maximal element, and a maximal proper filter on a Boolean algebra is an
ultrafilter. This is the direction Mathlib implements, as
`DistribLattice.prime_ideal_of_disjoint_filter_ideal`.

**BPI does not imply AC, in ZF.** The hard direction, and the attribution worth checking rather
than trusting.

> Halpern, J. D. and Levy, A., 1971. "The Boolean prime ideal theorem does not imply the axiom of
> choice", in *Axiomatic Set Theory*, Proceedings of Symposia in Pure Mathematics, Vol. XIII, Part
> I, American Mathematical Society, pp. 83-134.

That is the bibliography entry as it appears in the Stanford Encyclopedia entry cited above, whose
body says "This was shown to be weaker than AC in Halpern and Levy 1971". Wikipedia independently
attributes the result to "J. D. Halpern and Azriel Lévy" and calls the proof "rather non-trivial".
One caution about the date: the ZFA precursor, for set theory with atoms, is Halpern's alone and
predates the proceedings volume, and the 1971 paper is the one that does it for ZF proper. **I did
not verify the precursor's year or volume this session** and state none. Cite Halpern and Levy
1971, which is verified.

**What "strictly weaker" means formally.** Not that BPI is syntactically weaker. It means:

$$
\mathrm{ZF} \vdash \mathrm{AC} \to \mathrm{BPI},
\qquad
\mathrm{Con}(\mathrm{ZF}) \Rightarrow \mathrm{Con}(\mathrm{ZF} + \mathrm{BPI} + \neg\mathrm{AC}).
$$

The second half is a relative consistency result, which is what a model construction can deliver
and all it can deliver. There is no proof "in ZF" that BPI fails to imply AC, and there cannot be
one while ZF's own consistency is open.

**BPI is also not provable in ZF at all.** The cleanest witness is Solovay's model (Solovay, *A
model of set theory in which every set of reals is Lebesgue measurable*, Annals of Mathematics 92,
1970), which satisfies ZF plus dependent choice with every set of reals measurable. A nonprincipal
ultrafilter on $\omega$ yields a non-measurable set, so that model has none and BPI fails there.
The construction assumes an inaccessible cardinal, which bears on the metatheory's strength and not
on the point. **The Solovay reference is stated from standard knowledge and was not fetched this
session.**

---

# 4. The nuance that kills the lead

Now the part the brief asked me to confront head-on rather than bury.

## 4.1 The algebra in question is countable

[`logic-models-ensemble.md`](logic-models-ensemble.md) section 1 already establishes the two facts
it needs, and states the first of them in one line: the Lindenbaum-Tarski algebra

$$
B_T \;=\; \mathrm{Sent}/\!\sim_T,
\qquad \varphi \sim_T \psi \iff T \vdash \varphi \leftrightarrow \psi
$$

is **countable, because the language is**. That sentence is correct, and it is the sentence that
disarms section 4.3.

Be precise about *why* it is choice-free, because "countable" is a word that sometimes hides a
choice. Sentences are finite strings over a countable alphabet, so a Gödel numbering is an explicit
injection $\mathrm{Sent} \to \omega$, definable with no choice at all, and an injection into
$\omega$ well-orders the set. The quotient $B_T$ then also injects into $\omega$, because each
equivalence class is a nonempty set of naturals and so has a **least** element, "least" being a
definable selector. Nothing is chosen. This matters, because the general statement "a surjective
image of $\omega$ is countable" is *not* a ZF theorem; what makes it harmless here is that the
domain is well-ordered.

## 4.2 A countable Boolean algebra has a prime ideal in ZF

Let $B$ be a Boolean algebra with $\top \neq \bot$ and let $e : \omega \to B$ be onto. Define a
running conjunction by

$$
a_0 = \top,
\qquad
a_{n+1} =
\begin{cases}
a_n \wedge e(n) & \text{if } a_n \wedge e(n) \neq \bot \\
a_n \wedge \neg e(n) & \text{otherwise}
\end{cases}
$$

and let $U = \{x \in B : \exists n,\ a_n \le x\}$.

The single non-bookkeeping step is that $a_n \neq \bot$ is preserved, and it is pure algebra:

$$
a \wedge b = \bot \ \wedge\ a \wedge \neg b = \bot \;\Longrightarrow\; a = \bot
\veq{step}\lean
$$

because $a = a \wedge (b \vee \neg b) = (a \wedge b) \vee (a \wedge \neg b)$. Distributivity and
the excluded middle. That is the whole thing. Hence

$$
\top \neq \bot \;\Longrightarrow\; \forall n,\ a_n \neq \bot
\veq{consistent}\lean
$$

and, since $e$ is onto, every element is looked at, so

$$
\forall x \in B,\ x \in U \ \vee\ \neg x \in U
\veq{complete}\lean
$$

with $U$ a proper filter closed under meet and upward closed. Its complement is a prime ideal:

$$
\top \neq \bot,\ e \text{ onto} \;\Longrightarrow\; \exists\, I \subseteq B \text{ a prime ideal}
\veq{enum-prime}\lean
$$

and $U$ is a two-valued homomorphism, which is the "coherent sign" section 4.3 was after:

$$
x \wedge y \in U \iff x \in U \wedge y \in U
\veq{tv-and}\lean
$$

$$
x \vee y \in U \iff x \in U \vee y \in U
\veq{tv-or}\lean
$$

$$
x \in U \iff \neg x \notin U
\veq{tv-not}\lean
$$

**Where the choice would have been.** The Zorn proof considers the *set of all* proper filters
extending a given one, takes a chain, and takes its union at a limit. The enumerated proof has no
limits: every stage is a successor, the decision at each stage is determined by the algebra, and
the recursion theorem on $\omega$ is a ZF theorem. Nothing is chosen. This is Lindenbaum's lemma
for a countable language, and it is the standard reason Henkin's completeness proof for countable
languages is choice-free.

**Consequence.** For $B_T$ with $T$ any theory in a countable language, PA included, BPI is not
needed. The obstruction section 4.3 hoped was non-trivial in ZF is trivial in ZF for this algebra.

## 4.3 The sharp condition is well-orderability, not countability

Countability is sufficient but is not the boundary. The same argument runs by transfinite recursion
along any well-ordering: successor stages use the step lemma, limit stages take the union, which
stays proper because properness is a condition on finite meets. So

**ZF proves: every well-orderable Boolean algebra with $\top \neq \bot$ has a prime ideal.**

That locates BPI's content exactly. BPI is the assertion that this holds for algebras which
**cannot be well-ordered**, and under AC there are none, which is why the distinction is invisible
in ZFC. I could not locate a canonical citation for the well-orderable form; the proof above is
three lines and is offered as a proof rather than a reference. The countable special case is the
one the Lean file discharges and the one this project needs.

## 4.4 A correction to the brief that set this task

The task framing suggested the countability of $B_T$ turns on the language and theory being
**effectively** enumerable. It does not. The ZF argument needs *an* enumeration, not a computable
one. True arithmetic $\mathrm{Th}(\mathbb{N})$ is not even arithmetically definable, let alone
recursively enumerable, and its Lindenbaum algebra is still countable, so ZF still hands you a
completion. Effectiveness matters for section 6, a different question with a different answer.

---

# 5. Where the lead could still survive, checked one at a time

Four candidates. Three fail and one survives in a place the architecture never visits.

## 5.1 An uncountable, non-well-orderable language. Survives, and is unreachable

This is the honest survival. If the language has a constant symbol for every element of a set the
ambient ZF model cannot well-order, then $B_T$ is not well-orderable and section 4.2 does not
apply. A physics-flavoured example is easy to name: one constant per real number, in a model of ZF
where $\mathbb{R}$ is not well-orderable (Solovay's is one). There, "this theory has a complete
consistent extension" is genuinely a BPI-strength assertion.

Does toesnail ever go there? No. [`logic-layered-core.md`](logic-layered-core.md) designs Layer 0
as a decidable quantifier-free constraint language and Layer 1 as an incomplete arithmetic theory,
and both are countable. A continuum-indexed language is not on the roadmap and would break far more
than its choice principles. Real mathematics, empty application.

## 5.2 The measure, rather than the point. Fails, and inverts

A measure on the Stone space is a different object from a point of it. It needs **less** than a
point in general, and something orthogonal in the case at hand.

*Less, in general.* A point of the Stone space is an ultrafilter, whose bare existence is BPI. A
measure is not: Solovay's model carries a perfectly good Lebesgue measure on $2^{\omega}$ while
having no nonprincipal ultrafilter on $\omega$ at all. Measures survive there, points do not, so if
anything the measure-theoretic apparatus is the *less* choice-hungry half.

*Orthogonal, in the case at hand.* For $B_T$ countable the Stone space is Cantor space, and the
coin-flipping product measure on $2^{\omega}$ is explicitly definable with no choice. What routine
measure theory does use everywhere is **countable and dependent choice**: Carathéodory extension,
regularity arguments, nearly every "choose $\varepsilon_n$" step. And DC is not BPI. They are
incomparable:

- Solovay's model satisfies ZF + DC and refutes BPI.
- The Halpern-Levy model satisfies BPI and contains an infinite Dedekind-finite set of reals, so it
  refutes countable choice. (Standard; **not independently verified against the primary this
  session**.)

**So the finding for [`logic-models-ensemble.md`](logic-models-ensemble.md) is a redirection, not a
confirmation.** Its construction is choice-sensitive in the measure theory, as DC, not in the point
set, as BPI. A smaller and duller dependency, shared with essentially all of analysis.

## 5.3 Compactness of the Stone space. Fails, for a checkable reason

The question is fair, because the ensemble construction does lean on the Stone space being
compact, in the step where finite additivity on a clopen algebra upgrades to countable additivity
for free, and both Hausdorff-Tychonoff and "compactness of $2^S$" are BPI-equivalent.

But the relevant $S$ is $\omega$, and **compactness of $2^{\omega}$ is a ZF theorem**. One route:
$2^{\omega}$ is homeomorphic to the Cantor set, a closed subset of $[0,1]$, and Heine-Borel for
$[0,1]$ is provable in ZF, the bisection argument making a *definable* choice at each step. The
BPI-strength content of the $2^S$ row is entirely in uncountable $S$.

Attribution note, since the brief asked for care. Wikipedia credits Kelley (1950, *Duke
Mathematical Journal*) for the AC-equivalence of full Tychonoff, and cites Łoś and Ryll-Nardzewski,
*Fundamenta Mathematicae* 38 (1951), 233-237, which is the standard reference for BPI implying the
Hausdorff case. The converse is commonly attributed to Rubin and Scott; **I could not verify a
Rubin-Scott reference this session** and give none. The equivalence itself is confirmed by SEP.

## 5.4 Reading BPI as a $\mathbb{Z}_2$ obstruction. Not found, and now moot

Section 4.3's own novelty claim was that it found no one reading BPI as a cohomological
$\mathbb{Z}_2$ obstruction. I found no such reading either, but with WebSearch exhausted my sweep
was direct fetches against the sources in section 8, so **absence of evidence is weak here and I
claim nothing**. It is moot regardless: section 4.2 removes the obstruction for the intended
algebra, so there is nothing left for a class to obstruct.

---

# 6. What the owner's instinct was actually near

The countable case is not free of difficulty. The difficulty is just not choice.

**The completion is not computable, and cannot be.** By Gödel-Rosser every consistent recursively
axiomatized extension of PA is incomplete, so a computable complete consistent extension of PA
would be an r.e. complete consistent extension, which cannot exist. The recursion in section 4.2
consults, at each stage, whether $a_n \wedge e(n) \neq \bot$, that is, whether a finite conjunction
of sentences is $T$-consistent, and that predicate is undecidable. The Lean file takes the
corresponding `DecidableEq` instance as a hypothesis precisely so this is visible rather than
smuggled.

**The exact strength is a compactness principle, not a choice principle.** In reverse mathematics,
Gödel's completeness theorem for a countable language is equivalent, over RCA<sub>0</sub>, to
**WKL<sub>0</sub>**, weak König's lemma: every infinite subtree of $2^{<\omega}$ has an infinite
path. The Wikipedia survey [*Reverse
mathematics*](https://en.wikipedia.org/wiki/Reverse_mathematics) lists "Gödel's completeness
theorem (for a countable language)" among the statements equivalent to WKL<sub>0</sub>, alongside
Heine-Borel for $[0,1]$, which is the same compactness fact wearing different clothes. The standard
textbook treatment is Simpson, *Subsystems of Second Order Arithmetic*, chapter IV; **I did not
verify a specific theorem number this session** and give none.

A better home for the instinct than BPI was:

| Question | Answer for a countable language |
|---|---|
| Does a coherent truth assignment exist? | Yes, in ZF. No choice principle. |
| Is it canonical? | No. A different enumeration gives a different completion. |
| Is it computable? | No, and provably not. |
| What axiom does its existence need, measured finely? | WKL<sub>0</sub>, a compactness principle about binary trees. |

"Compactness, not choice" is the right slogan for the whole cluster: BPI's equivalents in section 2
are compactness theorems almost to a row, and the choice-flavoured packaging is an artifact of
stating them for arbitrary index sets.

One boundary to keep clean, since a sibling follow-up is adjacent. The non-computability above is
**not** Tennenbaum's theorem. Tennenbaum says no nonstandard model of PA has a computable
presentation, a statement about models; the statement here is that no complete consistent extension
of PA is computable, a statement about theories, and it follows from Rosser alone. D4.2 asks
[`logic-models-ensemble.md`](logic-models-ensemble.md) to fold in Tennenbaum; that is a different
strengthening, and the two should not be merged.

---

# 7. The verdict on the origin quote, and what it means for `id:251e`

Of the three outcomes the brief posed, the answer is **(b)**: the instinct was right about a real
theorem, and the theorem is about the wrong object.

Stated generously and without softening. The origin line, "core layer should only be complete, e.g.
ZF without C", was a passing parenthesis in a 2025 chat, not a claim. Read as a hunch that
*something about choice is load-bearing at the boundary between the layers*, section 4.3 was right
that a genuine principle sits in that vicinity, right about which one, and right about its
strength. It fails at the last step: for a theory in a countable language that principle is a ZF
theorem, so it cannot separate a core layer from an upper one or do any architectural work at all.

**What this does to `REVIEW_ME.md id:251e`.** That item currently records the first half of the
correction: dropping AC buys no completeness. This page supplies the second half, which points the
same way:

- Dropping AC buys **no completeness** (`id:251e`, already recorded).
- Dropping AC also costs **no truth assignment**, for any layer whose language is countable (this
  page).

So "ZF without C" is inert in both directions for this architecture, which is a tidier statement
than either half alone. Whether `id:251e` should be amended to say so is the owner's call. This
page does not touch that file, per the standing rule that a delegated agent's verdict is surfaced,
never recorded.

---

# 8. Verification status of every citation on this page

The session's WebSearch budget was exhausted before this pass, so prior-art work was direct fetches
against reference works. Every row states what was actually checked.

| Claim | Source | Status |
|---|---|---|
| BPI equivalent to Stone representation, FOL compactness, FOL completeness, Hausdorff Tychonoff; full Tychonoff equivalent to AC | SEP, *The Axiom of Choice* | **Fetched and confirmed**, quoted in section 2 |
| BPI weaker than AC; the Halpern-Levy 1971 bibliography entry | SEP, *The Axiom of Choice* | **Fetched and confirmed**, quoted verbatim in section 3 |
| BPI equivalent to ultrafilter lemma, propositional compactness and consistency, compactness of $2^S$; Hahn-Banach only implied | nLab, *ultrafilter theorem* | **Fetched and confirmed** |
| BPI equivalent to ultrafilter lemma provably in ZF; Halpern and Lévy attribution | Wikipedia, *Boolean prime ideal theorem* | **Fetched and confirmed** |
| Hausdorff Tychonoff equivalent to BPI; Kelley 1950; Łoś and Ryll-Nardzewski, Fund. Math. 38 (1951), 233-237 | Wikipedia, *Tychonoff's theorem* | **Fetched and confirmed** for these three items |
| Rubin and Scott for the converse Hausdorff-Tychonoff direction | none located | **NOT VERIFIED.** No reference given |
| Halpern's earlier ZFA-only result, year and volume | none located | **NOT VERIFIED.** No reference given |
| Gödel completeness for a countable language equivalent to WKL<sub>0</sub> over RCA<sub>0</sub> | Wikipedia, *Reverse mathematics* | **Fetched and confirmed** as a listed equivalence |
| Simpson, *Subsystems of Second Order Arithmetic*, specific theorem number | none located | **NOT VERIFIED.** Chapter cited, no number given |
| Solovay 1970, ZF + DC + all sets measurable | not fetched | **NOT VERIFIED this session.** Stated from standard knowledge |
| Halpern-Levy model contains an infinite Dedekind-finite set, so refutes countable choice | not fetched | **NOT VERIFIED this session.** Stated from standard knowledge |
| ZF proves the prime ideal theorem for well-orderable Boolean algebras | none located | **No citation.** Proof given in section 4.3 instead |
| ZF proves the prime ideal theorem for countable Boolean algebras | none located | **No citation.** Proof given in section 4.2 and machine-checked |

No reference on this page was invented. Where a source could not be reached, the row says so and no
plausible-looking substitute was supplied.

---

# 9. Map of the Lean file

`docs/dreamed/lean/LogicBPI.lean`, checked against the vendored Mathlib at
`leanprover/lean4:v4.30.0-rc2`. Exit 0, zero `sorry`.

| Handle | Lean name | Content |
|---|---|---|
| `step` | `eq_bot_of_inf_eq_bot_of_inf_compl_eq_bot` | The step lemma. The only mathematical content. |
| `consistent` | `approx_ne_bot` | Consistency is preserved at every stage. |
| `complete` | `mem_gen_or_compl_mem_gen` | Every element is decided. |
| `tv-and` | `inf_mem_gen_iff` | The assignment respects conjunction. |
| `tv-or` | `sup_mem_gen_iff` | The assignment respects disjunction. This is primeness. |
| `tv-not` | `mem_gen_iff_compl_notMem_gen` | The assignment respects negation. |
| `enum-prime` | `exists_isPrime_of_enumeration` | Headline: an enumerated consistent Boolean algebra has a prime ideal. |
| `ctble-prime` | `exists_isPrime_of_countable` | The same, from Mathlib's `Countable`. |

The prime ideal is returned in Mathlib's own `Order.Ideal` type with Mathlib's own
`Order.Ideal.IsPrime`, so the output is the identical object Mathlib's choice-based BPI produces.
Mathlib was searched before anything was rolled by hand: it already has `Order.Ideal`,
`Order.Ideal.IsPrime`, the maximal-implies-prime and prime-implies-maximal instances for Boolean
algebras, and BPI itself as `DistribLattice.prime_ideal_of_disjoint_filter_ideal`. What it lacks,
and what this file adds, is the enumerated construction.

**A negative result about the method, which is the most transferable thing here.** The obvious way
to make the choice-freeness claim machine-checkable is `#print axioms`: run it and see whether
`Classical.choice` appears. That does not work over Mathlib, and the file proves it does not by
including a **control**, `probe`, which is nothing but `if x ⊓ y = ⊥ then xᶜ else y`. The audit
reports:

```
'Toesnail.LogicBPI.probe' depends on axioms: [propext, Classical.choice, Quot.sound]
'Toesnail.LogicBPI.approx' ... [propext, Classical.choice, Quot.sound]
'Toesnail.LogicBPI.exists_isPrime_of_enumeration' ... [propext, Classical.choice, Quot.sound]
'DistribLattice.prime_ideal_of_disjoint_filter_ideal' ... [propext, Classical.choice, Quot.sound]
```

(Five constants are audited in the file; four are shown.)

All five agree, control and Zorn-based BPI included. The dependency is inherited from Mathlib's
order hierarchy and separates nothing, so `#print axioms` over Mathlib is not a usable
choice-freeness oracle, and no claim of the form "Lean confirms this proof avoids choice" should be
made in this repo on that basis. The Lean file certifies the *construction*; the ZF argument stays
where it belongs, in section 4.2, as ordinary mathematics.

---

# 10. Surfaced for the owner

Recommendations only. Nothing here has been written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`,
and no verdict has been recorded on your behalf.

1. **Close `id:987e` as a verified negative.** The BPI lead from `logic-z2-grading.md` section 4.3
   is mathematically correct and does not apply to the intended object. Suggested closing text:
   *"BPI is exactly the principle that produces a coherent truth assignment on a general Boolean
   algebra, and is strictly weaker than AC (Halpern and Levy 1971). The Lindenbaum-Tarski algebra
   of any theory in a countable language is countable, and for such an algebra a prime ideal is
   constructed in ZF by enumeration (`LogicBPI.lean`, `enum-prime`). The convergence with the
   origin quote is not real for this architecture. Outcome (b)."*

2. **Decide whether `REVIEW_ME.md id:251e` gets its second half.** It records that dropping AC buys
   no completeness. This pass adds that dropping AC also costs no truth assignment at any layer
   whose language is countable, so "ZF without C" is inert in both directions. Your call whether
   that is recorded there; I have not touched the file.

3. **Consider whether WKL is the thing you actually wanted.** The countable case does have a
   non-trivial principle behind it, and it is weak König's lemma, with the concrete consequence
   that the completion exists but is not computable. If the layered core is meant to say something
   formal about what a lower layer can and cannot certify about an upper one, WKL and the
   computability of completions are the live axis and choice is not.

4. **Tell `logic-models-ensemble.md` that its choice dependency is DC, not BPI.** D4.1 asked
   whether its measure needs more than a point. It needs something else: countable and dependent
   choice, like all measure theory, and DC and BPI are incomparable.

5. **One niche is genuinely open, and you are not in it.** For a language indexed by a
   non-well-orderable set, one constant per real say, the completion really is a BPI-strength
   assertion. Worth one line in `logic-layered-core.md` if a continuum-indexed core language ever
   comes up, and worth nothing before then.

6. **Two attributions were left blank on purpose.** Nothing is cited for Rubin and Scott on the
   Hausdorff-Tychonoff converse, nor for Halpern's pre-1971 ZFA result, because neither could be
   reached. Section 8 records exactly what was and was not fetched. Either one needs a search
   budget rather than a guess.
