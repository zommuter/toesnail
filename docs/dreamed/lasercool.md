---
title: Dreamed - laser cooling as entropy bookkeeping
permalink: /dreamed/lasercool
---

# Where does the entropy go? Laser cooling as a mode-counting argument

**STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Nothing here is theory or
owner-authored, and nothing may be promoted into `physics/` without the owner authoring the move.
The `\veq` badges refer **only** to `docs/dreamed/lean/Lasercool.lean`; they are not wired to the
repo's sidecar/verify machinery.

**Seed** (owner-picked): `physics/lasercool.md` (the three empty sections whose anchors were
ratified 2026-07-08, Q14), `physics/entropy.md`, the deep-dive note
`docs/meeting-notes/2026-07-08-1056-se-corpus-mining-and-lasercool-deepdive.md`, and the owner's
own [q/669175](https://physics.stackexchange.com/q/669175) and
[q/817764](https://physics.stackexchange.com/q/817764) with `docs/drafts/q669175-answer-draft.md`.
**Scope guard:** ROADMAP `id:e552` (`[HARD -- hands]`) reserves the *authoring* of
`physics/lasercool.md`'s empty sections to the owner. This file does not write them and is not
executor-ready work; §8 marks which leads fall inside `id:e552`.

## 1. The claim in one line

Laser cooling works because the pump beam is one mode and the fluorescence is ten million modes.
The exact form of that sentence also settles q/669175 and q/817764.

## 2. Entropy per photon is set by mode occupation, not by the word "laser"

A field mode with mean occupation $\bar n$ carries the Bose entropy (in units of $k_B$)

$$ s(\bar n) = (1+\bar n)\ln(1+\bar n) - \bar n\ln\bar n \veq{bosn}\lean $$

whose nonnegativity on $\bar n>0$ is Lean-proved. Entropy **per photon** is $s(\bar n)/\bar n$:

$$ \frac{s(\bar n)}{\bar n} \simeq 1+\ln(1/\bar n)\ \ (\bar n \ll 1), \qquad \frac{s(\bar n)}{\bar n} \simeq \frac{1+\ln\bar n}{\bar n}\ \ (\bar n \gg 1) \veq{spph}\sympy $$

Computed values of $s/\bar n$: 7.91, 5.61, 3.35, 1.386, 0.335, 0.056, 0.008 $k_B$ per photon at
$\bar n = 10^{-3}, 10^{-2}, 10^{-1}, 1, 10, 10^2, 10^3$. Two consequences.

**(a) Geometry enters only logarithmically.** Three decades in $\bar n$ move $s/\bar n$ by a factor
2.4, so every estimate below is robust against order-of-magnitude sloppiness in its mode count.

**(b) There is no such thing as "laser light has no entropy".** A *dim* single-mode beam
($\bar n\ll1$) carries several $k_B$ per photon like anything else. Coherence is not the operative
property; brightness is.

**Cross-check.** Ruan, Rand and Kaviany (PRB **75**, 214304 (2007), via the note §3.ii) quote
entropy flux per watt at 1 µm: $5.36\times10^{-4}$ K$^{-1}$ for fluorescence,
$9.0\times10^{-12}$ K$^{-1}$ for a diode beam. Converting with $h\nu$: **7.71** and
**$1.30\times10^{-7}$** $k_B$ per photon. The second reproduces $(1+\ln\bar n)/\bar n$ at their
stated $\bar n = 1.5\times10^8$ to three digits ($1.32\times10^{-7}$), the first corresponds to
$\bar n = 1.2\times10^{-3}$: formula and published numbers agree, which licenses using it below.

## 3. The budget for Rb87 D2, with arithmetic

Parameters: $\lambda = 780.241$ nm, $\Gamma/2\pi = 6.0666$ MHz, $m = 86.909\,u$; hence
$k = 8.055\times10^6$ m$^{-1}$, $E_\mathrm{rec}/h = 3.77$ kHz, $v_\mathrm{rec} = 5.885$ mm/s,
$T_\mathrm{rec} = \hbar^2k^2/(mk_B) = 362$ nK, $T_D = \hbar\Gamma/2k_B = 145.6$ µK.

**Pump.** 1 mW at 780 nm is $3.93\times10^{15}$ photons/s. In one spatial mode of 1 MHz linewidth,
$\bar n = 3.9\times10^{9}$ and $s/\bar n = 5.9\times10^{-9}\,k_B$ per photon (at 1 kHz linewidth,
$7.6\times10^{-12}$). The pump delivers energy and no entropy: it is **work**, not heat.

**Fluorescence.** Mode rate of an emitter of area $A$ radiating into $4\pi$ over bandwidth
$\Delta\nu$ is $\dot M = 2(A\cdot4\pi/\lambda^2)\Delta\nu$ (two polarizations, étendue
$A\Omega/\lambda^2$). For a 1 mm cloud at $\Delta\nu=\Gamma/2\pi$, $\dot M = 2.5\times10^{14}$
modes/s. At $s=1,\ \delta=-\Gamma/2$ each atom scatters at $\Gamma/6 = 6.4\times10^6$/s, so a
$10^7$-atom MOT gives $\bar n_f = 0.32$ and **2.28 $k_B$ per fluorescence photon**; $10^6$ atoms
give 4.45 $k_B$; a single atom ($A=\lambda^2$) gives 4.20 $k_B$.

**Atoms.** The naive route, $\Delta S = \tfrac32 k_B\ln(T_f/T_i)$ from capture at 30 m/s
($T_i = 3.14$ K) to $T_D$, gives $-14.97\,k_B$ per atom over at least $mv/\hbar k = 5098$
scattering events, i.e. $2.9\times10^{-3}\,k_B$ per photon. There is an exact closed form. With
the §5 friction and diffusion at $\delta=-\Gamma/2$,

$$ \alpha = \hbar k^2 s,\qquad R_\mathrm{tot} = \tfrac12\Gamma s,\qquad \frac{\alpha}{R_\mathrm{tot}} = \frac{2\hbar k^2}{\Gamma} \veq{alphaR}\sympy $$

so the entropy removed from atomic motion per scattering event at gas temperature $T$ is

$$ \sigma_\mathrm{atom}(T) = \frac{k_B}{m}\frac{\alpha}{R_\mathrm{tot}}\Big(1-\frac{T_D}{T}\Big) = k_B\frac{T_\mathrm{rec}}{T_D}\Big(1-\frac{T_D}{T}\Big) \le k_B\frac{T_\mathrm{rec}}{T_D} = \frac{4\omega_\mathrm{rec}}{\Gamma}k_B \veq{budget}\lean $$

(SymPy-verified identity; the bound and its use are Lean-proved.) This is the cleanest result here:
**the entropy a Doppler-cooled atom can shed per scattered photon is bounded by the inverse
sideband-resolution parameter** $4\omega_\mathrm{rec}/\Gamma = T_\mathrm{rec}/T_D$, and by nothing
else. For Rb87 that is $2.49\times10^{-3}\,k_B$; for Na D2 (589.158 nm, $\Gamma/2\pi = 9.795$ MHz)
$1.02\times10^{-2}\,k_B$, sodium's recoil being 6.6 times larger against a linewidth only 1.6 times
larger.

**Verdict.** Field gains $\gtrsim2\,k_B$ per photon, atoms lose at most $2.5\times10^{-3}\,k_B$:
**the inequality holds, with margin $\sim10^3$ for Rb87 and $\sim3\times10^2$ for Na.** That is
smaller than the $\sim10^7$ suggested by "one mode versus $4\pi$", because the atoms are terrible at
shedding entropy, not because the field is bad at absorbing it. The margin would close only at
$\bar n_f\approx3.1\times10^3$ (bisection on $s(\bar n)/\bar n = 2.49\times10^{-3}$), while
free-space radiation trapping pushes $\bar n_f$ from $10^{-2}$ only toward 1, six orders short:
**reabsorption is an energy and rate problem, not a second-law problem**, and the note's trapping
limit (§3.iii) should not be read as a thermodynamic one.

## 4. Why the owner's scheme cannot work, in its strongest form

q/669175 proposes relaxing the excited target by **stimulated** emission into a controlled cavity
mode rather than spontaneously into $4\pi$. The obstruction is one line:

$$ \frac{R_\mathrm{stim}}{R_\mathrm{spon}} = \bar n \ \text{(Einstein)},\qquad \frac{s(\bar n)}{\bar n}\Big|_{\bar n=1} = 1.386\,k_B,\qquad \frac{s(\bar n)}{\bar n} = 1 \ \text{at}\ \bar n = 1.84 \veq{crossover}\sorry $$

**A laser cannot be the exhaust: the brightness that makes it a laser is what empties it of
entropy.** The threshold at which stimulated emission starts to dominate and the threshold at
which the exhaust stops carrying $k_B$-scale entropy per photon are the same threshold, $\bar n
\approx 1$: these are not two facts to balance, they are one fact. To make stimulated relaxation
dominate by a factor $R$ you must set $\bar n = R$, and thereby divide the exhaust entropy per photon by
$R/(1+\ln R)$. Energy conservation caps the exhaust at about one photon per absorbed photon, so
nothing buys the factor back. Rb87 needs $2.5\times10^{-3}\,k_B$ per exhaust photon, capping
$\bar n$ at $3\times10^3$; a solid needing $\sim k_B$ per photon caps $\bar n$ near 3. A "laser"
at $\bar n\le3$ is not lasing.

This is also the honest reading of the note's "$\kappa$ replaces $\Gamma$". Cavity cooling does
**not** relax the atom by stimulated emission. The cavity mode is a fast directional **filter**
held at $\bar n\ll1$ (the photon leaves at rate $\kappa$ before a second arrives); the sink is
still the free-space continuum outside the mirror, and the outgoing beam is dim, so it carries its
several $k_B$ per photon. Give the same mode gain instead of loss and you get CARL, i.e. heating.
The engineering freedom is *which* lossy channel, never *whether* there is one.

## 5. The Doppler limit, derived, and what beats it

Two counter-propagating beams, saturation $s$, detuning $\delta$; each beam's rate for an atom at
velocity $v$ is $\frac{\Gamma}{2}\frac{s}{1+s+(2(\delta\mp kv)/\Gamma)^2}$. Expanding
$F = \hbar k(R_+-R_-)$ to first order in $v$ (SymPy):

$$ F = -\alpha v,\qquad \alpha = \frac{-8\hbar k^2 s\,\Gamma^3\delta}{\left(\Gamma^2(1+s)+4\delta^2\right)^2} \veq{alpha}\sympy $$

positive (a friction) exactly for $\delta<0$. With momentum diffusion
$D_p = \hbar^2k^2R_\mathrm{tot}$, $R_\mathrm{tot} = \Gamma^3s/(\Gamma^2(1+s)+4\delta^2)$, the
low-intensity steady state $k_BT = D_p/\alpha$ is

$$ k_B T(\delta) = \frac{\hbar\left(\Gamma^2+4\delta^2\right)}{8|\delta|} = \frac{\hbar\Gamma}{2}\cdot\frac{\Gamma^2/4+\delta^2}{|\delta|\Gamma} \veq{dopT}\sympy $$

and the dimensionless factor is $\ge1$ for every red detuning, with equality **iff**
$|\delta|=\Gamma/2$:

$$ \frac{\Gamma^2/4+\delta^2}{|\delta|\Gamma} \ge 1 \quad\Longleftrightarrow\quad \left(|\delta|-\tfrac{\Gamma}{2}\right)^2 \ge 0 \veq{dopmin}\lean $$

Hence $T_D = \hbar\Gamma/2k_B$: **145.6 µK** for Rb87, **235.0 µK** for Na. Bound, attainment and
uniqueness are all Lean-proved. Honest caveat, and the reason this is a claim about an
*expression* rather than about a Fokker-Planck steady state: the O(1) normalization of $D_p$ is
convention-dependent (the dipole radiation pattern shifts the prefactor), and only
$D_p = \hbar^2k^2R_\mathrm{tot}$ reproduces the canonical $\hbar\Gamma/2$ exactly.

**What beats it, and which assumption each one breaks.**

- **Polarization-gradient / Sisyphus** (1 to 10 µK): breaks "one ground state responding at rate
  $\Gamma$". With Zeeman sublevels the friction is set by the optical pumping time, far longer than
  $\Gamma^{-1}$ at low intensity, so $\alpha$ grows by the light-shift-to-pumping-rate ratio while
  $D_p$ does not.
- **The recoil limit** $T_\mathrm{rec}$ (362 nK for Rb87): breaks nothing. It is the floor for any
  scheme in which every atom keeps scattering, the last photon leaving a random $\hbar k$ behind.
- **VSCPT** breaks "every atom keeps scattering": a velocity-selective dark superposition makes
  atoms near $v=0$ stop absorbing, giving the random walk an absorbing boundary at zero.
- **Raman sideband cooling** breaks it differently: in the Lamb-Dicke regime the trap takes up the
  recoil (the Mössbauer move), so the motional quantum number ratchets down without a penalty.
- **Cavity cooling** breaks "the exit linewidth is $\Gamma$": $\kappa$ is free, so
  $T_\mathrm{min}\sim\hbar\kappa/k_B$ and no closed transition is needed.

Note what §3's bound says about these: $\sigma_\mathrm{atom}\le k_BT_\mathrm{rec}/T_D$ was derived
from the *Doppler* $\alpha$ and $R_\mathrm{tot}$. Sisyphus raises $\alpha$ at fixed
$R_\mathrm{tot}$, so it removes more entropy per scattered photon, which is exactly why it is
better. The bound constrains a mechanism, not the second law.

## 6. Time reversal (q/817764), and why it is the same fact as the entropy

The existing answer on q/817764 is right, and its Jaynes-Cummings framing is the correct one: the
time reverse of stimulated emission *is* absorption, the same Rabi cycle read backwards, and
$n\to n-1$ processes differ only through the Rabi frequency $\propto\sqrt n$. Three sharpenings.

**(i) Spontaneous emission is not an exception.** It is stimulated emission by the vacuum modes:
the $n\to n+1$ matrix element carries $\sqrt{n+1}$, nonzero at $n=0$, and the total rate
$A(1+\bar n)=A+B\bar n$ has the "1" as the $n=0$ case of the same coupling. Its time reverse is a
perfectly conjugated *converging* dipole wave being fully absorbed: not hypothetical, only hard.
Parabolic-mirror and $4\pi$-focusing single-photon absorption experiments approach it, and their
absorption probability measures how much of that mode they fill. Unitarity is never in question.

**(ii) Where the arrow actually enters.** Not in the Hamiltonian. In the Wigner-Weisskopf
derivation of exponential decay it enters at exactly three steps: (1) the initial state is the
field **vacuum** with no incoming correlations, a time-asymmetric *state* assumption rather than a
dynamical one; (2) the continuum density of states is flattened over the linewidth and the memory
kernel collapsed to a delta function (the Markov step), discarding what the field carries away;
(3) the pole gets the retarded prescription, selecting outgoing boundary conditions. Reverse the
initial condition and the calculation runs backwards without complaint. What is irreversible is a
small system coupled to a continuum whose state is untracked and which does not act back.

**(iii) The weld.** Step 2 *is* §3's entropy production. Tracing out the emitted photon discards
exactly the atom-field correlation the emission built, and that discarded mutual information, in
$k_B$, is §2's $s(\bar n)/\bar n$. **"The photon goes into one of $10^7$ modes we do not track" and
"the calculation picks the retarded branch" are the same sentence**, not two arguments that happen
to agree. Hence laser cooling *requires* an irreversible channel, and hence the bichromatic-force
schemes avoiding spontaneous emission (Corder, Arnold and Metcalf, PRL **114**, 043002 (2015))
remove energy but saturate in phase-space compression: without step 2 there is nowhere to put it.

## 7. The connection to `physics/entropy.md`, weighed honestly

`entropy.md` maximizes $S_B$ over $N$ equally spaced levels, gets $Z_B=(1-Z_1^N)/(1-Z_1)$ with
$Z_1=e^{-\beta E_1}$, and reads two limits off the *same* partition function: $N\to\infty$ gives
$\langle k\rangle = 1/(e^{\beta E_1}-1)$ (`\veq{be}`), $N=2$ gives $1/(e^{\beta E_1}+1)$
(`\veq{fd}`).

**Real structural connection.** The $N\to\infty$ case is not an analogy for the field mode; it *is*
the field mode. A quantized mode is exactly a ladder with $E_k=k\hbar\omega$, and his
$\langle k\rangle$ is $\bar n$, the one quantity §2 and §4 turn on, so his derivation already
contains the pump-versus-fluorescence distinction: the channels differ only in which $\bar n$ the
same formula is evaluated at. The missing step is small. Evaluating $S=-\sum_k p_k\ln p_k$ on his
own $p_k=Z_1^k/Z_B$ at $N\to\infty$ gives exactly $(1+\bar n)\ln(1+\bar n)-\bar n\ln\bar n$, three
lines of his existing algebra, making `entropy.md` the direct upstream of this essay.

**Only a cute observation.** The $N=2$ case gives the Fermi-Dirac *function*, and a two-level atom
obeys it, but for a different reason. His $N=2$ is a **state-counting cutoff**: higher levels are
simply not summed. For a real fermionic mode that cutoff comes from antisymmetry; for a two-level
atom from detuning, the higher levels existing and merely being off resonance. Exchange statistics
never appears, and cannot, because a single-mode occupation distribution is blind to it: BE and FD
*as distributions* are single-mode statements, and everything statistics-specific lives in
justifying the cutoff, not in the algebra downstream. So "laser cooling couples a fermionic
subsystem to a bosonic one" is false as stated. The defensible version: **laser cooling couples a
two-state system to an unbounded ladder, and the whole asymmetry of the process is the asymmetry
between those two cutoffs.** That is still a good sentence, and his own $Z_B$ supplies both ends.

## 8. Leads

1. Fold $s(\bar n)$ into `entropy.md` by evaluating $-\sum p_k\ln p_k$ on the existing
   $p_k=Z_1^k/Z_B$; decidable by SymPy in one sitting. **Inside `id:e552` (owner-only).**
2. Whether the ratified "Multiple (two-level?) systems" anchor should lead with the $\bar n\approx1$
   coincidence of §4 is a narrative call decidable only by the owner. **Inside `id:e552`.**
3. Redo §3 for optical refrigeration of solids: harvesting $\sim k_BT$ per photon means
   $\sigma\sim k_B$ against fluorescence's 7.7 $k_B$, a margin of only $\sim5$; decidable by
   redoing the arithmetic with the Epstein/Mungan numbers, and if single-digit it is the sharpest
   second-law statement in the subject.
4. The owner's maser question (note §5d) has a closed-form optimum: maximize the $k_BT/h\nu$
   harvest against the $\bar n_\mathrm{th}=1/(e^{h\nu/k_BT}-1)$ penalty using §2's $s(\bar n)$;
   decidable by SymPy, and the note records no paper stating $h\nu/k_BT|_\mathrm{opt}$ explicitly.
5. Formalize the crossover: $s(\bar n)/\bar n$ is strictly decreasing on $\bar n>0$ and crosses
   $k_B$ at $\bar n = 1.84$; decidable by a Mathlib derivative computation, not attempted here.

## 9. Surfaced for the owner: critique of `docs/drafts/q669175-answer-draft.md`

**Strongest part, §1.** The self-correction of the 2021 round-trip condition is the draft's best
move: reporting your own $\langle D\rangle-1\approx2\times10^{-13}$ against percent-scale quantum
defects, then keeping the *shape* of the scheme (absorb red, emit blue, harvest $k_BT$) while
replacing velocity selection with thermal Stark population. Keep it as written.

**Weakest part, §2's word "forbidden".** As drafted the argument runs: the laser exhaust has
essentially zero entropy per photon, so a laser-in/laser-out box has no drain, so the strong form
is forbidden. That does not close. A diode beam carries $1.3\times10^{-7}\,k_B$ per photon, small
but nonzero, so what has been shown is a suppression factor, not a prohibition. A referee asks why
$10^7$ times more exhaust photons do not fix it, and the draft has no answer on the page. **The
prohibition needs one more premise, and it is energy conservation:** at most about one exhaust
photon leaves per absorbed photon, so the per-photon comparison is the whole comparison. Adding
that sentence turns an assertion into an argument.

**Missing, and the best thing you could add: §4's $\bar n\approx1$ coincidence.** A laser cannot be
the exhaust: the brightness that makes it a laser is what empties it of entropy. Stimulated
emission dominates iff $\bar n>1$; the exhaust drops below $k_B$ per photon iff $\bar n>1.84$. Your
question's central intuition, relaxing via the resonance a laser provides instead of
spontaneously, is self-defeating at exactly the point where it starts to work. That is one line
rather than a citation, and it explains *why* radiation-balanced lasers must keep a fluorescence
channel open.

**Also: §2 conflates coherence with low entropy.** "Coherent laser mode therefore near-zero
entropy" is wrong in general; a dim single-mode beam carries several $k_B$ per photon. Brightness
kills the entropy, not coherence. This matters for your §3, because cavity cooling's exit beam
*is* single-mode and coherent and still carries entropy fine, which under the draft's framing
looks like a contradiction it then has to talk around. Relatedly, §3's "the photons still enter
the privileged mode by (spontaneous-like, stochastic, anti-Stokes-shifted) scattering" is correct
and load-bearing, but the parenthesis buries the whole point: the cavity mode is a filter held at
$\bar n\ll1$, not a stimulated relaxation channel. Promote it to the topic sentence.

**Net verdict.** Publishable after the §2 repair, materially better with the $\bar n\approx1$
crossover added: the physics is sound throughout, the logic has one gap, and the gap sits in the
sentence the draft is most confident about. On §4's "still open" claims I did not independently
search the literature this session and add no evidence either way; the post-checklist's advice to
have Seletskiy or Leitenstorfer check them before posting stands, and I would not weaken it.

## 10. Lean attestation

File `docs/dreamed/lean/Lasercool.lean`, checked 2026-09-01 from `/home/tobias/src/toesnail/verify`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Lasercool.lean
```

**Exit status 0, no output, no `sorry`.**

| Theorem | Attests | Handle |
|---|---|---|
| `doppler_ratio_ge_one` | $(\Gamma^2/4+\delta^2)/(\lvert\delta\rvert\Gamma)\ge1$ for $\Gamma>0,\ \delta<0$ | `dopmin` |
| `doppler_ratio_at_optimum` | the bound is attained at $\delta=-\Gamma/2$ | `dopmin` |
| `doppler_ratio_eq_one_iff` | equality iff $\lvert\delta\rvert=\Gamma/2$ | `dopmin` |
| `bose_entropy_nonneg` | $(1+n)\ln(1+n)-n\ln n\ge0$ on $n>0$ | `bosn` |
| `entropy_margin` | $(T_\mathrm{rec}/T_D)(1-T_D/T)<s_{ph}$ given $0<T_\mathrm{rec}<T_D,\ T>0,\ s_{ph}\ge1$ | `budget` |
| `Trec_div_TD` | $T_\mathrm{rec}/T_D = 2\hbar k^2/(\Gamma m) = 4\omega_\mathrm{rec}/\Gamma$ | `budget` |

**What was weakened.** `entropy_margin` assumes $s_{ph}\ge1$ rather than deriving it from
$s(\bar n)/\bar n$; that needs monotonicity of $s(n)/n$, which I did not attempt (lead 5), so "a
dim channel carries at least $k_B$ per photon" is a Lean hypothesis, not a theorem. Nothing numeric
or dimensional is attested: the six theorems are statements about real numbers, and the
identification with $\Gamma,\delta,T_D$ is carried by the docstring. The friction/diffusion
derivation (`alpha`, `dopT`, `alphaR`) is SymPy-checked only, and `crossover` is `\sorry` on
purpose, the Einstein-coefficient ratio being quoted rather than derived here.

## 11. What a `.mw` version would carry

Sketch in the style of `verify/mirror/resogram_esol.mw`. Not a mirror, not executable.

```computation
s_bose = (1 + nbar)*log(1 + nbar) - nbar*log(nbar)
alpha = -8*hbar*k**2*sat*Gamma**3*delta / (Gamma**2*(1 + sat) + 4*delta**2)**2
R_tot = Gamma**3*sat / (Gamma**2*(1 + sat) + 4*delta**2)
```

```computation
kT_doppler = (hbar**2*k**2*R_tot) / alpha
sigma_atom = (kB/m) * (alpha/R_tot) * (1 - TD/T)
margin = (s_bose/nbar) / (kB * Trec / TD)
```

The payoff is specific: `sigma_atom` depends on `alpha` and `R_tot`, which depend on `delta`, and
`kT_doppler` fixes `delta = -Gamma/2`. Change the diffusion normalization in `kT_doppler` and §3's
`margin` figure goes stale silently in plain markdown; a DAG would catch it. Same staleness class
as the `edot` sign propagation recorded in MEMORY.
