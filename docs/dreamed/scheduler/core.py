"""Scheduler core for the ratified D3 prototype.

DREAMED CODE. Unreviewed, outside `make test`, stdlib only.

This module is the "terminating checker" half of the D3 design. It allocates
proof-search budget across sentences it is not allowed to understand.

The binding constraint, from `docs/meeting-notes/2026-09-07-1508-bloch-truth-rulings.md`
D3 and from `logic-counterfactual-boundary.md`: a core that cannot interpret
arithmetic cannot represent proofs at all, because a proof is a finite sequence
and sequences need pairing. So the core is not a theory about proofs. It is a
terminating checker that arithmetic on two rationals per row, plus a decidable
equality on opaque sentence identifiers, is enough to drive.

Everything in this file honours that:

* `Handle` is an opaque atom. It supports equality and nothing else. It is
  unhashable (`__hash__ = None`), so no dictionary or set can be keyed by a
  sentence. It refuses ordering, so no sort can rank sentences. Its `repr` says
  nothing. Reading its one private attribute is recorded by the audit.
* The scheduler never inspects a sentence. It walks its OWN list, by its own
  integer index, and its single use of handle equality is to check that the
  report it just received is about the sentence it just asked about. That is
  the "fourth channel" (the report index) that `logic-counterfactual-boundary.md`
  found missing from `logic-layered-core.md`, and it is exactly what decidable
  equality on opaque atoms buys.
* Every other quantity the scheduler computes is arithmetic on `z`, `r`, and its
  own budget counters.

`audit.py` runs the scheduler on instrumented handles and asserts that the set
of handle operations it performed is a subset of `{eq}`. That is the enforcement.
The comment is not.
"""

_AUDIT = set()
_AUDIT_ON = [False]


def audit_start():
    """Begin recording which handle operations the scheduler performs."""
    _AUDIT.clear()
    _AUDIT_ON[0] = True


def audit_stop():
    """Stop recording and return the set of operations seen."""
    _AUDIT_ON[0] = False
    return set(_AUDIT)


def _note(op):
    if _AUDIT_ON[0]:
        _AUDIT.add(op)


class Handle:
    """An opaque sentence identifier. Decidable equality, and nothing else.

    Deliberately NOT provided: hashing, ordering, iteration, length, any
    accessor for content, any informative repr. A consumer of this type cannot
    parse a sentence, cannot relate it to a subformula, and cannot even put a
    collection of sentences in a canonical order.
    """

    __slots__ = ("_token",)
    __hash__ = None  # unhashable on purpose: no dict or set may be keyed by a sentence

    def __init__(self):
        # An anonymous object. Even a consumer that reaches past the API learns
        # nothing from it, and the audit records the reach.
        object.__setattr__(self, "_token", object())

    def __getattribute__(self, name):
        if name == "_token":
            _note("attr:_token")
        return object.__getattribute__(self, name)

    def __eq__(self, other):
        _note("eq")
        if not isinstance(other, Handle):
            return NotImplemented
        return object.__getattribute__(self, "_token") is object.__getattribute__(
            other, "_token"
        )

    def __ne__(self, other):
        _note("eq")
        result = self.__eq__(other)
        return result if result is NotImplemented else not result

    def __lt__(self, other):
        _note("order")
        raise TypeError("sentences are opaque atoms: no order is available")

    __le__ = __gt__ = __ge__ = __lt__

    def __repr__(self):
        _note("repr")
        return "<sentence>"


class Report:
    """One row of the report triangle: `|z| <= r <= 1`.

    `z = p_proved - p_refuted` is the truth lean, `r = 1 - p_open` is the
    settledness. This is the object D1 ruled to be the real one, the Bloch
    ball's `(z, r)` shadow with the azimuth dropped as gauge.
    """

    __slots__ = ("z", "r")

    def __init__(self, z, r):
        assert abs(z) <= r + 1e-12 <= 1.0 + 1e-12, (z, r)
        self.z = z
        self.r = r

    def __repr__(self):
        return "Report(z=%.3f, r=%.3f)" % (self.z, self.r)


# --------------------------------------------------------------------------
# The two readings, as projections of one and the same epistemic state.
#
# This is where the whole experiment lives. The corpus computes ONE epistemic
# state per sentence. A reading is a function from that state to what the
# scheduler is allowed to see. Nothing else differs between the arms.
# --------------------------------------------------------------------------


def reading_i(state):
    """Reading (i): the state is over MODELS.

    Every such state is diagonal (`logic-models-ensemble.md`), so `r = |z|`, and
    `z = 0` forces `r = 0`. "Proved undecidable, stop asking" and "got nowhere
    yet, spend more budget" are therefore literally the same report.

    Implemented as a projection of the (ii) report so that no other difference
    can creep in: same corpus, same state, same policy, narrower interface.
    """
    z = state.z()
    return Report(z, abs(z))


def reading_ii(state):
    """Reading (ii): the state is over EPISTEMIC STATUS, `{pr, rf, indep, open}`."""
    return Report(state.z(), state.r())


def reading_oracle(state):
    """Diagnostic arm only, NOT part of the (i) versus (ii) comparison.

    Sees the whole four-vector, so it can separate the two inhabitants of the
    point `(0, 1)` that `report_conflates` identifies: proved-independent, and
    certainly-decided-with-no-idea-which-way. Used solely to price that known
    defect of the two-number report.
    """
    return (Report(state.z(), state.r()), state.p_indep)


