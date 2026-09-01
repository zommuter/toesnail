"""STFT and Morlet-CWT baselines, plus the measurement harness.

All three transforms are driven with the SAME signal, and their Q is matched by
one common definition:

    Q := f_centre / (-3 dB POWER bandwidth of the analysis filter)

  - Resonator: |H(i*w)|**2 = omega**4 / ((omega**2 - w**2)**2 + 4*beta**2*w**2),
    whose -3 dB power points sit at w ~ omega +- beta, so the bandwidth is
    2*beta and Q = omega/(2*beta).  That is exactly the constructor's Q.
  - Morlet: the analytic Morlet has power response exp(-(s*w - w0)**2), so the
    -3 dB power bandwidth is 2*sqrt(ln 2)/s and the centre is w0/s, giving
    Q = w0 / (2*sqrt(ln 2)).  Hence w0 = 2*sqrt(ln 2)*Q matches the resonator.
  - STFT: a Hann window of length N has a -3 dB power bandwidth of about
    1.44*sr/N (measured, not assumed, by `measure_bandwidth`), which is CONSTANT
    in Hz, so its Q rises linearly with frequency.  There is no window length
    that matches a constant-Q bank at more than one frequency; we pick the
    window that matches at a stated reference frequency and say so.
"""

from __future__ import annotations

import numpy as np
from scipy.signal import get_window

MORLET_W0_PER_Q = 2.0 * np.sqrt(np.log(2.0))


def morlet_cwt_power(
    y: np.ndarray,
    sr: float,
    freqs_hz: np.ndarray,
    Q: float,
    hop: int = 64,
) -> tuple[np.ndarray, np.ndarray]:
    """|CWT|**2 with an analytic Morlet, matched in Q to the resonator bank.

    Frequency-domain convolution, one scale at a time, so peak memory stays at
    O(n_samples) per scale rather than O(n_freqs*n_samples).
    Returns (times_s, P) with P of shape (len(freqs_hz), n_frames).
    """
    y = np.asarray(y, dtype=float)
    n = len(y)
    nfft = int(2 ** np.ceil(np.log2(2 * n)))  # zero-pad to avoid circular wrap
    Y = np.fft.rfft(y, nfft)
    w = 2.0 * np.pi * np.fft.rfftfreq(nfft, d=1.0 / sr)
    w0 = MORLET_W0_PER_Q * Q
    idx = np.arange(0, n, hop)
    out = np.empty((len(freqs_hz), len(idx)), dtype=float)
    for i, f in enumerate(freqs_hz):
        s = w0 / (2.0 * np.pi * f)
        psi = np.exp(-0.5 * (s * w - w0) ** 2)  # analytic: supported on w >= 0
        # Build the ANALYTIC (complex) coefficient: keep only non-negative
        # frequencies and double the strictly positive ones.
        spec = Y * psi
        spec[1:-1] *= 2.0
        full = np.zeros(nfft, dtype=complex)
        full[: len(spec)] = spec
        coef = np.fft.ifft(full)[:n]
        out[i] = np.abs(coef[idx]) ** 2
    return idx / sr, out


def stft_power(
    y: np.ndarray,
    sr: float,
    nperseg: int,
    hop: int = 64,
    window: str = "hann",
    nfft: int | None = None,
) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    """Windowed FFT magnitude squared, centred frames, zero padded at the edges.

    Written explicitly (rather than via scipy.signal.stft) so the frame times
    line up sample-for-sample with the resogram and CWT hop grid.
    Returns (freqs_hz, times_s, P) with P of shape (n_bins, n_frames).
    """
    y = np.asarray(y, dtype=float)
    n = len(y)
    win = get_window(window, nperseg, fftbins=True)
    pad = nperseg // 2
    yp = np.concatenate([np.zeros(pad), y, np.zeros(nperseg)])
    idx = np.arange(0, n, hop)
    frames = np.stack([yp[i : i + nperseg] for i in idx], axis=0)
    nfft = nfft or nperseg  # zero-padding refines the frequency GRID, not the
    # resolution; needed so a dip between two close tones is actually sampled.
    P = np.abs(np.fft.rfft(frames * win, n=nfft, axis=1)) ** 2
    freqs = np.fft.rfftfreq(nfft, d=1.0 / sr)
    return freqs, idx / sr, P.T


