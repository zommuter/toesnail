---
title: The undecidability landscape, and the ladder above it
permalink: /dreamed/fig-boundary-and-big-five
---

# The undecidability landscape, and the ladder above it

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](README.md). This page was assembled by an
> AI agent, not by the owner, and nothing on it is toesnail's theory. It is a **figure page**: a
> visual reference card drawn from two already-written cluster essays,
> [`logic-counterfactual-boundary.md`](logic-counterfactual-boundary.md) and
> [`logic-bpi.md`](logic-bpi.md).

**What is established mathematics and what is not, stated up front, because this page differs from
its siblings.** Almost everything drawn here is textbook material with a named source: Presburger
1929, Mostowski 1952, Tarski 1948, Julia Robinson 1949, Cobham 1969 and Semenov 1977, Fischer and
Rabin 1974, the Big Five of reverse mathematics, Harrington's conservativity theorem, Jockusch and
Soare 1972. None of that is a cluster finding and none of it needs the owner's ratification; it
needs only to be drawn correctly. Exactly three things on this page come from the cluster rather
than from the literature: the **framing** of the boundary as wide-in-expressiveness and
sharp-in-verdict (panel 2), the observation that the crossing is bought **by adding a set** rather
than an operation (panel 3, machine-checked in
[`lean/LogicBoundary.lean`](lean/LogicBoundary.lean)), and the closing recommendation that the Big
Five is the ready-made ladder the layered-core design was groping for (panel 9). Those three are
recommendations awaiting the owner's ruling. The mathematics they rest on is not.

---

## 1. The landscape is a partial order, not a scale

The picture nearly everyone carries is a dial: weak theories at the bottom, strong ones at the top,
incompleteness switching on somewhere in the middle. The bottom of that picture is wrong in a
specific and useful way. **Neither addition nor multiplication alone is fatal.** Presburger
arithmetic, addition with no multiplication, is complete and decidable (Presburger 1929). Skolem
arithmetic, multiplication with no addition, is decidable too (Mostowski 1952, via Feferman-Vaught:
by unique factorisation a number is an exponent vector and multiplication is pointwise addition of
those vectors, so Skolem arithmetic is Presburger arithmetic in disguise). The villain is the pair.

Between the two famous landmarks sits an infinite populated region, and it is **partially** ordered.
Buechi arithmetic of base `k`, which is addition plus the "largest power of `k` dividing `x`"
function, is decidable and strictly stronger than Presburger. By the Cobham-Semenov theorem a
relation definable in base 2 and in base 3 is already Presburger-definable, so base 2 and base 3
are **incomparable**: each defines a set the other cannot. That antichain is why no real-valued
"strength parameter" can index this region.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 480" role="img" aria-labelledby="hasse-title">
<title id="hasse-title">Hasse diagram of the decidability landscape: Presburger arithmetic below, Buechi arithmetic base 2 and base 3 incomparable above it, Skolem arithmetic a fourth incomparable point, and full arithmetic above a cliff</title>
<defs>
<marker id="arrA" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
<path d="M 0 0 L 10 5 L 0 10 z" fill="#3a3a3a"/>
</marker>
</defs>
<rect x="0" y="0" width="860" height="480" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<rect x="24" y="24" width="812" height="128" fill="#f4ece6" stroke="none"/>
<text x="40" y="48" font-size="13" fill="#8a3d12" font-weight="bold">UNDECIDABLE AND INCOMPLETE</text>

<line x1="24" y1="152" x2="836" y2="152" stroke="#a8501e" stroke-width="3" stroke-dasharray="9 5"/>
<text x="40" y="174" font-size="14" fill="#8a3d12" font-weight="bold">THE CLIFF: interprets Robinson's Q</text>
<text x="40" y="192" font-size="12.5" fill="#5c5c5c">Nothing sits on this line. See panel 2.</text>
<text x="40" y="216" font-size="13" fill="#2f6b3f" font-weight="bold">DECIDABLE AND COMPLETE</text>

<rect x="345" y="62" width="180" height="52" fill="#ffffff" stroke="#8a3d12" stroke-width="2.5"/>
<text x="435" y="83" font-size="15" text-anchor="middle" font-weight="bold">⟨ℕ, +, ×⟩</text>
<text x="435" y="102" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Goedel 1931, Church 1936</text>

<line x1="240" y1="258" x2="380" y2="118" stroke="#3a3a3a" stroke-width="1.6" marker-end="url(#arrA)"/>
<line x1="435" y1="258" x2="435" y2="118" stroke="#3a3a3a" stroke-width="1.6" marker-end="url(#arrA)"/>
<line x1="640" y1="258" x2="495" y2="118" stroke="#3a3a3a" stroke-width="1.6" marker-end="url(#arrA)"/>
<line x1="330" y1="392" x2="240" y2="312" stroke="#3a3a3a" stroke-width="1.6" marker-end="url(#arrA)"/>
<line x1="345" y1="392" x2="425" y2="312" stroke="#3a3a3a" stroke-width="1.6" marker-end="url(#arrA)"/>

<rect x="150" y="258" width="180" height="54" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="240" y="279" font-size="14" text-anchor="middle" font-weight="bold">⟨ℕ, +, V₂⟩</text>
<text x="240" y="299" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Buechi, base 2</text>

<rect x="345" y="258" width="180" height="54" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="435" y="279" font-size="14" text-anchor="middle" font-weight="bold">⟨ℕ, +, V₃⟩</text>
<text x="435" y="299" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Buechi, base 3</text>

