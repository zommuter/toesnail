---
title: The map of the Bloch Truth cluster
permalink: /dreamed/fig-cluster-map
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself.

# The map

Nineteen pages of the 2026-09-07 "Bloch Truth" session are drawn here: 17 essays in three waves,
plus the two ratified follow-ups. **Everything mapped on this page is UNRATIFIED exploration, with
exactly one exception: the four rulings D1 to D4 of
[`2026-09-07-1508-bloch-truth-rulings`](../meeting-notes/2026-09-07-1508-bloch-truth-rulings.md),
which the owner settled in session.** Ratifying a decision is not ratifying the essay that argued
for it, and no verdict below has any authority over the theory.

The reason the cluster is worth a map rather than a list is that the essays **argued with each
other**. Three of the four speculative essays killed their own constructions, one essay refuted the
recommendation that created it, one follow-up dissolved the lead it was commissioned to verify, and
an audit essay corrected three siblings on prior art. Every claim below is sourced to a named essay.

---

## 1. The argument graph

Columns are waves, left to right. Six edge types, each with its own dash pattern **and** arrowhead
so the drawing does not depend on colour.

<div style="overflow-x:auto">
<svg viewBox="0 0 1240 830" style="min-width:1000px" role="img" xmlns="http://www.w3.org/2000/svg">
<title>Directed graph of the 19 Bloch Truth pages, with edges typed as builds-on, corrects, refutes-own-parent, self-refutes, converges-with and adjudicates</title>
<defs>
  <marker id="mTri" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#c05621"/></marker>
  <marker id="mTriR" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#a01b1b"/></marker>
  <marker id="mV" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse"><path d="M0,1 L9,5 L0,9" fill="none" stroke="#98a2b3" stroke-width="1.8"/></marker>
  <marker id="mSq" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><rect x="1" y="1" width="8" height="8" fill="#ffffff" stroke="#3b3f9e" stroke-width="2"/></marker>
  <marker id="mDia" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="6" markerHeight="6" orient="auto"><path d="M5,0 L10,5 L5,10 L0,5 z" fill="#17696b"/></marker>
