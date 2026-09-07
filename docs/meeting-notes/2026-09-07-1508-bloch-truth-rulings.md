---
title: Bloch Truth rulings
permalink: /meeting-notes/2026-09-07-1508-bloch-truth-rulings
---

# Bloch Truth cluster -- owner rulings, 2026-09-07 15:08

**Status: RATIFIED BY THE OWNER.** Unlike everything in `docs/dreamed/`, the four decisions
below are settled, not recommendations. They were taken by the owner in session after the
three dreaming waves (`TODO.md` `id:c454`, `id:352a`, `id:e50c`) put the questions to him.

The essays that produced the evidence remain UNRATIFIED and unreviewed. Ratifying a decision
is not ratifying the essay that argued for it.

## Context

Three waves of owner-seeded agent exploration on 2026-09-07 produced 17 essays and 16 Lean
companions on the owner's standing side project **"Bloch Truth"**: reading a qubit's Bloch
ball as a space of logical truth values, with poles for proven-true and proven-false. The
cluster converged, from several unrelated directions, on the conclusion that the ball carries
one coordinate too many. Four questions were put to the owner. All four were answered.

## D1. The ball stays as EXPOSITION; the triangle is the object

**Ruled: keep the Bloch ball for exposition only. The report triangle `{|z| <= r <= 1}` is
the real object. The azimuth is explicitly labelled as gauge.**

The triangle IS the ball's `(z, r)` shadow, so the demotion loses only the azimuth `phi`, and
four essays independently found that `phi` carries no logical content:

- `logic-bloch-gates.md`: no rotation-covariant order exists on a circle, so the azimuth
  cannot be a Kleene or Priest third truth value.
- `logic-bloch-phase.md`: six candidate meanings tested against four filters; the owner's own
  suggestion (provability) fails with a proof, since `box` distributes over conjunction,
  conjunction is idempotent, and an idempotent group element is the identity.
- `logic-z2-grading.md`: the surviving sign lives on **proofs**, not propositions, so it is
  not a coordinate on this space at all.
- `logic-proof-gauge.md`: that sign is a **potential**, not a holonomy, so it is not an
  azimuth even in the gauge reading.

The clinching argument needs no geometry. A non-simplicial state space is exactly one with no
broadcasting (Barnum-Barrett-Leifer-Wilce, PRL **99**, 240501, 2007), so a ball would assert
that a sentence's status cannot be copied. Publishing a proof copies it, exactly and freely.
Separately, `logic-complementarity.md` established that "name a complementary pair" and
"justify the ball" are the SAME demand by published theorem (a state space is a simplex iff
all its measurements are compatible), so the two arguments the cluster had been running were
always one.

Keeping the picture is deliberate and is not a hedge. Sperling and Walmsley (Phys. Rev. A
**97**, 062327, 2018) already draw exactly this picture, so the exposition is in published
company, and the picture is what got the project here.

## D2. `id:4bb2` is UNBLOCKED, with a ratified thesis

**Ruled: the thesis is "Bloch Truth adds a provability reading to a geometry already
published by Sperling and Walmsley (2018)."**

`TODO.md id:4bb2` had been BLOCKED since a 2026-07-17 `.mw` meeting found that no thesis
statement existed anywhere in 412 mined session files. Four incompatible candidates emerged
from this session's waves. The owner chose this one.

Why it is the right one, recorded so the choice is auditable:

- It is honest about the prior art `citation-audit.md` located. Sperling and Walmsley's §IV.3
  is titled *"True, false, and undecidable"* and already places true and false at the Bloch
  poles, an "undecidable" continuum at the equator, and a double cone as the convex hull of
  the classical set.
- It states exactly what is new: **the logic, not the picture.** No provability predicate
  appears anywhere in that paper; its logic vocabulary is an illustrative aside in a
  quantum-optics resource-theory paper.
- It survives D1. The other three candidates were each entangled with a geometry or an
  architecture that this session's rulings partly retired.

