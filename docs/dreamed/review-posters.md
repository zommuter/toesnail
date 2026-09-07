---
title: "Review: the ten ELI12 posters"
permalink: /dreamed/review-posters
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This is a fresh-eyes review of the five poster pages, written by an agent that did not write
> them. It edits nothing; every proposed change is a request to the coordinator.

# Review of the ten posters

Scope: [`poster-truth-ball`](poster-truth-ball), [`poster-too-hard`](poster-too-hard),
[`poster-computers`](poster-computers), [`poster-cold-light`](poster-cold-light),
[`poster-checking`](poster-checking), read in full including SVG text, and checked against
`fig-boundary-and-big-five.md`, `fig-results.md`, `logic-scheduler-prototype.md`,
`lasercool.md`, `logic-bloch-gates.md`, `fig-fhe.md`, `fig-cluster-map.md`,
`logic-models-vs-epistemic.md` and `fig-wirohsh.md`. Two questions were asked: did any
simplification become false, and does each poster land on a twelve-year-old in fifteen seconds
from across a room.

## 1. Verdict table

| # | Poster | Accurate | Lands in 15 s | Comment |
|---|---|---|---|---|
| 1 | truth-ball / THE TRUTH BALL | qualified | no | Headline is a topic, not a claim. The real payload (two kinds of not knowing) sits at 55 % of the way down. "Spinning it sideways means NOTHING" arrives with no set-up a child could use. |
| 2 | truth-ball / SOME QUESTIONS HAVE NO ANSWER | yes | yes | The liar vs Goedel split is done correctly and the "what it does NOT say" box is the best guard in the set. The skip line names exactly the three hypotheses the theorem needs. |
| 3 | too-hard / TWO SAFE INGREDIENTS | yes | yes | Picture carries the whole argument. "It can answer every question" is rescued by the skip line's "what counts as a question". The squares twist is correct (Presburger plus the set of squares defines multiplication). |
| 4 | too-hard / WHAT DO YOU NEED TO ASSUME | qualified | no | Headline is a question. Five rungs of abstract paraphrase, then the actual idea (the house) two-thirds down. The word "simple" is carrying the whole conservativity restriction. Weakest poster. |
| 5 | computers / FOUR WAYS IN, TWO WAYS OUT | qualified | yes | Best picture in the set: three arrows crowding into NO is the proof. One line is wrong as stated: "warms the room by a tiny fixed amount" (Landauer is a floor, see §2). |
| 6 | computers / MATHS INSIDE A LOCKED BOX | yes | yes | Gloves-in-a-box carries it. "minutes" is the hybrid-on-CPU figure, not the 37 s BERT figure, but the skip line says the speed depends on the sum. The empty lane matches `fig-fhe`: no end-to-end pure-FHE generative datapoint. |
| 7 | cold-light / HOW TO FREEZE SOMETHING WITH A LIGHT BEAM | qualified | qualified | Doppler mechanism, siren analogy and "the light is not cold" are all right. "Millions of tiny shoves later, it stops" is off by 1 to 3 orders of magnitude and it does not stop (see §2). 1880 px tall: four parts is a leaflet, not a poster. |
| 8 | cold-light / WHERE DOES THE MESS GO? | yes | qualified | The 7-blocks-vs-3-blocks bar is exactly `lasercool.md` §3 (10^7 folklore vs 10^3 for Rb87, margin set by the atom side). "Atoms are bad at it" is the essay's actual finding, correctly attributed. Too tall (2070 px). |
| 9 | checking / KNOWING WHICH ONES ARE IMPOSSIBLE | qualified | qualified | Numbers are right (19.98 vs 17.57 at zero independents, cost 80). But the race is the one row where checking cannot possibly win, and the poster does not say so while its own second line says "some of the questions are impossible" (see §2). |
| 10 | checking / HOW TO FIND OUT YOU WERE WRONG | yes | yes | 5 to 2, 4 to 1, 2 to 1 all trace to named essays. "Six killed their own idea" matches the cluster-map honour roll; "one killed the idea it was created to support" is `z2-grading`. |

Tally: 5 accurate, 5 qualified, 0 wrong outright, 3 lines that must change.

## 2. What is actually wrong and must change

