---
title: How the Bloch ball became a triangle
permalink: /dreamed/fig-the-object
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself.

# The object

This page is a picture of one argument, drawn in the order the Bloch Truth cluster actually made
it: start from a ball whose poles are truth values, find that two of its three coordinates carry
logical content and the third carries none, and watch the ball flatten into a triangle that says
exactly the same thing. Everything drawn here is **unratified** exploration from
[`docs/dreamed/`](./README.md), with one exception: the outcome in the last panel is **D1 of
[`2026-09-07-1508-bloch-truth-rulings`](../meeting-notes/2026-09-07-1508-bloch-truth-rulings.md),
which the owner ratified.** Every number and label below is sourced to a named sibling essay.

---

## 1. The starting picture, and the pole assignment that failed

<div style="overflow-x:auto">
<svg viewBox="0 0 700 430" role="img" xmlns="http://www.w3.org/2000/svg">
<title>Two candidate pole assignments: provable versus not provable works, true versus unprovable fails because Goedel's sentence occupies both poles</title>
<g font-family="system-ui, sans-serif" text-anchor="middle" fill="#1f2430">
  <text x="175" y="34" font-size="24" font-weight="700">EXCLUSIVE AND EXHAUSTIVE</text>
  <circle cx="175" cy="215" r="100" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <ellipse cx="175" cy="215" rx="100" ry="27" fill="none" stroke="#2b5d8a" stroke-width="2" stroke-dasharray="6 6"/>
  <circle cx="175" cy="115" r="11" fill="#1f2430"/>
  <circle cx="175" cy="315" r="11" fill="#1f2430"/>
  <text x="175" y="88" font-size="24">provable</text>
  <text x="175" y="352" font-size="24">not provable</text>
  <text x="175" y="400" font-size="24" fill="#6b7280">ratified assignment</text>

  <text x="525" y="34" font-size="24" font-weight="700" fill="#b04a25">NOT EXCLUSIVE: FAILS</text>
  <circle cx="525" cy="215" r="100" fill="#f6e2d8" stroke="#b04a25" stroke-width="3"/>
  <line x1="525" y1="115" x2="525" y2="315" stroke="#b04a25" stroke-width="3" stroke-dasharray="7 7"/>
  <line x1="450" y1="140" x2="600" y2="290" stroke="#b04a25" stroke-width="7" opacity="0.75"/>
  <line x1="600" y1="140" x2="450" y2="290" stroke="#b04a25" stroke-width="7" opacity="0.75"/>
  <circle cx="525" cy="115" r="19" fill="#b04a25"/>
  <circle cx="525" cy="315" r="19" fill="#b04a25"/>
  <text x="525" y="124" font-size="24" font-weight="700" fill="#ffffff">G</text>
  <text x="525" y="324" font-size="24" font-weight="700" fill="#ffffff">G</text>
  <text x="525" y="88" font-size="24">true</text>
  <text x="525" y="352" font-size="24">unprovable</text>
  <text x="525" y="400" font-size="24" fill="#6b7280">G: true AND unprovable</text>
</g>
</svg>
</div>

The poles are **provable / not provable**, not true / false. Per `logic-bloch-poles.md`, that is the
only one of the four candidate assignments that is both exclusive and exhaustive, and the only one
matching an actual two-outcome procedure: run the proof search, ask whether it halts with a proof.
Its price is that the south pole conflates *refutable* with *independent*.

The right-hand failure is worth drawing because it is the natural first guess. Goedel's sentence for
PA is true in the standard model **and** unprovable in PA, so a single sentence would sit at both
poles at once. Antipodal states are perfectly distinguishable, so that is not an approximation, it is
a contradiction in the formalism (`logic-bloch-poles.md`). The same section kills the rescue that
encodes false as $e^{i\pi}\lvert 1\rangle$: global phase is unobservable, so it encodes nothing.

---

## 2. Three coordinates, and what each one is worth