</defs>
<rect x="0" y="0" width="1240" height="830" fill="#fcfcfa"/>
<g font-family="system-ui, sans-serif" fill="#1f2430">

  <g font-size="17" font-weight="700" text-anchor="middle" fill="#6b7280">
    <text x="105" y="30">WAVE 1</text><text x="350" y="30">WAVE 2</text><text x="595" y="30">WAVE 2</text>
    <text x="840" y="30">WAVE 3 (speculative)</text><text x="1085" y="30">RATIFIED FOLLOW-UP</text>
  </g>

  <g stroke-linecap="round" fill="none">
    <g stroke="#98a2b3" stroke-width="1.8" marker-end="url(#mV)">
      <path d="M189,170 L266,100"/><path d="M189,170 L266,230"/>
      <path d="M189,330 L266,352"/><path d="M189,520 L266,520"/>
      <path d="M434,520 L511,520"/><path d="M924,560 L997,560"/>
      <path d="M595,542 C720,650 920,640 1001,568"/>
    </g>
    <g stroke="#17696b" stroke-width="2.4" stroke-dasharray="2 5" marker-start="url(#mDia)" marker-end="url(#mDia)">
      <path d="M434,95 L511,283"/><path d="M434,235 L511,294"/><path d="M350,498 L560,312"/>
      <path d="M105,712 C350,800 700,792 838,586"/>
    </g>
    <g stroke="#3b3f9e" stroke-width="2.4" stroke-dasharray="14 4 3 4" marker-end="url(#mSq)">
      <path d="M511,160 L438,104"/><path d="M511,160 L438,226"/>
    </g>
    <g stroke="#c05621" stroke-width="2.6" marker-end="url(#mTri)">
      <path d="M560,678 C500,620 430,580 394,545"/>
      <path d="M511,700 C480,600 478,320 438,248"/>
      <path d="M511,690 C462,610 466,430 438,368"/>
      <path d="M756,395 L683,395"/>
      <path d="M756,160 L683,160"/>
      <path d="M756,275 L683,287"/>
      <path d="M790,253 C700,70 560,80 438,214"/>
      <path d="M756,560 L683,530"/>
      <path d="M840,538 C1060,420 1000,20 354,73"/>
    </g>
    <g stroke="#a01b1b" stroke-width="2.6" stroke-dasharray="9 5" marker-end="url(#mTriR)">
      <path d="M511,395 L438,360"/>
      <path d="M1001,378 C930,280 760,300 687,387"/>
    </g>
    <g stroke="#a01b1b" stroke-width="2.4" stroke-dasharray="3 3" marker-end="url(#mTriR)">
      <path d="M924,148 C988,126 988,186 928,172"/>
      <path d="M924,263 C988,241 988,301 928,287"/>
      <path d="M924,383 C988,361 988,421 928,407"/>
    </g>
  </g>

  <g font-size="16" text-anchor="middle">
    <g fill="#e8eef5" stroke="#2b5d8a" stroke-width="2">
      <rect x="21" y="148" width="168" height="44" rx="6"/><rect x="21" y="308" width="168" height="44" rx="6"/>
      <rect x="21" y="498" width="168" height="44" rx="6"/><rect x="21" y="668" width="168" height="44" rx="6"/>
    </g>
    <g fill="#1f2430" stroke="none">
      <text x="105" y="176">bloch-poles</text><text x="105" y="336">bloch-gates</text>
      <text x="105" y="526">qutrit-su3</text><text x="105" y="696">weltformel</text>
    </g>
    <g fill="#eaf1e6" stroke="#4a7a3c" stroke-width="2">
      <rect x="266" y="73" width="168" height="44" rx="6"/><rect x="266" y="213" width="168" height="44" rx="6"/>
      <rect x="266" y="333" width="168" height="44" rx="6"/><rect x="266" y="498" width="168" height="44" rx="6"/>
      <rect x="511" y="138" width="168" height="44" rx="6"/><rect x="511" y="268" width="168" height="44" rx="6"/>
      <rect x="511" y="373" width="168" height="44" rx="6"/><rect x="511" y="498" width="168" height="44" rx="6"/>
      <rect x="511" y="678" width="168" height="44" rx="6"/>
    </g>
    <g fill="#1f2430" stroke="none">
      <text x="350" y="101">models-ensemble</text><text x="350" y="241">epistemic-state</text>
      <text x="350" y="361">bloch-phase</text><text x="350" y="526">beyond-su3</text>
      <text x="595" y="155" font-size="15">models-vs-</text><text x="595" y="173" font-size="15">epistemic</text>
      <text x="595" y="296">simplex</text><text x="595" y="401">z2-grading</text>
      <text x="595" y="526">layered-core</text><text x="595" y="706">citation-audit</text>
    </g>
    <g fill="#f7ece0" stroke="#b06a25" stroke-width="2">
      <rect x="756" y="138" width="168" height="44" rx="6"/><rect x="756" y="253" width="168" height="44" rx="6"/>
      <rect x="756" y="373" width="168" height="44" rx="6"/><rect x="756" y="538" width="168" height="44" rx="6"/>
    </g>
    <g fill="#1f2430" stroke="none">
      <text x="840" y="166">complementarity</text><text x="840" y="281">thermodynamics</text>
      <text x="840" y="401">proof-gauge</text>
      <text x="840" y="555" font-size="15">counterfactual-</text><text x="840" y="573" font-size="15">boundary</text>
    </g>
    <g fill="#ede7f6" stroke="#5b4a9e" stroke-width="2">
      <rect x="1001" y="373" width="168" height="44" rx="6"/><rect x="1001" y="538" width="168" height="44" rx="6"/>
    </g>
    <g fill="#1f2430" stroke="none">
      <text x="1085" y="401">bpi</text>
      <text x="1085" y="555" font-size="15">scheduler-</text><text x="1085" y="573" font-size="15">prototype</text>
    </g>
  </g>

  <g font-size="16">
    <rect x="21" y="756" width="1198" height="58" rx="6" fill="#ffffff" stroke="#d5d8dd"/>
    <g stroke-linecap="round" fill="none">
      <path d="M38,776 L98,776" stroke="#98a2b3" stroke-width="1.8" marker-end="url(#mV)"/>
      <path d="M38,802 L98,802" stroke="#c05621" stroke-width="2.6" marker-end="url(#mTri)"/>
      <path d="M330,776 L390,776" stroke="#a01b1b" stroke-width="2.6" stroke-dasharray="9 5" marker-end="url(#mTriR)"/>
      <path d="M330,802 C378,790 378,814 334,808" stroke="#a01b1b" stroke-width="2.4" stroke-dasharray="3 3" marker-end="url(#mTriR)"/>
      <path d="M700,776 L760,776" stroke="#17696b" stroke-width="2.4" stroke-dasharray="2 5" marker-start="url(#mDia)" marker-end="url(#mDia)"/>
      <path d="M700,802 L760,802" stroke="#3b3f9e" stroke-width="2.4" stroke-dasharray="14 4 3 4" marker-end="url(#mSq)"/>
    </g>
    <text x="108" y="781">builds on</text><text x="108" y="807">corrects (or locates a gap in)</text>
    <text x="400" y="781">refutes its own parent</text><text x="400" y="807">self-refutes</text>
    <text x="770" y="781">converges with</text><text x="770" y="807">adjudicates (and corrects both)</text>
  </g>