<rect x="550" y="258" width="180" height="54" fill="#ffffff" stroke="#2d5c8a" stroke-width="2" stroke-dasharray="6 4"/>
<text x="640" y="279" font-size="14" text-anchor="middle" font-weight="bold">⟨ℕ, ×⟩</text>
<text x="640" y="299" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Skolem, Mostowski 1952</text>

<rect x="250" y="392" width="190" height="54" fill="#ffffff" stroke="#2f6b3f" stroke-width="2.5"/>
<text x="345" y="413" font-size="14" text-anchor="middle" font-weight="bold">⟨ℕ, +⟩</text>
<text x="345" y="433" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Presburger 1929</text>

<text x="240" y="336" font-size="12.5" text-anchor="middle" fill="#8a3d12" font-weight="bold">no edge between these two</text>
<text x="435" y="336" font-size="12.5" text-anchor="middle" fill="#8a3d12" font-weight="bold">= INCOMPARABLE</text>
<text x="337" y="356" font-size="12.5" text-anchor="middle" fill="#5c5c5c">(Cobham 1969, Semenov 1977; also bases 5, 7, ... pairwise)</text>
<text x="640" y="336" font-size="12.5" text-anchor="middle" fill="#5c5c5c">dashed: no addition at all,</text>
<text x="640" y="353" font-size="12.5" text-anchor="middle" fill="#5c5c5c">so incomparable with all of them</text>

<text x="470" y="428" font-size="12.5" fill="#5c5c5c">2^(2^cn) proof-length lower bound already here</text>
<text x="470" y="446" font-size="12.5" fill="#5c5c5c">(Fischer and Rabin 1974): decidable is a mathematical</text>
<text x="470" y="464" font-size="12.5" fill="#5c5c5c">property, not an engineering one.</text>
</g>
</svg>

</div>

---

## 2. Two senses of "sharp", and conflating them is the standard error

Ask "is the boundary sharp?" and the honest answer is that the question is two questions with
opposite answers. In **expressive power** it is not sharp and not even a line: panel 1 is the
evidence. In **verdict** it is absolutely sharp. The threshold is interpreting Robinson's Q, and Q
is finitely axiomatised with no induction schema at all. Once a consistent, effectively axiomatised
theory interprets Q it receives the entire package at once: Goedel I, Goedel II, Rosser, Tarski,
Church. Q, PA and ZFC get exactly the same verdict, and there is **no theory that is slightly
incomplete**.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 300" role="img" aria-labelledby="sharp-title">
<title id="sharp-title">Two senses of sharpness: on the left, expressive power is a wide partially ordered region; on the right, the decidability verdict is a step function with nothing on the threshold</title>
<rect x="0" y="0" width="860" height="300" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<rect x="20" y="20" width="400" height="260" fill="#ffffff" stroke="#767676"/>
<text x="36" y="46" font-size="14" font-weight="bold">SENSE 1: expressive power</text>
<text x="36" y="66" font-size="13" fill="#2f6b3f" font-weight="bold">NOT sharp. Not even a line.</text>
<circle cx="150" cy="230" r="9" fill="#2f6b3f"/>
<text x="166" y="235" font-size="12.5">Presburger</text>
<circle cx="100" cy="160" r="9" fill="#2d5c8a"/>
<text x="60" y="150" font-size="12.5">base 2</text>
<circle cx="200" cy="150" r="9" fill="#2d5c8a"/>
<text x="214" y="146" font-size="12.5">base 3</text>
<circle cx="290" cy="170" r="9" fill="#2d5c8a"/>
<text x="230" y="188" font-size="12.5">base 5 ...</text>
<circle cx="345" cy="215" r="9" fill="#2d5c8a" stroke="#1a1a1a" stroke-dasharray="3 2"/>
<text x="300" y="243" font-size="12.5">Skolem</text>
<circle cx="215" cy="95" r="9" fill="#8a3d12"/>
<text x="232" y="99" font-size="12.5">⟨ℕ, +, ×⟩</text>
<line x1="150" y1="221" x2="105" y2="170" stroke="#3a3a3a"/>
<line x1="150" y1="221" x2="198" y2="160" stroke="#3a3a3a"/>
<line x1="150" y1="222" x2="285" y2="179" stroke="#3a3a3a"/>
<line x1="100" y1="151" x2="209" y2="104" stroke="#3a3a3a"/>
<line x1="200" y1="141" x2="214" y2="105" stroke="#3a3a3a"/>
<line x1="290" y1="161" x2="223" y2="103" stroke="#3a3a3a"/>
<line x1="345" y1="206" x2="222" y2="103" stroke="#3a3a3a" stroke-dasharray="4 3"/>
<text x="36" y="272" font-size="12.5" fill="#5c5c5c">An antichain cannot be indexed by a real number.</text>

<rect x="440" y="20" width="400" height="260" fill="#ffffff" stroke="#767676"/>
<text x="456" y="46" font-size="14" font-weight="bold">SENSE 2: the verdict</text>
<text x="456" y="66" font-size="13" fill="#8a3d12" font-weight="bold">ABSOLUTELY sharp. A step.</text>
<line x1="480" y1="240" x2="810" y2="240" stroke="#3a3a3a" stroke-width="1.5"/>
<line x1="480" y1="240" x2="480" y2="90" stroke="#3a3a3a" stroke-width="1.5"/>
<line x1="486" y1="220" x2="640" y2="220" stroke="#2f6b3f" stroke-width="4"/>
<line x1="640" y1="110" x2="804" y2="110" stroke="#8a3d12" stroke-width="4"/>
<line x1="640" y1="220" x2="640" y2="110" stroke="#767676" stroke-width="2" stroke-dasharray="5 4"/>
<circle cx="640" cy="220" r="5" fill="#ffffff" stroke="#2f6b3f" stroke-width="2.5"/>
<circle cx="640" cy="110" r="5" fill="#8a3d12"/>
<text x="500" y="212" font-size="12.5" fill="#2f6b3f">complete and decidable</text>
<text x="662" y="102" font-size="12.5" fill="#8a3d12">incomplete and undecidable</text>
<text x="640" y="262" font-size="12.5" text-anchor="middle">interprets Robinson's Q</text>
<text x="456" y="90" font-size="12.5" fill="#5c5c5c">No partial credit, no gradations,</text>
<text x="456" y="107" font-size="12.5" fill="#5c5c5c">nothing on the threshold itself.</text>
</g>
</svg>