<div style="overflow-x:auto">
<svg viewBox="0 0 700 470" role="img" xmlns="http://www.w3.org/2000/svg">
<title>The Bloch ball's three coordinates: z is the truth lean, r is settledness, the azimuth phi carries no logical content</title>
<g font-family="system-ui, sans-serif" fill="#1f2430">
  <circle cx="170" cy="230" r="115" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <ellipse cx="170" cy="230" rx="115" ry="32" fill="none" stroke="#6b7280" stroke-width="2" stroke-dasharray="6 6"/>
  <line x1="170" y1="230" x2="170" y2="98" stroke="#1f2430" stroke-width="4"/>
  <polygon points="170,88 164,104 176,104" fill="#1f2430"/>
  <text x="146" y="112" font-size="28" font-weight="700">z</text>
  <line x1="170" y1="230" x2="251" y2="149" stroke="#2b5d8a" stroke-width="4"/>
  <polygon points="258,142 244,148 252,156" fill="#2b5d8a"/>
  <text x="222" y="196" font-size="28" font-weight="700" fill="#2b5d8a">r</text>
  <text x="96" y="316" font-size="28" font-weight="700" fill="#6b7280">phi</text>
  <line x1="88" y1="306" x2="152" y2="306" stroke="#b04a25" stroke-width="4"/>

  <rect x="340" y="55" width="350" height="115" rx="10" fill="#ffffff" stroke="#2b5d8a" stroke-width="3"/>
  <text x="360" y="93" font-size="26" font-weight="700">z = which way it leans</text>
  <text x="360" y="127" font-size="24">p(true) = (1 + z)/2</text>
  <text x="360" y="157" font-size="24" fill="#6b7280">a Born probability</text>

  <rect x="340" y="185" width="350" height="115" rx="10" fill="#ffffff" stroke="#2b5d8a" stroke-width="3"/>
  <text x="360" y="223" font-size="26" font-weight="700">r = how settled</text>
  <text x="360" y="257" font-size="24">S = h((1 + r)/2)</text>
  <text x="360" y="287" font-size="24" fill="#6b7280">maximal only at r = 0</text>

  <rect x="340" y="315" width="350" height="115" rx="10" fill="#ececec" stroke="#6b7280" stroke-width="3" stroke-dasharray="8 6"/>
  <text x="360" y="353" font-size="26" font-weight="700" fill="#6b7280">phi = nothing</text>
  <line x1="356" y1="344" x2="530" y2="344" stroke="#b04a25" stroke-width="4"/>
  <text x="360" y="387" font-size="24" fill="#6b7280">no logical content</text>
  <text x="360" y="417" font-size="24" fill="#6b7280">four essays, independently</text>
</g>
</svg>
</div>

The `z` and `r` readings survive the density matrix exactly (`logic-bloch-poles.md`): the truth lean
is a Born probability $p = (1+z)/2$, and settledness is read through the von Neumann entropy
$S = h((1+r)/2)$, which is maximal only at the centre.

The azimuth is a different story, and the four refutations are independent. Named as the ruling names
them: `logic-bloch-gates.md` (no rotation-covariant order exists on a circle, so the angle cannot be
a Kleene or Priest third truth value); `logic-bloch-phase.md` (the owner's own suggestion,
provability, fails with a proof, since box distributes over conjunction, conjunction is idempotent,
and an idempotent group element is the identity); `logic-z2-grading.md` (the surviving sign lives on
*proofs*, not propositions, so it is not a coordinate here at all); and `logic-proof-gauge.md` (that
sign is a potential, not a holonomy, so it is not an azimuth even in the gauge reading).

---

## 3. The collapse

