---
title: "Zwei Plakate über Computer"
permalink: /dreamed/poster-computers-de
---

> **GETRÄUMT. UNGEPRÜFT. NICHT VOM EIGENTÜMER GESCHRIEBEN.** Siehe [`docs/dreamed/README.md`](./README.md).
> Diese Seite *schlägt vor*; entschieden wird anderswo. Nichts hier ist toesnail-Theorie, und nichts darf
> ohne den Eigentümer selbst nach `physics/`, `essays/` oder `crypto/` wandern.

Zwei Plakate für eine neugierige Zwölfjährige. Jedes hat ein Bild, das du quer durch den Raum lesen
kannst, einen grossen Gedanken und eine ehrliche Notiz darüber, was weggelassen wurde. Vereinfachen ist
hier erlaubt; falsch sein nicht. Die erwachsenen Fassungen, mit den Beweisen und den Quellen, sind
[`logic-bloch-gates`](logic-bloch-gates) für das erste Plakat und [`fig-fhe`](fig-fhe) für das zweite.

**In English:** [Two posters about computers](poster-computers).

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

## Plakat 1

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 1300" role="img" aria-labelledby="p1t p1d">
<title id="p1t">Vier Wege hinein, zwei Wege hinaus, also ging etwas verloren</title>
<desc id="p1d">Ein Plakat. Vier Kästchen oben zeigen die vier Stellungen von zwei Schaltern: aus aus, aus an, an aus, an an. Pfeile laufen hinunter zu zwei Antwortkästchen. Drei Pfeile drängen sich in die Antwort NEIN, nur ein einziger erreicht die Antwort JA. Weil drei verschiedene Starts dieselbe Antwort geben, kann NEIN nicht verraten, woher es kam, also ging Information verloren. Ein Computer, der rückwärts laufen muss, darf nichts vernichten und braucht darum einen dritten Draht für den Rest. Information zu vernichten kostet ausserdem Energie und macht Wärme.</desc>
<defs>
<marker id="p1arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse">
<path d="M0,0 L10,5 L0,10 z" fill="#26251f"/>
</marker>
</defs>

<text class="hl" x="30" y="72">Vier Wege hinein.</text>
<text class="hl" x="30" y="128">Zwei Wege hinaus.</text>
<text class="hl" x="30" y="184">Etwas ging verloren.</text>
<text class="sub" x="30" y="232">Warum ein Computer, der rückwärts läuft,</text>
<text class="sub" x="30" y="266">einen Draht mehr braucht.</text>

<text class="sm" x="30" y="316">die zwei Schalter</text>
<rect class="box" x="30" y="328" width="148" height="84" rx="10"/>
<rect class="box" x="194" y="328" width="148" height="84" rx="10"/>
<rect class="box" x="358" y="328" width="148" height="84" rx="10"/>
<rect class="box" x="522" y="328" width="148" height="84" rx="10"/>
<text class="big m" text-anchor="middle" x="104" y="382">aus aus</text>
<text class="big m" text-anchor="middle" x="268" y="382">aus an</text>
<text class="big m" text-anchor="middle" x="432" y="382">an aus</text>
<text class="big m" text-anchor="middle" x="596" y="382">an an</text>

<path class="arw" d="M104,416 L228,500" marker-end="url(#p1arrow)"/>
<path class="arw" d="M268,416 L243,500" marker-end="url(#p1arrow)"/>
<path class="arw" d="M432,416 L258,500" marker-end="url(#p1arrow)"/>
<path class="arw" d="M596,416 L580,500" marker-end="url(#p1arrow)"/>

<rect class="out" x="30" y="508" width="430" height="80" rx="10"/>
<rect class="out" x="490" y="508" width="180" height="80" rx="10"/>
<text class="huge m" text-anchor="middle" x="245" y="567">NEIN</text>
<text class="huge m" text-anchor="middle" x="580" y="567">JA</text>
<text class="sm" x="30" y="620">drei Starts drängen sich in eine Antwort</text>
<text class="sm e" text-anchor="end" x="670" y="620">ein Start, eine Antwort</text>

