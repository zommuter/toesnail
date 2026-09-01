---
title: The essay wing, and the 2017 parenthesis
permalink: /dreamed/essay-wing
---

> **DREAMED, UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here may be promoted into `physics/` or
> `essays/` without the owner authoring the move. The `\veq` badges below claim something about
> [`lean/EssayWing.lean`](lean/EssayWing.lean) **only**, and are deliberately not wired into
> `physics/*.toml` or `tests/test_verify.sh`.

**Seed (owner-carried, `CLAUDE.md`):** the `gtnsd-archive` orphan branch, "the ~2017
'inflownistration' / information-flow-administration origin", whose Inflownistration section
is flagged as an owner-authored essay candidate (`.mw` `id:aae4`); plus the question of what
the essay wing (`essays/Narrativium.md`, `essays/supertool.md`) is actually *for*.

# 0. Headline

The archive's Inflownistration section is **a good pun carrying a thin thesis**, but the same
single-evening README contains, in a parenthesis inside a task list, a precise statement of
the staleness problem the whole `verify:`/`.mw` machinery now solves. The genuine 2017-to-2026
lineage runs through that parenthesis (and through `essays/supertool.md`, which is a proto-`.mw`
wishlist), **not** through the inflownistration concept itself. The essay wing is one *subject*
(descriptions and their failure modes) but not one *quantity*; the connective thread the seed
proposed holds for half the material and has to be forced onto the other half, and I say where.

# 1. What the archive actually contains

`git ls-tree -r --name-only gtnsd-archive` returns exactly one file: `README.md`. The full
history is 21 commits, root `c9147ce` to tip `353972e`, **every one dated 2017-12-28**. The
"~2017 origin" is a single evening between Christmas and New Year (the text signs off "see you
next year :fireworks:", written by someone unemployed until February 2018, per its own aside).

The README is a stream-of-consciousness diary titled "getting things not-so-done": tool
evaluations (Trello, taiga, Phabricator, org-mode, Abricotine), a confessional about three
Firefox windows of unread tabs, a Steam backlog joke, and a task list. The Inflownistration
section, in full, is one definitional paragraph, four bullets, and a summary sentence. The
load-bearing lines:

> "Inlfownistration, a portmanteau of information flow administration, describes the very
> process of, in a way, _everything_ we do. We're basically always processing information, no
> matter what we do."

(The sole definition site spells it "Inlfownistration", letters swapped.) The four bullets
recast eating, work, tunnel-planning and religion as information processing, and the section
closes: "Somehow everything boils down to some input information ... implied consequences and
our decisions on how to interact".

**Honest assessment: this is thin.** About 120 words, a definition by example, no mechanism,
no consequence, and a thesis ("everything is information processing") that as stated is
near-unfalsifiable; it is Wheeler's "it from bit" mood without the physics that makes Wheeler
citable. The pun is genuinely good and the *instinct* is the one the fleet later ratified
(`.mw` `id:aae4` now records inflownistration as the broad parent concept, with the staleness
DAG as its first narrow instance). But as an essay candidate the section is a title plus an
opening paragraph. The owner has carried it nine years; what he carried is a name and an
instinct, not a draft.

The sentence actually worth nine years of carrying is elsewhere in the same file, in the task
list, as a parenthesis:

> "Add comment and/or annotation system (how will annotations work with content changing over
> time? Maybe this monolith should be shattered)"

That is a precise, technical, correctly-posed problem: annotation anchoring under content
drift, and the follow-up thought (shatter the monolith) is the move toward addressable units
that toesnail's equation handles later make.

# 2. Lineage: genuine or retrofitted?

Split verdict, and the split matters because the two halves are usually welded together.

