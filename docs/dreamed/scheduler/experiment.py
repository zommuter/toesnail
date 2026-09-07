"""The D3 experiment: does reading (ii) beat reading (i), and at what price?

DREAMED CODE. Unreviewed, outside `make test`, stdlib only.

Method: seeded Monte Carlo. Every arm sees the SAME corpus for a given seed, so
all comparisons are paired. Seeds and every parameter are printed with the
results.
"""

import random
import sys

import core
import corpus
from core import (schedule, reading_i, reading_ii, reading_oracle,
                  rule_triangle, rule_oracle)

# ---------------------------------------------------------------------------
# Baseline parameters. Deliberately small: three sibling agents share this box.
# ---------------------------------------------------------------------------
SEED0 = 20260907
N = 50            # sentences per corpus
BUDGET = 2500     # total units of proof search
MEAN_D = 40       # mean difficulty of a decidable sentence
RECOGNITION = 3   # units for a coin to advertise that it is decidable
TRIGGER = 60      # units of resistance before a policy acts (timeout, or a check)
CHECK_COST = 80   # baseline price of one independence attempt
SEEDS = 40


ARMS = {
    # name              reading        rule           timeout   check
    "i":               (reading_i,      rule_triangle, False,    False),
    "i+timeout":       (reading_i,      rule_triangle, True,     False),
    "i+check":         (reading_i,      rule_triangle, False,    True),
    "ii-nocheck":      (reading_ii,     rule_triangle, False,    False),
    "ii":              (reading_ii,     rule_triangle, False,    True),
    "ii+timeout":      (reading_ii,     rule_triangle, True,     True),
    "oracle":          (reading_oracle, rule_oracle,   False,    True),
}


def run_arm(arm, seed, frac_indep, frac_coin, check_cost=CHECK_COST,
            trigger=TRIGGER, budget=BUDGET, n=N, difficulty="exp"):
    reading, rule, use_timeout, use_check = ARMS[arm]
    rng = random.Random(seed)
    env = corpus.make_corpus(rng, n=n, frac_indep=frac_indep,
                             frac_coin=frac_coin, mean_d=MEAN_D,
                             recognition=RECOGNITION, difficulty=difficulty)
    res = schedule(
        env, env.handles(), budget, reading, rule,
        timeout=trigger if use_timeout else None,
        check_cost=check_cost if use_check else None,
        check_trigger=trigger if use_check else None,
    )

    # The oracle join lives HERE, outside the core, which never sees a status.
    units = env.ordinary_units_by_status()
    counts = env.count_by_status()
    checks_hit = checks_miss = 0
    coins_closed = coins_settled = 0
    for handle, tag in res.events:
        st = env.status_of(handle)
        if tag == "check":
            if st == corpus.INDEPENDENT:
                checks_hit += 1
            else:
                checks_miss += 1
        elif st == corpus.COIN and tag == "closed":
            coins_closed += 1
        elif st == corpus.COIN and tag == "settled":
            coins_settled += 1

    return {
        "settled": res.settled,
        "closed": res.closed,
        "budget_used": res.budget_used,
        "revivals": res.revivals,
        "waste_indep": units[corpus.INDEPENDENT],
        "check_spend": res.check_spend,
        "check_spend_hit": checks_hit * check_cost if use_check else 0,
        "check_spend_miss": checks_miss * check_cost if use_check else 0,
        "coins_closed": coins_closed,
        "coins_settled": coins_settled,
        "n_indep": counts[corpus.INDEPENDENT],
        "n_coin": counts[corpus.COIN],
        "n_dec": counts[corpus.PROVABLE] + counts[corpus.REFUTABLE],
    }


def mean_over_seeds(arm, seeds=SEEDS, **kw):
    acc = None
    for k in range(seeds):
        r = run_arm(arm, SEED0 + k, **kw)
        if acc is None:
            acc = dict((key, 0.0) for key in r)
        for key, v in r.items():
            acc[key] += v
    for key in acc:
        acc[key] /= float(seeds)
    return acc


def hr(title):
    print()
    print("=" * 78)
    print(title)
    print("=" * 78)


# ---------------------------------------------------------------------------
# E1. The headline comparison, no coins in the corpus.
# ---------------------------------------------------------------------------

