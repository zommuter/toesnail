---
title: A scheduler that reads the report triangle
permalink: /dreamed/logic-scheduler-prototype
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself.
>
> The **decision** this file executes is ratified: `D3` of
> [`docs/meeting-notes/2026-09-07-1508-bloch-truth-rulings.md`](../meeting-notes/2026-09-07-1508-bloch-truth-rulings).
> The **code and the conclusions** are not. This essay has no Lean companion, by design: it reports
> a measurement, not a theorem, and there is nothing here to machine-check that running the code
> does not already check better.

## What this is

D3 ruled that the Bloch Truth cluster should stop arguing about its central fork and measure it.
The fork is what the state is a state *of*.

- **Reading (i), the state is over models.** Every such state is diagonal, so the settledness $r$
  equals the truth lean's magnitude, $r = \lvert z \rvert$, and $z = 0$ forces $r = 0$.
  *"Proved undecidable, stop asking"* and *"got nowhere yet, spend more budget"* are therefore
  literally the same report. Nothing can tell them apart.
- **Reading (ii), the state is over epistemic status.** The state is a distribution over
  $\{\text{proved}, \text{refuted}, \text{independent}, \text{open}\}$, with
  $z = p_{\text{pr}} - p_{\text{rf}}$ and $r = 1 - p_{\text{open}}$. Those two situations are now
  the equatorial point $(0,1)$ and the origin $(0,0)$, and are different points.

The question D3 posed: **does a scheduler that can see that distinction actually do better than one
that cannot, and by how much?**

The code is in [`docs/dreamed/scheduler/`](scheduler/). It is stdlib Python, it runs in about
twenty seconds on one core, and everything runs under
[`capped.sh`](capped.sh), the systemd-scope memory and CPU guard the rest of this directory uses.
Run it with `docs/dreamed/scheduler/run.sh`.

**Read the stipulation before the numbers.** This is a simulation. The `independent` label is
attached when the corpus is generated; it is not discovered by a prover. So the experiment tests
whether the *interface* is actionable given reports of that shape. It does not test, and cannot
test, whether real provers can produce such reports. Everything below inherits that boundary.

## 1. What was built

### 1.1 The core is a terminating checker, not a theory

D3's binding design constraint comes from
[`logic-counterfactual-boundary.md`](logic-counterfactual-boundary): a core that cannot interpret
arithmetic **cannot represent proofs at all**, because a proof is a finite sequence and sequences
need pairing, and pairing is the arithmetic cliff. The repair ruled in session was to stop asking
the core to be a complete theory about proofs and make it a *terminating checker* instead. What was
wanted was never completeness. It was decidability of the checking relation.

Concretely, the scheduler gets **decidable equality on opaque atoms and nothing else**. It may ask
"same sentence or not". It may never ask what a sentence says.

### 1.2 That constraint is enforced, not asserted

A comment saying "we do not inspect sentences" is worth nothing, so the constraint is a type plus a
runnable audit.

`core.Handle` is unhashable (`__hash__ = None`), so no dictionary or set anywhere in the scheduler
can be keyed by a sentence. It raises on every comparison operator, so no sort can rank sentences.
It has no accessor for content and its `repr` is the constant string `<sentence>`. Its one private
attribute holds an anonymous `object()`, which teaches nothing to a consumer that reaches for it,
and reaching for it is recorded.

`audit.py` then does three things and prints a verdict:

1. checks that the type structurally refuses hashing, ordering and sorting;
2. runs a real scheduling pass with handle instrumentation switched on and asserts that the set of
   handle operations the scheduler performed is a subset of `{eq}`, and that `eq` is genuinely
   among them (an interface nobody exercises proves nothing);
3. greps `core.py` for the reflection escape hatches (`id(`, `hash(`, `sorted(`, `vars(`,
   `__dict__`, `getattr(`) that would let a Python program get structure out of an opaque object
   anyway.

It reports:

```
[1] opaque handle type: PASS
[2] handle operations performed by a real scheduling run: ['eq']
       PASS: equality only, and equality is actually used
[3] source scan for reflection escape hatches: PASS

AUDIT: PASS
```