<div style="overflow-x:auto">
<svg viewBox="0 0 700 430" role="img" xmlns="http://www.w3.org/2000/svg">
<title>Projecting out the azimuth collapses each horizontal disc of the Bloch ball to a segment, and the ball to the triangle given by the absolute value of z at most r at most one</title>
<g font-family="system-ui, sans-serif" fill="#1f2430" text-anchor="middle">
  <circle cx="140" cy="225" r="105" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <ellipse cx="140" cy="170" rx="89" ry="18" fill="none" stroke="#6b7280" stroke-width="2" stroke-dasharray="5 5"/>
  <ellipse cx="140" cy="225" rx="105" ry="22" fill="none" stroke="#6b7280" stroke-width="2" stroke-dasharray="5 5"/>
  <ellipse cx="140" cy="280" rx="89" ry="18" fill="none" stroke="#6b7280" stroke-width="2" stroke-dasharray="5 5"/>

  <line x1="278" y1="225" x2="368" y2="225" stroke="#1f2430" stroke-width="9"/>
  <polygon points="382,225 360,213 360,237" fill="#1f2430"/>
  <text x="325" y="192" font-size="24">project out phi</text>
  <text x="325" y="272" font-size="24" fill="#6b7280">(z, r) shadow</text>

  <polygon points="525,340 415,130 635,130" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <line x1="525" y1="340" x2="525" y2="130" stroke="#6b7280" stroke-width="2" stroke-dasharray="6 6"/>
  <text x="392" y="240" font-size="28" font-weight="700" fill="#2b5d8a">r</text>
  <text x="525" y="378" font-size="28" font-weight="700">z</text>
  <text x="350" y="412" font-size="24" fill="#6b7280">the same information, minus the angle</text>
</g>
</svg>
</div>

Because the azimuth says nothing, each horizontal disc of the ball collapses to a segment, and the
ball collapses to the triangle $\lvert z\rvert \le r \le 1$. This is the central frame of the page,
and the point is that the arrow is not a simplification. `logic-models-vs-epistemic.md` checks the
projection in **both** directions (`ball_shadow`, `shadow_sound`): the triangle *is* the ball's
$(z, r)$ shadow, so the ball and the triangle carry the same report and the only thing lost is the
angle.

---

## 4. The four corners

<div style="overflow-x:auto">
<svg viewBox="0 0 700 510" role="img" xmlns="http://www.w3.org/2000/svg">
<title>The four corners of the report triangle: proved at one comma one, refuted at minus one comma one, settled but unlocated at zero comma one, nothing known at the origin</title>
<g font-family="system-ui, sans-serif" fill="#1f2430" text-anchor="middle">
  <polygon points="350,410 150,150 550,150" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <line x1="350" y1="150" x2="350" y2="410" stroke="#6b7280" stroke-width="2" stroke-dasharray="6 6"/>
  <circle cx="150" cy="150" r="10" fill="#1f2430"/>
  <circle cx="550" cy="150" r="10" fill="#1f2430"/>
  <circle cx="350" cy="150" r="10" fill="#b04a25"/>
  <circle cx="350" cy="410" r="10" fill="#1f2430"/>
  <text x="150" y="100" font-size="24" font-weight="700">refuted</text>
  <text x="150" y="128" font-size="24" fill="#6b7280">(-1, 1)</text>
  <text x="350" y="100" font-size="24" font-weight="700" fill="#b04a25">settled but unlocated</text>
  <text x="350" y="128" font-size="24" fill="#6b7280">(0, 1)</text>
  <text x="550" y="100" font-size="24" font-weight="700">proved</text>
  <text x="550" y="128" font-size="24" fill="#6b7280">(1, 1)</text>
  <text x="350" y="452" font-size="24" font-weight="700">nothing known</text>
  <text x="350" y="480" font-size="24" fill="#6b7280">(0, 0)</text>
  <text x="424" y="300" font-size="24" fill="#6b7280" text-anchor="start">unproved</text>
</g>
</svg>
</div>

