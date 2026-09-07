---
title: "Two posters about cold light"
permalink: /dreamed/poster-cold-light
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This page *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself.

*A German edition of both posters is at [`poster-cold-light-de`](poster-cold-light-de).*

These are two posters for a twelve year old. Each one has a single idea and a picture, and you
should be able to get it from across the room. The first says how you can make something colder by
shining a light on it, which sounds like nonsense and is not. The second says where the mess goes
when you do, and shows the one number this repo actually worked out: the safety margin is far
tighter than the story people tell. The grown up versions, with the arithmetic and the caveats,
are [`lasercool`](lasercool), [`five-level-laser`](five-level-laser) and the figure sheet
[`fig-thermo-laser`](fig-thermo-laser).

<style>
.eli{display:block;width:100%;height:auto;max-width:700px;margin:0 auto;background:#fbfaf7;font-family:system-ui,-apple-system,"Segoe UI",Helvetica,Arial,sans-serif}
.eli text{fill:#26241d}
.eli .h1{font-size:48px;font-weight:800;fill:#14130f}
.eli .h2{font-size:33px;font-weight:700;fill:#14130f}
.eli .sub{font-size:27px;font-weight:600;fill:#3d3a31}
.eli .bd{font-size:26px}
.eli .bg{font-size:27px;font-weight:700;fill:#14130f}
.eli .lb{font-size:24px;font-weight:700}
.eli .sm{font-size:22px;fill:#6b6a63}
.eli .m{text-anchor:middle}
.eli .hot{fill:#d8542a}
.eli .cool{fill:#2a6fd6}
.eli .grey{fill:#8b877a}
.eli .green{fill:#2c6b4c}
.eli .panel{fill:#f2f0e8;stroke:#dcd8c9;stroke-width:2}
.eli .honest{fill:#eaf1ec;stroke:#4a8f6b;stroke-width:2}
.eli .rule{stroke:#c9c5b6;stroke-width:2}
.eli .kb{stroke:#2a6fd6;stroke-width:5;fill:none;stroke-linecap:round}
.eli .kr{stroke:#d8542a;stroke-width:5;fill:none;stroke-linecap:round}
.eli .ink{stroke:#26241d;stroke-width:4;fill:none;stroke-linecap:round}
</style>

## Poster 1

<div style="overflow-x:auto">

<svg class="eli" viewBox="0 0 700 1880" role="img" aria-labelledby="p1t p1d">
<title id="p1t">Poster: how to freeze something with a light beam</title>
<desc id="p1d">A poster in four parts. Part one: temperature is jiggling, so cooling something means slowing it down, drawn as a hot atom with big jiggle marks beside a cold atom with tiny ones. Part two: the trick is to tune the light so that only an atom flying towards the beam sees the right colour to absorb it, so only the incoming ones get hit and every hit is a shove backwards; an atom flying away sees the wrong colour and the beam sails past. Part three: this is the ambulance siren, the Doppler effect, drawn as squashed sound waves in front of the ambulance and stretched ones behind. Part four, the honest bit: the light is not cold, the atoms hand their motion over to the light, which leaves carrying it.</desc>

<rect x="0" y="0" width="700" height="1880" fill="#fbfaf7"/>

<text class="sm" x="44" y="52">POSTER 1 OF 2   .   LASER COOLING</text>
<text class="h1" x="44" y="124">How to freeze something</text>
<text class="h1" x="44" y="178">with a light beam</text>
<text class="sub" x="44" y="222">Yes, really. Light can slow things down.</text>
<line class="rule" x1="44" y1="250" x2="656" y2="250"/>

<text class="h2" x="44" y="304">1. Cold means: not moving much</text>
<text class="bd" x="44" y="348">Temperature is jiggling. Hot things jiggle</text>
<text class="bd" x="44" y="380">hard, cold things barely move at all.</text>

<rect class="panel" x="44" y="404" width="296" height="160" rx="14"/>
<text class="lb m hot" x="192" y="442">HOT</text>
<circle class="cool" cx="192" cy="490" r="22"/>
<line class="kr" x1="162" y1="490" x2="126" y2="490"/>
<line class="kr" x1="166" y1="474" x2="134" y2="462"/>
<line class="kr" x1="166" y1="506" x2="134" y2="518"/>
<line class="kr" x1="222" y1="490" x2="258" y2="490"/>
<line class="kr" x1="218" y1="474" x2="250" y2="462"/>
<line class="kr" x1="218" y1="506" x2="250" y2="518"/>
<text class="sm m" x="192" y="544">jiggling hard</text>

<rect class="panel" x="360" y="404" width="296" height="160" rx="14"/>
<text class="lb m cool" x="508" y="442">COLD</text>
<circle class="cool" cx="508" cy="490" r="22"/>
<line class="kb" x1="480" y1="490" x2="466" y2="490"/>
<line class="kb" x1="536" y1="490" x2="550" y2="490"/>
<text class="sm m" x="508" y="544">barely moving</text>

<text class="bg" x="44" y="612">So cooling something means slowing it down.</text>

<text class="h2" x="44" y="674">2. Only hit the ones coming at you</text>
<text class="bd" x="44" y="718">Tune the light so an atom flying TOWARDS the</text>
<text class="bd" x="44" y="750">beam sees just the right colour to swallow.</text>
<text class="bd" x="44" y="782">An atom flying away sees the wrong colour.</text>

<rect class="panel" x="44" y="806" width="612" height="190" rx="14"/>
<text class="sm m" x="170" y="844">atom flying in</text>
<circle class="cool" cx="170" cy="896" r="26"/>
<line class="kb" x1="200" y1="896" x2="268" y2="896"/>
<path class="cool" d="M 268,884 L 296,896 L 268,908 Z"/>
<text class="lb m hot" x="306" y="852">HIT</text>
<rect x="336" y="872" width="300" height="48" rx="6" fill="#f9e2d6" stroke="#d8542a" stroke-width="2"/>
<path class="hot" d="M 352,896 L 378,882 L 378,910 Z"/>
<path class="hot" d="M 422,896 L 448,882 L 448,910 Z"/>
<path class="hot" d="M 492,896 L 518,882 L 518,910 Z"/>
<path class="hot" d="M 562,896 L 588,882 L 588,910 Z"/>
<text class="sm m" text-anchor="middle" x="486" y="946">the laser beam, aimed this way</text>
<line class="kr" x1="206" y1="960" x2="126" y2="960"/>
<path class="hot" d="M 126,948 L 98,960 L 126,972 Z"/>
<text class="sm" x="220" y="968">one tiny shove backwards</text>

<rect class="panel" x="44" y="1014" width="612" height="160" rx="14"/>
<text class="sm m" x="200" y="1050">atom flying away</text>
<circle class="cool" cx="200" cy="1102" r="26"/>
<line class="kb" x1="168" y1="1102" x2="100" y2="1102"/>
<path class="cool" d="M 100,1090 L 72,1102 L 100,1114 Z"/>
<text class="lb m grey" x="284" y="1108">NO HIT</text>
<rect x="336" y="1078" width="300" height="48" rx="6" fill="#efece4" stroke="#b3afa2" stroke-width="2" stroke-dasharray="8 5"/>
<path class="grey" d="M 352,1102 L 378,1088 L 378,1116 Z"/>
<path class="grey" d="M 422,1102 L 448,1088 L 448,1116 Z"/>
<path class="grey" d="M 492,1102 L 518,1088 L 518,1116 Z"/>
<path class="grey" d="M 562,1102 L 588,1088 L 588,1116 Z"/>
<text class="sm m" text-anchor="middle" x="486" y="1152">wrong colour, so it sails past</text>

<text class="bg" x="44" y="1224">Thousands of shoves later: nearly stopped.</text>

<text class="h2" x="44" y="1286">3. You already know this trick</text>
<text class="bd" x="44" y="1330">A siren sounds higher as the ambulance</text>
<text class="bd" x="44" y="1362">races at you, and lower once it has passed.</text>
<text class="bd" x="44" y="1394">Flying at a light does the same to its</text>
<text class="bd" x="44" y="1426">colour. That is the Doppler effect.</text>

<rect class="panel" x="44" y="1450" width="612" height="152" rx="14"/>
<line class="ink" x1="382" y1="1472" x2="302" y2="1472"/>
<path fill="#26241d" d="M 302,1464 L 280,1472 L 302,1480 Z"/>
<text class="sm" x="392" y="1478">driving this way</text>
<rect x="298" y="1500" width="124" height="48" rx="8" fill="#f2f0e8" stroke="#26241d" stroke-width="3"/>
<rect x="344" y="1488" width="26" height="12" rx="3" fill="#d8542a"/>
<circle fill="#26241d" cx="326" cy="1554" r="11"/>
<circle fill="#26241d" cx="396" cy="1554" r="11"/>
<path class="kr" d="M 272,1493 A 34,34 0 0 0 272,1557"/>
<path class="kr" d="M 254,1493 A 34,34 0 0 0 254,1557"/>
<path class="kr" d="M 236,1493 A 34,34 0 0 0 236,1557"/>
<path class="kb" d="M 448,1493 A 34,34 0 0 1 448,1557"/>
<path class="kb" d="M 478,1493 A 34,34 0 0 1 478,1557"/>
<path class="kb" d="M 508,1493 A 34,34 0 0 1 508,1557"/>
<text class="sm m" x="222" y="1590">squashed, higher</text>
<text class="sm m" x="478" y="1590">stretched, lower</text>

<rect class="honest" x="44" y="1630" width="612" height="160" rx="14"/>
<text class="lb green" x="72" y="1674">The honest bit</text>
<text class="bd" x="72" y="1714">The light is not cold. The atoms hand</text>
<text class="bd" x="72" y="1746">their motion over to the light, which</text>
<text class="bd" x="72" y="1778">leaves carrying it. Nothing is free.</text>

<text class="sm" x="44" y="1826">What we skipped: real traps need beams from all sides,</text>
<text class="sm" x="44" y="1852">the tuning is fussy, and there is a coldest temperature</text>
<text class="sm" x="44" y="1878">this trick cannot get past.</text>
</svg>

</div>

## Poster 2

<div style="overflow-x:auto">

<svg class="eli" viewBox="0 0 700 2070" role="img" aria-labelledby="p2t p2d">
<title id="p2t">Poster: where does the mess go?</title>
<desc id="p2d">A poster in four parts. Part one: tidying never destroys mess, it moves it, and there is never less of it than you removed, drawn as a neat grid of squares beside a scattered cloud of dots. Part two: cooling an atom is tidying it up, so the mess leaves riding on the light that flies away. Part three, the finding: people assume a gigantic safety margin, but worked out properly for one real atom the margin is about a thousand times, not ten million, drawn as two bars on a ladder where each block means ten times bigger, seven blocks against three, the shorter bar labelled what it actually is. Part four: the reason is that atoms are bad at carrying mess away, so the atom is the bottleneck. The honest bit: this is a limit on what is allowed, not on what is easy.</desc>

<rect x="0" y="0" width="700" height="2070" fill="#fbfaf7"/>

<text class="sm" x="44" y="52">POSTER 2 OF 2   .   ENTROPY</text>
<text class="h1" x="44" y="124">Where does the mess go?</text>
<text class="sub" x="44" y="176">Tidying never destroys mess. It moves it.</text>
<line class="rule" x1="44" y1="204" x2="656" y2="204"/>

<text class="h2" x="44" y="258">1. The deepest rule in physics</text>
<text class="bd" x="44" y="302">Tidy your room and the mess does not</text>
<text class="bd" x="44" y="334">vanish. It goes somewhere else, and there</text>
<text class="bd" x="44" y="366">is never less of it than you removed.</text>

<rect class="panel" x="44" y="392" width="612" height="190" rx="14"/>
<text class="sm m" x="155" y="428">you tidy this</text>
<rect class="cool" x="110" y="448" width="26" height="26" rx="3"/>
<rect class="cool" x="142" y="448" width="26" height="26" rx="3"/>
<rect class="cool" x="174" y="448" width="26" height="26" rx="3"/>
<rect class="cool" x="110" y="480" width="26" height="26" rx="3"/>
<rect class="cool" x="142" y="480" width="26" height="26" rx="3"/>
<rect class="cool" x="174" y="480" width="26" height="26" rx="3"/>
<text class="sm m" x="155" y="540">neat, tidy, boring</text>
<text class="sm m" x="284" y="466">but</text>
<line class="ink" x1="240" y1="494" x2="300" y2="494"/>
<path fill="#26241d" d="M 300,482 L 328,494 L 300,506 Z"/>
<circle class="hot" cx="372" cy="452" r="8"/>
<circle class="hot" cx="408" cy="432" r="8"/>
<circle class="hot" cx="444" cy="466" r="8"/>
<circle class="hot" cx="392" cy="498" r="8"/>
<circle class="hot" cx="430" cy="522" r="8"/>
<circle class="hot" cx="468" cy="438" r="8"/>
<circle class="hot" cx="500" cy="470" r="8"/>
<circle class="hot" cx="478" cy="510" r="8"/>
<circle class="hot" cx="520" cy="430" r="8"/>
<circle class="hot" cx="548" cy="462" r="8"/>
<circle class="hot" cx="590" cy="444" r="8"/>
<circle class="hot" cx="566" cy="504" r="8"/>
<circle class="hot" cx="614" cy="478" r="8"/>
<circle class="hot" cx="604" cy="522" r="8"/>
<text class="sm m" text-anchor="middle" x="500" y="566">more of it, spread wider</text>

<text class="bg" x="44" y="628">Nobody has ever broken this rule.</text>

<text class="h2" x="44" y="686">2. Cooling an atom is tidying</text>
<text class="bd" x="44" y="730">So the mess has to go somewhere. It</text>
<text class="bd" x="44" y="762">leaves riding on the light that flies off.</text>

<rect class="panel" x="44" y="788" width="612" height="190" rx="14"/>
<circle class="cool" cx="150" cy="862" r="36"/>
<circle fill="#fbfaf7" cx="138" cy="850" r="5"/>
<circle fill="#fbfaf7" cx="158" cy="856" r="5"/>
<circle fill="#fbfaf7" cx="146" cy="874" r="5"/>
<circle fill="#fbfaf7" cx="164" cy="872" r="5"/>
<text class="sm m" x="150" y="930">atom being tidied</text>
<text class="sm m" x="248" y="834">hands it over</text>
<line class="ink" x1="200" y1="862" x2="268" y2="862"/>
<path fill="#26241d" d="M 268,850 L 296,862 L 268,874 Z"/>
<path class="kr" d="M 322,862 q 20,-24 40,0 t 40,0 t 40,0 t 40,0 t 40,0 t 40,0"/>
<path class="hot" d="M 562,850 L 590,862 L 562,874 Z"/>
<circle class="hot" cx="342" cy="828" r="6"/>
<circle class="hot" cx="422" cy="828" r="6"/>
<circle class="hot" cx="502" cy="828" r="6"/>
<text class="sm m" text-anchor="middle" x="456" y="930">light leaves, carrying the mess</text>

<text class="h2" x="44" y="1034">3. The surprise</text>
<text class="bd" x="44" y="1078">People assume there is a gigantic safety</text>
<text class="bd" x="44" y="1110">margin here. Worked out properly for one</text>
<text class="bd" x="44" y="1142">real atom, the margin came out about a</text>
<text class="bd" x="44" y="1174">thousand times, not ten million.</text>

<rect class="panel" x="44" y="1200" width="612" height="240" rx="14"/>
<text class="sm m" text-anchor="middle" x="350" y="1236">each block along a bar means ten times bigger</text>
<text class="lb" x="90" y="1272">What people assume</text>
<rect x="90" y="1284" width="420" height="40" rx="4" fill="#cfd9ea" stroke="#2a6fd6" stroke-width="2"/>
<line x1="150" y1="1284" x2="150" y2="1324" stroke="#2a6fd6" stroke-width="2"/>
<line x1="210" y1="1284" x2="210" y2="1324" stroke="#2a6fd6" stroke-width="2"/>
<line x1="270" y1="1284" x2="270" y2="1324" stroke="#2a6fd6" stroke-width="2"/>
<line x1="330" y1="1284" x2="330" y2="1324" stroke="#2a6fd6" stroke-width="2"/>
<line x1="390" y1="1284" x2="390" y2="1324" stroke="#2a6fd6" stroke-width="2"/>
<line x1="450" y1="1284" x2="450" y2="1324" stroke="#2a6fd6" stroke-width="2"/>
<text class="lb" x="522" y="1312">10,000,000</text>
<text class="lb" x="90" y="1354">What it actually is</text>
<rect x="90" y="1366" width="180" height="40" rx="4" fill="#f6d3c4" stroke="#d8542a" stroke-width="3"/>
<line x1="150" y1="1366" x2="150" y2="1406" stroke="#d8542a" stroke-width="2"/>
<line x1="210" y1="1366" x2="210" y2="1406" stroke="#d8542a" stroke-width="2"/>
<text class="lb" x="282" y="1394">1,000</text>
<text class="sm m" x="350" y="1428">seven blocks against three</text>

<text class="bd" x="44" y="1484">Still fine. Still legal. Just far tighter</text>
<text class="bd" x="44" y="1516">than the story people usually tell.</text>

<text class="h2" x="44" y="1574">4. Atoms are bad at it</text>
<text class="bd" x="44" y="1618">Light is brilliant at carrying mess away.</text>
<text class="bd" x="44" y="1650">An atom can only hand over a scrap at a</text>
<text class="bd" x="44" y="1682">time, so the atom is the narrow bit of</text>
<text class="bd" x="44" y="1714">the funnel. Its number sets the margin.</text>

<rect class="honest" x="44" y="1746" width="612" height="172" rx="14"/>
<text class="lb green" x="72" y="1790">The honest bit</text>
<text class="bd" x="72" y="1830">This is a limit on what is ALLOWED,</text>
<text class="bd" x="72" y="1862">not on what is EASY. Almost every real</text>
<text class="bd" x="72" y="1894">difficulty here is practical, not deep.</text>

<text class="sm" x="44" y="1954">What we skipped: those numbers are for one particular</text>
<text class="sm" x="44" y="1980">atom (rubidium) with one particular beam, the mess is</text>
<text class="sm" x="44" y="2006">counted per particle of light, and the rule itself is a</text>
<text class="sm" x="44" y="2032">statement about the whole universe, not about one room.</text>
</svg>

</div>

Both posters are dreamed, unreviewed, and simplified on purpose. The number in poster 2 comes from
[`lasercool`](lasercool) section 3, which is itself an AI recommendation and not a ratified result.
