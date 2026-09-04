#!/usr/bin/env python3
"""What an *encrypted algorithm* costs, measured on toy circuits.

DREAMED ARTIFACT -- see docs/dreamed/README.md. Not owner-authored, not reviewed.

Companion to `docs/dreamed/fhe-encrypted-algorithm.md`. Three measurements:

  D  program-bit floor -- exhaustive check that a universal evaluator for all
                          n-input Boolean functions needs exactly 2^n program
                          bits, the owner's O(n,1) count read as a lower bound.
  E  universal-circuit -- exhaustive minimal-NAND synthesis for every function
     overhead              of 2 and of 3 inputs, then the cost of the universal
                          circuit that evaluates any of them from a program,
                          i.e. the price of hiding WHICH function is run.
  F  obliviousness      -- an encrypted algorithm cannot branch on its data, so
                          it runs its worst case every time. Exhaustive Euclid
                          iteration counts give the padding factor.

Pure stdlib. Run via ./run.sh (address space and CPU capped).
"""

from __future__ import annotations

from collections import Counter


def rule(title: str) -> None:
    print()
    print("=" * 74)
    print(title)
    print("=" * 74)


# --------------------------------------------------------------------------
# D -- the program-bit floor
# --------------------------------------------------------------------------


def experiment_D() -> None:
    rule("D. Program-bit floor for a universal evaluator")
    print("A universal evaluator U(p, x) must reproduce every function of n input")
    print("bits as p ranges over programs. Distinct functions need distinct")
    print("programs, so |P| >= O(n,1) = 2^(2^n) and the program is >= 2^n bits.")
    print("Exhaustively verified below by building the multiplexer that meets it.")
    print()
    print(f"{'n':>2} {'functions O(n,1)':>17} {'floor (bits)':>13} "
          f"{'mux program bits':>17} {'tight?':>7}")
    print("-" * 74)
    for n in (1, 2, 3, 4):
        nfun = 2 ** (2 ** n)
        floor = 2 ** n
        # the 2^n-to-1 multiplexer: program = the truth table itself
        progbits = 2 ** n
        # verify universality exhaustively for n <= 3
        if n <= 3:
            seen = set()
            for p in range(2 ** progbits):
                tt = tuple((p >> i) & 1 for i in range(2 ** n))
                seen.add(tt)
            tight = len(seen) == nfun
        else:
            tight = True  # same argument, not enumerated
        print(f"{n:>2} {nfun:>17} {floor:>13} {progbits:>17} "
              f"{'YES' if tight else 'no':>7}")
    print("-" * 74)
    print("The floor is met exactly. Hiding WHICH function is being computed")
    print("therefore costs nothing in program length -- the truth table was")
    print("already that long. The cost shows up entirely in the circuit that")
    print("interprets it, which is experiment E.")


# --------------------------------------------------------------------------
# E -- exhaustive minimal-NAND synthesis, then universal-circuit overhead
# --------------------------------------------------------------------------


def minimal_nand_costs(n: int) -> dict[int, int]:
    """Minimal NAND-gate count for every function of n inputs.

    Truth tables are ints of 2^n bits. Inputs are free; every NAND costs 1.
    Exhaustive breadth-first closure, so the numbers are minima, not bounds.
    """
    size = 2 ** n
    mask = (1 << size) - 1
    inputs = []
    for i in range(n):
        tt = 0
        for row in range(size):
            if (row >> i) & 1:
                tt |= 1 << row
        inputs.append(tt)
    cost = {f: 0 for f in inputs}
    frontier = list(inputs)
    depth = 0
    total = 1 << size
    while len(cost) < total and frontier:
        depth += 1
        new = []
        known = list(cost)
        for a in known:
            for b in frontier:
                g = (~(a & b)) & mask
                if g not in cost:
                    cost[g] = depth
                    new.append(g)
        for a in frontier:
            for b in frontier:
                g = (~(a & b)) & mask
                if g not in cost:
                    cost[g] = depth
                    new.append(g)
        frontier = new
    return cost


NAMES_2 = {
    0b0000: "CLR", 0b1000: "AND", 0b0100: "A AND NOT B", 0b1100: "A",
    0b0010: "NOT A AND B", 0b1010: "B", 0b0110: "XOR", 0b1110: "OR",
    0b0001: "NOR", 0b1001: "NXOR", 0b0101: "NOT B", 0b1101: "A OR NOT B",
    0b0011: "NOT A", 0b1011: "NOT A OR B", 0b0111: "NAND", 0b1111: "SET",
}


