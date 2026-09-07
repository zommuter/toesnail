---
title: "Three models reviewing the same ten posters"
permalink: /dreamed/model-review-comparison
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`README.md`](dreamed/README.html).
> This file *proposes*; the owner disposes. It has no Lean companion, because it makes no
> mathematical claim: like [`citation-audit`](dreamed/citation-audit.html) it is a
> process artefact, not a dream.

## Read this first, because it is the part most likely to be misused

**This is an anecdote, not a benchmark.** One artefact type, one prompt each, one run per model,
no repeats. The repo's own standing heuristic says n=10 cannot distinguish rates within about ten
percentage points; here n=1. Nothing below supports a claim of the form "model X finds Y% more
errors". What it supports is weaker and more useful: a record of **which kinds of mistake each
reviewer was positioned to catch**, and one methodological conclusion that does not depend on the
counts.

The owner's framing when he asked for it: *"for the fun of it also spawn a few Sonnet and Haiku
agents to see if their aclaimed 'inferiority' actually yields valuable feedback"*.

## The setup

Ten ELI12 posters, written the same day by Opus agents, already checked by their authors. Three
models then reviewed **the same ten posters** independently, with deliberately parallel briefs:
same artefact, same output shape, same hard constraints. Each was told the others existed and told
explicitly **not** to differentiate for its own sake, since that would destroy the signal.

One deliberate asymmetry, stated up front so it is not mistaken for a result: Fable's and Sonnet's
briefs led with accuracy, Haiku's led with legibility. That was a hypothesis under test, not a
handicap. The hypothesis: **for ELI12 clarity specifically, a less capable reader is the better
instrument**, because the failure mode of a strong reviewer is silently filling gaps the
twelve-year-old cannot.

| | tokens | tool calls | wall clock | verdict returned |
|---|---|---|---|---|
| Haiku 4.5 | 95k | 19 | 2m 12s | 9 of 10 land, accuracy sound, no false claims |
| Sonnet | 155k | 36 | 3m 54s | 8 accurate, 2 qualified, 0 wrong |
| Fable | 133k | 20 | 4m 20s | 5 accurate, 5 qualified, 0 wrong |

Those verdicts disagree, which is the interesting part. All three were looking at identical files.

## What each one actually caught

**Haiku found a real physics error.** The cold-light poster said *"Millions of tiny shoves later,
it stops."* Atoms have a Doppler floor and do not stop, and the ratio of recoil to Doppler
temperature is exactly what the source essay's entropy margin is built on, so the simplification
deleted the quantity the essay exists to compute. Haiku also named the weakest poster correctly
(the scheduler chart, on the grounds that crossing lines "require abstract interpretation"), and
hedged honestly where it could not verify a count, writing *"I cannot independently verify this"*
rather than guessing.

**Fable caught the same physics line independently**, and went past it: the source counts 5098
events, so "millions" was wrong as well as "stops". It then found something neither other model
could have, because it required opening the experiment's data rather than reading the poster: the
race the give-up poster prints (20.0 against 17.6) is the row with **no impossible questions in
the pile**, while the poster's own second line says some of the questions are impossible. A reader
infers the checker lost *with* impossibles present, which is backwards. At a fifth impossible the
checker wins by 21.5%.

**Sonnet caught two overclaims that Fable had explicitly examined and judged safe.** The boundary
poster's *"It can answer every question"*, and the conservativity poster's *"exactly what it can
prove now. No more, no less."* Fable's reasoning was that each is rescued by the poster's own
"what we skipped" line. Sonnet's was that the skip line does not actually cover the second one,
and does not carry the first one loudly enough.

## The two disagreements, and how they were settled

Both went to the coordinator, and **both resolved the same way, which is itself the finding**.

Fable was *literally* right: the qualifier is present on the page. Sonnet was *practically* right:
it is 19px grey text at the bottom of a poster whose claim is 24px in the picture, on an artefact
defined by being read in fifteen seconds from across a room. A qualifier that the format
guarantees will not be read is not a qualifier.

Ruled for Sonnet, and both lines were changed. The general form is worth keeping:

> On an artefact with a reading protocol, a claim is qualified only if the qualifier is inside
> that protocol. Whether the words exist somewhere on the page is the wrong test.

That rule is not something any of the three reviewers stated. It fell out of their disagreement.

## What this suggests, stated no more strongly than n=1 allows

1. **Agreement across models was the strongest signal available.** The one error two independent
   reviewers flagged was real, was the most consequential poster-level error found, and needed no
   adjudication. Where they agreed, they were right; where one spoke alone, it needed checking.
2. **Capability tracked provenance-chasing, not error-spotting.** Every model found errors. Only
   the strongest traced a number back to the row it came from and noticed the row was the wrong
   one. That is the capability difference this exercise actually exhibits, and it is a narrower
   claim than "better reviewer".
3. **The smallest model was the best instrument for the question the artefact exists to answer.**
   Haiku's judgement that the scheduler chart demands abstract interpretation is the single most
   actionable legibility finding, and it came from the reviewer least able to supply the missing
   reasoning itself. The hypothesis survives this run. It is one run.
4. **Haiku was too generous as a fact-checker**, returning "no false claims" on a set where four
   lines needed changing. Not wrong about anything it asserted; wrong in what it let pass. That is
   the expected failure and it showed up on schedule.
5. **Three cheap reviews beat one expensive review here**, and not because of the count. They beat
   it because the disagreement produced a rule none of them wrote.

## The caution that outranks all of the above

The most serious finding of the whole review round came from Fable reading the **essays**, not the
posters: the "proofs are broadcastable" refutation of the Bloch ball, which this session had
relayed as the *clinching* argument for a ratified decision, is invalid. Orthogonal states clone
freely in quantum theory, so copying a published proof separates nothing. It had propagated into
five documents including the ratified meeting note.

That was found by the most capable reviewer, on the least glamorous task, reading prose that had
already survived a citation audit and several adversarial passes. **The lesson is not about model
tiers.** It is that the error lived in an argument everyone found persuasive, including the
coordinator who repeated it, and it took a fresh reader with no stake in it to look at the cited
theorem's actual scope.

## Surfaced for the owner

1. **Whether to keep running mixed-tier review as a practice.** The evidence here is one run, and
   the cost was small. A defensible reading is: cheap models for legibility and naive-reader
   proxying, the strongest available model for provenance and scope-of-citation. **Ruling needed:**
   adopt as a habit, or treat as a one-off amusement.
2. **The qualifier rule** in the disagreements section above is stated here for the first time and
   is not filed anywhere. It generalises past posters to any artefact with a reading protocol,
   including the figure pages. **Ruling needed:** whether it belongs in `CONVENTIONS.md`.
3. **This page has no Lean companion and no `\veq` badges**, by the same reasoning as
   `citation-audit.md`. Flagged so the absence reads as deliberate rather than as an omission.
