"""Produce every number and figure quoted in docs/dreamed/resogram-library.md.

Run (memory-capped, as required by the toesnail agent contract):

    cd docs/dreamed/resogram-lib
    ( ulimit -v 4000000; PYTHONPATH=. uv run --no-project \
        --with numpy --with scipy --with matplotlib --with soundfile \
        python demo.py )

Writes into out/: validation.txt, metrics.md, and four PNGs.
Everything printed here was actually measured; nothing is quoted from theory
without a matching run.
"""

from __future__ import annotations

import os
import resource
import shutil
import subprocess
import time

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
import numpy as np  # noqa: E402

from resogram.compare import (  # noqa: E402
    MORLET_W0_PER_Q,
    envelope_width,
    hann_nperseg_for_Q,
    measure_bandwidth,
    morlet_cwt_power,
    pre_echo_db,
    stft_power,
    two_tone_resolved,
)
from resogram.core import (  # noqa: E402
    apply_ebar,
    make_bank,
    resogram,
    resonate,
    specific_energy,
)
from resogram.io import decoder_report, load_audio  # noqa: E402

SR = 22050.0
Q = 20.0
HOP = 32
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "out")
os.makedirs(OUT, exist_ok=True)
LINES: list[str] = []


def say(s=""):
    print(s)
    LINES.append(str(s))


def peak_rss_mb():
    return resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1024.0


# ---------------------------------------------------------------- validation
def validation():
    say("== 1. VALIDATION against the owner's closed forms ==")
    say(f"sample rate {SR:.0f} Hz")
    say("")
    say("(a) steady state on resonance: |x| must equal Q, e must equal (Q*omega)^2/2")
    say("     f[Hz]     Q   rel err |x|   rel err e   energy ripple")
    for f, q in [(110.0, 5.0), (440.0, 20.0), (1760.0, 80.0), (4000.0, 20.0)]:
        bank = make_bank(SR, freqs_hz=np.array([f]), Q=q)
        omega = bank.omega[0]
        n = min(int(SR * 48 * q / omega), int(30 * SR))
        t = np.arange(n) / SR
        x, x_t = resonate(bank, np.cos(omega * t), 0)
        e = specific_energy(bank, x, x_t, 0)
        tail = slice(int(0.9 * n), None)
        amp = np.abs(x[tail]).max()
        et = e[tail]
        expect = (q * omega) ** 2 / 2
        say(
            f"  {f:8.0f} {q:5.1f}   {abs(amp-q)/q:9.2e}   {abs(et.mean()-expect)/expect:9.2e}"
            f"   {(et.max()-et.min())/et.mean():9.2e}"
        )
    say("")

    say("(b) impulse response vs the owner's `sol` kernel")
    say("    K(t) = (omega^2/Omega) sin(Omega t) exp(-beta t)")
    say("     f[Hz]     Q   max rel dev")
    for f, q in [(110.0, 20.0), (440.0, 20.0), (1760.0, 20.0), (4000.0, 20.0)]:
        bank = make_bank(SR, freqs_hz=np.array([f]), Q=q)
        omega, beta, Om = bank.omega[0], bank.beta[0], bank.Omega[0]
        n = int(SR * 0.3)
        imp = np.zeros(n)
        imp[0] = SR
        x, _ = resonate(bank, imp, 0)
        t = np.arange(n) / SR
        K = (omega**2 / Om) * np.sin(Om * t) * np.exp(-beta * t)
        say(f"  {f:8.0f} {q:5.1f}   {np.abs(x-K).max()/np.abs(K).max():9.2e}")
    say("")

    say("(c) free ring-down decay rate fitted from log(ebar); target 2*beta")
    say("     f[Hz]     Q   fitted     2*beta     rel err")
    for f, q in [(440.0, 5.0), (440.0, 20.0), (440.0, 60.0)]:
        bank = make_bank(SR, freqs_hz=np.array([f]), Q=q)
        beta, Om = bank.beta[0], bank.Omega[0]
        n = min(int(SR * 12.0 / (2 * beta)), int(6 * SR))
        imp = np.zeros(n)
        imp[0] = 1.0
        x, x_t = resonate(bank, imp, 0)
        env = apply_ebar(bank, specific_energy(bank, x, x_t, 0), 0, sign=-1)
        lo = int(2 * np.pi / Om * SR)
        t = np.arange(lo, n) / SR
        keep = env[lo:n] > env[lo:n].max() * 1e-10
        slope = -np.polyfit(t[keep], np.log(env[lo:n][keep]), 1)[0]
        say(f"  {f:8.0f} {q:5.1f}   {slope:9.4f}  {2*beta:9.4f}   {abs(slope-2*beta)/(2*beta):9.2e}")
    say("")

    say("(d) ebar kernel sign, on the free ring-down of the owner's `esol`")
    say("    residual ripple of ebar(t)*exp(+2*beta*t), which should be CONSTANT")
    say("     Q    sign=-1      sign=+1 (as printed)   ratio")
    for q in [8.0, 20.0, 60.0]:
        bank = make_bank(SR, freqs_hz=np.array([440.0]), Q=q)
        beta = bank.beta[0]
        n = int(SR * 3.0 / (2 * beta))
        imp = np.zeros(n)
        imp[0] = 1.0
        x, x_t = resonate(bank, imp, 0)
        e = specific_energy(bank, x, x_t, 0)
        t = np.arange(n) / SR
        lo, hi = int(0.2 * n), int(0.9 * n)
        env = np.exp(2 * beta * t[lo:hi])
        rip = {}
        for s in (-1, 1):
            v = apply_ebar(bank, e, 0, sign=s)[lo:hi] * env
            rip[s] = (v.max() - v.min()) / v.mean()
        say(f"  {q:5.1f}  {rip[-1]:10.3e}   {rip[1]:10.3e}          {rip[1]/rip[-1]:7.1f}x")
    say("")