</g>
</svg>
</div>

**Reading the graph.** `z2-grading` refutes `bloch-phase`, the essay whose one unfollowed
recommendation created it, using the parent's own idempotence lemma. `bpi` does the same a rung
further out: ruling D4.1 commissioned it to verify `z2-grading` section 4.3, and it dissolved the
lead. `models-vs-epistemic` adjudicates the two halves of the mixed-state fork and corrects both.
`citation-audit`, the only page with no Lean companion, corrects three siblings.

**Edges dropped for legibility, stated rather than hidden.** Four. `thermodynamics` corrects
**four** siblings on one point, that the order parameter is the truth lean and not the settledness;
only the edges to `simplex` and `epistemic-state` are drawn, the others go to `models-ensemble` and
`models-vs-epistemic`. `proof-gauge` corrects `z2-grading` **twice**, drawn as one edge.
`layered-core` also builds on `bloch-poles` section 7.1, and every later essay names `weltformel` as
a sibling; neither is drawn. The four-way convergence D1 rests on is in panel 4 instead, because
drawing it would have crossed the whole figure.

---

## 2. The self-refutation honour roll

The distinctive property of this cluster. Six pages killed something of their own.

| Page | What died | Why |
|---|---|---|
| `complementarity` | nine invented complementary pairs, all nine | any two two-valued questions about a sentence admit a joint distribution, and the joint cell **is** the conjunction (`no_logical_complementarity`) |
| `proof-gauge` | its own invented gauge theory of proofs | a discrete connection over a nonempty base is flat iff it has a potential, and confluence plus strong normalisation hands you that potential as the normal form. Over a set base the holonomy dies on every loop |
| `thermodynamics` | its own brief's premise, that settledness is an order parameter | on random 3-SAT it is a smooth sigmoid in budget and **non-monotone** in clause density, dipping at the hardness peak. Invented in order to be tested, and the test refuted it |
| `z2-grading` | its parent's recommendation, "look for a Z2 grading" | the parent's own idempotence lemma is uniform in the codomain group, so plus-or-minus-one collapses exactly as the circle does |
| `bpi` | the lead D4.1 sent it to verify | the Lindenbaum-Tarski algebra of a countable language is countable, so a prime ideal is built in ZF alone. Nothing is left for a choice principle to do |
| `scheduler-prototype` | its own first measurement | with no revival the run left up to a third of its budget unspent, so no arm was budget-limited. Adding revival moved the timeout arm from disastrous to exactly tied |

Two more pages argue against their own interest without dying. `epistemic-state`, whose whole case
is a quantum reading, concedes that the quantum structure is not needed. `models-ensemble` self-
reports the fatal limit of its own direction: a coherent measure gives probability 1 to every
theorem, so direction (i) has independence but never ignorance.