</div>

---

## 3. The cliff is crossed by adding a SET, not an operation

This is the most counterintuitive fact on the page, and it is the one most likely to bite anyone
actually building a deliberately weak core. A decidable additive core does not fall by being handed
multiplication. It falls by being handed a **lookup table**.

Addition plus the bare unary predicate "is a square" already defines multiplication. The squaring
*function* is not needed, only the set. Consecutive squares differ by an odd number, so "y is a
square, and the next square after y is y + 2n + 1" pins down y = n², and then
2xy = (x+y)² - x² - y² delivers the graph of multiplication. The uniqueness step is machine-checked
as `next_square_forces` in [`lean/LogicBoundary.lean`](lean/LogicBoundary.lean).

<div style="overflow-x:auto">

<svg viewBox="0 0 860 250" role="img" aria-labelledby="squares-title">
<title id="squares-title">Chain showing that Presburger arithmetic plus the bare set of squares defines squaring, then multiplication, then interprets Robinson's Q and falls to Goedel</title>
<defs>
<marker id="arrC" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
<path d="M 0 0 L 10 5 L 0 10 z" fill="#3a3a3a"/>
</marker>
</defs>
<rect x="0" y="0" width="860" height="250" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<rect x="16" y="60" width="150" height="72" fill="#ffffff" stroke="#2f6b3f" stroke-width="2.5"/>
<text x="91" y="88" font-size="14" text-anchor="middle" font-weight="bold">⟨ℕ, +⟩</text>
<text x="91" y="108" font-size="12.5" text-anchor="middle" fill="#2f6b3f">decidable</text>
<text x="91" y="124" font-size="12.5" text-anchor="middle" fill="#2f6b3f">and complete</text>

<text x="184" y="100" font-size="26" text-anchor="middle" font-weight="bold">+</text>

<rect x="202" y="60" width="176" height="72" fill="#ffffff" stroke="#a8501e" stroke-width="2.5"/>
<text x="290" y="86" font-size="13.5" text-anchor="middle" font-weight="bold">a SET, nothing more:</text>
<text x="290" y="108" font-size="13.5" text-anchor="middle">Sq = &#123;0, 1, 4, 9, 16, ...&#125;</text>
<text x="290" y="126" font-size="12.5" text-anchor="middle" fill="#5c5c5c">a unary predicate</text>

<line x1="382" y1="96" x2="428" y2="96" stroke="#3a3a3a" stroke-width="1.8" marker-end="url(#arrC)"/>

<rect x="432" y="60" width="176" height="72" fill="#ffffff" stroke="#767676" stroke-width="2"/>
<text x="520" y="84" font-size="13" text-anchor="middle">(n+1)² = n² + (2n+1)</text>
<text x="520" y="104" font-size="12.5" text-anchor="middle" fill="#5c5c5c">defines the graph of</text>
<text x="520" y="121" font-size="12.5" text-anchor="middle" fill="#5c5c5c">squaring, then of ×</text>

<line x1="612" y1="96" x2="658" y2="96" stroke="#3a3a3a" stroke-width="1.8" marker-end="url(#arrC)"/>

<rect x="662" y="60" width="182" height="72" fill="#f4ece6" stroke="#8a3d12" stroke-width="2.5"/>
<text x="753" y="86" font-size="13.5" text-anchor="middle" font-weight="bold">interprets Q</text>
<text x="753" y="108" font-size="12.5" text-anchor="middle" fill="#8a3d12">Goedel I and II, Rosser,</text>
<text x="753" y="125" font-size="12.5" text-anchor="middle" fill="#8a3d12">Tarski, Church, all at once</text>

<text x="16" y="176" font-size="13" fill="#5c5c5c">The set of squares looks like a harmless extra table. It is the whole of arithmetic arriving in the shape of a lookup table.</text>
<text x="16" y="198" font-size="13" fill="#5c5c5c">Machine-checked in lean/LogicBoundary.lean: sq_step, next_square_forces, mul_from_sq.</text>
<text x="16" y="226" font-size="12.5" fill="#8a3d12" font-weight="bold">Design consequence: audit a weak core by what SETS it may name, not only by what OPERATIONS it has.</text>
</g>
</svg>

</div>

---

## 4. The reals are easier than the integers

Tarski 1948 makes the theory of real closed fields complete and decidable, doubly exponential in
general. So a structure with **both** operations can be decidable, which looks like a
counterexample to panel 1 and is not. Goedel I needs the theory to interpret arithmetic, meaning to
define a copy of ℕ with both operations, and ℤ is not definable in the field of reals. No definable
ℕ means no induction, no counting, no finite sequences, no syntax.

