---
title: Dreamed - the five-level laser cooler
permalink: /dreamed/five-level-laser
---

# The five-level laser cooler: rate equations, Carnot, and where it dies

**STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Nothing here is theory or
owner-authored, and nothing may be promoted into `physics/` without the owner authoring the move.
The `\veq` badges refer **only** to `docs/dreamed/lean/FiveLevel.lean`; they are not wired to the
repo's sidecar/verify machinery.

**Seed (owner-dictated, 2026-09-01, verbatim intent):** a five-level laser for laser cooling:
base to halfway (symmetric or asymmetric) to top, then relax to the upper laser level, lower laser
level relaxes to base, such that pump and laser bands have no Doppler-induced overlap. Full
quantum-thermal treatment, not entropy heuristics.
**Scope guard:** ROADMAP `id:e552` (`[HARD -- hands]`) reserves authoring `physics/lasercool.md`
to the owner; §9 marks which leads fall inside it. **Siblings, cited not redone:**
[`lasercool.md`](lasercool) (entropy budget, margin $\sim10^3$, $\bar n\approx1$ crossover) and
[`photon-energy-scaling.md`](photon-energy-scaling) (no COP-optimal $h\nu/k_BT$ exists as posed).

## 1. The scheme, with one correction to the reading

Levels $|0\rangle$ (base, $E_0=0$), $|1\rangle$ (about halfway), $|2\rangle$ (top, $E_2$),
$|3\rangle$ (upper laser level), $|4\rangle$ (lower laser level). Pumping is stepwise through the
**real** intermediate level: $0\to1$ absorbs $h\nu_{p1}=E_1$, $1\to2$ absorbs $h\nu_{p2}=E_2-E_1$.
Lasing $3\to4$ emits $h\nu_L=E_3-E_4$; the $2\leftrightarrow3$ and $4\to0$ steps are non-radiative.
Symmetric means $\nu_{p1}=\nu_{p2}$ (one pump laser serves both steps, at the price of pinning
$E_1=E_2/2$ exactly); asymmetric decouples the level positions at the price of a second laser.

**The correction.** The dictated reading has $2\to3$ as *relaxation* (downhill, $E_3<E_2$) and
$4\to0$ as relaxation (downhill, $E_4>0$, forced since $E_0$ is the ground state). Then energy
conservation per cycle gives $h\nu_L = E_3-E_4 < E_2 = h\nu_{p1}+h\nu_{p2}$ **always**: with both
non-radiative steps downhill the device is a heater with waste heat $(E_2-E_3)+E_4$ per cycle,
exactly a four-level laser's quantum defect. The cooling condition $h\nu_L>h\nu_{p1}+h\nu_{p2}$ is
satisfiable only if the $2\to3$ step runs **uphill**: $E_3=E_2+\Delta$ with lift $\Delta>0$, a
phonon-absorbing thermalization, not a decay. The heat drawn from the bath per cycle is then

$$ Q = h\nu_L - h\nu_{p1} - h\nu_{p2} = \Delta - E_4, \veq{coolid}\lean $$

positive iff $\Delta>E_4$. Everything below uses this corrected reading; the octave geometry
($\nu_L\approx2\nu_p$) survives it, since $\Delta$ and $E_4$ are $k_BT$-scale against an eV-scale
gap. (Putting the uphill step at the *bottom* instead, with $|4\rangle$ the true ground and
$|0\rangle$ thermally populated above it, changes nothing: §3's chain bounds are symmetric in
where the lift sits, and the conclusion is identical.)

## 2. The model: every rate named, kept or dropped

Kept, with the reason:

- **Pump steps** $0\leftrightarrow1$, $1\leftrightarrow2$: stimulated absorption *and* stimulated
  emission at equal rates $P_i = B_i\rho(\nu_{pi})$ (nondegenerate levels), plus total spontaneous
  decay $A_1$ ($1\to0$) and $A_2$ ($2\to1$). Keeping the stimulated down-rates is what caps
  $N_1\le N_0$, $N_2\le N_1$: a two-level step saturates, it never inverts.
- **Lift** $2\leftrightarrow3$: multiphonon down-rate $d$ ($3\to2$), up-rate $u=d\,e^{-\Delta/k_BT}$
  by detailed balance (Lean: `detailed_balance_boltzmann`, handle `dbal`: the steady state of such
  a pair is the Boltzmann ratio).
