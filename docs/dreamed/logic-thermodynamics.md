---
title: A thermodynamics of proof search
permalink: /dreamed/logic-thermodynamics
---

# A thermodynamics of proof search

> **DREAMED, UNREVIEWED, AND PARTLY INVENTED ON PURPOSE.**
> This file is AI-generated exploration under [`docs/dreamed/`](./). It is not owner-authored,
> not reviewed, and carries no authority. See [`docs/dreamed/README.md`](README.md).
>
> **This essay deliberately invents physics-shaped objects.** A proof temperature, a proof
> partition function, a proof-branching factor and a critical proof temperature are all
> **[INVENTED]** here. They are named after real thermodynamic quantities because they are
> defined by the same formulas, not because anyone has shown that a prover is a thermal
> system. Every invented object is marked inline with **[INVENTED]** and listed in
> [§10, the Inventory of Invented Objects](#10-inventory-of-invented-objects).
>
> **No citation in this essay is invented.** Every reference below was checked against a
> bibliographic record in this session (Crossref, INSPIRE, or the arXiv abstract page), and
> where a check failed or was not attempted, the text says so in that spot. Numerical
> values that were not verified against a primary text are flagged at the point of use.
>
> The `\veq` badges mark only what [`lean/LogicThermo.lean`](lean/LogicThermo.lean)
> discharges. They are claims about that dreamed Lean file, not attestations against the
> repo's `verify` machinery.

---

# 0. The seed, and the hole it leaves

The Bloch Truth cluster built an epistemic state and never gave it dynamics.

[`logic-epistemic-state.md`](logic-epistemic-state.md) put four epistemic statuses on a
simplex, read off a truth lean $z$ and a settledness $r$, and observed that the von Neumann
entropy of the corresponding qubit state is the binary entropy

$$
S(r) \;=\; h\!\left(\frac{1+r}{2}\right),
$$

maximal at the origin $r=0$ and zero at $r=1$. [`logic-simplex.md`](logic-simplex.md) built
the four-vertex object properly and proved that learning, a stochastic map fixing the three
settled vertices, never decreases $r$. It then said, against its own interest, that the
honest object is **a budget-indexed trajectory, not a point**, and that it has no resource
parameter at all. [`logic-models-vs-epistemic.md`](logic-models-vs-epistemic.md) adjudicated
in favour of that reading. [`logic-models-ensemble.md`](logic-models-ensemble.md) reported
the wall a finite prover hits: a coherent probability assignment gives probability 1 to every
theorem, so it cannot be uncertain about a computation at all.

Nobody in that cluster wrote down a dynamics. Three of the essays gesture at one. None
defines a rate, a cost, a temperature, or a schedule. That is the hole, and this essay tries
to fill it with thermodynamics.

The repo makes this a dangerous subject, which is why it is worth doing here. toesnail
already contains careful thermodynamics: [`physics/entropy.md`](../../physics/entropy.md),
the laser-cooling wing, and the dreamed [`lasercool.md`](lasercool.md), which computed an
entropy margin and found the folklore off by four orders of magnitude. So the standard for
this essay is the standard [`lasercool.md`](lasercool.md) set: **compute the margin, in SI
units, with stated assumptions, and report the answer even when it kills the story.**

---

# 1. What already exists, and must not be reinvented

A large part of "a statistical mechanics of search" is real, published science. The owner's
standing instruction is against not-invented-here, so this section reports what exists before
anything is invented. Every item was checked against a bibliographic record in this session.

## 1.1 The random k-SAT phase transition

Random $k$-SAT with $n$ variables and $m = \alpha n$ clauses drawn uniformly has a
**satisfiability threshold** in the clause-to-variable density $\alpha$: below it a random
formula is satisfiable with high probability, above it unsatisfiable with high probability,
and the transition sharpens as $n$ grows.

Every row below was checked against a Crossref, INSPIRE or arXiv record in this session.

| Reference | DOI / id | What it establishes |
|---|---|---|
| Cheeseman, Kanefsky, Taylor, *Computational Complexity And Phase Transitions*, Workshop on Physics and Computation, 63-68 | `10.1109/phycmp.1992.615495` | The easy-hard-easy pattern. Their more cited IJCAI-1991 paper "Where the really hard problems are" did **not** come back from Crossref here; treat that citation as unverified. |
| Selman, Mitchell, Levesque, *Generating hard satisfiability problems*, Artificial Intelligence **81** (1996) 17-29 | `10.1016/0004-3702(95)00045-3` | Hardness concentrated at the threshold. Their AAAI-1992 paper did not come back from Crossref either; this is the record cited. |
| Kirkpatrick, Selman, *Critical Behavior in the Satisfiability of Random Boolean Expressions*, Science **264** (1994) 1297-1301 | `10.1126/science.264.5163.1297` | Finite-size scaling; makes the critical-point analogy explicit. |
| Friedgut (appendix by Bourgain), *Sharp thresholds of graph properties, and the k-sat problem*, J. AMS **12** (1999) 1017-1054 | `10.1090/s0894-0347-99-00305-7` | A sharp threshold *sequence* exists, weaker than and prior to convergence. |
| Monasson, Zecchina, Kirkpatrick, Selman, Troyansky, Nature **400** (1999) 133-137 | `10.1038/22055` | 2+p-SAT: connects the *order* of the transition to the hardness peak. |
| Mezard, Parisi, Zecchina, Science **297** (2002) 812-815 | `10.1126/science.1073287` | Cavity method and survey propagation. |
| Mertens, Mezard, Zecchina, Random Structures and Algorithms **28** (2006) 340-373 | `10.1002/rsa.20090` | Cavity thresholds; the arXiv abstract (`cs/0309020`) scopes the new derivations to $K \ge 4$. |
| Krzakala, Montanari, Ricci-Tersenghi, Semerjian, Zdeborova, PNAS **104** (2007) 10318-10323 | `10.1073/pnas.0703685104` | Clustering then condensation of the solution measure. |
| Ding, Sly, Sun, *Proof of the satisfiability conjecture for large k* | arXiv:1411.0650 | The threshold exists for large $k$ and **matches the 1-RSB prediction**. |
| Pittel, Sorkin, *The Satisfiability Threshold for k-XORSAT*, CPC **25** (2016) 236-268 | `10.1017/s0963548315000097` | The tractable cousin: clustering provable, problem still in P. Clustering alone does not imply hardness. |

**One numeric flagged.** The cavity value usually quoted for random 3-SAT is
$\alpha_c(3) \approx 4.267$. I did **not** verify that decimal against a primary text: the
Mertens-Mezard-Zecchina abstract scopes itself to $K \ge 4$, and neither the
Mezard-Parisi-Zecchina nor the Krzakala et al. abstract quotes a 3-SAT number. Treat it as a
widely repeated value with an unchecked primary source. Nothing here depends on it.

## 1.2 Simulated annealing

Kirkpatrick, Gelatt and Vecchi, *Optimization by Simulated Annealing*, Science **220** (1983)
671-680. Crossref returned this only as a reprint record (`10.7551/mitpress/4943.003.0034`)
whose title string quotes exactly that citation, so venue and pages are **verified
indirectly**. This is the canonical prior art for "put a temperature on a search space and
lower it", and the thing this essay must least pretend to invent: it already has a Boltzmann
distribution over *candidate solutions*, an energy equal to the number of violated
constraints, and a temperature schedule.

## 1.3 The thermodynamics of computation

All verified this session.

| Reference | DOI | What it establishes |
|---|---|---|
| Landauer, IBM J. Res. Dev. **5** (1961) 183-191 | `10.1147/rd.53.0183` | Erasing one bit at temperature $T$ dissipates at least $k_B T \ln 2$. |
| Bennett, *Logical Reversibility of Computation*, IBM J. Res. Dev. **17** (1973) 525-532 | `10.1147/rd.176.0525` | Any computation can be made logically reversible at the cost of an ancilla history, the TOFFOLI-and-ancilla structure [`logic-bloch-gates.md`](logic-bloch-gates.md) already met. |
| Bennett, *The thermodynamics of computation, a review*, Int. J. Theor. Phys. **21** (1982) 905-940 | `10.1007/bf02084158` | The standard review. |
| Berut, Arakelyan, Petrosyan, Ciliberto, Dillenschneider, Lutz, Nature **483** (2012) 187-189 | `10.1038/nature10872` | The Landauer bound has been measured. |
| Lloyd, *Ultimate physical limits to computation*, Nature **406** (2000) 1047-1054 | `10.1038/35023282` | The in-principle limits at the other end. |

## 1.4 The gap this leaves, which is where the invention starts

**All of the statistical mechanics in §1.1 and §1.2 is an ensemble over ASSIGNMENTS to a
FIXED finite formula. None of it is an ensemble over PROOFS.** In random $k$-SAT the
microstate is a truth assignment, the state space is the finite $\{0,1\}^n$, and the energy
is the number of violated clauses: an ordinary finite spin system, which is exactly why the
machinery transfers.

The cluster's object is not that. Its $r$ measures how settled an agent is about a
*sentence*, and the search that settles one runs through **proofs**, not assignments. The
proof space is countably infinite and the energy unbounded. Nothing in §1.1 covers that, and
the difference is not cosmetic: it is the difference between a partition function that always
exists and one that may not. So the invention below is specifically **an ensemble over
proofs**, and §1.1 is inherited only in the decidable propositional special case where a
proof search is an assignment search in disguise.

---

# 2. The invented ensemble, defined properly

A temperature only means something if there is a Boltzmann distribution over something. This
section constructs one, or fails to, and says which.

Fix a proof system $\mathcal{P}$: a finite set of axiom instances and one rule, modus ponens.
A **proof** is a finite binary tree whose leaves are axiom instances and whose internal nodes
are modus-ponens applications on well-typed premises.

- **[INVENTED] Def. 1, proof microstate.** One proof $\pi$. The state space is $\Pi$; the
  set of proofs of a fixed goal $G$ is $\Pi_G \subseteq \Pi$.
- **[INVENTED] Def. 2, proof energy.** $E(\pi) = \lvert \pi \rvert$, the number of
  axiom-instance leaves. Justification, such as it is: length is what a prover spends budget
  on, it is additive under composition, and it is bounded below by 1. Nothing else is forced;
  §7.1 records what a different choice would do.
- **[INVENTED] Def. 3, proof-branching factor $a$.** The growth rate of the density of
  states $N(n) = \#\{\pi : \lvert\pi\rvert = n\}$, namely $a = \lim_n N(n+1)/N(n)$.
- **[INVENTED] Def. 4, inverse proof temperature $\beta$ and proof partition function.**
  $Z(\beta) = \sum_{\pi \in \Pi} e^{-\beta E(\pi)} = \sum_{n \ge 1} N(n) e^{-\beta n}$, with
  $\beta$ in reciprocal proof length and the proof temperature $T = 1/\beta$ in
  axiom-instance leaves.

That is the whole construction, and now it can be broken.

## 2.1 The crux: does $Z$ exist?

For $N(n) = a^n$ the sum is geometric and the answer is exact.

$$
\sum_{n\ge 1} a^n e^{-\beta n} \ \text{converges} \iff \log a < \beta
\veq{partition}\lean
$$

`partition_summable_iff` in [`lean/LogicThermo.lean`](lean/LogicThermo.lean), proved as an
**iff**, so it also proves the divergence half. In temperature language, with $a>1$,

$$
T_c \;=\; \frac{1}{\log a},
\qquad Z(\beta) \ \text{exists} \iff T < T_c
\veq{crit-temp}\lean
$$

(`partition_summable_iff_temp`, `critTemp`).

And the applicable form, since a real proof system's $N(n)$ is only bounded below:

$$
a^n \le N(n) \ \text{for all } n, \quad \beta \le \log a
\;\Longrightarrow\;
\sum_n N(n) e^{-\beta n} \ \text{diverges}
\veq{partition-lb}\lean
$$

`not_summable_of_exp_le`.

**So the answer is: sometimes.** $Z$ exists below a critical temperature and not at or above
it. That is a real result for the analogy, because a finite spin system has no such boundary:
for a random $k$-SAT instance $Z(\beta)$ is a finite sum converging at every temperature,
$\beta = 0$ included. The proof ensemble differs in kind, and the difference is an infinite
state space with unbounded energy.

This is precisely the structure of a **Hagedorn temperature**: an exponentially growing
density of states produces a limiting temperature beyond which the canonical ensemble does
not exist. Hagedorn, *Statistical thermodynamics of strong interactions at high energies*,
Nuovo Cimento Supplemento **3** (1965) 147-186, verified against the INSPIRE record. The
comparison is **structural and exact**, being the same statement about the same kind of
series, and it is a comparison to a feature of hadronic and string spectra, not a claim about
proofs.

## 2.2 The signature: mean proof length diverges at $T_c$

Below criticality, writing $x = a e^{-\beta} \in [0,1)$, the ensemble mean length is

$$
\langle n \rangle \;=\; \frac{\sum_n n\, x^n}{\sum_n x^n} \;=\; \frac{x}{1-x}
\veq{hagedorn}\lean
$$

(`meanLen_eq`), strictly increasing in $x$ (`meanLen_strictMono`), and exceeding every bound
(`meanLen_unbounded`). So as the proof temperature rises to $T_c$ from below the typical
proof grows without limit: the ensemble runs out of finite proofs before it runs out of
temperature. That is the sharpest positive result here, and it is a theorem about geometric
series dressed in invented vocabulary. Its content as *thermodynamics of proof search* rests
entirely on Definitions 1 to 4 being right, and §7 argues that at least one is not.

---

# 3. A concrete tiny example, computed rather than asserted

Assertion is cheap. Here is $N(n)$ for an actual proof system, counted exactly.

**The system.** Implicational fragment over atoms $\{a,b\}$, one rule (modus ponens), axiom
instances $K(X,Y) = X \to (Y\to X)$ and $S(X,Y,Z) = (X\to(Y\to Z))\to((X\to Y)\to(X\to Z))$
for $X,Y,Z$ over the depth-at-most-1 formulas, discarding any formula with more than 9 atom
occurrences (which makes the derivable set finite). That is **76 axiom instances**. Exact
recursion: $N_F(n) = \sum_{i+j=n} \sum_{G} N_{G\to F}(i)\, N_G(j)$. Run under
[`capped.sh`](capped.sh) at `-m 2G -c 100 -t 300` in under a second; the script is not
committed (this essay is two files) and is reproducible from that recipe.

| $n$ | $N_{\text{all}}(n)$ | $N_{a\to a}(n)$ | ratio (all) | ratio ($a\to a$) |
|---:|---:|---:|---:|---:|
| 3 | 4 | 2 | 0.33 | -- |
| 6 | 32 | 4 | 2.67 | 2.00 |
| 10 | 600 | 72 | 2.38 | 2.12 |
| 14 | 13 616 | 1 660 | 2.31 | 2.20 |
| 18 | 351 368 | 43 696 | 2.30 | 2.27 |
| 22 | 9 845 824 | 1 242 484 | 2.32 | 2.32 |
| 26 | 291 382 584 | 37 139 544 | 2.344 | 2.344 |

**Three findings, in order of how much they hurt.**

**(a) The growth is cleanly exponential, with branching factor $a = 2.3445$**, so
$\beta_c = \log a = 0.8520$ and $T_c = 1.174$ axiom leaves. The size bound makes this a
finite system, so $N(n)$ is governed by the Perron root of a finite nonnegative matrix and
exponential growth is expected rather than discovered. Removing the bound would raise $a$ and
could change the prefactor; that case was not computed.

**(b) The branching factor of proofs of ONE theorem equals that of all proofs, to four
digits: 2.3445 against 2.3445.** Perron-Frobenius, and bad news for the analogy: **$T_c$ is a
property of the proof system alone and knows nothing about the sentence being proved.** An
invented temperature whose critical value is identical for every goal cannot be what
distinguishes an easy sentence from a hard one. Whatever it measures, it is not difficulty.

**(c) Whether $Z$ exists exactly at $T_c$ depends on the prefactor, and the two natural
models disagree.** For the matrix-like system above $N(n) \sim C a^n$ and $Z(\beta_c)$
diverges. Count proof *shapes* instead: a tree with $n$ leaves has $C_{n-1}$ shapes, so
$N(n) = C_{n-1} m^n$ with $m = 76$, and

$$
Z(x) = \sum_{n\ge1} C_{n-1} x^n = \frac{1 - \sqrt{1-4x}}{2},
\qquad x = m e^{-\beta}, \quad x_c = \tfrac14,
$$

so $\beta_c = \log(4m) = 5.7170$ and $Z(x_c) = 1/2$, **finite at criticality**, while
$\langle n\rangle = 2x/[\sqrt{1-4x}\,(1-\sqrt{1-4x})]$ still diverges there as
$(1-4x)^{-1/2}$. Two answers to "does $Z$ exist at $T_c$" from the same $\eqref{partition}$
theorem plus a Catalan prefactor. That distinction is real Hagedorn physics (the prefactor
sets the order of the transition), and it means the invented framework carries a free
parameter this essay cannot fix from first principles.

---

# 4. Is $r$ an order parameter? Tested, and the answer is no

**Setup.** Random 3-SAT, $n = 20$ variables, $m = \alpha n$ clauses, 200 instances per point,
fixed seed, DPLL with unit propagation and most-frequent-literal branching, hard node budget
$B$. This maps onto the cluster's four statuses directly: the search returns SAT (proved),
UNSAT (refuted), or exhausts its budget (open), so $r = 1 - P(\text{open})$ and
$z = P(\text{SAT}) - P(\text{UNSAT})$. All runs under [`capped.sh`](capped.sh) at
`-m 2G -c 100 -t 300`.

## 4.1 $r$ against budget: smooth, monotone, no transition

At $\alpha = 4.27$, $r$ against the node budget $B$:

| $B$ | 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 |
|---|---|---|---|---|---|---|---|---|
| $r$ | 0.000 | 0.000 | 0.020 | 0.210 | 0.650 | 0.950 | 1.000 | 1.000 |

A sigmoid in $\log B$, same shape at $\alpha = 2$ and $\alpha = 8$ with a different midpoint.
**There is no transition in budget.** $r$ is a monotone saturating function of the horizon,
which [`logic-simplex.md`](logic-simplex.md)'s `learn_r_mono` already guaranteed. What that
costs the analogy: an order parameter is non-analytic in its control parameter at a critical
value in the thermodynamic limit, and $r(B)$ is none of those things. It is a completion
fraction. **Budget is a horizon, not a control parameter.**

## 4.2 $r$ against clause density: a dip, and it is not monotone

At a fixed budget of 25 nodes:

| $\alpha$ | 2.5 | 3.5 | 4.0 | 4.5 | 5.0 | 5.5 | 6.0 | 7.0 | 9.0 |
|---|---|---|---|---|---|---|---|---|---|
| $r$ | 1.000 | 0.975 | 0.925 | 0.855 | 0.870 | 0.905 | 0.955 | 0.995 | 1.000 |

$r$ dips near $\alpha \approx 4.5$ and returns to 1 on both flanks: the easy-hard-easy pattern
of Cheeseman-Kanefsky-Taylor and Kirkpatrick-Selman, reproduced. Raise the budget to 60 nodes
and the dip vanishes entirely. So $r$ at fixed budget is a **hardness proxy**, non-monotone
in $\alpha$ and budget-dependent in a way an order parameter must not be. Directly
confirming: mean nodes to settle at unlimited budget peaks at $\alpha \approx 4.5$ to $5.5$
(17.9 nodes) against 10 to 11 on either flank.

## 4.3 The order parameter is $z$, not $r$

The truth lean $z = 2P(\text{SAT}) - 1$ at full budget, across five system sizes, 300
instances per point:

| $\alpha$ | $n{=}10$ | $n{=}20$ | $n{=}30$ |
|---:|---:|---:|---:|
| 3.50 | 0.913 | 0.960 | 0.987 |
| 4.00 | 0.700 | 0.700 | 0.660 |
| 4.25 | 0.580 | 0.333 | 0.340 |
| 4.50 | 0.393 | 0.067 | -0.087 |
| 4.75 | 0.080 | -0.140 | -0.327 |
| 5.00 | -0.053 | -0.427 | -0.593 |
| 5.50 | -0.360 | -0.787 | -0.913 |

Textbook finite-size sharpening: the zero crossing drifts down from $\alpha \approx 4.9$ at
$n=10$ to $\alpha \approx 4.45$ at $n=30$ and the curve steepens monotonically with $n$
(the omitted $n = 15$ and $n = 25$ columns interpolate). A small-$n$ reproduction of
Kirkpatrick and Selman 1994, not a new result, and the drift is consistent with a limit near
the commonly quoted 4.267 without being evidence for that decimal.

**The finding.** In the cluster's own coordinates, **the random $k$-SAT phase transition is a
transition in the truth lean $z$, not in the settledness $r$.** $z$ sharpens with system size
and becomes non-analytic in the limit; $r$ does not, and at fixed budget it is non-monotone
in the same control parameter. The cluster's intuition that $r$ is the "how much do we know"
axis and therefore the interesting one points at the wrong coordinate for the one phase
transition this subject has.

Sceptical caveat: at $n \le 30$ these are not asymptotics, and consistency with a known
result is weak evidence.

---

# 5. The second law question, in SI units

Learning increases $r$, which decreases the report entropy $S = h((1+r)/2)$ from $\ln 2$ to
zero. That violates nothing: the prover does work and dissipates heat. But toesnail is a repo
where entropy accounting is done properly, so here is the accounting.

**Assumptions, stated.** $T = 300$ K ambient, $k_B = 1.380649\times10^{-23}$ J/K, and one
core of this machine plus its share of package power taken as 20 W, a deliberately generous
low estimate for a laptop core under sustained load. Landauer floor per erased bit:
$k_B T \ln 2 = 2.871\times10^{-21}$ J $=$ 2.871 zJ. **Measurement:** the Lean file
accompanying this essay checks in 1.7 s of CPU time (measured this session under
`capped.sh`), so $E \approx 34$ J.

**Accounting 1: per settled sentence.** Settling one sentence takes the report from $r=0$ to
$r=1$, exactly one bit. Minimum 2.871 zJ, actual 34 J, **ratio $1.18\times10^{22}$.**

**Accounting 2: per erased bit, generously.** The report bit is not the erasure a prover
actually performs; a prover erases scratch. Bound it from above rather than guessing:

| erasure assumption | Landauer floor | ratio to 34 J |
|---|---|---|
| $10^9$ bits of scratch erased | $2.87\times10^{-12}$ J | $1.2\times10^{13}$ |
| the whole 4 GiB cap erased once | $9.19\times10^{-11}$ J | $3.7\times10^{11}$ |
| the whole 4 GiB cap erased every second | $1.56\times10^{-10}$ J | $2.2\times10^{11}$ |

**Accounting 3: a whole library.** The vendored Mathlib in `verify/.lake/packages/mathlib`
contains 163 460 lines beginning `theorem` or `lemma` (counted this session). A full build at
2 to 6 CPU-hours and 20 W is $1.4$ to $4.3 \times 10^5$ J, so **0.88 to 2.6 J per theorem**,
which is $3$ to $9\times10^{20}$ times the one-bit Landauer floor. The build time is an
assumption, not a measurement, and the line count is a proxy (declarations, not distinct
facts).

**Verdict on Landauer.** Not binding, and not close. For the bound to reach 34 J one would
have to erase $1.2\times10^{22}$ bits, which is $1.5\times10^{9}$ terabytes. Compare
[`lasercool.md`](lasercool.md), where the second-law margin for Doppler cooling of Rb87 came
out at roughly $10^3$ and therefore genuinely constrains the physics. **Here the margin is 11
to 22 orders of magnitude depending on how you count, and the second law places no constraint
on proof search that anyone will ever notice.** Same method as
[`lasercool.md`](lasercool.md), opposite sign: there the computed margin made the physics
interesting, here it makes it vacuous. An essay that wanted the analogy to work would leave
this section out.

One caveat the other way. The 20 W is dominated by CMOS leakage and clock distribution, not
by logical irreversibility, so this says "current hardware is astronomically far from the
bound", not "the bound is uninteresting in principle" (Lloyd 2000 makes the in-principle case
at the other end). What it does establish is what this essay needs: **no budget-allocation
rule for a real prover can be derived from thermodynamic cost, because thermodynamic cost is
not the binding constraint.**

