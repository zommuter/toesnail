# Authoring conventions

This repo is the **north-star use-case** of [`mathematical-writing` (`.mw`)](../mathematical-writing/) —
a future literate format that keeps prose, computation, and machine-checked proofs *mutually consistent*.
toesnail is authored **now**, in plain Jekyll markdown, as independently of `.mw` as possible — but using a
few conventions so that an eventual `.mw` migration is mechanical. Every convention here pays off **even if
`.mw` never ships**; anything that only helps `.mw` is deliberately *not* here (it's `.mw`'s job).

## 1. Stable equation handles

Every referenceable equation gets a stable, human-readable id; prose cites it rather than repeating it.
As of the Resogram pilot (2026-06-15) `\ltag` is a single macro defined **centrally, per renderer** — there
is no in-document macro block (MathJax rejects in-document `\gdef`: it errors on the `#` parameter char, and
KaTeX vs MathJax can't share one cross-block definition). Used as:

```latex
$$ ... \ltag{t1} $$      % tags the display equation `t1` (+ \label on the site)
... as shown in $\eqref{t1}$ ...   % prose reference to it
```

Where it's defined:

| renderer | used by | definition | `\eqref{id}` result |
|---|---|---|---|
| **MathJax 3** | the live GitHub-Pages site | `_includes/custom-head.html` → `macros: { ltag: ['\\tag{#1}\\label{#1}', 1] }` | **clickable** ref (built-in AMS `\eqref` + the `\label`) |
| **KaTeX** | VS Code Markdown preview | `.vscode/settings.json` → `markdown.math.macros` (`\ltag`→`\tag{#1}`, `\eqref`→`(\text{#1})`) | plain `(id)` text (KaTeX has no `\label`) |

- `\ltag{id}` renders `id` as the equation's tag (and, on the site, registers a `\label` so `\eqref` links).
- Ids are **content-meaningful and stable** (`eom`, `edot`, `conjugate-symmetry`), never positional —
  reflowing the document must not change them.
- **Display vs inline:** handles need a *display* equation (`$$ … $$`); `\tag` does not apply to inline
  `$ … $` math. Handle **where a claim is marked** (see §2); unmarked equations are not tagged on spec.
- **Why per-renderer, not in-document:** a single in-document `\gdef` block looked tempting (KaTeX honours it)
  but **MathJax errors on it**, and `\def` doesn't persist across separate `$$` blocks in either engine — so
  the only thing that works in both is each engine's native macro registry. Verified with `mathjax-full` +
  `katex` under Node (see `tests/test_mathjax.cjs`).
- **`.mw` value:** a handle *is* `.mw`'s typed-handle / DAG-node concept in embryo; migration reuses the id.

> The site renders math with MathJax 3 (not KaTeX — the earlier claim of "KaTeX macros at the top of
> `README.md`" was found false during the pilot; no such macros existed). `_includes/custom-head.html` carries
> the MathJax 3 config (delimiters, `tags:'ams'`), and `_config.yml` sets `kramdown: { math_engine: null }`
> so kramdown leaves the `$`/`$$` delimiters for MathJax to typeset.

## 2. Tier-tagged rigor-debt markers

Where a derivation is hand-waved, asserted-without-proof, or "I'm too lazy to check", tag the equation with
a `\veq{h}\tier` badge — the handle and the verification badge render TOGETHER inside the right-aligned tag:

```latex
$$ <claim> \veq{h}\sorry $$      % open debt — "to be checked"; greppable sentinel
$$ <claim> \veq{h}\sympy  $$     % algebraic identity / formula equivalence (SymPy)
$$ <claim> \veq{h}\numeric $$    % a claimed evaluation (integral value, limit, constant)
$$ <claim> \veq{h}\lean   $$     % a theorem / structural / type-level statement (Lean4)
$$ <claim> \veq{h}\sympylean $$  % attested by both SymPy and Lean
```

Badge glyphs: `\sorry`→? `\sympy`→∘ `\numeric`→△ `\lean`→✓ `\sympylean`→✓✓.
Use `\veqs{h}\tier` (unnumbered variant) inside `aligned` blocks where `\tag` is inappropriate.
Default open-debt state: `\veq{h}\sorry` (NOT `\sympy*` — the `\tier*` open-debt notation is still
unresolved, see `id:feb8`).

- The tier names match `.mw`'s three verifier tiers (SymPy / CrossHair / Lean4+Mathlib) so the marker
  pre-sorts the work.
- **Tier = assurance *floor*, not a claim-type label.** `\veq{h}\sympy` means "discharge with **at least**
  SymPy." The tiers partition by assurance strength × cost (SymPy = fast heuristic CAS verdict; Lean =
  kernel-checked certainty), not by the kind of claim — so an algebraic `\sympy` claim may legitimately be
  escalated to a Lean proof. Escalation adds a tier; never silently downgrade.
- **The badge arg is tooling-maintained; the equation/claim is human-only.** The owner authors only the
  handle + equation; the tool runs instruments, attests, and syncs the badge arg (`\sorry`→`\sympy`→
  `\sympylean`). The claim inside `\veq{…}` stays human-only theory — the D4 carve-out.
- **Handle is the join key.** `\eqref{h}` resolves cleanly; the badge does NOT leak into the label. The
  instrument and sidecar reference the same handle.
- **Standalone value:** `grep -rn '\\veq' .` is your live rigor-debt list (`\sorry` = open). `.mw` value:
  each `\veq{h}\tier` badge lowers to a `{#h}{@verify tier}` Fragment with handle + tier intact.

### `verified:` attestation — sidecar

Once a claim is discharged, the sidecar (`physics/<stem>.toml`, keyed by handle) records the attestation —
a machine-readable signature of *what* was checked and *by what*, never the result:

```toml
[edot]
tier_floor = "sympy"
tiers      = ["sympy", "lean"]          # achieved tiers; must contain the in-prose badge's tier
claim      = "b575864e"                 # sha256(srepr(<canonical sympy claim>))[:8]
by         = ["resogram_edot.py@54710d91", "Resogram.lean@<h8>"]
```

`tiers` ∈ superset of {`sympy`, `numeric`, `lean`, `sympy+lean`} — a list that grows with escalation; the
`claim=` hash stays byte-identical across tiers (pinned to the owner-stated claim, not to the instrument).

- **Composite key (Nix-derivation style):** `claim` is the first 8 hex of `sha256(srepr(<canonical sympy
  claim>))` — hashing SymPy's `srepr` of the *sympified* claim, so cosmetic LaTeX edits don't false-trigger
  but a genuine change of statement does. The `@<filehash8>` suffix in each `by` entry is
  `sha256sum <instrument> | cut -c1-8`. Either the claim **or** an instrument changing invalidates the entry.
- **Guard:** sidecar handles ⊆ source `\veq` handles — a sidecar entry with no matching `\veq{h}` in the
  source is a dangling attestation error (caught by `tests/test_verify.sh`).
- **Lifecycle:** `\veq{h}\sorry` (open debt) → instrument run → sidecar updated → badge synced to
  `\veq{h}\sympy` (etc.) → auto-stale on hash mismatch.
- A located discrepancy (✗) keeps its `\sorry` badge; it is **not** attested. The finding is written to
  `docs/rigor-debt.md`, and the source math is left untouched for the owner to resolve.
- An **automated** source-walking staleness checker (recompute both hashes, flag drift) is deliberately
  deferred until a second consumer exists (acoustics, pilot #2 — `TODO.md` id `04bb`); the grammar above is
  fixed now so that checker is mechanical to add. Recompute by hand meanwhile — see `verify/README.md`.

## 3. Source stays plain

Diff-friendly markdown only. Markers are HTML comments. **Never paste computed results inline as ground
truth** — the source is authoritative; any computed/proof output is regenerable and disposable. (This mirrors
`.mw`'s non-negotiable: source authoritative, cache disposable, no embedded outputs / JSON envelope.)

**Carve-out for `verified:` attestations (§2):** an attestation is a *signature / provenance record*, not a
result. Tier + handle + the two hashes (`claim=…`, `by=…@…`) are allowed inline because they identify *that*
a check ran and *over what* — they are not the check's output. The actual **value** it produced (`c = 0`,
`✓`, an integral's value) stays forbidden inline; it lives only in the regenerable instrument verdict.

## Working contract (AI assistance)

The **direction is the owner's** — the AI does **not** invent physics, choose which topics to pursue, or
decide narrative direction. The AI's license is narrow and it operates **per `verify:` marker**:

- `verify:sympy`/`verify:numeric` → return **✓ with the check** or **✗ with the located discrepancy**.
- `verify:lean` → return a **discharged proof** of the owner-stated claim, or a `sorry`-scaffold showing
  what remains.
- It **emits findings; it never edits the theory.** A wrong derivation is *located and surfaced*, not
  silently "fixed". The owner decides every resolution.

(The exception the owner carves out for "AI may think": Lean4-style formal proofs of claims the owner has
already stated — never inventing the claim.)

## Tree

- `README.md` (root, `permalink: /`) — project portal / site landing page (navigation, not content).
- `physics/toesnail.md` (`permalink: /toesnail`) — the TOESNAIL spine: QM-from-scratch "math on demand" TOE narrative.
- `physics/` — topic explorations: `lasercool.md`, `acoustics.md`, `Resogram.md`.
- `essays/` — non-mathematical wing: `Narrativium.md`.
- Permalinks are explicit in each file's front-matter, so file location is independent of public URL.

See `docs/meeting-notes/` for the design-decision records behind these conventions.