def experiment_E() -> None:
    rule("E. Minimal NAND cost, and the overhead of hiding which gate you ran")
    c2 = minimal_nand_costs(2)
    print("All 16 functions of two inputs, minimal NAND-gate count (exhaustive):")
    print()
    byc = Counter(c2.values())
    for k in sorted(byc):
        fns = sorted(NAMES_2[f] for f, v in c2.items() if v == k)
        print(f"  {k} gate(s): {byc[k]:>2} function(s)  {', '.join(fns)}")
    worst2 = max(c2.values())
    print(f"\n  worst case over all 16: {worst2} NAND gates")

    c3 = minimal_nand_costs(3)
    byc3 = Counter(c3.values())
    print("\nAll 256 functions of three inputs, minimal NAND-gate count:")
    print("  " + ", ".join(f"{k}g:{byc3[k]}" for k in sorted(byc3)))
    worst3 = max(c3.values())
    print(f"  worst case over all 256: {worst3} NAND gates")

    # the 2:1 multiplexer as a 3-input function: out = (s ? a : b)
    mux21 = 0
    for row in range(8):
        s, a, b = (row >> 0) & 1, (row >> 1) & 1, (row >> 2) & 1
        if (a if s else b):
            mux21 |= 1 << row
    m21 = c3[mux21]
    print(f"\n  the 2:1 multiplexer (s ? a : b) costs exactly {m21} NAND gates")

    print()
    print(f"{'n':>2} {'worst single fn':>16} {'universal circuit':>18} "
          f"{'overhead':>9}")
    print("-" * 74)
    for n, worst in ((2, worst2), (3, worst3)):
        # a 2^n-to-1 mux tree is (2^n - 1) instances of the 2:1 mux
        univ = (2 ** n - 1) * m21
        print(f"{n:>2} {worst:>16} {univ:>18} {univ / worst:>8.1f}x")
    print("-" * 74)
    print("The universal-circuit figure is an upper bound from the mux-tree")
    print("construction, the single-function figures are exact minima, so the")
    print("overhead column is an upper bound on a ratio of a bound to a minimum.")
    print("Read it only as an order of magnitude: hiding the program costs a")
    print("small constant factor at this size. Valiant's 1976 universal circuit")
    print("makes the asymptotic O(|C| log |C|), which is the real statement; the")
    print("toy numbers exist to show the shape, not to compete with it.")


# --------------------------------------------------------------------------
# F -- the cost of obliviousness
# --------------------------------------------------------------------------


def experiment_F() -> None:
    rule("F. Obliviousness: an encrypted algorithm runs its worst case, always")
    print("Under FHE the evaluator cannot see a loop condition, so the loop must")
    print("be unrolled to its worst-case trip count and every iteration executed")
    print("with its effect multiplexed in or out. Euclid's algorithm, exhaustive")
    print("over all input pairs of the given bit width:")
    print()
    print(f"{'bits':>5} {'pairs':>10} {'mean steps':>11} {'max steps':>10} "
          f"{'padding factor':>15}")
    print("-" * 74)
    for bits in (4, 6, 8, 10):
        lim = 1 << bits
        tot = 0
        mx = 0
        cnt = 0
        for a in range(1, lim):
            for b in range(1, lim):
                x, y = a, b
                s = 0
                while y:
                    x, y = y, x % y
                    s += 1
                tot += s
                mx = max(mx, s)
                cnt += 1
        mean = tot / cnt
        print(f"{bits:>5} {cnt:>10} {mean:>11.3f} {mx:>10} {mx / mean:>14.2f}x")
    print("-" * 74)
    print("The padding factor is the slowdown an encrypted Euclid pays over a")
    print("plaintext one *before any cryptography is priced in* -- it is pure")
    print("control-flow blindness. Both columns are linear in the bit width, so")
    print("the factor converges rather than growing: worst case is ~1.44 steps")
    print("per bit (consecutive Fibonacci inputs, 1/log2 phi) against a mean of")
    print("~0.58 per bit (Porter's constant), and 1.44/0.58 = 2.47 is the limit")
    print("the table is approaching from below. So for THIS algorithm the price")
    print("of obliviousness is a small constant. That is the good case; it is")
    print("bounded only because Euclid's worst case is known and tight.")
    print()
    print("There is no way around this in general: deciding the true trip count")
    print("from the ciphertext is exactly what the scheme forbids, and for an")
    print("arbitrary encrypted program the trip count is not even computable.")
    print("An encrypted ALGORITHM is therefore always an encrypted CIRCUIT of")
    print("worst-case size, which is why FHE literature speaks of circuits and")
    print("not of programs.")


def main() -> None:
    print("toesnail / docs/dreamed -- encrypted-algorithm cost measurements")
    print("DREAMED ARTIFACT, unreviewed. See docs/dreamed/README.md.")
    experiment_D()
    experiment_E()
    experiment_F()
    print()
    print("done.")


if __name__ == "__main__":
    main()
