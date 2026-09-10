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

## Dreamed-batch located findings (2026-09-07, Bloch Truth cluster, id:c454)

Surfaced by the 2026-09-07 owner-seeded dreaming session (4 essays, `docs/dreamed/README.md`).
Both were **re-verified by the coordinator against the cited source**, not merely reported by an
agent. **Neither was fixed.** Batch pointer: `TODO.md id:c454`. Note these differ from the
`id:8e64` findings above in one way the owner should know: the cited source is NOT a file in this
repo. It is the owner's own idea-pool and chat material, so there is nothing here to edit in
`physics/` -- the ruling needed is whether the reasoning is amended going forward.

- [ ] **"Core layer should only be complete, e.g. ZF without C" does not hold.** Source:
  `~/knowledge/sessions/claude-ai/2025-08-05_breaking_project_paralysis_cbae6cd6.md:1334`, the
  owner's turn of 2025-08-08 07:22 UTC, which is the ORIGIN quote of the "Bloch Truth" project
  and its layered-logic architecture: *"the Bloch Truth (might need a better name) might be useful
  for the AI logic core in the second (ZFC?) layer where incompleteness applies (core layer should
  only be complete, e.g. ZF without C)"*. Dropping the axiom of choice buys no completeness. ZF
  interprets Robinson arithmetic, so Goedel I applies to ZF exactly as it applies to ZFC: ZF is
  incomplete if consistent, and Goedel I never mentions AC. Worse for the premise as a choice of
  core, AC's independence from ZF (Goedel 1938, constructible universe; Cohen 1963, forcing) IS an
  instance of ZF's incompleteness, so the chosen core's most famous undecided sentence is precisely
  the axiom that was dropped to obtain it. **The architecture survives with the boundary redrawn**:
  genuinely complete or decidable theories exist on other grounds (Presburger arithmetic, real
  closed fields, Tarski's elementary geometry, propositional logic), and what they have in common
  is not lacking AC but not interpreting enough arithmetic. Two essays reached this independently
  and file it once: `docs/dreamed/logic-bloch-poles.md` section 7.1 (which also tabulates the
  candidate cores) and `docs/dreamed/logic-qutrit-su3.md` finding 7.
  `docs/dreamed/weltformel-impossibility.md` adds that this is the SAME error shape it audits in
  the Faizal papers: a restriction that touches none of the hypotheses the theorem actually uses.
  The owner accepts, amends or rejects. <!-- id:251e -->
- [ ] **`(2^2)! = 24`, not 12 -- a transient slip, already superseded downstream, filed only for
  completeness.** Source: the owner's claude.ai thread "Invertible Functions Bit Mapping Problem"
  (2025-09-09), his turn: *"But only (2**2)!=12 of them are actually invertible - I wonder if all of
  them can be expressed via the TOFFOLI gate?"*. `2^2 = 4` and `4! = 24`. The likely cause is
  visible in the same sentence, which applies an up-to-inversion halving to the preceding count,
  and 12 is exactly 24 halved. **Low severity and arguably self-resolved**: the owner uses 24
  correctly later in the same thread (`(1/24)^(1/2) = 20%` per bit), so the working value was right
  where it mattered. The 2-bit function census in the same message (16 outputs, 10 real functions,
  5 up to inversion, 256 two-output functions) is correct. See `docs/dreamed/logic-bloch-gates.md`,
  which also answers the trailing question: yes at 2 bits, but uninterestingly, since CNOT and NOT
  alone already generate all 24 (`AGL(2,2) = S_4`, machine-checked); Toffoli only earns its keep at
  3 bits, where 1344 of 40320 are affine. <!-- id:4787 -->

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

## Relay review 2026-09-07 11:42 (window `relay-ckpt-20260907-1107`..HEAD)

- [ ] **43 `docs/dreamed/` pages are PUBLISHED on the public site with ZERO render coverage, and the
  coverage guard is a hardcoded allowlist that can never notice.** Verified, not assumed: every one of
  the 44 files in `docs/dreamed/` carries a `permalink: /dreamed/<slug>` and `_config.yml`'s `exclude:`
  lists only the three `crypto/fhe.*` companions, so the whole tree renders on GH Pages. Meanwhile
  `tests/test_mathjax.cjs` walks a hardcoded 7-entry `DOCS` array (`physics/Resogram|toesnail|entropy|
  wirohsh|photon`, `crypto/fhe`, `essays/supertool`) and `tests/test_page_coverage.sh` only asserts that
  5 named pages appear in that array. Adding a page therefore never trips anything: the guard checks a
  list against itself. The dreamed essays are the math-heaviest prose in the repo (density matrices,
  Bloch decompositions, `\eqref` chains), so a kramdown/MathJax break there is silent and public.
  **This is a disposition question, not a bug to fix, which is why it is here and not in ROADMAP:** the
  tree is UNRATIFIED exploration by design, so gating `make test` on it may be exactly wrong. Three
  options, your call. (a) Leave it: accept that `/dreamed/*` renders unverified. (b) Cover it: extend
  `DOCS` to glob `docs/dreamed/*.md`, which makes the suite fail on an essay nobody has ratified.
  (c) Cover it non-blockingly: a separate advisory tier that reports dreamed render breaks without
  failing `make test`. Note (b) and (c) both also want `test_page_coverage.sh` changed from a name list
  to a directory scan, or the allowlist-checking-itself shape survives whichever you pick. Grew by 4
  pages this window (the Bloch Truth cluster, `id:c454`) and by 32 the week before. **RESOLVED 2026-09-07 (owner ruling: option (c), advisory tier).** Built: `tests/test_dreamed_render.cjs` renders every `docs/dreamed/` page through MathJax AND KaTeX and reports breaks LOUDLY while exiting 0, so an unratified essay can never fail `make test`. `tests/test_page_coverage.sh` rewritten from the 5-name self-checking allowlist to a DIRECTORY SCAN keyed on front-matter `permalink:`, and it additionally asserts no dreamed page has leaked into the blocking array, so option (b) cannot creep back by accident. Macro table extracted to `tests/lib/macros.cjs` so both tiers share one copy instead of creating the drift the existing drift guard exists to catch. Scope split: BLOCKING for `physics/`, `essays/`, `crypto/`, root; ADVISORY for `docs/dreamed/`. The rewritten scan immediately found FOUR ratified pages the old allowlist never noticed were uncovered (`physics/acoustics.md`, `physics/lasercool.md`, `essays/Narrativium.md`, `README.md`); they are now in the blocking array. Proven to fire, not merely asserted: four seeded defects on a scratch page were all reported with page and line, the suite still exited 0, and the scratch was removed. **It found a real six-day-old public break on its first run**: `docs/dreamed/photon-localizability.md` carried two veq handles in one display block, each expanding to a tag, which both engines reject, broken since 2026-09-01. Fixed by the repo's documented two-block split (same shape as `id:3b4c`) and recorded inline. All 68 dreamed pages now scan clean and `tests/run.sh` is `SUITE: PASS`. **VERIFIED INDEPENDENTLY by the 2026-09-07 16:26 relay review, not taken on report:** all 14 blocking tiers plus the advisory tier re-run here green with zero skips; the PRE-rewrite `test_page_coverage.sh` and `test_mathjax.cjs`, restored from `relay-ckpt-20260907-1148`, both still PASS against the new tree, so the rewrite strengthened the spec rather than relaxing it; `gaming-scan.sh` is clean. **The box stays UNTICKED on purpose** — this file's own header defines a ticked box as *"owner confirms this interpretation/correction"*, so the tick is yours and a review may not take it for you. The delivery is verified; only your confirmation is outstanding. <!-- id:8b1c -->

## Relay review 2026-09-07 16:26 (window `relay-ckpt-20260907-1148`..HEAD, 5 commits)

- [ ] **`docs/dreamed/lean/` is 56 Lean files with ZERO automated verification, and this window's
  headline results rest on them.** This is `id:8b1c` one layer over, for proofs instead of rendering,
  and it is stated as a disposition question for exactly the same reason. The facts, measured not
  assumed: `verify/lakefile.toml` declares `defaultTargets = ["Resogram"]` and one `lean_lib`, so no
  dreamed Lean file ever enters `make test`; `CLAUDE.md:50` already records this and says each file is
  "verified ad hoc instead". The ad-hoc record is a sentence in a commit message. **What this review
  did about it, so the gap is sized rather than merely named:** every one of the 56 files was grepped
  for `sorry` (8 hits, all inside comments or docstrings — zero real proof debt), and four files were
  re-elaborated from `verify/` under `capped.sh` — `LogicComplementarity` (the third wave's headline
  `no_logical_complementarity`), `LogicBPI` and `LogicModels` (the two D4 discharges) and
  `LogicBoundary` — all four exit 0 with no diagnostics; `LogicBPI` prints `#print axioms` output
  naming only `propext`, `Classical.choice`, `Quot.sound`, with no `sorryAx`. So the claim is TRUE
  today and was checked, not believed. What is missing is that nothing re-checks it tomorrow: a
  Mathlib bump silently rots 56 published "machine-checked" claims. Your call, and the third option
  is not free. (a) Leave it ad hoc, and accept that the public pages' proof claims decay unnoticed.
  (b) Blocking tier — wrong for the same reason (b) was wrong for rendering: unratified work would
  fail your `make test`. (c) An advisory Lean tier mirroring `test_dreamed_render.cjs`. **Note the
  cost asymmetry that makes (c) a different decision here:** the render tier is source-level and
  costs ~2 s on 68 pages, whereas elaborating 56 Mathlib-importing files is minutes to tens of
  minutes, so (c) probably wants to be opt-in or nightly rather than "always on" — which is a
  genuinely different shape from the ruling you already gave, not a rubber stamp of it.
  **ANSWERED 2026-09-08 (`/relay human`) and DELIVERED 2026-09-08 (`id:0720`).** You ruled a FOURTH
  option rather than (a)/(b)/(c): pinned-good hashes plus a pinned Mathlib/toolchain, with the pin as
  a TRIGGER and not documentation. Shipped: `verify/dreamed_lean_pin.sh` (a pure hash/pin comparison
  that runs with no `lake` on PATH), the baseline `docs/dreamed/lean-pins.json` (56 hashes + toolchain
  `leanprover/lean4:v4.30.0-rc2` + the Mathlib rev from `verify/lake-manifest.json`), the pin restated
  for readers in `docs/dreamed/README.md`, wired into `tests/run.sh`'s BLOCKING tier. Your ruling
  answers this box's cost asymmetry by refusing re-elaboration entirely: a drifted file is REPORTED
  and re-elaborating it stays an ad-hoc `capped.sh` run on the reported subset only. **VERIFIED
  INDEPENDENTLY by the 2026-09-08 18:52 relay review, not taken on report:** all four acceptance
  assertions fire (a mutated `.lean` file and a mutated toolchain pin each drive the checker non-zero
  and name the drifted item), and 15 blocking + 2 advisory tiers re-ran green here with zero skips.
  **The box stays UNTICKED on purpose** — per this file's header a tick is your confirmation, and a
  review may not take it for you. Only that confirmation is outstanding. <!-- id:ef6b -->

- [ ] **A rule and the commit that wrote it contradicted each other, and I narrowed the rule rather
  than leave it.** `tests/README.md` gained the line *"Do not 'fix' a dreamed finding to silence it:
  that content is the owner's, and a finding is surfaced, never edited away"* in commit `8019373` —
  the same commit that repaired `docs/dreamed/photon-localizability.md`. Both acts were right; the
  absolute wording was not. I rewrote that bullet to draw the line the practice actually follows: a
  PURE RENDER repair (block split, blank line) that changes no symbol, number or word and carries an
  inline comment saying what moved is allowed, because leaving a public page broken preserves nothing
  the comment does not; a CONTENT or MATH edit to silence a finding never is. Two things for you.
  First, confirm or move that line — it is a rule about your material and I am proposing, not
  settling, where it sits. Second, the stated JUSTIFICATION may be wrong independently of the rule:
  it says the dreamed content "is the owner's", while `TODO.md id:c454` describes the same tree as
  "AI-generated by four delegated agents, owner-seeded, UNREVIEWED". If the intended sense is "yours
  to rule on" rather than "written by you", the wording invites a future reader to protect AI prose
  as though it were authored material. <!-- id:bcc6 -->

- [ ] **Nine new pages went live on the public site with no `[OWNER]` triage pointer.** `CLAUDE.md`'s
  dreamed convention is explicit: a batch "gets ONE neutral `[OWNER]` triage pointer in `TODO.md` and
  nothing more". The three essay waves each got one (`id:c454`, `id:352a`, `id:e50c`); the nine
  infographics added in `8019373` (`fig-the-object` … `fig-wings-and-corpus`) got none. They are
  indexed in `docs/dreamed/README.md` and covered by the advisory render tier, so they are not
  invisible to tooling — they were invisible to YOUR LEDGER, which is what the convention protects.
  This review added the missing neutral pointer as `TODO.md id:ff4c`; it files no verdict and adopts
  nothing. Flagged here rather than fixed silently because restoring a convention on someone else's
  batch is still a write to your triage queue. <!-- id:a4bc -->

- [ ] **`id:9d8c` carries gate vocabulary but no typed `gated-on:` edge** (`orphan-scan.sh --shipped`
  UNMARKED-GATE, the window's only such finding). The ROADMAP line is the FORWARD-FLAG CI
  Lean/Mathlib build, held by `<!-- owner-hold:local-lake-build-gate-suffices -->`. No typed edge was
  added because the hold is an owner judgement ("the local lake build gate suffices"), not a
  dependency on another item, and `gated-on:` needs a target id — so inventing one would encode a
  dependency that does not exist. Either confirm the hold stands (and the scanner finding is
  permanent noise for this item) or name what would lift it. <!-- id:9d8c -->

## Surfaced by `/relay review` 2026-09-08 (window `relay-ckpt-20260907-1635`..HEAD)

- [ ] **`tests/test_carryback.sh`'s `[REFUSED: …]` marker is a self-granted exemption, and only the
  advisory tier keeps that safe.** The parser checks for `[REFUSED: …]` in the item text BEFORE it
  extracts the target sentence, so a refused item is never compared against its essay at all. Whoever
  edits `docs/dreamed/pascalized.md` can therefore convert any unapplied carry-back from MISSING to
  discharged by writing a reason next to it -- the mechanism cannot distinguish "we decided not to
  carry this back" from "we could not". That is defensible here (the tier always exits 0, so nothing
  is being gated open or shut, and both current refusals were escalated to you as decisions, TODO
  `id:ed2b`), but it stops being defensible the moment anyone proposes making this tier blocking.
  Nothing to fix today; the note exists so the next person who wants to gate on this count knows the
  count is author-controlled.

- [ ] **`id:e562` carries gate vocabulary but no typed `gated-on:` edge** (`orphan-scan --shipped`
  UNMARKED-GATE). The item says the dedicated `/meeting` is deliberately NOT now, which is exactly the
  clause a later sweep would misread as "pick this up when convenient". A typed edge would make the
  not-now machine-visible instead of prose-visible. `id:9d8c` has the same shape and has carried it
  since 2026-07; both are advisory, neither blocks. Your call whether the edge is worth the marker.

- [ ] **This file holds 31 open boxes against its own stated `Max ~10`, and none is ticked.** Not a
  new defect, but it is now 3x the budget and the header calls itself a 15-minute queue, which it
  demonstrably is not. Zero boxes are `[x]`, so `REVIEW_ME.archive.md` cannot drain any of them —
  the queue only shrinks when you tick. Worth one pass deciding which are genuinely still live.

## Relay review 2026-09-08 18:52 (window `relay-ckpt-20260908-1807`..HEAD, 6 commits)

- [x] **The new `id:0720` drift guard is in `make test` but NOT in CI, and CI is where the drift it
  guards would arrive.** Measured, not assumed: `.github/workflows/ci.yml` runs three named tests
  (`tests/test_verify.sh`, `tests/test_render.sh`, `tests/test_mathjax.cjs`) and never calls
  `tests/run.sh`, so `test_dreamed_lean_pin.sh` -- and the nine other blocking tiers -- do not run on
  push or pull_request. `tests/test_ci.sh` only asserts that CI *references* those three, so it passes
  and will keep passing. That subset is deliberate and predates this window, so this is not a
  regression and nothing here is red. The reason it is worth your ruling NOW rather than as generic
  CI debt: your 2026-09-08 ruling framed the whole point of `id:0720` as catching a Mathlib bump that
  would *silently* rot 56 published claims, and the mechanism it uses is a pinned rev in
  `verify/lake-manifest.json`. A bump reaches this tree as a commit -- which is precisely the moment
  CI looks and `make test` may not have been run. As it stands the guard fires only for whoever runs
  the full suite locally before pushing. **Your call**, and the middle option is real: (a) leave it,
  accepting that the guard is a local-discipline guard; (b) have CI run `bash tests/run.sh`, which
  pulls in `test_lean.sh`'s real `lake build` and its cold Mathlib cost into every push -- the cost
  `id:9d8c` is parked on, so this is not free and is arguably a different decision; (c) add just
  `verify/dreamed_lean_pin.sh` as its own CI step, which needs no `lake`, no Ruby and no Node and
  costs about a second -- the cheap half of (b) without the parked cost. Tooling only; no `.lean`
  proof or physics prose is involved. <!-- id:0720 -->

  Owner ruled option (c) on 2026-09-10: `verify/dreamed_lean_pin.sh` is now its own CI step ("Run dreamed_lean_pin drift guard") in `.github/workflows/ci.yml`, after the three existing test steps. It needs no lake, no Ruby and no Node; measured locally at 0.02s. Option (b) was explicitly NOT taken -- `tests/run.sh` stays out of CI, so `test_lean.sh`'s real `lake build` and a cold Mathlib never enter a push, which is the cost `id:9d8c` is parked on. YAML re-parsed after the edit (9 steps) and `tests/test_ci.sh` PASSes. Still unverified on GitHub Actions itself until a push runs.

## Relay review 2026-09-11 (window `relay-ckpt-20260908-1902`..HEAD, 2 commits)


Both commits in this window are owner-authored, so there was no executor work to trust-but-verify.
`gaming-scan.sh` clean; no test or `verify/` file was touched by the window; no `@owner-accepted` or
`@owner-answered` marker was introduced or modified. All 15 blocking test tiers plus the 2 advisory
tiers PASS, `test_lean.sh` included with a real `lake build` (8314 jobs). The two boxes below are
findings from this pass, not executor defects.

- [ ] **The `id:0720` CI step landed with nothing asserting it stays there, and `tests/test_ci.sh`
  PASSing was not evidence that it does.** The owner's own resolution note on the `id:0720` box
  records "`tests/test_ci.sh` PASSes" as part of the verification. Measured: that file asserted
  exactly three references (`test_verify`, `test_render`, `test_mathjax`) and nothing else, so it
  PASSed byte-identically before and after the guard step was added -- it could not have
  distinguished the two states. A later workflow edit could have dropped the step in silence, which
  is the same silent-no-op class the guard itself exists to prevent, one layer up. FIXED in this
  review: `tests/test_ci.sh` now also asserts the workflow references `verify/dreamed_lean_pin.sh`,
  keyed on the SCRIPT PATH rather than the step's display name so relabelling the step does not
  break the test while removing the guard does. Recorded here as a green-from-birth regression guard
  (review.md 2b.3): it pins behaviour the owner ratified on 2026-09-10, so it is pinning a decision
  rather than freezing an accident. Verified by negative control, not by exit status alone -- with
  the step stripped from a scratch copy of `ci.yml` the file fails at exactly the new assertion and
  nowhere earlier. Still true, and unchanged by this: the CI run itself is unverified until a push
  actually exercises GitHub Actions. <!-- id:9772 -->

- [ ] **The stated reason the "Meeting-gated backlog" section exists is no longer true -- and it is a
  claim about tool behaviour, so nothing tested it.** `ROADMAP.md:125` justifies mirroring seven
  `[INPUT - meeting]` TODO items into ROADMAP.md as being "purely so they stop being invisible to
  `/relay human`'s gather, which reads ROADMAP.md + REVIEW_ME.md, not TODO.md". That was true when
  written (2026-07-20). It is false now: `gather-human-backlog.sh` grew a TODO.md human-lane scan
  plus dedup under `id:4e67` (`scan_repo` passes TODO.md to the same helper, script line ~841). Run
  live against toesnail this review, the gather emits `id:c9d4`, `id:e029` and `id:e562` -- all three
  TODO-only, no ROADMAP twin -- so TODO.md is demonstrably reached. The dedup half also works: each
  of the seven mirrored ids appears exactly once in the output, so nothing is double-counted today
  and there is no live breakage. What is stale is the RATIONALE, which is the load-bearing part: the
  section is now seven hand-maintained duplicate lines whose stated justification has lapsed, and a
  reader re-deriving the roadmap from that sentence would keep adding mirrors that buy nothing.
  Whether to retire the mirrors or keep them for a different reason is the owner's call, not a
  reviewer's -- surfaced, not acted on. Note `id:e552` is a genuinely separate case: it is a real
  ROADMAP item under "Human-only", not one of these mirrors. <!-- id:9c03 -->

Two smaller notes, no box needed. (1) `orphan-scan.sh --shipped` reports UNMARKED-GATE for `id:9d8c`
and `id:e562`; `id:9d8c` already has an open box above, and `id:e562`'s gate is the owner's own
"deliberately NOT now" ruling, which has no external dependency to express as a typed `gated-on:`
edge -- the same shape the existing `id:4bb2` box already describes. (2) `ROADMAP.md:190` still
carries the retired venue-keyed `hands` lane tag, still spelled with the old em-dash delimiter. That
is deliberate and documented in commit `10b9ca3`: `lane-convert.sh` never auto-converts `hands`,
because it fragments across four destinations by human judgment. Verified not to be a dispatch
hazard -- `gather-human-backlog.sh` reads that line as `hard_hands`, and reads the newly
ASCII-hyphenated `[INPUT - meeting]` lines as `hard_meeting`, so both spellings resolve.
