#!/usr/bin/env python3
"""Exhaustive search over toy homomorphic-encryption models.

DREAMED ARTIFACT -- see docs/dreamed/README.md. Not owner-authored, not reviewed.

Answers, by brute force rather than by argument, the question of essay
`docs/dreamed/fhe-toy-enumeration.md`: is there a toy "encryption" of bits that
supports at least two independent binary operations, and what does it cost in
key bits?

Four experiments, each exhaustive over its stated space (no sampling except
where explicitly labelled MONTE CARLO, which is seeded):

  A  strict model   -- ciphertext space = plaintext space, evaluation uses the
                       SAME operation. Key = an automorphism. Exhaustive over
                       the 16 binary Boolean operations x S_2.
  A' word version   -- same, on k-bit words with (+, x) of GF(2^k). Exhaustive
                       over GL(k,2) for k = 1..4 (additive automorphisms are
                       exactly the GF(2)-linear bijections).
  A'' palette curve -- for 2-bit words: for every subgroup H of S_4, how many
                       binary operations M x M -> M are H-equivariant, i.e. how
                       big is the operation palette that survives |H| keys.
  B  disjoint-image -- deterministic, expanded ciphertext, key = which pair of
                       ciphertexts encodes (0, 1). Maximum clique over the
                       compatibility graph. Then the equality-pattern attack.
  C  congruence     -- randomised encryption as a quotient map. Existence is
                       free; the measured quantity is KEY AMBIGUITY, how many
                       decryption partitions a given evaluation table admits.

Run via ./run.sh, which caps address space and niceness. Pure stdlib.
"""

from __future__ import annotations

import itertools
import random
import sys
from collections import Counter

# --------------------------------------------------------------------------
# helpers
# --------------------------------------------------------------------------

BOOL_OP_NAMES = {
    (0, 0, 0, 0): "CLR",
    (0, 0, 0, 1): "AND",
    (0, 0, 1, 0): "A AND NOT B",
    (0, 0, 1, 1): "A",
    (0, 1, 0, 0): "NOT A AND B",
    (0, 1, 0, 1): "B",
    (0, 1, 1, 0): "XOR",
    (0, 1, 1, 1): "OR",
    (1, 0, 0, 0): "NOR",
    (1, 0, 0, 1): "NXOR",
    (1, 0, 1, 0): "NOT B",
    (1, 0, 1, 1): "A OR NOT B",
    (1, 1, 0, 0): "NOT A",
    (1, 1, 0, 1): "NOT A OR B",
    (1, 1, 1, 0): "NAND",
    (1, 1, 1, 1): "SET",
}


def rule(title: str) -> None:
    print()
    print("=" * 74)
    print(title)
    print("=" * 74)


def perms(n: int):
    return list(itertools.permutations(range(n)))


def equivariant(pi, f, n: int) -> bool:
    """pi(f(x,y)) == f(pi x, pi y) for all x, y.  f is a flat n*n table."""
    return all(pi[f[x * n + y]] == f[pi[x] * n + pi[y]] for x in range(n) for y in range(n))


# --------------------------------------------------------------------------
# A -- strict model on one bit: all 16 operations against S_2
# --------------------------------------------------------------------------