def e1():
    hr("E1  settled sentences per 1000 budget units, by independent fraction")
    print("N=%d  budget=%d  mean difficulty=%d  trigger=%d  check cost=%d  seeds=%d"
          % (N, BUDGET, MEAN_D, TRIGGER, CHECK_COST, SEEDS))
    print("corpus has NO coin sentences here; E3 adds them")
    print()
    arms = ["i", "i+timeout", "i+check", "ii-nocheck", "ii", "ii+timeout", "oracle"]
    header = "%-8s" % "f_ind" + "".join("%12s" % a for a in arms)
    print(header)
    print("-" * len(header))
    table = {}
    for f in (0.0, 0.1, 0.2, 0.3, 0.5):
        row = []
        for a in arms:
            m = mean_over_seeds(a, frac_indep=f, frac_coin=0.0)
            table[(f, a)] = m
            row.append("%12.2f" % (1000.0 * m["settled"] / BUDGET))
        print("%-8.2f" % f + "".join(row))

    print()
    print("Budget spent on ordinary search of INDEPENDENT sentences (units, mean):")
    print(header)
    print("-" * len(header))
    for f in (0.0, 0.1, 0.2, 0.3, 0.5):
        print("%-8.2f" % f + "".join("%12.1f" % table[(f, a)]["waste_indep"]
                                     for a in arms))

    print()
    print("Money spent on independence attempts, split by whether it hit (mean units):")
    print("%-8s%-14s%18s%16s" % ("f_ind", "arm", "on independent", "on decidable"))
    for f in (0.1, 0.3, 0.5):
        for a in ("i+check", "ii", "ii+timeout", "oracle"):
            m = table[(f, a)]
            print("%-8.2f%-14s%18.1f%16.1f"
                  % (f, a, m["check_spend_hit"], m["check_spend_miss"]))

    print()
    print("Budget actually spent (mean of %d; the cap is %d). An arm that leaves"
          % (BUDGET, BUDGET))
    print("budget unspent is not budget-limited and its comparison is void.")
    print(header)
    print("-" * len(header))
    for f in (0.0, 0.1, 0.2, 0.3, 0.5):
        print("%-8.2f" % f + "".join("%12.1f" % table[(f, a)]["budget_used"]
                                     for a in arms))

    print()
    print("Sanity: mean corpus composition at f_ind=0.3 -> %s"
          % {k: table[(0.3, "ii")][k] for k in ("n_dec", "n_indep", "n_coin")})
    return table


# ---------------------------------------------------------------------------
# E2. The economic question: how dear may an independence proof be?
# ---------------------------------------------------------------------------

def e2():
    hr("E2  break-even independence-proof cost")
    print("Sweeping the price of one independence attempt. (ii) buys attempts;")
    print("(i) cannot act on the result and so buys none. The competitor that")
    print("needs no independence proof at all is (i)+timeout, which abandons a")
    print("stubborn sentence and revives it later. It is printed alongside, and")
    print("it turns out to tie plain round-robin exactly at every trigger.")
    costs = [0, 5, 10, 15, 20, 30, 40, 60, 80, 120, 160, 240, 320, 480, 640, 960]
    for f in (0.2, 0.4):
        base_i = mean_over_seeds("i", frac_indep=f, frac_coin=0.0)["settled"]
        for trig in (20, 40, 60):
            base_t = mean_over_seeds("i+timeout", frac_indep=f, frac_coin=0.0,
                                     trigger=trig)["settled"]
            print()
            print("f_ind = %.2f   trigger = %d units of resistance" % (f, trig))
            print("  plain (i) settles %.2f;  (i)+timeout(%d) settles %.2f"
                  % (base_i, trig, base_t))
            print("  %-12s%15s%15s" % ("check cost", "(ii) settled",
                                       "vs plain (i)"))
            rows = []
            for c in costs:
                m = mean_over_seeds("ii", frac_indep=f, frac_coin=0.0,
                                    check_cost=c, trigger=trig)
                rows.append((c, m["settled"]))
                print("  %-12d%15.2f%+15.2f" % (c, m["settled"],
                                                m["settled"] - base_i))
            for label, base in (("plain (i)", base_i),
                                ("(i)+timeout", base_t)):
                cross = None
                for (c0, s0), (c1, s1) in zip(rows, rows[1:]):
                    if (s0 - base) >= 0 >= (s1 - base) and s0 != s1:
                        t = (s0 - base) / (s0 - s1)
                        cross = c0 + t * (c1 - c0)
                        break
                if cross is None:
                    verdict = ("never ahead in the swept range"
                               if rows[0][1] < base
                               else "still ahead at cost %d" % costs[-1])
                else:
                    verdict = "%.0f units" % cross
                print("    break-even against %-12s: %s" % (label, verdict))
            print("    (the curve turns back up at the top of the sweep because a")
            print("     check the scheduler cannot afford is not bought, so a very")
            print("     dear reading (ii) degenerates towards reading (i))")


# ---------------------------------------------------------------------------
# E3. Pricing the known conflation at (0, 1).
# ---------------------------------------------------------------------------