---

# 6. Undecidability as a phase: argued for one reading, against two

This is the speculative core, and it is labelled as such. Three candidate readings.

## 6.1 Reading A: an undecidable sentence never equilibrates

**Rejected as a simile.** "It never halts" and "it never equilibrates" share a word and
nothing else. Equilibration is a stochastic process converging to a stationary distribution;
non-halting is a deterministic machine having no final configuration. To make this more than
a pun one would need a shared structure: a Markov process whose mixing time is provably
infinite exactly when the sentence is undecidable. Nobody has one, this essay does not, and
words rhyming is not evidence. Call it a simile.

## 6.2 Reading B: an undecidable sentence is a glass

**Rejected, with a reason.** A glass **has** a Gibbs measure and cannot reach its ground
state in accessible time: the measure shatters into exponentially many pure states separated
by barriers. That is the Krzakala et al. clustering picture, and it is real in random CSPs.

But an unprovable sentence has no proofs, so the constrained ensemble $\Pi_G$ is **empty**,
the Boltzmann weights sum to zero, and there is no normalised distribution at all:

$$
\Pi_G = \emptyset \;\Longrightarrow\; \sum_{\pi \in \Pi_G} e^{-\beta E(\pi)} = 0 \ne 1
\veq{empty-ensemble}\lean
$$

