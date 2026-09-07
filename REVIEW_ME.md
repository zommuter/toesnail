# Human review queue <!-- budget: 15 min -->

Judgment calls for the owner — **theory decisions the AI surfaced but must never make.**
A ticked box = "owner confirms this interpretation/correction"; to correct one, edit the
cited source (or leave a note under the item) and the next review re-derives. Resolved via
`/relay human` or `/meeting`. Max ~10 open boxes.

> These are owner-ratified by design (the no-AI-vibe-thinking-the-theory constraint). A
> `.mw`/collAIb tool may later *pre-fill a suggested fix* for a sufficiently-clear item,
> but a human still accepts it — the suggestion is a draft, not a merge.

## Spun out of the owner's `236fa1b` edits (tooling / render — AI-eligible)

- [ ] **Wishlist: automated subequation dot-numbering** — derive `(edot.1)…(edot.4)` handles from a parent
  handle so per-line tags render (amsmath `subequations`/`align` style), letting the owner cite individual
  derivation steps. The owner currently has them commented out (`%\ltag{edot.N}`). Nice-to-have (owner, sugar):
  re-align the `=` signs of `(e)` and `(edot)` across the now-split blocks — the two-`$$` split (render fix
  id:3b4c) aligns each block independently; owner notes `.mw` may make this moot. (Handle drift is RESOLVED by
  the split: `\ltag{e}` on the energy block, `\ltag{edot}` on the ė-chain's outer block re-attaches the
  `[edot]` marker.) Relates to ROADMAP R2/R3 (id:445e) and `.mw`. <!-- id:d2f4 -->
  — **DEFERRED pending `.mw` (owner, /relay human 2026-06-16).** Disposition decided: do NOT
    schedule pool work now; the `.mw` motivating example may make per-line subequation numbering
    moot. Box stays OPEN as a tracked wishlist; revisit only after `.mw` lands (then either build
    or drop). Not "build now", not dropped.

## Entropy `lambertw` — D1 marker split (owner places markers)

- [ ] **Place the `lambertw` D1 marker split in `physics/entropy.md`** (/meeting id:3d2a D1, 2026-06-21;
  surfaced 2026-07-01 relay review). The meeting split the single `\veq{lambertw}\leanc` (l.59): the ALGEBRA
  steps (the l.53–57 inversion chain) are SymPy-provable → give them their own handle + `\sympyc` open-debt
  badge; the closed-form W line (l.59) is the *definition* of W → re-badge `\definition` (its W-branch/domain
  caveat stays Lean-queued, id:37cc). Marker placement is the owner's act (the D4 carve-out lets tooling touch
  only the badge ARG), which is why the 2026-07-01 handoff deliberately left this OUT of ROADMAP id:7306.
  Once the split markers land, the `verify/entropy_lambertw.py` instrument becomes `[ROUTINE]` (gated
  ROADMAP id:5d31); the next `/relay review` re-derives it.

## SE self-answer q/669175 — owner posts (Q16, 2026-07-08 SE-mining session)

- [ ] **Post (or discard) the q/669175 self-answer — draft ready, owner-external action.**
  The 2026-07-08 deep dive (`docs/meeting-notes/2026-07-08-1056-se-corpus-mining-and-lasercool-deepdive.md`
  §3) settled the physics: strong form second-law-forbidden (laser-mode entropy ≈ 0, Ruan PRB 75,
  214304), weak form established twice (radiation-balanced lasers; cavity cooling κ-replaces-Γ).
  AI-drafted answer: `docs/drafts/q669175-answer-draft.md` — the owner edits/adopts the voice and
  posts; it is a draft, never a merge. **Optional first step:** expert-check the draft's two
  "open" claims (net-cooling a *running* laser below ambient; the closed two-laser loop budget)
  with **Denis Seletskiy** — contact path via Alfred Leitenstorfer (they co-author: ref 47 of the
  Nat. Rev. Phys. **7**, 149 (2025) Expert Recommendation, in `private/`). Q13–Q15 from the same
  session are already ratified (note §5b); this box is the lone open Q16. Ticking = posted or
  deliberately discarded (note which).
  — DECIDED 2026-07-13 (relay human): EXPERT-CHECK the two 'open' claims (net-cooling a running laser below ambient; the cited caveat) BEFORE posting. Do not post as-is; do not discard. This is a "you run these" human action.

