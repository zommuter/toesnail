"""Enforcement of the D3 architecture constraint, run as a check rather than asserted.

DREAMED CODE. Unreviewed, outside `make test`, stdlib only.

D3 requires the scheduler to treat sentence identifiers as opaque atoms with
decidable equality only. This module proves that of the actual code, three ways:

1. The `Handle` type structurally refuses hashing and ordering, so no dictionary,
   set, or sort inside the scheduler could be keyed by a sentence even by mistake.
2. A real scheduling run is executed with handle instrumentation switched on, and
   the recorded set of handle operations is asserted to be a subset of `{eq}`.
3. The scheduler module's source is scanned for the escape hatches that would
   let a Python program get structure out of an opaque object anyway.
"""

import os
import re
import random

import core
from core import Handle, schedule, reading_i, reading_ii, rule_triangle
import corpus


def check_type_refuses_structure():
    a, b = Handle(), Handle()
    fails = []

    try:
        hash(a)
        fails.append("Handle is hashable, so a dict could be keyed by a sentence")
    except TypeError:
        pass

    try:
        a < b
        fails.append("Handle is orderable, so sentences could be ranked")
    except TypeError:
        pass

    try:
        sorted([a, b])
        fails.append("a list of Handles can be sorted")
    except TypeError:
        pass

    if not (a == a) or (a == b):
        fails.append("equality is not the identity of the atom")

    if repr(a) != "<sentence>":
        fails.append("repr leaks something")

    return fails


def check_scheduler_only_uses_equality():
    rng = random.Random(20260907)
    env = corpus.make_corpus(rng, n=12, frac_indep=0.25, frac_coin=0.25,
                             mean_d=10, recognition=2)
    handles = env.handles()
    core.audit_start()
    schedule(env, handles, budget=400, reading=reading_ii, rule=rule_triangle,
             timeout=40, check_cost=15, check_trigger=20)
    ops = core.audit_stop()
    return ops


def check_no_escape_hatches():
    # Anchored to this file, not to the caller's cwd: `python3 audit.py` from the
    # repo root otherwise died with FileNotFoundError, which made the audit look
    # broken when it was only mislocated.
    src = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "core.py")).read()
    # Everything after the module docstring: the docstring legitimately names
    # these things while explaining why they are absent.
    body = src.split('"""', 2)[2]
    banned = {
        r"\bid\(": "core calls id() on something",
        r"\bhash\(": "core hashes something",
        r"\bsorted\(": "core sorts something",
        r"\bvars\(": "core reflects with vars()",
        r"__dict__": "core reaches into __dict__",
        r"getattr\(": "core reflects with getattr()",
    }
    hits = []
    for pat, msg in banned.items():
        for m in re.finditer(pat, body):
            line = body[:m.start()].count("\n") + 1
            hits.append("%s (near body line %d)" % (msg, line))
    return hits


def main():
    print("== D3 architecture-constraint audit ==")
    ok = True

    fails = check_type_refuses_structure()
    print("[1] opaque handle type:", "PASS" if not fails else "FAIL")
    for f in fails:
        ok = False
        print("      ", f)

    ops = check_scheduler_only_uses_equality()
    allowed = {"eq"}
    print("[2] handle operations performed by a real scheduling run:",
          sorted(ops) if ops else "(none)")
    if not ops <= allowed:
        ok = False
        print("       FAIL: operations outside {eq}:", sorted(ops - allowed))
    elif "eq" not in ops:
        ok = False
        print("       FAIL: equality was never used, so the report-index channel")
        print("             is not actually being checked")
    else:
        print("       PASS: equality only, and equality is actually used")

    hits = check_no_escape_hatches()
    print("[3] source scan for reflection escape hatches:",
          "PASS" if not hits else "FAIL")
    for h in hits:
        ok = False
        print("      ", h)

    print()
    print("AUDIT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
