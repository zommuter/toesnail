# Math-on-demand curriculum — what each spine step must introduce, and no more

**Date:** 2026-07-07 · **Mode:** owner-requested dreaming continuation (afk).
**Status:** AI-emitted **candidate inventory** — a YAGNI-ordered list of the mathematics
each of the 11 roadmap steps genuinely *needs*, what it can loudly defer, and which
existing corpus file exercises it. The owner decides all ordering/inclusion; this is a
planning aid, not chapter content. Companion to `2026-07-07-1228-…` (the skeleton) and
`…-1257-…` (the corpus map). Existing spine prose (`physics/toesnail.md`) already covers
much of step 0–2's list — noted inline.

Legend: **NEEDS** = must be introduced *here* (first use) · **defer** = name it, use it
later (a layered-reading aside candidate, D4) · **corpus** = existing file that
exercises it · *(have)* = the spine's current text already introduces it.

## Step 0 · State, distinguishability, composition
- **NEEDS:** naming/abstraction (`|Ψ⟩` as label) *(have)*; sets & elements (only
  informally); the tensor-composition idea `|A,B⟩ = |A⟩⊗|B⟩` *(have — the |42⟩ split)*;
  equivalence ("same state") as the first *relation*.
- **defer:** what ⊗ *is* algebraically (bilinearity) — until amplitudes exist (step 2).
- **corpus:** toesnail.md §Divide and Conquer.
- **theme seeded:** *name it to tame it* (already the owner's own header).

## Step 1 · Combine/count → monoid → group → numbers
- **NEEDS:** binary operation, associativity, identity (monoid — combining with
  "nothing" = the empty subsystem); inverse ⇒ **group**, motivated physically by
  *reversibility* (undoing a composition/evolution); counting identical copies → ℕ;
  formal inverses → ℤ; ratios → ℚ. **The permutation group S_n** enters *here* as the
  first non-commutative example ("swap two identical subsystems") — it will recur
  (entropy, fhe) so introducing it early pays 3×.
- **defer:** ℝ (needs limits — step 2's continuity demand); abstract group axiom
  lists beyond the two examples in hand (composition, permutation); representation
  theory (step 4).
- **corpus:** fhe.md (bijections = S_{2^n} — reversibility made classical);
  entropy.md (counting occupations).
- **themes seeded:** *reversibility is sacred*; *counting is physics*.

## Step 2 · Interference → ℂ, rays, Hilbert space
- **NEEDS:** ℝ via completion (motivated: probabilities/norms need limits);
  ℂ as length+angle *(have — the footnote)*; linear combination *(have)*; inner
  product + its three axioms *(have)*; norm, unit vector, orthogonality *(have)*;
  **rays** (state = vector up to phase) — the single most consequential NEW item the
  current text hasn't stated yet, since projective-ness drives step 3; Cauchy–Schwarz
  (already a rigor-debt `verify:lean` candidate).
- **defer:** completeness/separability of Hilbert space (name the word, defer the
  topology); why-ℂ-not-ℝ/ℍ (Solèr) — a *layered aside* for the physicist reader;
  dual space formalities beyond the bra *(have informally)*.
- **corpus:** toesnail.md (bra-ket, inner product); wirohsh.md (holomorphy as ℂ's
  hidden power — aside hook).
- ⚠ existing rigor-debt flag stays load-bearing here: eq `t1` uses probabilities as
  coefficients where amplitudes will be needed — the step-2 chapter is exactly where
  the narrative must cash that IOU (owner's call how; flagged in rigor-debt.md).

## Step 3 · Projective reps: spin, and mass from Galilei (Bargmann)
- **NEEDS:** group *action* on states; "representation" as homomorphism-to-operators
  (minimal form); *projective* representation (because rays, step 2); the SU(2)→SO(3)
  double cover (spin-½ from a 2:1 wrapping — the belt trick as the "everyone" visual);
  central extension *only as* "the phase you can't gauge away" (Bargmann's mass).
- **defer:** full cohomology language (H²) — never needed at this altitude; Lie
  algebra formalism (step 4 introduces it properly).
- **corpus:** none yet — this step is the largest *gap* in the corpus; a natural
  future exploration file (owner's if/when).
- **themes:** *rays not vectors*; first payoff of *linearize, then worry* (rotating
  slowly ≈ identity + generator).

## Step 4 · Lie groups/algebras, generators, Noether
- **NEEDS:** one-parameter groups; generator = derivative at identity (**linearize a
  group → its algebra** — the theme, stated once, reused forever); commutator as the
  algebra's product; Stone's theorem in physicist form (continuous symmetry ↔
  self-adjoint generator); Noether: [Q,H]=0 ⇔ conserved; Casimir = the label that
  commutes with everything (distinct role from Q — the 1228-note correction).
- **defer:** matrix Lie group classification (step 7 needs only U(n)/SU(n) named);
  exponential-map subtleties.
- **corpus:** Resogram.md (the oscillator's phase-space flow as the worked
  one-parameter group; energy as its conserved quantity — the *same file* that seeds
  the love wing).

## Step 5 · Spacetime: Galilei → Poincaré; Wigner classification
- **NEEDS:** boosts/rotations/translations as a group; the invariant (interval)
  replacing the invariant (time) — *look for what stays invariant* does the heavy
  lifting; İnönü–Wigner contraction (c→∞) IF Galilei-first (open Q2); little groups;
  the two Casimirs → mass & spin; helicity for m=0.
- **defer:** full induced-representation machinery (Mackey) — sketch the orbit
  picture, defer the proofs; discrete symmetries C/P/T (own aside later).
- **corpus:** lasercool.md (Doppler = the boost acting on the photon — the least
  formal possible first meeting with relativity); photon.md (massless little group —
  with the Q12 Newton–Wigner caution attached).

## Step 6 · Why fields (locality, cluster decomposition)
- **NEEDS:** the *problem statement* (combine relativity + QM + locality); creation/
  annihilation operators — which the reader ALREADY owns if step 1 took the Fock/
  ladder route (D1's "we already knew this" callback); field = spacetime-labelled
  ladder operators; cluster decomposition as "distant experiments don't conspire".
- **defer:** renormalization entirely (honest signpost, not content); path integrals
  (optional aside — Wick rotation hook to wirohsh).
- **corpus:** acoustics.md (a *classical* field theory first: linearized Navier–Stokes
  as the "everyone" reader's first field equation — phonons before photons);
  wirohsh.md (wave-equation solution structure).

## Step 7 · Gauging: U(1) → EM; SU(2), SU(3)
- **NEEDS:** global vs local phase; the derivative that fails to commute with local
  phase → connection A_μ (minimal coupling as *repair*); U(1) compactness ⇒ charge
  quantization (the wirohsh theme's payoff); non-abelian generalization by analogy
  (SU(2), SU(3) named, their algebras only as needed); representation choice =
  matter content `[input]`.
- **defer:** fiber-bundle language (aside for the physicist layer); instantons/θ;
  anomalies (signpost only — but honest, since they *constrain* the matter content).
- **corpus:** photon.md (the U(1) quantum), lasercool.md (photons doing work);
  the 1228-note §4 U(1)-multiplicity discussion belongs to this chapter.

## Step 8 · SSB + Higgs; electroweak mixing
- **NEEDS:** degenerate ground states; order parameter; Goldstone mode (the acoustics
  sandbox cashes in: *the reader has heard a Goldstone boson*); gauge+SSB → massive
  vector (Higgs mechanism, minimal version); Weinberg angle = which U(1) survives.
- **defer:** full electroweak Lagrangian bookkeeping; custodial symmetry.
- **corpus:** acoustics.md (Goldstone), Resogram.md→Kuramoto (the sync transition as
  SSB's classical twin — §1.1 of the dreaming note), lasercool.md (laser threshold,
  same family). Three sandboxes, one mechanism — the strongest recurring-theme demo
  in the whole book plan.

## Step 9 · Ceiling theorems (Coleman–Mandula; SUSY loophole)
- **NEEDS:** only the *statement* + why the assumptions matter; graded algebras in
  one paragraph as the loophole's shape. `[hypothesis]` tag on SUSY.
- **defer:** any proof machinery; superspace.
- **corpus:** none (fine — this is a short, honest chapter by design).

## Step 10 · Gravity as the odd one out
- **NEEDS:** equivalence principle; metric as *effective* description — entered via
  the acoustics analogue (Unruh: sound in flow ≡ field on curved metric), so the
  reader computes on a curved metric *before* GR's postulates; geodesics; Einstein
  equations stated, not derived (`[input]`-honest); why gauging spacetime ≠ gauging
  U(1) (Weinberg–Witten as the guard rail).
- **defer:** tensor-calculus completeness (introduce indices exactly as far as the
  geodesic + one curvature scalar demand); cosmology (own branch someday).
- **corpus:** acoustics.md (analogue metric), wirohsh.md (Wick rotation — Euclidean
  gravity aside at most).

## Step 11 · Emergence wing → ❤️
- **NEEDS:** probability → entropy (entropy.md is *already* the chapter core);
  detailed balance (Einstein 1917 bridge to lasercool); coupled ODEs + phase portrait
  (Resogram → Strogatz); order parameter re-used from step 8 (Kuramoto); payoff
  matrix + iterated games (fhe.md's counting style reappears in strategy spaces);
  Landauer/Shannon (fhe + entropy welded).
- **defer:** neuroscience/psychology formalisms beyond the dynamical-systems frame;
  Friston (tag `[hypothesis]` if touched at all).
- **corpus:** entropy.md, fhe.md, Resogram.md, lasercool.md, Narrativium.md — this
  step is where the corpus is *richest*, which supports the D5 ratification that the
  wing is genuinely writable, not decorative.

## Cross-cutting observations

1. **The corpus gap is step 3** (projective reps/Bargmann) — everything else has at
   least one exercising file. If the owner wants one new exploration file next, the
   spin/double-cover/belt-trick one covers the thinnest ice. `[owner's call]`
2. **The Fock-route decision (Q1) has a long shadow:** step 6's ladder operators are
   either a callback (Fock route) or a new introduction (counting route). The
   curriculum reads noticeably smoother on the Fock route; noted as *evidence* for
   Q1, not a decision.
3. **Each step's "defer" list is the D4 aside inventory** — the layered-reading
   mechanism (`.mw` `{@aside}` kind, needs-note F2) has its content list here.
4. **Rigor-debt forecast per step** (for `.mw`/Lean planning, extends needs-note F3):
   steps 1–4 are Mathlib-friendly (groups, inner-product spaces, Stone); step 5's
   Wigner classification and step 3's Bargmann are the long-lived `\sorry` zones;
   steps 8–10 are mostly `[input]`-tagged prose with *local* verifiable algebra
   (Goldstone counting, Weinberg-angle trig, geodesic examples — SymPy-tier).