## Visual / manual (run these — never auto-ticked)

- [ ] `@manual` **Colour re-walk (id:c7d6 RUN half landed 2026-07-11).** The tier badges now
  render Option C colours (`\sorry` grey `#6b7280`, `\sympy`/`\sympyc` blue `#2563eb`, `\numeric`
  amber `#b45309`, `\lean`/`\leanc` green `#15803d`, `\sympylean`/`\sympyleanc` deep-green `#14532d`)
  in BOTH engines — machine-verified present in the rendered output (`test_mathjax.cjs`), but the
  *visual* last mile (real browser + VS Code KaTeX preview: hues legible, colour-blind separation
  as designed, glyph still primary on the actual site background) needs an owner eyeball. Re-walk
  `tests/HUMAN-integration.md` and tick when the colours look right (or note a correction).
  Optional doc nicety: `CONVENTIONS.md` line 57 lists the badge *glyphs* but not the new colours —
  add a one-line "each tier also carries a reinforcement colour (see `docs/palette-preview/`)" if
  the owner wants the convention doc to mention it (glyph line stays accurate as-is; not blocking).
  Note (2026-07-11 review): the machine half of this concern is now covered — ROADMAP/TODO id:0030
  landed a byte-for-byte drift guard asserting every badge macro in `_includes/custom-head.html` AND
  `.vscode/settings.json` matches the `test_mathjax.cjs` mirror (verified genuinely green + fires on a
  dropped `\textcolor`). Only the *visual* last mile above remains for the owner.

## Dreamed-batch located findings (2026-09-01, `docs/dreamed/`, id:8e64)

Surfaced by the 2026-09-01 owner-seeded dreaming session (32 essays, `docs/dreamed/README.md`).
Each line below was **verified by the coordinator against the cited source line**, not merely
reported by an agent. Every one is a located finding in OWNER content: the AI emits, the owner
decides. **None was fixed.** Batch pointer: `TODO.md id:2460`.

- [ ] **`physics/wirohsh.md:82` -- "In smooth regions those are perfectly sufficient" is false as written.**
  The dividing line for being the restriction of a holomorphic function is **analytic**, not smooth.
  A `C^infinity` bump with compact support is on the WRONG side (no nonzero analytic function has
  compact support), while `1/(1+x^2)` is on the right side despite also being merely smooth. Measured
  coefficient growth `|c_m|^(1/m)` at m = 10/20/40/80/160: Poisson kernel 0.500 flat, `C^infinity` bump
  0.545 -> 0.883, square pulse 0.705 -> 0.962. Suggested replacement offered in
  `docs/dreamed/wirohsh-discontinuities.md`; the owner accepts, edits or rejects. <!-- id:8777 -->
- [ ] **`physics/toesnail.md:79` vs `:89` -- an internal ordering clash.** l.79 tells the reader complex
  numbers cannot be ordered; l.89 then writes `positive-definiteness` as `<Psi|Psi> > 0` for one. One
  line fixes it, and that line is the missing demand for the conjugate-symmetry axiom the file already
  states. Reappears in Lean as a typing obligation (`0 < re <Psi,Psi>`). See `docs/dreamed/spine.md`.
- [ ] **`physics/toesnail.md:105` -- Cauchy-Schwarz equality case is the REAL one.** "parallel or
  anti-parallel" is the real-vector-space condition (`c = +/-1`); over the `C` the file admitted at l.71,
  equality holds iff the vectors are linearly dependent, `|Phi> = c|Psi>` with `|c| = 1`, the whole unit
  circle. Counterexample `|Phi> = i|Psi>`. Proved both directions in `docs/dreamed/lean/Spine.lean`.
  Note this correction and the **rays** concept are the same content, so it doubles as a demand-driven
  on-ramp to rays.