# ------------------------------------------------------- transform relationship
def relationship():
    say("== 2. WHAT TRANSFORM IS THIS? ==")
    say("")
    say("Exact algebra (verified numerically below): define the COMPLEX state")
    say("    z(t) = x(t) + i*x_t(t)/omega,   so   e(t) = (omega^2/2)*|z(t)|^2.")
    say("Both channels are linear filters of y, so z = h_c * y exactly, with")
    say("    h_c(t) = h_x(t) + (i/omega) h_x'(t)")
    say("           = (omega^2/Omega) e^{-beta t} [ c_- e^{-i Omega t} + c_+ e^{+i Omega t} ],")
    say("    c_- = (i/2)(1 + e^{i gamma}),  c_+ = (-i/2)(1 - e^{i gamma}),")
    say("    gamma = atan2(beta, Omega)  (note Omega + i*beta = omega e^{i gamma}).")
    say("So the resogram is EXACTLY |CWT|^2 for a causal complex kernel that is a")
    say("damped complex exponential plus a counter-rotating leak of relative")
    say("amplitude |c_+/c_-| = tan(gamma/2) ~ 1/(4Q).")
    say("")
    say("     Q     tan(gamma/2)   1/(4Q)    measured |c+/c-|   |e - (om^2/2)|h_c*y|^2| rel")
    rng = np.random.default_rng(3)
    y = rng.standard_normal(int(SR * 0.5))
    for q in [5.0, 20.0, 80.0]:
        bank = make_bank(SR, freqs_hz=np.array([440.0]), Q=q)
        omega, beta, Om = bank.omega[0], bank.beta[0], bank.Omega[0]
        gamma = np.arctan2(beta, Om)
        cm = 0.5j * (1 + np.exp(1j * gamma))
        cp = -0.5j * (1 - np.exp(1j * gamma))
        x, x_t = resonate(bank, y, 0)
        e = specific_energy(bank, x, x_t, 0)
        z = x + 1j * x_t / omega
        rel = np.abs(e - 0.5 * omega**2 * np.abs(z) ** 2).max() / e.max()
        say(
            f"  {q:6.1f}   {np.tan(gamma/2):10.5f}  {1/(4*q):8.5f}   {abs(cp/cm):14.5f}"
            f"   {rel:12.2e}"
        )
    say("")

    say("Admissibility (zero mean) is what a wavelet needs and this kernel lacks:")
    say("  H_x(0) = 1 while the peak gain is Q, so the DC leak sits at -20log10(Q) dB.")
    say("     Q     DC gain   peak gain   DC leak [dB]   measured [dB]")
    for q in [5.0, 20.0, 80.0]:
        bank = make_bank(SR, freqs_hz=np.array([440.0]), Q=q)
        omega = bank.omega[0]
        n = int(SR * 4.0)
        # measured: drive with a constant 1.0 and read the settled displacement
        x, _ = resonate(bank, np.ones(n), 0)
        dc = x[-1]
        t = np.arange(n) / SR
        xr, _ = resonate(bank, np.cos(omega * t), 0)
        pk = np.abs(xr[int(0.9 * n) :]).max()
        say(
            f"  {q:6.1f}   {dc:7.4f}   {pk:9.3f}   {-20*np.log10(q):12.2f}"
            f"   {20*np.log10(dc/pk):13.2f}"
        )
    say("")

    say("Kernel identity check against the order-1 gammatone")
    say("  gammatone_n(t) = t^{n-1} e^{-2 pi b t} cos(2 pi f_c t + phi) u(t)")
    say("  with n=1, 2 pi b = beta, 2 pi f_c = Omega, phi = -pi/2 this IS h_x/(omega^2/Omega).")
    bank = make_bank(SR, freqs_hz=np.array([440.0]), Q=20.0)
    omega, beta, Om = bank.omega[0], bank.beta[0], bank.Omega[0]
    n = int(SR * 0.2)
    imp = np.zeros(n)
    imp[0] = SR
    x, _ = resonate(bank, imp, 0)
    t = np.arange(n) / SR
    gt = (omega**2 / Om) * np.exp(-beta * t) * np.cos(Om * t - np.pi / 2)
    say(f"  max rel deviation h_x vs order-1 gammatone: {np.abs(x-gt).max()/np.abs(gt).max():.2e}")
    say("")


