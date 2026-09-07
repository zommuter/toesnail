"""The synthetic corpus and its oracle, for the D3 scheduler prototype.

DREAMED CODE. Unreviewed, outside `make test`, stdlib only.

The corpus holds sentences with a HIDDEN true status. The scheduler never sees
a status; it sees only what a reading projects out of the epistemic state. The
oracle side of this module is used by the experiment harness for scoring, never
by `core.schedule`.

Hidden statuses
---------------

* `provable`   settles to `z = +1` once `d` units of ordinary search are spent.
* `refutable`  settles to `z = -1` once `d` units are spent.
* `independent`  never settles under ordinary search, at any budget. An
  independence attempt costing `check_cost` succeeds on it.
* `coin`  the second inhabitant of the point `(0, 1)`. It is decidable and it
  advertises that cheaply, after `recognition` units, but its verdict still
  costs the full `d`. Between those two points it reports
  `(p_pr, p_rf, p_ind, p_open) = (1/2, 1/2, 0, 0)`, hence `z = 0`, `r = 1`, the
  same point as proved-independent. This is `report_conflates` from
  `logic-simplex.md` and `logic-epistemic-state.md`, made operational.

STIPULATION, stated loudly because it bounds every conclusion drawn from this
code: independence here is a label attached at corpus-generation time, not a
fact discovered by a prover. The experiment tests whether the INTERFACE is
actionable given such reports. It does not test whether real provers can
produce them.
"""

import math

from core import Handle

PROVABLE = "provable"
REFUTABLE = "refutable"
INDEPENDENT = "independent"
COIN = "coin"
STATUSES = (PROVABLE, REFUTABLE, INDEPENDENT, COIN)


class State:
    """A point of the epistemic simplex, `(p_pr, p_rf, p_indep, p_open)`."""

    __slots__ = ("p_pr", "p_rf", "p_indep", "p_open")

    def __init__(self, p_pr, p_rf, p_indep, p_open):
        self.p_pr = p_pr
        self.p_rf = p_rf
        self.p_indep = p_indep
        self.p_open = p_open

    def z(self):
        return self.p_pr - self.p_rf

    def r(self):
        return 1.0 - self.p_open


_OPEN = State(0.0, 0.0, 0.0, 1.0)
_PROVED = State(1.0, 0.0, 0.0, 0.0)
_REFUTED = State(0.0, 1.0, 0.0, 0.0)
_INDEP = State(0.0, 0.0, 1.0, 0.0)
_COIN = State(0.5, 0.5, 0.0, 0.0)


class _Sentence:
    __slots__ = ("status", "d", "recognition", "spent", "sign")

    def __init__(self, status, d, recognition, sign=1):
        self.status = status
        self.d = d
        self.recognition = recognition
        self.spent = 0
        self.sign = sign  # for a coin: which way it falls, once paid for


class Environment:
    """Mints opaque handles and answers questions about them.

    Handle resolution is done by the environment, which minted the handles, via
    `id()`. The scheduler never calls `id()` and never could usefully: `audit.py`
    records every handle operation the scheduler performs.
    """

    def __init__(self, sentences):
        self._handles = []          # keeps the handles alive
        self._rows = {}             # id(handle) -> _Sentence
        for s in sentences:
            h = Handle()
            self._handles.append(h)
            self._rows[id(h)] = s

    def handles(self):
        return list(self._handles)

    # ---- interface used by core.schedule -------------------------------

    def spend(self, handle, units):
        s = self._rows[id(handle)]
        s.spent += units
        return handle, self._state(s)

    def independence_attempt(self, handle):
        s = self._rows[id(handle)]
        if s.status == INDEPENDENT:
            return handle, _INDEP
        # Forcing failed. The money is gone and nothing was learned.
        return handle, self._state(s)

    # ---- oracle, used only by the experiment harness -------------------

    def status_of(self, handle):
        return self._rows[id(handle)].status

    def ordinary_units_by_status(self):
        acc = dict((k, 0) for k in STATUSES)
        for s in self._rows.values():
            acc[s.status] += s.spent
        return acc

    def count_by_status(self):
        acc = dict((k, 0) for k in STATUSES)
        for s in self._rows.values():
            acc[s.status] += 1
        return acc

    # ---- internals ------------------------------------------------------

    @staticmethod
    def _state(s):
        if s.status == PROVABLE:
            return _PROVED if s.spent >= s.d else _OPEN
        if s.status == REFUTABLE:
            return _REFUTED if s.spent >= s.d else _OPEN
        if s.status == INDEPENDENT:
            return _OPEN
        # COIN
        if s.spent >= s.d:
            return _PROVED if s.sign > 0 else _REFUTED
        if s.spent >= s.recognition:
            return _COIN
        return _OPEN


def make_corpus(rng, n, frac_indep, frac_coin, mean_d, recognition,
                difficulty="exp", pareto_alpha=1.5):
    """Build `n` sentences with the given hidden-status mix.

    `difficulty` is `exp` (memoryless, mean `mean_d`) or `pareto` (heavy tailed,
    same mean by construction). The remaining mass after the independent and
    coin fractions is split evenly between provable and refutable.
    """
    def draw_d():
        u = rng.random()
        if difficulty == "exp":
            return max(1, int(-mean_d * math.log(1.0 - u)))
        if difficulty == "pareto":
            scale = mean_d * (pareto_alpha - 1.0) / pareto_alpha
            return max(1, int(scale * (1.0 - u) ** (-1.0 / pareto_alpha)))
        raise ValueError(difficulty)

    n_ind = int(round(n * frac_indep))
    n_coin = int(round(n * frac_coin))
    n_dec = n - n_ind - n_coin
    if n_dec < 0:
        raise ValueError("independent + coin fractions exceed 1")

    out = []
    for i in range(n_dec):
        out.append(_Sentence(PROVABLE if i % 2 == 0 else REFUTABLE, draw_d(), 0))
    for _ in range(n_ind):
        out.append(_Sentence(INDEPENDENT, 0, 0))
    for i in range(n_coin):
        out.append(_Sentence(COIN, draw_d(), recognition, 1 if i % 2 == 0 else -1))
    rng.shuffle(out)
    return Environment(out)