- **Laser transition** $3\leftrightarrow4$: stimulated rate $L=B_{34}\rho(\nu_L)$ both ways,
  spontaneous $A_{34}$ down.
- **Reset** $4\leftrightarrow0$: multiphonon down-rate $w$, up-rate $w\,e^{-E_4/k_BT}$ (detailed
  balance again; this thermal up-rate is what item §6.5 turns on).

Dropped, with the reason: multiphonon decay on the *pump* gaps ($0.6$ eV $\approx11$ phonons at a
$450\,\mathrm{cm^{-1}}$ phonon cutoff; the energy-gap law $W_{nr}\propto e^{-\alpha\,\Delta E/h\nu_{ph}}$
makes anything beyond $\sim5$ phonons negligible, which is also why a long-lived $|1\rangle$ is
plausible while the $2.6$-phonon lift at $\Delta\approx5.6\,k_BT$ stays fast). Radiative bypasses
$A_{30},A_{20}$ and excited-state absorption are parasitics, quantified in §6 and included in the
Monte Carlo but not the core matrix. With $b_3=e^{-\Delta/k_BT}$, $b_4=e^{-E_4/k_BT}$, the rate
matrix $\dot N = M N$ is

$$ M=\begin{pmatrix}
-(P_1{+}wb_4) & P_1{+}A_1 & 0 & 0 & w\\
P_1 & -(P_1{+}A_1{+}P_2) & P_2{+}A_2 & 0 & 0\\
0 & P_2 & -(P_2{+}A_2{+}db_3) & d & 0\\
0 & 0 & db_3 & -(d{+}L{+}A_{34}) & L\\
wb_4 & 0 & 0 & L{+}A_{34} & -(L{+}w)
\end{pmatrix} \veq{cons}\lean $$

Each column sums to zero, so total population is conserved and a steady state exists (Lean:
`total_population_conserved`).

## 3. Steady state: the exact inversion condition

SymPy solves the four independent balance equations symbolically (explicit linear solve, not a
blind `solve`; script in §12). The gain $N_3-N_4$ over the positive-definite denominator has the
numerator (exact, all ten rates kept):

$$ \mathcal N = P_1P_2\,d\,w\,(b_3-b_4) \;-\; A_{34}\big[P_1P_2(b_3 d + b_4 w) + \dots\big]
\;-\; b_4\,w\,[A_1A_2 d + \dots] \veq{gainnum}\sympy $$

with every elided term strictly negative. Three exact facts follow. **(i)** The only positive term
carries $b_3$, so gain requires $b_3>b_4$, i.e. $\Delta<E_4$, i.e. $Q<0$: **inversion and cooling
are mutually exclusive at any pump strength**. **(ii)** The laser intensity $L$ does not appear in
$\mathcal N$ at all: no amount of intracavity buildup changes the sign. **(iii)** In the saturated
pump limit $P_1,P_2\to\infty$ the numerator collapses to $d\,w\,(b_3-b_4)-A_{34}(b_3 d+b_4 w)$: even
at $Q=0$ exactly, spontaneous emission keeps the gain strictly negative.

The structural reason is a chained ratio bound. At steady state with forward flux on each link,
each link is bounded by its own equilibrium: the pump steps saturate ($N_1\le N_0$, $N_2\le N_1$),
the lift obeys $N_3\le N_2e^{-\Delta/k_BT}$, the reset floor is $N_4\ge N_0e^{-E_4/k_BT}$. Chaining,

$$ \frac{N_3}{N_4} \;=\; \frac{N_3}{N_2}\frac{N_2}{N_1}\frac{N_1}{N_0}\frac{N_0}{N_4}
\;\le\; e^{-(\Delta-E_4)/k_BT} \;=\; e^{-Q/k_BT}, \veq{nogain}\lean $$

so $Q>0$ forces $N_3<N_4$ (Lean: `no_gain_when_cooling`) and gain forces $Q\le0$ (Lean:
`gain_implies_heating`). A Monte Carlo over $2\times10^5$ random rate sets spanning six decades,
*including* parasitic bypass decays $A_{30},A_{20}$ outside the single-cycle topology, found
12825 inverted samples and **zero** with $b_3<b_4$: the bound survives the parallel channels,
which only drain $N_3$ further.