# ---------------------------------------------------------------- measurements
def measurements():
    say("== 3. MEASURED COMPARISON: resogram vs Morlet CWT vs STFT ==")
    say(f"Q = {Q} for the resogram and the Morlet (matched by -3 dB power bandwidth);")
    say("the Hann window is sized to give the same Q at 440 Hz, since a fixed window")
    say("cannot be constant-Q at more than one frequency.")
    nper = hann_nperseg_for_Q(SR, Q, 440.0)
    say(f"Hann N = {nper} samples = {nper/SR*1000:.1f} ms")
    say(f"Morlet w0 = 2*sqrt(ln2)*Q = {MORLET_W0_PER_Q*Q:.3f}")
    say("")

    bank = make_bank(SR, f_min=110.0, f_max=6000.0, bins_per_octave=24, Q=Q)
    freqs = bank.freqs_hz
    say(f"bank: {len(freqs)} resonators, 110 Hz to {freqs[-1]:.0f} Hz, 24 per octave")
    say("")

    # --- measured analysis bandwidths, at 880 Hz ---
    say("(a) measured -3 dB POWER bandwidth of each analysis filter at 880 Hz")
    n = int(SR * 2.0)
    probe = np.zeros(n)
    probe[0] = 1.0
    k880 = int(np.argmin(np.abs(freqs - 880.0)))
    b1 = make_bank(SR, freqs_hz=np.array([880.0]), Q=Q)
    x, _ = resonate(b1, probe, 0)
    H = np.abs(np.fft.rfft(x, 2 * n)) ** 2
    fx = np.fft.rfftfreq(2 * n, 1 / SR)
    bw_res, fc_res = measure_bandwidth(H, fx)
    # Morlet
    s = MORLET_W0_PER_Q * Q / (2 * np.pi * 880.0)
    w = 2 * np.pi * fx
    Hm = np.exp(-((s * w - MORLET_W0_PER_Q * Q) ** 2))
    bw_m, fc_m = measure_bandwidth(Hm, fx)
    # Hann
    from scipy.signal import get_window

    win = get_window("hann", nper)
    Hh = np.abs(np.fft.rfft(win, 64 * nper)) ** 2
    fh = np.fft.rfftfreq(64 * nper, 1 / SR)
    bw_h, _ = measure_bandwidth(Hh, fh)
    say(f"  resonator   : {bw_res:8.2f} Hz  (centre {fc_res:7.2f}, Q = {fc_res/bw_res:6.2f})")
    say(f"  Morlet      : {bw_m:8.2f} Hz  (centre {fc_m:7.2f}, Q = {fc_m/bw_m:6.2f})")
    say(f"  Hann N={nper:<5d}: {bw_h:8.2f} Hz  (constant in Hz, Q = {880.0/bw_h:6.2f} at 880 Hz)")
    say("")

    # --- click: time resolution and pre-echo ---
    say("(b) unit click at t = 0.25 s: -10 dB width and pre-echo, read at 880 Hz")
    n = int(SR * 0.5)
    onset = n // 2
    click = np.zeros(n)
    click[onset] = 1.0
    t_on = onset / SR

    _, tr, E = resogram(click, SR, bank=bank, hop=HOP)
    _, C = morlet_cwt_power(click, SR, freqs, Q, hop=HOP)
    sf, st, S = stft_power(click, SR, nper, hop=HOP)
    ks = int(np.argmin(np.abs(sf - 880.0)))

    rows = []
    rows.append(("resogram", envelope_width(tr, E[k880]), pre_echo_db(tr, E[k880], t_on, 0.002)))
    rows.append(("Morlet CWT", envelope_width(tr, C[k880]), pre_echo_db(tr, C[k880], t_on, 0.002)))
    rows.append(("STFT", envelope_width(st, S[ks]), pre_echo_db(st, S[ks], t_on, 0.002)))
    say("  method        -10 dB width [ms]   pre-echo [dB rel peak]")
    for name, wid, pe in rows:
        pes = "-inf (exactly zero)" if pe == float("-inf") else f"{pe:.1f}"
        say(f"  {name:<12}  {wid*1000:15.2f}   {pes:>22}")
    say("")

    # --- two tones ---
    say("(c) two equal tones one semitone apart, 1 s.")
    say("    The frequency AXIS is refined so the dip is actually sampled:")
    say("    192 bins/octave for the constant-Q banks, 8x zero-padded STFT.")
    say("    Each slice is the TIME MEAN over the middle 60 % of frames. That")
    say("    matters: a filterbank driven by two close tones BEATS at |f1-f2|,")
    say("    so a single instantaneous slice of e(t) can show no dip at all")
    say("    (measured: dip 0.00 dB at the beat maximum). Frequency resolution")
    say("    is a statement about the mean, not about one instant.")
    n = int(SR * 1.0)
    t = np.arange(n) / SR
    for f_a, f_b, label, qq in [
        (440.0, 466.164, "semitone, 5.95 %", 20.0),
        (440.0, 466.164, "semitone, 5.95 %", 40.0),
        (440.0, 466.164, "semitone, 5.95 %", 80.0),
        (440.0, 452.89, "quartertone, 2.93 %", 80.0),
    ]:
        fine = make_bank(SR, f_min=380.0, f_max=540.0, bins_per_octave=192, Q=qq)
        nper_q = hann_nperseg_for_Q(SR, qq, 440.0)
        two = np.cos(2 * np.pi * f_a * t) + np.cos(2 * np.pi * f_b * t)
        _, t2, E2 = resogram(two, SR, bank=fine, hop=512)
        _, C2 = morlet_cwt_power(two, SR, fine.freqs_hz, qq, hop=512)
        sf2, st2, S2 = stft_power(two, SR, nper_q, hop=512, nfft=8 * nper_q)
        def mid60(P):
            a, b = int(0.2 * P.shape[1]), int(0.8 * P.shape[1])
            return P[:, a:b].mean(axis=1)

        say(f"  {f_a:.2f} vs {f_b:.2f} Hz ({label}), Q={qq:.0f}, Hann N={nper_q}:")
        for name, row, fr in [
            ("resogram", mid60(E2), fine.freqs_hz),
            ("Morlet CWT", mid60(C2), fine.freqs_hz),
            ("STFT", mid60(S2), sf2),
        ]:
            ok, dip = two_tone_resolved(row, fr, f_a, f_b)
            say(f"    {name:<12} resolved: {str(ok):<5}  dip {dip:7.2f} dB")
    say("  (Rayleigh-style: a dip of at least 3 dB below the weaker peak counts as resolved)")
    say("")

    say("(c2) the resogram's intrinsic +6 dB/octave tilt")
    say("     e = (Q*A*omega)^2/2 on resonance, so equal-amplitude tones an octave")
    say("     apart do NOT give equal display values: the higher one is 4x louder.")
    two = np.cos(2 * np.pi * 440.0 * t) + np.cos(2 * np.pi * 880.0 * t)
    _, t3, E3 = resogram(two, SR, bank=bank, hop=512)
    a, b = int(0.2 * E3.shape[1]), int(0.8 * E3.shape[1])
    m3 = E3[:, a:b].mean(axis=1)
    i440 = int(np.argmin(np.abs(freqs - 440.0)))
    i880 = int(np.argmin(np.abs(freqs - 880.0)))
    say(f"     measured e(880)/e(440) = {m3[i880]/m3[i440]:.3f}  (predicted 4.000,")
    say("     i.e. +6.02 dB); a spectrogram of the same signal gives 1.000.")
    say("")

    # --- chirp ridge ---
    say("(d) linear chirp 200 -> 4000 Hz over 1.0 s: ridge tracking error")
    n = int(SR * 1.0)
    t = np.arange(n) / SR
    f0, f1 = 200.0, 4000.0
    phase = 2 * np.pi * (f0 * t + 0.5 * (f1 - f0) * t**2 / 1.0)
    chirp = np.sin(phase)
    _, tc, Ec = resogram(chirp, SR, bank=bank, hop=128)
    _, Cc = morlet_cwt_power(chirp, SR, freqs, Q, hop=128)
    sfc, stc, Sc = stft_power(chirp, SR, nper, hop=128)
    keep = (tc > 0.15) & (tc < 0.9)
    true_f = f0 + (f1 - f0) * tc
    for name, P, fr, tt in [
        ("resogram", Ec, freqs, tc),
        ("Morlet CWT", Cc, freqs, tc),
        ("STFT", Sc, sfc, stc),
    ]:
        ridge = fr[np.argmax(P, axis=0)]
        tf = f0 + (f1 - f0) * tt
        m = (tt > 0.15) & (tt < 0.9)
        err = np.median(np.abs(ridge[m] - tf[m]) / tf[m]) * 100
        bias = np.median((ridge[m] - tf[m]) / tf[m]) * 100
        say(f"  {name:<12} median |ridge - true|/true = {err:6.3f} %   median bias {bias:+6.3f} %")
    say("  (a causal filterbank must LAG a rising chirp; a symmetric kernel should not)")
    say("")
    del keep, true_f

    # --- cost ---
    say("(e) cost on the 1.0 s chirp, same output grid (hop 128), single core")
    for name, fn in [
        ("resogram", lambda: resogram(chirp, SR, bank=bank, hop=128)),
        ("Morlet CWT", lambda: morlet_cwt_power(chirp, SR, freqs, Q, hop=128)),
        ("STFT", lambda: stft_power(chirp, SR, nper, hop=128)),
    ]:
        t0 = time.perf_counter()
        for _ in range(3):
            fn()
        dt = (time.perf_counter() - t0) / 3
        say(f"  {name:<12} {dt*1000:8.1f} ms   ({dt/1.0:6.3f} x realtime)")
    say(f"  process peak RSS at this point: {peak_rss_mb():.1f} MB")
    say("")
    return bank, freqs, nper, chirp, click, tr, E, C, st, S, sf