**The essay itself remains owner-authored and is NOT to be auto-written.** `id:4bb2`'s
original terms stand: narrative is the owner's domain under the working contract. What this
ruling removes is the blocker, not the authorship constraint.

## D3. Build a small prototype of the layered core

**Ruled: build a minimal scheduler that reads `(z, r)` reports and allocates proof-search
budget.**

Chosen over adopting the prior art outright, and the reason is worth recording: the prototype
settles the cluster's central open fork **empirically rather than by argument**. Reading (i),
the state over models, and reading (ii), the state over epistemic status, differ exactly in
whether "proved undecidable, stop asking" and "got nowhere yet, spend more budget" are
distinguishable states. Under (i) they are the same point (`models_z_zero_forces_origin`);
under (ii) they are the poles-and-origin of the report triangle. A scheduler either can act on
that distinction or it cannot, and building one is the cheapest way to find out.

Known prior art that the prototype should reuse rather than reinvent (`logic-layered-core.md`,
verified there): proof-carrying code (Necula and Lee, PLDI 1998), LCF-style small trusted
kernels, Milawa's eleven-level self-verifying tower, and partial reflection schemas (Harrison,
SRI CRC-053, 1995). This repo already runs a live instance of the pattern in Lean's own kernel.

**Design constraint that binds the prototype**, from `logic-counterfactual-boundary.md`: a core
that cannot interpret arithmetic cannot represent proofs at all, since a proof is a finite
sequence and sequences require pairing. The repair, ruled in session, is to stop asking the
core to be a *complete theory* that talks about proofs and instead make it a *terminating
checker*. The property wanted was never completeness; it is decidability of the checking
relation. Concretely the prototype must give report indices **decidable equality on opaque
atoms only** -- the core needs to know "same sentence or not", never what the sentence says,
and that sits far below the arithmetic cliff. This also answers the fourth channel (the report
index) that `logic-counterfactual-boundary.md` found missing from `logic-layered-core.md`.

## D4. Three follow-ups adopted

**Ruled: pursue all three.**

1. **The BPI lead.** `logic-z2-grading.md` §4.3 found that the Boolean Prime Ideal theorem,
   strictly weaker than full AC, is the choice principle needed to pick a coherent truth
   assignment. If it holds, the owner's original "ZF without C" instinct was pointing at
   something real, just not at completeness (which is what `REVIEW_ME.md id:251e` corrects).
   Flagged there as unverified against prior art, so it needs one focused pass.
2. **Fold in the Tennenbaum strengthening.** `logic-models-ensemble.md` never mentions
   Tennenbaum's theorem and so never states that the *points* of its Stone space are
   individually uncomputable; its wall is about the measure only. Located by
   `logic-counterfactual-boundary.md` and framed there as a strengthening rather than an
   error, since it also closes the "just pick a model and believe it" fallback.
3. **The render-coverage gap `id:8b1c`.** Surfaced by the parallel relay review the same day:
   the published `/dreamed` pages carry zero render-test coverage, on a site where a kramdown
   blank-line slip silently kills equation handles. Tooling only, executor-eligible.

## Filed for later, deliberately not decided now

**Reinstating the ball as the object.** The owner asked that this be recorded as a live future
option rather than closed. It becomes available if, and only if, someone names a pair of
questions about a sentence that cannot be answered simultaneously. That is not a low bar:
`logic-complementarity.md` invented nine candidates, all nine failed to a single machine-checked
theorem (`no_logical_complementarity`), and the demand is provably equivalent to the ball
itself. The one escape route it identified and could not close is that propositions commute
while the **acts of establishing them** may not; its invented Adoption Algebra genuinely fails
to commute (adopting ZF + AC then not-AC differs from the reverse) and still dies, because
order-dependence of *update* is not order-dependence of *evaluation*. Anyone reopening this
should start there.

## What was NOT decided

The `(i)` versus `(ii)` fork itself is left open, deliberately: D3 makes it an empirical
question rather than an argumentative one. The two findings filed for owner ruling in
`REVIEW_ME.md` (`id:251e` the ZF-without-C correction, `id:4787` the `(2^2)!` slip) remain
open there.