The rationals are the other side of that coin. Julia Robinson (1949, her 1948 Berkeley thesis under
Tarski) defined ℤ inside ℚ by a first-order formula, which is exactly the mechanism the reals lack,
and the theory of the rationals is undecidable in consequence.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 230" role="img" aria-labelledby="fields-title">
<title id="fields-title">Three fields and three verdicts: the reals are decidable, the rationals and the integers are not, with Julia Robinson's definability of the integers inside the rationals as the mechanism</title>
<defs>
<marker id="arrD" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
<path d="M 0 0 L 10 5 L 0 10 z" fill="#8a3d12"/>
</marker>
</defs>
<rect x="0" y="0" width="860" height="230" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<rect x="30" y="48" width="230" height="86" fill="#ffffff" stroke="#2f6b3f" stroke-width="2.5"/>
<text x="145" y="78" font-size="17" text-anchor="middle" font-weight="bold">ℝ</text>
<text x="145" y="100" font-size="13.5" text-anchor="middle" fill="#2f6b3f" font-weight="bold">DECIDABLE</text>
<text x="145" y="122" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Tarski 1948, real closed fields</text>

<rect x="315" y="48" width="230" height="86" fill="#ffffff" stroke="#8a3d12" stroke-width="2.5"/>
<text x="430" y="78" font-size="17" text-anchor="middle" font-weight="bold">ℚ</text>
<text x="430" y="100" font-size="13.5" text-anchor="middle" fill="#8a3d12" font-weight="bold">UNDECIDABLE</text>
<text x="430" y="122" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Julia Robinson 1949</text>

<rect x="600" y="48" width="230" height="86" fill="#f4ece6" stroke="#8a3d12" stroke-width="2.5"/>
<text x="715" y="78" font-size="17" text-anchor="middle" font-weight="bold">ℤ</text>
<text x="715" y="100" font-size="13.5" text-anchor="middle" fill="#8a3d12" font-weight="bold">UNDECIDABLE</text>
<text x="715" y="122" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Goedel 1931, Church 1936</text>

<path d="M 700 148 C 660 190, 480 190, 436 150" fill="none" stroke="#8a3d12" stroke-width="2" marker-end="url(#arrD)"/>
<text x="568" y="196" font-size="12.5" text-anchor="middle" fill="#8a3d12">ℤ is first-order definable inside ℚ, so ℚ inherits the verdict</text>

<text x="30" y="176" font-size="12.5" fill="#5c5c5c">ℝ has both operations and cannot define ℤ.</text>
<text x="30" y="212" font-size="13" fill="#1a1a1a">The line runs not between simple and rich structures, but between those that can point at their own integers and those that cannot.</text>
</g>
</svg>

</div>

---

## 5. Above the line: the Big Five of reverse mathematics

Everything so far was about where incompleteness begins. Reverse mathematics asks the opposite
question, from above: given a theorem, **which** set-existence axioms are needed to prove it? The
empirical finding of the field is that almost every theorem of ordinary mathematics is equivalent,
over a weak base, to one of five systems. That is a ready-made ladder of layer strengths.

Sources for this panel and the next two: the Stanford Encyclopedia entry *Reverse Mathematics* and
the Wikipedia survey *Reverse mathematics*, both fetched for this page. Simpson, *Subsystems of
Second Order Arithmetic*, is the standard textbook; no specific theorem number is cited here
because none was verified this session.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 450" role="img" aria-labelledby="bigfive-title">
<title id="bigfive-title">The Big Five subsystems of second-order arithmetic in increasing strength, from RCA-zero at the bottom to Pi-1-1 comprehension at the top, each with what it is and representative theorems</title>
<defs>
<marker id="arrE" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse">
<path d="M 0 0 L 10 5 L 0 10 z" fill="#2d5c8a"/>
</marker>
</defs>
<rect x="0" y="0" width="860" height="450" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<line x1="22" y1="418" x2="22" y2="26" stroke="#2d5c8a" stroke-width="2" marker-end="url(#arrE)"/>
<text x="0" y="0" font-size="12.5" fill="#2d5c8a" transform="translate(14 284) rotate(-90)">increasing strength</text>

<rect x="40" y="16" width="806" height="74" fill="#ffffff" stroke="#4a3560" stroke-width="2"/>
<rect x="40" y="16" width="160" height="74" fill="#efe9f4" stroke="#4a3560" stroke-width="2"/>
<text x="120" y="50" font-size="15" text-anchor="middle" font-weight="bold">Π¹₁-CA₀</text>
<text x="120" y="72" font-size="12.5" text-anchor="middle" fill="#5c5c5c">strongest of the five</text>
<text x="212" y="40" font-size="13">Comprehension for Π¹₁ formulas: impredicative, quantifying over sets to build a set.</text>
<text x="212" y="60" font-size="13" fill="#2d5c8a">Equivalent to: the Cantor-Bendixson theorem; Silver's dichotomy for coanalytic</text>
<text x="212" y="80" font-size="13" fill="#2d5c8a">equivalence relations; decomposition theorems for countable abelian groups.</text>

<rect x="40" y="100" width="806" height="74" fill="#ffffff" stroke="#4a3560" stroke-width="2"/>
<rect x="40" y="100" width="160" height="74" fill="#efe9f4" stroke="#4a3560" stroke-width="2"/>
<text x="120" y="134" font-size="15" text-anchor="middle" font-weight="bold">ATR₀</text>
<text x="120" y="156" font-size="12.5" text-anchor="middle" fill="#5c5c5c">transfinite recursion</text>
<text x="212" y="124" font-size="13">Iterate an arithmetically definable operator transfinitely along a countable well-ordering.</text>
<text x="212" y="144" font-size="13" fill="#2d5c8a">Equivalent to: comparability of countable well-orderings; the perfect set theorem;</text>
<text x="212" y="164" font-size="13" fill="#2d5c8a">Luzin's separation theorem for analytic sets; Ulm's theorem.</text>