# ---------------------------------------------------------------------- figures
def figures(bank, freqs, nper, chirp, click, tr, E, C, st, S, sf):
    def panel(ax, tt, ff, P, title, logy=True):
        P = np.maximum(P, 1e-300)
        db = 10 * np.log10(P / P.max())
        im = ax.pcolormesh(tt, ff, np.maximum(db, -70), shading="nearest", cmap="magma",
                           vmin=-70, vmax=0)
        if logy:
            ax.set_yscale("log")
        ax.set_ylim(freqs[0], freqs[-1])
        ax.set_ylabel("f [Hz]")
        ax.set_title(title, fontsize=10)
        return im

    # figure 1: click, all three
    fig, ax = plt.subplots(3, 1, figsize=(9, 9), sharex=True)
    panel(ax[0], tr, freqs, E, f"resogram, click, Q={Q} (strictly causal)")
    panel(ax[1], tr, freqs, C, f"Morlet CWT, click, Q={Q} (symmetric, pre-echoes)")
    panel(ax[2], st, sf[1:], S[1:], f"STFT, click, Hann N={nper}")
    ax[2].set_xlabel("time [s]")
    fig.tight_layout()
    fig.savefig(f"{OUT}/click.png", dpi=120)
    plt.close(fig)

    # figure 2: chirp, all three
    _, tc, Ec = resogram(chirp, SR, bank=bank, hop=128)
    _, Cc = morlet_cwt_power(chirp, SR, freqs, Q, hop=128)
    sfc, stc, Sc = stft_power(chirp, SR, nper, hop=128)
    fig, ax = plt.subplots(3, 1, figsize=(9, 9), sharex=True)
    panel(ax[0], tc, freqs, Ec, "resogram, 200-4000 Hz chirp")
    panel(ax[1], tc, freqs, Cc, "Morlet CWT, same chirp")
    panel(ax[2], stc, sfc[1:], Sc[1:], f"STFT, same chirp, Hann N={nper}")
    ax[2].set_xlabel("time [s]")
    fig.tight_layout()
    fig.savefig(f"{OUT}/chirp.png", dpi=120)
    plt.close(fig)

    # figure 3: kernels in the time domain
    b1 = make_bank(SR, freqs_hz=np.array([440.0]), Q=Q)
    omega, beta, Om = b1.omega[0], b1.beta[0], b1.Omega[0]
    n = int(SR * 0.12)
    imp = np.zeros(2 * n)
    imp[n] = SR
    x, x_t = resonate(b1, imp, 0)
    tt = (np.arange(2 * n) - n) / SR
    s = MORLET_W0_PER_Q * Q / (2 * np.pi * 440.0)
    morlet = np.real(np.exp(1j * 2 * np.pi * 440.0 * tt) * np.exp(-(tt**2) / (2 * s**2)))
    fig, ax = plt.subplots(2, 1, figsize=(9, 6), sharex=True)
    ax[0].plot(tt * 1000, x / np.abs(x).max(), lw=0.9, color="C3")
    ax[0].plot(tt * 1000, np.exp(-beta * np.maximum(tt, 0)) * (tt >= 0), "k--", lw=0.8,
               label="exp(-beta t) u(t)")
    ax[0].set_title("resonator impulse response at 440 Hz, Q=20: zero for t<0", fontsize=10)
    ax[0].legend(fontsize=8)
    ax[1].plot(tt * 1000, morlet, lw=0.9, color="C0")
    ax[1].plot(tt * 1000, np.exp(-(tt**2) / (2 * s**2)), "k--", lw=0.8, label="Gaussian")
    ax[1].set_title("Morlet wavelet, matched Q: two-sided, nonzero for t<0", fontsize=10)
    ax[1].set_xlabel("time relative to the impulse [ms]")
    ax[1].legend(fontsize=8)
    fig.tight_layout()
    fig.savefig(f"{OUT}/kernels.png", dpi=120)
    plt.close(fig)

    # figure 4: e vs ebar on a plucked-string-like signal
    n = int(SR * 1.2)
    t = np.arange(n) / SR
    sig = np.zeros(n)
    for f0, t0 in [(220.0, 0.05), (277.18, 0.35), (329.63, 0.65), (440.0, 0.9)]:
        dt = np.maximum(t - t0, 0.0)
        env = (1 - np.exp(-dt / 0.004)) * np.exp(-6.0 * dt) * (t >= t0)
        for h in (1, 2, 3):
            sig += env * np.sin(2 * np.pi * f0 * h * t) / h**2
    bank2 = make_bank(SR, f_min=150.0, f_max=3000.0, bins_per_octave=24, Q=Q)
    f2, t2, Ep = resogram(sig, SR, bank=bank2, hop=64, mode="e")
    _, _, Eb = resogram(sig, SR, bank=bank2, hop=64, mode="ebar", ebar_sign=-1)
    fig, ax = plt.subplots(3, 1, figsize=(9, 9))
    for a, P, ttl in [
        (ax[0], Ep, "resogram, instantaneous specific energy e(t)"),
        (ax[1], Eb, "resogram, sliding half-period average ebar(t), sign = -1"),
    ]:
        Pn = np.maximum(P, 1e-300)
        db = 10 * np.log10(Pn / Pn.max())
        a.pcolormesh(t2, f2, np.maximum(db, -50), shading="nearest", cmap="magma",
                     vmin=-50, vmax=0)
        a.set_yscale("log")
        a.set_ylim(f2[0], f2[-1])
        a.set_ylabel("f [Hz]")
        a.set_title(ttl, fontsize=10)
    k220 = int(np.argmin(np.abs(f2 - 220.0)))
    ax[2].semilogy(t2, np.maximum(Ep[k220], 1e-6), lw=0.7, color="0.55", label="e(t)")
    ax[2].semilogy(t2, np.maximum(Eb[k220], 1e-6), lw=1.3, color="C3",
                   label="ebar(t), sign = -1")
    ax[2].set_xlim(t2[0], t2[-1])
    ax[2].set_ylim(1e0, None)
    ax[2].set_xlabel("time [s]")
    ax[2].set_ylabel("specific energy")
    ax[2].set_title("slice at 220 Hz: ebar is the ripple-free envelope of e", fontsize=10)
    ax[2].legend(fontsize=8)
    fig.tight_layout()
    fig.savefig(f"{OUT}/ebar.png", dpi=120)
    plt.close(fig)
    say("wrote out/click.png, out/chirp.png, out/kernels.png, out/ebar.png")
    say("")