# --------------------------------------------------------------------------
# Drop rules
#
# (i) and (ii) share ONE rule, verbatim: stop when `r == 1`, and call it settled
# only if `|z| == 1`. The oracle arm needs a richer rule because it has a richer
# interface; that asymmetry is the point of that arm and is not a confound in
# the (i) versus (ii) comparison, which the two share exactly.
# --------------------------------------------------------------------------

CONTINUE = 0
SETTLED = 1
CLOSED = 2  # certain, but not settled either way


def rule_triangle(seen):
    """The shared rule for readings (i) and (ii)."""
    if seen.r >= 1.0 - 1e-12:
        return SETTLED if abs(seen.z) >= 1.0 - 1e-12 else CLOSED
    return CONTINUE


def rule_oracle(seen):
    rep, p_indep = seen
    if abs(rep.z) >= 1.0 - 1e-12:
        return SETTLED
    if p_indep >= 1.0 - 1e-12:
        return CLOSED
    return CONTINUE


class _Row:
    """The scheduler's OWN bookkeeping. Two counters and an opaque atom."""

    __slots__ = ("handle", "spent", "checked")

    def __init__(self, handle):
        self.handle = handle
        self.spent = 0
        self.checked = False


class Result:
    """What the scheduler itself knows when it stops.

    Deliberately thin. The scheduler counts verdicts and budget and nothing
    else; it cannot attribute an outcome to a hidden true status, because it
    cannot see one. `events` is a log of `(handle, tag)` pairs that the
    EXPERIMENT HARNESS, which does hold the oracle, joins against the hidden
    corpus to produce the per-status numbers. Keeping that join outside the core
    is what stops instrumentation from quietly widening the interface.
    """

    __slots__ = ("settled", "closed", "budget_used", "dropped_on_timeout",
                 "check_spend", "revivals", "events")

    def __init__(self):
        self.settled = 0
        self.closed = 0
        self.budget_used = 0
        self.dropped_on_timeout = 0
        self.check_spend = 0
        self.revivals = 0
        self.events = []


def schedule(env, handles, budget, reading, rule, timeout=None, check_cost=None,
             check_trigger=None):
    """Round-robin allocation under one reading of the reports.

    Parameters that are policy, not interface: `timeout` (abandon a sentence
    after this many units without a verdict) and `check_cost`/`check_trigger`
    (buy an independence proof once a sentence has resisted this long). Both are
    made available to EVERY arm, so any advantage an arm shows is an advantage of
    its interface and not of a policy the other arm was denied.

    The scheduler uses handle equality exactly once per report, to check that
    the report is about the sentence it asked about.
    """
    active = [_Row(h) for h in handles]
    deferred = []
    bound = timeout
    remaining = budget
    out = Result()
    idx = 0

    while remaining > 0:
        if not active:
            if not deferred:
                break
            # Nothing left to work on, and budget still in hand. Abandoning a
            # sentence was a deferral, not a verdict, so raise the bound and
            # bring the deferred rows back. This is iterative deepening, and it
            # is what stops the timeout arm being a strawman: every arm spends
            # the whole budget when there is anything at all to spend it on.
            active, deferred = deferred, []
            bound = bound * 2
            out.revivals += 1
            idx = 0
        if idx >= len(active):
            idx = 0
        row = active[idx]

        # 1. Policy actions, both evaluated at the top of a visit so that neither
        #    can pre-empt the other by an accident of ordering. A sentence that
        #    has resisted `check_trigger` units may have an independence proof
        #    bought for it; if that is unavailable or fails, a `timeout` policy
        #    may then abandon it. Both are offered to every arm.
        #
        #    Forcing is not cheap and it can fail: a merely hard decidable
        #    sentence returns nothing and the money is gone.
        if (check_cost is not None and not row.checked
                and row.spent >= check_trigger):
            row.checked = True
            if remaining >= check_cost:
                remaining -= check_cost
                out.check_spend += check_cost
                who, state = env.independence_attempt(row.handle)
                assert who == row.handle  # the one use of decidable equality
                out.events.append((row.handle, "check"))
                verdict = rule(reading(state))
                if verdict != CONTINUE:
                    if verdict == SETTLED:
                        out.settled += 1
                        out.events.append((row.handle, "settled"))
                    else:
                        out.closed += 1
                        out.events.append((row.handle, "closed"))
                    del active[idx]
                    continue

        if bound is not None and row.spent >= bound:
            out.dropped_on_timeout += 1
            deferred.append(row)
            del active[idx]
            continue

        # 2. One quantum of ordinary proof search.
        remaining -= 1
        row.spent += 1
        who, state = env.spend(row.handle, 1)
        assert who == row.handle  # the one use of decidable equality

        verdict = rule(reading(state))
        if verdict == SETTLED:
            out.settled += 1
            out.events.append((row.handle, "settled"))
            del active[idx]
            continue
        if verdict == CLOSED:
            out.closed += 1
            out.events.append((row.handle, "closed"))
            del active[idx]
            continue
        idx += 1

    out.budget_used = budget - remaining
    return out
