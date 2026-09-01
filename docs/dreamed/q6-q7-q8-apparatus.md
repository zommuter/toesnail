---
title: "Dreamed: Q6/Q7/Q8, the editorial apparatus"
permalink: /dreamed/q6-q7-q8-apparatus
---

# Dreamed: Q6/Q7/Q8, the editorial apparatus

**DREAMED, UNREVIEWED.** See `docs/dreamed/README.md`. Nothing here is a decision, a macro
definition, or an engine-config change; this essay PROPOSES, the owner disposes. Seed picked
by the owner 2026-09-01: the three open apparatus questions of `TODO.md` id:57e2, from
`docs/meeting-notes/2026-07-07-1228-toe-roadmap-evaluation.md` (D3, D4) and
`docs/meeting-notes/2026-07-07-1240-mw-collaib-toe-needs.md` (Q6/Q7/Q8, F2, F5).
Companion Lean file: `docs/dreamed/lean/Apparatus.lean`. The Q6 feasibility question is
CLOSED (probe PASS 2026-07-07, re-confirmed below) and is not reopened here; Q6 is a naming
choice. Every render claim below was checked against the repo's own engines and real macros.

## 1. Q6: what to call the epistemic-status tags

### 1.1 The two axes are orthogonal, and the repo already says so twice