---

## 3. Did the headline survive?

One glyph per page. Verdicts are this figure's own reading of what the cluster and the rulings did
to each headline, not a ruling in themselves.

<div style="overflow-x:auto">
<svg viewBox="0 0 1240 428" style="min-width:1000px" role="img" xmlns="http://www.w3.org/2000/svg">
<title>Verdict strip: for each of the 19 pages, whether its headline claim landed as confirmed, refuted, narrowed or superseded</title>
<defs>
  <g id="gC"><circle cx="12" cy="12" r="11" fill="#2f6b35"/><path d="M6,12 L10,17 L18,7" stroke="#ffffff" stroke-width="2.6" fill="none"/></g>
  <g id="gR"><rect x="1" y="1" width="22" height="22" rx="3" fill="#a01b1b"/><path d="M7,7 L17,17 M17,7 L7,17" stroke="#ffffff" stroke-width="2.6"/></g>
  <g id="gN"><circle cx="12" cy="12" r="11" fill="#ffffff" stroke="#9a6b00" stroke-width="2.4"/><path d="M12,1 A11,11 0 0,1 12,23 z" fill="#9a6b00"/></g>
  <g id="gS"><path d="M12,1 L24,12 L12,23 L0,12 z" fill="#ffffff" stroke="#4a5568" stroke-width="2.4"/><path d="M3,12 L21,12" stroke="#4a5568" stroke-width="2.4"/></g>
</defs>
<rect x="0" y="0" width="1240" height="428" fill="#fcfcfa"/>
<g font-family="system-ui, sans-serif" font-size="16" fill="#1f2430">
  <g transform="translate(20,26)">
    <use href="#gC"/><text x="32" y="18">CONFIRMED, 9</text>
    <g transform="translate(215,0)"><use href="#gR"/><text x="32" y="18">REFUTED, 3</text></g>
    <g transform="translate(400,0)"><use href="#gN"/><text x="32" y="18">NARROWED, 6</text></g>
    <g transform="translate(600,0)"><use href="#gS"/><text x="32" y="18">SUPERSEDED, 1</text></g>
  </g>
