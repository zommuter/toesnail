# 2026-06-16 — Lean formalization of the `edot` derivative step (id:b9bc)

**Started:** 2026-06-16 22:57
**Session:** 530f0d16-4c69-4a45-aacd-0b979423c393
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity), 🔬 Greta (proof-engineering / formal-methods — re-onboarded for the Lean lens; subsumes the prior 0827 "Lennart" formal-methods seat)
**Topic:** Scope the tracked `verify:lean` debt `id:b9bc` — proving the *derivative* step `ė = ẋ(ẍ+ω²x)` (genuine time-derivative of `e=½ẋ²+½ω²x²`) in Mathlib, now that the lake/Mathlib bring-up (id:3317) has landed.

## Surfaced discoveries
- [2026-06-16 zkWhale] A Lean proof of a hand-written *model* certifies the model, not the deployed artifact; its value lives in the model↔artifact fidelity binding, validated against an INDEPENDENT reference. → here: the Lean *statement* of `ė=ẋ(ẍ+ω²x)` is a model of the doc's edot.1 first equality; fidelity to the authored claim is owner-ratified, not self-evident.
- [2026-06-15 toesnail] verify-marker schema: tier-as-assurance-floor (escalatable sympy→lean) + `verified:` attestation keyed on composite srepr-claim-hash × instrument-file-hash; instruments are source, AI surfaces never edits.

## Audit results
- ADVISORY orphan candidate `id:8afc` (tracking line inside 2026-06-16-1421-review-me-backlog-d5.md) — benign, no action.
- ADVISORY cross-ledger drift `id:fed0` TODO:[ ] / ROADMAP:[x] (crypto/ Jekyll-exclusion — done in ROADMAP, unticked in TODO). Unrelated; flag for a `/todo-update` sweep.
- No open GitHub issues/PRs; no GitHub prior art.

## Agenda
1. **Statement & fidelity** — exact Mathlib theorem for edot.1's *first* equality; is the derivative step EOM-free, separable from the proven `edot_first_line` algebra?
2. **Differentiability hypotheses & proof approach** — `ContDiff ℝ 2 x` vs explicit hyps; which Mathlib lemmas.
3. **Dispatch class, DoD & marker/test integration** — `[ROUTINE]` vs `[HARD]`? new handle vs reuse `edot`? how it joins `Resogram.lean` / `test_lean.sh` / the `verified:` marker.

## Facts established (read-only)
- Authored claim (`physics/Resogram.md:30-39`): `e = ½ẋ² + (ω²/2)x²` (handle `e`); chain `ė = ẋ(ẍ+ω²x)` (edot.1) `= ẋ(-2βẋ+ω²y)` (edot.2) `= -2βẋ²+ω²ẋy` (edot.3) `= -4βe+ω²(2βx²+ẋy)` (edot.4).
- `verify/Resogram.lean:38-40` proves only the ALGEBRA edot.1→edot.3 with ẋ, ẍ as **free reals** (`edot_first_line … := by subst eom; ring`). Header explicitly carves the derivative step out as id:b9bc.
- id:3317 (lake project + Mathlib v4.30.0-rc2) is DONE [x]. Gate cleared.
- Derivative step proves `d/dt[½ẋ²+½ω²x²] = ẋẍ + ω²xẋ = ẋ(ẍ+ω²x)` — pure chain rule, **does not reference the EOM**.

## Discussion

### Agenda 1 — Statement & fidelity
- Greta: `b9bc` owes the *first* equality of edot.1 — the genuine time-derivative of `e(t)=½ẋ²+½ω²x²` equals `ẋ(ẍ+ω²x)`. Pure chain rule, **EOM-free**; composes with `edot_first_line` (`deriv e = ẋ(ẍ+ω²x)` [b9bc] then `= -2βẋ²+ω²ẋy` [edot_first_line]).
- Archie: clean statement takes `x : ℝ → ℝ`, no eom/y/β — the lemma that *licenses* writing `ė` as `ẋ(ẍ+ω²x)`.
- Riku: fidelity binding (zkWhale) is owner-ratified — "Mathlib's derivative of this functional IS the doc's overdot" is a modeling choice, not a theorem.
- Petra: distinct claim from `edot_first_line` → own handle `edot_deriv`, own row.