- [ ] **`physics/toesnail.md:59` -- `t1` uses probabilities where amplitudes are needed.**
  `|tossed coin> ~ p|heads> + (1-p)|tails>` has coefficients summing to 1, not their squares. A unitary
  preserves `sum |c|^2`, so `t1`'s coefficients can arise from a `U(t)` only if `p = 0` or `p = 1`. The
  `\propto` softens it, but `## Transition` is where the amplitudes-vs-probabilities debt stops being
  deferrable. See `docs/dreamed/time-and-operators.md` (finding T3).
- [ ] **`physics/entropy.md:59` -- the `lambertw` step needs a branch qualifier.** Bosonic case: correct
  only on **`W_{-1}`**. Read with the principal branch (the default in SymPy, mpmath, SciPy, Mathematica
  and Maple) it returns `beta*E_1 = 0` identically, because `-beta*E` is its own principal pre-image. At
  `beta*E_1 = 0.1`: `W_0` gives 1.8e-25, `W_{-1}` gives 0.100000. Fermionic case stays real but is
  genuinely TWO-VALUED, with existence exactly saturated at `y_max = W_0(1/e) = 0.27846454...`. No sign
  error: the `-/+` pairing audits clean. Relates `id:37cc`, `id:5d31`. See
  `docs/dreamed/lambertw-statistics.md`.
- [ ] **`physics/Resogram.md:118` -- the `ebar` kernel sign.** Printed as `e^{+2*beta*t'}`. Substituting
  the file's own `esol` and integrating, the OPPOSITE sign gives exactly `C*omega*e^{-2*beta*t}` with
  every ripple term cancelling; the printed sign leaves a `cos(2*Omega*t - delta + 2*phi)` residual
  (29.3x larger at Q=8, 19.3x at Q=20). SymPy-, numerically- and Lean-verified
  (`ebar_minus_exact`, `beta` unconstrained). **There is a reading on which the printed form is right**
  (define `ebar` at the window start), so this is genuinely the owner's call. The dreamed library
  defaults to `-1` and exposes `ebar_sign=+1`. The three already-known Resogram discrepancies all check
  out as written; nothing reopens them. <!-- id:93f5 -->
- [ ] **`physics/acoustics.md` -- the adiabatic assumption is never stated, and the wave equation is
  never derived.** The definition `c^2/gamma := nRT/m` is the ISOTHERMAL ideal-gas law whose *naming*
  presupposes `c^2 = gamma*p/rho` (Laplace); the assumption is load-bearing and unstated, and nothing in
  the file confirms this `c` is the propagation speed. Newton 290.1 vs Laplace 343.2 m/s at 20 C.
  Also: the permalink is spelled `Accoustics` (URL-breaking to change, so a deliberate trade-off), a
  dangling `d_t omega` line, and a "conservation of perpendicular momentum" label naming a
  mass-conservation consequence. See `docs/dreamed/acoustics.md`.
- [ ] **`essays/Narrativium.md:18` and `:22` -- the co-author is Ian Stewart, not "I. Steward".**
  Twice, so it is a stored error rather than a slip. Also `:24` "for to guys bumping fists" reads as
  "two". `:11` "incessable" is surfaced but explicitly NOT called an error, since the same paragraph
  deliberately coins Gossipium/Fictionium/Rantium. See `docs/dreamed/narrativium-formalized.md`.
- [ ] **`physics/wirohsh.md` notation snags (four from round 1, three more from round 2).**
  Round 1: stray `]` at L97, `\partial_\varphi` vs `\partial_\varphi^2` at L58, `d^3e` at L88, a
  load-bearing `\partial_\phi` collision at L154. Round 2: L78's `z = x - ct` contradicts the `(Wick)`
  line at L38 taken literally, and `f^\pm` is overloaded at L70 (radial `r^{\pm m}`) vs L74 (the `z`/`zbar`
  split). Cosmetic individually; L154 and L78 are not.
