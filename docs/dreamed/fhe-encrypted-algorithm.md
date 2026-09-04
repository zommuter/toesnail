---
title: "Dreamed: what an encrypted algorithm is, and which of the three you meant"
permalink: /dreamed/fhe-encrypted-algorithm
---

# Dreamed: what an encrypted algorithm is, and which of the three you meant

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-04 from an owner-picked seed. Nothing here is theory or a correction; nothing moves into
> `crypto/` or the `verify/` machinery without the owner authoring the move. Claims about owner
> content live under [Surfaced for the owner](#6-surfaced-for-the-owner), located, never resolved.

**Seed (owner, this session):** *"the ultimate goal is of course real fully homomorphic encryption
of a more general algorithm, better even an encrypted algorithm."*

**Context.** Sibling essays: [`fhe-toy-enumeration`](fhe-toy-enumeration.md) (the toy half of the
same session's seed) and [`fhe-counting`](fhe-counting.md) (the Lean debts of `crypto/fhe.md`).
This essay's one Lean theorem sharpens the owner's own line at `crypto/fhe.md:8`.

Numbers from [`docs/dreamed/fhe-search/circuit_search.py`](fhe-search/circuit_search.py), run
under `fhe-search/run.sh` (hard cgroup memory cap, no swap, CPU quota -- see `capped.sh`). The NAND costs are
exhaustive minima from breadth-first circuit synthesis, not bounds from a construction.

## 0. Summary

"An encrypted algorithm" names **three different problems** with three different answers, and the
seed's phrasing is compatible with all three. Separating them is this essay's actual content:

| what is hidden, from whom | name | status |
|---|---|---|
| the program, from the **evaluator** who also cannot see the data | private function evaluation | **solved**, and costs a universal circuit: $O(\lvert C\rvert \log \lvert C\rvert)$ |
| the program, from someone who **can run it** on inputs of their choosing | obfuscation | **VBB impossible** (Barak et al. 2001); indistinguishability obfuscation exists but is astronomically slow |
| the server's program, from the **client who decrypts** the result | circuit privacy | solved, by noise flooding; a cost, not a barrier |

The first is what FHE gives almost for free, and it is almost certainly what the seed wants. Two
further findings, both measured rather than asserted:

- **The program-bit floor is exactly $2^n$ and is attained.** `crypto/fhe.md:8` states the
  enumeration length $m2^n$ for a particular encoding; the same count is a *lower bound over all
  encodings*, so the owner's line is optimal and not merely convenient. Proved in Lean.
- **Obliviousness, not cryptography, is the structural tax.** An encrypted algorithm cannot branch
  on its data, so it runs its worst case every time -- before a single bit of encryption is
  priced in. Exhaustively, Euclid's algorithm pays a factor converging to about **2.5**. That the
  factor is *small and bounded* is a fact about Euclid, and the essay's least comfortable finding
  is that for a general program there is no worst case to pad to at all.

## 1. Encrypting the algorithm reduces to encrypting the data

The reduction is old and complete. Encrypt the program $p$ under the client's key alongside the
data $x$, and have the server homomorphically evaluate a **fixed public** universal circuit
$U(p, x)$. The server sees two ciphertexts and one public circuit; it learns neither program nor
data. So *program privacy is not a separate cryptographic problem* -- it is data privacy applied
to a program-shaped input. What remains is the price of $U$.

The first half of that price is zero, and this is where the owner's page already has the answer.
`crypto/fhe.md:8` reads: "there are $O(n,m) = (2^I)^m = 2^{m2^n}$ possible functions from $n$ to
$m$ bits. These functions can be enumerated using $m2^n$ bits." Stated that way it is a fact about
one encoding. It is also a **lower bound over every encoding**, because distinct functions need
distinct programs:

$$ \text{Universal } U \implies 2^{2^n} \le |P| \implies \text{program length} \ge 2^n \text{ bits} \veq{progfloor-dreamed}\lean $$

and the truth table attains it. Verified exhaustively for $n \le 3$:

| $n$ | functions $O(n,1)$ | floor (bits) | multiplexer program (bits) | tight |
|---:|---:|---:|---:|:--:|
| 1 | 4 | 2 | 2 | yes |
| 2 | 16 | 4 | 4 | yes |
| 3 | 256 | 8 | 8 | yes |
| 4 | 65536 | 16 | 16 | yes |

(The last column is verified by exhaustive enumeration for $n \le 3$; the $n = 4$ row is the same
argument, not enumerated.)

**Hiding which function you run costs nothing in program length.** The owner's $m2^n$ is optimal.
The entire cost lives in the circuit that interprets the program, which is section 2.

## 2. The price of the universal circuit

Exhaustive minimal NAND-gate counts, by breadth-first synthesis over all circuits:

| inputs | 0 gates | 1 | 2 | 3 | 4 | 5 | worst |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 2 (16 functions) | 2 | 3 | 5 | 6 | -- | -- | **3** |
| 3 (256 functions) | 3 | 6 | 22 | 99 | 72 | 54 | **5** |

The 2:1 multiplexer costs exactly **3** NAND gates, so a $2^n$-to-1 mux tree costs
$3(2^n - 1)$:

| $n$ | worst single function (exact min) | universal circuit (construction) | ratio |
|---:|---:|---:|---:|
| 2 | 3 | 9 | 3.0 |
| 3 | 5 | 21 | 4.2 |

Read that column as an order of magnitude only: it divides an upper bound by an exact minimum, and
at $n = 2,3$ everything is a constant factor away from everything. The honest statement is the
asymptotic one, and it is not mine: **Valiant (STOC 1976)** gave a universal circuit of size
$O(k \log k)$ for circuits of size $k$, with a $4.75\,k\log k$ construction from 4-way supernodes;
**Lipmaa, Mohassel and Sadeghian (2016)** and **Kiss and Schneider (2016)** improved the constants
and gave the first complete implementations; **Zhao et al. (ASIACRYPT 2019)** improved it further
and proved a lower bound. So the real answer to "what does hiding the program cost" is
**a logarithmic factor**, and it has been known since 1976.

The toy table exists only to show the shape: the overhead is a *factor*, not a barrier. Which
means the interesting cost is somewhere else.

## 3. Obliviousness is the structural tax

Under FHE the evaluator cannot see a loop condition, a branch predicate, or an array index. So
every loop is unrolled to its worst-case trip count, every branch executes both sides with the
result multiplexed, every array access touches every element. This is not a cryptographic overhead
that a better scheme might remove. It follows from the definition:

$$ \text{observation constant} \wedge \text{cost a function of observation} \implies \text{cost constant} \veq{oblivious-dreamed}\lean $$

which is trivial as mathematics and total as a constraint. Exhaustively, over all input pairs of
each bit width, Euclid's algorithm:

| bits | pairs | mean steps | max steps | padding factor |
|---:|---:|---:|---:|---:|
| 4 | 225 | 2.524 | 6 | 2.38 |
| 6 | 3969 | 3.625 | 9 | 2.48 |
| 8 | 65025 | 4.754 | 12 | 2.52 |
| 10 | 1046529 | 5.913 | 15 | 2.54 |

Both columns are linear in the bit width, so the factor converges rather than growing. The
asymptotic constants are $1/\log_2\varphi \approx 1.44$ steps per bit for the worst case
(consecutive Fibonacci inputs) and $12(\ln 2)^2/\pi^2 \approx 0.584$ per bit for the mean (the
Levy-Heilbronn coefficient -- *not* Porter's constant, which is the additive $O(1)$ term
$\approx 1.467$; an earlier draft misattributed it), giving a limit of about $2.47$.
**For Euclid the price of obliviousness is a small constant**, and the table approaches that limit
**from above**: at these widths the worst case is still exactly $1.5$ steps per bit (6, 9, 12, 15)
rather than the asymptotic $1.44$, so the measured ratio overshoots and descends. An earlier draft
said "from below", which its own table contradicts.

That is the good case, and it is good only because Euclid's worst case is known and tight. The
general statement is worse in a way no engineering fixes: for an arbitrary program the trip count
is not computable, so **there is no worst case to pad to**. An encrypted algorithm is therefore
always an encrypted *circuit* of fixed size, which is why the FHE literature speaks of circuits and
never of programs. The seed's "more general algorithm" has a precise ceiling: general up to
choosing a bound, and not one step past it.

## 4. The three problems, kept apart

This is the section I would most want the owner to disagree with, because the distinctions are
routinely blurred in popular accounts and the blur is exactly what makes "encrypted algorithm"
sound simultaneously solved and impossible.

**(a) Private function evaluation.** The evaluator sees neither program nor data. Solved: section
1's reduction plus a universal circuit. This is what an untrusted cloud running your secret model
on your secret data looks like, and it works today at a logarithmic overhead on top of the FHE
overhead.

**(b) Obfuscation.** The evaluator holds the program *in the clear enough to run it on inputs of
its own choosing*, but is meant not to learn what it does. Fundamentally different, because
running it is itself an oracle. **Barak, Goldreich, Impagliazzo, Rudich, Sahai, Vadhan and Yang
(CRYPTO 2001)** proved that virtual black-box obfuscation is **impossible in general**: there are
programs that leak a secret to anyone holding any implementation. The escape they defined in the
same paper, **indistinguishability obfuscation**, is achievable -- **Jain, Lin and Sahai (2020/21)**
built it from well-founded assumptions (LWE, SXDH, LPN, constant-depth PRGs) -- but guarantees
only that obfuscations of two *functionally identical* programs are indistinguishable, and current
constructions are far from practical.

The distinction that matters for the seed: **(a) is cheap and (b) is impossible in the strong
form**, and the difference between them is nothing but who holds the decryption key. If the
evaluator can decrypt, you are in (b) and the news is bad. If it cannot, you are in (a) and there
is no problem beyond cost.

**(c) Circuit privacy.** The *server's* program is hidden from the client who decrypts. FHE does
not give this for free: the noise in the result carries information about the circuit that
produced it. The standard fix is noise flooding (drown the circuit-dependent noise in much larger
random noise) or bootstrapping the result through a fresh key. A cost, not a barrier, and it is
the one of the three that people forget exists.

## 5. What is already known, and what is not

Everything load-bearing above has a citation, and I want that visible rather than buried:

- Universal circuits and their $O(k\log k)$ size: **Valiant 1976**, with the modern line
  Kolesnikov-Schneider 2008, Lipmaa-Mohassel-Sadeghian 2016, Kiss-Schneider 2016, Zhao et al. 2019.
- VBB impossibility and iO: **Barak et al. 2001**; iO from well-founded assumptions,
  **Jain-Lin-Sahai 2020**.
- Obliviousness and access-pattern hiding: **Goldreich-Ostrovsky** oblivious RAM, and the whole
  ORAM line; the FHE-specific version is folklore ("FHE evaluates circuits").
- Circuit privacy by noise flooding: standard since Gentry's thesis.

What I did not find stated as such, and offer as the essay's own small contribution: the **exact
tightness** of the $2^n$ program-bit floor presented as a sharpening of an enumeration count (the
Lean theorem of section 1), and the **three-way taxonomy of section 4 pinned to the single
question of who holds the key**. Both are the kind of thing that is obvious once written and
annoying until it is.

## 6. Surfaced for the owner

Located, evidenced, not resolved. **No finding or verdict here was filed into any ledger.** The
batch carries one neutral pointer (`TODO.md` `id:6646`) that lists these rulings AS PENDING, which
is how it stays visible to `/relay human` without anything being recorded as decided.

1. **`crypto/fhe.md:8` is stronger than it says it is.** The line "These functions can be
   enumerated using $m2^n$ bits" reads as a remark about one encoding. It is optimal: no encoding
   is shorter, because programs must separate functions, and the truth table attains the bound. If
   the page wants that upgrade it is one clause, and the Lean is written
   (`universal_card_lower` + `tt_universal`). Owner's call, and the page may prefer to stay
   descriptive.

2. **A possible framing offer, entirely the owner's to reject.** `crypto/fhe.md` currently runs
   from counting functions to counting bijections to the key-bit criterion at `:14`. Section 4's
   three-way split is the natural next joint if the page ever grows a section on what FHE is *for*
   -- but the page's line of thought is a counting argument, and grafting a taxonomy onto it may
   be exactly wrong. Recorded as an option, not a recommendation.

3. **No discrepancy found.** Unlike the sibling essays in this directory, this one located no
   error in owner content. Stated explicitly so the absence is not read as an omission.

## 7. Lean attestation

**File** [`docs/dreamed/lean/FHEUniversal.lean`](lean/FHEUniversal.lean). **Command**
`cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/FHEUniversal.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in `verify/lake-manifest.json`;
imports are narrow, no `import Mathlib`.

| Claim | Lean names | Status |
|---|---|---|
| $2^n$ inputs, $2^{2^n}$ functions | `card_inputs`, `card_functions` | proved |
| program-bit floor | `Universal`, `universal_card_lower` | proved |
| floor is attained | `tt_universal`, `tt_card` | proved |
| obliviousness forces a constant schedule | `oblivious_cost_constant`, `oblivious_pays_worst_case` | proved |
| a worst case need not exist | `WorstCaseExists` | **definition only, deliberately unproved** |

`WorstCaseExists` is a definition rather than a theorem on purpose: section 3's claim that an
arbitrary program has no computable worst case is a statement about a machine model, and stating
it honestly needs one. Formalising it against Mathlib's Turing machines is lead 3 below, and it is
a real project, not a gap I glossed.

`\veq` badges above attest against this dreamed file only, never against the repo's sidecar
machinery (`docs/dreamed/README.md` rule).

## 8. Follow-up leads

1. **Adopt `universal_card_lower` into `verify/`** (owner-gated, then `[ROUTINE]`): decidable the
   moment the owner rules on surfaced item 1. Signature frozen above; the executor work is a copy
   plus test wiring.
2. **The mux-tree cost as a Lean theorem** (mechanizable, small): that a $2^n$-to-1 multiplexer
   built from 2:1 muxes has $2^n - 1$ of them. Cheap, and it makes section 2's toy column a proved
   upper bound rather than a construction I counted by hand.
3. **Undecidability of the padding bound** (mechanizable, large): `WorstCaseExists` against
   Mathlib's `Turing` machinery, i.e. that no total computable function bounds the running time of
   an arbitrary program. This is the halting problem in a costume and Mathlib has the pieces, but
   it is a project rather than an afternoon.
4. **Whether the page wants any of this** (owner-only, gating): items 1-3 are mine, not the
   page's. Surfaced item 2 is the decision they all hang from.