The scheduler's single use of equality is to check that the report it just received is about the
sentence it just asked about. That is exactly the **fourth channel**, the report index, that
`logic-counterfactual-boundary.md` found missing from
[`logic-layered-core.md`](logic-layered-core). It is worth noting how small the resulting authority
is: the core can confirm that a report is correctly addressed, and it cannot confirm anything else
about it.

### 1.3 How the two readings are isolated

This is the design point on which the whole experiment stands, so it is stated flatly.

The corpus computes **one** epistemic state per sentence, a point of the four-status simplex. A
*reading* is a pure function from that state to what the scheduler is allowed to see:

- `reading_ii(state)` returns `Report(z, r)`;
- `reading_i(state)` returns `Report(z, abs(z))`.

Reading (i) is implemented as a **projection of reading (ii)'s report**, not as a separate pipeline.
There is one corpus, one epistemic state, one allocation policy, one drop rule, and one code path.
The arms differ in one function of two floats and in nothing else. Any difference in the measured
outcome is therefore a difference of what the interface can express.

The shared drop rule is likewise one rule, used verbatim by both: stop working on a sentence when
its report has $r = 1$, and count it as settled only if $\lvert z \rvert = 1$.

Both optional policies, the timeout and the purchase of an independence proof, are offered to
**every** arm, including the ones that cannot benefit. That is deliberate. An arm that shows an
advantage must not be able to owe it to a policy its rival was denied.

### 1.4 The corpus

Fifty sentences per corpus, seeded Monte Carlo, base seed `20260907`, forty seeds per cell. Hidden
statuses:

| Status | Behaviour |
|---|---|
| `provable` | settles to $z = +1$ once $d$ units of ordinary search are spent on it |
| `refutable` | settles to $z = -1$ once $d$ units are spent |
| `independent` | never settles under ordinary search, at any budget. A separate independence attempt, costing `check_cost`, succeeds on it |
| `coin` | decidable, and it says so cheaply, but its verdict still costs the full $d$. In between it reports $(z,r) = (0,1)$: the same point as proved-independent |

Difficulties are exponential with mean 40 by default, and Pareto with $\alpha = 1.5$ and the same
mean as a robustness check. The baseline total budget is 2500 units, so the per-sentence share is
50, slightly above the mean difficulty. That is the interesting regime: not so poor that nothing
settles, not so rich that everything does.

The independence attempt is modelled the way forcing actually behaves. It is a separate purchase, it
is bought once per sentence after that sentence has resisted `trigger` units of ordinary search, and
**it can fail**. Spent on a merely hard decidable sentence it returns nothing and the money is gone.
Reading (i) is offered the same purchase, and the point of offering it is that reading (i) cannot
act on the answer: the projection turns the returned $(0,1)$ into $(0,0)$, which is what it already
had.

## 2. The prediction, and both ways it fails

The prediction registered in advance was: the two schedulers are identical when the corpus has no
independent sentences, and (ii) wins by a margin that grows with the independent fraction.

Measured, at the baseline price of 80 units per independence attempt, sentences settled per 1000
units of budget:

| independent fraction | (i) | (ii), no purchases | (ii), buying at cost 80 | (i), buying at cost 80 |
|---|---|---|---|---|
| 0.00 | 19.98 | 19.98 | 17.57 | 17.57 |
| 0.10 | 17.51 | 17.51 | 14.63 | 14.58 |
| 0.20 | 14.83 | 14.83 | 12.88 | 12.85 |
| 0.30 | 12.35 | 12.35 | 11.11 | 11.09 |
| 0.50 | 8.21 | 8.21 | 7.94 | 7.94 |

**The first half of the prediction holds, and is sharper than expected.** At zero independent
sentences, (i) and (ii) agree to every digit. They also agree at *every* independent fraction as
long as nobody buys an independence proof, because until someone pays, an independent sentence
reports $(0,0)$ under both readings. The distinction reading (ii) can express does not exist in the
data by itself. **It has to be manufactured, and manufacturing it is the whole cost.**