def hann_nperseg_for_Q(sr: float, Q: float, f_ref: float) -> int:
    """Hann window length whose -3 dB power bandwidth equals f_ref/Q."""
    # Hann -3 dB power bandwidth is about 1.4382 * sr / N (measured below).
    n = int(round(1.4382 * sr * Q / f_ref))
    return max(16, n + (n % 2))


def measure_bandwidth(response_f: np.ndarray, freqs: np.ndarray) -> tuple[float, float]:
    """(-3 dB power bandwidth, centre frequency) of a sampled power response."""
    p = np.asarray(response_f, dtype=float)
    k = int(np.argmax(p))
    half = p[k] / 2.0
    if k == 0:
        # Peak at DC (a lowpass window kernel): the response is even, so measure
        # the upper half-width and double it. Without this the lower-side search
        # runs off the end of the array and extrapolates nonsense.
        hi = 0
        while hi < len(p) - 1 and p[hi] > half:
            hi += 1
        t = (half - p[hi - 1]) / (p[hi] - p[hi - 1]) if p[hi] != p[hi - 1] else 0.0
        f_hi = freqs[hi - 1] + t * (freqs[hi] - freqs[hi - 1])
        return 2.0 * (f_hi - freqs[0]), freqs[0]
    lo = k
    while lo > 0 and p[lo] > half:
        lo -= 1
    hi = k
    while hi < len(p) - 1 and p[hi] > half:
        hi += 1

    def interp(i0, i1):
        if p[i1] == p[i0]:
            return freqs[i0]
        t = (half - p[i0]) / (p[i1] - p[i0])
        return freqs[i0] + t * (freqs[i1] - freqs[i0])

    f_lo = interp(lo, lo + 1)
    f_hi = interp(hi, hi - 1)
    return abs(f_hi - f_lo), freqs[k]


def envelope_width(t: np.ndarray, row: np.ndarray, drop_db: float = 10.0) -> float:
    """Width in seconds of a single-peak energy row at -drop_db from its peak."""
    p = np.asarray(row, dtype=float)
    k = int(np.argmax(p))
    thr = p[k] * 10.0 ** (-drop_db / 10.0)
    lo = k
    while lo > 0 and p[lo] > thr:
        lo -= 1
    hi = k
    while hi < len(p) - 1 and p[hi] > thr:
        hi += 1
    return t[hi] - t[lo]


def pre_echo_db(t: np.ndarray, row: np.ndarray, t_onset: float, guard_s: float) -> float:
    """Peak energy strictly BEFORE the onset, in dB relative to the row peak.

    Returns -inf when the pre-onset region is numerically zero, which is the
    signature of a strictly causal filter.
    """
    p = np.asarray(row, dtype=float)
    pre = p[t < (t_onset - guard_s)]
    if len(pre) == 0:
        return float("nan")
    peak = p.max()
    m = pre.max()
    if m <= 0 or peak <= 0:
        return float("-inf")
    return 10.0 * np.log10(m / peak)


def two_tone_resolved(row: np.ndarray, freqs: np.ndarray, f1: float, f2: float) -> tuple[bool, float]:
    """Rayleigh-style test on a frequency slice: is there a dip between the tones?

    Returns (resolved, dip_db) where dip_db is the depth of the minimum between
    the two peaks relative to the weaker peak.  Resolved means dip_db <= -3.
    """
    p = np.asarray(row, dtype=float)
    i1 = int(np.argmin(np.abs(freqs - f1)))
    i2 = int(np.argmin(np.abs(freqs - f2)))
    lo, hi = sorted((i1, i2))
    if hi - lo < 2:
        return False, 0.0
    seg = p[lo : hi + 1]
    trough = seg.min()
    weaker = min(p[lo], p[hi])
    if trough <= 0 or weaker <= 0:
        return True, float("-inf")
    dip = 10.0 * np.log10(trough / weaker)
    return dip <= -3.0, dip