<text class="hd" x="30" y="674">Bei JA kannst du rückwärts rechnen</text>
<text class="bd" x="30" y="710">Wenn die Antwort ja ist, sind beide Schalter an,</text>
<text class="bd" x="30" y="742">und du weisst genau, womit du angefangen hast.</text>

<text class="hd" x="30" y="796">Bei NEIN ist die Vergangenheit weg</text>
<text class="bd" x="30" y="832">War der linke Schalter aus? Der rechte? Beide?</text>
<text class="bd" x="30" y="864">NEIN verrät es dir nicht. Drei verschiedene</text>
<text class="bd" x="30" y="896">Starts, eine einzige Antwort.</text>

<text class="hd" x="30" y="950">Rückwärts rechnen braucht drei Drähte</text>
<text class="bd" x="30" y="986">Zwei Drähte hinein und zwei hinaus können die</text>
<text class="bd" x="30" y="1018">Antwort und den Rest nicht gleichzeitig tragen.</text>
<text class="bd" x="30" y="1050">Drei Drähte können es, der dritte hält den Rest.</text>
<text class="bd" x="30" y="1082">Zähl die Pfeile: das ist keine Geschmacksfrage,</text>
<text class="bd" x="30" y="1114">sondern eine Frage des Zählens.</text>

<text class="hd" x="30" y="1168">Vergessen macht Wärme</text>
<text class="bd" x="30" y="1204">Jedes Bit, das du wegwirfst, wärmt den Raum um</text>
<text class="bd" x="30" y="1236">mindestens ein winziges bisschen. Niemand kommt</text>
<text class="bd" x="30" y="1268">ums Bezahlen herum.</text>
</svg>

</div>

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 152" role="img" aria-labelledby="p1st p1sd">
<title id="p1st">Was Plakat eins weggelassen hat</title>
<desc id="p1sd">Das Drei-Draht-Gatter heisst Toffoli-Gatter. Es lässt beide Schalter unangetastet und legt die Antwort auf einen dritten Draht. Die Wärme aus einem einzigen vergessenen Bit ist viel kleiner als das, was ein echter Chip heute verheizt: echte Physik, aber noch nicht die Grenze für heutige Computer.</desc>
<line class="rule" x1="30" y1="14" x2="670" y2="14"/>
<text class="sm" x="30" y="48">Was wir weggelassen haben: das Drei-Draht-Gatter heisst</text>
<text class="sm" x="30" y="78">Toffoli. Es lässt beide Schalter in Ruhe und legt die</text>
<text class="sm" x="30" y="108">Antwort auf den dritten Draht. Und die Wärme aus einem</text>
<text class="sm" x="30" y="138">vergessenen Bit ist winzig gegen das, was ein Chip verheizt.</text>
</svg>

</div>

## Plakat 2

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 1340" role="img" aria-labelledby="p2t p2d">
<title id="p2t">Mathe in einer verschlossenen Kiste</title>
<desc id="p2d">Ein Plakat. Eine verschlossene Kiste mit Vorhängeschloss enthält eine geheime Zahl. Zwei Handschuhe greifen von aussen hinein, damit ein Fremder mit der Zahl arbeiten kann, ohne die Kiste zu öffnen. Der Fremde rechnet, gibt die Kiste zurück, und die Besitzerin schliesst auf und findet die richtige Antwort, während der Fremde weder die Zahl noch die Antwort gesehen hat. Darunter vergleichen drei Balken die Geschwindigkeit: ein normaler Computer braucht einen Wimpernschlag, dieselbe Aufgabe in der Kiste braucht Minuten, und die dritte Spur ist leer gezeichnet, weil noch niemand die grössten KI-Modelle ganz in der Kiste laufen liess.</desc>

<text class="hl" x="30" y="72">Mathe in einer</text>
<text class="hl" x="30" y="128">verschlossenen Kiste.</text>
<text class="sub" x="30" y="180">Ein Fremder rechnet für dich, ohne je deine</text>
<text class="sub" x="30" y="214">Zahl zu sehen, und ohne die Antwort zu sehen.</text>