<rect x="40" y="184" width="806" height="74" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<rect x="40" y="184" width="160" height="74" fill="#e7eef5" stroke="#2d5c8a" stroke-width="2"/>
<text x="120" y="218" font-size="15" text-anchor="middle" font-weight="bold">ACA₀</text>
<text x="120" y="240" font-size="12.5" text-anchor="middle" fill="#5c5c5c">first-order part: PA</text>
<text x="212" y="208" font-size="13">Comprehension for arithmetical formulas, no set quantifiers. This is the Turing jump.</text>
<text x="212" y="228" font-size="13" fill="#2d5c8a">Equivalent to: Bolzano-Weierstrass; sequential least upper bound for the reals;</text>
<text x="212" y="248" font-size="13" fill="#2d5c8a">Ascoli's theorem; every countable vector space has a basis.</text>

<rect x="40" y="268" width="806" height="74" fill="#ffffff" stroke="#a8501e" stroke-width="3"/>
<rect x="40" y="268" width="160" height="74" fill="#f4ece6" stroke="#a8501e" stroke-width="3"/>
<text x="120" y="302" font-size="15" text-anchor="middle" font-weight="bold">WKL₀</text>
<text x="120" y="324" font-size="12.5" text-anchor="middle" fill="#8a3d12">the rung that matters</text>
<text x="212" y="292" font-size="13">RCA₀ plus weak Koenig's lemma: every infinite subtree of 2&lt;ω has an infinite path.</text>
<text x="212" y="312" font-size="13" fill="#8a3d12">A COMPACTNESS principle. Panel 6 unpacks it, panel 7 gives its conservativity.</text>
<text x="212" y="332" font-size="13" fill="#5c5c5c">Same first-order part as RCA₀ (IΣ₁), and strictly weaker than ACA₀.</text>

<rect x="40" y="352" width="806" height="74" fill="#ffffff" stroke="#2f6b3f" stroke-width="2"/>
<rect x="40" y="352" width="160" height="74" fill="#e8f0e9" stroke="#2f6b3f" stroke-width="2"/>
<text x="120" y="386" font-size="15" text-anchor="middle" font-weight="bold">RCA₀</text>
<text x="120" y="408" font-size="12.5" text-anchor="middle" fill="#5c5c5c">the base theory</text>
<text x="212" y="376" font-size="13">Comprehension only for computable (Δ⁰₁) sets, plus Σ⁰₁ induction. Computable mathematics.</text>
<text x="212" y="396" font-size="13" fill="#2f6b3f">Proves outright: the intermediate value theorem; nested interval completeness;</text>
<text x="212" y="416" font-size="13" fill="#2f6b3f">the Baire category theorem for separable metric spaces. First-order part: IΣ₁.</text>
</g>
</svg>

</div>

---

## 6. WKL₀ in detail: one compactness principle wearing many costumes

Weak Koenig's lemma is a small statement about binary trees. What makes it the interesting rung is
that a long list of theorems from analysis, algebra and logic turn out to be **the same statement**
over RCA₀. The list below is from the SEP entry, fetched for this page; the ring result and Peano
existence appear there explicitly, and Wikipedia's survey adds the Jordan curve theorem, Riemann
integrability of continuous functions on the unit interval, and the de Bruijn-Erdős theorem for
countable graphs.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 450" role="img" aria-labelledby="wkl-title">
<title id="wkl-title">Seven theorems radiating from weak Koenig's lemma, each equivalent to it over RCA-zero: Heine-Borel compactness of the unit interval, the compactness theorem for first-order logic, Goedel's completeness theorem, separable Hahn-Banach, Brouwer's fixed point theorem, Peano existence for ordinary differential equations, and the existence of a prime ideal in every countable commutative ring</title>
<rect x="0" y="0" width="860" height="450" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<line x1="430" y1="225" x2="430" y2="52" stroke="#a8501e" stroke-width="1.6"/>
<line x1="430" y1="225" x2="712" y2="112" stroke="#a8501e" stroke-width="1.6"/>
<line x1="430" y1="225" x2="742" y2="225" stroke="#a8501e" stroke-width="1.6"/>
<line x1="430" y1="225" x2="712" y2="338" stroke="#a8501e" stroke-width="1.6"/>
<line x1="430" y1="225" x2="430" y2="398" stroke="#a8501e" stroke-width="1.6"/>
<line x1="430" y1="225" x2="148" y2="338" stroke="#a8501e" stroke-width="1.6"/>
<line x1="430" y1="225" x2="118" y2="225" stroke="#a8501e" stroke-width="1.6"/>
<line x1="430" y1="225" x2="148" y2="112" stroke="#a8501e" stroke-width="1.6"/>

<circle cx="430" cy="225" r="68" fill="#f4ece6" stroke="#a8501e" stroke-width="3"/>
<text x="430" y="216" font-size="19" text-anchor="middle" font-weight="bold">WKL₀</text>
<text x="430" y="240" font-size="12.5" text-anchor="middle" fill="#8a3d12">every infinite</text>
<text x="430" y="256" font-size="12.5" text-anchor="middle" fill="#8a3d12">subtree of 2&lt;ω</text>
<text x="430" y="272" font-size="12.5" text-anchor="middle" fill="#8a3d12">has a path</text>