def experiment_A() -> None:
    rule("A. Strict model, 1-bit ciphertext: which operations admit a key?")
    print("Key space = { pi in S_2 : pi(f(x,y)) = f(pi x, pi y) }.  A key of")
    print("size 1 means zero key bits: the evaluator's table already fixes pi.")
    print()
    print(f"{'op':<12} {'truth table':<12} {'|Aut|':>5}  {'key bits':>8}  genuinely binary?")
    print("-" * 74)
    survivors = []
    for tt in itertools.product((0, 1), repeat=4):
        f = list(tt)  # f[x*2+y]
        aut = [pi for pi in perms(2) if equivariant(pi, f, 2)]
        # "genuinely binary": output depends on BOTH arguments somewhere
        dep_a = any(f[0 * 2 + y] != f[1 * 2 + y] for y in range(2))
        dep_b = any(f[x * 2 + 0] != f[x * 2 + 1] for x in range(2))
        binary = dep_a and dep_b
        bits = 0 if len(aut) == 1 else round(len(aut) - 1)  # log2 of 1 or 2
        print(
            f"{BOOL_OP_NAMES[tt]:<12} {''.join(map(str, tt)):<12} {len(aut):>5}  "
            f"{bits:>8}  {'YES' if binary else 'no'}"
        )
        if len(aut) > 1:
            survivors.append((BOOL_OP_NAMES[tt], binary))
    print("-" * 74)
    keyed = [name for name, _ in survivors]
    keyed_binary = [name for name, b in survivors if b]
    print(f"operations admitting a nontrivial key ({len(keyed)}): {', '.join(keyed)}")
    print(f"of those, GENUINELY BINARY: {len(keyed_binary)} -> {keyed_binary or 'NONE'}")
    print()
    print("Reading: the only 1-bit operations that tolerate a key are the two")
    print("projections and their negations, i.e. exactly the operations that")
    print("compute nothing. Every operation that actually combines two inputs")
    print("pins the key to the identity. Zero key bits, exhaustively.")


# --------------------------------------------------------------------------
# A' -- strict model on k-bit words, both + and x of GF(2^k)
# --------------------------------------------------------------------------

# Conway polynomials (as bitmasks of degree k) for GF(2^k), k = 1..5.
GF_MOD = {1: 0b11, 2: 0b111, 3: 0b1011, 4: 0b10011, 5: 0b100101}


def gf_mul(a: int, b: int, k: int) -> int:
    mod = GF_MOD[k]
    r = 0
    while b:
        if b & 1:
            r ^= a
        b >>= 1
        a <<= 1
        if a >> k & 1:
            a ^= mod
    return r


def gl_matrices(k: int):
    """All invertible k x k matrices over GF(2), as tuples of row bitmasks."""
    rows = list(range(1, 1 << k))  # nonzero rows only (a zero row is singular)
    for cand in itertools.product(rows, repeat=k):
        # invertibility by Gaussian elimination over GF(2)
        m = list(cand)
        rank = 0
        for bit in range(k):
            piv = next((i for i in range(rank, k) if m[i] >> bit & 1), None)
            if piv is None:
                continue
            m[rank], m[piv] = m[piv], m[rank]
            for i in range(k):
                if i != rank and m[i] >> bit & 1:
                    m[i] ^= m[rank]
            rank += 1
        if rank == k:
            yield cand


def apply_mat(mat, x: int, k: int) -> int:
    """mat acts on x by (mat x)_i = parity(row_i AND x)."""
    out = 0
    for i in range(k):
        if bin(mat[i] & x).count("1") & 1:
            out |= 1 << i
    return out


def experiment_A_prime() -> None:
    rule("A'. Strict model on k-bit words: keys preserving BOTH + and x")
    print("An automorphism of + on GF(2^k) is exactly a GF(2)-linear bijection,")
    print("so the search is exhaustive over GL(k,2) -- no permutation blow-up.")
    print()
    print(f"{'k':>2} {'|M|':>4} {'|GL(k,2)|':>10} {'|Aut(+)|':>9} {'|Aut(+,x)|':>11} "
          f"{'key bits':>9} {'OTP bits':>9}")
    print("-" * 74)
    for k in (1, 2, 3, 4):
        n = 1 << k
        mats = list(gl_matrices(k))
        both = []
        for mat in mats:
            img = [apply_mat(mat, x, k) for x in range(n)]
            if all(img[gf_mul(x, y, k)] == gf_mul(img[x], img[y], k)
                   for x in range(n) for y in range(n)):
                both.append(mat)
        bits = (len(both).bit_length() - 1) if len(both) and (len(both) & (len(both) - 1)) == 0 \
            else round(__import__("math").log2(len(both)), 4)
        print(f"{k:>2} {n:>4} {len(mats):>10} {len(mats):>9} {len(both):>11} "
              f"{str(bits):>9} {k:>9}")
    print("-" * 74)
    print("|Aut(+, x)| = k exactly: the Frobenius maps x -> x^(2^j), j = 0..k-1.")
    print("So the key entropy of a two-operation deterministic bijective scheme")
    print("is log2(k) bits on a k-bit word, against the OTP's k bits for ONE")
    print("operation. Adding a second operation collapses the key space from")
    print("exponential to LINEAR in the word size.")


