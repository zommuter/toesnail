---
title: Which methodology themes earn their names
permalink: /dreamed/methodology-themes
---

# Q10: which candidate methodology themes become named themes of the book?

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written 2026-09-01, round 2 of the
> owner-picked dreaming session. Seed: open owner question **Q10** of
> `docs/meeting-notes/2026-07-07-1257-corpus-dreaming-session.md` §6, whose §3 lists six candidate
> themes and recommends naming No. 1 (compactness) and No. 4 (reversibility). This essay tests all
> six against the repo's actual text, instance by instance, and ranks them by how much existing text
> each one explains. It **proposes**; the owner disposes. Every `\veq` badge is a claim about
> [`lean/Themes.lean`](lean/Themes.lean) only, not the repo's `verify/` machinery.

## 0. Headline

A named theme is a leitmotif the book returns to by name. The empirical test used here: count the
places where owner-authored text already exhibits the motive, with file:line receipts, and count
separately what is dreamed and what is merely prospective. Result, sorted by owner-instance count:

| Candidate (note §3 numbering) | Owner instances | Files | Dreamed | Prospective chapters |
|---|---|---|---|---|
| No. 3 move the problem, solve, move back | ~8 | 5 | 4+ | many |
| (missed) the complex plane pays rent | 4 | 2 (+1 corpus row) | 4 | step 2 |
| No. 1 compactness => discreteness => quantization | 3 + 1 converse | 1 | 3 | >= 4 |
| No. 4 reversibility is sacred | 1 explicit + 2 implicit | 3 | 2 | >= 3 |
| No. 2 linearize, then worry | 1 | 1 | 0 | many |
| No. 5 same equation, different world / No. 6 one protagonist | 1 | 1 | 1 | many |

The note's recommendation ("No. 1 and No. 4 carry the most chapters per gram") comes out **half
confirmed**: No. 1 survives the attack and is the strongest theme by instance *quality* despite a
count concentrated in one file; No. 4 is currently a **slogan, not a theme** (the words
"reversible" and "irreversible" appear in zero owner-authored files; `grep -rn 'revers'
physics/ essays/ crypto/` returns nothing). §2 says what would upgrade it. The two surprises are
that the note's own No. 3 quietly out-counts everything, and that the note missed a candidate whose
name the corpus doc has already minted (§3).

## 1. Theme No. 1: compactness => discreteness => quantization

### 1.1 The instances, honestly

**Fits, explicitly (all in `physics/wirohsh.md`):**

1. `wirohsh.md:62-64`: $\Phi_m(\varphi)=e^{im\varphi}$, $m\in\mathbb Z$, "the discreteness of $m$
   is a result of requiring $\Phi(\varphi+2\pi)=\Phi(\varphi)$". The theme's engine, verbatim,
   owner-authored. Proved both ways in Lean below.
2. `wirohsh.md:32`: solid harmonics "thanks to periodicity constraints on a shell only have
   discrete indices". The mechanism cited by name, one paragraph before the derivation.
3. `wirohsh.md:40`: "the discrete base set of hyperspherical functions"; the whole WiRoHSH program
   is an attempt to *manufacture* a compact domain (via Wick rotation into polar angles) so that
   this theme fires.

**The converse, also owner-authored:** `wirohsh.md:30` complains that the Fourier $\omega$ on the
non-compact time axis is continuous, "rather disadvantageous" computationally. A theme that explains
the corpus's frustrations as well as its wins is doing real work: the complaint and the derivation
are the same fact with the compactness toggled.

**Does not fit, and saying so matters:** `physics/entropy.md:6` has a discrete level index
$k\in\{0,\dots,N-1\}$, but that discreteness is *assumed* (a postulated finite state space), not
derived from any compact domain; nothing in the file is periodic. Likewise `lasercool.md:25`'s two
levels are an input. Claiming these for the theme would be exactly the stretch that makes a theme
worse; the honest coverage is one file deep and one file wide.

**Dreamed extensions (cited, not duplicated):** [`wick-entropy.md`](wick-entropy.md) shows the same
$m$ *is* the Matsubara index under $z=e^{w}$, and that the owner's periodicity line, read on the
rotation circle, is the no-conical-singularity condition fixing the Unruh temperature.
[`wirohsh-approximation.md`](wirohsh-approximation.md) §1 runs the theme backwards as an exact
mechanism: unwrap the compact circle to a strip and the discrete Laurent index becomes the
continuous two-sided-Laplace/Mellin variable.

