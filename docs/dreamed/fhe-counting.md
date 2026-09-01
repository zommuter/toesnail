---
title: "Dreamed: four Lean debts of the FHE page, scoped and (mostly) closed"
permalink: /dreamed/fhe-counting
---

# Dreamed: four Lean debts of the FHE page, scoped and (mostly) closed

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-01 from an owner-picked seed. Nothing here is theory or a correction; nothing moves into
> `crypto/` or the `verify/` machinery without the owner authoring the move. Claims about owner
> content live under [Surfaced for the owner](#4-surfaced-for-the-owner), located, never resolved.

**Seed:** the `\leanc` open-debt badges at `crypto/fhe.md:8` (`ocount`), `:67` (`semidestr`), `:74`
(`bij24`) and `physics/entropy.md:59` (`lambertw`). **Context:** ROADMAP `id:37cc` (each claim
needs its own scoping pass, fidelity-consume + frozen signature, before it can be sized
`[ROUTINE]`), meeting note `docs/meeting-notes/2026-06-21-2129-lean-formalization-strategy.md`
(D2, which created the queue and drafted starting-point signatures), and ROADMAP `id:76e5` (the
located `stirling` finding, independently re-verified below). Corpus rows M-7/M-8 place the FHE
page in the crypto/info wing.

## 0. Summary

Of the five debts `id:37cc` queues, **three are pure counting and are now closed in Lean** with
zero `sorry` (`ocount`, `bij24`, `semidestr`-count, each proved in general and at the concrete
instance the page uses); **one is owner modelling and is deliberately left as a definition plus a
stated, unproved proposition** (`semidestr`-identification); and **one was already scoped by a
sibling essay** (`lambertw`-branch: [`lambertw-statistics.md`](lambertw-statistics.md) found the
bosonic inversion needs the `W_{-1}` branch, Mathlib has no Lambert W at the vendored rev, so its
`Statistics.lean` proves the branch precondition instead. Cited, not redone here). Independently
re-running the `id:76e5` check **confirms** the `stirling` finding: the residual of the claimed
expansion converges to +0.4068 bits and does not shrink with `n`.

## 1. The three counting claims, scoped and closed

Each subsection: the owner's claim verbatim with line number, the precise proposition, the
Mathlib lemma, the frozen signature (as compiled in `lean/FHECounting.lean`), classification.
Notation throughout: `Inputs n := Fin n → Bool` (the `2^n` truth-table rows), `Outputs m := Fin m
→ Bool`.

### 1.1 `ocount` (`crypto/fhe.md:8`) -- pure counting, closed

> "there are $O(n,m)=(2^I)^m = 2^{m2^n}$ possible functions from $n$ to $m$ bits" (with $I=2^n$)

Proposition: $|\{f : \mathbb{B}^n \to \mathbb{B}^m\}| = 2^{m\cdot 2^n}$. Mathlib discharges it
with `Fintype.card_fun` (`Mathlib/Data/Fintype/BigOperators.lean:199` at the vendored rev:
`Fintype.card (α → β) = Fintype.card β ^ Fintype.card α`) applied twice, plus `pow_mul`. Frozen
signature, proved:

$$ O(n,m) = 2^{m\, 2^n} \veq{ocount-dreamed}\lean $$

```
theorem ocount (n m : ℕ) :
    Fintype.card (Inputs n → Outputs m) = 2 ^ (m * 2 ^ n)
```

Instances the page actually uses, each an `example` closed by `rw [ocount]; decide`:
$O(0,1)=2$ (l.19), $O(1,1)=4$ (l.23), $2^{2^2}=16$ (l.41), $2^{2\cdot2^2}=256$ (l.74).
Classification: **pure counting, mechanizable, closed.** No fidelity judgment beyond reading
"function from n to m bits" as a set-theoretic function on truth tables, which l.8's own
enumeration argument already commits to.

### 1.2 `bij24` (`crypto/fhe.md:74`, general form at `:10`) -- pure counting, closed

> "there are $P=(2^n)!$ bijective functions for $n$ bits" (l.10); "the $(2^2)! = 24$ bijective
> functions" (l.74)

Proposition: $|\mathrm{Sym}(\mathbb{B}^n)| = (2^n)!$. For $m=n$, "bijective function" is a
permutation of the $2^n$ inputs, exactly l.10's own phrasing ("the output map is a permutation of
the input map"). Mathlib: `Fintype.card_perm` (`Mathlib/Data/Fintype/Perm.lean:160`,
`Fintype.card (Perm α) = (Fintype.card α)!`). Frozen signatures, proved:

$$ P = (2^n)!\,, \qquad (2^2)! = 24 \veq{bij24-dreamed}\lean $$

```
theorem bij_count (n : ℕ) :
    Fintype.card (Equiv.Perm (Inputs n)) = (2 ^ n)!
theorem bij24 : Fintype.card (Equiv.Perm (Inputs 2)) = 24
theorem perm_fin4 : Fintype.card (Equiv.Perm (Fin 4)) = 24
```

The meeting's D2 rule ("state general-`n`, then instantiate, else `=24` is a tautology") is
honoured: `bij24` is `bij_count` at `n = 2` plus `decide`, and `perm_fin4` gives the same count
over the abstract row indices `Fin 4`. Classification: **pure counting, mechanizable, closed.**

### 1.3 `semidestr`-count (`crypto/fhe.md:67`, weight profile at `:65`) -- pure counting, closed

> "$\binom{2^n}{2^{n-1}}=6$ semi-destructive functions A, B, XOR and inverses" (l.67); "For each
> sum $s$ of truth-outputs per function there are $\binom4s$ functions, i.e. 1,4,6,4,1" (l.65)

Proposition (the count only; the *naming* of these as semi-destructive is section 2): the number
of Boolean functions on a size-$N$ domain taking value 1 exactly $k$ times is $\binom Nk$;
at $N=2^n$, $k=2^{n-1}$ this is the balanced count, and at $n=2$ it is $\binom42=6$. Mathlib has
no single lemma for Boolean functions of fixed weight; the proof composes an explicit equivalence
(weight-$k$ functions $\simeq$ $k$-element subsets, 7 lines) with `Fintype.card_finset_len`
(`Mathlib/Data/Fintype/Powerset.lean:52`), which itself rests on `Finset.card_powersetCard`
(`Nat.choose`). Frozen signatures, proved:

$$ \#\{f : \mathbb{B}^n\to\mathbb{B} \mid \mathrm{wt}(f) = 2^{n-1}\} = \binom{2^n}{2^{n-1}} \veq{semidestr-count-dreamed}\lean $$

```
theorem weight_count (α : Type*) [Fintype α] [DecidableEq α] (k : ℕ) :
    Fintype.card {f : α → Bool // trueCount f = k} = (Fintype.card α).choose k
theorem semidestr_count (n : ℕ) :
    Fintype.card {f : Inputs n → Bool // trueCount f = 2 ^ (n - 1)} =
      (2 ^ n).choose (2 ^ (n - 1))
theorem semidestr6 :
    Fintype.card {f : Inputs 2 → Bool // trueCount f = 2} = 6
```

plus l.65's full profile `binom(4,s) = 1,4,6,4,1` as a `decide` one-liner. One faithfulness
footnote an executor should keep: at `n = 0`, Nat subtraction makes `2^(n-1) = 2^0 = 1`, so
`semidestr_count` degenerates gracefully (`choose 1 1 = 1`) but the owner's claim is evidently
meant for `n ≥ 1`. Classification: **pure counting, mechanizable, closed.**

## 2. The one that is not mechanizable: `semidestr`-identification (`crypto/fhe.md:65`)

> "Only the six balanced functions A, B, XOR and there inverses are 'semi-destructive', i.e. can
> be used as output bit of a bijective function"