**The second half fails outright at this price.** Reading (ii) does not win by a growing margin. It
*loses at every fraction*, including at 0.50, where independents are half the corpus. At an
independent fraction of zero it loses by 12 percent, spending 760 budget units on forcing attempts
of which, necessarily, not one could succeed.

The mechanism is visible in the money. At an independent fraction of 0.10, reading (ii) spent 300
units on attempts that hit and **504 units on attempts that missed**: 63 percent of the independence
budget was spent on sentences that were merely hard. It bought down the ordinary search wasted on
independents from 821 units to 304, a saving of 517, and paid 804 for the privilege.

The saving itself is real and grows the right way. Ordinary search burned on sentences that can
never settle, mean units out of 2500:

| independent fraction | (i) | (ii) |
|---|---|---|
| 0.10 | 821.1 | 304.2 |
| 0.20 | 1073.5 | 619.2 |
| 0.30 | 1303.5 | 929.1 |
| 0.50 | 1711.8 | 1537.0 |

At an independent fraction of 0.10, reading (i) spends a third of its entire budget on five
sentences it will never settle. That is exactly the pathology D3 named. Reading (ii) cuts it by 63
percent. It just does not cut it cheaply enough.

## 3. The economic question, which is the answer

So the useful number is not "does (ii) win". It is **how cheap an independence proof has to be
before (ii) wins**. That converts a philosophical fork into an engineering threshold, and it is the
most useful thing this prototype produces.

Sweeping the price of one independence attempt and interpolating the crossing:

| independent fraction | trigger 20 | trigger 40 | trigger 60 |
|---|---|---|---|
| 0.20 | 23 units | 25 units | 22 units |
| 0.40 | 29 units | 23 units | 12 units |

**Break-even is between 12 and 29 budget units, against a mean ordinary proof cost of 40.** An
independence proof must cost roughly **a third to three quarters of an ordinary proof** before
reading (ii) is worth having at all.

That is a demanding threshold, and it points the wrong way for the intuition that motivated the
fork. Forcing is not cheap. The premise everyone in this cluster has been working from is that
independence proofs are *harder* than ordinary proofs, not cheaper by a factor of two. On that
premise, and at this budget, reading (ii) does not pay.

The curve has a shape worth stating, because it looks like a second crossing and is not. Above the
break-even, reading (ii)'s performance falls, bottoms out, and then climbs back towards reading
(i)'s. That is not the interface recovering. A check the scheduler cannot afford is simply not
bought, so an extremely dear reading (ii) degenerates into reading (i) by never exercising the
thing that distinguishes it. At a price of 960 against a budget of 2500 only two attempts are
affordable in a whole run.

### 3.1 The scissors

Sweeping the budget as well as the independent fraction, and comparing reading (i) against the best
reading (ii) could ever be (told for free which sentences are independent):

| budget | independent fraction | (i) settles | (ii) at cost 0 | gain | break-even | break-even / mean proof cost |
|---|---|---|---|---|---|---|
| 1500 | 0.10 | 33.17 | 36.77 | +10.9 % | 4 | 0.11 |
| 1500 | 0.50 | 15.45 | 23.62 | +52.9 % | 11 | 0.27 |
| 2500 | 0.10 | 43.77 | 45.00 | +2.8 % | 18 | 0.44 |
| 2500 | 0.50 | 20.52 | 25.00 | +21.8 % | 30 | 0.74 |
| 4000 | 0.10 | 45.00 | 45.00 | +0.0 % | 40 | 1.00 |
| 4000 | 0.50 | 23.77 | 25.00 | +5.2 % | 60 | 1.51 |

The two halves of the table move against each other, and that is the finding.

**The regime where reading (ii)'s distinction is valuable and the regime where you can afford to buy
it do not overlap.** When budget is scarce the distinction is worth up to 53 percent more settled
sentences, and precisely because budget is scarce an independence proof may cost no more than a
tenth of an ordinary one before it stops paying. When budget is plentiful an independence proof may
cost one and a half ordinary proofs, and by then reading (i) has already settled 95 to 100 percent
of what is settleable, so the distinction buys 0 to 5 percent.