- [ ] **`physics/photon.md` -- the Gaussian ansatz does not solve the wave equation, and the per-index
  width breaks covariance.** SymPy: with the spatial-positive exponent, `box A/A = (c^2t^2 - x^2 +
  2*sigma^2)/sigma^4` in 1+1 and `(c^2t^2 - r^2 + 4*sigma^2)/sigma^4` in 3+1 (coordinator re-derived by
  hand and in SymPy). Since the file writes `box A_mu = J_mu` this may be the intended answer rather than
  an error, but it is not stated and a reader will assume a free field. Separately, an alpha-dependent
  `sigma_alpha` makes the ansatz's form frame-dependent; covariance collapses it to `A_mu = a_mu Phi(x)`.
  His `\partial^\beta A_\alpha` line is CORRECT; only a suppressed `nu` index snags. Q12 recommendation
  (a one-line epistemic-status aside rather than a caution section or silence) in
  `docs/dreamed/photon-localizability.md`. <!-- id:25a0 -->

### Recommendations awaiting ratification (NOT decided)

These are agent RECOMMENDATIONS. A delegated agent's verdict is never self-settling, so none is
recorded as chosen. Full argument + weaknesses in each essay.

- [ ] **`id:ff32` (T-matrix / Gaussian-splat / WiRoHSH): recommended NO-GO**, now on five independent
  grounds (four in `wirohsh-splats.md`, a fifth in `wirohsh-approximation.md`: a nonzero analytic
  function has no compact support, so the basis can never localize, and a clipped splat is by
  construction in the forbidden class). One gated salvage was left open, and
  `docs/dreamed/loderite-lodelore.md` reports that its gating condition is one loderite's renderer does
  not and will not meet. Suggested disposition: close as NO-GO, mark the salvage dormant. **Owner's.**
- [ ] **Q2 (Galilei vs Poincare): recommended hybrid C1**, on a decisive asymmetry proved in Lean (the
  Galilei boost-translation cocycle is not a coboundary, the Poincare one is), plus corpus evidence.
  Two caveats the essay states itself: that is **1+1**, where `dim H^2(Poincare) = 1` not 0; and the
  recommendation REVISES the 2026-07-07-1228 note's recorded "Galilei-first or hybrid" finding, which
  is flagged as a revision rather than dressed as a first opinion. **Owner's.**
- [ ] **Q9 (information wing): recommended ratify, membership corrected.** Coheres around `log W`, not
  the word "entropy". IN: `entropy.md`, Landauer+Shannon, `fhe.md`'s counting half, M-5 as a ceiling
  theorem. OUT: FHE proper, and corpus row **M-7** (Euler for non-coprime `a` has zero entropy content
  and is currently misfiled under the crypto/info wing). **Owner's.**
- [ ] **Q10 (methodology themes): recommended ranking overturns the note's own.** "Move the problem,
  solve, move back" has ~8 owner instances across 5 files and was under-ranked by the note that proposed
  it; "compactness => discreteness" has 3, all in `wirohsh.md`, and `entropy.md`'s discrete `k` honestly
  does not fit; "reversibility is sacred" is a **slogan**, not a theme (`grep 'revers'` over `physics/
  essays/ crypto/` returns zero hits). A missed candidate, "the complex plane pays rent", is already
  named at `docs/se-corpus.md:48`. **Owner's.**