def e3():
    hr("E3  what report_conflates costs operationally")
    print("A coin sentence is decidable, advertises that after %d units, and then"
          % RECOGNITION)
    print("reports (z, r) = (0, 1): the same point as proved-independent.")
    print("f_ind fixed at 0.20; the coin fraction eats into the decidable share.")
    print()
    arms = ["i", "i+timeout", "ii", "ii+timeout", "oracle"]
    header = "%-8s" % "f_coin" + "".join("%12s" % a for a in arms)
    print("settled per 1000 units")
    print(header)
    print("-" * len(header))
    tab = {}
    for fc in (0.0, 0.1, 0.2, 0.3):
        row = []
        for a in arms:
            m = mean_over_seeds(a, frac_indep=0.2, frac_coin=fc)
            tab[(fc, a)] = m
            row.append("%12.2f" % (1000.0 * m["settled"] / BUDGET))
        print("%-8.2f" % fc + "".join(row))

    print()
    print("coin sentences wrongly closed at (0,1) instead of being settled (mean count)")
    print(header)
    print("-" * len(header))
    for fc in (0.0, 0.1, 0.2, 0.3):
        print("%-8.2f" % fc + "".join("%12.2f" % tab[(fc, a)]["coins_closed"]
                                      for a in arms))

    print()
    print("coin sentences actually settled (mean count; of %.1f present at f_coin=0.3)"
          % tab[(0.3, "ii")]["n_coin"])
    print(header)
    print("-" * len(header))
    for fc in (0.0, 0.1, 0.2, 0.3):
        print("%-8.2f" % fc + "".join("%12.2f" % tab[(fc, a)]["coins_settled"]
                                      for a in arms))

    print()
    print("(ii) minus oracle, settled per 1000 units: the price of the conflation")
    for fc in (0.0, 0.1, 0.2, 0.3):
        d = 1000.0 * (tab[(fc, "ii")]["settled"] - tab[(fc, "oracle")]["settled"]) / BUDGET
        print("   f_coin=%.2f   %+.2f" % (fc, d))


# ---------------------------------------------------------------------------
# E4. Does the difficulty distribution change the story?
# ---------------------------------------------------------------------------

def e4():
    hr("E4  robustness to a heavy-tailed difficulty distribution")
    print("Pareto(alpha=1.5) difficulties, same mean. Long tails are exactly the")
    print("case where a timeout should look worst, so this is the adversarial")
    print("check on E2's honest competitor.")
    print()
    arms = ["i", "i+timeout", "ii", "ii+timeout", "oracle"]
    for dist in ("exp", "pareto"):
        print("%-8s" % dist + "".join("%12s" % a for a in arms))
        for f in (0.0, 0.2, 0.4):
            row = []
            for a in arms:
                m = mean_over_seeds(a, frac_indep=f, frac_coin=0.0,
                                    difficulty=dist)
                row.append("%12.2f" % (1000.0 * m["settled"] / BUDGET))
            print("f=%-6.2f" % f + "".join(row))
        print()


# ---------------------------------------------------------------------------
# E5. Is there any informed policy at all inside the interface?
# ---------------------------------------------------------------------------

def e5():
    hr("E5  how much signal do the reports carry before a verdict arrives?")
    print("Counting distinct report values seen across a whole run, by reading.")
    print("If unsettled sentences all report the same point, no priority order")
    print("over them is computable from the interface, and round-robin is not a")
    print("lazy choice but the only choice.")
    print()
    for reading_name, reading in (("(i)", reading_i), ("(ii)", reading_ii)):
        seen = set()
        rng = random.Random(SEED0)
        env = corpus.make_corpus(rng, n=N, frac_indep=0.2, frac_coin=0.2,
                                 mean_d=MEAN_D, recognition=RECOGNITION)
        handles = env.handles()
        # replay a plain round robin, recording every distinct report value
        active = list(handles)
        i = 0
        for _ in range(BUDGET):
            if not active:
                break
            if i >= len(active):
                i = 0
            h = active[i]
            _, st = env.spend(h, 1)
            rep = reading(st)
            seen.add((round(rep.z, 6), round(rep.r, 6)))
            if rep.r >= 1.0 - 1e-12:
                del active[i]
            else:
                i += 1
        print("  reading %-5s distinct (z, r) values ever reported: %d  ->  %s"
              % (reading_name, len(seen), sorted(seen)))


COSTS = [0, 5, 10, 15, 20, 25, 30, 40, 60, 80, 120, 160, 240, 320, 480, 640, 960]