The bottleneck population is honest too: detailed balance pins $N_3\le e^{-\Delta/k_BT}N_2$, a
Boltzmann tax of $e^{-3}=0.050$ to $e^{-5.6}=3.7\times10^{-3}$ on the level the laser is supposed
to run on. Conventional anti-Stokes cooling pays the *same* exponential, but on the absorption
side (the thermally populated initial Stark level); the five-level scheme moves the tax, it does
not remove it.

## 4. The thermodynamics, done as a theorem

Scovil and Schulz-DuBois, *Phys. Rev. Lett.* **2**, 262 (1959)
([APS](https://link.aps.org/doi/10.1103/PhysRevLett.2.262), citation verified by web search
2026-09-01, ~715 citations) proved that a three-level maser with the pump link thermalized at
$T_h$ and the idler link at $T_c$ can only be inverted while its efficiency respects Carnot:

$$ N_\mathrm{upper} > N_\mathrm{lower} \iff \frac{\nu_s}{\nu_p} < 1-\frac{T_c}{T_h}. \veq{ssdb}\lean $$

This is Lean-proved here (`ssdb_inversion_iff_carnot`), and it **generalizes verbatim to the
five-level scheme**. The hot reservoir is the pump field at its brightness temperature $T_p$
(defined by $\bar n_p = 1/(e^{h\nu_p/k_BT_p}-1)$; a laser pump is the limit $T_p\to\infty$, where
the pump-link Boltzmann bounds relax to §3's saturation bounds). The cold reservoir is the lattice
at $T$, coupled at *both* phonon links. Chaining all four links at finite $T_p$ (Lean:
`five_level_carnot` and `gain_bounds_laser_energy`):

$$ N_3>N_4 \;\Longrightarrow\; \frac{h\nu_L}{h\nu_{p1}+h\nu_{p2}} < 1-\frac{T}{T_p}. \veq{fivecarnot}\lean $$

Cooling needs the left side $>1$; the right side is $<1$ for every $T_p>0$. So a five-level device
that *lases* while *net-cooling* would need $T/T_p<0$: it would convert lattice heat wholly into
work-grade coherent light, and the inversion condition is exactly Kelvin's statement of the second
law wearing rate-equation clothes. That is the essay's centrepiece, a theorem rather than a
heuristic, and it is the sibling's $\bar n\approx1$ crossover with the mechanism visible: the
budget said the exhaust must stay dim; the rate model shuts the gain off before it can brighten.

**What survives: the fluorescence mode.** Spontaneous emission on $3\to4$ needs no inversion
($J=A_{34}N_3>0$ regardless), so the cycle runs and cools with the exhaust as fluorescence. The
steady-state cooling power is exact and was verified numerically to machine precision:

$$ P_\mathrm{cool} = J\,(\Delta-E_4) = J\,(h\nu_L - h\nu_{p1} - h\nu_{p2}),\qquad
J = d b_3 N_2 - d N_3 = w N_4 - w b_4 N_0, \veq{cop}\lean $$

the single cycle flux. Per absorbed pump pair the COP is $Q/E_2$: 2.2% at $Q=k_BT$, 6.5% at
$Q=3k_BT$ (300 K, $E_2=1.2$ eV). Against Carnot: the fluorescence flux temperature at
$\bar n_f\sim10^{-3}$ is $T_F=h\nu_L/(7.7\,k_B)=1808$ K (sibling §2), giving
$\mathrm{COP}\le T/(T_F-T)=0.199$ at 300 K, and the Lean theorem `carnot_cop_bound` derives that
bound from energy balance plus the entropy inequality. The scheme sits a factor 3 below its own
Carnot limit. **Where the entropy goes, at rate level:** each cycle moves one photon from a bright
pump mode ($s\approx0$) into one of $\sim10^7$ fluorescence modes at $\bar n\ll1$
($s\approx7.7\,k_B$), and the cycle's $Q/T\approx3\,k_B$ of lattice entropy rides out on it; the
ledger balances with the sibling's budget, carried here by $A_{34}N_3$, a rate, not a slogan.

## 5. The stepwise-pump bottleneck, with the number

Stepwise resonant pumping through the real $|1\rangle$ is *not* virtual two-photon absorption, and
the difference is the whole feasibility case: real-level cross-sections are
$\sigma\sim10^{-20}\,\mathrm{cm^2}$, versus two-photon $\sim10^2$ GM $=10^{-48}\,\mathrm{cm^4\,s}$,
which at the same $10^3\,\mathrm{s^{-1}}$ excitation rate would demand $\sim3\,\mathrm{MW/cm^2}$
against the stepwise $\sim10\,\mathrm{kW/cm^2}$. But the second step only fires while population
sits in $|1\rangle$: the promoted fraction is $P_2\tau_1/(1+P_2\tau_1)$, so the pump must beat the
intermediate lifetime,

$$ I_2 \gtrsim \frac{h\nu_{p2}}{\sigma_2\tau_1} =
\begin{cases} 9.6\ \mathrm{kW/cm^2} & \tau_1 = 1\ \mathrm{ms}\\
96\ \mathrm{kW/cm^2} & \tau_1 = 100\ \mathrm{\mu s}\\
9.6\ \mathrm{MW/cm^2} & \tau_1 = 1\ \mathrm{\mu s}\end{cases} $$

at $\sigma_2=10^{-20}\,\mathrm{cm^2}$, $h\nu_{p2}=0.6$ eV. This does **not** kill the scheme: a
metastable $|1\rangle$ ($\tau_1\sim$ ms, plausible per the 11-phonon gap above) needs kW/cm$^2$,
routine intracavity or in a fiber core, and Er$^{3+}$ upconversion-pumped lasers run exactly this
two-step ladder in practice. The price is different: a millisecond-metastable, really-populated
$|1\rangle$ is a standing invitation to excited-state absorption (§6.3), and every $|1\rangle$
atom that decays non-radiatively dumps $0.6$ eV, twenty-three $k_BT$, so the branching of
$|1\rangle$ decay must itself be $\gtrsim99$% radiative or idle.

## 6. Parasitics, each with its number (300 K, $E_2=1.2$ eV, $Q=3k_BT$ unless said)

1. **External quantum efficiency.** A cycle that dies non-radiatively dumps $\sim E_2$; one that
   completes harvests $Q$. Net cooling needs $\eta_\mathrm{ext} > E_2/(E_2+Q)$: **97.9%** at
   $Q=k_BT$, **93.9%** at $Q=3k_BT$, **90.3%** at $Q=5k_BT$. Same class as real optical
   refrigeration (Yb:YLF needed $\approx99$%; GaAs records are $\approx99.5$%), and here it must
   hold as the *product* over five steps, not once.
2. **Background absorption.** Standard figure of merit
   $\eta_\mathrm{abs}=\alpha_r/(\alpha_r+\alpha_b)$ with state-of-the-art
   $\alpha_b\approx4\times10^{-4}\,\mathrm{cm^{-1}}$. The *first* pump step is fine
   ($\alpha_{r1}\sim10\,\mathrm{cm^{-1}}$ at $10^{21}\,\mathrm{cm^{-3}}$ doping:
   $\eta\approx0.99996$). The *second* step is the new weakness: its resonant absorption runs on
   the dilute excited population, $\alpha_{r2}=\sigma_2 N_1$, so at $N_1/N=10^{-2}$,
   $\alpha_{r2}=0.1\,\mathrm{cm^{-1}}$ and $\eta_\mathrm{abs,2}=0.996$; at $N_1/N=10^{-3}$ it is
   **0.962**, which on its own eats two thirds of the $Q=3k_BT$ budget (total inefficiency
   allowance 6.1%). Stepwise pumping degrades the parasitic-absorption figure of merit by the
   factor $N_1/N$, a cost ground-state-pumped schemes do not pay.
3. **Excited-state absorption.** By design there is standing population in $|1\rangle$ (0.6 eV)
   and $|3\rangle$ (1.2 eV). ESA of a laser photon from $|1\rangle$ lands at $1.8$ eV
   $=1.5\,E_2$; from $|3\rangle$, pump ESA lands at $1.8$ eV and laser ESA at $2.4$ eV. The scheme
   therefore needs a spectroscopic void at $1.5\times$ and $2\times$ the gap. Yb$^{3+}$ is the
   premier cooling ion precisely because it has *no* second excited manifold; any ion with a real
   halfway level (Er, Tm, Ho) has the dense upper structure that makes such voids rare, and each
   ESA event converts an eV-scale photon into heat against a $78$ meV harvest: a single per-mille
   ESA branching costs $10^{-3}\times1.2\,\mathrm{eV}/78\,\mathrm{meV}\approx1.5$% of the budget.
4. **Reabsorption and trapping.** The laser photon is resonant with $4\to3$ wherever $N_4$ lives.
   Thermal population alone gives $\alpha_\mathrm{reabs}=\sigma_L N_4 \approx
   10^{-20}\times10^{-2}\times10^{21}=0.1\,\mathrm{cm^{-1}}$ at $E_4=4.6\,k_BT$: 250 times the
   background absorption, and each trapping generation multiplies the EQE exposure
   ($\eta^{n+1}$ after $n$ reabsorptions; $0.98^5\approx0.90$ already fails item 1). The octave
   separation does nothing here, because this is same-band reabsorption.
5. **Thermal population of $|4\rangle$.** $N_4/N_0=e^{-E_4/k_BT}<\varepsilon$ iff
   $E_4>k_BT\ln(1/\varepsilon)$ (Lean: `thermal_terminal_level`, handle `nfourth`):
   $\varepsilon=10^{-2}$ needs $E_4>119$ meV at 300 K, $>40$ meV at 100 K. But cooling needs
   $\Delta>E_4$, and the cycle rate carries the lift tax $e^{-\Delta/k_BT}$, so power optimizes at
   $\Delta=E_4+k_BT$ exactly (Lean: `lift_power_bound`, handle `lift`; the sibling's Doppler-limit
   extremum pattern): harvest one $k_BT$ more than the terminal level costs. The chain
   $E_4\gtrsim4.6\,k_BT\Rightarrow\Delta\gtrsim5.6\,k_BT\Rightarrow$ rate tax $e^{-5.6}=3.7\times10^{-3}$
   caps the per-ion cooling power at $A_{34}e^{-\Delta/k_BT}\,k_BT\approx1.5\times10^{-20}$ W/ion
   ($A_{34}=10^3\,\mathrm{s^{-1}}$), against $2.1\times10^{-19}$ W/ion if $E_4$ could sit at
   $2k_BT$. Cooling to 100 K *helps* item 5 (thresholds drop threefold) but shrinks every $k_BT$
   harvest with it: the COP degrades $\propto T$, as in all anti-Stokes refrigeration.
6. **The $A\propto\nu^3$ wall.** With comparable dipole matrix elements the pump transitions,
   an octave down, have $A_p=A_L/8$: their spontaneous loss is suppressed, which *helps*
   ($|1\rangle$ lives longer for free), but the same factor suppresses the achievable resonant
   absorption per linewidth, and it is why $\sigma_2$ cannot be assumed larger than the
   $10^{-20}\,\mathrm{cm^2}$ used in §5.

**Ranking:** items 3 and 4 kill first (they are architectural, created by the populated
intermediate level and the same-band terminal level), item 1 is the usual materials wall, item 2
degrades with $N_1/N$, item 5 is a design equation rather than a killer, item 6 is neutral.

## 7. The Doppler claim, quantified, and what the octave actually buys

For a Yb-mass gas: fractional Doppler FWHM $\sqrt{8\ln2\,k_BT/mc^2}=9.4\times10^{-7}$ at 300 K
($1.4\times10^{-6}$ at 700 K), i.e. 274 MHz on the laser line, 137 MHz on the pumps. The
pump-to-laser separation is $\nu_L-\nu_p\approx145$ THz: **$5.3\times10^5$ Doppler widths** at
300 K ($3.5\times10^5$ at 700 K). The seed's claim is confirmed: overlap is excluded by five to
six orders of magnitude. Natural linewidths (kHz to MHz) and pressure broadening (~10 MHz/mbar)
change nothing at this distance. The symmetric variant adds a real gas-phase nicety: with
$\nu_{p1}=\nu_{p2}$ and counter-propagating beams the two first-order Doppler shifts cancel in the
*sum* energy, though each stepwise-resonant step still sees its own $\pm k v$.

The honest comparison: conventional Yb:YLF anti-Stokes cooling has pump-to-mean-fluorescence
separation of 7.4 THz, which is already $\sim1.3\times10^4$ gas-equivalent Doppler widths, and in
the solid, where linewidths are phonon-broadened to $\sim0.1$ to $1$ THz, still $\sim10$ to $70$
widths: adequate, and never the binding constraint. What actually limits real optical
refrigerators is same-band resonant reabsorption plus parasitic absorption, and §6.4 showed the
octave gap does not touch same-band physics. **So the architecture buys pump/laser band isolation
that conventional schemes already have in sufficient measure, and pays for it with a second pump
step, a populated metastable level, ESA exposure at $1.5\times$ and $2\times$ the gap, and the
$N_1/N$ absorption-FOM penalty. The answer to "what does it buy" is: less than it looks.**

## 8. Verdict (a recommendation, not a decision)

**As dictated (lasing output, net cooling): NO-GO, at theorem strength.** The binding constraint
is not an engineering number but the generalized Scovil-Schulz-DuBois bound of §3 to §4: inversion
requires $h\nu_L<(h\nu_{p1}+h\nu_{p2})(1-T/T_p)<h\nu_{p1}+h\nu_{p2}$, so the device can lase or
cool but never both, with the margin closed by the exact gain numerator (its only positive term
requires $Q<0$) at *any* pump strength and *any* laser intensity. This is the second law as
algebra; no rearrangement within the seed's topology escapes it, the bottom-lift variant included.

**As a fluorescence cooler: it works but is dominated.** The five-level cycle with spontaneous
$3\to4$ output is conventional anti-Stokes refrigeration with a two-step pump; every genuine cost
(items 6.2 to 6.4) is new relative to two-level (Yb-type) anti-Stokes cooling, and every benefit
is one the two-level scheme already has. Against a *four*-level Stokes laser it does cool rather
than heat, but so does the far simpler two-level scheme. Recommendation: treat the five-level
architecture as a beautiful pedagogical vehicle (it makes the SSDB theorem and the laser/heat-pump
boundary exact and Lean-provable) rather than a device candidate. **The one live salvage:**
radiation-balanced operation, i.e. running $h\nu_L$ slightly *below* the pump sum so the device
lases legally while its mandatory fluorescence fraction carries the entropy (Bowman 1999); whether
stepwise octave-split pumping offers any advantage for radiation-balanced lasers (pump ESA
immunity in fibers, say) is the only branch I could not close with a number here.

## 9. Leads

1. Radiation-balanced five-level operation: compute the Bowman balance point of the §3 model
   (gain at $Q<0$, fluorescence carrying $|Q|$ plus the defect); decidable with the same SymPy
   steady state in one sitting.
2. The $T_p$-dependence opens an LED-pumped (low brightness temperature) corner: welding the
   sibling `photon-energy-scaling.md` numbers to §4's $1-T/T_p$ is decidable by substitution;
   narrative placement is **inside `id:e552` (owner-only)**.
3. Er$^{3+}$ reality check: pick actual Er levels ($^4I_{15/2},{}^4I_{13/2},{}^4I_{9/2}$ ladder),
   measured ESA spectra and lifetimes, and re-run §6; decidable from published spectroscopy,
   and would turn §6.3 from generic to specific.
4. The lift-optimum $\Delta=E_4+k_BT$ against real Stark-manifold spacings (Yb:YLF's 450 cm$^{-1}$
   top level is $2.2\,k_BT$ at 300 K): is the existing materials choice already at this optimum?
   Decidable from the Melgaard 2016 data. Whether it enters `physics/lasercool.md`'s "Multiple
   levels" section is **inside `id:e552` (owner-only)**.
5. Formalize §3's link bounds *from* the steady state (currently Lean takes them as hypotheses;
   SymPy has the exact solution): a Mathlib proof over the symbolic 5x5 would close the one gap
   between the essay and the attestation.

## 10. Surfaced for the owner

- The dictated scheme's "$2\to3$ relax" plus "net cooling" is internally inconsistent as read;
  §1's uphill correction is what the analysis uses. If the intended reading differed (e.g.
  $|3\rangle$ populated by something other than thermal phonons), §3's no-go would need
  re-deriving for that reading.