`no_normalisation_of_empty` and `tsum_weights_of_empty`. A glass is slow; this is absent.
Different failures, and the glass vocabulary hides the difference.

The Lean statement is deliberately weak and the essay must say so: it is a fact about the
empty index type, and reading "empty proof set" as "undecidable sentence" is a step Lean does
not take. A merely unproved theorem also has an empty *found*-proof set, and a refutable
sentence has an empty proof set while being perfectly decidable. The theorem separates "no
Gibbs measure" from "slow Gibbs measure"; it does not characterise undecidability.

## 6.3 Reading C: undecidability has no thermodynamic analogue here, and the divergence that looks like one is about something else

**This is the reading argued for.**

The one phase-transition-like structure this essay found is the Hagedorn temperature of §2.
Look at what it requires: an exponentially growing density of states over an infinite proof
space. It requires **nothing** about undecidability. The tiny Hilbert system of §3 is
decidable in the relevant sense (its derivable set is finite by construction and its proof
count is a finite matrix power), and it has the divergence anyway. Conversely, an undecidable
sentence contributes an empty ensemble, which is not a divergence but its opposite.

So the thermodynamic structure and the undecidability are **independent**. The temperature
diverges for reasons of counting; the sentence is undecidable for reasons of logic; and no
computation here connects them. Dressing incompleteness in phase language would borrow the
credibility of §2's theorem for a claim §2's theorem does not support.