1. **checking, poster 1: the race hides the two conditions that decide it.** The bar pair
   (20.0 vs 17.6) is `logic-scheduler-prototype.md` §2, row `independent fraction 0.00`, column
   "buying at cost 80". So the checker lost in a pile with **no impossible questions at all**,
   paying **twice an ordinary attempt** (80 against a mean proof cost of 40) for each check. The
   poster's second line says "Some of the questions are impossible", so a reader assumes the race
   had some and the checker still lost. That reading is false: at fraction 0.20 and budget 1500
   the checker at cost 0 wins by 21.5 %. Fix, one label under the race: change
   `The race, actually run:` to `The race, actually run, with NO impossible ones in the pile:`
   and change the caption `questions finished in the same time` to
   `questions finished in the same time, checking cost double`. The headline stays true; the
   race then illustrates the bullet "Checking costs time too" honestly.

2. **cold-light, poster 1: "Millions of tiny shoves later, it stops."** `lasercool.md` §3 counts
   5098 scattering events to bring Rb87 from 3.14 K to the Doppler temperature; from an oven beam
   at a few hundred m/s it is a few times 10^4 (v / v_rec with v_rec = 5.885 mm/s). Not millions.
   And it does not stop: the skip line already admits a coldest temperature. A physicist reads
   "stops" as a Doppler-limit error. Fix: `Thousands of tiny shoves later, it has nearly stopped.`

3. **computers, poster 1: "Every bit you throw away warms the room by a tiny fixed amount."**
   Landauer is a lower bound, k_B T ln 2, and it scales with temperature; a real erasure
   dissipates more, which is what the skip line then says. "Fixed amount" asserts an equality.
   Fix: `Every bit you throw away warms the room by at least a tiny amount.` The next line,
   "Nobody gets out of paying", is then exactly right.

Everything else I checked survives. Specifically, for the flagged high-risk items:

- **Goedel poster.** "This sentence cannot be PROVED" is the right sentence and the liar is
  correctly shown as spinning. "If you could prove it, you would have proved something FALSE"
  plus the skip line's "rules must not fight each other" is the consistency argument in plain
  words, and it is sound (provable G gives provable not-G via a true Sigma-1 sentence). "In ANY
  rulebook big enough to do ordinary arithmetic, plus and times" states the strength condition;
  "a list a machine can check" states effectiveness; "true means true of counting" pins the
  standard model. "It rules out ONE thing: a rulebook that settles it all" does not overstate
  incompleteness. "Everything you meet in maths class still works fine" is true. No falsehood.
- **Boundary poster.** Presburger (addition) and Skolem (multiplication) are each decidable;
  the pair is not; the squares predicate restores multiplication (`fig-boundary` §3,
  machine-checked as `next_square_forces`). "It can answer every question" is only true for
  questions phrasable in that language, and the skip line names exactly that gap. "Proved
  impossible, back in the 1930s" is Goedel 1931 and Church 1936. Accurate.
- **Two-storey house.** "Every simple fact the weak floor could prove before is exactly what it
  can prove now" is Harrington's Pi-1-1 conservativity of WKL_0 over RCA_0 with "simple fact"
  standing in for the sentence class. The word "simple" is load-bearing and a child will not
  read it as a restriction, but the poster never says "everything", and "Gain no new simple
  facts" is the correct direction. Qualified, not wrong. I do not ask for the class to be named;
  that would be nuance, not correction.
- **Laser cooling thermodynamics.** Red detuning stated as "an atom flying TOWARDS the beam sees
  just the right colour": correct sign. Siren drawn with squashed waves ahead of the ambulance
  (spacing 18) and stretched behind (spacing 30), arrow pointing the right way. "The atoms hand
  their motion over to the light, which leaves carrying it" is the energy balance. Poster 2's
  "there is never less of it than you removed" is the second law stated without a loophole, and
  "counted per particle of light" in the skip line is the essay's actual unit. Only item 2 above
  is wrong.
- **Give-up numbers.** 20.0 / 17.6 (19.98 / 17.57), "up to 53 per cent", "about a quarter"
  (break-even / 40 = 0.25 at budget 1500, fraction 0.40), "between nothing and about 5 per cent"
  at large budget, minus 12.1 % at zero independents: all match `logic-scheduler-prototype.md`
  and `fig-results.md`. Only the framing in item 1 is the problem.

## 3. The fifteen-second test, honestly

