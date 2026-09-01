"""Real assertions against the owner's closed forms.

Run:  uv run --with numpy --with scipy --with pytest python -m pytest tests -q
"""

from __future__ import annotations

import numpy as np
import pytest
from scipy.signal import lfilter

from resogram.compare import morlet_cwt_power, pre_echo_db, stft_power
from resogram.core import (
    apply_ebar,
    ebar_kernel,
    make_bank,
    resonate,
    specific_energy,
    steady_state_amplitude,
)
from resogram.live import StreamingBank

SR = 22050.0


def _single(f, Q, normalize=True):
    return make_bank(SR, freqs_hz=np.array([f]), Q=Q, normalize=normalize)


@pytest.mark.parametrize("f", [110.0, 440.0, 1760.0])
@pytest.mark.parametrize("Q", [5.0, 20.0, 80.0])
def test_on_resonance_steady_state_amplitude(f, Q):
    """Drive at resonance; steady-state |x| must equal the closed form Q.

    physics/Resogram.md handle `eom` with y = cos(omega t) gives, in the
    steady state, x = |H_x(i*omega)| cos(omega t + arg H) with
    |H_x(i*omega)| = omega**2/(2*beta*omega) = omega/(2*beta) = Q.
    """
    bank = _single(f, Q)
    omega = bank.omega[0]
    # Let the transient (time constant 1/beta) die: 12 e-foldings.
    n = int(SR * 12.0 * (2 * Q / omega))
    n = min(max(n, int(0.5 * SR)), int(20 * SR))
    t = np.arange(n) / SR
    y = np.cos(omega * t)
    x, x_t = resonate(bank, y, 0)
    tail = slice(int(0.8 * n), None)
    amp = np.abs(x[tail]).max()
    rel = abs(amp - Q) / Q
    assert rel < 2e-3, f"f={f} Q={Q}: |x|={amp:.6f} vs Q={Q}, rel={rel:.2e}"


@pytest.mark.parametrize("f", [110.0, 440.0, 1760.0])
@pytest.mark.parametrize("Q", [5.0, 20.0, 80.0])
def test_on_resonance_steady_state_energy(f, Q):
    """Steady-state energy must equal (Q*omega)**2/2.

    e = x_t**2/2 + omega**2 x**2/2; on resonance x_t leads x by 90 degrees with
    amplitude omega*Q, so e = (Q*omega)**2/2 exactly and CONSTANT in time.
    """
    bank = _single(f, Q)
    omega = bank.omega[0]
    # 24 e-foldings of the transient (time constant 1/beta = 2*Q/omega), then
    # measure only the last 10 %, so the residual transient is below 1e-8.
    n = min(max(int(SR * 48 * Q / omega), int(0.5 * SR)), int(30 * SR))
    t = np.arange(n) / SR
    y = np.cos(omega * t)
    x, x_t = resonate(bank, y, 0)
    e = specific_energy(bank, x, x_t, 0)
    tail = e[int(0.9 * n) :]
    expect = (Q * omega) ** 2 / 2.0
    rel = abs(tail.mean() - expect) / expect
    ripple = (tail.max() - tail.min()) / tail.mean()
    assert rel < 5e-3, f"f={f} Q={Q}: e={tail.mean():.6e} vs {expect:.6e}, rel={rel:.2e}"
    # The residual ripple is a pure discretisation artefact: the velocity
    # channel's phase relative to i*omega*x. Bound it by that measured phase
    # error (times 2, plus a floor), which is a test of the error MODEL, not a
    # rubber-stamp tolerance. Measured range at sr=22050: 1.6e-5 (110 Hz, Q=5)
    # to 3.3e-2 (1760 Hz, Q=5).
    z = np.exp(1j * omega / SR)
    P = lambda cc: cc[0] + cc[1] / z + cc[2] / z**2  # noqa: E731
    ratio = P(bank.b_v[0]) / P(bank.b_x[0]) / (1j * omega)
    phase_err = abs(np.angle(ratio))
    assert ripple < 2.0 * phase_err + 1e-4, (
        f"f={f} Q={Q}: ripple {ripple:.2e} exceeds 2*phase_err={2*phase_err:.2e}"
    )