## 6.4 Where undecidability and phases genuinely do meet, which is not here

One real place: Cubitt, Perez-Garcia and Wolf, *Undecidability of the spectral gap*, Nature
**528** (2015) 207-211, DOI `10.1038/nature16059`, **verified**, with the longer Forum of
Mathematics Pi **10** (2022) version, DOI `10.1017/fmp.2021.15`, also verified. Whether a
translationally invariant lattice Hamiltonian is gapped is undecidable, so a genuine
thermodynamic-limit property is genuinely undecidable. The honest reading, which
[`weltformel-impossibility.md`](weltformel-impossibility.md) already applies to the Faizal
papers: the undecidability belongs to a **family** of Hamiltonians indexed by a Turing
machine, not to a phase of one system. Even the best real instance licenses only "phase
questions can be undecidable", the converse and much weaker.

---

# 7. Attacking the construction

Four attacks, in descending order of damage.

**7.1 The energy is a stipulation, and a different one changes everything.** Definition 2
takes $E(\pi) = \lvert\pi\rvert$. Take instead $E(\pi) = \log(\text{search cost of finding }
\pi)$, or the Kolmogorov complexity of $\pi$, and $N(n)$ changes, $a$ changes, and $T_c$
changes. Nothing in this essay derives the energy; it picks one and computes with it. This is
the attack most likely to succeed, because a thermodynamics whose energy function is a free
choice is a family of formalisms, not a theory.

