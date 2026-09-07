---
title: Thermodynamics, entropy and the laser wing
permalink: /dreamed/fig-thermo-laser
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This page *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself.

This is a **figure sheet**, not an essay. Six essays written on 2026-09-01, all seeded by the owner
on his own [`physics/lasercool.md`](../../physics/lasercool), [`physics/entropy.md`](../../physics/entropy),
[`physics/acoustics.md`](../../physics/Accoustics) and his StackExchange corpus, produced numbers and
exclusion arguments. This page draws them and nothing else. Every value is read off a named essay
section; where a chart shows an arithmetic rearrangement of an essay's own formula rather than a
number the essay printed, the caption says so. **All of it is UNRATIFIED**: each headline below is
an AI recommendation awaiting the owner's ruling, and section 7 says which ones are filed in
`REVIEW_ME.md` and which are still only in their essay.

Sources, in the order they appear: [`lasercool`](lasercool), [`five-level-laser`](five-level-laser),
[`photon-energy-scaling`](photon-energy-scaling), [`lambertw-statistics`](lambertw-statistics),
[`wick-entropy`](wick-entropy), [`acoustics`](acoustics).

<style>
.tsfig{display:block;width:100%;height:auto;max-width:760px;margin:0 auto;background:#fcfcfb;font-family:system-ui,-apple-system,"Segoe UI",sans-serif}
.tsfig text{fill:#52514e;font-size:13px}
.tsfig .hd{fill:#0b0b0b;font-size:15px;font-weight:600}
.tsfig .sh{fill:#0b0b0b;font-size:13px;font-weight:600}
.tsfig .mu{fill:#898781}
.tsfig .sm{font-size:12px}
.tsfig .e{text-anchor:end}
.tsfig .m{text-anchor:middle}
.tsfig .lbl{fill:#0b0b0b;font-weight:600}
.tsfig .crt{fill:#d03b3b;font-weight:600}
.tsfig .gd{fill:#0ca30c;font-weight:600}
.tsfig .g{stroke:#e1e0d9;stroke-width:1}
.tsfig .ax{stroke:#c3c2b7;stroke-width:1}
.tsfig .ln{fill:none;stroke-width:2;stroke-linejoin:round;stroke-linecap:round}
.tsfig .dsh{fill:none;stroke-width:2;stroke-dasharray:7 5}
.tsfig .thin{fill:none;stroke-width:1.5}
.tsfig .mk{stroke:#fcfcfb;stroke-width:2}
.tsfig .s1{fill:#2a78d6}.tsfig .s1k{stroke:#2a78d6}
.tsfig .s2{fill:#eb6834}.tsfig .s2k{stroke:#eb6834}
.tsfig .s3{fill:#1baf7a}.tsfig .s3k{stroke:#1baf7a}
.tsfig .ck{stroke:#d03b3b}
.tsfig .zone{fill:#f0efec}
.tsfig .bad{fill:#d03b3b;opacity:0.13}
.tsfig .ok{fill:#2a78d6;opacity:0.10}
</style>

## 1. The entropy margin, corrected: about 10<sup>3</sup>, not 10<sup>7</sup>

Source: [`lasercool.md`](lasercool) sections 2, 3 and 4 (Rb87 D2, 780.241 nm, natural linewidth
6.0666 MHz). The inequality that licenses laser cooling holds, but not by the factor the standard
"one pump mode against 4 pi steradians of fluorescence" picture implies. The reason is on the atom
side, not the field side: what a Doppler-cooled atom can shed per scattered photon is bounded by the
inverse sideband-resolution parameter,

$$ \sigma_\mathrm{atom} \;\le\; k_B\frac{T_\mathrm{rec}}{T_D} \;=\; \frac{4\omega_\mathrm{rec}}{\Gamma}\,k_B $$

and for Rb87 that is 2.49 millikelvin-scale-free units of nothing at all: it is
2.49 x 10<sup>-3</sup> k<sub>B</sub> per photon, four orders below the folklore.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 434" role="img" aria-labelledby="f1t f1d">
<title id="f1t">Entropy per photon: what the field gains, what an atom can shed, what the pump delivers</title>
<desc id="f1d">A base-10 logarithmic axis in units of Boltzmann's constant per photon, running from 1e-9 to 10. Fluorescence carries 2.28 to 7.71 k_B per photon. A Doppler-cooled Rb87 atom can shed at most 2.49e-3 and sodium 1.02e-2. The pump beam carries 5.9e-9 and a published diode figure 1.3e-7. The gap between the atom bound and the fluorescence is about a factor 1000, not the factor 10 million a naive mode count suggests. Figures repeated in the table below.</desc>
<text class="hd" x="14" y="26">Entropy per photon, Rb87 D2 laser cooling</text>
<text font-size="13" x="14" y="46">k_B per photon, base-10 log axis. The margin is the gap between the two labelled lanes, not a mode count.</text>

<line class="g" x1="100" y1="76" x2="100" y2="336"/>
<line class="g" x1="160" y1="76" x2="160" y2="336"/>
<line class="g" x1="220" y1="76" x2="220" y2="336"/>
<line class="g" x1="280" y1="76" x2="280" y2="336"/>
<line class="g" x1="340" y1="76" x2="340" y2="336"/>
<line class="g" x1="400" y1="76" x2="400" y2="336"/>
<line class="g" x1="460" y1="76" x2="460" y2="336"/>
<line class="g" x1="520" y1="76" x2="520" y2="336"/>
<line class="g" x1="580" y1="76" x2="580" y2="336"/>
<line class="g" x1="640" y1="76" x2="640" y2="336"/>
<line class="g" x1="700" y1="76" x2="700" y2="336"/>
<line class="ax" x1="100" y1="336" x2="700" y2="336"/>
<text class="mu sm m" x="100" y="354">1e-9</text>
<text class="mu sm m" x="220" y="354">1e-7</text>
<text class="mu sm m" x="340" y="354">1e-5</text>
<text class="mu sm m" x="460" y="354">1e-3</text>
<text class="mu sm m" x="580" y="354">0.1</text>
<text class="mu sm m" x="700" y="354">10</text>
<text class="mu sm m" x="400" y="374">entropy per photon, k_B per photon (log scale, base 10)</text>

<text class="sh" x="14" y="100">Field gains</text>
<line class="ln s3k" x1="661.5" y1="112" x2="693.2" y2="112"/>
<g class="mk s3"><circle cx="661.5" cy="112" r="5.5"/><circle cx="693.2" cy="112" r="5.5"/></g>
<text class="lbl e" x="700" y="94">2.28 to 7.71 (fluorescence)</text>

<text class="sh" x="14" y="160">Atoms shed</text>
<g class="mk s2"><rect x="478.3" y="166.5" width="11" height="11"/><rect x="515" y="166.5" width="11" height="11"/></g>
<text class="lbl e" x="472" y="176">Rb87 bound 2.49e-3</text>
<text class="lbl" x="534" y="176">Na bound 1.02e-2</text>

<text class="sh" x="14" y="222">Pump delivers</text>
<g class="mk s1"><polygon points="146.3,222 152,228 146.3,234 140.6,228"/><polygon points="226.8,222 232.5,228 226.8,234 221.1,228"/></g>
<text class="lbl" x="160" y="216">1 mW, 780 nm, 1 MHz linewidth: 5.9e-9</text>
<text class="lbl" x="240" y="246">Ruan 2007 diode beam: 1.3e-7</text>

<text class="lbl m" x="572" y="258">ACTUAL margin, Rb87: about 10&#179;</text>
<line class="ln s2k" x1="483.8" y1="270" x2="661.5" y2="270"/>
<line class="ln s2k" x1="483.8" y1="264" x2="483.8" y2="276"/>
<line class="ln s2k" x1="661.5" y1="264" x2="661.5" y2="276"/>

<text class="crt m" x="451" y="296">what the folklore "one mode against 4&#960;" implies: 10&#8311;</text>
<line class="dsh ck" x1="241.5" y1="308" x2="661.5" y2="308"/>
<line class="ln ck" x1="241.5" y1="302" x2="241.5" y2="314"/>
<line class="ln ck" x1="661.5" y1="302" x2="661.5" y2="314"/>
<text class="mu sm m" x="451" y="328">(dashed bracket is a construction: the exhaust value divided by 10&#8311;)</text>

<text class="gd sm" x="14" y="402">Reabsorption is a RATE problem, not a second-law problem: the margin closes only at n_f = 3.1e3,</text>
<text class="gd sm" x="14" y="420">and free-space radiation trapping pushes n_f from 1e-2 only toward 1, six orders short.</text>
</svg>

</div>

| quantity | value, k<sub>B</sub> per photon | source |
|---|---|---|
| pump, 1 mW at 780 nm, one spatial mode, 1 MHz linewidth (n̄ = 3.9 x 10<sup>9</sup>) | 5.9 x 10<sup>-9</sup> | `lasercool.md` section 3 |
| published diode-beam figure (Ruan, Rand and Kaviany, PRB **75**, 214304 (2007)) | 1.30 x 10<sup>-7</sup> | `lasercool.md` section 2 |
| **atom bound, Rb87** (`sigma_atom <= k_B T_rec/T_D`, T<sub>rec</sub> = 362 nK, T<sub>D</sub> = 145.6 µK) | **2.49 x 10<sup>-3</sup>** | `lasercool.md` section 3 |
| atom bound, Na D2 (589.158 nm, 9.795 MHz) | 1.02 x 10<sup>-2</sup> | `lasercool.md` section 3 |
| fluorescence, 10<sup>7</sup>-atom MOT (n̄<sub>f</sub> = 0.32) | 2.28 | `lasercool.md` section 3 |
| fluorescence, 10<sup>6</sup> atoms | 4.45 | `lasercool.md` section 3 |
| single atom, emitting area lambda<sup>2</sup> | 4.20 | `lasercool.md` section 3 |
| published fluorescence figure (Ruan 2007, 1 µm) | 7.71 | `lasercool.md` section 2 |

Stated margins: **about 10<sup>3</sup> for Rb87, about 3 x 10<sup>2</sup> for Na**. The essay's own
verdict: *"That is smaller than the ~10<sup>7</sup> suggested by 'one mode versus 4 pi', because the
atoms are terrible at shedding entropy, not because the field is bad at absorbing it."*

## 2. Lasing while cooling: a NO-GO at theorem strength

Source: [`five-level-laser.md`](five-level-laser) sections 3, 4 and 8. Two independent exclusions,
both drawn below. Left: the chained detailed-balance bound on the level ratio, which forbids
inversion whenever the cycle draws net heat. Right: the Scovil-Schulz-DuBois bound
(*Phys. Rev. Lett.* **2**, 262 (1959)), generalised verbatim to the five-level scheme, which puts the
inversion ceiling and the cooling floor on opposite sides of the same line.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 452" role="img" aria-labelledby="f2t f2d">
<title id="f2t">Two region diagrams: inversion and cooling do not overlap</title>
<desc id="f2d">Left panel plots the upper-to-lower laser level population ratio on a log axis against the net heat drawn per cycle in units of k_B T. The chained bound N3 over N4 at most exp of minus Q over k_B T passes exactly through the point where the ratio is one and the heat is zero, so the whole quadrant with net cooling and inversion together is unreachable. Right panel plots the laser-to-pump energy ratio against the lattice-to-pump-brightness temperature ratio. The Scovil-Schulz-DuBois ceiling one minus T over T_p lies below the cooling floor of one for every positive temperature ratio; the two touch only at zero.</desc>
<text class="hd" x="14" y="26">Inversion and cooling are mutually exclusive, at any pump strength and any laser intensity</text>

<text class="sh" x="14" y="52">a. The chained detailed-balance bound</text>
<text class="sm" x="14" y="70">N&#8323;/N&#8324; on a log axis against net heat drawn per cycle</text>
<rect class="bad" x="215" y="80" width="145" height="100"/>
<polygon class="ok" points="70,180 215,180 215,284.2 360,284.2 360,300 70,300"/>
<line class="g" x1="70" y1="80" x2="360" y2="80"/>
<line class="g" x1="70" y1="120" x2="360" y2="120"/>
<line class="ax" x1="70" y1="180" x2="360" y2="180"/>
<line class="g" x1="70" y1="240" x2="360" y2="240"/>
<line class="g" x1="70" y1="300" x2="360" y2="300"/>
<text class="mu sm e" x="64" y="84">100</text>
<text class="mu sm e" x="64" y="124">10</text>
<text class="mu sm e" x="64" y="184">1</text>
<text class="mu sm e" x="64" y="244">0.1</text>
<text class="mu sm e" x="64" y="304">0.01</text>
<line class="ax" x1="70" y1="300" x2="360" y2="300"/>
<line class="ax" x1="215" y1="80" x2="215" y2="300"/>
<text class="mu sm m" x="70" y="318">-4</text>
<text class="mu sm m" x="142.5" y="318">-2</text>
<text class="mu sm m" x="215" y="318">0</text>
<text class="mu sm m" x="287.5" y="318">+2</text>
<text class="mu sm m" x="360" y="318">+4</text>
<text class="mu sm m" x="215" y="338">Q / k_B T, net heat drawn from the lattice per cycle</text>
<text class="mu sm m" x="215" y="352">(Q = &#916; - E&#8324; = h&#957;_L - h&#957;_p1 - h&#957;_p2; Q &gt; 0 is cooling)</text>
<line class="ln s1k" x1="70" y1="75.8" x2="360" y2="284.2"/>
<text class="s1 sm lbl" x="76" y="100">bound N&#8323;/N&#8324; &#8804; e^(-Q/k_B T)</text>
<text class="crt sm" x="222" y="100">FORBIDDEN</text>
<text class="crt sm" x="222" y="116">inversion AND</text>
<text class="crt sm" x="222" y="132">net cooling</text>
<text class="crt sm" x="222" y="148">(empty region)</text>
<text class="s1 sm" x="76" y="272">reachable</text>
<text class="mu sm e" x="356" y="196">heating</text>
<text class="mu sm e" x="356" y="212">no inversion</text>

<text class="sh" x="420" y="52">b. Scovil-Schulz-DuBois, generalised</text>
<text class="sm" x="420" y="70">laser/pump energy ratio against T/T_p</text>
<rect class="bad" x="440" y="80" width="290" height="70"/>
<polygon class="ok" points="440,150 730,300 440,300"/>
<line class="g" x1="440" y1="80" x2="730" y2="80"/>
<line class="g" x1="440" y1="112.5" x2="730" y2="112.5"/>
<line class="g" x1="440" y1="187.5" x2="730" y2="187.5"/>
<line class="g" x1="440" y1="225" x2="730" y2="225"/>
<line class="g" x1="440" y1="262.5" x2="730" y2="262.5"/>
<line class="ax" x1="440" y1="300" x2="730" y2="300"/>
<line class="ax" x1="440" y1="80" x2="440" y2="300"/>
<text class="mu sm e" x="434" y="84">1.4</text>
<text class="mu sm e" x="434" y="154">1.0</text>
<text class="mu sm e" x="434" y="229">0.5</text>
<text class="mu sm e" x="434" y="304">0</text>
<text class="mu sm m" x="440" y="318">0</text>
<text class="mu sm m" x="585" y="318">0.5</text>
<text class="mu sm m" x="730" y="318">1.0</text>
<text class="mu sm m" x="585" y="338">T / T_p, lattice temperature over pump brightness temperature</text>
<text class="mu sm m" x="585" y="352">(dimensionless; a laser pump is the limit T_p &#8594; &#8734;, i.e. T/T_p &#8594; 0)</text>
<line class="ln s2k" x1="440" y1="150" x2="730" y2="300"/>
<line class="dsh s1k" x1="440" y1="150" x2="730" y2="150"/>
<text class="s2 sm lbl" x="600" y="272">inversion ceiling 1 - T/T_p</text>
<text class="s1 sm lbl" x="446" y="168">cooling floor: h&#957;_L / &#931;h&#957;_p &gt; 1</text>
<text class="crt sm m" x="585" y="106">net cooling requires this band</text>
<text class="crt sm m" x="585" y="126">and inversion forbids it: EMPTY</text>
<text class="mu sm" x="446" y="290">inversion allowed</text>

<text class="sh" x="14" y="380">What survives: the same cycle run as a FLUORESCENCE cooler, where spontaneous 3&#8594;4 needs no inversion.</text>
<text class="sm" x="14" y="400">Cooling needs the energy ratio above 1; inversion needs it below the ceiling 1 - T/T_p. They meet only at T/T_p = 0.</text>
<text class="sm" x="14" y="418">COP per absorbed pump pair 2.2% at Q = k_B T and 6.5% at Q = 3k_B T (300 K, E&#8322; = 1.2 eV), against a</text>
<text class="sm" x="14" y="436">Carnot ceiling of 0.199 for a fluorescence flux temperature T_F = 1808 K: a factor 3 below its own limit.</text>
</svg>

</div>

The exact steady state (SymPy on the full 5 x 5 rate matrix, all ten rates kept) says the same thing
algebraically: the **only positive term** in the gain numerator carries the lift Boltzmann factor
b<sub>3</sub>, so gain requires `b_3 > b_4`, i.e. `Delta < E_4`, i.e. `Q < 0`. The laser intensity L
does not appear in the numerator at all. A Monte Carlo over 2 x 10<sup>5</sup> random rate sets
spanning six decades, including parasitic bypass decays outside the single-cycle topology, found
**12825 inverted samples and zero with `b_3 < b_4`** (`five-level-laser.md` section 3).

## 3. The Wien law with exponent 4: an optimum next to a non-optimum

Source: [`photon-energy-scaling.md`](photon-energy-scaling) sections 3 and 4. Left, cooling power
against harvested energy per photon: a genuine interior maximum, at the root of Wien's transcendental
equation with exponent 4. Right, the coefficient of performance on the same device: monotone, no
stationary point anywhere, with Carnot sitting as a boundary point on the curve rather than a peak of
it.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 456" role="img" aria-labelledby="f3t f3d">
<title id="f3t">A power optimum exists; a COP optimum does not</title>
<desc id="f3d">Left panel plots normalised cooling power, proportional to y to the fourth over exp y minus one, against the harvested energy per photon y in units of k_B T_c. It rises from zero, peaks at y equals 3.920690395, and falls away. Marks on the axis show the neighbouring Wien constants for rate exponents 1, 2 and 4. Right panel plots coefficient of performance against the harvested fraction of each photon on log-log axes. It is a single monotone curve with no stationary point, diverging as the harvested fraction approaches one, and the second law cuts the axis at the cold-over-hot temperature ratio. Figures in the tables below.</desc>
<text class="hd" x="14" y="26">An optimum in POWER; no optimum in COP</text>

<text class="sh" x="14" y="52">a. Cooling power, y&#8308;/(e^y - 1), normalised to its own maximum</text>
<line class="g" x1="70" y1="80.95" x2="380" y2="80.95"/>
<line class="g" x1="70" y1="135.7" x2="380" y2="135.7"/>
<line class="g" x1="70" y1="190.5" x2="380" y2="190.5"/>
<line class="g" x1="70" y1="245.3" x2="380" y2="245.3"/>
<line class="ax" x1="70" y1="300" x2="380" y2="300"/>
<line class="ax" x1="70" y1="70" x2="70" y2="300"/>
<text class="mu sm e" x="64" y="85">1.0</text>
<text class="mu sm e" x="64" y="140">0.75</text>
<text class="mu sm e" x="64" y="195">0.5</text>
<text class="mu sm e" x="64" y="250">0.25</text>
<text class="mu sm e" x="64" y="304">0</text>
<polyline class="ln s1k" points="70,300 77.8,298.9 82.9,295.6 89.4,287 95.8,273.3 102.3,255.1 108.8,233.4 115.2,209.6 121.7,185.2 128.1,161.6 134.6,139.9 141,121 147.5,105.5 154,93.8 160.4,85.9 166.9,81.8 171.3,81 179.8,83.7 186.3,88.9 199.2,105.7 212.1,127.9 225,152.4 250.8,199.6 276.7,237 302.5,262.9 328.3,279.2 354.2,288.8 380,294.2"/>
<line class="dsh ck" x1="171.3" y1="81" x2="171.3" y2="300"/>
<circle class="mk s1" cx="171.3" cy="81" r="5.5"/>
<text class="crt sm lbl" x="180" y="76">y* = 3.920690395</text>
<text class="crt sm" x="180" y="92">= 4 + W&#8320;(-4e&#8315;&#8308;)</text>
<text class="sm" x="180" y="112">24.508 THz at T_c = 300 K,</text>
<text class="sm" x="180" y="128">wavelength 12.232 &#181;m</text>
<line class="ax" x1="111.2" y1="300" x2="111.2" y2="308"/>
<line class="ax" x1="142.9" y1="300" x2="142.9" y2="308"/>
<line class="ax" x1="198.3" y1="300" x2="198.3" y2="308"/>
<text class="mu sm m" x="70" y="318">0</text>
<text class="mu sm m" x="121.7" y="318">2</text>
<text class="mu sm m" x="173.3" y="318">4</text>
<text class="mu sm m" x="225" y="318">6</text>
<text class="mu sm m" x="276.7" y="318">8</text>
<text class="mu sm m" x="328.3" y="318">10</text>
<text class="mu sm m" x="380" y="318">12</text>
<text class="mu sm m" x="225" y="338">y = (h&#957; - &#956;)/k_B T_c, heat harvested per photon (dimensionless)</text>
<text class="mu sm m" x="225" y="354">ticks below axis: the neighbouring Wien constants, 1.5936 / 2.8214 / 4.9651</text>

<text class="sh" x="420" y="52">b. COP = u/(1 - u), same device, both axes log</text>
<line class="g" x1="440" y1="70.25" x2="730" y2="70.25"/>
<line class="g" x1="440" y1="127.5" x2="730" y2="127.5"/>
<line class="g" x1="440" y1="185" x2="730" y2="185"/>
<line class="g" x1="440" y1="242.5" x2="730" y2="242.5"/>
<line class="ax" x1="440" y1="300" x2="730" y2="300"/>
<line class="ax" x1="440" y1="70" x2="440" y2="300"/>
<text class="mu sm e" x="434" y="74">100</text>
<text class="mu sm e" x="434" y="132">10</text>
<text class="mu sm e" x="434" y="189">1</text>
<text class="mu sm e" x="434" y="247">0.1</text>
<text class="mu sm e" x="434" y="304">0.01</text>
<polyline class="ln s2k" points="440,299.8 500.6,282.2 554.4,258.5 595,239.9 635.6,219.6 659.4,206.2 689.4,185 709.1,163.8 723.8,130.1 727,111.5 729.4,70.3"/>
<line class="dsh ck" x1="730" y1="70" x2="730" y2="300"/>
<text class="crt sm e" x="726" y="86">u &#8594; 1</text>
<g class="mk s2"><circle cx="487.6" cy="287.9" r="5.5"/><circle cx="637.9" cy="218.4" r="5.5"/><circle cx="650" cy="211.8" r="5.5"/></g>
<line class="thin ax" x1="487.6" y1="287.9" x2="470" y2="266"/>
<text class="lbl sm" x="446" y="262">780 nm, u = 1.6%, COP 0.016</text>
<line class="thin ax" x1="637.9" y1="218.4" x2="620" y2="252"/>
<text class="lbl sm e" x="618" y="266">10 &#181;m, u = 20.8%</text>
<line class="thin ax" x1="650" y1="211.8" x2="676" y2="176"/>
<text class="lbl sm e" x="730" y="172">24.51 THz optimum, u = 25.5%</text>
<text class="mu sm m" x="440" y="318">0.01</text>
<text class="mu sm m" x="595" y="318">0.1</text>
<text class="mu sm m" x="730" y="318">1</text>
<text class="mu sm m" x="585" y="338">u = (h&#957; - &#956;)/h&#957;, harvested fraction of each photon (log)</text>
<text class="mu sm m" x="585" y="354">second law cut: u &lt; T_c/T_h for cooling; COP = t/(1-t) there</text>

<text class="crt sm" x="14" y="386">No interior COP optimum exists: the derivative of y/(x-y) with respect to x is -y/(x-y)&#178;, negative everywhere.</text>
<text class="crt sm" x="14" y="404">Cheaper photons are always better for COP without limit, and the supremum is Carnot on the zero-flux boundary.</text>
<text class="gd sm" x="14" y="426">The optimum the seed was reaching for is real, and it is a POWER optimum: 3.920690395 k_B T_c per photon,</text>
<text class="gd sm" x="14" y="444">essentially independent of frequency, of the temperature ratio, and of the operating point.</text>
</svg>

</div>

The Wien family, from `photon-energy-scaling.md` section 4 (for a rate prefactor
`kappa` proportional to `nu^p`, the optimum is `y* = n + W_0(-n e^-n)` with `n = p + 1`):

| rate law | n | y* | reading |
|---|---|---|---|
| `kappa ~ nu` | 2 | 1.593624260 | Wien peak of the photon-number spectrum |
| `kappa ~ nu^2` (mode-density-limited) | 3 | 2.821439372 | Wien's frequency displacement law |
| **`kappa ~ nu^3` (free-space Einstein A)** | **4** | **3.920690395** | **this result** |
| `kappa ~ nu^4` | 5 | 4.965114232 | Wien's wavelength displacement law |

Robustness, from the same section: exact maximisation of the full expression (with the ambient term
kept) gives y* = 3.920690 to seven digits for harvest fractions up to 0.2, drifting only to 4.6899 at
harvest fraction 0.9. **Panel b is an algebraic rearrangement, flagged as such**: the essay writes
COP = (h nu - mu)/mu, which in the harvested fraction u = (h nu - mu)/h nu is exactly u/(1 - u), and
the Carnot bound COP < T<sub>c</sub>/(T<sub>h</sub> - T<sub>c</sub>) is exactly u < T<sub>c</sub>/T<sub>h</sub>.
The three marked points are the essay's own section 6 wall table (x = h nu / k<sub>B</sub>T<sub>c</sub> of
61.47, 4.796 and 3.921) at a harvest of one k<sub>B</sub>T<sub>c</sub> per photon, which is the essay's
stated "1.6 % at 780 nm" and its "harvest up to 21 to 26 % of h nu" in the mid-infrared.

## 4. The branch that decides the answer, and every CAS gets it wrong

Source: [`lambertw-statistics.md`](lambertw-statistics) sections 2, 3 and 6. **This is the most
practically dangerous finding in the wing**, because the default branch in SymPy, mpmath, SciPy,
Mathematica and Maple is the principal one, and on the principal branch the bosonic inversion in
`physics/entropy.md:59` collapses to `beta E_1 = 0` identically. It does not fail loudly. It returns
zero.

The picture is one horizontal line cutting one curve twice. `W` inverts `F(u) = u e^u`, which is not
injective: it decreases on `u <= -1` (that is `W_-1`) and increases on `u >= -1` (that is `W_0`), and
the two arms meet at the global minimum `F(-1) = -1/e`.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 452" role="img" aria-labelledby="f4t f4d">
<title id="f4t">The two Lambert W branches, and the Gentile family between Fermi and Bose</title>
<desc id="f4d">Left panel plots F of u equals u times e to the u against u from minus four to plus 0.4. The curve falls to a minimum of minus one over e at u equals minus one, then rises through zero. A horizontal line at minus 0.3252 cuts it twice, at minus 1.581977 on the W minus one branch and at minus 0.581977 on the principal branch. The principal root gives beta E one exactly zero; the other gives the correct value 1.0. Right panel plots the maximum attainable beta E against the occupancy cutoff N on a log axis, rising from 0.2784645 at N equals two toward the Bose supremum of one.</desc>
<text class="hd" x="14" y="26">One horizontal line, two roots: the principal branch returns the trivial one</text>

<text class="sh" x="14" y="52">a. F(u) = u e^u, and the two pre-images of a physical argument</text>
<line class="g" x1="70" y1="130" x2="390" y2="130"/>
<line class="g" x1="70" y1="245" x2="390" y2="245"/>
<line class="ax" x1="70" y1="201.4" x2="390" y2="201.4"/>
<line class="ax" x1="70" y1="70" x2="70" y2="300"/>
<text class="mu sm e" x="64" y="134">0.33</text>
<text class="mu sm e" x="64" y="205">0</text>
<text class="mu sm e" x="64" y="249">-0.20</text>
<text class="mu sm e" x="64" y="304">-0.45</text>
<polyline class="ln s1k" points="70,217.5 106.4,224.6 142.7,234.2 179.1,246.4 215.5,260.7 233.6,268 245.9,272.7 251.8,274.7 270,279.9 288.2,282 306.4,279 318.6,272.7 324.5,267.9 342.7,244.1 360.9,201.4 379.1,131.1 390,70.7"/>
<line class="dsh s2k" x1="70" y1="272.7" x2="390" y2="272.7"/>
<text class="s2 sm lbl" x="76" y="268">v = -&#946;E&#183;e^(-&#946;E) = -0.32520</text>
<circle class="mk s1" cx="288.2" cy="282" r="5"/>
<text class="mu sm m" x="288.2" y="298">branch point (-1, -1/e)</text>
<g class="mk s2"><rect x="240.4" y="267.2" width="11" height="11"/><rect x="313.1" y="267.2" width="11" height="11"/></g>
<line class="thin ax" x1="245.9" y1="272.7" x2="215" y2="180"/>
<text class="crt sm m" x="180" y="162">W&#8331;&#8321; branch, u &#8804; -1</text>
<text class="crt sm m" x="180" y="176">u = -1.581977, &#946;E&#8321; = 1.000000</text>
<text class="crt sm m" x="180" y="146">the CORRECT root</text>
<line class="thin ax" x1="318.6" y1="272.7" x2="345" y2="180"/>
<text class="sm m" x="342" y="162">W&#8320; branch, u &#8805; -1</text>
<text class="sm m" x="342" y="176">u = -0.581977, &#946;E&#8321; = 0</text>
<text class="crt sm m" x="342" y="146">every CAS default</text>
<text class="mu sm m" x="70" y="318">-4</text>
<text class="mu sm m" x="142.7" y="318">-3</text>
<text class="mu sm m" x="215.5" y="318">-2</text>
<text class="mu sm m" x="288.2" y="318">-1</text>
<text class="mu sm m" x="360.9" y="318">0</text>
<text class="mu sm m" x="230" y="338">u (dimensionless). Row shown: &#946;E&#8321; = 1.00, &#946;E = 0.581977.</text>

<text class="sh" x="420" y="52">b. The N family is GENTILE statistics, not anyons</text>
<line class="g" x1="470" y1="80.95" x2="730" y2="80.95"/>
<line class="g" x1="470" y1="135.7" x2="730" y2="135.7"/>
<line class="g" x1="470" y1="190.5" x2="730" y2="190.5"/>
<line class="g" x1="470" y1="245.3" x2="730" y2="245.3"/>
<line class="ax" x1="470" y1="300" x2="730" y2="300"/>
<line class="ax" x1="470" y1="70" x2="470" y2="300"/>
<text class="mu sm e" x="464" y="85">1.0</text>
<text class="mu sm e" x="464" y="140">0.75</text>
<text class="mu sm e" x="464" y="195">0.5</text>
<text class="mu sm e" x="464" y="250">0.25</text>
<text class="mu sm e" x="464" y="304">0</text>
<line class="dsh ck" x1="470" y1="80.95" x2="730" y2="80.95"/>
<polyline class="ln s3k" points="470,239 486.9,207 508.2,172.6 527.8,147.4 614.4,94 730,82.1"/>
<g class="mk s3"><circle cx="470" cy="239" r="5"/><circle cx="486.9" cy="207" r="5"/><circle cx="508.2" cy="172.6" r="5"/><circle cx="527.8" cy="147.4" r="5"/><circle cx="614.4" cy="94" r="5"/><circle cx="730" cy="82.1" r="5"/></g>
<text class="lbl sm e" x="730" y="234">N = 2 (Fermi-Dirac): 0.2784645428 = W&#8320;(1/e)</text>
<text class="crt sm e" x="726" y="76">N &#8594; &#8734; (Bose): supremum 1, NOT attained</text>
<text class="mu sm m" x="470" y="318">2</text>
<text class="mu sm m" x="527.8" y="318">8</text>
<text class="mu sm m" x="614.4" y="318">64</text>
<text class="mu sm m" x="730" y="318">1024</text>
<text class="mu sm m" x="600" y="338">N, occupancy cutoff (at most N-1 quanta per level; log)</text>
<text class="mu sm m" x="600" y="354">y axis: maximum attainable &#946;E (dimensionless)</text>

<text class="crt sm" x="14" y="386">Bosonic: an unqualified W returns &#946;E&#8321; = 0 for EVERY physical &#946;E, because -&#946;E is its own principal pre-image.</text>
<text class="crt sm" x="14" y="404">At &#946;E&#8321; = 0.1 the W&#8320; route gives 1.8e-25; the W&#8331;&#8321; route gives 0.100000.</text>
<text class="sm" x="14" y="426">Fermionic: real roots always exist, saturated exactly at &#946;E = W&#8320;(1/e) = 0.2784645, but BOTH branches are</text>
<text class="sm" x="14" y="444">physical, so one energy measurement does not determine the level spacing.</text>
</svg>

</div>

| `x = beta E_1` | `y = beta E` | `X = x + y` | `beta E_1` via `W_0` | `beta E_1` via `W_-1` |
|---|---|---|---|---|
| 0.10 | 0.950833 | 1.050833 | 1.8 x 10<sup>-25</sup> | 0.100000 |
| 1.00 | 0.581977 | 1.581977 | 1.3 x 10<sup>-26</sup> | 1.000000 |
| 5.00 | 0.033918 | 5.033918 | 0.0 | 5.000000 |

Maximum attainable `beta E` by cutoff N (`lambertw-statistics.md` section 7): N = 2, 0.2784645428;
N = 3, 0.4247897654; N = 5, 0.5817057419; N = 8, 0.6964810581; N = 64, 0.9403336629; N = 1024,
0.9946790201; N infinite, supremum 1 and not attained. The family is an **occupancy cutoff**, which
is exactly **Gentile statistics** (G. Gentile jr., 1940) with the owner's `N-1` playing Gentile's
`n`. It is **not anyons** (those generalise braid statistics in 2D, a different axis), and not a
consistent quantum statistics field-theoretically: Greenberg's objection is that "at most n particles
in a quantum state" is not basis-invariant. The consistent generalisation is Green's parastatistics.

## 5. Wick rotation: the Laurent index and the Matsubara index are one basis

Source: [`wick-entropy.md`](wick-entropy) section 1, seeded on the owner's own physics.SE
[q/143075](https://physics.stackexchange.com/q/143075) and on `physics/wirohsh.md`. Under the map
below, the owner's Laurent basis and the thermal field theory's Matsubara basis are the same object,
with `m = n`, and his single-valuedness condition in the polar angle **is** the periodicity condition
in imaginary time. The essay's headline: he did not fail to compactify, he compactified the wrong
circle, and the wrong circle is the interesting one.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 500" role="img" aria-labelledby="f5t f5d">
<title id="f5t">The plane-to-cylinder map identifying the Laurent index with the Matsubara index</title>
<desc id="f5d">Top row shows a thermal cylinder in coordinates sigma and tau, with tau periodic with period h-bar beta c, mapped by z equals exp of two pi times sigma plus i tau over h-bar beta c onto an annulus carrying the Laurent basis z to the m. The indices coincide. Lower rows contrast the two inequivalent circles: quotienting by a translation gives constant circumference and global equilibrium Matsubara physics; using the polar angle gives circumference two pi r, a position-dependent period, and therefore the Unruh temperature. The bottom chart plots that temperature against radius on log-log axes.</desc>
<text class="hd" x="14" y="26">His m IS the Matsubara n: one coordinate change, not an analogy</text>

<rect x="40" y="60" width="200" height="110" rx="6" fill="none" stroke="#2a78d6" stroke-width="2"/>
<line class="thin s1k" x1="40" y1="88" x2="240" y2="88"/>
<line class="thin s1k" x1="40" y1="116" x2="240" y2="116"/>
<line class="thin s1k" x1="40" y1="144" x2="240" y2="144"/>
<text class="sm m" x="140" y="80">thermal cylinder, coordinates (&#963;, &#964;)</text>
<text class="sm m" x="140" y="108">&#964; ~ &#964; + &#295;&#946;c  (period fixed)</text>
<text class="sm m" x="140" y="136">&#969;_n = 2&#960;n/(&#295;&#946;), n integer</text>
<text class="sm m" x="140" y="164">Matsubara basis e^(i&#969;_n&#964;)</text>
<text class="mu sm m" x="140" y="186">thermal field theory</text>

<line class="ln ax" x1="256" y1="115" x2="384" y2="115"/>
<polygon fill="#c3c2b7" points="384,115 374,110 374,120"/>
<text class="sm m" x="320" y="100">z = exp[2&#960;(&#963; + i&#964;)/(&#295;&#946;c)]</text>
<text class="lbl sm m" x="320" y="140">m = n</text>
<text class="mu sm m" x="320" y="158">radial quantization</text>

<circle cx="510" cy="115" r="58" fill="none" stroke="#eb6834" stroke-width="2"/>
<circle cx="510" cy="115" r="20" fill="none" stroke="#eb6834" stroke-width="2"/>
<line class="thin s2k" x1="530" y1="115" x2="568" y2="115"/>
<line class="thin s2k" x1="496" y1="100" x2="469" y2="74"/>
<line class="thin s2k" x1="496" y1="130" x2="469" y2="156"/>
<text class="sm m" x="510" y="119">z^m</text>
<text class="sm m" x="620" y="80">Laurent basis in</text>
<text class="sm m" x="620" y="96">wirohsh.md:</text>
<text class="sm m" x="620" y="116">z^m = r^m e^(im&#966;)</text>
<text class="sm m" x="620" y="140">R_m&#177; = r&#177;^m are the</text>
<text class="sm m" x="620" y="156">two halves of ONE</text>
<text class="sm m" x="620" y="172">Matsubara frequency</text>

<line class="g" x1="40" y1="204" x2="730" y2="204"/>
<text class="sh" x="14" y="228">Two inequivalent circles, and the file leaves &#964; non-compact</text>

<rect class="zone" x="40" y="244" width="320" height="104" rx="6"/>
<text class="sh sm" x="56" y="266">1. Quotient by a translation</text>
<line class="thin s1k" x1="60" y1="284" x2="340" y2="284"/>
<line class="thin s1k" x1="60" y1="332" x2="340" y2="332"/>
<ellipse cx="110" cy="308" rx="16" ry="24" fill="none" stroke="#2a78d6" stroke-width="2"/>
<ellipse cx="200" cy="308" rx="16" ry="24" fill="none" stroke="#2a78d6" stroke-width="2"/>
<ellipse cx="290" cy="308" rx="16" ry="24" fill="none" stroke="#2a78d6" stroke-width="2"/>

<rect class="zone" x="400" y="244" width="330" height="104" rx="6"/>
<text class="sh sm" x="416" y="266">2. Use the polar ANGLE as the thermal circle</text>
<circle cx="452" cy="308" r="12" fill="none" stroke="#eb6834" stroke-width="2"/>
<circle cx="452" cy="308" r="22" fill="none" stroke="#eb6834" stroke-width="2"/>
<circle cx="452" cy="308" r="32" fill="none" stroke="#eb6834" stroke-width="2"/>
<text class="sm" x="494" y="292">circumference 2&#960;r: the period is</text>
<text class="sm" x="494" y="308">POSITION DEPENDENT, &#295;&#946;(r)c = 2&#960;r.</text>
<text class="crt sm" x="494" y="326">k_B T = &#295;c/(2&#960;r) = &#295;a/(2&#960;c), a = c&#178;/r:</text>
<text class="crt sm" x="494" y="342">the Unruh temperature, forced.</text>

<text class="sm" x="40" y="366">Reading 1: constant circumference at every &#963;, so a global &#946;, equilibrium, Matsubara. Reading 2 in SI units, below:</text>
<text class="sh" x="14" y="386">the local temperature the angle condition forces</text>
<line class="g" x1="100" y1="410" x2="700" y2="410"/>
<line class="g" x1="100" y1="444" x2="700" y2="444"/>
<line class="ax" x1="100" y1="478" x2="700" y2="478"/>
<line class="ax" x1="100" y1="400" x2="100" y2="478"/>
<polyline class="ln s2k" points="100,411.6 233.3,428.6 366.7,445.6 500,462.5 700,488"/>
<circle class="mk s2" cx="233.3" cy="428.6" r="5"/>
<text class="lbl sm" x="244" y="424">r = 1 &#181;m: T = 364 K, proper acceleration a = 9.0e22 m/s&#178;</text>
<text class="mu sm e" x="94" y="414">1e5 K</text>
<text class="mu sm e" x="94" y="448">1e3 K</text>
<text class="mu sm e" x="94" y="482">1e1 K</text>
<text class="mu sm m" x="100" y="496">1e-9 m</text>
<text class="mu sm m" x="300" y="496">1e-6 m</text>
<text class="mu sm m" x="500" y="496">1e-3 m</text>
<text class="mu sm m" x="700" y="496">1 m</text>
</svg>

</div>

The bottom line is arithmetic on the essay's own `beta(r) = 2 pi r / (hbar c)` with CODATA `hbar`,
`c` and `k_B`; the essay itself checks the relation symbolically in SymPy, not numerically. Values:
`T = 3.644 x 10^-4 K` at r = 1 m, 0.3644 K at 1 mm, 364.4 K at 1 µm, 3.644 x 10<sup>5</sup> K at 1 nm.

Two further results from the same essay, text rather than curves because they are identities. First,
the boson/fermion split is *identity at the two points the owner uses and coincidence if
extrapolated*: his `N = 2` truncation and the antiperiodic boundary condition agree exactly as
values, but twisting a complex boson's boundary condition gives `Z_theta = 1/(1 - Z_1 e^(i theta))`,
which shifts a pole and is never a polynomial, while a truncation is a degree-`N-1` polynomial;
SymPy finds no `theta` reproducing `N = 3`. Second, the entropy pun is a pun, and the honest content
is one equation:

$$ \frac{S_{\text{thermo}}}{k_B} \;=\; \beta E \;-\; \frac{S_E}{\hbar} $$

Both letters appear, they are not equal, and the entropy is the **gap** between the Euclidean action
and `beta E`. That is the Gibbons-Hawking dictionary.

## 6. Acoustics: impedance matching decouples reflection from refraction

Source: [`acoustics.md`](acoustics) sections 3 and 4. At normal incidence,
`r = (Z_2 - Z_1)/(Z_2 + Z_1)` with `Z = rho c`. Reflection sees only `Z`; refraction sees only `c`
(Snell). In acoustics those are **independent material knobs**, so an interface can be invisible to
reflection while still bending the ray. Optics at normal incidence cannot do it: for nonmagnetic
media `Z = Z_0/n` locks the impedance to the index, which in the plane below confines optics to a
single horizontal line.

<div style="overflow-x:auto">

<svg class="tsfig" viewBox="0 0 760 436" role="img" aria-labelledby="f6t f6d">
<title id="f6t">The two-knob acoustic plane against the one-knob optical line, and the reflectance curve</title>
<desc id="f6d">Left panel is a log-log plane of density ratio against sound-speed ratio. The reflectionless locus, where the impedances match, is the full anti-diagonal line. Optics is confined to the horizontal line where the density ratio is one, so its only reflectionless point is the trivial one where the speeds also match. A witness at speed ratio two and density ratio one half lies on the acoustic locus and refracts. Right panel plots normal-incidence energy reflectance against the impedance ratio on a log axis, marking air to water at 99.9 per cent and a ten kelvin warm-air layer at 7 times ten to the minus five.</desc>
<text class="hd" x="14" y="26">Two knobs against one: what optics cannot do</text>

<text class="sh" x="14" y="52">a. Reflectionless loci in the material plane (both axes log)</text>
<rect class="ok" x="70" y="70" width="290" height="230"/>
<line class="g" x1="70" y1="70" x2="360" y2="70"/>
<line class="g" x1="70" y1="127.5" x2="360" y2="127.5"/>
<line class="g" x1="70" y1="242.5" x2="360" y2="242.5"/>
<line class="ax" x1="70" y1="300" x2="360" y2="300"/>
<line class="g" x1="142.5" y1="70" x2="142.5" y2="300"/>
<line class="g" x1="287.5" y1="70" x2="287.5" y2="300"/>
<line class="ax" x1="70" y1="70" x2="70" y2="300"/>
<line class="ln s1k" x1="70" y1="70" x2="360" y2="300"/>
<line class="ln s2k" x1="70" y1="185" x2="360" y2="185"/>
<circle class="mk s3" cx="215" cy="185" r="6"/>
<g class="mk s1"><rect x="281.5" y="236.5" width="12" height="12"/></g>
<text class="s1 sm lbl" x="76" y="88">ACOUSTICS: r = 0 on this whole line (Z&#8321; = Z&#8322;)</text>
<text class="s2 sm lbl" x="76" y="178">OPTICS lives only here (Z = Z&#8320;/n)</text>
<line class="thin ax" x1="287.5" y1="242.5" x2="320" y2="270"/>
<text class="lbl sm e" x="356" y="284">witness: c&#8322; = 2c&#8321;, &#961;&#8322; = &#961;&#8321;/2</text>
<text class="sm e" x="356" y="298">no reflection, halves the wavelength</text>
<line class="thin ax" x1="215" y1="185" x2="190" y2="150"/>
<text class="crt sm m" x="186" y="140">their only common point:</text>
<text class="crt sm m" x="186" y="126">the trivial one, no refraction</text>
<text class="mu sm e" x="64" y="74">4</text>
<text class="mu sm e" x="64" y="132">2</text>
<text class="mu sm e" x="64" y="189">1</text>
<text class="mu sm e" x="64" y="247">0.5</text>
<text class="mu sm e" x="64" y="304">0.25</text>
<text class="mu sm m" x="70" y="318">0.25</text>
<text class="mu sm m" x="142.5" y="318">0.5</text>
<text class="mu sm m" x="215" y="318">1</text>
<text class="mu sm m" x="287.5" y="318">2</text>
<text class="mu sm m" x="360" y="318">4</text>
<text class="mu sm m" x="215" y="338">c&#8322;/c&#8321;, sound-speed ratio (dimensionless)</text>
<text class="mu sm m" x="215" y="354">y axis: &#961;&#8322;/&#961;&#8321;, density ratio (dimensionless)</text>

<text class="sh" x="420" y="52">b. Normal-incidence energy reflectance R = r&#178;</text>
<line class="g" x1="440" y1="70" x2="730" y2="70"/>
<line class="g" x1="440" y1="127.5" x2="730" y2="127.5"/>
<line class="g" x1="440" y1="185" x2="730" y2="185"/>
<line class="g" x1="440" y1="242.5" x2="730" y2="242.5"/>
<line class="ax" x1="440" y1="300" x2="730" y2="300"/>
<line class="ax" x1="440" y1="70" x2="440" y2="300"/>
<text class="mu sm e" x="434" y="74">1.0</text>
<text class="mu sm e" x="434" y="132">0.75</text>
<text class="mu sm e" x="434" y="189">0.5</text>
<text class="mu sm e" x="434" y="247">0.25</text>
<text class="mu sm e" x="434" y="304">0</text>
<polyline class="ln s3k" points="440,70.1 476.3,70.9 512.5,79 548.8,146 566.1,233.3 574.1,274.4 585,300 595.9,274.4 604,233.3 621.3,146 657.5,79 693.8,70.9 730,70.1"/>
<g class="mk s3"><circle cx="714.1" cy="70.3" r="5.5"/><circle cx="584.7" cy="300" r="5.5"/></g>
<line class="thin ax" x1="714.1" y1="70.3" x2="690" y2="104"/>
<text class="lbl sm e" x="700" y="118">air to water: Z 413 vs 1.5e6 rayl,</text>
<text class="sm e" x="700" y="132">R = 99.9%, so 1e-3 crosses</text>
<line class="thin ax" x1="584.7" y1="300" x2="560" y2="266"/>
<text class="lbl sm e" x="558" y="256">+10 K warm-air layer:</text>
<text class="sm e" x="558" y="242">c changes 1.7%, R = 7e-5</text>
<text class="mu sm m" x="440" y="318">1e-4</text>
<text class="mu sm m" x="512.5" y="318">1e-2</text>
<text class="mu sm m" x="585" y="318">1</text>
<text class="mu sm m" x="657.5" y="318">1e2</text>
<text class="mu sm m" x="730" y="318">1e4</text>
<text class="mu sm m" x="585" y="338">Z&#8322;/Z&#8321;, impedance ratio (log scale, base 10)</text>
<text class="mu sm m" x="585" y="354">y axis: R, fraction of incident energy reflected (dimensionless)</text>

<text class="crt sm" x="14" y="386">And the assumption nobody states: physics/acoustics.md defines c&#178;/&#947; := nRT/m, the ISOTHERMAL gas law,</text>
<text class="crt sm" x="14" y="404">whose NAMING presupposes the adiabatic c&#178; = &#947;p/&#961;. Load-bearing, and never stated in the file.</text>
<text class="sm" x="14" y="426">Newton 290.1 m/s against Laplace 343.2 m/s for air at 20 &#176;C, a ratio of &#8730;&#947; = 1.18322.</text>
</svg>

</div>

Sound ducts over cold lakes at night because a warm-air layer refracts strongly (1.7 % in `c`) while
reflecting 7 x 10<sup>-5</sup> of the energy; light through the same layer refracts about a thousand
times more weakly. Air to water is the opposite regime, `R` about 99.9 %, which is why ultrasound gel
exists. All of section 3 and section 4 of the essay is Lean-attested (six theorems, zero `sorry`),
including the matched-but-refracting witness.

## 7. What these six essays located in the owner's own text

Every row is **surfaced, not resolved**. The AI emits findings; it never edits the theory. Column
"filed" says whether the item also has a line in `REVIEW_ME.md` today, or whether it exists only in
the essay's own "Surfaced for the owner" section.

| # | finding | in | filed |
|---|---|---|---|
| 1 | **`physics/entropy.md:59` needs a branch qualifier.** Bosonic: correct only on `W_-1`; read with the principal branch it returns `beta E_1 = 0` identically. Fermionic: real always, but genuinely two-valued, existence saturated at `y_max = W_0(1/e) = 0.27846454`. No sign error: the `-/+` pairing audits clean. | `lambertw-statistics.md` section 5 | **yes**, `REVIEW_ME.md` dreamed-batch findings (`id:8e64`, batch pointer `TODO.md id:2460`); relates `id:37cc`, `id:5d31` |
| 2 | **`physics/acoustics.md`: the adiabatic assumption is never stated and the wave equation is never derived.** Plus a dangling `d_t omega` line, a "conservation of perpendicular momentum" label naming a mass-conservation consequence, and the `Accoustics` permalink spelling (URL-breaking to change). | `acoustics.md` section 6 | **yes**, same `id:8e64` section |
| 3 | **Five-level laser cooler: recommended NO-GO at theorem strength.** As a fluorescence cooler it works but is dominated by plain Yb-type anti-Stokes. One salvage flagged: radiation-balanced operation with octave-split stepwise pumping. | `five-level-laser.md` section 8 | **yes**, `REVIEW_ME.md` "Recommendations awaiting ratification (NOT decided)" |
| 4 | **The Wien-4 power optimum is a candidate result worth a decision.** Originality verdict is CALIBRATED as "could not find it stated", explicitly NOT "original": arXiv:2504.05013 states the content numerically per material; absent is the dimensionless closed form and the Wien identification. | `photon-energy-scaling.md` section 5 | **yes**, same subsection |
| 5 | **`docs/drafts/q669175-answer-draft.md` section 2: the word "forbidden" does not close.** A diode beam carries 1.3 x 10<sup>-7</sup> k<sub>B</sub> per photon, small but nonzero, so what is shown is a suppression factor. The missing premise is energy conservation: at most about one exhaust photon leaves per absorbed photon. Also, section 2 conflates coherence with low entropy; brightness kills the entropy, not coherence. | `lasercool.md` section 9 | **no**. The draft has its own `REVIEW_ME.md` section (q/669175, Q16, owner posts), but this critique is not in it. |
| 6 | **`physics/wirohsh.md` leaves imaginary time non-compact, and which circle it means is an owner decision.** Cylinder (global beta, Matsubara, equilibrium QFT) or plane (Rindler, `beta(r) = 2 pi r/(hbar c)`, Unruh). The two give different physics, and only the second explains why the `2 pi` was forced. A placement proposal for a "Transition: imaginary time" subsection in `physics/toesnail.md` rides along. | `wick-entropy.md` sections 1, 4 and 8 | **no**, essay only |

Two scope facts that bind every row above. First, `ROADMAP id:e552` (`[HARD -- hands]`) reserves the
*authoring* of `physics/lasercool.md`'s empty sections to the owner, and each essay marks which of its
own leads fall inside it. Second, routing a dreamed finding into a ledger is itself an owner decision:
a delegated agent's verdict is a recommendation, never self-settling, which is why rows 5 and 6 are
listed as unfiled rather than quietly filed by this page.

---

*Figure sheet, 2026-09-07. Values from the six named essays of 2026-09-01 only. Charts are
hand-authored inline SVG, no libraries. Where a chart rearranges an essay's formula rather than
reprinting a number it printed (panel 3b's `u/(1-u)`, panel 5's SI temperatures, panel 6b's
reflectance curve, panel 1's dashed folklore bracket), the caption says so at the point of use.*
