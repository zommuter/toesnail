---
title: The numbers this cluster actually measured
permalink: /dreamed/fig-results
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself.
>
> This page invents nothing. It is a **figure sheet**: every value below is read off a run of
> [`docs/dreamed/scheduler/run.sh`](scheduler/) or off a sourced sibling essay, and the source is
> named beside each chart.

Almost all of the Bloch Truth cluster is argument. Two files in it produced **measurements**, and
this page draws them. [`logic-scheduler-prototype.md`](logic-scheduler-prototype) ran a seeded
Monte Carlo over a synthetic 50-sentence corpus to ask whether a scheduler that can tell *proved
undecidable, stop asking* apart from *got nowhere yet, spend more budget* does better than one that
cannot; charts 1 to 3 are its answer, and the answer is no at any plausible price.
[`logic-thermodynamics.md`](logic-thermodynamics) counted proofs in a tiny Hilbert system and then
did the Landauer accounting; chart 4 is why it calls its own analogy a costume. The tables under
each chart carry the same figures as text.

<style>
.tsfig{display:block;width:100%;height:auto;max-width:760px;margin:0 auto;background:#fcfcfb;font-family:system-ui,-apple-system,"Segoe UI",sans-serif}
.tsfig text{fill:#52514e;font-size:13px}
.tsfig .hd{fill:#0b0b0b;font-size:15px;font-weight:600}
.tsfig .mu{fill:#898781;font-size:13px}
.tsfig .e{text-anchor:end;font-size:13px}
.tsfig .m{text-anchor:middle;font-size:13px}
.tsfig .val,.tsfig .lbl{fill:#0b0b0b;font-weight:600;font-size:13px}
.tsfig .warn,.tsfig .critt{fill:#d03b3b;font-weight:600;font-size:13px}
.tsfig .g{stroke:#e1e0d9;stroke-width:1}
.tsfig .ax{stroke:#c3c2b7;stroke-width:1}
.tsfig .crit{stroke:#d03b3b;stroke-width:2;stroke-dasharray:7 5}
.tsfig .ln{fill:none;stroke-width:2;stroke-linejoin:round}
.tsfig .mk{stroke:#fcfcfb;stroke-width:2}
.tsfig .s1{fill:#2a78d6}
.tsfig .s2{fill:#eb6834}
.tsfig .s3{fill:#1baf7a}
.tsfig .s1k{stroke:#2a78d6}
.tsfig .s2k{stroke:#eb6834}
.tsfig .s3k{stroke:#1baf7a}
.tsfig .zone{fill:#f0efec}
</style>

## 1. The scissors

Source: `experiment.py` block **E7**, re-run for this page. N=50, mean difficulty 40 budget units,
40 seeds per cell, base seed 20260907. The upper panel gives reading (ii) its **best possible**
case, told for free which sentences are independent; the lower panel gives the price at which the
purchase stops paying, divided by the 40-unit mean cost of an ordinary proof.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 664" role="img" aria-labelledby="c1t c1d">
<title id="c1t">The scissors: the gain from the independence distinction is largest exactly where an independence proof must be cheapest</title>
<desc id="c1d">Two panels share an x-axis of independent-sentence fraction. Top, the per cent gain of reading (ii) at zero purchase cost over reading (i). Bottom, the break-even price of one independence attempt divided by the mean ordinary proof cost of 40 units. As budget rises from 1500 to 4000 the gain collapses while the affordable price rises past parity. Full figures in the table below.</desc>
<text class="hd" x="14" y="26">Gain from the distinction, best case: reading (ii) told free which sentences are independent</text>
<text x="14" y="46">per cent more sentences settled than reading (i), same corpus, same budget, 40 seeds</text>
<text class="warn" x="14" y="66">as budget rises the gain collapses ...</text>
<line class="ax" x1="96" y1="292" x2="552" y2="292"/>
<text class="mu e" x="86" y="296">0%</text>
<line class="g" x1="96" y1="253.1" x2="552" y2="253.1"/>
<text class="mu e" x="86" y="257.1">10%</text>
<line class="g" x1="96" y1="214.2" x2="552" y2="214.2"/>
<text class="mu e" x="86" y="218.2">20%</text>
<line class="g" x1="96" y1="175.3" x2="552" y2="175.3"/>
<text class="mu e" x="86" y="179.3">30%</text>
<line class="g" x1="96" y1="136.4" x2="552" y2="136.4"/>
<text class="mu e" x="86" y="140.4">40%</text>
<line class="g" x1="96" y1="97.5" x2="552" y2="97.5"/>
<text class="mu e" x="86" y="101.5">50%</text>
<polyline class="ln s1k" points="96,249.6 210,208.3 324,168.7 438,126.6 552,86.2"/>
<g class="mk s1"><circle cx="96" cy="249.6" r="4.5"/><circle cx="210" cy="208.3" r="4.5"/><circle cx="324" cy="168.7" r="4.5"/><circle cx="438" cy="126.6" r="4.5"/><circle cx="552" cy="86.2" r="4.5"/></g>
<text class="lbl" x="566" y="90.2">budget 1500</text>
<polyline class="ln s2k" points="96,281.1 210,261.3 324,239.9 438,220.8 552,207.2"/>
<g class="mk s2"><rect x="92" y="277.1" width="8" height="8"/><rect x="206" y="257.3" width="8" height="8"/><rect x="320" y="235.9" width="8" height="8"/><rect x="434" y="216.8" width="8" height="8"/><rect x="548" y="203.2" width="8" height="8"/></g>
<text class="lbl" x="566" y="211.2">budget 2500</text>
<polyline class="ln s3k" points="96,292 210,290.8 324,285.4 438,280.3 552,271.8"/>
<g class="mk s3"><polygon points="96,286.5 101.5,292 96,297.5 90.5,292"/><polygon points="210,285.3 215.5,290.8 210,296.3 204.5,290.8"/><polygon points="324,279.9 329.5,285.4 324,290.9 318.5,285.4"/><polygon points="438,274.8 443.5,280.3 438,285.8 432.5,280.3"/><polygon points="552,266.3 557.5,271.8 552,277.3 546.5,271.8"/></g>
<text class="lbl" x="566" y="275.8">budget 4000</text>
<text class="hd" x="14" y="336">Break-even price of one independence attempt, in units of an ordinary proof</text>
<text font-size="13" x="14" y="356">break-even price divided by the mean ordinary proof cost of 40 units; above 1.00 the idea is uneconomic</text>
<text class="warn" x="14" y="376">... and exactly there the affordable price rises past parity</text>
<line class="ax" x1="96" y1="598" x2="552" y2="598"/>
<text class="mu e" x="86" y="602">0.0</text>
<line class="g" x1="96" y1="544.5" x2="552" y2="544.5"/>
<text class="mu e" x="86" y="548.5">0.4</text>
<line class="g" x1="96" y1="491" x2="552" y2="491"/>
<text class="mu e" x="86" y="495">0.8</text>
<line class="g" x1="96" y1="437.5" x2="552" y2="437.5"/>
<text class="mu e" x="86" y="441.5">1.2</text>
<line class="g" x1="96" y1="384" x2="552" y2="384"/>
<text class="mu e" x="86" y="388">1.6</text>
<line class="crit" x1="96" y1="464.2" x2="556" y2="464.2"/>
<text class="critt e" x="552" y="484.2">1.00: an independence proof costs the same as an ordinary one</text>
<polyline class="ln s1k" points="96,583.3 210,573.9 324,568.6 438,564.6 552,561.9"/>
<g class="mk s1"><circle cx="96" cy="583.3" r="4.5"/><circle cx="210" cy="573.9" r="4.5"/><circle cx="324" cy="568.6" r="4.5"/><circle cx="438" cy="564.6" r="4.5"/><circle cx="552" cy="561.9" r="4.5"/></g>
<text class="lbl" x="566" y="565.9">budget 1500</text>
<polyline class="ln s2k" points="96,539.1 210,515.1 324,508.4 438,501.7 552,499"/>
<g class="mk s2"><rect x="92" y="535.1" width="8" height="8"/><rect x="206" y="511.1" width="8" height="8"/><rect x="320" y="504.4" width="8" height="8"/><rect x="434" y="497.7" width="8" height="8"/><rect x="548" y="495" width="8" height="8"/></g>
<text class="lbl" x="566" y="503">budget 2500</text>
<polyline class="ln s3k" points="96,464.2 210,456.2 324,432.1 438,412.1 552,396"/>
<g class="mk s3"><polygon points="96,458.8 101.5,464.2 96,469.8 90.5,464.2"/><polygon points="210,450.7 215.5,456.2 210,461.7 204.5,456.2"/><polygon points="324,426.6 329.5,432.1 324,437.6 318.5,432.1"/><polygon points="438,406.6 443.5,412.1 438,417.6 432.5,412.1"/><polygon points="552,390.5 557.5,396 552,401.5 546.5,396"/></g>
<text class="lbl" x="566" y="400">budget 4000</text>
<text class="mu m" x="96" y="620">0.10</text>
<text class="mu m" x="210" y="620">0.20</text>
<text class="mu m" x="324" y="620">0.30</text>
<text class="mu m" x="438" y="620">0.40</text>
<text class="mu m" x="552" y="620">0.50</text>
<text class="m" x="324" y="644">fraction of the 50-sentence corpus that is independent</text>
</svg>

</div>

Read one budget at a time and the two panels swap rank. At budget 1500 the blue line is at the top
of the upper panel (up to **+52.9 %**) and at the bottom of the lower panel (**0.11**, so an
independence proof must cost about a ninth of an ordinary one). At budget 4000 the aqua line has
fallen to the floor of the upper panel (**0.0 % to 5.2 %**) and risen through the dashed parity
line in the lower one (**1.00 to 1.51**). Break-even exceeds the cost of an ordinary proof only in
the block where the gain has already collapsed below about 5 %.

| budget (units) | f_ind | (i) settles | (ii) at cost 0 | gain | break-even (units) | break-even / 40 |
|---|---|---|---|---|---|---|
| 1500 | 0.10 | 33.17 | 36.77 | +10.9 % | 4 | 0.11 |
| 1500 | 0.20 | 27.82 | 33.80 | +21.5 % | 7 | 0.18 |
| 1500 | 0.30 | 23.20 | 30.55 | +31.7 % | 9 | 0.22 |
| 1500 | 0.40 | 19.23 | 27.40 | +42.5 % | 10 | 0.25 |
| 1500 | 0.50 | 15.45 | 23.62 | +52.9 % | 11 | 0.27 |
| 2500 | 0.10 | 43.77 | 45.00 | +2.8 % | 18 | 0.44 |
| 2500 | 0.20 | 37.08 | 40.00 | +7.9 % | 25 | 0.62 |
| 2500 | 0.30 | 30.88 | 35.00 | +13.4 % | 27 | 0.67 |
| 2500 | 0.40 | 25.35 | 30.00 | +18.3 % | 29 | 0.72 |
| 2500 | 0.50 | 20.52 | 25.00 | +21.8 % | 30 | 0.74 |
| 4000 | 0.10 | 45.00 | 45.00 | +0.0 % | 40 | 1.00 |
| 4000 | 0.20 | 39.88 | 40.00 | +0.3 % | 42 | 1.06 |
| 4000 | 0.30 | 34.42 | 35.00 | +1.7 % | 50 | 1.24 |
| 4000 | 0.40 | 29.12 | 30.00 | +3.0 % | 56 | 1.39 |
| 4000 | 0.50 | 23.77 | 25.00 | +5.2 % | 60 | 1.51 |

Counts are sentences settled per run out of 50; "settles" columns are means over 40 seeds.

## 2. The baseline, where the registered prediction failed

Source: `experiment.py` block **E1**, re-run for this page. Budget 2500 units, attempt price 80
units, trigger 60 units.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 436" role="img" aria-labelledby="c2t c2d">
<title id="c2t">Reading (ii) loses at every independent fraction, including zero</title>
<desc id="c2d">Grouped bars of sentences settled per 1000 budget units. The first bar of each pair is reading (i), which is also exactly reading (ii) before any independence proof is purchased. The second bar is reading (ii) buying at 80 units, and it is lower everywhere. Figures are printed on the bars.</desc>
<text class="hd" x="14" y="26">Where the prediction failed: buying independence proofs loses at every fraction</text>
<text x="14" y="46">sentences settled per 1000 budget units; N=50, budget 2500, 40 seeds, attempt price 80 units</text>
<text class="warn" x="14" y="70">at zero independents no attempt could possibly succeed, and 760 units went on trying: minus 12.1 per cent</text>
<line class="ax" x1="110" y1="336" x2="660" y2="336"/>
<text class="mu e" x="102" y="340">0</text>
<line class="g" x1="110" y1="278.9" x2="660" y2="278.9"/>
<text class="mu e" x="102" y="282.9">5</text>
<line class="g" x1="110" y1="221.7" x2="660" y2="221.7"/>
<text class="mu e" x="102" y="225.7">10</text>
<line class="g" x1="110" y1="164.6" x2="660" y2="164.6"/>
<text class="mu e" x="102" y="168.6">15</text>
<line class="g" x1="110" y1="107.4" x2="660" y2="107.4"/>
<text class="mu e" x="102" y="111.4">20</text>
<text x="14" y="88">settled per</text>
<text x="14" y="104">1000 units</text>
<rect class="s1" x="127.2" y="107.7" width="44" height="228.3" rx="4"/>
<text class="val m" x="149.2" y="100.7">19.98</text>
<rect class="s2" x="173.2" y="135.2" width="44" height="200.8" rx="4"/>
<text class="val m" x="195.2" y="128.2">17.57</text>
<text class="mu m" x="172.2" y="358">0.00</text>
<rect class="s1" x="235.6" y="135.9" width="44" height="200.1" rx="4"/>
<text class="val m" x="257.6" y="128.9">17.51</text>
<rect class="s2" x="281.6" y="168.8" width="44" height="167.2" rx="4"/>
<text class="val m" x="303.6" y="161.8">14.63</text>
<text class="mu m" x="280.6" y="358">0.10</text>
<rect class="s1" x="344" y="166.5" width="44" height="169.5" rx="4"/>
<text class="val m" x="366" y="159.5">14.83</text>
<rect class="s2" x="390" y="188.8" width="44" height="147.2" rx="4"/>
<text class="val m" x="412" y="181.8">12.88</text>
<text class="mu m" x="389" y="358">0.20</text>
<rect class="s1" x="452.4" y="194.9" width="44" height="141.1" rx="4"/>
<text class="val m" x="474.4" y="187.9">12.35</text>
<rect class="s2" x="498.4" y="209" width="44" height="127" rx="4"/>
<text class="val m" x="520.4" y="202">11.11</text>
<text class="mu m" x="497.4" y="358">0.30</text>
<rect class="s1" x="560.8" y="242.2" width="44" height="93.8" rx="4"/>
<text class="val m" x="582.8" y="235.2">8.21</text>
<rect class="s2" x="606.8" y="245.3" width="44" height="90.7" rx="4"/>
<text class="val m" x="628.8" y="238.3">7.94</text>
<text class="mu m" x="605.8" y="358">0.50</text>
<text class="m" x="389" y="382">fraction of the corpus that is independent</text>
<rect class="s1" x="118" y="392" width="14" height="14" rx="3"/>
<text x="138" y="404">reading (i), and reading (ii) before any purchase: identical to every digit</text>
<rect class="s2" x="118" y="412" width="14" height="14" rx="3"/>
<text x="138" y="424">reading (ii), buying an independence proof at 80 units</text>
</svg>

</div>

The registered prediction was that the two readings tie at zero independent sentences and that (ii)
then wins by a growing margin. Half of it holds and half of it inverts.

- **At zero independents, (i) settles 19.98 per 1000 units and (ii) settles 17.57**, a loss of
  12.1 %. All 760 units (ii) spent bought independence checks that could not possibly succeed:
  there was nothing independent in the corpus.
- **(ii) loses at every fraction tested**, including 0.50, where 8.21 falls to 7.94.
- E1's `ii-nocheck` column equals its (i) column **to every printed digit at every fraction**, which
  is why the blue bar is labelled as both. Until somebody pays for an independence proof, an
  independent sentence reports the same point under both readings. The distinction is a
  **purchase**, not information already sitting in the data.

## 3. The conflation costs more than the feature is worth

Source: `experiment.py` block **E3**, re-run for this page. Coin fraction 0.30 means 15 of the 50
sentences are the second inhabitant of the point (0,1): decided, with no idea which way, which is
Ellsberg's known-fair coin.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 316" role="img" aria-labelledby="c3t c3d">
<title id="c3t">The richer interface performs worse: coin sentences settled at coin fraction 0.30</title>
<desc id="c3d">Horizontal bars out of the 15 known-fair-coin sentences present. Reading (i) settles 13.93, the four-weight oracle 12.18, reading (ii) 1.45. Performance runs opposite to interface richness.</desc>
<text class="hd" x="14" y="26">The conflation at the point (0,1) costs more than the distinction is worth</text>
<text x="14" y="46">coin sentences settled, of the 15 present; coin fraction 0.30, independent fraction 0.20, budget 2500</text>
<line class="ax" x1="360" y1="76" x2="360" y2="246"/>
<text class="mu m" x="360" y="268">0</text>
<line class="g" x1="473.3" y1="76" x2="473.3" y2="246"/>
<text class="mu m" x="473.3" y="268">5</text>
<line class="g" x1="586.7" y1="76" x2="586.7" y2="246"/>
<text class="mu m" x="586.7" y="268">10</text>
<line class="g" x1="700" y1="76" x2="700" y2="246"/>
<text class="mu m" x="700" y="268">15</text>
<text class="m" x="530" y="290">coin sentences settled, of 15 present</text>
<rect class="s1" x="360" y="92" width="315.7" height="30" rx="4"/>
<text class="e" x="348" y="106">reading (i), sees the truth lean only</text>
<text class="mu e" x="348" y="121">poorest interface</text>
<text class="val" x="683.7" y="112">13.93</text>
<rect class="s3" x="360" y="144" width="276.1" height="30" rx="4"/>
<text class="e" x="348" y="158">four-weight oracle, sees the simplex point</text>
<text class="mu e" x="348" y="173">richest interface</text>
<text class="val" x="644.1" y="164">12.18</text>
<rect class="s2" x="360" y="196" width="32.9" height="30" rx="4"/>
<text class="e" x="348" y="210">reading (ii), sees the two-number report</text>
<text class="mu e" x="348" y="225">middle interface</text>
<text class="val" x="400.9" y="216">1.45</text>
<text class="warn" x="14" y="312">Reading (ii) throws away 4.07 settled sentences per 1000 units, 32 per cent of the oracle throughput.</text>
</svg>

</div>

The bars are in performance order, and that order **inverts** interface richness. Reading (ii) sees
the settledness number and is destroyed by it: it settles **1.45 of 15**, because a coin advertises
certainty it does not have and (ii)'s drop rule believes it. The four-weight oracle, which can
separate the two inhabitants of (0,1), settles **12.18**. Plain reading (i) settles **13.93**,
beating the oracle, precisely because it **cannot see the settledness number at all** and so cannot
be misled. The bill to (ii) is 4.07 settled sentences per 1000 units, 32 % of achievable throughput.
A richer interface performing worse than a poorer one is the largest single effect measured anywhere
in the cluster.

| coin fraction | coins present | (i) | (ii) | oracle |
|---|---|---|---|---|
| 0.10 | 5 | 4.72 | 0.42 | 4.25 |
| 0.20 | 10 | 9.40 | 0.90 | 8.30 |
| 0.30 | 15 | 13.93 | 1.45 | 12.18 |

## 4. The thermodynamics numbers

Source: [`logic-thermodynamics.md`](logic-thermodynamics) sections 3 and 5.

The partition function over proofs, sum over n of a to the n times exp(-beta n), converges **iff**
beta > log a, so there is a critical temperature above which no Boltzmann distribution over proofs
exists at all. Measured on a concrete tiny Hilbert system (implicational fragment over two atoms,
modus ponens, **76 axiom instances**, exact proof counts to n = 26): branching factor
**a = 2.3445**, hence **beta_c = log a = 0.8520** and **T_c = 1.174 axiom leaves**. Mean proof
length diverges at that point, which is a genuine Hagedorn signature. It is also the analogy's
undoing: the branching factor for proofs of one theorem matches the branching factor for all proofs
to four digits, **2.3445 against 2.3445**, so T_c is a property of the proof system and knows
nothing about the goal.

Then the accounting that delivers the verdict, at 300 K with the Landauer floor
k_B T ln 2 = 2.871 zJ per erased bit, against roughly 34 J actually spent:

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 384" role="img" aria-labelledby="c4t c4d">
<title id="c4t">How far the second law is from binding: proof search against laser cooling</title>
<desc id="c4d">Logarithmic axis of the ratio between energy actually spent and the Landauer floor at 300 K. Laser cooling sits near 10 to the 3, where the bound genuinely constrains the physics. Proof search sits between 10 to the 11 and 10 to the 22. Each bar is labelled with its value.</desc>
<text class="hd" x="14" y="26">Same accounting, opposite verdict: the thermodynamic analogy is a costume</text>
<text font-size="13" x="14" y="46">energy spent divided by the Landauer floor at 300 K, a dimensionless ratio; log scale, one tick per 10 to the 4</text>
<rect class="zone" x="356" y="84" width="55.7" height="224"/>
<text class="m" x="383.8" y="76">bound bites</text>
<line class="ax" x1="356" y1="84" x2="356" y2="308"/>
<text class="mu m" x="356" y="328">10^0</text>
<line class="g" x1="411.7" y1="84" x2="411.7" y2="308"/>
<text class="mu m" x="411.7" y="328">10^4</text>
<line class="g" x1="467.3" y1="84" x2="467.3" y2="308"/>
<text class="mu m" x="467.3" y="328">10^8</text>
<line class="g" x1="523" y1="84" x2="523" y2="308"/>
<text class="mu m" x="523" y="328">10^12</text>
<line class="g" x1="578.7" y1="84" x2="578.7" y2="308"/>
<text class="mu m" x="578.7" y="328">10^16</text>
<line class="g" x1="634.3" y1="84" x2="634.3" y2="308"/>
<text class="mu m" x="634.3" y="328">10^20</text>
<line class="g" x1="690" y1="84" x2="690" y2="308"/>
<text class="mu m" x="690" y="328">10^24</text>
<text class="m" x="523" y="350">margin above the Landauer floor</text>
<rect class="s3" x="356" y="89" width="41.8" height="20" rx="4"/>
<text class="e" x="344" y="104">Doppler cooling of Rb87 (lasercool.md)</text>
<text class="val" x="405.8" y="104">about 10^3</text>
<rect class="s3" x="356" y="121" width="34.5" height="20" rx="4"/>
<text class="e" x="344" y="136">Doppler cooling of Na (lasercool.md)</text>
<text class="val" x="398.5" y="136">about 3 x 10^2</text>
<rect class="s1" x="356" y="153" width="157.8" height="20" rx="4"/>
<text class="e" x="344" y="168">whole 4 GiB cap erased every second</text>
<text class="val" x="521.8" y="168">2.2 x 10^11</text>
<rect class="s1" x="356" y="185" width="161" height="20" rx="4"/>
<text class="e" x="344" y="200">whole 4 GiB cap erased once</text>
<text class="val" x="525" y="200">3.7 x 10^11</text>
<rect class="s1" x="356" y="217" width="182" height="20" rx="4"/>
<text class="e" x="344" y="232">10^9 bits of scratch erased</text>
<text class="val" x="546" y="232">1.2 x 10^13</text>
<rect class="s1" x="356" y="249" width="291.6" height="20" rx="4"/>
<text class="e" x="344" y="264">Mathlib build, per theorem</text>
<text class="val" x="655.6" y="264">3 to 9 x 10^20</text>
<rect class="s1" x="356" y="281" width="307.2" height="20" rx="4"/>
<text class="e" x="344" y="296">per settled sentence, one bit</text>
<text class="val" x="671.2" y="296">1.2 x 10^22</text>
<text class="e mu" x="344" y="76">laser cooling</text>
<text class="warn" x="14" y="374">Laser cooling has a margin of about 1000, so the bound bites. Proof search has 10 to the 11 up to 10 to the 22.</text>
</svg>

</div>

The two aqua bars are [`lasercool.md`](lasercool)'s, computed by the same method: Doppler cooling of
Rb87 clears the second law by a factor of about **10^3**, sodium by about **3 x 10^2**, close enough
that the bound genuinely constrains what a cooling scheme can do. Every blue bar is proof search,
and the nearest is **2.2 x 10^11**. To make the Landauer bound reach the 34 J a proof run actually
costs, one would have to erase **1.2 x 10^22 bits**, about 1.5 x 10^9 terabytes. Three orders of
magnitude is a physics constraint; eleven to twenty-two is a coincidence of notation. The Mathlib
row is drawn at the conservative end of its 3 to 9 x 10^20 range and rests on an assumed 2 to 6
CPU-hour build at 20 W, not a measurement.

## 5. Honesty panel: what these numbers are not

**The scheduler is a simulation, and the `independent` label is stipulated, not discovered.** The
corpus generator attaches it when it builds the corpus; no prover ever proves anything independent
in this experiment. So charts 1 to 3 measure whether the **interface is actionable** given reports
of that shape. They do not measure, and cannot measure, whether real provers can produce such
reports. That boundary is structural, and no number of extra seeds moves it.

The sampling, by contrast, is settled. Per-run settled counts have a **standard deviation of 2.36
sentences**, giving a **standard error of 0.37** on a forty-seed cell mean, and **quadrupling the
sample to 160 seeds left the interpolated break-even unchanged at 26.8 units**. The effects above
are far larger than that noise. Under heavy-tailed Pareto difficulties the whole effect shrinks:
reading (ii) at cost 80 loses by 0.7 % rather than 12 % at zero independents.

Two further things the charts do not carry. The corpus is a flat bag of sentences with **no logical
relations between them**, so nothing here models a real theory where settling one sentence settles
others. And chart 4's Mathlib row is an estimate, as noted.

The D3 fork is therefore **informed and not settled**. These measurements convert a philosophical
question into an engineering threshold and then report where the threshold sits. What an
independence proof actually costs in the real world is the one input a simulation cannot supply, and
whether the two-number report or the four-weight simplex point is the object is an interface change
and therefore an owner decision. **The owner rules; this page reports.**

## Reproducing the figures

```
bash docs/dreamed/scheduler/run.sh experiment.py e1 e3 e7
```

Everything runs under [`capped.sh`](capped.sh) at `-m 2G -c 100 -t 300`, a systemd user scope with a
hard cgroup memory cap and no swap, in under a minute on one core. Those three blocks print exactly
the tables above. Chart 4's inputs are quoted from
[`logic-thermodynamics.md`](logic-thermodynamics) sections 3 and 5 and [`lasercool.md`](lasercool);
the proof-count script behind a = 2.3445 is not committed, and that essay states its recipe instead.