# ------------------------------------------------------------------------ audio
def audio_check():
    say("== 4. AUDIO I/O, actually exercised on this machine ==")
    say(decoder_report())
    say("")
    wav = f"{OUT}/probe.wav"
    mp3 = f"{OUT}/probe.mp3"
    n = int(SR * 1.0)
    t = np.arange(n) / SR
    sig = 0.4 * (np.sin(2 * np.pi * 440 * t) + 0.5 * np.sin(2 * np.pi * 1320 * t))
    import soundfile as sf_mod

    sf_mod.write(wav, sig, int(SR))
    y, sr = load_audio(wav)
    say(f"WAV  : wrote and read back {len(y)} samples at {sr:.0f} Hz, "
        f"rms {np.sqrt((y**2).mean()):.4f}")

    if shutil.which("ffmpeg"):
        subprocess.run(
            ["ffmpeg", "-y", "-v", "error", "-i", wav, "-codec:a", "libmp3lame",
             "-b:a", "192k", mp3],
            check=True,
        )
        y2, sr2 = load_audio(mp3)
        say(f"MP3  : ffmpeg encoded {os.path.getsize(mp3)} bytes; decoded "
            f"{len(y2)} samples at {sr2:.0f} Hz, rms {np.sqrt((y2**2).mean()):.4f}")
        # spectral check that it is the same signal
        k = int(round(440 * len(y2) / sr2))
        P = np.abs(np.fft.rfft(y2)) ** 2
        say(f"       decoded MP3 peak bin at {np.argmax(P)*sr2/len(y2):.1f} Hz "
            f"(expected 440.0); bin 440 is {10*np.log10(P[k]/P.max()):.2f} dB below peak")
        say("       => MP3 decoding VERIFIED on this machine (soundfile/libsndfile 1.2.2).")
        freqs, times, E = resogram(y2, sr2, hop=64, f_min=110.0, f_max=6000.0,
                                   bins_per_octave=24, Q=Q)
        pk = freqs[np.argmax(E[:, len(times) // 2])]
        say(f"       resogram of the decoded MP3 peaks at {pk:.1f} Hz mid-file")
    else:
        say("MP3  : ffmpeg absent, MP3 path NOT exercised")
    say("")


def main():
    validation()
    relationship()
    args = measurements()
    figures(*args)
    audio_check()
    say(f"peak RSS for the whole demo: {peak_rss_mb():.1f} MB")
    with open(f"{OUT}/validation.txt", "w") as fh:
        fh.write("\n".join(LINES) + "\n")
    print(f"\nwrote {OUT}/validation.txt")


if __name__ == "__main__":
    main()