- [ ] **Q11 (love-wing arc): recommended adopt with three amendments** -- merge stages 1+2 (same
  theorem), insert a "method, not model" hinge before Kuramoto, and demote Gottman from terminus to a
  labelled `[empirical fit]` appendix (inverting the note's ending). **Owner's.**
- [ ] **Q12 (photon caution flag): recommended middle option**, one `[aside: prereq]` epistemic-status
  line at the ansatz rather than a caution section or silence. Its stated weakness: it defers rather
  than settles, and the moment the file moves from `A_mu` to a one-photon state the flag should be
  accepted in full. The trigger is the WORD "photon", not the Gaussian. **Owner's.**
- [ ] **Q6/Q7/Q8 (editorial apparatus): recommended Q6 EXTENDS the existing `\definition`/`\assumption`
  kinds** rather than inventing a family -- `custom-head.html`'s own kind-macro comment ("full kind
  taxonomy is a later /meeting", `id:8ddc`) IS Q6, and `TODO id:57e2` does not cross-reference it. The
  status axis is orthogonal to the tier ladder (25 = 5x5, proved). Cross-file `\eqref` renders a literal
  `(???)` with a dead href, SILENTLY, which argues for deciding **Q8 first**. **Owner's.**
- [ ] **Five-level laser cooler: recommended NO-GO at theorem strength.** Inversion and cooling are
  mutually exclusive at any pump strength (exact SymPy on the full 5x5; 200000-sample Monte Carlo gave
  12825 inverted samples and ZERO while cooling), because Scovil-Schulz-DuBois generalizes verbatim and
  makes lasing-while-cooling require `T/T_p < 0`. As a FLUORESCENCE cooler it works but is dominated by
  plain Yb-type anti-Stokes. One salvage flagged: radiation-balanced operation with octave-split
  stepwise pumping. **Owner's.** See `docs/dreamed/five-level-laser.md`.
- [ ] **collAIb's `verify:`-assist role: recommended close as not-taken.** collAIb is dormant (0.0.0,
  last commit 2026-07-20, last FEATURE commit 2026-07-13) while the two-tier commit hook shipped. The
  essay states its own weakness: dormancy may be attention elsewhere, and the ratified revisit tripwire
  was *liveness*, which a post-commit hook can never provide. Also note the hook that "won" is itself
  broken (see `ROADMAP id:ac7b`). **Owner's.** See `docs/dreamed/mw-collaib-triad.md`.