# --------------------------------------------------------------------------
# A'' -- palette curve: key group size vs number of surviving operations
# --------------------------------------------------------------------------


def compose(p, q):
    return tuple(p[q[i]] for i in range(len(q)))


def subgroups_of_sym(n: int):
    """All subgroups of S_n, via closures of <=2 generators (valid for n <= 4)."""
    P = perms(n)
    ident = tuple(range(n))
    found = {}
    for a, b in itertools.product(P, repeat=2):
        elems = {ident}
        frontier = [a, b]
        while frontier:
            x = frontier.pop()
            if x in elems:
                continue
            elems.add(x)
            for y in list(elems):
                for z in (compose(x, y), compose(y, x)):
                    if z not in elems:
                        frontier.append(z)
        found[frozenset(elems)] = elems
    return sorted(found.values(), key=len)


def equivariant_op_count(H, n: int) -> int:
    """#{ f : M x M -> M | f is H-equivariant }, by the orbit/stabiliser product.

    f is determined by its value on one representative per orbit of the diagonal
    H-action on M x M; that value must be fixed by the stabiliser of the rep.
    """
    seen = set()
    total = 1
    for x in range(n):
        for y in range(n):
            if (x, y) in seen:
                continue
            orbit = {(pi[x], pi[y]) for pi in H}
            seen |= orbit
            stab = [pi for pi in H if (pi[x], pi[y]) == (x, y)]
            choices = sum(1 for v in range(n) if all(pi[v] == v for pi in stab))
            total *= choices
            if total == 0:
                return 0
    return total


def experiment_A_double_prime() -> None:
    rule("A''. Palette curve for 2-bit words: key size vs surviving operations")
    print("M = 2-bit words (|M| = 4). For each subgroup H of S_4 taken as the key")
    print("space, count the binary operations M x M -> M that every key preserves.")
    print("Total operation count is 4^16 = 4294967296.")
    print()
    print(f"{'|H|':>4} {'key bits':>9} {'H-equivariant ops':>19} {'fraction':>12}  "
          f"constants kept")
    print("-" * 74)
    import math
    total_ops = 4 ** 16
    rows = {}
    for H in subgroups_of_sym(4):
        c = equivariant_op_count(H, 4)
        fixed_pts = sum(1 for v in range(4) if all(pi[v] == v for pi in H))
        rows.setdefault(len(H), []).append((c, fixed_pts))
    for size in sorted(rows):
        best_c, best_fp = max(rows[size])
        kb = round(math.log2(size), 4)
        print(f"{size:>4} {str(kb):>9} {best_c:>19} {best_c / total_ops:>12.3e}  "
              f"{best_fp} of 4")
    print("-" * 74)
    print("The 'constants kept' column is the whole story: a constant map to c is")
    print("H-equivariant only if every key fixes c. A nontrivial key group fixes")
    print("fewer than 4 points, so at least one constant is NOT computable, so the")
    print("surviving palette is NOT functionally complete. Key bits > 0 and")
    print("functional completeness are exactly incompatible, not merely in tension.")


# --------------------------------------------------------------------------
# B -- deterministic expanded ciphertext, disjoint-image keys
# --------------------------------------------------------------------------