Break-even exceeds the cost of an ordinary proof only in the top block, where the gain has already
collapsed below about 5 percent.

Two robustness notes. Under heavy-tailed Pareto difficulties the whole effect shrinks (reading (ii)
at cost 80 loses to reading (i) by 0.7 percent instead of 12 percent at zero independents), because
fewer sentences survive long enough to trigger a wasted purchase. And the numbers are not sampling
noise: per-run settled counts have a standard deviation of 2.36 sentences, giving a standard error
of 0.37 on a forty-seed cell mean, and quadrupling the sample to 160 seeds leaves the interpolated
break-even unchanged at 26.8.

## 4. Pricing the known conflation

[`logic-simplex.md`](logic-simplex) and
[`logic-models-vs-epistemic.md`](logic-models-vs-epistemic) established, and machine-checked as
`report_conflates`, that the point $(0,1)$ has **two** inhabitants: *proved independent*, and
*certainly decided with no idea which way*, which is Ellsberg's known-fair coin. That is a real
defect of the two-number report, and a prototype is the right place to price it rather than deplore
it.

Coin sentences were added to the corpus, holding the independent fraction at 0.20. A coin is
decidable, advertises that after three units, and thereafter reports $(0,1)$. A third arm, an
oracle that sees the whole four-vector and can therefore separate the two inhabitants, is included
purely as the yardstick.

Settled per 1000 units:

| coin fraction | (i) | (ii) | oracle |
|---|---|---|---|
| 0.00 | 14.83 | 12.88 | 12.88 |
| 0.10 | 14.83 | 11.35 | 12.88 |
| 0.20 | 14.83 | 10.01 | 12.88 |
| 0.30 | 14.82 | 8.81 | 12.88 |

Coin sentences actually settled, of those present:

| coin fraction | present | (i) | (ii) | oracle |
|---|---|---|---|---|
| 0.10 | 5 | 4.72 | 0.42 | 4.25 |
| 0.20 | 10 | 9.40 | 0.90 | 8.30 |
| 0.30 | 15 | 13.93 | 1.45 | 12.18 |

**The conflation is not a footnote. It is the largest single effect measured here.** At a coin
fraction of 0.30, reading (ii) settles 1.45 of the 15 coin sentences. The oracle settles 12.18. The
cost is 4.07 settled sentences per 1000 units, which is 32 percent of what the oracle manages on the
same corpus, and it is a straight consequence of the drop rule acting on a point the interface
cannot resolve.

There is a sting in it. **Reading (i) is immune.** It settles 13.93 of 15, better than the oracle,
because it cannot see $r$ at all and therefore cannot be misled by a sentence that advertises
certainty it does not have. The defect is a defect of *having* the extra distinction while lacking
the resolution to use it safely. This is the clearest case in the cluster of a richer interface
being actively worse than a poorer one, and it is not a subtlety of the geometry. It is a scheduler
throwing away decidable work.

The repair is known and is outside the two-number report: report all four simplex weights.
`logic-simplex.md` §2.4 already says so, and prices it at one extra number. What this prototype adds
is the operational size of the bill for not paying that one number.

## 5. What the architecture constraint forced me to report rather than code around

Two things. Both are findings about the design, not obstacles that were worked around, and per D3
they are surfaced rather than dissolved by quietly widening the interface.

### 5.1 The interface carries three or four distinct values in an entire run, and no gradient at all

Instrumenting a whole run and collecting every distinct report value ever emitted:

- reading (i): **3** values, $(-1,1)$, $(0,0)$, $(1,1)$;
- reading (ii): **4** values, those three plus $(0,1)$.

Every unsettled sentence reports exactly $(0,0)$, forever, until the instant it settles. There is no
partial credit, no "getting warmer", no ordering.

The consequence is severe and I could not code around it. **No informed prioritisation is possible.**
A scheduler cannot prefer one unsettled sentence to another, because on the evidence available they
are the same. It cannot even break a tie on evidence, because there is no evidence. Round-robin is
not a lazy baseline chosen for simplicity; within this interface it is very nearly the only thing
there is, and the alternatives differ only in the *shape* of the sharing, never in its *targeting*.