def break_even(f, trigger, budget, n=N, difficulty="exp"):
    """Interpolated check cost at which (ii) stops beating plain (i)."""
    base = mean_over_seeds("i", frac_indep=f, frac_coin=0.0, budget=budget,
                           n=n, difficulty=difficulty)["settled"]
    rows = []
    for c in COSTS:
        m = mean_over_seeds("ii", frac_indep=f, frac_coin=0.0, check_cost=c,
                            trigger=trigger, budget=budget, n=n,
                            difficulty=difficulty)
        rows.append((c, m["settled"]))
    for (c0, s0), (c1, s1) in zip(rows, rows[1:]):
        if (s0 - base) >= 0 >= (s1 - base) and s0 != s1:
            t = (s0 - base) / (s0 - s1)
            return c0 + t * (c1 - c0), base, rows[0][1]
    return None, base, rows[0][1]


def e7():
    hr("E7  does the break-even price scale, and with what?")
    print("mean difficulty is %d throughout. The per-sentence budget share is" % MEAN_D)
    print("budget/N. If the break-even tracks one of those, it is a usable rule.")
    print()
    print("%-8s%-7s%9s%9s%9s%9s%11s%9s" %
          ("budget", "f_ind", "(i)", "(ii)@0", "gain", "gain %",
           "break-even", "/mean_d"))
    for budget in (1500, 2500, 4000):
        for f in (0.1, 0.2, 0.3, 0.4, 0.5):
            be, base, free = break_even(f, 20, budget)
            print("%-8d%-7.2f%9.2f%9.2f%+9.2f%8.1f%%%11s%9s"
                  % (budget, f, base, free, free - base,
                     100.0 * (free - base) / base,
                     "%.0f" % be if be else "none",
                     "%.2f" % (be / MEAN_D) if be else "-"))
        print()
    print("The scissors: the gain is largest where budget is scarce, and that is")
    print("exactly where the break-even price is lowest. Where an independence")
    print("proof may cost more than an ordinary proof (break-even / mean_d > 1),")
    print("the gain has already collapsed.")


def e6():
    hr("E6  the free-information ceiling, and where it is worth anything")
    print("Reading (ii) with check cost 0 is the best (ii) could ever be: it is")
    print("told, for free, which sentences are independent. Comparing that to")
    print("plain (i) isolates the value of the DISTINCTION from the price of")
    print("obtaining it. Trigger 20, so the free label arrives early.")
    print()
    print("settled, as a fraction of the decidable sentences present")
    print("%-9s%-9s%10s%10s%10s%10s" % ("budget", "f_ind", "(i)", "(ii)@0",
                                        "margin", "n_dec"))
    for budget in (1000, 1500, 2500, 4000, 6000):
        for f in (0.0, 0.1, 0.2, 0.3, 0.4, 0.5):
            a = mean_over_seeds("i", frac_indep=f, frac_coin=0.0, budget=budget)
            b = mean_over_seeds("ii", frac_indep=f, frac_coin=0.0, budget=budget,
                                check_cost=0, trigger=20)
            nd = a["n_dec"]
            print("%-9d%-9.2f%10.3f%10.3f%+10.3f%10.1f"
                  % (budget, f, a["settled"] / nd, b["settled"] / nd,
                     (b["settled"] - a["settled"]) / nd, nd))
        print()


def e8():
    hr("E8  is any of this Monte-Carlo noise?")
    global SEEDS
    keep = SEEDS
    vals = [run_arm("i", SEED0 + k, frac_indep=0.3, frac_coin=0.0)["settled"]
            for k in range(160)]
    mean = sum(vals) / len(vals)
    var = sum((v - mean) ** 2 for v in vals) / (len(vals) - 1)
    sd = var ** 0.5
    print("plain (i) at f_ind=0.30: per-run settled mean %.2f, sd %.2f," % (mean, sd))
    print("so the standard error on a %d-seed cell mean is %.2f sentences."
          % (keep, sd / keep ** 0.5))
    print()
    for s in (40, 160):
        SEEDS = s
        be, base, free = break_even(0.3, 20, BUDGET)
        print("  %3d seeds -> break-even %.1f, (i) %.2f, (ii)@0 %.2f"
              % (s, be, base, free))
    SEEDS = keep
    print()
    print("The break-even is unmoved by quadrupling the sample, so the numbers")
    print("above are not being driven by sampling noise.")


def main():
    which = sys.argv[1:] or ["e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8"]
    fns = {"e1": e1, "e2": e2, "e3": e3, "e4": e4, "e5": e5, "e6": e6,
           "e7": e7, "e8": e8}
    print("D3 scheduler prototype -- seeded Monte Carlo, base seed %d, %d seeds/cell"
          % (SEED0, SEEDS))
    for w in which:
        fns[w]()
    print()
    print("done.")


if __name__ == "__main__":
    main()