<rect x="326" y="26" width="208" height="52" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="430" y="48" font-size="13" text-anchor="middle">Heine-Borel compactness</text>
<text x="430" y="66" font-size="13" text-anchor="middle">of the closed unit interval</text>

<rect x="608" y="86" width="208" height="52" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="712" y="108" font-size="13" text-anchor="middle">Compactness theorem</text>
<text x="712" y="126" font-size="13" text-anchor="middle">for first-order logic</text>

<rect x="638" y="199" width="208" height="52" fill="#ffffff" stroke="#4a3560" stroke-width="2.5"/>
<text x="742" y="221" font-size="13" text-anchor="middle" font-weight="bold">Goedel's completeness</text>
<text x="742" y="239" font-size="13" text-anchor="middle" font-weight="bold">theorem (countable)</text>

<rect x="608" y="312" width="208" height="52" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="712" y="334" font-size="13" text-anchor="middle">Separable</text>
<text x="712" y="352" font-size="13" text-anchor="middle">Hahn-Banach theorem</text>

<rect x="326" y="372" width="208" height="52" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="430" y="394" font-size="13" text-anchor="middle">Brouwer's</text>
<text x="430" y="412" font-size="13" text-anchor="middle">fixed point theorem</text>

<rect x="44" y="312" width="208" height="52" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="148" y="334" font-size="13" text-anchor="middle">Peano existence theorem</text>
<text x="148" y="352" font-size="13" text-anchor="middle">for ODEs</text>

<rect x="14" y="199" width="208" height="52" fill="#ffffff" stroke="#2f6b3f" stroke-width="2.5"/>
<text x="118" y="221" font-size="13" text-anchor="middle" font-weight="bold">Every countable commutative</text>
<text x="118" y="239" font-size="13" text-anchor="middle" font-weight="bold">ring has a prime ideal</text>

<rect x="44" y="86" width="208" height="52" fill="#ffffff" stroke="#2d5c8a" stroke-width="2"/>
<text x="148" y="108" font-size="13" text-anchor="middle">Riemann integrability of</text>
<text x="148" y="126" font-size="13" text-anchor="middle">continuous functions on [0,1]</text>
</g>
</svg>

</div>

Two of these spokes are the reason this page exists at all. **Goedel's completeness theorem for a
countable language** is where [`logic-bpi.md`](logic-bpi.md) landed after ruling out choice, and
**every countable commutative ring has a prime ideal** is the countable shadow of the Boolean prime
ideal theorem. Panel 8 draws that pairing.

---

## 7. The payoff: a strong layer that provably does not corrupt the weak one below it

This is the architecture statement, and it is a theorem rather than an aspiration. WKL₀ proves
things RCA₀ cannot, so it is genuinely stronger. But **every Π¹₁ sentence WKL₀ proves is already
provable in RCA₀** (Harrington's theorem, unpublished, made available in Simpson's *Subsystems of
Second Order Arithmetic*), and every Π⁰₂ sentence it proves is provable in primitive recursive
arithmetic. The second follows by a chain: Parsons 1970 gives that IΣ₁ is Π⁰₂-conservative over
PRA, Friedman 1976 gives that IΣ₁ is the first-order part of RCA₀, and Sieg 1985 supplied a
constructive proof that transforms proofs into primitive recursive functions.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 320" role="img" aria-labelledby="cons-title">
<title id="cons-title">Conservativity as a layered architecture: WKL-zero sits above RCA-zero, which sits above primitive recursive arithmetic, and each stronger layer is conservative over the one below for a stated class of sentences</title>
<defs>
<marker id="arrG" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse">
<path d="M 0 0 L 10 5 L 0 10 z" fill="#2f6b3f"/>
</marker>
</defs>
<rect x="0" y="0" width="860" height="320" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<rect x="40" y="30" width="420" height="66" fill="#f4ece6" stroke="#a8501e" stroke-width="3"/>
<text x="250" y="58" font-size="16" text-anchor="middle" font-weight="bold">WKL₀</text>
<text x="250" y="80" font-size="12.5" text-anchor="middle" fill="#8a3d12">strong: compactness, Heine-Borel, completeness, Brouwer</text>

<rect x="40" y="126" width="420" height="66" fill="#e8f0e9" stroke="#2f6b3f" stroke-width="2.5"/>
<text x="250" y="154" font-size="16" text-anchor="middle" font-weight="bold">RCA₀</text>
<text x="250" y="176" font-size="12.5" text-anchor="middle" fill="#2f6b3f">weak: computable mathematics only</text>

<rect x="40" y="222" width="420" height="66" fill="#e8f0e9" stroke="#2f6b3f" stroke-width="2.5"/>
<text x="250" y="250" font-size="16" text-anchor="middle" font-weight="bold">PRA</text>
<text x="250" y="272" font-size="12.5" text-anchor="middle" fill="#2f6b3f">primitive recursive arithmetic: finitist</text>

<path d="M 476 62 C 560 62, 560 158, 480 158" fill="none" stroke="#2f6b3f" stroke-width="2.5" marker-end="url(#arrG)"/>
<text x="578" y="52" font-size="13.5" font-weight="bold">Π¹₁-conservative over RCA₀</text>
<text x="578" y="72" font-size="12.5" fill="#5c5c5c">Harrington, unpublished;</text>
<text x="578" y="90" font-size="12.5" fill="#5c5c5c">available via Simpson 2009.</text>