- [ ] **A candidate result worth a decision: the Wien-4 power optimum.** There is NO COP-optimal
  `h*nu/k_B*T` (flux positivity alone gives `COP <= T_c/(T_h-T_c)`, monotone, supremum on the boundary),
  which is why the literature never states one. But optimising cooling POWER with the `nu^3` wall gives
  `h*nu - mu = [4 + W_0(-4*e^-4)]*k_B*T_c = 3.920690395 k_B T_c`, the **Wien displacement equation with
  exponent 4** (Wien's frequency law is the exponent-3 member, the wavelength law exponent-5). 12.23 um
  at 300 K. Coordinator independently reproduced the root two ways to 15 digits. Originality verdict is
  CALIBRATED as "could not find it stated", NOT "original": arXiv:2504.05013 states the content
  numerically per material; absent is the dimensionless closed form and the Wien identification.
  **Owner decides whether this is worth writing up.** See `docs/dreamed/photon-energy-scaling.md`.

## Relay review 2026-09-07 (window `relay-ckpt-20260717-1835`..HEAD, 33 commits)

- [ ] **`ROADMAP id:9d8c` — the 2026-07-19 "typed `gated-on:` edge added" tick was FALSE; the marker
  parsed to nothing, and I have replaced it with `owner-hold:` on my own judgment. Confirm or correct.**
  The written marker was `<!-- gated-on: id5776-local-lake-build-gate -->`. `lib-typed-edges.sh`'s
  extractor is `(?<=<!-- gated-on:)[0-9a-f,]+(?= -->)`, so the space after the colon AND the non-4-hex
  payload both miss — the edge was invisible to every consumer, while the REVIEW_ME box above it was
  ticked `[x] DONE`. `gated-on:5776` would ALSO have been wrong: id:5776 is `[x]` closed
  (`ROADMAP.archive.md:137`), so a dependency edge on it resolves as CLEARED and would unpark an item
  you deliberately parked. The gate as written is a CONDITION ("warranted only if the local `lake build`
  gate proves insufficient"), which is what `owner-hold:` (id:d119) exists to express. **This is a
  semantics change to a gate you parked, so it is yours to ratify** — say whether `owner-hold` is the
  intent, or name what should clear the gate. Located 2026-09-07 by `orphan-scan --shipped` +
  reading the extractor, not by taking the tick at face value.
- [ ] **`ROADMAP id:4bb2` — UNMARKED-GATE with no expressible typed edge.** The line reads "BLOCKED on
  routed:c196", a CROSS-REPO token. `lib-typed-edges.sh`'s `gated-on:` grammar takes local 4-hex ids
  only, so there is no marker that can express this blocker and `orphan-scan --shipped` will report it
  UNMARKED-GATE forever. Options: leave it and accept the standing report, add an `owner-hold:` with a
  reason, or ask `.mw`/dotclaude-skills for a cross-repo edge grammar. **Your call**; I changed nothing.
- [ ] **`ROADMAP.md` carried the same `md-merge` stacked-body damage that `584e93e` repaired in
  `TODO.md` — REPAIRED here, but the generator is still live.** `bcecee6` filed `id:ac7b`, `id:17ee`
  and `id:3381` via `md-merge update-ids`; all three head lines landed at the top of
  `## Gated forward-flags — NOT yet executor work` with ALL THREE bodies stacked under `id:3381`. Net
  effect: `ac7b` and `17ee` had no acceptance criteria at all, and `roadmap-lint` rejected all three as
  `PARKED-POOL-LANE` (a pool-executable `[ROUTINE]` under a parked heading, i.e. never dispatchable —
  the `id:d35a` class). They sat that way from 2026-09-01 to 2026-09-07. Moved to their own
  `### Dreamed-batch tooling findings` section with each body re-attached; no text changed, added or
  dropped. **This is the THIRD occurrence** (`id:6646`, `id:2460`, now ROADMAP), so it is a tool defect,
  not three slips: `update-ids` replaces the id-tagged LINE but neither moves nor replaces its
  continuation lines. **Already tracked upstream as `dotclaude-skills id:4f0f`** ("`md-merge.py
  update-ids` cannot reach a WRAPPED item's continuation lines at all"), so nothing new was filed. One
  half may not be covered there and is worth checking when 4f0f is worked: 4f0f is about EDITING an
  existing wrapped item, whereas this incident was INSERTING three new ones, where the failure was
  PLACEMENT — all three head lines landed under a heading whose semantics silently disqualified them.

## Relay review 2026-09-07 10:48 (chain-end, window `relay-ckpt-20260907-1027`..HEAD)

- [ ] **`docs/dependencies.md`: the new `dotclaude-skills → toesnail` edge was ranked strong on three
  legs, one of which is FALSE. I corrected the false leg inline; the STRENGTH re-rank is yours.**
  `id:3381` (closed today) justified **strong** by: (1) the relay executes/reviews this repo's ROADMAP
  items, (2) "its git hooks (relay-aware commit-hook design, id:d8bf) gate toesnail's commit workflow",
  (3) shared ledger helpers are the intended substrate. Leg (2) is wrong twice over, verified not
  assumed: `id:d8bf` is a **toesnail** id whose meeting note is
  `docs/meeting-notes/2026-06-16-0635-relay-aware-commit-hook.md` **in this repo**, and the hook it
  produced is this repo's own `hooks/post-commit`; and this repo sets `core.hooksPath=hooks`, which
  means dotclaude-skills' global hooks (privacy pre-push gate, lane-vocab pre-commit) **do not run here
  at all** — `relay-doctor` classifies the shadowing as DELIBERATE, an owner call. So the map, whose own
  filing reason was derived-doc drift, was itself asserting a dependency that does not exist and
  crediting another repo with an artifact this one owns. Corrected in both the node bullet and the edge
  row this pass; leg (3) says "intended", which is honest. **What is left for you:** leg (1) alone is
  genuinely process-blocking, so I LEFT the strength at **strong** rather than re-ranking on my own
  judgment — but it is now a one-legged **strong**, and `docs/dependencies.md` says the map is reviewed
  at the parked `id:921b` scoping session. Re-rank it there, or say now whether one leg carries strong.