@pytest.mark.parametrize("sr", [22050.0, 44100.0, 88200.0])
def test_energy_ripple_vanishes_as_sample_rate_rises(sr):
    """Convergence check: the on-resonance energy ripple is O(1/sr).

    Measured (f=1760 Hz, Q=5): 1.7e-2 at 22050, 4.2e-3 at 44100, 1.0e-3 at
    88200, i.e. it falls by about 4x per doubling, so it is a discretisation
    artefact and not a modelling error.
    """
    f, Q = 1760.0, 5.0
    bank = make_bank(sr, freqs_hz=np.array([f]), Q=Q)
    omega = bank.omega[0]
    n = int(sr * 0.5)
    t = np.arange(n) / sr
    x, x_t = resonate(bank, np.cos(omega * t), 0)
    e = specific_energy(bank, x, x_t, 0)
    tail = e[int(0.8 * n) :]
    ripple = (tail.max() - tail.min()) / tail.mean()
    budget = {22050.0: 2.0e-2, 44100.0: 5.0e-3, 88200.0: 1.3e-3}[sr]
    assert ripple < budget, f"sr={sr}: ripple {ripple:.2e} > {budget:.1e}"


@pytest.mark.parametrize("f", [220.0, 880.0])
def test_off_resonance_transfer_function(f):
    """Off-resonance gain must track the continuous H_x(i*w) closely."""
    Q = 20.0
    bank = _single(f, Q)
    omega = bank.omega[0]
    for ratio in (0.5, 0.9, 1.1, 2.0):
        wd = omega * ratio
        n = int(SR * 2.0)
        t = np.arange(n) / SR
        y = np.cos(wd * t)
        x, _ = resonate(bank, y, 0)
        amp = np.abs(x[int(0.7 * n) :]).max()
        expect = abs(steady_state_amplitude(omega, bank.beta[0], wd))
        rel = abs(amp - expect) / expect
        assert rel < 0.05, f"f={f} ratio={ratio}: {amp:.5f} vs {expect:.5f} rel={rel:.2e}"


def test_undamped_conserves_energy():
    """beta -> 0: after an impulse the free oscillator holds its energy.

    Q = 1e7 makes beta/omega = 5e-8; over 1 s at 440 Hz the analytic decay is
    exp(-2*beta*t) = 1 - 2.8e-4, so we require the numerical drift to stay
    within 1e-3 relative.
    """
    Q = 1e7
    bank = _single(440.0, Q, normalize=True)
    n = int(SR * 1.0)
    y = np.zeros(n)
    y[0] = 1.0
    x, x_t = resonate(bank, y, 0)
    e = specific_energy(bank, x, x_t, 0)
    # Skip the first ring-up cycle, then compare early vs late peak energy.
    k0 = int(0.05 * SR)
    early = e[k0 : k0 + int(0.05 * SR)].max()
    late = e[-int(0.05 * SR) :].max()
    rel = abs(late - early) / early
    assert rel < 1e-3, f"energy drift {rel:.2e} for Q={Q:g} (analytic loss 2.8e-4)"


@pytest.mark.parametrize("Q", [5.0, 20.0, 60.0])
def test_energy_decay_rate_is_two_beta(Q):
    """Fit the free ring-down: log e must fall at exactly 2*beta.

    physics/Resogram.md handle `esol`:
        e = (A**2 omega/2) exp(-2*beta*t) (omega + beta cos(2(Omega t + phi) - delta))
    so the ENVELOPE decays at 2*beta. We fit the log of the per-half-period
    maxima, which removes the cos ripple.
    """
    f = 440.0
    bank = _single(f, Q)
    beta = bank.beta[0]
    Omega = bank.Omega[0]
    n = int(SR * 12.0 / (2 * beta))
    n = min(n, int(6 * SR))
    y = np.zeros(n)
    y[0] = 1.0
    x, x_t = resonate(bank, y, 0)
    e = specific_energy(bank, x, x_t, 0)
    # Use the ripple-free ebar envelope (sign = -1) so the fit sees a pure
    # exponential rather than the cos(2*Omega*t) modulation of `esol`.
    env = apply_ebar(bank, e, 0, sign=-1)
    lo = int(2 * np.pi / Omega * SR)  # skip the first two half periods
    hi = n
    t = np.arange(lo, hi) / SR
    keep = env[lo:hi] > env[lo:hi].max() * 1e-10
    slope = np.polyfit(t[keep], np.log(env[lo:hi][keep]), 1)[0]
    rel = abs(-slope - 2 * beta) / (2 * beta)
    assert rel < 1e-3, f"Q={Q}: fitted decay {-slope:.5f} vs 2*beta={2*beta:.5f} rel={rel:.2e}"