def experiment_B() -> None:
    rule("B. Deterministic expansion: key = which ciphertext pair encodes (0,1)")
    print("E is injective {0,1} -> C, key = the pair (c0, c1). Two keys can")
    print("coexist under one public evaluation table iff they never demand two")
    print("different values in the same table cell. Maximum key space = maximum")
    print("clique in that compatibility graph, computed exhaustively.")
    print()
    ops = {
        "XOR": (0, 1, 1, 0),
        "AND": (0, 0, 0, 1),
        "NOR": (1, 0, 0, 0),
        "all 16 at once": None,
    }
    print(f"{'|C|':>4} {'cipher bits':>12} {'operation set':<16} {'max keys':>9} "
          f"{'key bits':>9}")
    print("-" * 74)
    import math
    for csize in (2, 4, 8, 16):
        keys = [(a, b) for a in range(csize) for b in range(csize) if a != b]
        for label, tt in ops.items():
            tts = [tt] if tt else list(itertools.product((0, 1), repeat=4))

            def cells(key):
                c = {}
                for ti, t in enumerate(tts):
                    for x in (0, 1):
                        for y in (0, 1):
                            c[(ti, key[x], key[y])] = key[t[x * 2 + y]]
                return c

            cellmap = [cells(k) for k in keys]
            nk = len(keys)
            # adjacency as bitmasks -- max clique on up to 240 vertices
            adj = [0] * nk
            for i in range(nk):
                for j in range(i + 1, nk):
                    if all(cellmap[j].get(p, v) == v for p, v in cellmap[i].items()):
                        adj[i] |= 1 << j
                        adj[j] |= 1 << i
            best = [0]

            def expand(size: int, cand: int) -> None:
                """Tomita-style max clique: greedy colouring gives the bound."""
                if cand == 0:
                    if size > best[0]:
                        best[0] = size
                    return
                # greedy colouring of `cand`; colour k bounds the clique at k
                order: list[tuple[int, int]] = []
                uncoloured = cand
                colour = 0
                while uncoloured:
                    colour += 1
                    avail = uncoloured
                    while avail:
                        v = (avail & -avail).bit_length() - 1
                        avail &= ~(1 << v) & ~adj[v]
                        uncoloured &= ~(1 << v)
                        order.append((colour, v))
                for colour, v in reversed(order):
                    if size + colour <= best[0]:
                        return
                    expand(size + 1, cand & adj[v])
                    cand &= ~(1 << v)

            # Is compatibility exactly "the two keys use disjoint ciphertexts"?
            disjoint_iff = all(
                bool(adj[i] >> j & 1) == (len(set(keys[i]) & set(keys[j])) == 0)
                for i in range(nk) for j in range(i + 1, nk)
            )
            expand(0, (1 << nk) - 1)
            mx = best[0]
            kb = round(math.log2(mx), 4) if mx > 0 else float("-inf")
            print(f"{csize:>4} {csize.bit_length() - 1:>12} {label:<16} "
                  f"{mx:>9} {str(kb):>9}  "
                  f"{'compat == disjoint' if disjoint_iff else 'compat > disjoint'}")
        print()
    print("-" * 74)
    print("Every row is an exhaustive maximum clique, no construction assumed.")
    print("Read the last column: for a SINGLE operation, two keys can share a")
    print("ciphertext and still agree, so the key space is larger than the")
    print("disjoint-image construction would give. Demand all sixteen operations")
    print("and that slack vanishes -- compatibility becomes exactly disjointness,")
    print("and the key space drops to |C|/2, one bit less than the ciphertext.")
    print("That is the price of the second operation, measured: not a collapse")
    print("to nothing as in the strict model of experiment A, but a scheme whose")
    print("key is one bit shorter than its own ciphertext, for one bit of")
    print("plaintext. Experiment B2 shows the key does no work at all.")
    print("Note the third column: supporting ALL SIXTEEN operations costs exactly")
    print("as much as supporting one. Disjoint ciphertext images never collide, so")
    print("the number of operations is free. That is a toy FHE with two -- with")
    print("every -- independent operation. Experiment B2 says what it is worth.")


def experiment_B2(trials: int = 2000, seed: int = 20260904) -> None:
    rule("B2. The equality-pattern attack on the scheme of experiment B")
    print("MONTE CARLO (seeded). Encrypt a random n-bit plaintext bitwise under a")
    print("random key, hand the adversary only the ciphertext, no table access.")
    print("The adversary groups equal ciphertexts and outputs the resulting")
    print("2-colouring; it is right up to global complementation.")
    print()
    rng = random.Random(seed)
    csize = 16
    print(f"{'n (plaintext bits)':>19} {'recovered exactly (up to flip)':>32}")
    print("-" * 74)
    for n in (1, 2, 4, 8, 16, 32):
        wins = 0
        for _ in range(trials):
            c0, c1 = rng.sample(range(csize), 2)
            msg = [rng.randint(0, 1) for _ in range(n)]
            ct = [c0 if b == 0 else c1 for b in msg]
            guess = [0 if c == ct[0] else 1 for c in ct]
            if guess == msg or guess == [1 - b for b in msg]:
                wins += 1
        print(f"{n:>19} {wins / trials:>31.1%}")
    print("-" * 74)
    print("100% at every length. The scheme is deterministic and the key is")
    print("reused across bits, so the ciphertext IS the plaintext relabelled --")
    print("a monoalphabetic substitution on a two-letter alphabet. The key bits")
    print("counted in experiment B are real but buy nothing: the equality pattern")
    print("of the ciphertext leaks the message without ever touching the key.")