**7.2 The ensemble is never sampled.** A statistical mechanics earns its name when the system
actually visits states with Boltzmann probabilities. Simulated annealing does, being a
Metropolis chain by construction. No proof search visits proofs with probability
$\propto e^{-\beta|\pi|}$: a resolution prover, a tableau prover and Lean's elaborator all do
something else entirely. So $Z$ here is a **generating function** of the proof-length
distribution, a real and useful object wearing a thermodynamic name it has not earned. That
is the honest deflation of §2, and it is not fatal only because generating functions are
genuinely informative.

**7.3 $T_c$ knows nothing about the goal (§3b).** The measured branching factor is identical
for one theorem and for all theorems, to four digits, as Perron-Frobenius requires. Any
reading in which "hard sentences are near criticality" is dead on arrival: all sentences
share the same criticality.

**7.4 The one quantitative bridge to physics is vacuous (§5).** The Landauer margin is
$10^{11}$ to $10^{22}$, so the connection is formal (the same series appear) and not physical
(no physical quantity is bounded by anything).

**What survives all four.** $\eqref{partition}$ and the divergence of $\langle n\rangle$ at
$T_c$, because they are theorems about series and do not depend on any disputed
identification. Stripped of vocabulary: *the generating function of proof lengths has a finite
radius of convergence, and the mean length under an exponential tilt diverges as the tilt
approaches that radius.* True, useful, and containing no physics.