<g transform="translate(20,74)"><use href="#gC"/><text x="32" y="18" font-weight="600">weltformel</text><text x="230" y="18" font-size="15" fill="#4a5568">two located errors stand; converges with counterfactual-boundary</text></g>
<g transform="translate(20,110)"><use href="#gS"/><text x="32" y="18" font-weight="600">bloch-poles</text><text x="230" y="18" font-size="15" fill="#4a5568">pole assignment survives; D1 demotes its ball to exposition</text></g>
<g transform="translate(20,146)"><use href="#gC"/><text x="32" y="18" font-weight="600">bloch-gates</text><text x="230" y="18" font-size="15" fill="#4a5568">no rotation-covariant order on the equator; cited by D1</text></g>
<g transform="translate(20,182)"><use href="#gC"/><text x="32" y="18" font-weight="600">qutrit-su3</text><text x="230" y="18" font-size="15" fill="#4a5568">the qutrit body is not a ball; the dimension count was right</text></g>
<g transform="translate(20,218)"><use href="#gN"/><text x="32" y="18" font-weight="600">models-ensemble</text><text x="230" y="18" font-size="15" fill="#4a5568">adjudicated against, then strengthened by Tennenbaum</text></g>
<g transform="translate(20,254)"><use href="#gN"/><text x="32" y="18" font-weight="600">epistemic-state</text><text x="230" y="18" font-size="15" fill="#4a5568">adjudicated in favour, then priced negative by the prototype</text></g>
<g transform="translate(20,290)"><use href="#gN"/><text x="32" y="18" font-weight="600">models-vs-epistemic</text><text x="230" y="18" font-size="15" fill="#4a5568">its report triangle became D1; its "name a pair" framing corrected</text></g>
<g transform="translate(20,326)"><use href="#gR"/><text x="32" y="18" font-weight="600">bloch-phase</text><text x="230" y="18" font-size="15" fill="#4a5568">recommendation refuted; its negative result survives and D1 cites it</text></g>
<g transform="translate(20,362)"><use href="#gC"/><text x="32" y="18" font-weight="600">beyond-su3</text><text x="230" y="18" font-size="15" fill="#4a5568">flat antichain, no connectives; its GL route feeds D3</text></g>
<g transform="translate(20,398)"><use href="#gC"/><text x="32" y="18" font-weight="600">simplex</text><text x="230" y="18" font-size="15" fill="#4a5568">built the object; D1 makes its shadow the real one</text></g>
<g transform="translate(640,74)"><use href="#gN"/><text x="32" y="18" font-weight="600">z2-grading</text><text x="215" y="18" font-size="15" fill="#4a5568">refutation stands; its own BPI lead dissolved</text></g>
<g transform="translate(640,110)"><use href="#gN"/><text x="32" y="18" font-weight="600">layered-core</text><text x="215" y="18" font-size="15" fill="#4a5568">a fourth channel was missing; D3 builds it anyway</text></g>
<g transform="translate(640,146)"><use href="#gC"/><text x="32" y="18" font-weight="600">citation-audit</text><text x="215" y="18" font-size="15" fill="#4a5568">11 corrections applied; it drove D2</text></g>
<g transform="translate(640,182)"><use href="#gC"/><text x="32" y="18" font-weight="600">complementarity</text><text x="215" y="18" font-size="15" fill="#4a5568">confirmed as a negative; nine inventions dead</text></g>
<g transform="translate(640,218)"><use href="#gC"/><text x="32" y="18" font-weight="600">counterfactual-boundary</text><text x="215" y="18" font-size="15" fill="#4a5568">its design constraint binds D3</text></g>
<g transform="translate(640,254)"><use href="#gR"/><text x="32" y="18" font-weight="600">proof-gauge</text><text x="215" y="18" font-size="15" fill="#4a5568">construction flat; two corrections survive it</text></g>
<g transform="translate(640,290)"><use href="#gR"/><text x="32" y="18" font-weight="600">thermodynamics</text><text x="215" y="18" font-size="15" fill="#4a5568">self-declared costume; one real theorem kept</text></g>
<g transform="translate(640,326)"><use href="#gC"/><text x="32" y="18" font-weight="600">bpi</text><text x="215" y="18" font-size="15" fill="#4a5568">confirmed as a negative; the honest home is weak Koenig</text></g>
<g transform="translate(640,362)"><use href="#gN"/><text x="32" y="18" font-weight="600">scheduler-prototype</text><text x="215" y="18" font-size="15" fill="#4a5568">the fork is a purchase, not free information</text></g>
</g>
</svg>
</div>

---

## 4. What changed the owner's mind

The four rulings, each with the one finding that drove it. **These four are ratified.**

| Ruling | What was decided | The finding behind it |
|---|---|---|
| **D1** | keep the Bloch ball for exposition only; the report triangle (z-magnitude at most r, r at most 1) is the object, and the azimuth is labelled gauge | **the driver originally cited here is WITHDRAWN as invalid** (orthogonal states clone freely in quantum theory, so copying a published proof separates nothing; see `fig-the-object` and `review-essays` HIGH 1). D1 stands on what it was actually taken on: four essays independently found the azimuth carries no logical content, so the ball has a coordinate the logic never uses |
| **D2** | `id:4bb2` unblocked, thesis ruled: Bloch Truth adds a **provability reading** to a geometry already published | `citation-audit` verified Sperling and Walmsley 2018 section IV.3, which already draws the poles, the undecidable equator and the double cone. No provability predicate appears anywhere in it |
| **D3** | build a minimal scheduler that reads the reports and allocates proof-search budget | the fork between direction (i) and direction (ii) is exactly whether "proved undecidable, stop" and "got nowhere yet, spend budget" are the same point. `counterfactual-boundary` then bound the design: a core that cannot interpret arithmetic cannot represent proofs at all, so the core gets decidable equality on opaque atoms and nothing else |
| **D4** | pursue three follow-ups: the BPI lead, the Tennenbaum strengthening, and the `/dreamed` render-coverage gap `id:8b1c` | `z2-grading` section 4.3 flagged the BPI convergence as striking and unverified; `counterfactual-boundary` located the missing Tennenbaum caveat; a parallel relay review found the published dreamed pages carried zero render-test coverage |