The four mutually exclusive statuses are proved, refuted, independent and open, with
$z = p_{\text{pr}} - p_{\text{rf}}$ and $r = p_{\text{pr}} + p_{\text{rf}} + p_{\text{ind}}$. They
land on the north pole, the south pole, the equatorial circle and the origin, machine-checked as
`vertex_coords` in `logic-epistemic-state.md`. Both middle statuses have $z = 0$; $r$ alone separates
them, which is the whole reason the second coordinate is needed.

---

## 5. Two facts worth their own panels

**The constraint was never imposed.**

<div style="overflow-x:auto">
<svg viewBox="0 0 700 320" role="img" xmlns="http://www.w3.org/2000/svg">
<title>The four simplex weights as a stacked bar, showing that the absolute value of z is at most r follows from non-negativity of the weights alone</title>
<g font-family="system-ui, sans-serif" fill="#1f2430" text-anchor="middle">
  <text x="350" y="42" font-size="26" font-weight="700">derived, not imposed</text>
  <rect x="90" y="90" width="130" height="62" fill="#2b5d8a"/>
  <rect x="220" y="90" width="90" height="62" fill="#8fb4d0"/>
  <rect x="310" y="90" width="150" height="62" fill="#c9c9c9"/>
  <rect x="460" y="90" width="150" height="62" fill="#ffffff" stroke="#6b7280" stroke-width="3" stroke-dasharray="8 6"/>
  <rect x="90" y="90" width="520" height="62" fill="none" stroke="#1f2430" stroke-width="3"/>
  <text x="155" y="190" font-size="24">proved</text>
  <text x="265" y="190" font-size="24">refuted</text>
  <text x="385" y="190" font-size="24">indep.</text>
  <text x="535" y="190" font-size="24">open</text>
  <line x1="90" y1="212" x2="460" y2="212" stroke="#2b5d8a" stroke-width="3"/>
  <line x1="90" y1="212" x2="90" y2="200" stroke="#2b5d8a" stroke-width="3"/>
  <line x1="460" y1="212" x2="460" y2="200" stroke="#2b5d8a" stroke-width="3"/>
  <text x="275" y="244" font-size="24" fill="#2b5d8a">r = 1 &#8722; open</text>
  <text x="350" y="292" font-size="24">|z| &#8804; r &#8804; 1 from p &#8805; 0 alone</text>
</g>
</svg>
</div>

`logic-simplex.md` gets the owner's geometry back from componentwise non-negativity and nothing else
(`abs_z_le_r`): $\lvert p_{\text{pr}} - p_{\text{rf}}\rvert \le p_{\text{pr}} + p_{\text{rf}} \le r$.
So the ball was enforcing, by construction, a constraint the simplex gets for free.

**The known defect.**

<div style="overflow-x:auto">
<svg viewBox="0 0 700 300" role="img" xmlns="http://www.w3.org/2000/svg">
<title>Two distinct epistemic states, proved independent and certainly decided with no idea which way, both land on the single point zero comma one</title>
<g font-family="system-ui, sans-serif" fill="#1f2430" text-anchor="middle">
  <rect x="25" y="40" width="290" height="80" rx="10" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <text x="170" y="76" font-size="24">proved independent</text>
  <text x="170" y="106" font-size="24" fill="#6b7280">(Cohen-style)</text>
  <rect x="25" y="165" width="290" height="105" rx="10" fill="#f6e2d8" stroke="#b04a25" stroke-width="3" stroke-dasharray="8 6"/>
  <text x="170" y="200" font-size="24">certainly decided,</text>
  <text x="170" y="230" font-size="24">no idea which way</text>
  <text x="170" y="260" font-size="24" fill="#6b7280">Ellsberg's fair coin</text>
  <line x1="325" y1="80" x2="495" y2="142" stroke="#1f2430" stroke-width="4"/>
  <polygon points="508,147 486,140 492,155" fill="#1f2430"/>
  <line x1="325" y1="215" x2="495" y2="158" stroke="#1f2430" stroke-width="4"/>
  <polygon points="508,153 492,146 486,161" fill="#1f2430"/>
  <circle cx="524" cy="150" r="13" fill="#b04a25"/>
  <text x="616" y="145" font-size="24" font-weight="700">(0, 1)</text>
  <text x="616" y="178" font-size="24" fill="#6b7280">one point</text>
  <text x="350" y="294" font-size="24" fill="#6b7280">forced by mixing alone</text>