Headlines that are claims: 2, 3, 5, 9, 10, and 8's subhead. Topics or questions: 1 ("THE TRUTH
BALL"), 4 ("WHAT DO YOU NEED TO ASSUME?"), 6 ("Maths inside a locked box", which the gloves
picture rescues), 7 ("How to freeze something with a light beam", a how-to, which is fine).

Pictures that carry the argument without the text: 3 (two green boxes feeding a hatched red one),
5 (three arrows into NO), 6 (gloves into a padlocked box), 10 (five arrows vs one source). Pictures
that decorate: 1 (a ball with labels does not show why the edge and the centre differ), 4 (a
ladder of sentences), 9 (two crossing lines, which needs both axis labels read to mean anything).

Jargon left unexplained: "conservativity result" (4), "the Doppler effect" (7, but it is named
after being explained, which is the right order), "entropy" only in the small kicker of 8. Nothing
else. That is a good result for ten posters.

Type: body 24 to 27 px on a 700 px viewBox is 3.5 % of width, headlines 44 to 54 px are 6 to 8 %.
At A3 that is 15 mm body and 30 mm headline: headline reads at 3 m, body at 1 m. Right for a poster
whose headline is the payload (2, 3, 5, 10), wrong for the ones whose payload is in the body (1,
4, 7, 8, 9). Heights of 1600 to 2070 px at 700 wide are 2.3 to 3 aspect ratios: 7 and 8 are
four-part leaflets and would be two posters each if the rule were enforced.

Read in the wrong order: 2, 3, 5, 6, 10 survive, every box is self-contained. 1 does not (the
"two kinds" boxes need the ball, the squash panel needs the "two kinds"). 4 does not (the house is
meaningless until you know rung 2 is a rung). 9's bullets survive alone, which is why item 1
above matters: the race is the part a reader will look at first.

**Weakest poster: 4, the ladder.** A question for a headline, five rungs whose paraphrases are
opaque to a twelve-year-old ("Gather the numbers you describe", "Quiz every collection at once"
carry no meaning without the real names they replace), two examples per rung that a child cannot
recognise as theorems, and the one genuinely surprising idea, the house, at y = 1128 of 1620. It
is a summary of `fig-boundary` §5 to §7 shrunk, not a poster built around one claim. The fix is
structural rather than textual, so I only name it: lead with the house and the sentence "Borrow a
strong tool. Gain no new simple facts", and let the ladder be a small side panel.

## 4. Skip lines

Doing real work: 2 (names all three hypotheses), 3 (names the "what counts as a question" gap
its own headline depends on), 8 (one atom, one beam, per-photon counting, whole-universe scope:
every one of these is a way the number could be misused), 1 (admits the triangle conflates two
cases, which is the cluster's own `report_conflates`). Partly: 5 and 6 (name the gate and the
"box is arithmetic", both useful; 5's heat line is doing the work item 3 asks of the body). Thin:
4 ("the real names" and "a special language" admit nothing the poster claimed), 9 ("a computer
simulation with pretend homework" is honest but the thing that needed admitting is item 1), 10
("which claims these were" is a pointer, not an admission, though here there is little to admit).

## 5. Best poster

**3, TWO SAFE INGREDIENTS. ONE DANGEROUS MIXTURE.** The headline is a claim, the picture is the
proof (two plain boxes, an arrow each, a hatched red box), the body says "not 'nobody has managed
it yet', proved impossible" which is the distinction that matters, the twist panel adds a genuine
surprise from the repo's own Lean file without breaking the frame, and the skip line names the
exact place where a pedant would object. A twelve-year-old gets "two safe things make a dangerous
one" in three seconds and "the line is thinner than you think" in fifteen. Close second: 5, whose
picture is a complete proof by counting.

## 6. Verdict

The exercise held its line: of ten posters, none says anything a knowledgeable reader would call
wrong in its main claim, and the three lines that must change (a race presented without the two
conditions that decided it, "millions" for thousands with "stops" for a Doppler floor, and "fixed"
for a lower bound) are each a one-line edit that leaves the poster's idea intact. The Goedel and
boundary posters, the two with the most room to go wrong, are the two most careful. The cost was
paid instead on the second question: five of ten do not land in fifteen seconds, and the pattern
is the same each time, a topic headline over a body that is a compressed essay. The ladder poster
should be rebuilt around the house; the two cold-light posters should be halved; the truth-ball
poster should lead with "there are TWO kinds of not knowing" and let the ball illustrate it. None
of that is a request for nuance. It is a request to move the claim to the top.
