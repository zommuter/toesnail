# 2026-06-16 — Two-tier relay-aware commit-hook (id:d8bf)

**Started:** 2026-06-16 06:35
**Session:** ed7fc8ad-f87a-4133-9f3d-51823ed2f3c6
**Attendees:** 🏗️ Archie (architect), 😈 Riku (devil's advocate), ✂️ Petra (productivity), 🔩 Gil (git plumbing / worktree isolation — new), 🔭 Otto (observability / observe-before-preventing — new), ⚙️ Sage (Claude Code runtime / subscription-scope — onboarded at decision C)
**Topic:** Should toesnail build a relay-aware commit-hook running a HARD (`.mw` DAG staleness) and/or SOFT (collAIb LLM observer) detector on the commit diff, emitting findings into REVIEW_ME / `🚧` callouts?

## Surfaced discoveries
None auto-surfaced (no `EMBED_ENDPOINT`). Grounding doc: `docs/dependencies.md` §"Current tool-capability map & the two-tier detection proposal (2026-06-15)".

## Agenda
1. Warrant: build now or observe-first (N=1)? If build, minimal shape?
2. Trigger: pre-commit vs post-commit vs post-merge.
3. Relay-awareness: skip pool/executor worktree commits without false-gating owner commits.
4. Tier scope for v1: HARD / SOFT / both; the `.mw`-mirror double-entry cost vs waiting for an importer.
5. Route `.mw` `id:b7b1` (dangling-symbol detection) to the SOFT tier?
6. (raised mid-meeting) `git notes` carrier; squash semantics; note lifecycle; loose-note recovery; `/relay human` seam; tighter `.mw`/collAIb coupling.

## Discussion

### A — Warrant + trigger
🔭 Otto opened on the owner's own *observe-before-preventing* heuristic: this episode is **N=1**, so the honest minimal artifact is a *reporter*, not a *gate*. 🏗️ Archie: the proposal already concedes "the hook is partly its own logger" (`dependencies.md:144`) — resolve the tension by making v1 **report-only**. 😈 Riku: report-only forbids the commit-blocking path, so the trigger cannot be a blocking pre-commit (every SOFT-tier LLM false positive would fail a commit). 🔩 Gil: pre-commit is also mechanically wrong for diff analysis (staged index, no SHA anchor, partial-staging mismatch); **post-commit** has stable `HEAD`/`HEAD~1` anchors and an exit code git *ignores* — so it physically cannot block (the report-only guarantee enforced by git). Post-merge is wrong granularity (batches a branch, the relay-integrator path we want to skip). ✂️ Petra cut scope: v1 = post-commit, report-only, single repo, owner commits only.

### B — `git notes` carrier (owner reframe)
Owner proposed `git notes` instead of the hook *committing* findings. 🔩 Gil: notes dissolve the pain — no second commit, no re-trigger (adding a note doesn't fire `post-commit`), worktree-safe (`refs/notes/*` live in the common git dir, shared across worktrees), anchored to the exact SHA. 🔭 Otto: the note *is* a better logger than a flat file (`git log --notes`). 😈 Riku named three sharp edges (not pushed by default; lost on rewrite; invisible unless a tool reads them). 🏗️ Archie resolved them with a **two-artifact split**: note = ephemeral local detector signal (lossy-on-rebase OK, not the system of record); **REVIEW_ME box = durable record minted by a human/strong-model step**, preserving no-AI-vibe-thinking-the-theory. 🔩 Gil: use a dedicated `refs/notes/verify` ref. ✂️ Petra: relay-awareness shrinks to "run on owner commits only; no-op in relay context" — the hook never fights the integrator because it touches no tree.

### C — Tier→runtime split (the load-bearing point)
Owner raised the subscription-ToS issue. ⚙️ Sage: the two tiers have different runtime needs — **HARD** (`.mw` DAG) is deterministic, no LLM, belongs in the hook; **SOFT** (LLM) cannot drive the Claude Code subscription from a headless hook (ToS), so in a hook it'd need local Ollama or paid API — *but* `/relay review` is already an interactive Claude Code session, so **inside it Claude Code itself is the SOFT-tier LLM** (no ToS, no infra, strongest model). 🏗️ Archie: `/relay review` also catch-up-sweeps un-noted commits → the hook is a best-effort accelerant, not a single point of failure. 😈 Riku pinned the invariant: **the hook must NEVER call an LLM**. 🔩 Gil answered rebase-survival: `notes.rewriteRef = refs/notes/verify` copies notes across rebase/amend; orphaned notes linger until gc and are re-derivable anyway. b7b1 dangling-symbol routes to the SOFT tier (relieves `.mw`).

### D — Squash semantics + note lifecycle
🔩 Gil: squash is governed by `notes.rewriteMode`; the default `overwrite` silently drops all-but-last note — set **`concatenate`**. 🏗️ Archie flagged the owner's "delete the note" idea as a trap: deletion destroys the observe-first log. Instead append-in-place: `pending` → `processed verdict:valid|noise review_me:id:XXXX` (triple duty: cross-link, observe-first metric, idempotency key). 😈 Riku: `verdict:noise` mints no box but still marks processed so false positives don't nag forever. ✂️ Petra: minimal three-state lifecycle, no separate state file, `verify`-branch deferred.

### E — Loose-note sweep + `/relay human` seam
🔩 Gil: `/relay review` runs three passes — on-branch un-noted commits, on-branch `pending` notes, and **loose/off-branch notes** (`git merge-base --is-ancestor` non-zero) recovered before gc. 😈 Riku: a gc-pruned commit loses the note *object* but the *finding* is re-derivable — document honestly. 🏗️ Archie corrected verdict ownership: `/relay review` only detects + drafts (state `triaged`, NO verdict); **`/relay human` is where the OWNER rules `valid|noise`** (state `processed`) — machine never judges real-vs-noise. ✂️ Petra: `triaged` is the existing review→human seam, not new machinery.

### F — Coupling tightness (weak-edge guard)
🏗️ Archie: v1's loose coupling (`.mw`-as-library, Claude-Code-as-SOFT-LLM) is correct per `dependencies.md` "keep toesnail's outgoing edges weak". 😈 Riku made it an enforced invariant: hook **degrades gracefully** if `.mw` is unavailable (HARD tier no-ops, commit still succeeds) — never a commit gate. ✂️ Petra: the tighter integrations are the already-parked items (`.mw` importer retires the mirror double-entry; b7b1-relief; note↔DAG convergence; collAIb live tier + note-schema read) — **routed cross-repo findings, none committed**. 🏗️ Archie: tightening gated on the verdict-log + `.mw` importer landing (a concrete third revisit-tripwire trigger).

## Decisions

- **D1 — Build now, report-only, post-commit.** Non-blocking `post-commit` detector that emits findings, never blocks, never edits content — itself the observe-first logger. Post-commit's exit code is ignored by git ⇒ cannot block. Pre-commit (blocking, no SHA anchor) and post-merge (wrong granularity) rejected. *Out of scope:* blocking commits, auto-editing content, live pre-save detection, CI.
- **D2 — `git notes` carrier + two-artifact split + slim relay-awareness.** Ephemeral, local-only `git notes` on dedicated `refs/notes/verify` = detector signal + logger; not pushed; lossy-on-rebase OK (not system of record). Durable record stays `REVIEW_ME.md`, minted by a human/strong-model step. Detector runs on **owner commits only**, no-ops in relay context (`RELAY_SKIP` authoritative; `/worktrees/` path fallback). *Out of scope:* pushing notes; `verify`-branch (deferred upgrade path).
- **D3 — Tier→runtime split.** HARD (`.mw` deterministic DAG) → post-commit hook; **hook NEVER calls an LLM** (invariant). SOFT (LLM, incl. dangling-symbol) → `/relay review` where Claude Code is the model (no ToS, no infra). `/relay review` catch-up-sweeps un-noted commits. `notes.rewriteRef = refs/notes/verify`. b7b1 → SOFT tier. *Out of scope:* collAIb-local-LLM-at-commit-time.
- **D4 — Squash + lifecycle.** `notes.rewriteMode = concatenate` (default `overwrite` drops merged notes). Append-only note states, **never deleted**: `pending` (hook) → `triaged` (/relay review) → `processed verdict:valid|noise review_me:id:XXXX`. *Out of scope:* deletion-on-process; separate state file.
- **D5 — 3-pass review sweep + `/relay human` owns the verdict.** Passes: on-branch un-noted → detect; on-branch `pending` → triage; loose/off-branch (`merge-base --is-ancestor`) → recover before gc. `/relay review` detects + drafts (state `triaged`, no verdict); `/relay human` owner-rules `valid|noise` (state `processed`) via `**re**`. Honest caveat: gc-pruned note object lost, finding re-derivable. *Out of scope:* machine-written verdicts.
- **D6 — Coupling LOOSE in v1.** `.mw`-as-library with graceful degradation (HARD tier no-ops if `.mw` unavailable, commit succeeds); `.mw`/collAIb optional accelerants, NEVER a commit gate; collAIb absent from v1. Tighter integrations = routed cross-repo findings, none committed; tightening gated on verdict-log + `.mw` importer. *Out of scope:* committing to an `.mw` importer dependency now; collAIb live tier in v1.

## Action items

**toesnail (TOOLING — executor-eligible; verify-harness mechanics, not theory):**
- [ ] Implement v1 `post-commit` hook: deterministic HARD tier (`.mw` DAG library over a one-section Resogram `.mw` mirror) → `git notes --ref=refs/notes/verify append` `status:pending`; relay-context no-op (`RELAY_SKIP` authoritative + `/worktrees/` path fallback); graceful-degrade when `.mw` unavailable; **NEVER calls an LLM**. Contract: test asserts a `pending` note on an owner commit, and NO note + commit-success in a relay worktree / `.mw`-absent run. (2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:8757 -->
- [ ] Git config setup (documented in `CLAUDE.md`): `notes.rewriteRef = refs/notes/verify` + `notes.rewriteMode = concatenate`. Contract: test squashes two noted commits, asserts both findings survive. (2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:d5f9 -->
- [ ] Stand up the one-section Resogram `.mw` mirror the HARD tier reads (realizes deferred `id:04bb` via `.mw` DAG-as-library; mirror ONE section only — N=2 guard). Contract: editing `esol` flags its `$e$` citation + downstream average stale; unrelated `y` untouched. (2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:0e63 -->
- [ ] Tests for the hook: pending-note-on-owner-commit, relay-worktree no-op, graceful-degrade-without-`.mw`, concatenate-on-squash, loose-note detection via `merge-base --is-ancestor`. (2026-06-16-0635-relay-aware-commit-hook.md) <!-- id:211c -->

**Routed cross-repo (not toesnail's ledger):**
- [ ] `/relay review` gains the 3-pass notes sweep (on-branch un-noted detection + SOFT/LLM pass incl. b7b1 dangling-symbol + loose/off-branch recovery), drafts REVIEW_ME box + `🚧` callout, marks note `status:triaged`; reads/writes `refs/notes/verify`. → routed to dotclaude-skills inbox <!-- routed:6cc0 -->
- [ ] `/relay human` gains the owner verdict transition — surface `triaged` notes, owner rules `valid|noise` via `**re**`, append `status:processed verdict:… review_me:id:…` to the note (never deletes). → routed to dotclaude-skills inbox <!-- routed:f42b -->
- [ ] `.mw` findings — (a) b7b1 dangling-symbol can route to toesnail's SOFT tier, so `.mw` need NOT solve it deterministically (unblocks merge); (b) a Markdown importer would retire the one-section mirror double-entry; (c) note-state `pending/triaged/processed` ↔ DAG `PENDING/PROVEN/STALE` convergence. → routed to mathematical-writing inbox <!-- routed:f50b -->
- [ ] collAIb finding — deferred SOFT-at-commit-time / pre-save *live* tier is collAIb's home (PWA + local model + file-I/O, ~2–3 day build, parked runtime-Q); nearer-term sibling touch = collAIb *reads* `refs/notes/verify` + REVIEW_ME schema for side-panel (needs file-I/O it lacks). → routed to collaib inbox <!-- routed:05f4 -->

**Parent:** id:d8bf — design resolved by this meeting; decomposed into the toesnail items above + the routed findings.