@pytest.mark.parametrize("Q", [10.0, 20.0, 60.0])
def test_ebar_minus_sign_removes_the_ripple(Q):
    """sign = -1 turns e into its clean envelope: the ripple cancels.

    Analytically (sympy, see the essay) ebar with exp(-2*beta*tp) equals
    (A**2 omega**2/2) exp(-2*beta*t) exactly, so ebar/e_envelope must be flat.
    """
    bank = _single(440.0, Q)
    beta = bank.beta[0]
    n = int(SR * 3.0 / (2 * beta))
    y = np.zeros(n)
    y[0] = 1.0
    x, x_t = resonate(bank, y, 0)
    e = specific_energy(bank, x, x_t, 0)
    eb = apply_ebar(bank, e, 0, sign=-1)
    lo, hi = int(0.2 * n), int(0.9 * n)
    t = np.arange(n) / SR
    # Divide out the analytic envelope; what remains must be constant.
    ratio = eb[lo:hi] * np.exp(2 * beta * t[lo:hi])
    ripple = (ratio.max() - ratio.min()) / ratio.mean()
    raw = e[lo:hi] * np.exp(2 * beta * t[lo:hi])
    raw_ripple = (raw.max() - raw.min()) / raw.mean()
    assert ripple < 1e-3, f"Q={Q}: ebar(-) residual ripple {ripple:.2e}"
    assert ripple < raw_ripple / 50.0, f"Q={Q}: {ripple:.2e} vs raw {raw_ripple:.2e}"


def test_ebar_plus_sign_as_written_does_not_remove_the_ripple():
    """The kernel EXACTLY as printed in Resogram.md leaves a residual ripple.

    This is the evidence for a SURFACED finding, not a fix: with exp(+2*beta*tp)
    the sympy integral keeps a cos(2*Omega*t - delta + 2*phi) term. The AI does
    not edit the theory; the owner decides.
    """
    Q = 20.0
    bank = _single(440.0, Q)
    beta = bank.beta[0]
    n = int(SR * 3.0 / (2 * beta))
    y = np.zeros(n)
    y[0] = 1.0
    x, x_t = resonate(bank, y, 0)
    e = specific_energy(bank, x, x_t, 0)
    t = np.arange(n) / SR
    lo, hi = int(0.2 * n), int(0.9 * n)
    env = np.exp(2 * beta * t[lo:hi])
    plus = apply_ebar(bank, e, 0, sign=+1)[lo:hi] * env
    minus = apply_ebar(bank, e, 0, sign=-1)[lo:hi] * env
    r_plus = (plus.max() - plus.min()) / plus.mean()
    r_minus = (minus.max() - minus.min()) / minus.mean()
    assert r_plus > 10 * r_minus, f"plus {r_plus:.2e} vs minus {r_minus:.2e}"
    # Both still decay at 2*beta: the printed kernel rescales, it does not flatten.
    assert 0.9 < (plus.max() / minus.max()) < 1.5


def test_ebar_kernel_length_is_half_period():
    bank = _single(440.0, 20.0)
    k = ebar_kernel(bank, 0, sign=-1)
    expect = int(round(np.pi / (bank.Omega[0] / SR)))
    assert len(k) == expect
    assert k[0] > k[-1], "sign=-1 kernel must decay into the past"
    assert ebar_kernel(bank, 0, sign=+1)[0] < ebar_kernel(bank, 0, sign=+1)[-1]
    # Closed-form mass: (Omega/pi) * (1 - exp(-2*beta*pi/Omega)) / (2*beta).
    beta, Omega = bank.beta[0], bank.Omega[0]
    mass = (Omega / np.pi) * (1 - np.exp(-2 * beta * np.pi / Omega)) / (2 * beta)
    assert abs(k.sum() - mass) / mass < 2e-3, f"{k.sum():.5f} vs {mass:.5f}"


def test_causality_impulse_response_is_zero_before_t0():
    """h(t) = 0 for t < 0: no output before the drive. Exact, not approximate."""
    bank = make_bank(SR, f_min=110.0, f_max=4000.0, bins_per_octave=6, Q=20.0)
    n = int(SR * 0.5)
    onset = n // 2
    y = np.zeros(n)
    y[onset] = 1.0
    for i in range(len(bank)):
        x, x_t = resonate(bank, y, i)
        e = specific_energy(bank, x, x_t, i)
        assert np.all(e[:onset] == 0.0), f"resonator {i} responded before the impulse"