This is not a count; it is an **identification** between an informal crypto notion
("semi-destructive": usable as one output bit of a bijection, information recoverable "with just
one other bit") and a combinatorial one (balanced: weight $2^{n-1}$). The meeting already flagged
it as "crypto modelling, owner judgment", and the scoping pass sharpens *why*, because the reason
generalizes well beyond FHE:

**Formalizing an identification does not verify it; it only fixes what it means.** A theorem
`Balanced f ↔ SemiDestructive f` is only as meaningful as the `def SemiDestructive`, and that
`def` is precisely the thing being claimed. The Lean file therefore ships:

```
def SemiDestructive {α : Type*} (f : α → Bool) : Prop :=
  ∃ g : α → Bool, Function.Injective fun x => (f x, g x)
def Balanced {α : Type*} [Fintype α] (f : α → Bool) : Prop :=
  2 * trueCount f = Fintype.card α
def balanced_iff_semiDestructive : Prop :=       -- STATED, NOT PROVED
  ∀ f : Inputs 2 → Bool, Balanced f ↔ SemiDestructive f
```

as a **definition plus a stated proposition, deliberately unproved** (a `def` of type `Prop`, so
no `sorry`). What a proof *would* establish: that balanced coincides with *this particular*
completion property (some companion bit `g` makes `x ↦ (f x, g x)` injective). What it would
**not** establish: that this property is what "semi-destructive" means in the page's argument;
whether the intended notion is existence of *one* completion, of *many*, or a statement about
which completions are cryptographically usable; and whether the `n = 2` phrasing "with just one
other bit" should generalize to `n-1` companion bits at higher `n`. Those are the owner's
modelling calls, and no amount of proof quality substitutes for them. However good the Lean gets,
this item stays `[HARD]` on the modelling half; only *after* the owner ratifies a `def` does the
proof half drop to `[ROUTINE]`.

Two facts worth having on the table for that ratification (checked outside Lean, brute force over
all 16 functions): under the candidate `def`, the equivalence at `n = 2` is **true**, both sides
picking out the same 6 functions, and it is `Decidable`, so the ratified version would close by a
one-word `decide`. And the generalization holds too: with `n-1` companion bits, balanced is
necessary (each fiber of `f` must inject into $2^{n-1}$ codes and the two fibers sum to $2^n$)
and sufficient (split each half-sized fiber bijectively). So the *mathematics* is cheap; the
entire cost of this item is deciding what the words mean, which is exactly why it cannot be
delegated.

## 3. What the counts do in the argument

Honest sizing of what closing these was worth. The load-bearing chain of `crypto/fhe.md` is:
$\Pi_n = \log_2((2^n)!)$ measures the key material a full bijection costs (l.10-12), $\Pi_1 = 1$
identifies the OTP as the break-even (l.14, checks out: $\log_2 2! = 1$ exactly), and
$\frac1n\Pi_n > 1$ for $n \ge 2$ (l.14, checks out: $\frac12\Pi_2 = 2.2925 \approx 2.3$) poses
the page's actual question, how to thin the bijections. In that chain, **`bij24`'s general form
$(2^n)!$ is load-bearing** (it is the argument of the $\log_2$ everything hangs on), while the
$=24$ instance is the worked table's row count. **`ocount` is framing**: $2^{m2^n}$ sizes the
ambient function space the bijections sit inside, and nothing downstream depends on the exact
value. **`semidestr`-count is structural**: the split 16 = 6 balanced + 10 destructive motivates
the thinning strategy, but the page's table already enumerates all 6 by hand, so the formal count
confirms arithmetic the reader can see. Closing all three cost about seven small theorems and is
worth exactly that much: the counting was never where the page's risk lives. The risk lives in
the two places that resisted mechanization, the `stirling` constant (section 4) and the
identification (section 2).

## 4. Surfaced for the owner

**Independent re-verification of the `id:76e5` `stirling` finding: CONFIRMED.** The claim
(`crypto/fhe.md:12`) writes the constant term of $\Pi_n = \log_2((2^n)!)$ as $\ln\sqrt{2\pi}$.
The base-2 Stirling expansion requires $\log_2\sqrt{2\pi} = \ln\sqrt{2\pi}/\ln 2$:

$$ \ln\sqrt{2\pi} = 0.9189385\ldots, \qquad \log_2\sqrt{2\pi} = 1.3257481\ldots, \qquad \Delta = 0.4068095\ldots $$

Symbolically (SymPy): substituting $N = 2^n$ into the asymptotic $\log_2 N! = N\log_2 N -
N\log_2 e + \tfrac12\log_2 N + \log_2\sqrt{2\pi} + \frac{1}{12N\ln 2} + \ldots$ and subtracting
the corrected expansion simplifies to exactly 0. Numerically, exact $\Pi_n$ minus each expansion:

| $n$ | $\Pi_n$ (exact) | residual vs claimed ($\ln\sqrt{2\pi}$) | residual vs corrected ($\log_2\sqrt{2\pi}$) |
|---:|---:|---:|---:|
| 2 | 4.584963 | +0.436804 | +0.029995 |
| 4 | 44.250140 | +0.414323 | +0.007513 |
| 6 | 295.995144 | +0.408688 | +0.001878 |
| 8 | 1683.996287 | +0.407279 | +0.000470 |
| 10 | 8769.006144 | +0.406927 | +0.000117 |
| 12 | 43250.046890 | +0.406839 | +0.000029 |

The claimed expansion's residual converges to $+0.4068095$ bits and **does not shrink with**
$n$; the corrected one halves per step, consistent with the stated $\mathcal O(2^{-n})$
remainder. This matches the `id:76e5` gate text (a ~0.407-bit constant offset) in both magnitude
and sign. Not fixed here; the source line, the badge, and the eventual `verify/fhe_stirling.py`
instrument all stay gated on the owner (`REVIEW_ME` box of 2026-07-02). One adjacent
observation, cheap to fold into the same edit or ignore: l.65 carries two typos ("there
inverses" for "their inverses", "it consist of" for "it consists of"), noted only because the
owner will be editing that region anyway.

**Ratification candidates from this essay** (recommendations, not decisions): (a) adopt the four
frozen signatures of section 1 into `verify/FHE.lean` and flip the three badges
`\leanc → \lean` once the owner confirms the notation mapping; (b) ratify or amend
`SemiDestructive` (section 2), after which the identification closes by `decide`; (c) the
`stirling` fix itself, unchanged from `id:76e5`.

## 5. Lean attestation

**File** `docs/dreamed/lean/FHECounting.lean`. **Command**
`cd verify && nice -n19 lake env lean --threads=2 ../docs/dreamed/lean/FHECounting.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in
`verify/lake-manifest.json`; imports are narrow (`Fintype.BigOperators`, `Fintype.Perm`,
`Fintype.Powerset`), no `import Mathlib`.

| Item | Lean names | Status |
|---|---|---|
| `ocount` | `ocount`, `card_inputs` + 4 instance examples | proved |
| `bij24` | `bij_count`, `bij24`, `perm_fin4` | proved |
| `semidestr`-count | `weight_count`, `weightEquivFinsetLen`, `semidestr_count`, `semidestr6` + weight-profile example | proved |
| `semidestr`-identification | `SemiDestructive`, `Balanced`, `balanced_iff_semiDestructive` | **definition + stated Prop, deliberately unproved** |
| `lambertw`-branch | `docs/dreamed/lean/Statistics.lean` (sibling) | out of scope here |
| `stirling` residual | none | left to SymPy; a faithful Lean bound needs Stirling-series analysis, not counting |

`\veq` badges above attest against this dreamed file only, never against the repo's sidecar
machinery (`docs/dreamed/README.md` rule).

```computation
# stirling re-verification (id:76e5), base-2 Stirling with N = 2**n
Pi = log(factorial(2**n), 2)
claimed   = 2**n * (n - log(E, 2)) + n/2 + log(sqrt(2*pi))
corrected = 2**n * (n - log(E, 2)) + n/2 + log(sqrt(2*pi), 2)
offset = log(sqrt(2*pi), 2) - log(sqrt(2*pi))   # = 0.4068095...
```

## 6. Follow-up leads

1. **Port to `verify/FHE.lean` + badge flips** (owner-gated, then `[ROUTINE]`): decidable once
   the owner ratifies the section-1 notation mapping; the executor work is a copy plus
   `tests/test_lean.sh` wiring, signatures frozen above.
2. **Ratify `SemiDestructive`** (owner-only): decidable the moment he says whether
   "usable as output bit of a bijective function" means the injective-completion property; the
   Lean equivalence then closes by `decide` at `n = 2` and by the fiber argument in general.
3. **General-`n` semi-destructivity with `n-1` companion bits** (mechanizable after lead 2): the
   balanced ⟺ completable fiber argument of section 2 as a Lean theorem; decidable by writing it,
   but pointless before the `def` is ratified.
4. **`fhe_stirling.py` instrument** (owner-gated by `id:76e5`, then `[ROUTINE]`): decidable once
   the owner fixes or ratifies l.12; the symbolic check in section 4 is a working prototype of
   the named-correction-terms instrument the ROADMAP specifies.
5. **Key-bit overhead asymptotics** (owner direction): l.14's $\frac1n\Pi_n > 1$ has the clean
   strengthening $\frac1n\Pi_n \sim \frac{2^n}{n}(n - \log_2 e) \to \infty$, i.e. per-data-bit
   key cost grows essentially like $2^n$; whether the page wants that growth rate stated is a
   narrative call, though the mathematics is SymPy-closable today.