The `\veq` ladder answers *how well checked is this*; a status tag answers *what kind of
claim is this*. Checked against the ratified texts rather than assumed: `CONVENTIONS.md` §2
states it directly ("Tier = assurance *floor*, not a claim-type label ... the tiers
partition by assurance strength × cost ..., not by the kind of claim"), and the 1228 note's
D3 states the converse direction ("link-status is a different axis than verification tier: a
`[derivation]` link can still carry `\sorry`"). The orthogonality survives scrutiny under
one precise reading: **the tier attests the conditional mathematical content of the claim as
stated; the status tags how the claim earns its place in the text** (derived from prior
text, taken from experiment, posited). Under that reading every combination is realizable,
including the seemingly odd corners: `hypothesis + lean` is a posited law whose stated
consequence is kernel-checked (a SUSY algebra closing is a theorem about a hypothesis);
`empirical + sympy` is a fitted formula whose algebraic restatement is CAS-confirmed. The
companion Lean file proves the product structure concretely (`card_apparatus`,
`no_status_pins_tier`: 5 × 5 = 25 inhabitants, no status pins a tier). So the tag family is
NOT redundant with the ladder; Q6 is worth answering.

One entanglement is real, though, and it is grammatical, not semantic: in `\veq{h}<badge>`
the second slot today holds *either* a tier *or* a kind. That is exactly why §2 needs its
anti-gaming clause ("`\definition` is never a dodge for a real claim"): the axes share a
render slot, so one can masquerade as the other. The 2026-07-07 probe proved stacking
renders (`\veq{h}\derived\sorry`, both engines); what it deliberately did not fix is the
canonical stacked order and which badge lands inside the tag. That typography belongs in the
same ratification as the names, so the first authored tag does not set an accidental
precedent.

### 1.2 The family already exists in embryo, and Q6 should extend it

`_includes/custom-head.html` already defines two "Annotation-KIND macros (not verification
tiers)": `\definition` → `def` and `\assumption` → `ass`, with the comment "PILOT of the
open annotation family (id:8ddc / .mw id:358f open-enum `{@<kind>}`). Full kind taxonomy is
a later /meeting". The `physics/Resogram.toml` header confirms they are live ("annotation
KINDS (eom `\assumption`, e `\definition`) carry no attestation"). **That later /meeting is
Q6.** A `\derived`/`\empirical`/`\hypothesis` family minted without reference to it would be
a second, conflicting family: five kind-shaped badges in two typographies, two enum homes,
and an undrawn line between `\assumption` (a local modeling premise, like `eom`) and
`\hypothesis` (a global physical conjecture, like SUSY), which are adjacent kinds that only
one merged taxonomy can delimit cleanly. This is the essay's main Q6 finding: **extend the
piloted kind family to five, do not invent a parallel one.**

### 1.3 Naming schemes, each with badge, freedom check, and weakness

All name-freedom results below were re-probed 2026-09-01 against the real central configs in
BOTH engines (undefined ⇒ error under KaTeX / merror under strict MathJax); `\input` stays
impossible (TeX primitive) and was not retried.

**(a) The recorded candidates: `\derived` / `\empirical` / `\hypothesis`.** Badges as in the
2026-07-07 probe bodies: `[der.]` / `[emp.]` / `[hyp.]` in `\scriptsize\text`. All three
free in both engines (2026-07-07 PASS, re-confirmed). Weakness: grammatical mismatch with
the existing kinds. `definition` and `assumption` are nouns naming what the equation *is*;
`derived` and `empirical` are adjectives, and the mixed family reads unevenly
(`def`, `ass`, `der`, `emp`, `hyp` hides it, but the source-level names do not).

**(b) Provenance-first: `\fromtext` / `\frommeasure` / `\posited`.** Badges `txt` / `exp` /
`fiat` in the existing `\mathrm` style. All three free in both engines (probed 2026-09-01).
Pro: names the reader's actual question, "where does this equation come from". Weakness:
clumsy control words, and it abandons the vocabulary D3 already ratified as the tag *text*
(`[derivation]`/`[input]`/`[hypothesis]`), so prose and macro names would drift apart.

**(c) Kind-extension, noun-consistent (recommended): `\derivation` / `\observation` /
`\hypothesis`,** joining `\definition` and `\assumption` with matching `\mathrm` typography:
`def`, `ass`, `der`, `obs`, `hyp`. Probed free 2026-09-01: `\derivation`, `\observation`,
`\measurement`, `\premise`, `\conjecture`, `\postulate` all free in both engines, so the
noun forms are available and the owner can swap synonyms freely (`\observation` vs
`\measurement` vs keeping `\empirical` is taste; `\input`'s meaning lands on whichever is
picked). One family, one typography, one open-enum home matching `.mw` id:358f. No TeX or
LaTeX kernel collision found for any candidate; amsthm users define theorem *environments*
named `hypothesis`/`conjecture`, which are environment names, not control sequences, so even
a future real-LaTeX export does not clash. All five are valid Lean identifiers (the
companion file uses them verbatim; only the *tier* `sorry` needed renaming, to `sorryT`).

**(d) A variant composable with any of the above: mark departures only.** Make `derivation`
the unmarked default and badge only `def`/`ass`/`obs`/`hyp`. In a text whose whole premise
is derivation, this halves badge noise, which serves D4's "everyone" audience. Weakness:
silence becomes ambiguous (unmarked = derived, or = not yet triaged?), and the greppable
inventory loses its largest class; it would need a lint asserting every display equation
carries *something*, which is new machinery.

**Recommendation (owner's to ratify): scheme (c), five noun kinds in the existing
typography, with (d) recorded as an explicit non-adopted alternative.** Weakness of the
recommendation itself: `obs`/`der` are less self-evident than `[emp.]`/`[der.]` spelled
out, and merging the families forces the `\assumption` vs `\hypothesis` boundary question
into the same meeting, which grows its agenda. (I count that a feature; the owner may not.)

## 2. Q7: named kinds versus numeric levels for asides

The inventory is already fixed: the 1318 curriculum note's per-step "defer" lists ("Each
step's defer list is the D4 aside inventory", its observation 3). Reading that inventory
settles more than the abstract argument does.

**The named kinds are audience-indexed, not depth-ordered.** Per the 1240 note: `trivial` =
skippable for physicists, `prereq` = skippable for laypersons on reread, `advanced` =
optional depth. These do not sit on one axis a threshold can cut: a layperson wants `prereq`
shown and `advanced` hidden; a physicist wants the reverse; nobody wants "everything up to
level 2" as such. The numeric scheme's real advantage (sort, threshold) only materializes if
the level is read as *reader sophistication* and visibility as a band around the reader,
which is exactly the information three named kinds already encode as a kind → audience-set
map. Kinds here are levels with names, minus the pretense of more resolution than exists.

**The inventory is lopsided.** Nearly every defer-list entry is `advanced`-flavoured
(bilinearity of ⊗, completeness/separability, H² cohomology, Mackey machinery, C/P/T,
renormalization signposts, fiber bundles, custodial symmetry, superspace, tensor-calculus
completeness, neuroscience formalisms). `trivial` and `prereq` instances will arise during
authoring, not from the lists. A numeric scale would today be calibrated on essentially one
flavour of data, and author-side level calibration drifting across eleven chapters is the
classic failure mode of numeric difficulty ratings. The sibling audit
[`spine.md`](./spine) supplies the first non-`advanced` specimens: the ~350-word
complex-number footnote it flags as the spine's largest unpaid introduction is a
`prereq`-or-`advanced` aside candidate, exercising the kinds the moment the spine is revised.

**Concrete rendering proposals.** Named kinds: `{@aside advanced}` lowering to
`<details class="aside aside-advanced">`, with a small per-page reader-mode toggle (lay /
reread / physicist) that opens or collapses by class; the source stays self-documenting.
Numeric: `{@aside 2}` plus a slider; the reader must learn what 2 means and the author must
mean it consistently.

**Which does D4 favour? Named kinds, because D4 is phrased in kinds.** The ratified text
specifies *who skips what* ("skippable trivial maths sections that remain enjoyable",
"determined laypersons must be able to follow"), never a depth dial. Recommendation: named
kinds, with the enum DECLARED as ordered (`prereq` < `trivial` < `advanced`) so a numeric
view stays mechanically derivable later; nothing is lost by naming. Weakness: if a fourth
stratum ever appears (say two grades of advanced), kinds need a rename/migration where
numbers would have absorbed it silently. They are not exclusive; adding a level *facet* to
kinds later is additive, and should wait for the first aside that actually needs it.

## 3. Q8: chapter granularity, and what `\eqref` actually does across files

### 3.1 Two verified facts

**Permalinks decouple URL from file, but only for moves.** `_config.yml` sets no permalink
defaults; every page carries its own (`physics/toesnail.md` → `/toesnail`,
`physics/Resogram.md` → `/Resogram`, `physics/entropy.md` → `/Entropy`, checked in the front
matters). Moving a file preserves its URL; *splitting* one mints new URLs and orphans
in-page anchors of whatever content moves out. Granularity is therefore a real, one-way
decision at the URL level too.

**A cross-file `\eqref` breaks, verified, and the breakage is silent-ugly, not loud.**
Probed 2026-09-01 with the repo's `mathjax-full` and the real `custom-head.html` macros
(`tags:'ams'`): labeling `\veq{massenergy}\sorry` in one MathJax document and rendering
`\eqref{massenergy}` in a *second* document (a separate Jekyll page is a separate MathJax
document; there is no cross-page label registry) produces no error and no red text; the
reader sees a literal **`(???)`** wrapped in a dead `href="#"` link. Same-document, the same
reference renders `(massenergy)` correctly linked. A workaround exists but is second-class:
the labeled equation gets `id="mjx-eqn:massenergy"` (verified), so a plain markdown link
`[(eom)](/toesnail#mjx-eqn%3Aeom)` can deep-link across pages. Its costs: a visibly
different citation syntax; no render-time validation (a typo renders fine and scrolls
nowhere); every grep and future `.mw` DAG edge needs a second pattern; and fragment
scrolling races MathJax typesetting (the target id does not exist at page-load), which the
node harness cannot check and is flagged as a `[HUMAN]` browser test below.

### 3.2 What that settles

The `\eqref` finding does not pick a file count, but it converts Q8 from taste into two
constraints. First, **chapter boundaries must fall where equation-citation chains are
cold**, because every hot cross-boundary citation drops to the second-class link or forces a
restatement. Second, **Q8 must be decided early**: a later split converts existing in-file
`\eqref`s into `(???)`, so the migration cost grows monotonically with authored content, and
"split when it hurts" is not free. Per the 1318 dependency map the steps cite their
neighbours densely (step 7's gauging uses step 3's projective-rep definitions; step 5 uses
3 and 4), so eleven one-step files maximize exactly the hot edges.

### 3.3 The three options

- **A. One file per roadmap step (11 files).** Cleanest `.mw` DAG nodes and smallest pages,
  but `.mw` F5 (cross-file DAG, unconfirmed in `.mw`) becomes immediately blocking, the
  cross-file citation load is maximal, and eleven stub URLs exist from day one.
- **B. Phase files (3 to 5).** For instance steps 1 to 4 (states to spacetime symmetry
  groundwork), 5 to 6 (particles and fields), 7 to 9 (gauge to ceiling theorems), 10 to 11
  (gravity and emergence); the actual seams are the owner's to draw along the 1318 map. Most
  citations stay in-file; the known 3 → 7 edge crosses any sane partition, so F5 remains
  wanted but not blocking. At current corpus density (848 lines total today, the spine 139)
  phase pages stay comfortably readable.
- **C. Organic (status quo).** No decision now, but the `\eqref` migration debt accrues, a
  full 11-step spine in one file strains D4 navigation, and every aside lands on one page,
  which is exactly the Q8 → Q7 coupling.

**Recommendation (owner's to ratify): B, phase files, seams drawn at citation-cold
boundaries before step-2 authoring starts; treat a needed cross-seam citation as a prompt to
*restate* the equation under a fresh handle in the citing chapter.** That restatement is not
only a workaround: it is D1's "we already knew this" callback pattern, so the constraint and
the ratified voice point the same way. Weakness: the partition is itself a physics-direction
judgment about which steps cohere, which the AI cannot make; and B still needs the F5 answer
from `.mw` eventually, plus the `[HUMAN]` anchor check before any cross-page deep link is
relied on.

## 4. Decision order and summary

**Q8 first** (its cost grows with every authored line, it constrains Q7's per-page aside
volume, and it sets F5's urgency for the queued `.mw` meeting, id:b160). **Q7 second**
(sizing the aside mechanism needs Q8's page length). **Q6 is independent** and can be
decided any time before the first status tag is authored; deciding it also unblocks the
`.mw` agenda item that D3 routed (`routed:91ab`/`1a68`).

| Q | Recommendation | Weakness |
|---|---|---|
| Q6 | Extend the piloted kind family to five noun kinds (`\definition`, `\assumption`, `\derivation`, `\observation`, `\hypothesis`), one `\mathrm` typography | Less self-evident badges; drags the `\assumption` vs `\hypothesis` boundary into the same meeting |
| Q7 | Named kinds, enum declared ordered; levels only when a 4th stratum appears | A later stratum means migration, not renumbering |
| Q8 | 3 to 5 phase files, seams at citation-cold boundaries, decided before step 2 | Seam-drawing is an owner physics judgment; F5 still needed for residual cross-edges |

## 5. Lean attestation

`docs/dreamed/lean/Apparatus.lean` formalizes the one mathematical claim here: the ladder is
a partial order with `\numeric` as a genuine off-ramp, and the status axis is orthogonal.

- `Apparatus.Tier.apparatus_partial_order`: `PartialOrder Tier` with `sorryT < sympy < lean
  < sympylean` and `sorryT < numeric` only; reflexivity, antisymmetry, transitivity closed
  by `decide` (125 cases).
- `Apparatus.Tier.numeric_is_off_ramp`: `numeric` is above `sorryT`, and incomparable in
  both directions with `sympy` and `sympylean`; `Apparatus.Tier.ladder_not_linear`: hence
  the ladder is provably NOT a total order. Getting `\numeric` non-comparable is the
  faithful reading of §2's "complementary counter-indicator, never the assurance badge".
- `Apparatus.card_apparatus` (`Fintype.card_prod`) and `card_apparatus_eq`:
  `|Tier × Status| = 5 × 5 = 25`; `Apparatus.no_status_pins_tier`: any two tiers are
  realized under the same status. With the bare three-status family the count is 15 and the
  argument is identical; the file models the recommended five-kind family.
- `Apparatus.Entry.wf`: the sidecar shape (`tier_floor`, achieved `tiers`) with a decidable
  well-formedness predicate under the ORDER reading of the floor, plus worked examples: the
  live `[edot]` entry is `wf`; achieved `[numeric]` never discharges a `sympy` floor.

Checked 2026-09-01 from `verify/` (vendored Mathlib, narrow imports):

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Apparatus.lean
```

Exit status 0, zero `sorry`, first compile.

## 6. Surfaced for the owner (findings, deliberately not filed)

1. **`tier_floor` has no mechanical consumer.** `grep -rn tier_floor tests/ verify/*.py`
   finds nothing; the floor lives only in the toml header comment and `CONVENTIONS.md`.
   Consistent with observe-before-preventing, but see 2.
2. **The floor's satisfaction semantics is unpinned, and two ratified texts disagree.**
   `CONVENTIONS.md` §2 says `tiers` "must contain the in-prose badge's tier" (membership);
   `tier_floor` is glossed "lowest assurance tier intended" (order). They differ on whether
   achieved `["lean"]` satisfies `tier_floor = "sympy"`: membership says no, order says yes.
   `Apparatus.lean` pins the order reading as a proposal; worth ratifying one reading before
   the automated staleness checker (id:04bb) hard-codes either.
3. **TODO id:57e2's Q6 and custom-head's id:8ddc are the same question and do not
   cross-reference each other.** The Q6 line never mentions `\definition`/`\assumption`;
   the macro comment's "later /meeting" never mentions Q6. Risk: two kind families ratified
   independently. Section 1.2 is the reconciliation proposal.
4. **The 2026-07-07 stacking probe fixed renderability, not layout.** Canonical badge order
   and tag-slot placement for `status + tier` are open typography; fold into the Q6 naming
   ratification.
5. **`[HUMAN]` check pending:** whether `/page#mjx-eqn%3Ahandle` deep links actually scroll
   after MathJax typesets on the live site; `tests/HUMAN-integration.md` is the natural home
   if Q8 option B is taken.

## 7. Follow-up leads

- Mechanically extract the cross-step citation graph from the 1318 needs/defer lists;
  decidable once the owner confirms the per-step edges, and it draws B's seams for him.
- Put the F5 question to `.mw` as a concrete two-file fixture (handle in file A, typed link
  from file B); decidable in one `.mw` spike session, and it prices A versus B honestly.
- Run the `[HUMAN]` deep-link scroll check on the live site; decidable with one test link.
- Pilot the five-kind family on one existing page (`physics/entropy.md`'s N-states premise
  is `observation`-shaped); decidable by whether the owner can tag the page without wanting
  a sixth kind.
- Scan the aside inventory for anything needing two grades of `advanced`; decidable by
  counting, and a count of zero settles Q7's named-kinds recommendation outright.