<rect class="box" x="170" y="262" width="360" height="250" rx="16"/>
<rect class="out" x="200" y="292" width="300" height="126"/>
<text class="huge m" text-anchor="middle" x="350" y="378">7</text>
<text class="sm m" text-anchor="middle" x="350" y="404">deine geheime Zahl</text>
<path class="arw" d="M478,286 a14,14 0 0 1 28,0 l0,12" fill="none"/>
<rect x="472" y="298" width="40" height="30" rx="5" fill="#f2f1ec" stroke="#26251f" stroke-width="3"/>
<text class="sm" x="524" y="322">verschlossen</text>
<circle class="out" cx="270" cy="482" r="28"/>
<circle class="out" cx="430" cy="482" r="28"/>
<path d="M40,572 Q150,566 268,502" fill="none" stroke="#6b6a66" stroke-width="24" stroke-linecap="round"/>
<path d="M660,572 Q550,566 432,502" fill="none" stroke="#6b6a66" stroke-width="24" stroke-linecap="round"/>
<text class="sm" x="30" y="612">der Fremde greift hinein, die Kiste geht nie auf</text>

<text class="hd" x="30" y="666">Hingeben, zurückbekommen, aufschliessen</text>
<text class="bd" x="30" y="702">Schliess deine Zahl in die Kiste. Gib die Kiste einem</text>
<text class="bd" x="30" y="734">Fremden. Er rechnet mit dem, was drin ist, ohne sie</text>
<text class="bd" x="30" y="766">zu öffnen, und gibt sie dir zurück. Du schliesst auf.</text>
<text class="bd" x="30" y="798">Die Antwort stimmt.</text>

<text class="hd" x="30" y="852">Klingt unmöglich. Gibt es wirklich.</text>
<text class="bd" x="30" y="888">Er hat deine Zahl nie gesehen und die Antwort auch</text>
<text class="bd" x="30" y="920">nicht. Er hat die Kiste nur durchgeschüttelt.</text>

<text class="hd" x="30" y="974">Der Haken: es ist unfassbar langsam.</text>
<text class="sm" x="30" y="1010">ein normaler Computer, offen im Freien</text>
<rect class="barA" x="30" y="1020" width="9" height="34"/>
<text class="bd" x="55" y="1048">ein Wimpernschlag</text>
<text class="sm" x="30" y="1094">genau dieselbe Aufgabe, in der verschlossenen Kiste</text>
<rect class="barB" x="30" y="1104" width="560" height="34"/>
<text class="bd e" text-anchor="end" x="670" y="1132">Minuten</text>
<text class="sm" x="30" y="1178">die grössten KI-Modelle, ganz in der Kiste</text>
<rect class="empty" x="30" y="1188" width="640" height="34" rx="6"/>
<text class="bd m" text-anchor="middle" x="350" y="1214">das hat noch niemand geschafft</text>
<text class="sm" x="30" y="1264">Ein längerer Balken heisst langsamer. Die Spur ist leer,</text>
<text class="sm" x="30" y="1294">weil der Rekord leer ist, nicht weil die Zahl klein ist.</text>
<text class="sm" x="30" y="1324">Eine Lücke in einer Grafik zu bemerken, ist eine Kunst.</text>
</svg>

</div>

<div style="overflow-x:auto">

<svg class="tspost" viewBox="0 0 700 152" role="img" aria-labelledby="p2st p2sd">
<title id="p2st">Was Plakat zwei weggelassen hat</title>
<desc id="p2sd">Die Kiste ist raffinierte Rechnerei und keine Kiste zum Anfassen, es gibt mehrere Sorten und manche sind viel schneller als andere, und wie langsam es ist, hängt sehr stark davon ab, welche Aufgabe du stellst.</desc>
<line class="rule" x1="30" y1="14" x2="670" y2="14"/>
<text class="sm" x="30" y="48">Was wir weggelassen haben: die Kiste ist in Wahrheit</text>
<text class="sm" x="30" y="78">raffinierte Rechnerei, keine Kiste zum Anfassen. Es gibt</text>
<text class="sm" x="30" y="108">mehrere Sorten, manche viel schneller als andere, und wie</text>
<text class="sm" x="30" y="138">langsam es ist, hängt stark von der Aufgabe ab.</text>
</svg>

</div>
