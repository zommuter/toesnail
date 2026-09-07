---
title: D3 scheduler prototype (code)
permalink: /dreamed/scheduler/
---

# `docs/dreamed/scheduler/` -- the ratified D3 prototype

This directory holds the small scheduler that
[`docs/meeting-notes/2026-09-07-1508-bloch-truth-rulings.md`](../../meeting-notes/2026-09-07-1508-bloch-truth-rulings)
**D3** ordered built. D3 is an owner-ratified decision. The code here is not: it
is **dreamed code**, written by an agent, unreviewed, deliberately outside
`tests/` and outside `make test`, and it must not be wired into either. Its
findings are recommendations awaiting the owner's ruling, exactly like every
other file under `docs/dreamed/`.

The write-up, with the numbers and what they do and do not settle, is
[`docs/dreamed/logic-scheduler-prototype.md`](../logic-scheduler-prototype).

## What it is for

D3 left the cluster's central fork open on purpose and made it an empirical
question. Reading **(i)** says the state is over models, so every state is
diagonal, `r = |z|`, and `z = 0` forces `r = 0`. Reading **(ii)** says the state
is over epistemic status, so `(0, 0)` and `(0, 1)` are different points. The
practical difference is whether *"proved undecidable, stop asking"* and *"got
nowhere yet, spend more budget"* are the same report or two reports. This code
builds a scheduler that allocates proof-search budget from such reports, runs it
under both readings over identical corpora, and measures the difference.

## Layout

| File | What it does |
|---|---|
| `core.py` | The scheduler. The opaque `Handle` type, the `(z, r)` `Report`, the two readings as projections of one epistemic state, and the shared allocation policy. |
| `corpus.py` | The synthetic corpus of sentences with hidden true statuses, and the oracle used for scoring (never by the scheduler). |
| `audit.py` | Enforces the D3 architecture constraint as a runnable check, three ways. |
| `experiment.py` | Eight experiment blocks, `e1` through `e8`. Seeded Monte Carlo, 40 seeds per cell, base seed `20260907`. |
| `run.sh` | Runs everything under `../capped.sh`. |

## How to run it

```
./run.sh                      # audit.py, then all eight experiment blocks
./run.sh experiment.py e3     # one block
./run.sh audit.py             # just the architecture-constraint audit
```

Everything goes through [`../capped.sh`](../capped.sh), which puts the run in a
systemd user scope with a hard cgroup memory limit (`MemoryMax=2G`),
`MemorySwapMax=0`, and a one-core CPU quota. An exit code of 137 means the cap
fired, which is the guard working. Stdlib Python only, no third-party packages,
no network. The whole suite takes about twenty seconds on one core.

## The architecture constraint, and how it is enforced

D3 binds the prototype with a result from
[`logic-counterfactual-boundary.md`](../logic-counterfactual-boundary): a core
that cannot interpret arithmetic cannot represent proofs at all, because a proof
is a finite sequence and sequences need pairing. So the scheduler is a
terminating checker, not a complete theory, and it gets **decidable equality on
opaque atoms and nothing else**.

That is enforced rather than asserted. `core.Handle` is unhashable
(`__hash__ = None`, so no dictionary or set can be keyed by a sentence), refuses
every comparison operator (so no sort can rank sentences), carries no accessor
for content, and has an uninformative `repr`. `audit.py` then runs a real
scheduling pass with handle instrumentation on and asserts that the set of
handle operations the scheduler performed is a subset of `{eq}`, and greps
`core.py` for the reflection escape hatches that would let a Python program get
structure out of an opaque object anyway. It prints `AUDIT: PASS` or fails.

The scheduler's single use of equality is to check that the report it just
received is about the sentence it just asked about. That is the "fourth channel",
the report index, that `logic-counterfactual-boundary.md` found missing from
`logic-layered-core.md`.

## The stipulation that bounds everything here

The `independent` label is **attached at corpus-generation time, not discovered
by a prover**. This is a simulation. It tests whether the interface is
*actionable* given such reports. It does not test, and cannot test, whether real
provers can produce them.