**Prospective (would have to be written):** Peter-Weyl (compact group => discrete irreps, spine
step 4), Dirac / compact-U(1) charge quantization (the note's own payoff, feeding the owner's
U(1)-uniqueness question), particle in a box (second boundary-condition instance, Lean-closed
below), Bloch's theorem, flux quantization. None exist in the repo today. The theme's "most
chapters per gram" is a promissory note about chapters not yet drafted; the owner should weigh it
as such.

### 1.2 The attack: the inverse is false, and the name must carry that

Compactness forces discreteness; discreteness does not certify compactness. The harmonic
oscillator lives on the full non-compact line and still has the discrete ladder $E_n = 2n+1$ (in
natural units): confinement by a potential quantizes too. SymPy check (n = 0..4, all pass):

```computation
psi_n = hermite(n, x) * exp(-x**2 / 2)
eigen_check = Eq(-diff(psi_n, x, 2) + x**2 * psi_n, (2*n + 1) * psi_n)
```

(The check exhibits the ladder members; that *only* these are normalizable is textbook input, not
verified here.) Hydrogen splits the same way: the angular indices $\ell, m$ are the compact-sphere
half of the theme, the radial $n$ is confinement. So the nameable, true statement is a one-way
implication plus a second route: **"a compact domain or group forces discreteness; so does
confinement; free motion on a non-compact domain is the continuum case."** If the theme is named
without the confinement clause, the first reader who meets the oscillator ladder will apply the
theme backwards and conclude something is compact that is not.

### 1.3 The provable core, closed in Lean

The circle direction, in the owner's own notation ($m$ deliberately real, so the circle does the
forcing):

$$ \big(\forall\theta:\ e^{im(\theta+2\pi)} = e^{im\theta}\big) \iff m\in\mathbb Z \veq{circle-quantizes}\lean $$

The non-compact converse, stated as a theorem instead of a lament: for **every** real $m$, with no
constraint whatsoever, the same plane wave satisfies the eigenvalue equation

$$ \partial_x^2\, e^{imx} = -m^2\, e^{imx}, \qquad m\in\mathbb R\ \text{arbitrary}, \veq{line-no-quantization}\lean $$

each derivative exhibited as a `HasDerivAt` witness (house rule: `deriv` is junk-on-failure). The
eigenvalue family $\{-m^2\}$ is a continuum; that *is* `wirohsh.md:30`. And the same mechanism
under a different boundary condition, the particle in a box with walls at $0$ and $L$:

$$ \sin(k\cdot 0) = 0 \ \wedge\ \sin(kL) = 0 \iff \exists n\in\mathbb Z:\ k = \frac{n\pi}{L} \veq{box-quantizes}\lean $$

Verdict on No. 1: **name it**, with the confinement clause built in. It has the only
machine-checkable core of the six, it explains both the corpus's central derivation and its central
complaint, and two dreamed essays independently landed on it as their spine. Its weakness, stated
plainly: today it is one owner file plus promises.

## 2. Theme No. 4: reversibility is sacred. Theme or slogan?

Where the corpus actually turns on it:

1. **`crypto/fhe.md`, explicit concept, absent word.** The file's organizing classification is
   destructive vs semi-destructive vs bijective (`fhe.md:25-30` table column "destructive";
   `fhe.md:65` "all others destroy information and make it impossible to retrieve the original
   inputs"; `fhe.md:10` bijective iff the output map is a permutation). This is the theme's one
   real owner instance, and it is load-bearing there.
2. **`physics/lasercool.md`, implicit.** Spontaneous emission "in a random direction away"
   (`lasercool.md:37`) is the irreversible step that makes cooling possible at all
   (`lasercool.md:63`, `:79`); the word never appears. The dreamed
   [`lasercool.md`](lasercool.md) essay makes it quantitative: the entropy leaves with the
   scattered photons and the atom's export bandwidth is the whole bottleneck.
3. **`physics/Resogram.md`, implicit.** The damping term $2\beta\dot x$ (`Resogram.md:12`, energy
   "permanently" lost per `:50`) is an effective irreversibility with no bath in sight; the sliding
   average at `:118` even carries an $e^{+2\beta t'}$ kernel that *undoes* the damping inside the
   average, which is the theme acted out without being named.

That is one explicit instance. A theme makes predictions; a slogan is a mood; on today's corpus
"reversibility is sacred" is a **slogan**. What would upgrade it is a sharper phrasing that
generates checkable obligations, for instance: **"irreversibility is always an accounting
statement: every irreversible step must name the degrees of freedom that carried the information
away."** That version predicts the Landauer cost of `fhe.md`'s destructive maps, predicts that
lasercool's cooling rate is bounded by an entropy-export budget (which the dreamed essay computed:
the margin is ~10^3, not folklore's ~10^7), and predicts that Resogram's $\beta$ is a trace-out in
disguise. All three predictions are writable chapters; none is written. Since the note's own Q9
(information wing, now "inflownistration" with 2017 owner provenance) would contain exactly those
chapters, the natural move is to **couple the decisions**: defer naming No. 4 until Q9 is ratified,
and if Q9 lands, let this theme be that wing's spine rather than a book-wide burden.

## 3. What the note missed, and what it under-ranked

**Under-ranked: No. 3, "move the problem, solve, move back", is the corpus's widest motive.**
Owner instances: the Wick rotation itself (`wirohsh.md:34-40`); $E=-\partial_\beta\ln Z_B$ and the
$\frac{d}{dZ_1}$-under-the-log trick (`entropy.md:12`, `:17`); the integrate-then-exponentiate
inversion (`entropy.md:44-48`); the $x\to x\mp y$ substitution that makes Lambert $W$ fire
(`entropy.md:53-59`); the Helmholtz-decomposition detour through potentials
(`acoustics.md:62-79`); trading the trajectory for the energy (`Resogram.md:27`) and the
co-decaying average kernel (`Resogram.md:118`); the radix bijection between functions and
enumerations (`fhe.md:105-110`). Roughly eight instances across five files, more than any other
candidate. Its weakness is bagginess: stated loosely it is just "mathematics", and a theme that
covers everything explains nothing. It earns a name only if stated tightly (transform, exploit a
structure absent in the original coordinates, transform back, and *account for what the round trip
loses*; the last clause is what `wirohsh.md:40` is literally asking).

**Missed: "the complex plane pays rent."** Owner instances: the complex-numbers footnote of
`physics/toesnail.md:79`, which introduces $\mathbb C$ with an explicit promissory note ("many
important properties and benefits ... which we'll learn more about later"); the Wick rotation
(`wirohsh.md:36-38`, one $i$ converts wave to Laplace); the holomorphic split $f^+(z)+f^-(\bar z)$
with the Cauchy-Riemann remark (`wirohsh.md:72-76`); the complexified argument
$a_\phi(x_\phi+iz)$ of the 3D reduction (`wirohsh.md:173`). Plus a corpus row that already carries
the literal name: `docs/se-corpus.md:48` files the owner's 28-vote $e^{ix}$ trig-identity answer
(math.SE a/1297) as a ready-made **"C pays rent" demo** for spine step 2. Four dreamed essays lean
on it (the $z=e^w$ cylinder map, the annulus-strip unwrap, Fresnel as Schwarz reflection, the isotropic
direction of the splats NO-GO). Cost paragraph writes itself: [`spine.md`](spine.md) located the
clash where `toesnail.md:79` says complex numbers cannot be ordered and `:89` then writes
$\braket{\Psi\vert\Psi}>0$ for one; a named C-theme obliges the book to resolve exactly that kind
of debt in the open, which is arguably a feature.

**Tested and rejected as themes:** "analytic, not merely smooth" has one owner instance
(`wirohsh.md:82`) and the [`wirohsh-discontinuities.md`](wirohsh-discontinuities.md) sibling flags
that very line's criterion as wrong (smoothness is not the dividing line, real-analyticity is), so
it is a correction candidate, not a leitmotif. "The same object twice" (BE and FD from one
partition function, `entropy.md:25-38`; Laurent = Matsubara per the wick-entropy sibling) is real
but is No. 5/No. 6 wearing a different coat; folding it in costs nothing.

## 4. Verdict on Q10 (owner to ratify; nothing here is settled)

Recommended naming, in order of prominence, each with its weakness attached:

1. **Compactness forces discreteness (and so does confinement).** Sharpest, provable, explains the
   corpus's central win and central complaint. Weakness: one owner file today; most of its chapters
   are unwritten.
2. **Move the problem, solve, move back, and audit the toll.** Widest actual coverage (5 files).
   Weakness: baggy unless the audit clause is kept; without it the theme degenerates to "we did
   math".
3. **The complex plane pays rent.** The name already exists in `docs/se-corpus.md`, the owner's own
   SE answer is its demo, and step 2 needs it anyway. Weakness: three of four owner instances sit
   in one file, and it must face the ordering clash spine.md located.
4. **Reversibility is sacred: defer, coupled to Q9.** Today a slogan with one explicit instance;
   as the information wing's spine (if Q9/inflownistration is ratified) it becomes a theme with
   three writable predictions. Naming it book-wide now would tax every physics chapter for a motive
   only `crypto/fhe.md` exhibits.
5. **Leave No. 2, No. 5, No. 6 implicit** until the chapters that would exhibit them exist
   (Kuramoto, analogue gravity, the qubit protagonist); revisit at the next theme audit.

**What naming costs, so the recommendation is honest about the downside.** A named theme is an
editorial contract: every chapter must either exhibit it or explain its absence, and the name
becomes load-bearing vocabulary that is expensive to rename once `.mw` tags or cross-references
hang off it (Q10 explicitly floats `.mw`-taggability). There is also an epistemic cost the book's
own essay wing warns about: `essays/Narrativium.md:18` quotes Pratchett on narrativium leading
humans "to focus on facts that fit the story, while ignoring those that don't". Themes are
narrativium for mathematics. The instance-counting discipline of this essay (a claimed instance
needs a file:line receipt, and non-fitting cases get said out loud, as entropy.md's $k$ was) is the
regularizer, and it should travel with whatever themes get named.

## 5. Lean attestation

File: [`docs/dreamed/lean/Themes.lean`](lean/Themes.lean). Theorems, all closed, zero `sorry`:

- `circle_quantizes` (badge `circle-quantizes`): $2\pi$-periodicity of $e^{im\theta}$ iff
  $m\in\mathbb Z$, both directions, via `Complex.exp_eq_one_iff`.
- `planeWave_hasDerivAt`, `line_never_quantizes` (badge `line-no-quantization`): for every real
  $m$, `HasDerivAt` witnesses for $\partial_x e^{imx} = im\,e^{imx}$ and
  $\partial_x^2 e^{imx} = -m^2 e^{imx}$; no hypothesis on $m$.
- `box_quantizes`, `box_modes` (badge `box-quantizes`): $\sin(kL)=0$ (and the trivial wall at 0)
  iff $k=n\pi/L$, via `Real.sin_eq_zero_iff`.

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Themes.lean
```

Exit status 0 on 2026-09-01. The SymPy oscillator check (§1.2) passed for $n=0..4$ under
`uv run --with sympy`.

## 6. Follow-up leads

1. **Theme ratification meeting.** Decidable by a /meeting session over §4's table; the instance
   receipts here are the prep material, and the owner's prune is the decision.
2. **The confinement clause.** Write the box and the oscillator as one facing-page pair and see
   whether the one-way statement survives contact with a lay reader in a single sentence; decidable
   by drafting that section.
3. **Reversibility upgrade gate.** Decidable the moment Q9 (inflownistration wing) is ratified: if
   yes, draft Landauer as the theme's first explicit chapter and re-test whether the slogan has
   become a theme; if no, drop No. 4 from the named set.
4. **The ordering clash.** Whether "C pays rent" can be named hinges on how the owner resolves
   spine.md's `toesnail.md:79` vs `:89` finding; decidable when that located discrepancy is ruled
   on.
5. **`.mw` theme tags.** Whether themes should be machine-greppable (like the D3 marker family) is
   decidable by a cheap pilot: tag the three wirohsh instances of theme No. 1 in a scratch `.mw`
   mirror and check the grep surfaces exactly them.
