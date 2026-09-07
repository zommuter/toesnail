---
title: "Review: ten ELI12 posters"
permalink: /dreamed/review-posters-sonnet
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This is one AI reviewer's independent read of the five poster pages, fresh-eyes, not a ruling.

# Review of the ten ELI12 posters (Sonnet pass)

Reviewed: `poster-truth-ball.md` (2 posters), `poster-too-hard.md` (2), `poster-computers.md` (2),
`poster-cold-light.md` (2), `poster-checking.md` (2). Cross-checked against `fig-boundary-and-big-five.md`,
`fig-cluster-map.md`, `fig-wirohsh.md`, `logic-scheduler-prototype.md`, `lasercool.md`,
`logic-models-vs-epistemic.md`, `q6-q7-q8-apparatus.md`. Verified: zero em or en dashes across all five
files; no dollar signs inside any SVG or comment; `node tests/test_dreamed_render.cjs` passes
(74 pages, no render breaks).

## Verdict table

| Poster | Accurate | Lands in 15s | Comment |
|---|---|---|---|
| Truth ball 1 (the ball) | Yes | Yes | Poles, centre and edge are exactly right; the "spinning means nothing" claim about the discarded phase is a fair reading of `logic-bloch-gates`'s no-rotation-covariant-order finding. |
| Truth ball 2 (Goedel) | Yes | Yes | Holds the line the brief asked for: liar sentence spins, Goedel's sentence lands true-and-unprovable; the WRONG/RIGHT panel explicitly rejects "maths is broken" and "nothing is knowable". Best-executed poster of the ten. |
| Too hard 1 (boundary) | Qualified | Yes | "It can answer every question." (twice) is the exact overclaim the brief warned about -- true only for questions in that restricted arithmetic, and the poster never says so on the page itself. |
| Too hard 2 (conservativity) | Qualified | Yes | "Every simple fact... exactly what it can prove now. No more, no less" states unrestricted conservativity; the source (`fig-boundary-and-big-five.md`) restricts this to Π¹₁ (and Π⁰₂ over PRA) sentences, not literally everything statable downstairs. Not covered by the "what we skipped" line. |
| Computers 1 (reversible/Toffoli) | Yes | Yes | AND-gate-as-two-switches, three-inputs-crowd-into-NO, Toffoli-needs-a-spare-wire, Landauer heat -- all correct and correctly hedged ("far less than a real chip wastes today"). |
| Computers 2 (FHE) | Yes | Yes | Locked-box analogy for homomorphic computation is standard and accurate; the empty AI-generation lane matches `fig-fhe`'s "no published end-to-end pure-FHE generative datapoint at all" exactly. |
| Cold light 1 (laser cooling) | Yes | Yes | Doppler-only-hits-incoming-atoms mechanism and the ambulance-siren analogy are both standard and correctly stated; "the light is not cold, atoms hand their motion to it" is an accurate one-line summary. |
| Cold light 2 (entropy margin) | Yes | Qualified | The ~10³-not-10⁷ number and "atoms are bad at shedding entropy" match `lasercool.md` §3 exactly (margin ~10³ for Rb87, ~3×10² for Na). Physically sound, but the picture (tidy squares vs. scattered dots) argues the *second law in general*, not the specific atom-vs-field entropy budget that is the actual finding -- the argument is carried more by the prose blocks than the image. |
| Checking 1 (give-up race) | Yes | Yes | The 20.0 vs 17.6 race and the "up to 53%, afford about a quarter" / "loads of time: 0 to 5%" figures match `logic-scheduler-prototype.md` §3.1's table (gain +52.9% at budget 1500/frac 0.50, break-even/mean-cost 0.27; gain +0.0% to +5.2% at budget 4000) to the stated precision. |
| Checking 2 (checking your work) | Yes | Yes | "Five reasons, really two" = `fig-wirohsh`'s two-root independence audit; "four write-ups, one theorem" = `logic-models-vs-epistemic` §item 5; "two questions, the same one twice" = `q6-q7-q8-apparatus` item 3 (id:57e2 Q6 = id:8ddc); "six write-ups killed their own idea" and "one killed the idea it was created to support" both match `fig-cluster-map`'s self-refutation table (six rows; `z2-grading` refutes its own parent's recommendation). All four numeric claims independently verified in the source files. |

Accurate: 8. Qualified (real but bounded issue): 2. Wrong (must change): 0.

## Things that must change

1. **Too hard, Poster 1 -- "It can answer every question."** (appears twice, once under ADDING and
   once under MULTIPLYING). As written this is the unqualified overclaim the review brief flagged by
   name. A twelve-year-old reading only the poster, not the "what we skipped" strip, will take it to
   mean the machine can answer any question at all. **Fix:** change both instances to "It can answer
   every question *about numbers, using only this*." or move the qualifier into the picture (e.g. put
   it inside the same box as the +/× symbol, or add "...about + alone" / "...about × alone" as a
   sub-line). Six words fixes it without weakening the poster.

2. **Too hard, Poster 2 -- "Every simple fact the weak floor could prove before is exactly what it can
   prove now. No more, no less."** This states unrestricted conservativity. The grown-up source
   (`fig-boundary-and-big-five.md`) is explicit that the result holds for a *stated class* of
   sentences (Π¹₁ over RCA₀, Π⁰₂ over PRA), not for literally every downstairs statement -- and the
   poster's own "careful" box only warns that this is "about assumptions, not about whether the maths
   is true," which is a different caveat and does not cover this gap. **Fix:** the cheapest repair
   that keeps the picture is to change the line to something like "Every simple fact of the kind
   downstairs *already talks about* is exactly what it could prove before" -- this keeps the
   architecture picture intact while not asserting the conservativity net catches every conceivable
   sentence. Alternatively fold a one-line qualifier into the existing "What we skipped" strip
   ("...and only for the ordinary kind of downstairs statement, not literally anything you could ever
   phrase").

No other statement across the ten posters was found to cross from simplified into false.

## Best poster and why

**Truth ball 2, the Goedel poster**, is the strongest of the ten. It does the hardest job in the set --
distinguishing the liar sentence from Goedel's sentence for a child -- and gets the actual logical
content right rather than gesturing at it: "if you could prove it, you would have proved something
false" is the real argument, not a metaphor, and the poster earns its WRONG/RIGHT panel by naming the
two specific overclaims the brief said to avoid and rejecting both explicitly, on the page, not just in
the skipped-stuff strip. It also survives being read out of order: someone starting at the ladder of
rulebooks in the middle still gets the point once they hit the first row.

The weakest is **Too hard, Poster 2 (conservativity)**. It is not inaccurate by intent and the "careful"
box shows the authors knew there was a caveat to make -- they made the wrong one. The two-storey-house
picture is good and does carry the architecture point; the text sentence over-reaches past what the
picture actually shows. It is also the densest poster of the ten (five stacked rungs plus a two-storey
diagram plus two callout boxes) and asks the most of a fifteen-second read, though the ladder itself is
legible enough that this is a secondary concern next to the wording issue above.

## Verdict

Across ten posters, two carry a real overclaim and none is fabricated or unsalvageable: both flagged
items are single-sentence fixes that tighten wording without touching the pictures, and both sit in the
same poster page (`poster-too-hard.md`). The three numeric clusters singled out for checking against
their sources -- the give-up race and its percentages, the entropy margin, and the self-refutation counts
-- all reproduce their source figures to the stated precision. The Goedel poster in particular holds a
genuinely hard line (liar vs. Goedel sentence, and the two specific "wrong" readings) cleanly enough
that it should be treated as the template for the rest of the set.