def test_no_pre_echo_versus_stft_and_cwt():
    """The measurable claim: resogram pre-echo is exactly -inf dB, the others are not."""
    Q = 20.0
    n = int(SR * 0.6)
    onset = n // 2
    y = np.zeros(n)
    y[onset] = 1.0
    t_onset = onset / SR
    hop = 32

    from resogram.core import resogram as reso

    freqs, times, E = reso(y, SR, hop=hop, f_min=110.0, f_max=4000.0,
                           bins_per_octave=6, Q=Q)
    k = int(np.argmin(np.abs(freqs - 880.0)))
    guard = 0.002
    res_pre = pre_echo_db(times, E[k], t_onset, guard)
    assert res_pre == float("-inf"), f"resogram pre-echo {res_pre} should be -inf"

    _, C = morlet_cwt_power(y, SR, freqs, Q, hop=hop)
    cwt_pre = pre_echo_db(times, C[k], t_onset, guard)
    assert cwt_pre > -60.0, f"Morlet CWT should pre-echo strongly, got {cwt_pre:.1f} dB"

    nper = 2048
    sf, st, S = stft_power(y, SR, nper, hop=hop)
    ks = int(np.argmin(np.abs(sf - 880.0)))
    stft_pre = pre_echo_db(st, S[ks], t_onset, guard)
    assert stft_pre > -60.0, f"STFT should pre-echo, got {stft_pre:.1f} dB"


def test_streaming_matches_batch():
    """Block streaming must reproduce batch filtering (the live-mode invariant)."""
    bank = make_bank(SR, f_min=220.0, f_max=2000.0, bins_per_octave=6, Q=16.0)
    rng = np.random.default_rng(7)
    y = rng.standard_normal(8192)
    sb = StreamingBank(bank)
    blocks = [sb.push(y[i : i + 700]) for i in range(0, len(y), 700)]
    streamed = np.concatenate(blocks, axis=1)
    batch = np.empty_like(streamed)
    for i in range(len(bank)):
        x, x_t = resonate(bank, y, i)
        batch[i] = specific_energy(bank, x, x_t, i)
    rel = np.abs(streamed - batch).max() / batch.max()
    assert rel < 1e-12, f"streaming/batch mismatch {rel:.2e}"


def test_impulse_response_matches_analytic_kernel():
    """The discrete filter must reproduce the owner's `sol` convolution kernel.

    physics/Resogram.md handle `sol` has kernel
        K(t) = (omega**2/Omega) * sin(Omega*t) * exp(-beta*t).
    """
    f, Q = 440.0, 20.0
    bank = _single(f, Q)
    omega, beta, Omega = bank.omega[0], bank.beta[0], bank.Omega[0]
    n = int(SR * 0.2)
    y = np.zeros(n)
    y[0] = SR  # discrete approximation of a unit Dirac (area 1 at rate SR)
    x, _ = resonate(bank, y, 0)
    t = np.arange(n) / SR
    K = (omega**2 / Omega) * np.sin(Omega * t) * np.exp(-beta * t)
    rel = np.abs(x - K).max() / np.abs(K).max()
    assert rel < 5e-3, f"impulse response deviates from analytic kernel by {rel:.2e}"


def test_normalization_reduces_gain_error():
    """The normalize=True gain correction must beat plain impulse invariance."""
    f, Q = 4000.0, 20.0
    errs = {}
    for norm in (False, True):
        bank = _single(f, Q, normalize=norm)
        omega = bank.omega[0]
        n = int(SR * 1.0)
        t = np.arange(n) / SR
        x, _ = resonate(bank, np.cos(omega * t), 0)
        amp = np.abs(x[int(0.7 * n) :]).max()
        errs[norm] = abs(amp - Q) / Q
    assert errs[True] < errs[False]
    assert errs[True] < 2e-3, f"normalized error {errs[True]:.2e}"


def test_bank_is_constant_q_scale_invariant():
    """h_omega(t) = omega * psi(omega*t): the bank is a wavelet-style dilation family.

    This is the fact that makes the resogram a constant-Q filterbank rather
    than a fixed-resolution one, and it is the crux of the CWT comparison.
    """
    Q = 20.0
    f1, f2 = 200.0, 400.0
    n = 4096
    imp = np.zeros(n)
    imp[0] = SR
    b1 = _single(f1, Q)
    b2 = _single(f2, Q)
    x1, _ = resonate(b1, imp, 0)
    x2, _ = resonate(b2, imp, 0)
    # Compare x2(t) with the dilated x1: x2(t) = 2 * x1(2*t) for f2 = 2*f1.
    idx = np.arange(n // 2)
    ref = 2.0 * np.interp(idx * 2.0, np.arange(n), x1)
    rel = np.abs(x2[: n // 2] - ref).max() / np.abs(ref).max()
    assert rel < 5e-3, f"scale invariance broken, rel={rel:.2e}"


def test_lfilter_state_dims_sanity():
    """Guard against a scipy API change silently breaking the streaming path."""
    b = np.array([0.0, 1.0, 0.0])
    a = np.array([1.0, -0.5, 0.25])
    out, zf = lfilter(b, a, np.ones(10), zi=np.zeros(2))
    assert out.shape == (10,) and zf.shape == (2,)