---

# 8. Does it give the layered core anything operational?

The brief asked whether this buys the owner's layered architecture
([`logic-layered-core.md`](logic-layered-core.md)) a principled budget-allocation rule. Here
is the most that can be claimed, with its weakness in the same breath.

**The rule.** Let a layer's proof-length distribution be $p(n) \propto N(n) e^{-\beta n}$
with measured branching factor $a$ and a tilt $\beta > \log a$ fitted from previously found
proofs. Then $\langle n\rangle = x/(1-x)$ with $x = ae^{-\beta}$: allocate budget
$\propto \langle n \rangle$, and **refuse to allocate at all when the fitted $x$ exceeds a
threshold**, because $\eqref{hagedorn}$ says the mean length is then diverging and the budget
buys into a distribution with no finite scale.

**Why that is worth less than it sounds.** Three reasons, all located above.

1. It restates "estimate the proof-length distribution and budget by its mean", which needs
   no thermodynamics. The temperature is a fitted parameter of a geometric distribution.
2. By §7.3, $a$ is a constant of the proof system, so the rule cannot rank two sentences
   within one layer. It ranks only *layers*, a much coarser instrument than the core needs.
3. By §4, the quantity that moves at the one real phase transition is $z$, not $r$, and the
   rule above is expressed in $r$.

