"""Resonator bank and energy computation.

Physics (owner's file: physics/Resogram.md, handles `eom`, `e`, `edot`, `sol`).
Each resonator obeys the driven damped harmonic oscillator

    x_tt + 2*beta*x_t + omega**2 * (x - y) = 0

driven by the audio signal y(t), with specific energy

    e = x_t**2 / 2 + omega**2 * x**2 / 2

and the sliding half-period average with the owner's growing kernel

    ebar(t) = (Omega/pi) * int_0^{pi/Omega} e(t - tp) * exp(+2*beta*tp) dtp.

Naming follows the owner's Lean convention (`lean-derivative-naming`): the
subscript names the differentiation variable, so x_t and x_tt, never xd/xdd.

DISCRETIZATION
--------------
The continuous transfer function from drive y to displacement x is

    H_x(s) = omega**2 / (s**2 + 2*beta*s + omega**2)

whose impulse response is exactly the convolution kernel that appears in the
owner's analytic solution (handle `sol`):

    h_x(t) = (omega**2 / Omega) * exp(-beta*t) * sin(Omega*t) * u(t),
    Omega  = sqrt(omega**2 - beta**2).

We use IMPULSE INVARIANCE: sample h_x at the audio rate and scale by the sample
period T so the discrete convolution approximates the continuous integral,
h_d[n] = T * h_x(n*T).  With the standard z-transform pairs

    Z{r**n * sin(w*n)} = r*sin(w)*z**-1 / D(z)
    Z{r**n * cos(w*n)} = (1 - r*cos(w)*z**-1) / D(z)
    D(z) = 1 - 2*r*cos(w)*z**-1 + r**2 * z**-2

with r = exp(-beta*T) and w = Omega*T, the displacement filter is

    b_x = T * (omega**2 / Omega) * [0, r*sin(w), 0]
    a   = [1, -2*r*cos(w), r**2]

The velocity channel uses the SAME denominator (same poles).  Because
h_x(0) = 0 there is no delta term, and

    h_v(t) = dh_x/dt = (omega**2/Omega)*exp(-beta*t)*(Omega*cos(Omega*t)
                                                      - beta*sin(Omega*t))

so
    b_v = T * omega**2 * [1, -r*(cos(w) + (beta/Omega)*sin(w)), 0].

Impulse invariance aliases: the sampled kernel's response at the resonance is
not exactly the continuous H_x(i*omega) = -i*Q.  With `normalize=True` (the
default) both numerators are rescaled by the SAME real gain

    g = |H_x(i*omega)| / |H_d(exp(i*omega*T))|

which restores the exact continuous on-resonance gain and, being common to both
channels, leaves the energy identity e = (x_t**2 + omega**2 x**2)/2 intact.
Measured effect: see tests/test_core.py and demo.py.

Q AND RESOLUTION
----------------
beta = omega / (2*Q) makes the bank constant-Q: the impulse response satisfies
h_omega(t) = omega * psi(omega*t) with psi depending only on Q, i.e. every
resonator is the same shape stretched in time.  The ring-down time is
1/beta = 2*Q/omega, so higher Q buys frequency resolution (bandwidth
approximately omega/Q rad/s) and pays for it in time smearing, linearly in Q.
This is the same trade the STFT window length makes, except the resonator is
strictly causal: h(t) = 0 for t < 0, so it can never pre-echo.
"""

from __future__ import annotations

from dataclasses import dataclass

import numpy as np
from scipy.signal import lfilter


@dataclass
class ResonatorBank:
    """A log-spaced bank of second-order resonators at one sample rate."""

    sr: float
    freqs_hz: np.ndarray  # (n_freqs,) natural frequencies f = omega/(2*pi)
    Q: float
    b_x: np.ndarray  # (n_freqs, 3) displacement numerators
    b_v: np.ndarray  # (n_freqs, 3) velocity numerators
    a: np.ndarray  # (n_freqs, 3) shared denominators
    gain: np.ndarray  # (n_freqs,) applied normalization gain

    @property
    def omega(self) -> np.ndarray:
        return 2.0 * np.pi * self.freqs_hz

    @property
    def beta(self) -> np.ndarray:
        return self.omega / (2.0 * self.Q)

    @property
    def Omega(self) -> np.ndarray:
        """Damped (eigen) frequency, distinct from the free frequency omega."""
        return np.sqrt(self.omega**2 - self.beta**2)

    def __len__(self) -> int:
        return len(self.freqs_hz)


