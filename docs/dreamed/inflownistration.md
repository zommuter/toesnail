---
title: Inflownistration, nine years on
permalink: /dreamed/inflownistration
---

# Inflownistration, nine years on

> **DREAMED, UNREVIEWED.** AI-generated exploration, not owner-authored and not reviewed.
> Status contract: [`docs/dreamed/README.md`](README.md). This file *proposes*; the owner
> disposes. Nothing here may be promoted into `physics/` or `essays/` without the owner
> authoring the move. The `\veq` badges claim something about
> `docs/dreamed/lean/Inflow.lean` only, never about `physics/*.toml` or `tests/test_verify.sh`.

**Seed.** The owner asked to go "a lot deeper on inflownistration" and pointed at the live
repo `~/src/inflownistration`. A sibling dreamed essay, [`essay-wing.md`](essay-wing.md),
examined only the `gtnsd-archive` orphan branch here and ruled the concept **thin**. This
essay read the live repo, with instructions to overturn that verdict if it deserved it.

---

# 0. Headline

The sibling's "thin" verdict is **correct about the 2017 text and irrelevant to the
concept**, because the live repo already ruled the same way, in writing, before the sibling
existed: `~/src/inflownistration/docs/provenance.md` states that no component invariant
spans 2017 and that "claims that the 2017 text *anticipated* the 2026 mechanism are not
supportable". Two independent readers of the same 1,382-word archive reached the same verdict
without contact. That is a datum about the archive, not a dispute.

What the sibling could not see: the concept has since acquired a **seven-component grammar**,
a **falsifiable novelty claim** (a seven-way conjunction), an **eight-row instance
inventory**, a **named pathology with six documented cases**, and an **adversarial prior-art
programme that has already eaten three of one component's five sub-claims**. A thesis whose
components are being knocked down one at a time by evidence is not thin. It is under test.

The 2017 sentence remains what the sibling said it was. My addition is *why*: it is not false
and not a category error, it is **under-specified in arity**. "Processing information" is a
three-place relation and the sentence supplies one argument. The 2026 grammar is, read
charitably, precisely the missing arguments.

---

# 1. The live repo, reported honestly

Read 2026-09-01 at tip `42245f2`. Facts, each checkable from the repo:

101 commits, of which the first 21 are the 2017 `gtnsd` document, rooted at `c9147ce` and all
dated 2017-12-28. Chartered 2026-08-20 by a meeting note in `~/src/project_manager`. Private
(`fievel`) remote only; the 2017 text stays public via toesnail's `gtnsd-archive`. Four
content docs: `grammar.md` 172 lines, `instances.md` 234, `provenance.md` 119, `prior-art.md`
44. Five ledgers totalling 156 KB against 36 KB of authored content, a ratio of roughly 1:4.
No code at all, by construction.

**The repo's own framing.** `README.md`: it is "the **home for the concept**", and "**No
engine is built here.**" `CLAUDE.md`: "An **evidence and narrative home**", "It is not the
carve." The standing convention is "**Pointers, not copies**": canonical documents stay in
their home repos and this one carries pointers plus a freshly authored digest.