<path d="M 476 158 C 560 158, 560 254, 480 254" fill="none" stroke="#2f6b3f" stroke-width="2.5" marker-end="url(#arrG)"/>
<text x="578" y="150" font-size="13.5" font-weight="bold">Π⁰₂-conservative over PRA</text>
<text x="578" y="170" font-size="12.5" fill="#5c5c5c">Parsons 1970 (IΣ₁ over PRA),</text>
<text x="578" y="188" font-size="12.5" fill="#5c5c5c">Friedman 1976 (IΣ₁ is RCA₀'s</text>
<text x="578" y="206" font-size="12.5" fill="#5c5c5c">first-order part), Sieg 1985</text>
<text x="578" y="224" font-size="12.5" fill="#5c5c5c">for a constructive treatment.</text>

<text x="40" y="308" font-size="13.5" fill="#8a3d12" font-weight="bold">Read as architecture: reasoning in the strong layer cannot corrupt the weak one. That is a theorem, not a hope.</text>
</g>
</svg>

</div>

The reading matters. Conservativity is not "the strong layer is useless"; WKL₀ proves Π¹₂ things
RCA₀ does not. It is the exact statement that for a stated class of consequences, borrowing the
strong layer's power costs the weak layer nothing. A layered design that wants "the upper layer may
be powerful, and must not contaminate the trusted lower one" is asking for a conservativity result,
and here two of them already exist, with the classes spelled out.

---

## 8. Compactness, not choice: BPI and WKL are one theorem at two cardinalities

[`logic-bpi.md`](logic-bpi.md) chased a hunch that "ZF without C" was doing architectural work and
found it was not. The Boolean prime ideal theorem really is what produces a coherent truth
assignment on a **general** Boolean algebra, really is unprovable in ZF, really is strictly weaker
than AC (Halpern and Levy 1971). But the Lindenbaum-Tarski algebra of a theory in a countable
language is countable, and for a countable Boolean algebra a prime ideal is built by walking an
enumeration and deciding one element at a time, in ZF alone. There is no limit stage, so there is
nothing for a choice principle to do. The sharp condition is **well-orderability**, not
countability, and nothing in the architecture reaches an algebra that fails it.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 300" role="img" aria-labelledby="bpi-title">
<title id="bpi-title">The same theorem at two cardinalities: for arbitrary languages the completion needs the Boolean prime ideal theorem, a choice principle, while for countable languages it is weak Koenig's lemma, a compactness principle provable in ZF</title>
<rect x="0" y="0" width="860" height="300" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<text x="430" y="30" font-size="14" text-anchor="middle" font-weight="bold">"Every consistent theory has a complete consistent extension"</text>
<text x="430" y="50" font-size="12.5" text-anchor="middle" fill="#5c5c5c">one statement, and the cardinality of the language decides what it costs</text>

<rect x="30" y="70" width="390" height="180" fill="#ffffff" stroke="#4a3560" stroke-width="2.5"/>
<text x="225" y="98" font-size="14" text-anchor="middle" font-weight="bold">ARBITRARY language</text>
<text x="225" y="124" font-size="13.5" text-anchor="middle" fill="#4a3560" font-weight="bold">needs BPI: a CHOICE principle</text>
<text x="48" y="150" font-size="12.5">Unprovable in ZF. Strictly weaker than AC</text>
<text x="48" y="168" font-size="12.5">(Halpern and Levy 1971). Zorn on the poset of</text>
<text x="48" y="186" font-size="12.5">proper filters: a genuine limit stage, and the</text>
<text x="48" y="204" font-size="12.5">union at that stage is what must be chosen.</text>
<text x="48" y="230" font-size="12.5" fill="#5c5c5c">Sharp condition: the algebra is NOT well-orderable.</text>

<rect x="440" y="70" width="390" height="180" fill="#ffffff" stroke="#a8501e" stroke-width="3"/>
<text x="635" y="98" font-size="14" text-anchor="middle" font-weight="bold">COUNTABLE language</text>
<text x="635" y="124" font-size="13.5" text-anchor="middle" fill="#8a3d12" font-weight="bold">needs WKL: a COMPACTNESS principle</text>
<text x="458" y="150" font-size="12.5">A ZF theorem. Walk the enumeration, decide one</text>
<text x="458" y="168" font-size="12.5">element at a time, every stage a successor.</text>
<text x="458" y="186" font-size="12.5">Nothing is chosen. Measured finely in reverse</text>
<text x="458" y="204" font-size="12.5">mathematics, the strength is exactly WKL₀.</text>
<text x="458" y="230" font-size="12.5" fill="#5c5c5c">Machine-checked construction: lean/LogicBPI.lean.</text>

<text x="430" y="272" font-size="13.5" text-anchor="middle" font-weight="bold">So the principle the layered architecture actually needs is COMPACTNESS, not CHOICE.</text>
<text x="430" y="292" font-size="12.5" text-anchor="middle" fill="#5c5c5c">Low Basis Theorem (Jockusch and Soare 1972): the completion exists, is not computable, and is LOW.</text>
</g>
</svg>

</div>

The Low Basis Theorem is the sharpest statement of what the countable case costs. A completion
exists; by Goedel-Rosser it cannot be computable; but it can be taken **low**, meaning its Turing
jump is as weak as possible, which is also the standard route to showing WKL₀ is strictly weaker
than ACA₀. Not computable, and only barely not.

---

## 9. Tying it back, with the caution attached

The layered picture the cluster has been circling wants a stratification: a weak trusted layer, a
stronger layer above it, and a guarantee that the upper does not corrupt the lower. Panels 5 through
7 say that stratification **does not need inventing**. Reverse mathematics has five rungs, calibrated
against hundreds of ordinary theorems, with the conservativity relations between them already worked
out and attributed. Borrowing it is cheaper and far better tested than designing one.