</g>
</svg>
</div>

`logic-epistemic-state.md` found this by trying to prove the opposite, and reports it as
`report_conflates`: the point $(0,1)$ has two inhabitants. `logic-simplex.md` then upgrades the cost
to an impossibility (`conflation_forced`, `conflation_not_injective`). The ball's $r$ is a **norm**,
so it is convex; the simplex's $r = 1 - p_{\text{open}}$ is **affine**. Any mixing-respecting map
that puts *open* at the centre and *proved* / *refuted* at the poles is non-injective, because in the
ball the centre already *is* the even mixture of the poles. The conflation is not the price of
discarding the azimuth.

---

## 6. Why the ball had to go

<div style="overflow-x:auto">
<svg viewBox="0 0 700 260" role="img" xmlns="http://www.w3.org/2000/svg">
<title>Publishing a proof copies a sentence's status exactly, which is broadcasting, which a non-simplex state space forbids</title>
<g font-family="system-ui, sans-serif" fill="#1f2430" text-anchor="middle">
  <rect x="40" y="60" width="150" height="100" rx="8" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <text x="115" y="120" font-size="24">status</text>
  <line x1="200" y1="105" x2="392" y2="68" stroke="#1f2430" stroke-width="4"/>
  <polygon points="406,65 384,60 388,75" fill="#1f2430"/>
  <line x1="200" y1="115" x2="392" y2="182" stroke="#1f2430" stroke-width="4"/>
  <polygon points="406,187 388,172 384,187" fill="#1f2430"/>
  <rect x="410" y="20" width="150" height="90" rx="8" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <text x="485" y="74" font-size="24">status</text>
  <rect x="410" y="145" width="150" height="90" rx="8" fill="#dce8f2" stroke="#2b5d8a" stroke-width="3"/>
  <text x="485" y="199" font-size="24">status</text>
  <text x="300" y="135" font-size="24" fill="#b04a25">publish</text>
  <text x="350" y="252" font-size="24" fill="#6b7280">a proof copies a status exactly</text>
</g>
</svg>
</div>

The clinching argument needs no geometry. A non-simplex state space is exactly one with **no
broadcasting** (Barnum, Barrett, Leifer and Wilce, Phys. Rev. Lett. **99**, 240501, 2007), so a ball
would assert that a sentence's status cannot be copied. Publishing a proof copies it, exactly and
freely. `logic-complementarity.md` also showed that "name a complementary pair" and "justify the
ball" are the same demand, by published theorem, so the cluster had been running one argument twice.

---

## 7. The ratified outcome

**D1, ratified by the owner on 2026-09-07**
([`2026-09-07-1508-bloch-truth-rulings`](../meeting-notes/2026-09-07-1508-bloch-truth-rulings.md)):
the Bloch ball is kept **for exposition**, the report triangle $\lvert z\rvert \le r \le 1$ is **the
object**, and the azimuth is explicitly labelled **gauge**. Keeping the picture is deliberate and is
not a hedge: Sperling and Walmsley (Phys. Rev. A **97**, 062327, 2018) already draw it, so the
exposition is in published company.

One thing stays **open** on the owner's instruction, recorded there as a live future option rather
than closed: reinstating the ball as the object. It becomes available if, and only if, someone names
a pair of questions about a sentence that cannot be answered simultaneously.
`logic-complementarity.md` invented nine candidates and all nine failed to a single machine-checked
theorem, so the bar is not low. Anyone reopening it should start from the one escape route that essay
identified and could not close: propositions commute, but the *acts of establishing* them may not.