**The carve-drift tripwire** is the best piece of governance in the repo. Any executable or
machine-consumed artifact landing here reopens the 2026-06-16 decision to defer building the
engine. It has been amended twice (a docs-only `ROADMAP.md` does not fire it; the
`/inflownistration` skill's format-parsing filing mode is pre-ratified) and it currently
carries an **explicitly undecided** case, `id:2b63`: a ledger provenance-chain walker that
would read meeting-note decisions *semantically*. `CLAUDE.md` refuses to decide it and says
why: "deciding by shipping is precisely the accretion this tripwire names."

## 1.1 Has the concept acquired a mechanism, a test, or a prediction?

All three, at differing strengths. **Mechanism:** the grammar T (traced flow), M (machine
proposal), C (certainty measure), H (human ratification), S (staleness propagation), G
(graceful degradation), R (re-check discipline), with `grammar.md` stating its own scope
limit, that no component invariant spans all formulations and only a **fourfold** T/M/C/H
invariant holds across the 2026 ones. **Test:** the novelty claim is the seven-way
conjunction, and `id:aa0c` is a prior-art programme designed to kill it, which has already
produced a rejected verdict, a reopen, an independent re-search and a calibration scoring.
**Prediction:** `REVIEW_ME.md` preserves the rejected verdict `id:e0b1` as "a dated
PREDICTION to be scored afterwards", and `id:dc63` scored it 2 HIT, 5 UNRESOLVED.

## 1.2 The R verdict and the C rubric, since the owner asked

**The R verdict (`id:3cb5`, delivered 2026-08-27, OPEN and deliberately held).** R was
decomposed into five sub-claims so it could fail, and it did, in part:

| | Sub-claim | Verdict |
|---|---|---|
| R1 | a ratified resolution is a defeasible claim, not a terminal fact | EATEN |
| R2 | it is re-verified later on a schedule or trigger | EATEN, decades old |
| R3 | the system computes which resolutions need re-checking | EATEN, low confidence |
| R4 | the re-check spans prose *and* code *and* proofs together | **SURVIVES** |
| R5 | re-check outcomes are graded rather than binary | CONTESTED |

The prior art named is safety-case maintenance (UL 4600 safety performance indicators,
arXiv:2410.00578 and arXiv:2412.17618) and identity-governance access recertification
(ISO/IEC 17021-1, IDPro). Two of those predate the 2017 coinage. The consequence is the part
worth the owner's attention: the conjunction plausibly still holds but **its support has
moved**, off "R is distinctive" and onto R4 plus R's pairing with M and C. The unit declared
its residue: five of six retrievals were arXiv abstract pages, so most findings are
abstract-grounded.

**The C rubric (`id:6ae1`, POSED, not answered, owner-only).** Does `C` require the grade to
express **certainty**, or merely to be **non-binary**? Strict: `grammar.md` says
"severity/certainty-graded" and pairs C with G, so C3 survives ReqToCode (arXiv:2603.13999)
untouched. Loose: any non-binary grading counts, and C1+C2 eat C. The two readings give
opposite verdicts on identical evidence, which is why no search result can settle it. One
ruling moves **two** things, because the IGA literature grades a re-check by declared risk
tier with no uncertainty content at all: it decides C3 *and* R5. The box heads a recorded
four-step chain (rule C, then ratify or reject R, then `id:aa0c` closes, ungating `id:466d`
and then the essay `id:431c`); the owner deferred it on 2026-09-01 to read the boxes first.
I have an input to that ruling in §3.3, and no answer.

---

# 2. The steel-manned thesis, and where it breaks

> "We're basically always processing information, no matter what we do."

## 2.1 Reading one: Landauer, which makes it true and useless

Every logically irreversible operation dissipates at least $k_B T \ln 2$ per bit erased.
The sibling [`information-wing.md`](information-wing.md) develops this and finds $\log W$
the unifying quantity of the wing; I do not redo it. What it buys the 2017 thesis is a
literal energetic reading: information processing has a floor denominated in joules.

What it costs the thesis is everything that made it interesting. The bound applies to a rock
warming in the sun, a protein folding and a hard drive being wiped, without distinction. It
is conservation-law-shaped: universally true, and therefore incapable of separating the
cases the 2017 essay wanted to unify (eating, work, planning a tunnel, religion) from the
cases it did not mention. A criterion that admits everything selects nothing.

## 2.2 Reading two: the free-energy principle, and its contestation

Friston's free-energy principle says a system that persists must minimise variational free
energy, an upper bound on surprise, which is read as: living things *are* inference
engines. If sound, this is the strongest available version of the 2017 thesis, because it
is a formal claim rather than an analogy.

It is heavily contested, and honesty requires reporting that rather than citing the strong
form. The standard objection is the one this essay is testing: a principle that redescribes
perception, action, memory, attention and value as free-energy minimisation risks being
unfalsifiable, since no empirical finding is left to count against it. Critics render the
circularity as "why do biological systems minimise free energy? Because they exist. Why do
they exist? Because they minimise free energy." **Friston himself has said the principle is
"almost tautological"** and better read as an elegant way of looking at things than as a
scientific theory. A further objection is terminological: variational free energy is not
physical energy, and the vocabulary of entropy and surprise invites an analogy it does not
earn.

So the FEP does not rescue the 2017 thesis. It **reproduces that thesis's exact failure mode
one level up**, with far more mathematics attached and its own author conceding the point.
Useful as a negative result: the universality is not fixable by importing a better formalism.

## 2.3 Reading three: maximum caliber, and the distinction that matters

Maximum caliber is Jaynes's maximum-entropy principle over trajectories rather than states:
given constraints on path observables, pick the path distribution of greatest entropy. It is
the honest physics analogue, and its honesty is that it is **epistemic**, a rule for a
modeller who is uncertain rather than a claim that the system performs inference. That
distinction is the whole argument. The FEP is accused of blurring it; MaxCal keeps it; the
2017 sentence never had it. "We are always processing information" is ambiguous between "a
describer can always model this as information flow" (true, uninteresting) and "the system
itself computes" (strong, mostly false).

## 2.4 The crux: is "eating is information processing" a deep identity or a category error?

Neither, and the essay must not dodge this. It is an **arity error**.

"Processes information" reads as a one-place predicate and is not one. The contentful
relation has three arguments:

$$ \mathrm{Proc}(X;\ Y;\ Z) \quad\text{: } X \text{ carries information about } Y \text{ for a decoder } Z \text{ that acts on it.} $$

Supply only $X$, and the claim is trivially true of everything: any process has nonzero
mutual information with its own past, so "$X$ processes information" is satisfied by a rock.
Supply $Y$ as well and you get physics, a good but very broad theory. Supply $Z$ and the
claim becomes discriminating, because now there is a fact of the matter about whether a
designated reader exists and whether it acts.

Eating, at full arity: the gut carries information about the meal for a decoder
(enteroendocrine signalling, satiety) that acts on it. A genuine instance, not a pun.
Digestion in a corpse is not, because $Z$ is gone. The 2017 essay's examples are all real
instances **once the arity is restored**, and its universality claim is false for exactly
the same reason: it dropped $Z$, and $Z$ is what selects.

This puts the 2026 grammar in an unexpectedly good light. **T (traced flow) is the $Z$
argument.** "Consequential information carries explicit links" is a statement about a
designated reader that will act on the link. The grammar is not a change of subject from the
2017 text; it is the missing arguments, filled in nine years later. (The sibling
[`omniscience.md`](omniscience.md) independently found arity, not physics, to be the crux of
a different owner question. Worth one sentence; it is not evidence.)

---

# 3. Where the concept has bite: direction and decay rate

The universal thesis has no bite. Its sharp descendant does, and it is not "everything is
information flow". It is **information flow has a direction and a decay rate**.

## 3.1 The direction, proved

A description of a description says no more about the referent than the description did.
Formally, for a re-description $f$ of the description $D$,

$$ I(R;\ f(D)) \le I(R;\ D) $$

with equality only when $f$ loses nothing. \veq{dpi}\lean

This is the data-processing inequality. `docs/dreamed/lean/Inflow.lean` proves it in the
**deterministic coarse-graining case** (`dpi_coarse`, on finite types with strictly positive
joint laws, plus `dpi_coarse_twice` for iterated re-description), from a `log_sum_ineq`
proved from `Real.log_le_sub_one_of_pos`. \veq{lsi}\lean

**Scope, stated so the badge cannot launder it.** The general stochastic-kernel DPI for a
Markov chain $R \to D \to D'$ with a random second channel is **not** proved. The
deterministic case is the one this argument uses, since an edit, a summary, a transcription
and a cached verdict are each a function of what they were taken from. Mutual information is
also proved non-negative (`MI_nonneg`), which the sibling `lean/InfoWing.lean` established
independently as `gibbs_nonneg`; here it is re-derived as the normalised case of the log-sum
inequality rather than reproved.

## 3.2 The decay rate, and the channel the DPI does not cover

The DPI bounds the **description-side** channel: what happens when a description is
re-described. The staleness this repo actually suffers from is the **referent-side** channel:
the equation changes and the sidecar entry does not. The DPI says nothing about that, because
it fixes $R$. So the decay rate is an empirical parameter, and the Lean file treats it as
one. Given a per-step preservation ratio $q < 1$,

$$ I_n \le q^n I_0, \qquad n \ge \frac{\log(\varepsilon/I_0)}{\log q} \implies I_n \le \varepsilon $$

proved as `mi_decay` and `steps_to_epsilon`, with the half-life
$t_{1/2} = \log 2 / (-\log q)$ and $q^{t_{1/2}} = 1/2$ as `rpow_halfLife`. \veq{half}\lean

That turns "staleness" into a number, conditional on measuring $q$. It is small and honest,
and the honesty is that $q$ is a hypothesis, not a theorem.

## 3.3 Can toesnail's `verify:` machinery measure $q$?

Partly, and the gap is instructive.

`physics/Resogram.toml` pins, per equation handle, a `claim` field (an srepr content hash of
what the instrument verified) and a `by` list of instrument file hashes.
`tests/test_verify.sh` asserts non-drift on both and asserts the sidecar handles are a subset
of the source `\veq` handles. That is already a staleness instrument, and what it reports is
**binary**: hash matches or it does not. A hash is a 0/1 collapse of the continuous quantity
above; it detects the *onset* of decay perfectly and measures its *rate* not at all. The rate
is recoverable from data the repo already has, because git dates every edit:

```computation
# PROPOSED, NOT RUN. Attestation half-life from the repo's own history.
# For each handle h in physics/Resogram.toml:
#   t_write(h)  = commit date the attestation was written
#   t_drift(h)  = first later commit where the instrument's claim-hash changed
# lifetime(h)   = t_drift - t_write   (censored if no drift yet)
# Estimate median lifetime over handles, Kaplan-Meier for the censoring.
# Output: a half-life in commits and in days, per tier.
# Decidable: yes. It needs git log over physics/ and verify/, nothing else.
```

The `edot` incident is the one measured point available today: one sign fix propagated four
hand-checkable discrepancies through Resogram with no staleness checker to catch them. That
is an out-degree of 4 for a single edit, not a rate, but it is the empirical anchor a rate
estimate would be calibrated against.

**An input to the C rubric, offered as input and not as an answer.** A grade that expresses
*certainty* is a quantity with a decay rate attached: it can be re-estimated, it can fall
below a threshold, and `steps_to_epsilon` applies to it. A grade that is merely *non-binary*
(a risk tier, a lifecycle rung) is a declared static label with no dynamics, so nothing about
it is measurable. If C is meant to be the component that couples to S, that argues one way;
if C is an ergonomic reading aid, the other. This observation appears in neither
`REVIEW_ME.md` box. The ruling is the owner's; this is an argument, not a verdict.

---

# 4. The cross-project map, checked

Every repo named below exists under `~/src`; I checked before asserting the link.

| Edge to | Real or thematic | Evidence |
|---|---|---|
| `.mw` | **real dependency** | `TODO.md:34` `id:aae4` holds the concept block; `id:cb68` holds the carve gate, kept there because the machinery is there |
| toesnail | **real** | the 2017 origin branch; the "toesnail verify tiers" instance row (T/M/C/H ●, S ◐, G ●, R ◐); the essay `id:431c` is to be authored in `essays/` |
| `dotclaude-skills` | **real, and strongest** | the relay is the only 7/7 instance, in its own self-hosting tier |
| `zkm` | **real but narrow** | Grand Truth umbrella hub `id:3d98` at `zkm/TODO.md:146`; the `zkm` instance row is T ● and nothing else |
| `chidiai` | **real row, thematic beyond it** | `chidiai gate` is an instance row; its `docs/cases/` corpus is thematically the empirical record of the "flow without signal" pathology, and nothing links them |
| `it-infra` | **real** | the drive catalogue row and the pathology's six cases both come from it |
| `collaib` | **real row, weak** | `collAIb co-author loop` row; toesnail's `docs/dependencies.md` grades that edge weak and non-blocking |

**One gap worth locating.** `instances.md` states that the portfolio's only 7/7 instance
"was absent from every triad and mesh document", and names toesnail's
`docs/dependencies.md` as one of them. I checked: `docs/dependencies.md` has exactly three
nodes, toesnail, `.mw` and collAIb, and no `dotclaude-skills`. The claim is accurate as of
today. See "Surfaced for the owner".

---

# 5. Recommendation, with its weaknesses

**The owner's to ratify. This is a recommendation and settles nothing.**

**On the sibling's verdict: it stands, narrowed.** The 2017 *text* is thin, definition by
example, ~120 words, and its concept-to-tooling lineage is retrofitted. That was already the
live repo's ratified position, so the sibling re-derived rather than discovered it. But
"thin" **does not transfer to the concept**, and reading the sibling as a verdict on the
concept would be wrong. §2.4 is my one substantive disagreement: the sibling treated the
universal thesis as merely weak, and it is more specifically an arity error whose repair is
what the 2026 grammar performs.

**On what the repo should be: it is already a live research programme and should be called
one.** The evidence is a decomposable claim, an adversarial test that has knocked down three
sub-claims, a preserved dated prediction, a calibration scoring, and a named pathology with
six field cases. A concept home does not do those things.

The single change I would recommend, if any: a **prediction register**, one file, one row per
falsifiable claim with its date, its status and what would kill it. `REVIEW_ME.md` already
holds that content, spread across a 65 KB ledger where only a full read finds it.

**Weaknesses, stated because a recommendation without them is sycophancy.** A register is one
automation away from tripping the carve-drift tripwire, and the tripwire is the best thing in
the repo. The 1:4 content-to-ledger ratio admits two readings, careful process or process
outgrowing substance; I lean to the first because the ledger content is mostly adversarial
testing rather than bookkeeping, but I cannot distinguish them from the artifacts and the
owner can. And this is one pass by a reader with an incentive to find the repo interesting.

**The counter-argument, which the owner may prefer:** `instances.md` records a standing gap,
that no artifact has yet crossed a repo boundary. Until one does, another ledger file is more
inventory, and the honest move is to build the first cross-boundary artifact and let the
register wait.

---

# Surfaced for the owner

Located and evidenced, never edited. Nothing here was filed into any ledger.

1. **`toesnail/docs/dependencies.md` has three nodes and no `dotclaude-skills`.** The live
   repo's `instances.md` names this file as one of the documents that omits the portfolio's
   only 7/7 instance. Verified today: the node list is toesnail, `.mw`, collAIb. Whether
   `docs/dependencies.md` should gain that node is the owner's call; its scope may
   deliberately be the three-way tool relationship only.
2. **`inflownistration/docs/grammar.md:20`, "R was forced onto the list by the evidence,
   not designed in."** The `id:3cb5` verdict already asks that this not be read as novelty
   evidence. I add only that the sentence is a claim about derivation, and the file places
   it two lines under the component table where a reader takes it as support.
3. **The C rubric input in §3.3.** Neither `REVIEW_ME.md` box contains the
   certainty-decays / label-does-not argument. Offered as input to `id:6ae1`, deliberately
   not an answer, deliberately not filed.
4. **The 2017 typo `Inlfownistration` is already handled.** `provenance.md` records the
   transposition as being in the source. The sibling flagged it as a finding; it is not one.
   Noted so the two dreamed essays do not disagree in the owner's inbox.
5. **`physics/Resogram.toml` measures decay onset, never decay rate.** Nothing is wrong
   with the file. The observation is that the repo's only staleness instrument is binary by
   construction, and the `edot` incident is the sole measured data point on propagation.

---

# Lean attestation

File: `docs/dreamed/lean/Inflow.lean`.

Theorems: `log_sum_ineq`, `gibbs_nonneg'`, `marginalX_pos`, `marginalY_pos`, `sum_marginalX`,
`sum_marginalY`, `MI_nonneg`, `marginalX_push`, `marginalY_push`, `dpi_coarse`,
`dpi_coarse_twice`, `mi_decay`, `steps_to_epsilon`, `halfLife_pos`, `rpow_halfLife`.
Command, run from `verify/`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Inflow.lean
```

Exit status **0**. Zero `sorry`. Four `unusedSectionVars` linter warnings, no errors. The
file is outside the `verify` lake target and cannot affect `make test`.

**Weakened, declared.** `dpi_coarse` is the **deterministic** data-processing inequality
(`D' = f(D)`), not the general stochastic-kernel case for a Markov chain with a random
second channel; that needs the chain rule for conditional mutual information and is not
proved. All positivity is in named hypotheses (`hpos`, `hq0`, `hI0`), so the theorems say
nothing about distributions with zero entries. `mi_decay` takes the per-step ratio `q` as a
hypothesis; nothing here derives a decay rate from anything.

---

# Follow-up leads

1. **Measure the attestation half-life** from the `physics/` and `verify/` git history with
   the sketch in §3.3. *Decidable by:* running it; the data exists and needs no new
   instrument.
2. **Prove the stochastic DPI** and check whether the referent-side channel (§3.2) admits
   any theorem at all, or is irreducibly empirical. *Decidable by:* attempting the chain
   rule for conditional mutual information in Mathlib at the vendored rev, and reporting
   whether the referent-drift case has a bound or only a model.
3. **Settle R3 with one fetch.** The `id:3cb5` residue names it the highest-value single
   follow-up: one retrieval of the TLAPS body text or Why3 session documentation decides
   whether R3 has shipped since 2012. *Decidable by:* that one fetch.
4. **Test the arity claim of §2.4 against `grammar.md`'s T.** If T really is the missing
   $Z$ argument, then every instance row marked T ○ should be a system with no designated
   acting reader. *Decidable by:* checking the eight rows against that prediction; the
   inventory is small enough to check by hand, and a single counterexample kills it.
5. **Cross the first repo boundary.** The standing gap in `instances.md` is that no
   artifact has crossed the `.mw`/collAIb boundary. *Decidable by:* naming one candidate
   artifact and shipping it, which also fires or fails to fire the `id:aae4` carve gate and
   resolves a question four re-checks have left open.