**One operational item does survive, and it is not thermodynamic.** §4.2's dip is real: at
fixed budget, $r$ is minimised at the hardness peak and returns to 1 on both flanks. A
scheduler that measures $r$ at two budgets and sees it *not* rising is looking at an instance
near a threshold, and the right response is to change the encoding or the layer rather than
to buy more budget. That is usable, it is fully explained by the 1994 Kirkpatrick-Selman
literature, and it required none of this essay's inventions.

---

# 9. Verdict

**A thermodynamics of proof search is a costume worn over one real theorem.**

Ranked, with the weaknesses attached:

- **Theory: no.** That would need a derived energy function, an ensemble the system actually
  samples, and a physical quantity bounded by a physical law. None of the three (§7.1, §7.2,
  §7.4).
- **Useful heuristic: partly, and less than the existing literature gives.** The transferable
  rule (§8) is a geometric-distribution fit. The genuinely useful heuristic here is the
  easy-hard-easy dip, which is 1991 to 1994 prior art.
- **Costume: mostly yes, and dangerous in this repo specifically.** Calling
  $\sum_n N(n)e^{-\beta n}$ a partition function and $1/\beta$ a temperature invites the
  reader to import the second law, equipartition and free-energy minimisation, none of which
  is available. §5 is the proof: the second law is 11 to 22 orders from binding.
- **Worth keeping:** $\eqref{partition}$ with $\eqref{hagedorn}$, stated without the costume.
  The proof-length generating function has a finite radius of convergence set by the
  branching factor, the mean length diverges there, and the radius is a constant of the proof
  system rather than of the goal. A machine-checked fact about proof systems that does not
  mention heat.

**Recommendation to the owner:** do not adopt thermodynamic vocabulary for the layered core.
Adopt the generating function, which is the mathematics, and drop the temperature, which is
the costume. If the vocabulary is kept anyway (and there is a real argument, namely that
Hagedorn structure is genuinely what this is), §5 must travel with it as a permanent
disclaimer, because the repo's existing thermodynamics is careful and a loose usage beside it
would be read as a claim.

---

# 10. Inventory of Invented Objects

Everything in this list was invented in this essay. None of it is established terminology for
proof search, none of it is owner-authored, and none of it is claimed to be physics.

1. **Proof microstate**, a single proof $\pi$ (§2, Def. 1). Prior art exists for microstates
   as *assignments* (§1.1); as *proofs*, no prior art found in this session's searches.
2. **Proof energy $E(\pi) = \lvert\pi\rvert$** (§2, Def. 2). A stipulation, attacked in §7.1.
3. **Proof-branching factor $a$** (§2, Def. 3). The quantity is standard combinatorics;
   calling it the branching factor of a thermodynamic density of states is the invention.
4. **Inverse proof temperature $\beta$, proof temperature $T = 1/\beta$**, in reciprocal
   axiom leaves (§2, Def. 4).
5. **Proof partition function $Z(\beta)$** (§2, Def. 4). Mathematically the generating
   function of the proof-length distribution under an exponential tilt, which is standard;
   the thermodynamic name is the invention.
6. **Critical proof temperature $T_c = 1/\log a$** (§2.1). Elementary theorem, invented name.
7. **The Hagedorn reading of $T_c$** (§2.1, §2.2). The structural comparison is exact; the
   application to proofs is invented. Hagedorn's own 1965 paper is real, cited, and about
   hadrons.
8. **The identification of the cluster's $r$ with an order parameter** (§4). Invented in
   order to be tested, and the test **refuted** it.