**Genuine:** parenthesis to tooling. The 2017 worry "how will annotations work with content
changing over time?" is *literally* the problem `tests/test_verify.sh` and the `.mw` DAG solve
for the special case where the annotation is a verification verdict: the sidecar pins each
verdict to a content hash (`claim = "b575864e"` in `physics/Resogram.toml`), and the check
fires when the content moves under it. The corpus-dreaming addendum of 2026-07-07 already
recorded this ("the owner posed `.mw`'s core problem statement nine years before the tool"),
and for the parenthesis that claim is correct. `essays/supertool.md` strengthens the lineage:
its wishlist (source stays simple, code input hidden or shown on demand, "output artifacts
should be kept outside the source document but may still be kept cached in a versioning
friendly manner") is `.mw`'s architecture, stated years before `.mw` existed, down to
instruments-are-source / verdicts-are-cache.

**Retrofitted:** concept to tooling. Nothing in the Inflownistration *section* mentions
change, decay, annotation, or verification. Reading the staleness machinery as the concept's
descendant projects the 2026 tool back onto the 2017 name. The honest statement is: on one
December evening the owner wrote down both a vague grand concept and, separately, a sharp
small problem; the sharp small problem grew into `.mw`; the grand concept contributed the
*name* under which the fleet later filed the family (`id:aae4`'s framing, inflownistration as
parent and staleness DAG as first instance, is a 2026 act of curation, and a reasonable one,
but it is curation, not continuity). "He was interested in information flow, and separately
posed a staleness problem" is the accurate version, with the caveat that both came out of the
same head on the same evening, which is more than coincidence and less than a program.

# 3. Is there one essay wing, or three?

The material: `Narrativium.md` (stories as a force; Pratchett's "they insist on interpreting
the universe as if it's telling a story ... focus on facts that fit the story, while ignoring
those that don't"), `supertool.md` (an Introduction section and then silence: complete
sentences, no body), the omniscience result ([`omniscience.md`](omniscience.md): defeated by
arity via Lawvere, not by physics), and the inflownistration material above. The
[information-wing sibling](information-wing.md) set the discipline: name the single recurring
quantity or admit there is not one.

**There is no single quantity.** The information wing had an identity ($\log W$ is literally
the same formula in all its members). The essay wing has at best a *genus*: every candidate
member is about a **description and a specific way it fails its subject**.

- *Incompleteness* (omniscience): a description held inside the system cannot cover the
  system. This failure is by arity and is **atemporal**; it fails at a frozen instant.
- *Staleness* (inflownistration parenthesis, supertool, the repo's own `verify:` discipline):
  a description true when taken, silently detached from a subject that moved.
- *Capture* (Narrativium): a description that filters its subject to fit its own shape.

The seed proposed the stronger thesis that all of these are "a description going out of date
with respect to what it describes". Tested member by member: exact for staleness; **wrong for
omniscience**, whose obstruction is the diagonal, not bandwidth, and reading it temporally is
precisely the weak "capacity" reading the omniscience essay demotes in its own §1.3; and a
*rereading* for Narrativium, whose Pratchett quote describes selection at reading time, not
decay over time (a story's shape outliving the facts is a defensible gloss, but it is my
gloss, not the essay's content, and half of `Narrativium.md` is about sharing-versus-creating,
not about stories at all). So: **one wing, if the owner wants it, under "what descriptions
cannot do", with three distinct theorem-grade mechanisms; not one thread.** Claiming the
single thread would itself be narrativium: insisting the corpus is telling a story and
ignoring the member that does not fit.

# 4. The formalizable core, proved

The staleness member is the one with real machinery, and its kernel is small enough to
machine-check: **a cached verdict is only as good as the hash it was taken against.**
[`lean/EssayWing.lean`](lean/EssayWing.lean) models a sidecar entry in the shape of
`physics/Resogram.toml` (`tier_floor`, `tiers`, `claim`, `by`) and defines

$$ \mathrm{fresh}(e, h) \;:\iff\; e.\mathrm{claim} = h \veqs{fresh}\lean $$

with four results, none deep, all load-bearing for the design:

1. **A stale entry proves nothing** (`stale_entry_proves_nothing`,
   `verdict_transfer_fails`): a world exists where the recorded claim is true and the
   current claim is false under one and the same entry; the transfer principle "recorded
   true means currently true" is refuted. Freshness is *necessary*.
2. **Freshness suffices exactly as far as the hash does** (`fresh_transfers`): with
   matching hashes the verdict carries over; hash collisions are outside the model, so this
   theorem is exactly as strong as the 8-hex srepr hash is injective in practice.
3. **Both checks are decidable** (`fresh.decidable`, `driftFree.decidable`): freshness is
   hash equality, and `test_verify.sh`'s drift check (sidecar handles a subset of source
   handles) is a finite subset test.
4. **The drift check's asymmetry** (`driftFree_insert_source` vs `removal_orphans`): adding
   a marked equation to the source can never break the subset check; removing one can, with
   a two-element counterexample. Deleting a marked equation silently orphans its
   attestation, which is exactly the failure mode the check exists to catch.

Plus a toy `.mw` DAG: `staleAfterEdit` as reflexive-transitive reachability through
dependency edges, with transitive propagation (`staleAfterEdit_trans`), mirroring
`mathematical_writing.dag.stale_after_edit` as used by the post-commit hook. The repo's own
`edot` incident (one sign fix, four propagated discrepancies, no checker at the time) is this
theorem instantiated.

## Lean attestation

File: `docs/dreamed/lean/EssayWing.lean`. Theorems: `stale_entry_proves_nothing`,
`verdict_transfer_fails`, `fresh_transfers`, `driftFree_insert_source`, `removal_orphans`,
`staleAfterEdit_self`, `staleAfterEdit_of_dep`, `staleAfterEdit_trans`; instances
`fresh.decidable`, `driftFree.decidable`. Checked with

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/EssayWing.lean
```

Exit status 0, zero `sorry`, 2026-09-01.

# 5. Recommendation (the owner's to ratify, with weaknesses)

1. **Archive: keep archived, cite, do not fold.** The branch stays as-is (it is the canonical
   public record per `TODO.md` `id:7f2f`; the fievel mirror is private). Folding the README
   into `essays/` wholesale would import a tab-tree diary; the owner-authored core worth
   adapting is the annotation parenthesis, the Inflownistration section as period colour, and
   the closing solicitation of feedback. The essay-candidate flag already exists in `.mw`
   `id:aae4` ("flagged, not auto-written"); nothing new needs filing. *Weakness:* "keep
   archived" leaves the 2017 coinage invisible to site readers until the owner writes the
   essay, and he has, by his own README's title, a documented relationship with not-so-doing.
2. **If the essay gets written, its honest arc is the split verdict of §2:** "I posed the
   problem in one parenthesis in 2017 and built the answer in 2026", with the grand concept
   as the name it was filed under, not as the thesis. That essay is stronger than the
   flattering version ("my 2017 concept became the tool") *because* it is true, and it ends
   naturally at `.mw` and the sidecar. *Weakness:* it makes the essay partly about tooling,
   and the owner may want essays/ to stay tool-free.
3. **Essay wing thesis, two options.** (A) Adopt "descriptions and their failure modes:
   incompleteness, staleness, capture" as the wing's ordering principle; the repo's own
   `verify:` discipline becomes the staleness chapter's case study. (B) No thesis: the wing
   stays the free wing, defined only as non-mathematical. I recommend **B now, A as an index
   page only if a third essay actually lands**, because §3 shows A requires rereading
   Narrativium and demoting half its content. *Weakness of B:* the wing remains two stubs
   with no reason to grow.
4. **Attachment point for the staleness material:** ROADMAP `id:d973` (annotation system for
   the site). The `removal_orphans` asymmetry is a concrete design input there: anchors must
   be handles, not text offsets, or every edit orphans the overlay's annotations exactly as
   hypothes.is anchors rot. That closes a nine-year loop: the 2017 parenthesis was written
   *about* the very annotation system `id:d973` now plans.

# Surfaced for the owner

- The entire `gtnsd` history is one day, 2017-12-28 (21 commits). `CLAUDE.md`'s "~2017" is
  accurate but the romance of a long-lived repo is not; it was one productive evening.
- The coinage's sole definition site spells it "Inlfownistration" (l/f swapped). If adapted,
  the owner should decide which spelling is canonical; the typo'd form loses "inflow".
- `supertool.md` does not die mid-sentence; it completes its Introduction and stops. Its
  wishlist is close enough to shipped `.mw` that a one-line owner audit (lead 1 below) could
  turn the stub into a satisfying short essay: "I specified this tool in n lines; here is
  what building it actually took."
- Both existing essays end by soliciting the reader: `Narrativium.md` "Well, motivate me.";
  the 2017 README "please feel free to open an issue for any feedback". Same impulse, nine
  years apart: the owner keeps building channels for readers to push him. `id:d973` is the
  third instance. That recurring impulse, not any thesis, may be what the essay wing is for.

# Follow-up leads

1. **supertool-vs-`.mw` audit:** table `supertool.md`'s wishlist against shipped `.mw`
   features; decidable in one short session, and settles whether the stub becomes a
   retrospective essay or a pointer.
2. **`id:d973` anchor experiment:** prototype a hypothes.is overlay on one rendered page,
   then edit the annotated equation; whether the anchor orphans or drifts decides overlay
   versus handle-anchored home-grown, and tests §5.4's claim empirically.
3. **Narrativium ruling:** one owner sentence on whether the Pratchett selection quote is
   meant as caching/compression or as force decides whether `Narrativium.md` joins the
   descriptions genus or stays standalone (and hence A-vs-B in §5.3).
4. **Is the wing thesis itself narrativium?** Decidable by the methodology sibling's test:
   count owner-authored sentences each reading explains; if "descriptions" explains fewer
   lines of `essays/` than "motivation and creation" does, drop A for good.
5. **Self-attestation diagonal:** the sidecar is itself content that nothing attests; add
   the sidecar as a node in the DAG model and ask whether an entry can be fresh *about
   itself* under updates, or whether the Lawvere-style obstruction reappears. A small Lean
   attempt (proof or counterexample) settles whether staleness and incompleteness are two
   mechanisms or one.
