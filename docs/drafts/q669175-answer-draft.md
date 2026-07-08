# DRAFT — self-answer for physics.SE q/669175 (Q16)

**Status:** AI-drafted candidate (2026-07-08) from the deep-dive findings
(`docs/meeting-notes/2026-07-08-1056-se-corpus-mining-and-lasercool-deepdive.md` §3).
The owner edits, adopts the voice, and posts (or discards). Nothing here is posted or
authoritative until the owner does. SE-flavored markdown/MathJax below the rule.

---

**TL;DR:** Macroscopic laser cooling is real — but not by Doppler selection, and the
outgoing entropy carrier can never be the coherent laser mode itself. The two halves
of the idea each exist separately in the literature: "the target lases while being
cooled" is a **radiation-balanced laser**, and "give the emitted photons a controlled
exit so they aren't reabsorbed" is **cavity cooling**. What the second law forbids is
merging them: the controlled exit channel must be a *lossy passive* mode, not a lasing
one.

**1. Cooling a macroscopic solid with a laser is established — via anti-Stokes
fluorescence, not Doppler.** Optical refrigeration pumps in the red tail of an
absorption band; thermally excited phonons top up the absorbed photon, so the mean
fluorescence photon leaves *blue-shifted* by ~$k_BT$-scale phonon energy
(Pringsheim 1929; first demonstration Epstein et al., *Nature* **377**, 500 (1995);
Yb:YLF crystals to 91 K, Melgaard et al., *Sci. Rep.* **6**, 20380 (2016); current
push: semiconductors with predicted ~10 K floors — see the reporting-standards paper
by Zhang et al., *Nat. Rev. Phys.* **7**, 149 (2025)). The per-photon fractional
up-shift is $(\lambda_P-\lambda_F)/\lambda_F \sim 1\text{–}3\%$. Compare the
mechanism I proposed in the question: the angle-averaged Doppler factor is second
order, $\langle D\rangle - 1 \approx 4k_BT/(\pi m c^2) \approx 2\times10^{-13}$ for
Yb at 300 K (first-order Doppler averages to zero over directions), so the round-trip
condition $1 = D(T_C)D(T_H)\eta_H\eta_C$ as I wrote it misses by ~11 orders of
magnitude against percent-scale quantum defects. The *energetic shape* of the scheme
(absorb red, emit blue, harvest ~$k_BT$) is exactly right — but thermal level
population, not velocity selection, is what delivers it for macroscopic matter.

**2. Why the exhaust cannot be laser light (the entropy bookkeeping).** Landau
(*J. Phys. Moscow* **10**, 503 (1946)) resolved Pringsheim's apparent second-law
paradox: the fluorescence pays the entropy bill through its bandwidth, solid angle
and incoherence. Quantitatively (Ruan, Rand & Kaviany, *Phys. Rev. B* **75**, 214304
(2007)): entropy flux per watt at ~1 µm is $\sim5.4\times10^{-4}\,\mathrm{K^{-1}}$
for hemispherical fluorescence but $\sim9\times10^{-12}\,\mathrm{K^{-1}}$ for a
diode-quality beam (per-mode occupation $\bar n\sim10^8$ ⇒ essentially zero entropy
per photon). The corresponding second-law bound on the cooling efficiency at 300 K
collapses from ~20 % (fluorescence exhaust) to ~$3\times10^{-9}$ (laser exhaust). A
laser-in/laser-out box whose interior entropy decreases has no drain — so
"suppress spontaneous emission and lase the energy out instead" is forbidden *as a
total replacement*. In heat-engine language (Scovil & Schulz-DuBois, *PRL* **2**,
262 (1959); Mungan, *JOSA B* **20**, 1075 (2003)): the pump beam and any output
laser beam are **work** (flux temperature → ∞); only the broadband fluorescence is
**heat** (flux temperature ~2000 K), and a refrigerator must reject heat.

**3. But both halves of the idea exist separately.**
*Radiation-balanced lasers* (Bowman, *IEEE JQE* **35**, 115 (1999)): the gain medium
lases while its own anti-Stokes fluorescence removes the quantum-defect heat —
demonstrated up to a 192 mW radiation-balanced fiber laser at 56.8 % efficiency
(2021–2024, e.g. Knall et al., *PRL* **127**, 013903 (2021)). The laser mode carries
the energy; the fluorescence still carries the entropy.
*Cavity cooling* (Vuletić & Chu, *PRL* **84**, 3787 (2000); review Ritsch et al.,
*RMP* **85**, 553 (2013)): the particle coherently scatters pump light preferentially
into the anti-Stokes sideband of a *lossy* cavity mode, and the photon leaves through
the mirror before it can be reabsorbed — the cavity decay rate $\kappa$ replaces the
spontaneous linewidth $\Gamma$, no closed transition is needed, and with superradiant
self-organization (Domokos & Ritsch, *PRL* **89**, 253003 (2002)) the cooling rate
*grows* with atom number — the opposite of the free-space reabsorption/radiation-
trapping limit (Sesko, Walker & Wieman, *JOSA B* **8**, 946 (1991)) that motivated my
question. This is the rigorous version of "prevent the spontaneously emitted photons
from being reabsorbed by giving them a controlled way out": the photons still enter
the privileged mode by (spontaneous-like, stochastic, anti-Stokes-shifted) scattering
— what's engineered is *which* mode and how fast it leaks, never coherent gain. The
boundary case proves the rule: give the target mode *gain* and you get CARL
(collective atomic recoil lasing) — amplification and heating, not cooling.

**4. What's still open** (as far as I can find): a quantitative treatment of the
closed two-laser mutual-pumping loop from the question (recycling the target's
*laser* output as pump light is legitimate — it's work→work, and multi-pass/
intracavity pump recycling is standard practice for absorption enhancement — but it
buys efficiency, not a new cooling channel, and each pass loses to the quantum
defect); and net optical refrigeration of a *running* laser's gain medium below
ambient — radiation-balanced lasers by construction balance to zero net heat rather
than net-cool. If someone knows literature on either, I'd be glad for pointers.

---

**Post-checklist for the owner:** adopt first person / adjust tone; decide whether to
include the §4 "open" claims (they're the AI's no-instance-found statements — verify
or soften); optionally cite the Nat. Rev. Phys. 2025 Expert Recommendation as the
standard any demonstration would have to meet; consider pinging
Seletskiy/Leitenstorfer before posting §4 so the "open" claims are expert-checked.