**DP1 (owner): `HasDerivAt` witnesses.** Greta's endorsement — the *more* rigorous option: Mathlib's `deriv` is total junk-on-failure (returns `0` off-domain), so a `deriv`-based statement silently models "non-differentiable ⇒ rate 0", a latent fidelity hole. `HasDerivAt` forces differentiability into *named hypotheses* carrying the witness values — strengthens exactly the binding Riku flagged. Frozen statement:
```
theorem edot_deriv (x v a : ℝ → ℝ) (ω : ℝ) (t : ℝ)
    (hx : HasDerivAt x (v t) t)          -- ẋ = v
    (hv : HasDerivAt v (a t) t)          -- ẍ = a
    : HasDerivAt (fun s => (1/2)*(v s)^2 + (1/2)*ω^2*(x s)^2)
                 (v t * (a t + ω^2 * x t)) t
```
*Rejected:* `deriv`-based (junk-on-failure); fuse-with-`edot_first_line` (conflates two claims).

### Agenda 2 — Proof approach & dispatch class
- Greta: HasDerivAt witnesses *settle* differentiability — no separate `ContDiff` hyp. Proof ≈ `(((hv.pow 2).const_mul (1/2)).add ((hx.pow 2).const_mul (ω^2/2))).congr_deriv (by ring)` (or `convert … using 1; ring`). ~5 lines.
- Archie: 0827's "multi-day" priced the *unscoped* problem; EOM-free reduces it to ~1 session.
- Petra: residual = "make `lake build` discharge this exact theorem, no `sorry`" → `[ROUTINE]`.
- Riku: safe *iff* the spec freezes the signature byte-for-byte; `test_lean.sh`'s `grep -L sorry` fails a sorry-green, and a frozen signature blocks hypothesis-weakening. Conceded the owner-physics worry: freezing the signature here IS owner ratification, so the residual isn't physics judgment.
- Greta: DoD must forbid added hypotheses — "matches pinned signature exactly" covers it.