<div style="overflow-x:auto">

<svg viewBox="0 0 860 240" role="img" aria-labelledby="close-title">
<title id="close-title">Closing panel: what the Big Five gives the layered design, set against the caution that WKL-zero is itself a subsystem of second-order arithmetic and therefore incomplete</title>
<rect x="0" y="0" width="860" height="240" fill="#fbfaf8"/>
<g font-family="Georgia, 'Times New Roman', serif" fill="#1a1a1a">

<rect x="24" y="20" width="400" height="196" fill="#e8f0e9" stroke="#2f6b3f" stroke-width="2.5"/>
<text x="224" y="48" font-size="14" text-anchor="middle" font-weight="bold">WHAT IT ANSWERS</text>
<text x="42" y="78" font-size="13">A ladder of layer strengths, five rungs, already</text>
<text x="42" y="98" font-size="13">calibrated against real mathematics.</text>
<text x="42" y="124" font-size="13">Conservativity between rungs, stated and proved,</text>
<text x="42" y="144" font-size="13">so "the upper layer does not corrupt the lower"</text>
<text x="42" y="164" font-size="13">is a theorem with a named sentence class.</text>
<text x="42" y="194" font-size="13" font-weight="bold">"Which principle buys completions?" -- WKL₀.</text>

<rect x="440" y="20" width="396" height="196" fill="#f4ece6" stroke="#8a3d12" stroke-width="2.5"/>
<text x="638" y="48" font-size="14" text-anchor="middle" font-weight="bold">WHAT IT DOES NOT</text>
<text x="458" y="78" font-size="13">WKL₀ is a subsystem of SECOND-ORDER arithmetic.</text>
<text x="458" y="98" font-size="13">It interprets arithmetic. So by panels 1 to 3 it is</text>
<text x="458" y="118" font-size="13">itself incomplete, and sits well above the cliff.</text>
<text x="458" y="148" font-size="13">It is not a candidate for a decidable core, and</text>
<text x="458" y="168" font-size="13">nothing about its weakness relative to ACA₀ moves</text>
<text x="458" y="188" font-size="13">the verdict of panel 2 by one inch.</text>
<text x="458" y="210" font-size="12.5" fill="#8a3d12" font-weight="bold">Wrong question: "what can a decidable core be?"</text>
</g>
</svg>

</div>

The two halves of this page therefore answer two different questions and should not be run together.
Panels 1 to 4 fix **where the cliff is**, and a core that stays below it cannot talk about proofs at
all, because a proof is a finite sequence and sequences are pairing. Panels 5 to 8 fix **how the
territory above the cliff is stratified**, and they are silent about anything below it. Reverse
mathematics is a map of the strong country. It is not a route back across the border.

---

## Verification status

Fetched and confirmed for this page, since the session's WebSearch budget was exhausted and only
targeted fetches were available:

| Item | Source | Status |
|---|---|---|
| The Big Five, in increasing strength, and what each adds | SEP *Reverse Mathematics*; Wikipedia *Reverse mathematics* | **Fetched and confirmed** |
| Theorems provable in RCA₀, and equivalent to ACA₀ / ATR₀ / Π¹₁-CA₀ | Wikipedia *Reverse mathematics*; SEP for the ATR₀ and Π¹₁-CA₀ examples | **Fetched and confirmed** |
| WKL₀ equivalents: Heine-Borel on [0,1], first-order compactness, Goedel completeness, separable Hahn-Banach, Brouwer, Peano existence for ODEs, prime ideal in every countable commutative ring | SEP *Reverse Mathematics*, which lists all seven explicitly | **Fetched and confirmed** |
| WKL₀ Π¹₁-conservative over RCA₀, attributed to Harrington | SEP *Reverse Mathematics* | **Fetched and confirmed.** SEP states the theorem and the attribution; the "unpublished, made available by Simpson 2009" wording is standard and **the Simpson volume itself was not fetched this session** |
| WKL₀ Π⁰₂-conservative over PRA, via Parsons 1970 and Friedman 1976, with Sieg 1985 constructive | SEP *Reverse Mathematics* | **Fetched and confirmed**, including the three-step chain |
| Low Basis Theorem, Jockusch and Soare 1972 | SEP *Reverse Mathematics* | **Fetched and confirmed** as the attribution and as the route to WKL₀ being strictly weaker than ACA₀ |
| First-order parts: IΣ₁ for RCA₀ and WKL₀, PA for ACA₀ | SEP *Reverse Mathematics* | **Fetched and confirmed** |
| Presburger 1929; Mostowski 1952; Fischer and Rabin 1974; Tarski 1948; Julia Robinson 1949; Cobham 1969 and Semenov 1977 | [`logic-counterfactual-boundary.md`](logic-counterfactual-boundary.md) §9, each marked verified there | **Inherited, not re-verified here** |
| Halpern and Levy 1971; the countable-algebra ZF construction; the WKL₀ strength of countable completeness | [`logic-bpi.md`](logic-bpi.md) §8 | **Inherited, not re-verified here** |
| `next_square_forces`, `mul_from_sq`, `sq_step` | [`lean/LogicBoundary.lean`](lean/LogicBoundary.lean) | Machine-checked per the parent essay; **not re-run for this page** |
| A specific theorem number in Simpson, *Subsystems of Second Order Arithmetic* | none located | **NOT VERIFIED.** Chapter-level pointer only, no number given |

No citation on this page was invented. Where a source could not be reached the row says so and no
plausible-looking substitute was supplied.
