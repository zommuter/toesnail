---
title: Two posters about computers
permalink: /dreamed/poster-computers
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This page *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/`, `essays/` or `crypto/` without the owner authoring the move himself.

Two posters for a curious twelve-year-old. Each one has a picture you can read from across the
room, one big idea, and an honest note about what got left out. Simplifying is allowed here;
being wrong is not. The grown-up versions, with the proofs and the citations, are
[`logic-bloch-gates`](logic-bloch-gates) for the first poster and [`fig-fhe`](fig-fhe) for the
second.

<style>
.tspost{display:block;width:100%;height:auto;max-width:640px;margin:0 auto;background:#fcfcfb;font-family:system-ui,-apple-system,"Segoe UI",sans-serif}
.tspost text{fill:#26251f}
.tspost .hl{fill:#0b0b0b;font-size:52px;font-weight:700}
.tspost .sub{fill:#4a4944;font-size:28px}
.tspost .hd{fill:#0b0b0b;font-size:30px;font-weight:700}
.tspost .bd{fill:#26251f;font-size:26px}
.tspost .sm{fill:#6b6a66;font-size:24px}
.tspost .m{text-anchor:middle}
.tspost .e{text-anchor:end}
.tspost .box{fill:#f2f1ec;stroke:#26251f;stroke-width:3}
.tspost .out{fill:#ffffff;stroke:#26251f;stroke-width:3}
.tspost .big{fill:#0b0b0b;font-size:34px;font-weight:700}
.tspost .huge{fill:#0b0b0b;font-size:60px;font-weight:700}
.tspost .arw{fill:none;stroke:#26251f;stroke-width:3}
.tspost .rule{stroke:#c9c8c0;stroke-width:2}
.tspost .barA{fill:#2a78d6}
.tspost .barB{fill:#eb6834}
.tspost .empty{fill:none;stroke:#6b6a66;stroke-width:3;stroke-dasharray:10 8}
</style>

## Poster 1

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 1240" role="img" aria-labelledby="p1t p1d">
<title id="p1t">Four ways in, two ways out, so something got lost</title>
<desc id="p1d">A poster. Four boxes across the top show the four settings of two switches: off off, off on, on off, on on. Arrows run down to two answer boxes. Three arrows crowd into the answer NO and only one arrow reaches the answer YES. Because three different starts give the same answer, the answer NO cannot tell you which start it came from, so information was destroyed. A computer that must run backwards cannot destroy anything, so it needs a third wire to keep the leftovers. Destroying information also costs energy and makes heat.</desc>
<defs>
<marker id="p1arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse">
<path d="M0,0 L10,5 L0,10 z" fill="#26251f"/>
</marker>
</defs>

<text class="hl" x="30" y="72">Four ways in.</text>
<text class="hl" x="30" y="128">Two ways out.</text>
<text class="hl" x="30" y="184">Something got lost.</text>
<text class="sub" x="30" y="232">Why a computer that runs backwards needs a spare wire.</text>

<text class="sm" x="30" y="282">the two switches</text>
<rect class="box" x="30" y="294" width="148" height="84" rx="10"/>
<rect class="box" x="194" y="294" width="148" height="84" rx="10"/>
<rect class="box" x="358" y="294" width="148" height="84" rx="10"/>
<rect class="box" x="522" y="294" width="148" height="84" rx="10"/>
<text class="big m" x="104" y="348">off off</text>
<text class="big m" x="268" y="348">off on</text>
<text class="big m" x="432" y="348">on off</text>
<text class="big m" x="596" y="348">on on</text>

<path class="arw" d="M104,382 L228,466" marker-end="url(#p1arrow)"/>
<path class="arw" d="M268,382 L243,466" marker-end="url(#p1arrow)"/>
<path class="arw" d="M432,382 L258,466" marker-end="url(#p1arrow)"/>
<path class="arw" d="M596,382 L580,466" marker-end="url(#p1arrow)"/>

<rect class="out" x="30" y="474" width="430" height="80" rx="10"/>
<rect class="out" x="490" y="474" width="180" height="80" rx="10"/>
<text class="huge m" x="245" y="533">NO</text>
<text class="huge m" x="580" y="533">YES</text>
<text class="sm" x="30" y="586">three starts crowd into one answer</text>
<text class="sm e" x="670" y="586">one start, one answer</text>

<text class="hd" x="30" y="640">Say YES and you can work backwards</text>
<text class="bd" x="30" y="676">If the answer is yes, both switches are on,</text>
<text class="bd" x="30" y="708">and you know exactly what you started with.</text>

<text class="hd" x="30" y="762">Say NO and the past is gone</text>
<text class="bd" x="30" y="798">Was it the left switch that was off? The right</text>
<text class="bd" x="30" y="830">one? Both? NO cannot tell you. Three</text>
<text class="bd" x="30" y="862">different starts, one single answer.</text>

<text class="hd" x="30" y="916">A backwards computer needs a spare wire</text>
<text class="bd" x="30" y="952">Two wires in and two wires out cannot carry</text>
<text class="bd" x="30" y="984">the answer and the leftovers at once. Three</text>
<text class="bd" x="30" y="1016">wires can, and the third one holds the</text>
<text class="bd" x="30" y="1048">leftovers. Count the arrows: it is not a</text>
<text class="bd" x="30" y="1080">matter of taste, it is a matter of counting.</text>

<text class="hd" x="30" y="1134">Forgetting makes heat</text>
<text class="bd" x="30" y="1170">Every bit you throw away warms the room by at</text>
<text class="bd" x="30" y="1202">least a tiny amount. Nobody gets out of paying.</text>
</svg>

</div>

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 110" role="img" aria-labelledby="p1st p1sd">
<title id="p1st">What poster one skipped</title>
<desc id="p1sd">The three wire gate is called a Toffoli gate. It leaves both switches untouched and adds the answer onto a third wire. The heat from one forgotten bit is far smaller than what a real chip wastes today, so it is real physics but not yet the thing that limits computers.</desc>
<line class="rule" x1="30" y1="14" x2="670" y2="14"/>
<text class="sm" x="30" y="48">What we skipped: the three wire gate has a name, Toffoli. It leaves</text>
<text class="sm" x="30" y="78">both switches alone and adds the answer onto the third wire. And the</text>
<text class="sm" x="30" y="108">heat from one forgotten bit is far less than a real chip wastes today.</text>
</svg>

</div>

## Poster 2

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 1340" role="img" aria-labelledby="p2t p2d">
<title id="p2t">Doing maths inside a locked box</title>
<desc id="p2d">A poster. A sealed box with a padlock holds a secret number. Two gloves reach in from outside so a stranger can work on the number without opening the box. The stranger does the sum, hands the box back, and the owner unlocks it to find the right answer, while the stranger never saw the number or the answer. Underneath, three bars compare speed: a normal computer takes a blink, the same job inside the box takes minutes, and the third lane is drawn empty because nobody has yet run the biggest AI models all the way inside the box.</desc>

<text class="hl" x="30" y="72">Maths inside</text>
<text class="hl" x="30" y="128">a locked box.</text>
<text class="sub" x="30" y="180">A stranger does your sums for you without</text>
<text class="sub" x="30" y="214">ever seeing your number, or the answer.</text>

<rect class="box" x="170" y="262" width="360" height="250" rx="16"/>
<rect class="out" x="200" y="292" width="300" height="126"/>
<text class="huge m" x="350" y="378">7</text>
<text class="sm m" x="350" y="404">your secret number</text>
<path class="arw" d="M478,286 a14,14 0 0 1 28,0 l0,12" fill="none"/>
<rect x="472" y="298" width="40" height="30" rx="5" fill="#f2f1ec" stroke="#26251f" stroke-width="3"/>
<text class="sm" x="524" y="322">locked</text>
<circle class="out" cx="270" cy="482" r="28"/>
<circle class="out" cx="430" cy="482" r="28"/>
<path d="M40,572 Q150,566 268,502" fill="none" stroke="#6b6a66" stroke-width="24" stroke-linecap="round"/>
<path d="M660,572 Q550,566 432,502" fill="none" stroke="#6b6a66" stroke-width="24" stroke-linecap="round"/>
<text class="sm" x="30" y="612">the stranger reaches in, but the box never opens</text>

<text class="hd" x="30" y="666">Hand it over, get it back, unlock it</text>
<text class="bd" x="30" y="702">Lock your number in the box. Give the box to</text>
<text class="bd" x="30" y="734">a stranger. They do maths on what is inside</text>
<text class="bd" x="30" y="766">without opening it, and hand the box back.</text>
<text class="bd" x="30" y="798">You unlock it. The answer is correct.</text>

<text class="hd" x="30" y="852">That sounds impossible. It is real.</text>
<text class="bd" x="30" y="888">They never saw your number and they never</text>
<text class="bd" x="30" y="920">saw the answer. They only shuffled the box.</text>

<text class="hd" x="30" y="974">The catch. It is enormously slow.</text>
<text class="sm" x="30" y="1010">a normal computer, out in the open</text>
<rect class="barA" x="30" y="1020" width="9" height="34"/>
<text class="bd" x="55" y="1048">a blink</text>
<text class="sm" x="30" y="1094">the very same job, inside the locked box</text>
<rect class="barB" x="30" y="1104" width="560" height="34"/>
<text class="bd e" x="670" y="1132">minutes</text>
<text class="sm" x="30" y="1178">the biggest AI models, all the way inside the box</text>
<rect class="empty" x="30" y="1188" width="640" height="34" rx="6"/>
<text class="bd m" x="350" y="1214">nobody has managed it yet</text>
<text class="sm" x="30" y="1264">A longer bar means slower. The empty lane is empty because</text>
<text class="sm" x="30" y="1294">the record is empty, not because the number is small. Reading</text>
<text class="sm" x="30" y="1324">a gap in a chart is a skill worth having.</text>
</svg>

</div>

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 110" role="img" aria-labelledby="p2st p2sd">
<title id="p2st">What poster two skipped</title>
<desc id="p2sd">The box is clever arithmetic rather than a physical box, there are several kinds of box and some are much faster than others, and how slow it is depends enormously on which sum you ask for.</desc>
<line class="rule" x1="30" y1="14" x2="670" y2="14"/>
<text class="sm" x="30" y="48">What we skipped: the box is really clever arithmetic, not a box you</text>
<text class="sm" x="30" y="78">could hold. There are several kinds, some much faster than others,</text>
<text class="sm" x="30" y="108">and how slow it is depends hugely on which sum you ask for.</text>
</svg>

</div>