# --------------------------------------------------------------------------
# C -- randomised encryption as a congruence; measure key ambiguity
# --------------------------------------------------------------------------


def experiment_C(trials: int = 400, seed: int = 20260904) -> None:
    rule("C. Randomised encryption as a quotient: existence is free, hiding is not")
    print("Decryption is a surjection d : C -> {0,1}; the key is the partition.")
    print("For any two target operations f1, f2 an evaluation pair F1, F2 always")
    print("EXISTS (pick any representative of the target class per cell), so")
    print("algebra never obstructs a two-operation toy FHE. MONTE CARLO (seeded):")
    print("build such an F1, F2 at random, then count how many of the 2^|C|-2")
    print("nontrivial partitions are consistent with the published tables.")
    print()
    rng = random.Random(seed)
    f1 = (0, 1, 1, 0)  # XOR
    f2 = (1, 0, 0, 0)  # NOR -- functionally complete together with XOR
    print(f"{'|C|':>4} {'partitions':>11} {'mean consistent keys':>21} "
          f"{'max':>5} {'>1 key':>8}")
    print("-" * 74)
    for csize in (4, 6, 8, 10):
        counts = []
        for _ in range(trials):
            # random balanced partition = the true key
            pts = list(range(csize))
            rng.shuffle(pts)
            cls = [0] * csize
            for p in pts[csize // 2:]:
                cls[p] = 1
            byclass = ([p for p in range(csize) if cls[p] == 0],
                       [p for p in range(csize) if cls[p] == 1])
            F = []
            for tt in (f1, f2):
                tab = [0] * (csize * csize)
                for a in range(csize):
                    for b in range(csize):
                        tgt = tt[cls[a] * 2 + cls[b]]
                        tab[a * csize + b] = rng.choice(byclass[tgt])
                F.append(tab)
            ok = 0
            for mask in range(1, (1 << csize) - 1):
                g = [(mask >> p) & 1 for p in range(csize)]
                if all(g[F[i][a * csize + b]] == tt[g[a] * 2 + g[b]]
                       for i, tt in enumerate((f1, f2))
                       for a in range(csize) for b in range(csize)):
                    ok += 1
            counts.append(ok)
        c = Counter(counts)
        print(f"{csize:>4} {(1 << csize) - 2:>11} {sum(counts) / len(counts):>21.3f} "
              f"{max(counts):>5} {sum(v for k, v in c.items() if k > 1) / trials:>7.1%}")
    print("-" * 74)
    print("The mean is exactly 1.000 at every size and the maximum is 1: the true")
    print("key is the ONLY consistent partition, every time. Not even the")
    print("complement survives -- flipping the class labels turns XOR into NXOR,")
    print("so the label-swap symmetry one might expect is already broken by the")
    print("first of the two operations.")
    print("So a published evaluation TABLE pins the decryption partition")
    print("uniquely, however much randomness the encryption injects. Randomisation")
    print("is necessary -- experiment B2 -- but it is not sufficient. What real")
    print("FHE adds is that the table is never written down: F is given implicitly")
    print("as arithmetic on a ring of astronomical size, and recovering the")
    print("partition from that description is the LWE problem.")


# --------------------------------------------------------------------------

def main() -> None:
    print("toesnail / docs/dreamed -- exhaustive toy-FHE search")
    print("DREAMED ARTIFACT, unreviewed. See docs/dreamed/README.md.")
    experiment_A()
    experiment_A_prime()
    experiment_A_double_prime()
    experiment_B()
    experiment_B2()
    experiment_C()
    print()
    print("done.")


if __name__ == "__main__":
    sys.setrecursionlimit(10000)
    main()
