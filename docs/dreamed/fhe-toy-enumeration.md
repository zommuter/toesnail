---
title: "Dreamed: a toy FHE with two operations, by exhaustive search"
permalink: /dreamed/fhe-toy-enumeration
---

# Dreamed: a toy FHE with two operations, by exhaustive search

> **STATUS: DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). Written by an AI agent on
> 2026-09-04 from an owner-picked seed. Nothing here is theory or a correction; nothing moves into
> `crypto/` or the `verify/` machinery without the owner authoring the move. Claims about owner
> content live under [Surfaced for the owner](#7-surfaced-for-the-owner), located, never resolved.

**Seed (owner, this session):** *"brute-force enumerating all possible binary operations
systematically in order to find at least a toy-model FHE that permits at least two independent
operations (e.g. plus and multiply, but even XOR and NOR or similar) on 'encrypted' (toy model,
thus quotes) data."*

**Context.** `crypto/fhe.md:14` poses the owner's own version of this: the one-time pad costs
$\Pi_1 = 1$ key bit per data bit and is secure, $\frac1n\Pi_n > 1$ for all $n \ge 2$, "so the
question is how to sensibly reduce the amount of bijective functions such that there are no
excessive keybits used". The sibling essay [`fhe-counting`](fhe-counting.md) closed the counting
debts of that page. This essay asks what the *second operation* costs in the same currency.

Everything numerical below comes from
[`docs/dreamed/fhe-search/fhe_search.py`](fhe-search/fhe_search.py), run under
`fhe-search/run.sh` (hard cgroup memory cap, no swap, CPU quota -- see `capped.sh`). Every search is
exhaustive over its stated space; the two Monte-Carlo experiments are seeded and labelled.

## 0. Summary

The brute force answers the seed, and the answer is sharper than "hard". Four models, in
increasing generality:

| model | encryption | key entropy with two independent operations |
|---|---|---|
| **A** strict | permutation of the message space, same public operation | **zero bits** on one bit; $\log_2 k$ bits on a $k$-bit word |
| **A''** relaxed palette | permutation, restricted operation set | nonzero **iff** the palette is not functionally complete -- exactly, not approximately |
| **B** expanded | injective into a larger ciphertext space | $\log_2(|C|/2)$ bits, and the scheme is broken by an attack that never touches the key |
| **C** randomised | one-to-many, decryption a quotient map | **unbounded -- and always constructible.** Algebra stops being the obstruction entirely |

So a toy FHE with two independent operations exists, trivially, and the search shows the reason it
is not a *cryptosystem*: in models A and B the difficulty is algebraic and fatal, and in model C
the algebra disappears and the whole difficulty moves into a question the enumeration cannot see.
That relocation is the finding, and it is exactly the boundary the real literature sits on.

## 1. Model A: same space, same operation

Encryption is a permutation $\pi$ of the message space; the evaluator is public and applies the
*same* operation $f$ to ciphertexts. Correctness for every message is exactly

$$ \pi(f(x,y)) = f(\pi x, \pi y) \quad\text{for all } x,y \veq{equivar-dreamed}\lean $$

so the usable keys are $\operatorname{Aut}(f)$, and for two operations $\operatorname{Aut}(f) \cap
\operatorname{Aut}(g)$. That intersection is a subgroup of the permutation group, hence its order
divides the $P = (2^n)!$ of `crypto/fhe.md:10` -- the owner's own count is the ceiling on this
model's key space.

**One bit, all 16 operations, exhaustive.** Four operations admit a nonidentity key: `A`, `B`,
`NOT A`, `NOT B`. Every one of them ignores at least one input. **No genuinely binary operation of
one bit tolerates any key at all**, so the strict model at $n = 1$ has zero key bits before the
second operation is even asked for.

**Words, exhaustive over $\mathrm{GL}(k,2)$.** On a $k$-bit word with the field operations of
$\mathrm{GF}(2^k)$, an automorphism of $+$ is precisely a $\mathrm{GF}(2)$-linear bijection, so
the search enumerates $\mathrm{GL}(k,2)$ rather than $2^k!$ permutations:

| $k$ | $|M|$ | $|\mathrm{GL}(k,2)| = |\mathrm{Aut}(+)|$ | $|\mathrm{Aut}(+,\times)|$ | key bits | OTP bits |
|---:|---:|---:|---:|---:|---:|
| 1 | 2 | 1 | 1 | 0 | 1 |
| 2 | 4 | 6 | 2 | 1 | 2 |
| 3 | 8 | 168 | 3 | 1.585 | 3 |
| 4 | 16 | 20160 | 4 | 2 | 4 |

$|\mathrm{Aut}(+,\times)| = k$ exactly: the Frobenius maps $x \mapsto x^{2^j}$ and nothing else.
Read against the owner's criterion at `crypto/fhe.md:14`:

$$ \text{one operation: } k \text{ key bits (the OTP)}; \qquad \text{two operations: } \log_2 k \veq{frobenius-dreamed}\sorry $$

**The second operation collapses the key space from exponential in the word size ($2^k$ possible
additive automorphisms) to linear in it ($k$), so the key BITS fall from $k$ to $\log_2 k$.** That is the seed's question answered in the owner's own units, and it is why no amount of
cleverness rescues model A.

## 2. The exact trade-off: key entropy against expressive power

The palette curve generalises the collapse. For 2-bit words, taking each subgroup $H \le S_4$ as
the key space and counting the $H$-equivariant binary operations out of $4^{16}$:

| $|H|$ | key bits | $H$-equivariant operations | fraction of all | constants computable |
|---:|---:|---:|---:|---:|
| 1 | 0 | 4294967296 | 1 | 4 of 4 |
| 2 | 1 | 65536 | $1.5\cdot10^{-5}$ | 2 of 4 |
| 3 | 1.585 | 1024 | $2.4\cdot10^{-7}$ | 1 of 4 |
| 4 | 2 | 256 | $6.0\cdot10^{-8}$ | 0 of 4 |
| 6 | 2.585 | 32 | $7.5\cdot10^{-9}$ | 1 of 4 |
| 8 | 3 | 16 | $3.7\cdot10^{-9}$ | 0 of 4 |
| 12 | 3.585 | 4 | $9.3\cdot10^{-10}$ | 0 of 4 |
| 24 | 4.585 | 2 | $4.7\cdot10^{-10}$ | 0 of 4 |

(Rows are indexed by subgroup *order*, and where several subgroups share an order the row reports
the most favourable one. At order 2 the two classes differ: a transposition keeps 2 constants, a
double transposition keeps 0. The dichotomy below is unaffected -- both are under 4 -- but the
column is a maximum, not a function of $|H|$.)

The last column carries the argument, and it makes the trade-off an equivalence rather than a
tendency. A constant operation $(x,y) \mapsto c$ is $H$-equivariant exactly when every key fixes
$c$. A nontrivial key group fixes fewer than all points, so some constant is not computable, so
the palette is not functionally complete. Conversely a complete palette contains that constant and
forces the key to be the identity. Formally:

$$ \pi \neq \mathrm{id} \iff \exists f,\ \pi \notin \operatorname{Aut}(f) \veq{keyvscomplete-dreamed}\lean $$

**Key entropy and functional completeness are exactly incompatible in the strict model.** Not a
trade-off curve to be optimised along -- a dichotomy.

## 3. Model B: expand the ciphertext

Drop the requirement that encryption be onto. $E : \{0,1\} \to C$ is injective, the key is the
pair $(c_0, c_1)$, and the public evaluation tables live on $C$. Two keys coexist under one table
iff they never demand different values in the same cell, so the maximum key space is a maximum
clique in the compatibility graph -- computed exhaustively (Tomita-style branch and bound with a
greedy-colouring bound), no construction assumed:

| $|C|$ | cipher bits | XOR only | AND only | NOR only | all 16 at once |
|---:|---:|---:|---:|---:|---:|
| 2 | 1 | 1 | 1 | 1 | 1 |
| 4 | 2 | 3 | 6 | 2 | 2 |
| 8 | 3 | 7 | 28 | 4 | 4 |
| 16 | 4 | 15 | 120 | 8 | 8 |

Two things fall out. A **single** operation is roomy: XOR admits $|C| - 1$ keys, because all keys
sharing a $c_0$ agree everywhere they overlap. Demand **all sixteen** and the slack vanishes
exactly: compatibility becomes literal disjointness of ciphertext images, and the key space is a
perfect matching on $C$, so

$$ \text{key bits} = \log_2\frac{|C|}{2} = (\text{cipher bits}) - 1 \veq{matching-dreamed}\sorry $$

for **one** bit of plaintext. Unlike model A this is not zero. It is worse than zero in a way the
enumeration alone would not reveal, which is why the search runs the attack:

**The equality-pattern attack, $|C| = 16$.** (Reported as a seeded Monte Carlo, but honestly it is
a proof wearing an experiment's clothes: the adversary's rule recovers the plaintext up to a global
flip with probability exactly 1 for every seed and every length, by construction. The run confirms
the arithmetic; it does not test anything.) Encrypt an $n$-bit plaintext
bitwise under one key, give the adversary only the ciphertext and no table access. Group equal
ciphertexts, output the 2-colouring. Recovery up to global complementation: **100% at
$n = 1, 2, 4, 8, 16, 32$.** The scheme is deterministic with a reused key, so the ciphertext is
the plaintext relabelled -- a monoalphabetic substitution on a two-letter alphabet. The key bits
counted above are real and do no work whatsoever.

## 4. Model C: randomise, and watch the algebra evaporate

Let encryption be one-to-many: decryption is a surjection $d : C \to M$, a ciphertext is any
preimage, the encryptor picks one at random. Then for **any** family of plaintext operations there
is a ciphertext operation inducing each of them, with no constraint at all:

$$ \exists F,\ \forall a,b:\ d(F(a,b)) = f(d\,a, d\,b) \veq{quotient-dreamed}\lean $$

The proof is one line (choose a section of $d$). Two operations, sixteen, or all of them cost
nothing to arrange. **Whatever makes fully homomorphic encryption hard, it is not the algebra.**

So the search asks the only remaining question: does publishing $F$ give the key away? For small
$C$ it can count exactly. Build $F_1, F_2$ inducing XOR and NOR (a functionally complete pair) by
choosing a random representative of the target class in every cell, then count how many of the
$2^{|C|} - 2$ nontrivial partitions are consistent with the published tables:

| $|C|$ | nontrivial partitions | mean consistent keys | max | fraction with $>1$ |
|---:|---:|---:|---:|---:|
| 4 | 14 | 1.000 | 1 | 0.0% |
| 6 | 62 | 1.000 | 1 | 0.0% |
| 8 | 254 | 1.000 | 1 | 0.0% |
| 10 | 1022 | 1.000 | 1 | 0.0% |

The answer is **1.000 at every size, with maximum 1**: the true key is the only partition
consistent with the tables, every single trial. I had predicted 2, expecting the key and its
label-complement to be indistinguishable; they are not, because complementing the classes turns
XOR into NXOR, so the symmetry is broken by the first of the two operations before the second is
consulted. Randomising the encryption bought **exactly zero** key ambiguity.

**A published evaluation table pins the decryption partition almost exactly, however much
randomness the encryption injects.** Randomisation is necessary -- model B says so -- and it is
nowhere near sufficient. What a real scheme adds is that $F$ is *never written down*: it is given
implicitly as arithmetic on a ring of astronomical size, and recovering the partition from that
description is a hard lattice problem. The enumeration cannot see that difference, because the
difference is computational and not algebraic. Which is precisely the boundary the seed's
brute-force programme runs into, and the reason it is worth having run it.

## 5. What is already known

This essay re-derives, in a small exhaustive setting, results that have names. Stating that
plainly is the point of the section; confirming known results with an independent method is worth
something, and pretending to have discovered them is not.

- **Rivest, Adleman and Dertouzos (1978), "On Data Banks and Privacy Homomorphisms"** posed the
  problem and proposed four additive privacy homomorphisms. **Brickell and Yacobi (1987)** broke
  all four -- two under ciphertext-only attack, two under known plaintext, one of them from a
  *single* known pair. Model B's equality-pattern attack is the toy shadow of that.
- **Boneh and Lipton (1996)**, *Algorithms for Black-Box Fields*, proved that any **deterministic**
  **field**-homomorphic encryption scheme can be broken in **subexponential** time, via black-box
  extraction over a prime field. **Corrected after an audit:** an earlier draft of this section said
  "over a finite ring", which overstates it. The extension to $\mathbb{Z}_n$ carries hypotheses the
  draft dropped (squarefree $n$, factorisation known), and the general **ring** case is precisely
  the question that line of work leaves open -- indeed it is treated as evidence *for* the
  possibility of ring-homomorphic schemes. My Frobenius count is over $\mathrm{GF}(2^k)$, a field,
  so it *is* an instance of the proved case; but the impossibility does not extend to rings, and
  section 5 of [`fhe-llm`](fhe-llm.md) should not have filed it under "proven impossible" without
  that qualifier.
- **Determinism defeats IND-CPA outright**, and has since Goldwasser-Micali: an adversary with an
  encryption oracle compares $\mathrm{Enc}(m_0)$ against the challenge. Model B's 100% recovery is
  this textbook fact wearing a toy costume.
- **Clone theory** owns section 2. The $H$-equivariant operations are a *centralizer clone*; that a
  nontrivial permutation group's centralizer clone is a proper clone, hence not functionally
  complete, is standard (Rosenberg's classification of maximal clones; Machida and Rosenberg on
  centralizers). What section 2 contributes is the crypto reading -- centralizer clone = key
  space -- and the exhaustive $S_4$ table.
- **Gentry (2009)** resolved the 1978 problem by leaving the algebra alone and making the
  ciphertext *noisy*: decryption is a quotient by a noise ball, evaluation grows the noise,
  bootstrapping resets it. In this essay's language, real FHE is model C with an $F$ that cannot
  be tabulated and a $d$ hidden behind LWE.

What the search adds is exhaustive instantiation rather than a new theorem, and an earlier draft
overclaimed here. It said the equivalence of section 2 "in **both** directions" was not stated
elsewhere -- three sentences after conceding that the reverse direction (a nontrivial group's
centralizer clone is proper, hence incomplete) is standard clone theory. Both directions are known.
The contribution is the crypto reading, the exhaustive $S_4$ table, and the fact that the dichotomy
is exact rather than a bound.

## 6. What a toy model can and cannot demonstrate

Worth stating, because the seed asked for a toy and toys mislead in a specific way here. A toy FHE
is *easy* -- section 4 builds one in a line. Every difficulty in real FHE is quantitative: not
"can $F$ exist" but "can $F$ be described compactly enough to publish and opaquely enough to hide
$d$". Those two requirements pull against each other and only start pulling at sizes where
enumeration is impossible by construction. **An exhaustive search over small algebras is therefore
guaranteed to find either a trivially insecure scheme or no scheme at all**, and that is what it
found. This is not a failure of the method; it is the method reporting where its own horizon is.

## 7. Surfaced for the owner

Located, evidenced, not resolved. **No finding or verdict here was filed into any ledger.** The
batch carries one neutral pointer (`TODO.md` `id:6646`) that lists these rulings AS PENDING, which
is how it stays visible to `/relay human` without anything being recorded as decided.

1. **`crypto/fhe.md:14`'s criterion is exactly right and can be sharpened.** The page rejects
   anything above one key bit per data bit as worse than the OTP. Model A gives the reverse
   statement in the same units: two operations cap the key at $\log_2 k$ bits for $k$ data bits,
   i.e. asymptotically **zero** key bits per data bit. If the page ever wants a sentence saying why
   the search for a thinned bijection family cannot succeed *as bijections*, this is it. Owner's
   call whether the page wants it.

2. **The `stirling` finding of `id:76e5` is untouched here** and remains as
   [`fhe-counting`](fhe-counting.md) left it (confirmed, $+0.4068$ bits, gated on the owner).
   Flagged only so this essay is not read as superseding that one.

3. **Adjacent, cheap, ignore freely:** `crypto/fhe.md:76` carries a bare `TODO switch endianess of
   permutation`, and `:112` a stray `print("hello")` python block. Both predate this session and
   neither affects any claim; noted because the owner will be in that region if he acts on item 1.

## 8. Lean attestation

**File** [`docs/dreamed/lean/FHEToy.lean`](lean/FHEToy.lean). **Command**
`cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/FHEToy.lean`.
**Exit status `0`, `sorry` count `0`.** Mathlib is the rev pinned in `verify/lake-manifest.json`;
imports are narrow, no `import Mathlib`.

| Claim | Lean names | Status |
|---|---|---|
| usable keys form a subgroup | `Equivariant`, `autOp`, `autOp₂` | proved |
| a key fixes the identity element | `fixes_identity`, `fixes_two_identities` | proved |
| key entropy $\iff$ incompleteness | `const_equivariant_iff`, `nontrivial_key_incomplete`, `complete_forces_trivial_key` | proved |
| one-bit instance, zero keys | `bool_and_xor_only_id` | proved by `decide` |
| GF(4) instance, exactly 2 keys | `add4`, `mul4`, `gf4_key_count` | proved by `decide` |
| algebra never obstructs | `eval_exists`, `eval_exists_family` | proved |
| key hiding | `KeyHiding` | **definition only, deliberately unproved** |

**Two of my own claims were false and Lean caught both.** I first stated
`bool_and_xor_only_id` and `gf4_key_count` *without* a bijectivity hypothesis, on the reasoning
that dropping invertibility would only strengthen them. It does not: the constant map
$x \mapsto \texttt{false}$ commutes with both `and` and `xor`, and the constant-zero map commutes
with both GF(4) operations. `decide` reported both as false. The file now records the
counterexamples as theorems (`const_false_homomorphic`, `gf4_without_bijectivity`) so the
hypothesis is visibly necessary rather than defensive. The underlying point is worth keeping:
**being a homomorphism and being an encryption are independent properties**, and the toy models
only bite once invertibility is imposed.

The `matching-dreamed` badge in section 3 carries `\sorry` deliberately: the $|C|/2$ formula is an
observed pattern across four exhaustive rows, not a proved theorem, and I have not proved that
demanding all $2^{2^2}$ operations forces disjointness in general.

`\veq` badges above attest against this dreamed file only, never against the repo's sidecar
machinery (`docs/dreamed/README.md` rule).

## 9. Follow-up leads

1. **Prove the model-B matching bound** (mechanizable, small): that requiring all 16 operations
   makes compatibility equal disjointness, hence key space $= \lfloor |C|/2 \rfloor$. Decidable by
   writing it; the four exhaustive rows are the fixtures. Would retire the one `\sorry` above.
2. **The general-$H$ centralizer-clone statement** (mechanizable, larger): section 2's dichotomy
   currently proves "some operation is missing"; the clone-theoretic statement is that the
   centralizer clone of a nontrivial group is contained in a maximal clone. That is a real
   theorem with a literature, and porting even the finite case is a genuine Lean project.
3. **Model C at larger $|C|$ with structured rather than random $F$** (mechanizable, cheap): the
   ambiguity measured in section 4 uses a *random* fill. An adversarially chosen fill maximising
   ambiguity is the interesting quantity, and it is a maximum-agreement problem, not a count.
   This is the closest the toy programme can get to touching the real question.
4. **Whether `crypto/fhe.md` wants any of this** (owner-only, and the gating one): items 1-3 are
   about a model *this essay* introduced, not about the owner's page. He may reasonably decide the
   page's line of thought is about counting bijections and should stay there.