- The q/669175 draft's §2 ("the exhaust cannot be laser light") acquires a sharper form here:
  not only does the bright exhaust carry no entropy, the *gain condition itself* enforces the
  prohibition before the exhaust exists. The draft could cite SSDB for this in one line; the
  five-level version is the same theorem with two pump photons.
- `physics/entropy.md`'s Boltzmann derivation is literally the `dbal` theorem's content, and the
  $N_4$ thermal condition (§6.5) is his $Z_1$ evaluated at $E_4$: a small, clean weld if wanted.

## 11. Lean attestation

File `docs/dreamed/lean/FiveLevel.lean`, checked 2026-09-01 from `/home/tobias/src/toesnail/verify`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/FiveLevel.lean
```

**Exit status 0, no output, no `sorry`.**

| Theorem | Attests | Handle |
|---|---|---|
| `detailed_balance_boltzmann` | steady two-level ratio = Boltzmann factor | `dbal` |
| `total_population_conserved` | zero column sums conserve $\sum_iN_i$ | `cons` |
| `ssdb_inversion_iff_carnot` | 3-level inversion $\iff \nu_s/\nu_p<1-T_c/T_h$ | `ssdb` |
| `no_gain_when_cooling` | link bounds + $E_4<\Delta$ $\Rightarrow N_3<N_4$ | `nogain` |
| `gain_implies_heating` | inversion $\Rightarrow\Delta\le E_4$ | `nogain` |
| `cooling_iff_lift_exceeds_terminal` | $h\nu_L>\sum h\nu_p \iff E_4<\Delta$ | `coolid` |
| `five_level_carnot` | inversion $\Rightarrow (E_{p1}{+}E_{p2})/T_p+(\Delta{-}E_4)/T<0$ | `fivecarnot` |
| `gain_bounds_laser_energy` | rearranged: $E_L/E_p<1-T/T_p$ | `fivecarnot` |
| `carnot_cop_bound` | $Q/T\le E_F/T_F \Rightarrow \mathrm{COP}\le T/(T_F{-}T)$ | `cop` |
| `thermal_terminal_level` | $e^{-E_4/k_BT}<\varepsilon \iff E_4>k_BT\ln(1/\varepsilon)$ | `nfourth` |
| `lift_power_bound` / `lift_power_at_optimum` | $(\Delta{-}E_4)e^{-\Delta/k_BT}$ maximal iff $\Delta=E_4+k_BT$ | `lift` |

**What was weakened.** The per-link bounds feeding `no_gain_when_cooling` and
`five_level_carnot` are *hypotheses* in Lean, derived in the essay from the exact SymPy gain
numerator (whose sign analysis is inspection of an explicit polynomial) plus the
$2\times10^5$-sample Monte Carlo; lead 5 is the missing formalization. Nothing numeric or
dimensional is attested; all temperatures carry $k_B$ folded in; the identification with rates
and level energies lives in docstrings. Einstein $A/B$ relations and every §5 to §7 number are
SymPy/NumPy-level only.

## 12. What a `.mw` version would carry

Sketch in the style of `verify/mirror/resogram_esol.mw`. Not a mirror, not executable.

```computation
b3 = exp(-dlift/(kB*T)); b4 = exp(-E4/(kB*T))
M = Matrix(...)          # the section-2 rate matrix, columns summing to zero
Nss = nullspace(M)       # steady state; gain = N3 - N4
gain_num = numer(together(N3 - N4))   # only positive monomial carries b3
```

```computation
J = d*b3*N2 - d*N3
P_cool = J*(dlift - E4)              # == J*(h*nuL - h*nup1 - h*nup2)
COP = (dlift - E4)/(h*nup1 + h*nup2)
dlift_opt = E4 + kB*T                # argmax of (dlift-E4)*exp(-dlift/(kB*T))
```

The payoff is the same staleness class as Resogram's `edot`: `P_cool`, `COP` and `dlift_opt` all
hang off the sign of `dlift` fixed in §1; flip the $2\to3$ step back to "relax" and every
downstream number silently inverts in plain markdown, while a DAG would flag all four.