**DP2 (owner): `[ROUTINE]`, frozen signature — and treat the run as a Sonnet-on-Lean4 pilot.** Re-tag `id:b9bc` `[ROUTINE]`; executor fills only the `by` body; `RELAY_LOG.md` records how Sonnet fared (clean / flailed / handback / sorry-caught) as an n=1 datapoint on ROUTINE-dispatching simple Lean4. (Owner's "observe before preventing / build a logger first" heuristic.)

### Agenda 3 — Marker / rigor-debt attestation
- Archie: second theorem in the same `Resogram.lean` → `test_lean.sh` unchanged.
- Greta: distinct claim, **no SymPy instrument** (SymPy never differentiated `e`) → own marker, lean-only tier.
- Riku: lean-only is a *SymPy-as-gate* datapoint — `edot` = "SymPy ✓ predicted lean-provable", `edot_deriv` = contrasting "SymPy-blind, lean-only".
- Petra: grammar already admits `lean`-only (id:1335) → no CONVENTIONS change.

**DP3 → Amendment:** owner leaned "own lean-only marker, bundled" but redirected: *"consult the .mw decisions on that, including my dislike of HTML comments."*

## Amendment session — marker carrier vs `.mw` brace grammar
`.mw` consult (read-only, `/home/tobias/src/mathematical-writing`):
- `docs/meeting-notes/2026-06-16-1313-typed-link-anchor-fork.md` — owner **verbatim**: *"I am _strongly_ against HTML comments in markdown, and neither should .mw use that."*
- `.mw` adopted a **brace-attribute grammar**: `{#label}` = anchor, `{@type target}` = typed link (`{@impl energy}`, `{@proves theorem}`). The `<!-- verify:... -->` surface is "off the table." Parser capture SHIPPED (`src/mathematical_writing/parser.py`, RED spec `tests/test_parser_anchors.py`); `.mw` adopts toesnail's *semantic tier system* through the brace surface, not HTML comments.
- **Design gap:** the brace grammar covers anchors + *simple* links; toesnail's `verified:` marker carries a **rich payload** (tier-list + `claim=<h8>` + `by=<inst>@<h8>`). That mapping is undesigned — a real question bigger than `b9bc`.

Discussion: Archie — a new HTML comment walks *toward* the surface the owner is leaving; the `.lean` proof is unaffected. Greta — keep `rigor-debt.md` (a table, not a comment) free to record status. Petra — don't design the rich brace surface here (scope blow-up); spin it out. Riku — defer; the pilot stays a *pure Lean* measurement.

**DP-Amendment (owner): option 2 — interim HTML comment now, AND file the brace-attestation question on `.mw`.** `edot_deriv` uses the existing carrier for corpus consistency; the rich-payload→brace design is routed to `.mw`; toesnail's corpus-wide migration is a gated forward-flag.

## Decisions
- **D1 — Statement: `HasDerivAt` witnesses, EOM-free, own handle `edot_deriv`.** Frozen signature (owner-ratified fidelity) per the Agenda-1 code block. Proves edot.1's *first* equality only; velocity/accel are free functions bound by the two `HasDerivAt` hyps (named witnesses, not junk-on-failure `deriv`). *Rejected:* `deriv`-based, fuse-with-`edot_first_line`. *Out of scope:* the EOM (covered by `edot_first_line`).
- **D2 — Dispatch: `[ROUTINE]`, frozen signature; executor run is a Sonnet-on-Lean4 pilot.** Re-tag `id:b9bc` `[ROUTINE]`. Spec freezes the signature verbatim; executor fills only the `by` body (~5-line `HasDerivAt.pow`/`const_mul`/`add`/`congr_deriv`+`ring` chain). Effort revises to ~1 session. `RELAY_LOG.md` self-report = the n=1 pilot datapoint. *Out of scope:* strong-model dispatch; proving it in this Opus session.
- **D3 — Attestation: own lean-only marker, SymPy-blind datapoint, bundled with the proof.** Distinct claim from `edot`, no SymPy instrument → own marker, tier `lean` only (grammar already admits it, id:1335 — **no CONVENTIONS change**). `docs/rigor-debt.md` gets a new `[edot_deriv]` row: lean-attested + **SymPy-blind** (the SymPy-as-gate contrast cell). `tests/test_lean.sh` unchanged. *Out of scope:* sharing `edot`'s `verified:sympy+lean` marker.
- **D4 (Amendment) — Marker carrier: interim HTML comment, brace design filed on `.mw`.** Per `.mw`'s "no HTML comments" ruling, `edot_deriv` uses the existing `<!-- verify:lean [edot_deriv] -->` → `<!-- verified:lean [edot_deriv] claim=<h8> by=Resogram.lean@<h8> -->` carrier NOW for corpus consistency. The rich-payload→brace mapping is **routed to `.mw`**. toesnail's corpus-wide marker migration off HTML comments is a forward-flag **GATED** on that `.mw` design landing. *Out of scope this session:* designing the brace surface; migrating existing markers.

## Action items
- [ ] (id:b9bc, re-tagged `[ROUTINE]`) Prove `edot_deriv` in `verify/Resogram.lean` against the D1 frozen signature (`by` body only); add the `<!-- verify:lean [edot_deriv] -->` → `verified:lean` HTML-comment marker near edot.1 in `physics/Resogram.md`; add the lean-only / SymPy-blind `[edot_deriv]` row to `docs/rigor-debt.md`. **DoD:** `cd verify && lake build` exit 0; `verify/Resogram.lean` contains `edot_deriv` with the **exact D1 signature** (no added/weakened hyps); `grep -L sorry verify/Resogram.lean` clean; `bash tests/run.sh` passes. **Pilot:** `RELAY_LOG.md` self-report captures the Sonnet-Lean4 datapoint. <!-- id:b9bc -->
- [ ] → routed to `mathematical-writing` inbox: design the brace-attribute surface for the rich `verified:` attestation payload (tier-list + `claim=<h8>` + `by=<inst>@<h8>[,…]`), extending the `{#anchor}`/`{@type target}` grammar; toesnail's marker migration depends on it. <!-- routed:e4df -->
- [ ] (GATED — forward-flag) Migrate toesnail's `<!-- verify/verified -->` HTML-comment markers to the `.mw` brace-attribute surface. **Gate:** the routed `.mw` brace-attestation design (routed:e4df) landing. Not executor work until then. <!-- id:a9d2 -->

## Effort estimate
Pure design meeting (~1.5s budget class). The dispatched `edot_deriv` proof unit revises from 0827's "multi-day" to ~1 session against the existing lake project.