I tested this rather than asserting it, and the test produced the sharpest single result in the run.
An abandon-and-revive policy (drop a sentence after `trigger` units, bring it back with a doubled
bound when nothing else is left) **ties plain round-robin to every printed digit, at every trigger
value tried, at every independent fraction**. That is not a coincidence: a shared deepening bound
with equal quanta is a permutation of equal sharing, and it settles the same sentences with the same
budget. Stated carefully, this is measured for this settling model (a sentence settles at a
threshold), not proved in general. But it means the obvious cheap repair for reading (i), "just time
out the stubborn ones", **buys exactly nothing** under a fixed budget. There is nothing better to
move the budget to.

This is worth putting next to the fork itself. The reason reading (ii) can help at all is not that
it enables smarter scheduling. It is only that it enables *permanent removal*. That is a narrower
claim than the cluster has been making, and it is the claim the numbers support.

### 5.2 The core cannot tell a fair coin from an independence proof, and cannot be given a heuristic that would

The natural engineering fix for section 4 is a heuristic: treat a $(0,1)$ report with suspicion if
the sentence looks like the kind that has a decision procedure. Every version of that sentence
requires inspecting the sentence, which is precisely what the arithmetic cliff forbids. The core has
handle equality. It has no syntax, no subformula relation, no class membership, no way to ask
whether two sentences are instances of one schema.

So the conflation is not repairable *inside* the core at any price. It is repairable only by the
reporter sending a richer report, which is a change to the interface and therefore an owner
decision, not a scheduler improvement. Surfaced as item 3 below.

## 6. One methodological correction, recorded because it changed the answer

The first version of the experiment had no revival: a timed-out sentence was gone for good. That
version made the timeout arm look terrible (it settled 16.60 against round-robin's 37.08 at trigger
20) and it made reading (ii) look artificially cheap. Both were the same artifact. With everything
abandoned early, the run was **leaving up to a third of its budget unspent** (1643 of 2500 units in
one measured cell), so a scheduler that spent 806 units on independence attempts, 506 of them
failures, paid nothing for them: it was spending money that had nowhere else to go, and the arms
were not budget-limited at all.

Adding revival made the budget binding for every arm, and the conclusion moved: the timeout arm went
from disastrous to exactly tied, and reading (ii) went from cheaply attractive to losing at the
baseline price. A comparison between two schedulers is void unless both are actually spending the
budget, and the corrected `e1` block now prints budget-actually-spent alongside the results so that
this cannot recur silently.

## 7. What this settles, and what it does not

**Settles, within the simulation:**

- The two readings are **indistinguishable in outcome** unless someone pays to produce the $(0,1)$
  report. The distinction is not free-standing information present in the data; it is a purchase.
- Reading (ii)'s advantage, when bought at a plausible price, is **negative** at the baseline and
  positive only below a break-even of 12 to 29 units against a mean ordinary proof cost of 40.
- The regime where the distinction is worth most is the regime where it is least affordable. The two
  do not overlap.
- The known conflation at $(0,1)$ costs about a third of achievable throughput at a coin fraction of
  0.30, and reading (i) is immune to it.
- Within either interface, no informed prioritisation of unsettled sentences exists, and the obvious
  timeout repair for reading (i) buys nothing.

**Does not settle:**

- **Whether real provers can produce these reports at all.** The `independent` label is stipulated
  by the corpus generator, not discovered. This is the single largest limitation and it is
  structural, not a matter of running more seeds.
- **The real price of an independence proof**, which is the only input the break-even needs and the
  one thing a simulation cannot supply. The prototype converts the fork into a threshold; someone
  still has to measure the quantity on the other side of it.
- **Whether the fork matters for the owner's actual layered core.** The corpus here is a flat bag of
  independent sentences with no logical relations between them. A real theory has sentences that
  imply one another, so settling one settles others, and none of that structure is representable in
  an interface with handle equality only. That is a finding about the architecture, not about the
  fork.
- **Anything about the geometry.** D1 already ruled the ball to be exposition and the triangle to be
  the object. This prototype takes the triangle as given and never touches the question.