def log_freqs(f_min: float, f_max: float, bins_per_octave: int) -> np.ndarray:
    """Geometrically spaced centre frequencies, inclusive of f_min."""
    n_oct = np.log2(f_max / f_min)
    n = int(np.floor(n_oct * bins_per_octave)) + 1
    return f_min * 2.0 ** (np.arange(n) / bins_per_octave)


def make_bank(
    sr: float,
    f_min: float = 55.0,
    f_max: float | None = None,
    bins_per_octave: int = 12,
    Q: float = 20.0,
    freqs_hz: np.ndarray | None = None,
    normalize: bool = True,
) -> ResonatorBank:
    """Build a constant-Q resonator bank.

    Q > 0.5 is required for an underdamped resonator (Omega real).
    """
    if Q <= 0.5:
        raise ValueError("Q must exceed 0.5 for an underdamped resonator")
    if freqs_hz is None:
        if f_max is None:
            f_max = 0.45 * sr
        freqs_hz = log_freqs(f_min, f_max, bins_per_octave)
    freqs_hz = np.atleast_1d(np.asarray(freqs_hz, dtype=float))
    if np.any(freqs_hz >= 0.5 * sr):
        raise ValueError("resonator frequency at or above Nyquist")

    T = 1.0 / sr
    omega = 2.0 * np.pi * freqs_hz
    beta = omega / (2.0 * Q)
    Omega = np.sqrt(omega**2 - beta**2)

    r = np.exp(-beta * T)
    w = Omega * T
    c, s = np.cos(w), np.sin(w)

    zeros = np.zeros_like(freqs_hz)
    b_x = np.stack([zeros, T * (omega**2 / Omega) * r * s, zeros], axis=1)
    b_v = np.stack(
        [
            T * omega**2 * np.ones_like(freqs_hz),
            -T * omega**2 * r * (c + (beta / Omega) * s),
            zeros,
        ],
        axis=1,
    )
    a = np.stack([np.ones_like(freqs_hz), -2.0 * r * c, r**2], axis=1)

    gain = np.ones((len(freqs_hz), 2))
    if normalize:
        # Impulse invariance aliases: the sampled kernel's response at the
        # resonance is not exactly the continuous one. Rescale EACH channel by a
        # real factor so its on-resonance magnitude is exact:
        #   |H_x(i*omega)| = omega/(2*beta) = Q,   |H_v(i*omega)| = omega*Q.
        # Measured on this machine (sr = 22050): the displacement channel needs
        # essentially no correction (2.7e-11 relative at 110 Hz, 4.7e-4 at
        # 8 kHz), while the velocity channel is high by exactly beta*T, which
        # would otherwise put a 2*beta*T ripple on an energy that should be
        # flat. Correcting the channels separately makes x_t no longer the exact
        # discrete derivative of x; the residual inconsistency is the velocity
        # channel's PHASE error, measured at 3.3e-5 rad at 110 Hz rising to
        # 0.07 rad at 8 kHz. Pass normalize=False for the raw impulse-invariant
        # filters.
        z = np.exp(1j * omega * T)
        den = a[:, 0] + a[:, 1] / z + a[:, 2] / z**2
        h_x = (b_x[:, 0] + b_x[:, 1] / z + b_x[:, 2] / z**2) / den
        h_v = (b_v[:, 0] + b_v[:, 1] / z + b_v[:, 2] / z**2) / den
        gain = np.stack([Q / np.abs(h_x), omega * Q / np.abs(h_v)], axis=1)
        b_x = b_x * gain[:, 0:1]
        b_v = b_v * gain[:, 1:2]

    return ResonatorBank(sr=sr, freqs_hz=freqs_hz, Q=Q, b_x=b_x, b_v=b_v, a=a, gain=gain)


