# Authoring conventions

This repo is the **north-star use-case** of [`mathematical-writing` (`.mw`)](../mathematical-writing/) —
a future literate format that keeps prose, computation, and machine-checked proofs *mutually consistent*.
toesnail is authored **now**, in plain Jekyll markdown, as independently of `.mw` as possible — but using a
few conventions so that an eventual `.mw` migration is mechanical. Every convention here pays off **even if
`.mw` never ships**; anything that only helps `.mw` is deliberately *not* here (it's `.mw`'s job).

## 1. Stable equation handles

Every referenceable equation gets a stable, human-readable id; prose cites it rather than repeating it.
We already do this with the KaTeX macros defined at the top of `README.md`:

```latex
$$ ... \ltag{t1} $$      % tag + (future) anchor on equation t1
... as shown in $\eqref{t1}$ ...   % prose reference to it
```

- Ids are **content-meaningful and stable** (`t1`, `conjugate-symmetry`, `rho.0`), never positional —
  reflowing the document must not change them.
- **Standalone value:** cross-references work in the rendered Jekyll site today.
- **`.mw` value:** a handle *is* `.mw`'s typed-handle / DAG-node concept in embryo; migration reuses the id.

## 2. Tier-tagged rigor-debt markers

Where a derivation is hand-waved, asserted-without-proof, or "I'm too lazy to check", leave a **greppable
HTML-comment marker** tagged with the verification *tier* that would discharge it:

```html
<!-- verify:sympy   <claim> -->     algebraic identity / formula equivalence / manipulation correctness
<!-- verify:numeric <claim> -->     a claimed evaluation (integral value, limit, constant like "c=0?")
<!-- verify:lean    <claim> -->     a theorem / structural / type-level statement needing a proof
```

- The tier names match `.mw`'s three verifier tiers (SymPy / CrossHair / Lean4+Mathlib) so the marker
  pre-sorts the work, but a marker is **just a structured TODO** — it carries no `.mw`-specific syntax that
  `.mw` could later redefine.
- **Standalone value:** `grep -rn 'verify:' .` is your live rigor-debt list. `.mw` value: each marker lifts
  directly into a verification fragment of that tier.

## 3. Source stays plain

Diff-friendly markdown only. Markers are HTML comments. **Never paste computed results inline as ground
truth** — the source is authoritative; any computed/proof output is regenerable and disposable. (This mirrors
`.mw`'s non-negotiable: source authoritative, cache disposable, no embedded outputs / JSON envelope.)

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

- `README.md` (root, `permalink: /`) — the TOESNAIL spine: QM-from-scratch "math on demand" TOE narrative.
- `physics/` — topic explorations: `lasercool.md`, `acoustics.md`, `Resogram.md`.
- `essays/` — non-mathematical wing: `Narrativium.md`.
- Permalinks are explicit in each file's front-matter, so file location is independent of public URL.

See `docs/meeting-notes/` for the design-decision records behind these conventions.
