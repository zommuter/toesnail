# SE-corpus mining + lasercool entropy deep dive — updating the 2026-07-07 suggestions

**Date:** 2026-07-08 · **Mode:** owner-requested background-agent research (3 agents:
physics.SE sweep, math.SE/network sweep, laser-cooling literature deep dive).
**Status:** AI-emitted **findings + candidates** — nothing here edits the theory; every
resolution is the owner's. Updates the 2026-07-07 trio
(`…-1228-toe-roadmap-evaluation.md`, `…-1257-corpus-dreaming-session.md`,
`…-1318-math-on-demand-curriculum.md`); extends the owner question list to **Q13–Q16**.

## 0. Headline findings

1. **The owner's SE corpus (2010–2024) is a pre-existing shadow of the spine.**
   [physics.SE q/27195](https://physics.stackexchange.com/q/27195) (2011) *derives
   Klein–Gordon from the Casimir P²* and asks whether the Pauli–Lubanski W² yields
   Dirac/spin-s — i.e. spine **step 5 stated as a question, 15 years early**. The
   2010–11 trilogy [q/8518](https://physics.stackexchange.com/q/8518) (discrete-symmetry
   Noether, score 115 — his highest-voted post ever), [q/8626](https://physics.stackexchange.com/q/8626)
   (converse of Noether), [q/8860](https://physics.stackexchange.com/q/8860) (DOF
   counting) sits exactly on the step 1↔4 seam. Same pattern as the gtnsd/Q9 addendum:
   the owner's oldest threads keep resurfacing as spine steps.
2. **lasercool (q/669175): the strong form of the idea is second-law-forbidden; the
   weak form is established physics twice over.** "Target emits laser radiation
   *instead of* spontaneous photons as the entropy carrier" cannot work — a laser
   mode's per-photon entropy is ≈0. But (a) **radiation-balanced lasers** (target
   lases *while* its own anti-Stokes fluorescence carries the entropy) and (b)
   **cavity cooling** (a privileged **lossy** exit mode lets photons escape before
   local reabsorption — the rigorous version of the owner's instinct) both exist,
   demonstrated. Details §3.
3. **The curriculum's step-3 corpus gap has owner-authored raw material**: the
   math.SE generator/Lie cluster + the vector-spherical-harmonics-under-Poincaré and
   d-dimensional ladder-operator questions are quarry for the missing
   projective-reps/spin exploration file (§2, items P-F/M-1).

## 1. Where the owner is active (network account 125888)

physics.SE (uid 97): 26 questions, 54 answers — the primary quarry. math.SE (uid 163,
6.8k rep): 93 Q / 63 A — Lie/matrix-exp, complex analysis, Fourier/Laurent,
regularization, logic. Information Security (8k rep), Cryptography, Bitcoin — crypto/
information-wing material. MathOverflow: 1 question, directly spine-relevant.
(Stack Overflow/Unix/gaming rep exists but has nothing to mine.)

## 2. Ranked mining results — subjects worth adding (candidates; owner prunes)

Physics.SE (P-) and math/network (M-) items, merged by spine target. "Voice" = the
owner asked (Q) or answered (A) it himself.

| # | Subject | Own posts | Feeds | Candidate form |
|---|---|---|---|---|
| P-A | **Noether for discrete symmetries** — what Noether does *not* give (parity/permutation → multiplicative/mod-N charges, no currents) | [q/8518](https://physics.stackexchange.com/q/8518) (115) | step 4 ↔ step 1 (permutation group) | aside/exploration "What Noether doesn't give you" |
| P-B | **Converse of Noether + what is a DOF** — do all conserved quantities come from symmetries; DOF-counting definition | [q/8626](https://physics.stackexchange.com/q/8626), [q/8860](https://physics.stackexchange.com/q/8860) | steps 1, 4 | rigor-debt aside pair; SymPy-able worked example |
| P-C | **Casimir eigenvalue equations as field equations** — P²→Klein–Gordon (owner's own derivation), W²→spin-s?; accepted answer's subtlety: relativistic H is a *constraint*, not a generator | [q/27195](https://physics.stackexchange.com/q/27195) | steps 3–5 | headline exploration-file candidate for step 5 |
| P-D | **Mass = Casimir P² of the whole system** (his answer on "symmetry behind conservation of mass", cites Wigner) | [a/8627](https://physics.stackexchange.com/a/8627) | steps 3, 5 | sidebar citation |
| P-E | **Why −¼F² ⇒ massless photon** — gauge freedom vs Proca mass term; Proca-vs-Maxwell DOF count | [q/48349](https://physics.stackexchange.com/q/48349)+own answer, [a/281724](https://physics.stackexchange.com/a/281724) | step 7 (+5) | rigor-debt aside, verify-able DOF count |
| P-F | **Angular momentum beyond 3D** — VSH under full Poincaré; so(d) ladder operators with his own recurrence | MO [89955](https://mathoverflow.net/q/89955) = [q/27279](https://physics.stackexchange.com/q/27279), [q/759844](https://physics.stackexchange.com/q/759844) | steps 3–4 | exploration file (SymPy-friendly); still OPEN on SE |
| P-G | **Multi-particle state notation** — Fock vs ⊗ vs Hilbert-of-Hilbert | [q/671433](https://physics.stackexchange.com/q/671433) | step 0 | notation sidebar; serves photon/entropy files |
| P-H | **The quantization ladder / "third quantization"** | [q/625](https://physics.stackexchange.com/q/625) (56) | step 6 | narrative aside on what quantization *is* |
| P-I | **Wick rotation of entropy** — it↔β, iS↔? (owner-authored open problem) | [q/143075](https://physics.stackexchange.com/q/143075) | wirohsh, entropy, step 11 | verify-marked open speculation |
| P-J | **Time-reversal of stimulated emission vs absorption** | [q/817764](https://physics.stackexchange.com/q/817764) (2024) | lasercool + step 4 discrete symmetry | aside; connects to P-A |
| P-K | **Acoustic Fresnel formulas** (impedance-matched reflection/refraction) | [q/787284](https://physics.stackexchange.com/q/787284) | acoustics | new section/citation |
| P-L | **Is the world C^∞?** — smoothness/analyticity of fundamental fields | [q/1324](https://physics.stackexchange.com/q/1324) (55) | step 6/2, wirohsh, essays | essay-wing aside |
| M-1 | **Generators from first principles** — translation e^{a d/dx}, his own dilation generator α^{x d/dx}, curl as skew so(3) matrix, eigenvectors of curl | [116633](https://math.stackexchange.com/q/116633)+own answer, [337971](https://math.stackexchange.com/q/337971), [186201](https://math.stackexchange.com/q/186201) | step 4 | exploration/aside — owner-worked derivations, ready |
| M-2 | **Matrix-exp derivative + BCH** — d/dx e^{A(x)} for non-commuting A (his Dyson-like answer); ln(AB) simplification | [2043](https://math.stackexchange.com/q/2043)+[a/2047](https://math.stackexchange.com/a/2047), [57832](https://math.stackexchange.com/q/57832) | steps 3–4 | rigor-debt lemmas (`\veq` candidates) |
| M-3 | **Clifford-algebra recognition** — unitaries with {Uᵢ†,Uⱼ}=2δ | [4734748](https://math.stackexchange.com/q/4734748) | steps 3/5/6 | aside → gamma matrices/spinors doorway |
| M-4 | **ζ-regularization consistency** — 2+2+2+…=−½ or −1?; two-sided sums | [468839](https://math.stackexchange.com/q/468839), [469568](https://math.stackexchange.com/q/469568) | step 6 | rigor-debt aside on regularization caveats |
| M-5 | **Self-reference & describability** — liar paradox vs binary logic; uncountability via describability (Berry/Kolmogorov) | [119639](https://math.stackexchange.com/q/119639) (40), [2447217](https://math.stackexchange.com/q/2447217) | step 11/info wing, essays | welds to the Lawvere/omniscience item (dreaming §5.1) + MDL (§1.8) |
| M-6 | **Fourier : transform :: Laurent : ?** — transform-duality frame; analytic⟺one-sided FT; Laurent convergence rings | [444826](https://math.stackexchange.com/q/444826), [5696](https://math.stackexchange.com/q/5696), [503548](https://math.stackexchange.com/q/503548) | wirohsh ("move the problem" theme №3) | aside/citation |
| M-7 | **Number theory → RSA trapdoor** — Euler's theorem for non-coprime a; aⁿ mod n | [518845](https://math.stackexchange.com/q/518845), [537284](https://math.stackexchange.com/q/537284) | crypto/info wing | exploration material |
| M-8 | **Crypto × games** — mental poker/commutative encryption ("securely deal cards"), unordered/commutative hashing; post-quantum survivability ([48022](https://security.stackexchange.com/q/48022), 111 votes); ECDSA-vs-RSA | crypto [86629](https://crypto.stackexchange.com/q/86629), [26658](https://crypto.stackexchange.com/q/26658); infosec 48022 | info wing ∩ love-wing game theory | wing material; the "what survives quantum attack" question anchors the info-theoretic vs computational security distinction (OTP/fhe.md) |
| M-9 | **Trig identities from e^{ix}** — his 28-vote derivation | [a/1297](https://math.stackexchange.com/a/1297) | step 2 | ready-made "ℂ pays rent" demo, owner's voice |

Lower-priority but noted: momenton [q/595522](https://physics.stackexchange.com/q/595522)
(step 6/10 speculative), proper-time extremization [q/80157](https://physics.stackexchange.com/q/80157)
(step 10), regularized quantum Coulomb [q/206108](https://physics.stackexchange.com/q/206108)
(self-answered Gaussian-smearing computation — verify-ready worked example), d-dim
Laplacian = radial + L²/r² [a/364789](https://math.stackexchange.com/a/364789), how to
measure entropy [q/129158](https://physics.stackexchange.com/q/129158) (entropy.md,
operational framing).

## 3. lasercool deep dive (q/669175) — findings memo

The question as ASKED (2021): a *two-laser mutual-pumping loop* — cooler C pumps hot
laser H via the thermally Doppler-shifted line; H disposes of the excitation *by
lasing* (not fluorescing), partially re-pumping C; roundtrip condition
1 = D(T_C)·D(T_H)·η_H·η_C with the angle-averaged (second-order) relativistic Doppler
factor. One answer (score 1) redirects to cavity optomechanics — which turns out to be
on-target. Today's restatement drops the loop, makes reabsorption-suppression the
motive, and adds the entropy framing ("suck entropy from another's cavity") — per the
literature, the entropy framing is exactly the right frame.

**(i) Macroscopic laser cooling is ESTABLISHED — optical refrigeration of solids.**
Pringsheim 1929 (proposal) → **Landau 1946** (the canonical entropy accounting:
fluorescence carries entropy via bandwidth + solid angle + incoherence) → **Epstein
et al., Nature 1995** (first net cooling: Yb:ZBLANP, pump red of the mean fluorescence,
each cycle exports ~k_BT of lattice heat) → Yb:YLF to 119 K (2013) and **91 K**
(Melgaard et al. 2016), payload cooling <125 K (2022). Conditions: external quantum
efficiency ≳98–99 %, near-zero parasitic absorption; per-photon gain only ~1–3 %.
**Fluorescence reabsorption/trapping inside the solid is a real limit there too** —
the field's answer is geometry/purity/low-index hosts, *not* stimulated extraction.

**(ii) Does making the target lase help? The quantitative verdict** (Ruan, Rand &
Kaviany, PRB 75, 214304 (2007); Mungan, JOSA B 20, 1075 (2003)):

- Entropy flux per watt at ~1 µm, 60 mW: **fluorescence 5.36×10⁻⁴ K⁻¹** (more than
  4395 K blackbody!) · random laser 2.91×10⁻⁴ · **diode-quality beam 9.0×10⁻¹² K⁻¹**
  (n̄ ≈ 1.5×10⁸ per mode ⇒ ~zero entropy/photon).
- Second-law cooling-efficiency bound at 300 K: **≈20 % if the exhaust is
  fluorescence, 11 % if random-laser light, 2.7×10⁻⁹ if laser light.** Ruan et al.
  state it outright: cooling schemes based on any stimulated-emission exhaust are
  inherently less efficient. **A laser-in/laser-out box has no entropy drain — the
  strong form of the idea is forbidden.**
- BUT the weak form exists, twice:
  1. **Radiation-balanced lasers** (Bowman, IEEE JQE 35, 115 (1999)): the gain
     medium lases while its own anti-Stokes fluorescence removes the quantum-defect
     heat. Demonstrated: Yb:KGW 2002; RB silica fiber amplifier (Knall et al., PRL
     127, 013903 (2021)); RB fiber laser, 192 mW @ 56.8 % efficiency (2024). In every
     one, **the laser beam carries the energy (thermodynamically: work), the
     fluorescence carries the entropy (heat)**. Mungan's flux-temperature analysis
     makes the fluorescence exhaust structurally mandatory (efficiency → 0 as the
     fluorescence channel closes).
  2. **Cavity cooling** — the rigorous version of "give the photons a privileged,
     controlled exit so they aren't reabsorbed": coherent scattering into a **lossy
     passive** cavity mode; the anti-Stokes photon leaves through the mirror (decay κ)
     before rescattering; **κ replaces the spontaneous linewidth Γ** (T_min ~ ħκ/k_B,
     needs no closed transition). Vuletić & Chu PRL 84, 3787 (2000); ensembles
     (Hosseini et al., PRL 118, 183601 (2017): 200 µK→10 µK); levitated nanoparticle
     to the ground state (Delić et al. 2019/2020); collective *N-scaling* via
     superradiant self-organization (Domokos & Ritsch, PRL 89, 253003 (2002); RMP 85,
     553 (2013)) — cooling *improves* with atom number, the opposite of free-space
     reabsorption scaling. Boundary case: give the target mode *gain* and you get
     CARL — amplification + heating; the exit channel must be lossy, not lasing.
  3. (Bounded curiosity) **Stimulated-only cooling exists but saturates**: bichromatic
     force cooling without spontaneous emission (Corder, Arnold & Metcalf, PRL 114,
     043002 (2015)) removes energy+entropy into correlated two-mode photon
     redistribution, but phase-space compression is fundamentally limited without an
     irreversible channel (arXiv:1806.06906).

**(iii) Dense-gas reabsorption limit + known fixes** (the owner's premise, confirmed):
radiation trapping caps MOT densities and adds ~2 recoil energies per rescatter
(Walker/Sesko/Wieman 1990/1991). Fixes: dark-SPOT MOT (Ketterle 1993 — *reduce*
scattering), **festina lente** (Castin–Cirac–Lewenstein PRL 80, 5305 (1998) — make
fluorescence *slower* than the trap frequency; reabsorption then transfers no net
energy), Raman sideband cooling → laser cooling to BEC (Hu et al., Science 358, 1078
(2017)), and cavity cooling (the one fix matching the owner's instinct).

**(iv) "One laser sucking entropy from another's cavity" — closest rigorous
statements.** Optical refrigeration as a heat pump: pump laser = pure work (flux
temperature → ∞); fluorescence exhaust ≈ 1900 K "heat"; Carnot COP ≈ 0.19 at 300 K
(lineage: Scovil & Schulz-DuBois maser-as-heat-engine, PRL 2, 262 (1959)). The literal
one-laser-plus-target-cavity realization is Vuletić–Chu cavity cooling — established
**provided the second cavity is passive and lossy, not inverted/lasing**. The closed
two-laser mutual-pumping loop: no literature instance found; flux-temperature
bookkeeping shows each round trip degrades (every stage must dump fluorescence
entropy). **OPEN (nothing found):** quantitative treatment of the closed loop; net
optical refrigeration of a *running* laser below ambient (RBLs balance, don't
net-cool).

**Magnitude finding on the 2021 roundtrip condition** (finding, not a correction): the
angle-averaged Doppler factor is second-order, D(T)−1 ≈ 4k_BT/(πmc²) ≈ **2×10⁻¹³** for
Yb at 300 K — vs quantum defects η at the % scale, so the roundtrip condition as
written misses by ~11 orders of magnitude. The energetic *shape* of the scheme
(absorb red, emit blue, gap ~k_BT) is exactly right; in the real macroscopic schemes
the up-shift is delivered by **thermal population of Stark levels** (~1–3 % per
photon), not by velocity selection. First-order Doppler averages to zero over angles.

**Candidate anchors for lasercool.md's empty sections** (candidates only):
- *Multiple (two-level?) systems* → the N-body story: reabsorption/radiation trapping,
  festina lente, cavity cooling with κ-replaces-Γ and superradiant N-scaling — plus
  the Ruan/Mungan per-mode entropy numbers as the thermodynamic punchline. This is
  where q/669175 has its rigorous home.
- *Multiple levels* → two-level Doppler → four-level anti-Stokes: optical
  refrigeration (Pringsheim → Landau → Epstein → 91 K), the η_ext ≳ 98 % condition,
  radiation-balanced lasers as the "lase while cooling" limit case.
- *Off-resonance* → red detuning at the k_BT phonon scale as the macroscopic analogue
  of Doppler red-detuning; far-detuned coherent-scattering regime (no closed
  transition needed); the 2×10⁻¹³ second-order-Doppler estimate as a worked
  non-example.

Spine tie-ins: the entropy accounting welds lasercool ↔ entropy.md exactly as the
dreaming session's §1.2 "laser cooling is entropy export" bullet anticipated — now
with the quantitative backbone (Landau 1946; Ruan 2007; Mungan 2003). The
maser-as-heat-engine lineage (Scovil 1959) is a step-11 bridge. Cavity cooling's
κ-replaces-Γ is a clean "same equation, different world" instance (theme №5).

## 4. Updates to the 2026-07-07 suggestion set

- **Dreaming note §1.2 (lasercool):** the "entropy export" bullet is now
  literature-backed and sharpened: spontaneous/fluorescence emission is not a nuisance
  to engineer away but the **thermodynamically mandatory exhaust**; the engineering
  freedom is *which lossy channel* (free space vs cavity mode). The rigor-debt ladder
  gains a top rung: Doppler limit → recoil limit → sub-recoil → **per-mode entropy
  bound** (second-law tier — SymPy-able from the n̄-formula).
- **Dreaming note §5.1 (omniscience/Lawvere)** gains owner-voice anchors: math.SE
  [119639](https://math.stackexchange.com/q/119639) + [2447217](https://math.stackexchange.com/q/2447217) (M-5).
- **Curriculum step 3 gap:** partially quarried — P-F (VSH/Poincaré, so(d) ladders),
  M-2 (BCH/matrix-exp lemmas), M-3 (Clifford) are owner-authored raw material for the
  missing projective-reps/spin exploration file; the Bargmann core remains unwritten.
- **Curriculum steps 4/5:** P-A/B/C/D give the Noether/Casimir chapters owner-voice
  hooks; P-C is arguably the spine's step-5 *epigraph* question.
- **Q1 (Fock-route) evidence extended:** P-G (q/671433, Fock-vs-⊗ notation) is the
  owner's own question asking for exactly the step-0/6 notation bridge.
- **Themes (Q10):** theme №3 "move the problem" gains M-6 (Fourier:Laurent duality);
  theme №5 "same equation, different world" gains κ-replaces-Γ.

## 5. New open questions for the owner (extends Q1–Q12)

- **Q13 — SE promotion:** which mined subjects get promoted, and to what? AI's ranked
  shortlist if wanted: P-C (Casimir→field equations; step-5 headline), P-A
  (discrete-Noether aside), M-1+M-2 (generators + matrix-exp lemmas; feeds the step-3/4
  gap), P-G (notation sidebar), M-5 (describability ↔ omniscience weld). Everything
  else can sit in the inventory until its spine step is authored.
- **Q14 — lasercool anchors:** adopt the three empty-section anchors (§3) as the
  file's working skeleton, including the second-law/per-mode-entropy punchline as the
  section's honest headline finding?
- **Q15 — durable SE inventory:** create `docs/se-corpus.md` (one line per mined post:
  link, spine step, candidate form, status) so this mining survives as a referenceable
  index rather than a meeting note? Mechanical to maintain; `[ROUTINE]`-able once
  seeded.
- **Q16 — closing the SE loop (owner-only, external):** q/669175 is answerable today
  with the radiation-balanced-laser + cavity-cooling literature (§3.ii). Post a
  self-answer / bounty / edit? Also: P-F (VSH under Poincaré) is still open on two
  sites — the eventual step-3/5 exploration could become the answer. Both are
  owner-external actions; noted, not queued.

## 5b. Owner ratifications (2026-07-08, same session)

- **Q13 — RATIFIED (partial promotion):** promote **P-C** (Casimir→field equations,
  q/27195, step-5 headline exploration/epigraph), **P-A** (discrete-Noether aside,
  q/8518), **M-1+M-2** (generators + matrix-exp/BCH lemmas, step-3/4 gap material).
  Everything else stays in the inventory until its spine step is authored. Authoring
  is owner-only (physics content) — tracked as TODO id:e552.
- **Q14 — RATIFIED:** the three lasercool.md empty-section anchors (§3) are adopted
  as the file's working skeleton, including the second-law per-mode-entropy punchline.
  Owner authors the prose; the findings memo is the citation base.
- **Q15 — RATIFIED:** durable inventory created at `docs/se-corpus.md` (seeded this
  session; future upkeep `[ROUTINE]`-able).
- **Q16 — remains open** (external, owner-only): self-answering q/669175 with the
  RBL + cavity-cooling literature; P-F still open on two SE sites.

## 6. Key references (beyond the 2026-07-07 notes' lists)

*Confidence: verified this session unless marked [K] = training-knowledge citation.*

- L. Landau, "On the thermodynamics of photoluminescence", *J. Phys. (Moscow)* **10**,
  503 (1946). [K; role verified via secondary sources]
- P. Pringsheim, *Z. Phys.* **57**, 739 (1929). [K]
- R. I. Epstein, M. I. Buchwald, B. C. Edwards, T. R. Gosnell, C. E. Mungan,
  "Observation of laser-induced fluorescent cooling of a solid", *Nature* **377**,
  500 (1995).
- M. Sheik-Bahae, R. I. Epstein, "Optical refrigeration", *Nat. Photonics* **1**, 693
  (2007). [K]
- S. D. Melgaard, A. R. Albrecht, M. P. Hehlen, M. Sheik-Bahae, "Solid-state optical
  refrigeration to sub-100 Kelvin regime", *Sci. Rep.* **6**, 20380 (2016).
- S. R. Bowman, "Lasers without internal heat generation", *IEEE J. Quantum Electron.*
  **35**, 115 (1999). [K on venue]
- J. Knall, M. Engholm, T. Boilard, M. Bernier, M. J. F. Digonnet,
  "Radiation-Balanced Silica Fiber Amplifier", *Phys. Rev. Lett.* **127**, 013903
  (2021); arXiv:2103.02698. RB fiber laser 192 mW @ 56.8 %: *Opt. Lett.* (2024).
- C. E. Mungan, "Thermodynamics of radiation-balanced lasing", *J. Opt. Soc. Am. B*
  **20**, 1075 (2003).
- X. L. Ruan, S. C. Rand, M. Kaviany, "Entropy and efficiency in laser cooling of
  solids", *Phys. Rev. B* **75**, 214304 (2007).
- H. E. D. Scovil, E. O. Schulz-DuBois, "Three-level masers as heat engines",
  *Phys. Rev. Lett.* **2**, 262 (1959). [K]
- D. W. Sesko, T. G. Walker, C. E. Wieman, *J. Opt. Soc. Am. B* **8**, 946 (1991);
  T. Walker, D. Sesko, C. Wieman, *Phys. Rev. Lett.* **64**, 408 (1990). [K]
- W. Ketterle, K. B. Davis, M. A. Joffe, A. Martin, D. E. Pritchard, "…dark
  spontaneous-force optical trap", *Phys. Rev. Lett.* **70**, 2253 (1993).
- Y. Castin, J. I. Cirac, M. Lewenstein, "Reabsorption of light by trapped atoms",
  *Phys. Rev. Lett.* **80**, 5305 (1998).
- V. Vuletić, S. Chu, "Laser cooling of atoms, ions, or molecules by coherent
  scattering", *Phys. Rev. Lett.* **84**, 3787 (2000); V. Vuletić, H. W. Chan,
  A. T. Black, *Phys. Rev. A* **64**, 033405 (2001).
- P. Domokos, H. Ritsch, "Collective cooling and self-organization of atoms in a
  cavity", *Phys. Rev. Lett.* **89**, 253003 (2002); H. Ritsch, P. Domokos,
  F. Brennecke, T. Esslinger, *Rev. Mod. Phys.* **85**, 553 (2013).
- M. Hosseini, Y. Duan, K. M. Beck, Y.-T. Chen, V. Vuletić, "Cavity Cooling of Many
  Atoms", *Phys. Rev. Lett.* **118**, 183601 (2017).
- U. Delić et al., *Phys. Rev. Lett.* **122**, 123601 (2019); ground state:
  *Science* **367**, 892 (2020). [Science ref K]
- C. Corder, B. Arnold, H. Metcalf, "Laser Cooling without Spontaneous Emission",
  *Phys. Rev. Lett.* **114**, 043002 (2015); limits: arXiv:1806.06906.
- J. Hu, A. Urvoy, Z. Vendeiro, V. Crépel, W. Chen, V. Vuletić, "Creation of a
  Bose-condensed gas … by laser cooling", *Science* **358**, 1078 (2017).
- P. Maunz, T. Puppe, I. Schuster, N. Syassen, P. W. H. Pinkse, G. Rempe, "Cavity
  cooling of a single atom", *Nature* **428**, 50 (2004).
- M. Aspelmeyer, T. J. Kippenberg, F. Marquardt, "Cavity Optomechanics",
  *Rev. Mod. Phys.* **86**, 1391 (2014). (the SE answer's redirect)
- R. Bonifacio, L. De Salvo (CARL), *Nucl. Instrum. Methods A* **341**, 360 (1994)
  [K]; D. Kruse et al., *Phys. Rev. Lett.* **91**, 183601 (2003) [medium confidence].
- Zhong et al., "Critical Limitations in Cryogenic Laser Cooling of Solids …
  Fluorescence Trapping …", *Adv. Sci.* (2026), doi:10.1002/advs.202519452.

All SE posts are linked inline in §2–§3.