def resonate(bank: ResonatorBank, y: np.ndarray, index: int) -> tuple[np.ndarray, np.ndarray]:
    """Drive resonator `index` with y and return (x, x_t) at the audio rate."""
    y = np.asarray(y, dtype=float)
    x = lfilter(bank.b_x[index], bank.a[index], y)
    x_t = lfilter(bank.b_v[index], bank.a[index], y)
    return x, x_t


def specific_energy(bank: ResonatorBank, x: np.ndarray, x_t: np.ndarray, index: int) -> np.ndarray:
    """e = x_t**2/2 + omega**2 * x**2/2  (owner's handle `e`)."""
    omega = bank.omega[index]
    return 0.5 * x_t**2 + 0.5 * omega**2 * x**2


def ebar_kernel(bank: ResonatorBank, index: int, sign: int = -1) -> np.ndarray:
    """Discretised sliding half-period average kernel of the owner's `ebar`.

    physics/Resogram.md ends with

        ebar(t) := (Omega/pi) * int_0^{pi/Omega} e(t - tp) * exp(+2*beta*tp) dtp

    which is `sign = +1` here. `sign = -1` uses exp(-2*beta*tp) instead.

    SURFACED, NOT DECIDED (see docs/dreamed/resogram-library.md): substituting
    the owner's own closed form `esol` and integrating symbolically gives

      sign = -1:  ebar(t) = (A**2 * omega**2 / 2) * exp(-2*beta*t)   EXACTLY,
                  i.e. the ripple cancels identically and ebar is the clean
                  energy envelope, which is what "a sensible sliding average"
                  would be for.
      sign = +1:  a surviving cos/sin(2*Omega*t - delta + 2*phi) ripple of
                  amplitude of order beta**2, times a prefactor that grows like
                  exp(4*pi*beta/Omega).

    Either way the FIR is strictly causal, which is the property the resogram
    trades on. The default here is -1 because it is the one that does the job;
    the owner decides which he meant. Nothing in this package edits the theory.
    """
    if sign not in (-1, 1):
        raise ValueError("sign must be +1 (as written in Resogram.md) or -1")
    T = 1.0 / bank.sr
    Omega = bank.Omega[index]
    beta = bank.beta[index]
    n_k = max(1, int(round(np.pi / (Omega * T))))
    k = np.arange(n_k)
    return (Omega / np.pi) * T * np.exp(sign * 2.0 * beta * k * T)


def apply_ebar(bank: ResonatorBank, e: np.ndarray, index: int, sign: int = -1) -> np.ndarray:
    """Causal FIR application of the ebar kernel; same length as e."""
    w = ebar_kernel(bank, index, sign=sign)
    return np.convolve(e, w)[: len(e)]


def resogram(
    y: np.ndarray,
    sr: float,
    bank: ResonatorBank | None = None,
    hop: int = 64,
    mode: str = "e",
    ebar_sign: int = -1,
    **bank_kwargs,
) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    """Compute the resogram of y.

    Returns (freqs_hz, times_s, E) with E of shape (n_freqs, n_frames).

    `mode` is "e" for the instantaneous specific energy or "ebar" for the
    owner's sliding half-period average.  Filtering always runs at the full
    audio rate; only the OUTPUT time axis is decimated by `hop`, which keeps
    memory at O(n_samples + n_freqs*n_frames) rather than O(n_freqs*n_samples).
    """
    if mode not in ("e", "ebar"):
        raise ValueError("mode must be 'e' or 'ebar'")
    y = np.asarray(y, dtype=float)
    if bank is None:
        bank = make_bank(sr, **bank_kwargs)
    idx = np.arange(0, len(y), hop)
    out = np.empty((len(bank), len(idx)), dtype=float)
    for i in range(len(bank)):
        x, x_t = resonate(bank, y, i)
        e = specific_energy(bank, x, x_t, i)
        if mode == "ebar":
            e = apply_ebar(bank, e, i, sign=ebar_sign)
        out[i] = e[idx]
    return bank.freqs_hz, idx / sr, out


def steady_state_amplitude(omega: float, beta: float, drive_omega: float) -> complex:
    """Continuous-time H_x(i*drive_omega) for the closed-form validation."""
    s = 1j * drive_omega
    return omega**2 / (s**2 + 2.0 * beta * s + omega**2)