- **Whether reading (i) or reading (ii) is *true*.** It measures which is *actionable*, at what
  price. Those are different questions, and the second does not answer the first.

# Surfaced for the owner

Each item is a located claim plus the ruling it needs. Nothing here has been written into
`TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`, and a delegated agent's verdict is a recommendation,
never a settled decision.

1. **The fork's practical content is smaller than the cluster has been saying, and it is a purchase
   rather than a distinction.** Located: §2, first table. Readings (i) and (ii) agree to every digit
   at every independent fraction until someone pays for an independence proof, because until then an
   independent sentence reports $(0,0)$ under both. **Ruling needed: does the project accept that
   the fork's operational content is entirely "is an independence proof worth buying", or does it
   claim some further difference that this prototype failed to model?**

2. **Break-even says reading (ii) does not pay at any plausible price for forcing.** Located: §3,
   12 to 29 units against a mean ordinary proof cost of 40. Every essay in this cluster has assumed
   independence proofs are dearer than ordinary proofs, not one third to three quarters the price.
   **Ruling needed: accept the threshold and treat reading (ii) as unfunded until someone measures a
   real independence-proof cost, or reject the cost model?** The purchase here is one-shot and
   all-or-nothing; a cheap partial independence *signal* is not modelled and might change the
   answer.

3. **The conflation costs a third of throughput, and reading (i) is immune to it.** Located: §4.
   Reading (ii) settles 1.45 of 15 coin sentences where reading (i) settles 13.93. The repair,
   reporting all four simplex weights instead of $(z,r)$, is `logic-simplex.md` §2.4's, costs one
   number, and is an interface change and therefore yours. **Ruling needed: is the two-number report
   the object, or is the four-weight simplex point the object with $(z,r)$ merely its picture?** D1
   ruled on the ball versus the triangle; it did not rule on the triangle versus the simplex.

4. **The interface admits no prioritisation, only removal.** Located: §5.1. Three or four distinct
   report values exist in an entire run, and abandon-and-revive ties plain round-robin exactly.
   Whatever a layered core is for, it is not for scheduling cleverly. **Ruling needed: is
   "permanently remove a sentence from the queue" the whole of the intended benefit? If yes, the
   report only ever needed one bit, and the geometry is decoration.**

5. **The corpus has no logical relations, and the architecture forbids adding them.** Located: §7.
   Real sentences imply one another; settling one settles others. That structure cannot be expressed
   to a core holding opaque atoms with equality only, so the prototype cannot model it and neither
   can the design D3 ratified. **Ruling needed: is a core that cannot know that $\varphi$ implies
   $\psi$ still the core you want, or does the arithmetic cliff need to be crossed somewhere with a
   partial reflection schema (Harrison, SRI CRC-053, 1995), as `logic-layered-core.md` proposes?**

6. **A comparison of schedulers is void unless both are budget-limited.** Located: §6. The first
   version of this experiment left up to a third of the budget unspent and inverted two of its own
   conclusions. Not a physics question, but it is the kind of error that would survive review in a
   result table, so it is recorded rather than quietly fixed. **No ruling needed; noted for the
   method file.**

# Follow-up leads

1. **Measure a real independence-proof cost.** The break-even is now a number waiting for its
   counterpart. Even a crude figure from the literature on forcing-based independence results,
   against a comparable measure for ordinary proof search, would decide item 2 outright.
2. **Model a partial independence signal.** The purchase here is one-shot and all-or-nothing. A
   cheap, unreliable "this smells independent" report is a different economic object and the
   break-even may be far friendlier to it. It also fits the report triangle naturally: it is an
   interior point rather than a vertex.
3. **Run the four-weight report as a fourth arm.** The oracle arm here has full information, which
   is not a proposal. The four-weight simplex point is a proposal, it costs one number, and section
   4 says exactly how much it would recover.
4. **Add implication structure and see what breaks.** Not to fix the scheduler, but to measure how
   much of a real corpus's settleable work is invisible to a core that cannot relate two sentences.
   That number bounds what the D3 architecture can ever be worth.