9. **"Undecidability as a phase"** (§6). Invented; three readings, two rejected, and the
   survivor is that there is no analogue.
10. **The budget-allocation rule of §8.** Invented, and deflated in the same section.

Not invented, and cited: everything in §1, plus Cubitt-Perez-Garcia-Wolf (§6.4) and Hagedorn
(§2.1).

---

# 11. What Lean discharges

[`lean/LogicThermo.lean`](lean/LogicThermo.lean), checked this session with
`lake env lean --threads=1` under `capped.sh -m 4G -c 100`, **exit code 0, zero `sorry`, no
warnings**.

| Handle | Lean name | Statement |
|---|---|---|
| `partition` | `partition_summable_iff` | $\sum_n a^n e^{-\beta n}$ summable $\iff \log a < \beta$. An iff, so it proves divergence too. §2.1. |
| `crit-temp` | `partition_summable_iff_temp`, `critTemp` | The same in temperature language for $a>1$: converges iff $T < T_c = 1/\log a$. §2.1. |
| `partition-lb` | `not_summable_of_exp_le` | A lower bound $a^n \le N(n)$ suffices for divergence at $\beta \le \log a$. §2.1. |
| `empty-ensemble` | `no_normalisation_of_empty`, `tsum_weights_of_empty` | An empty proof set carries no normalised Gibbs state. §6.2. |
| `hagedorn` | `meanLen_eq`, `meanLen_strictMono`, `meanLen_unbounded` | $\langle n\rangle = x/(1-x)$, strictly increasing, unbounded as $x \to 1^-$. §2.2. |

Deliberately **not** re-proved: the antitonicity of $h((1+r)/2)$ in $r$, already discharged in
[`lean/LogicEpistemic.lean`](lean/LogicEpistemic.lean) as `settledEntropy_strictAntiOn`.
Restating it would pad the attestation without adding assurance. Deliberately **not**
formalised: §4's SAT numbers (simulations), §3's measured $a = 2.3445$ (a count), and all of
§5 (arithmetic on measurements, with stated assumptions).

---

# 12. Surfaced for the owner

Findings only. Nothing here was written into `TODO.md`, `ROADMAP.md` or `REVIEW_ME.md`; a
dreamed verdict is a recommendation and a routing decision is the owner's.

1. **Ruling wanted: drop the thermodynamic vocabulary, keep the generating function.** §9.
   The layered core should speak of a proof-length generating function with a finite radius
   of convergence, not of a temperature. Keeping the vocabulary is defensible only if §5's
   margin travels with it as a permanent disclaimer.

2. **Correction to the cluster's own intuition: the order parameter is $z$, not $r$.** §4.3.
   Four sibling essays treat $r$ as the informative axis. In the one place the subject has a
   genuine phase transition, it is $z$ that sharpens with system size while $r$ is
   non-monotone and budget-dependent. If the cluster's geometry is kept, this reverses which
   coordinate carries the interesting physics.

3. **The critical temperature does not depend on the goal, measured to four digits.** §3b:
   $a = 2.3445$ for proofs of $a\to a$ and 2.3445 for all proofs. Perron-Frobenius, and it
   kills any reading in which hard sentences sit near criticality.

4. **Landauer is 11 to 22 orders of magnitude from binding on proof search.** §5. A companion
   number to [`lasercool.md`](lasercool.md)'s $10^3$: same method, opposite conclusion. Worth
   a `docs/rigor-debt.md` line only if the owner wants the entropy wing to record negative
   results too. His call.

5. **"Undecidability is a glassy phase" is recommended REJECTED.** §6. A glass has a Gibbs
   measure and is slow; an unprovable sentence has no Gibbs measure. The only real meeting
   point (Cubitt-Perez-Garcia-Wolf) makes undecidability a property of a family, not a phase
   of a system, the same correction
   [`weltformel-impossibility.md`](weltformel-impossibility.md) applied to the Faizal papers.

6. **The budget-indexed trajectory [`logic-simplex.md`](logic-simplex.md) asked for is built
   here, and it is boring.** §4.1: $r(B)$ is a sigmoid in $\log B$ with no transition, which
   answers that essay's item 4 in the negative. The trajectory is the right object, it simply
   has no interesting limit theorems in the budget direction.

7. **Three unverified bibliographic items flagged.** $\alpha_c(3) \approx 4.267$ (§1.1, no
   primary source checked), the IJCAI-1991 Cheeseman-Kanefsky-Taylor record, and the
   AAAI-1992 Mitchell-Selman-Levesque record, neither of which Crossref returned. If any of
   this is ever promoted, all three need a real citation or removal.

8. **Open question the essay could not close.** §3c: whether $Z(\beta_c)$ is finite depends on
   the subexponential prefactor of $N(n)$, and two natural models of the same tiny system
   disagree (matrix-like diverges; Catalan shapes finite, $Z(x_c) = 1/2$). Which models a real
   proof system is undecided here, and it is the one place more computation would change an
   answer rather than confirm one.