Recorded as deliberately **not** decided: the (i) versus (ii) fork itself, which D3 turns into an
empirical question; and reinstating the ball, which stays a live option available to anyone who can
name a pair of questions about a sentence that cannot be answered at once.

---

## 5. What was new, and what was already published

<div style="overflow-x:auto">
<svg viewBox="0 0 1240 400" style="min-width:1000px" role="img" xmlns="http://www.w3.org/2000/svg">
<title>Prior art panel: what the cluster contributed versus what it rediscovered, with the citation audit tally of 37 items</title>
<rect x="0" y="0" width="1240" height="400" fill="#fcfcfa"/>
<g font-family="system-ui, sans-serif" fill="#1f2430" font-size="16">
  <rect x="20" y="20" width="580" height="250" rx="8" fill="#eaf1e6" stroke="#4a7a3c" stroke-width="2"/>
  <text x="44" y="52" font-size="19" font-weight="700">NEW, as far as the sweeps could tell</text>
  <text x="44" y="86">the provability reading itself: no provability predicate</text>
  <text x="44" y="110">anywhere in the published geometry</text>
  <text x="44" y="144">no rotation-covariant order on the equator</text>
  <text x="44" y="178">a Boolean ring has no odd part, for any grading group</text>
  <text x="44" y="212">the broadcasting refutation of the ball applied to proofs</text>
  <text x="44" y="236" font-size="15" fill="#4a5568">(WITHDRAWN 2026-09-07: invalid, it was shot down. See review-essays.)</text>

  <rect x="640" y="20" width="580" height="250" rx="8" fill="#f2ece2" stroke="#8a6a3c" stroke-width="2"/>
  <text x="664" y="52" font-size="19" font-weight="700">ALREADY PUBLISHED</text>
  <text x="664" y="86">the geometry: Sperling and Walmsley, Phys. Rev. A 97,</text>
  <text x="664" y="110">062327 (2018), section IV.3 "True, false, and undecidable"</text>
  <text x="664" y="144">the architecture: proof-carrying code (Necula and Lee 1998),</text>
  <text x="664" y="168">Milawa's eleven-level tower, partial reflection schemas</text>
  <text x="664" y="192">(Harrison, SRI CRC-053, 1995), LCF-style kernels</text>
  <text x="664" y="226">the simplex-iff-compatible equivalence, and the</text>
  <text x="664" y="250">three-status fragment, which is Kleene K3 relabelled</text>

  <text x="20" y="316" font-size="19" font-weight="700">The citation audit, 37 items checked</text>
  <g>
    <rect x="20" y="334" width="907" height="34" fill="#2f6b35"/>
    <rect x="927" y="334" width="162" height="34" fill="#a01b1b"/>
    <rect x="1089" y="334" width="131" height="34" fill="#9a6b00"/>
    <g fill="#ffffff" font-size="16" text-anchor="middle">
      <text x="473" y="357">28 CONFIRMED</text><text x="1008" y="357">5 WRONG</text><text x="1154" y="357">4 UNRESOLVED</text>
    </g>
  </g>
  <text x="20" y="390" font-size="15" fill="#4a5568">All 11 recommended corrections were applied. The two audited Faizal papers came out clean, both quoted lines verbatim on the stated pages.</text>
</g>
</svg>
</div>

The honest summary the audit itself reached: **the geometry is published prior art from 2018, the
logic is not.** The failure mode that produced the cluster's earlier, wrong "no prior art" claim is
worth more than the correction: an abstract that is silent plus a full-text fetch that failed was
treated as evidence of absence. It is evidence of nothing.

---

## Surfaced for the owner

Nothing on this page is filed anywhere. It is a reading of `docs/dreamed/`, drawn to make the
cluster's internal argument visible; the verdict glyphs in panel 3 are this figure's judgement and
carry no more authority than the essays they summarise. The rulings in panel 4 are quoted from the
meeting note and are the only ratified content here.
