---
title: The resogram library
permalink: /dreamed/resogram-library
---

# A working resogram library, and what transform it turns out to be

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, from a seed
> the owner dictated that day: *"have an agent work out the resogram library while we're at it, i.e.
> a working product that can live show resograms and/or process MP3s etc, plus comparing against
> windowed FFTs and wavelet analysis"*. It **proposes**; the owner disposes. Unlike its sibling
> essays the deliverable here is **running code**, in
> [`docs/dreamed/resogram-lib/`](resogram-lib/); this file is the report on it.

## 0. Headline

The library works and validates against the owner's own closed forms. And the comparison settles a
question the seed did not ask but which anybody building this will hit within a day:

**The resogram is not a new transform. It is exactly the squared modulus of a causal, constant-Q
complex wavelet transform, whose analysing kernel is an order-1 gammatone.** That is not a
diminishment. What is genuinely the owner's is the *route*: he arrives at the same object from the
energy method rather than from a chosen mother wavelet, the quadrature pair that a wavelet
transform gets by fiat (real and imaginary parts of an analytic kernel) is here supplied by the
physical state $(x, \dot x)$, and the `ebar` kernel is his. The transform's one hard advantage over
a Morlet CWT is **strict causality**, which is measurable and which this library measures.

## 1. What was built

A real installable package, `docs/dreamed/resogram-lib/`: `core.py` (bank, discretisation, `e`,
`ebar`), `io.py` (soundfile then scipy-wav then ffmpeg), `compare.py` (STFT and Morlet baselines plus
the metric harness), `live.py`, `cli.py`, `tests/test_core.py` with 39 assertions, and `demo.py`
which writes `out/validation.txt` and four PNGs. Layout details are in its README.

Exact commands, all run on this machine:

```
cd docs/dreamed/resogram-lib
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project --with numpy --with scipy \
    --with pytest python -m pytest tests -q )                      # -> 39 passed in 0.56s
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project --with numpy --with scipy \
    --with matplotlib --with soundfile python demo.py )            # -> out/validation.txt + 4 PNGs
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project --with numpy --with scipy \
    --with matplotlib --with soundfile python -m resogram.cli render out/probe.mp3 -o out/r.png )
```

The last one printed `wrote out/r.png  (87 resonators x 345 frames, sr=22050)` on a real MP3.

### The discretisation, and how it was derived

The transfer function from drive to displacement is $H_x(s)=\omega^2/(s^2+2\beta s+\omega^2)$, whose
impulse response is exactly the convolution kernel already in the owner's `sol`:

$$
h_x(t) = \frac{\omega^2}{\Omega}\,e^{-\beta t}\sin(\Omega t)\,u(t),\qquad \Omega=\sqrt{\omega^2-\beta^2}.
$$

Sampling that at the audio rate and scaling by $T=1/f_s$ (impulse invariance), the standard
$z$-transform pairs for $r^n\sin(wn)$ and $r^n\cos(wn)$ with $r=e^{-\beta T}$, $w=\Omega T$ give a
two-pole IIR filter per resonator, with the velocity channel sharing the same denominator:
$b_x = T\frac{\omega^2}{\Omega}[0,\ r\sin w,\ 0]$,
$b_v = T\omega^2[1,\ -r(\cos w + \tfrac{\beta}{\Omega}\sin w),\ 0]$, $a = [1,\ -2r\cos w,\ r^2]$.
So the whole bank is `scipy.signal.lfilter`, not a Python sample loop. Each channel is then rescaled
by a real gain that makes its on-resonance magnitude exactly the continuous one.

### Validation against the owner's closed forms

Driving one resonator at resonance with $y=\cos\omega t$: the steady state must have $|x|=Q$ and
$e = (Q\omega)^2/2$, flat in time. Measured at $f_s = 22050$ Hz:

| $f$ [Hz] | $Q$ | rel. err. $\lvert x\rvert$ | rel. err. $e$ | energy ripple |
| ---: | ---: | ---: | ---: | ---: |
| 110 | 5 | 2.7e-07 | 4.5e-07 | 6.5e-05 |
| 440 | 20 | 3.0e-07 | 1.3e-06 | 2.6e-04 |
| 1760 | 80 | 2.9e-06 | 2.7e-07 | 1.1e-03 |
| 4000 | 20 | 7.0e-05 | 4.8e-05 | 2.3e-02 |

**It matches.** The impulse response against the `sol` kernel deviates by 1.4e-12 (110 Hz) to 4.3e-06
(4 kHz). The free ring-down decay rate, fitted from $\log\bar e$, reproduces $2\beta$ to 1.0e-08
at $Q=60$ and 7.7e-06 at $Q=5$.

The one thing that came out **worse than hoped** is the ripple column. An on-resonance energy should
be exactly constant, and it is not: the residual is the velocity channel's phase relative to
$i\omega x$, which is a pure discretisation artefact ($\propto \beta T$). It falls by about 4x per
doubling of $f_s$ (1.7e-2 at 22050, 4.2e-3 at 44100, 1.0e-3 at 88200 for 1760 Hz / $Q=5$), which is
what a test asserts. Practical rule: keep $f_\text{max}\le 0.2 f_s$.

## 2. The comparison

All three transforms are matched by one definition, $Q := f_c / (\text{-3 dB power bandwidth})$.
For the resonator that is the constructor's $Q$; for the Morlet it fixes $w_0 = 2\sqrt{\ln 2}\,Q$;
for the STFT there is no window that is constant-$Q$ at more than one frequency, so the Hann window
is sized to match at 440 Hz and the code says so. Measured bandwidths at 880 Hz, $Q=20$: resonator
44.03 Hz, Morlet 44.00 Hz, Hann $N=1442$ 22.03 Hz constant in Hz. The match is real.

**Click at $t=0.25$ s, read at 880 Hz:**

| | -10 dB width [ms] | pre-echo [dB rel. peak] |
| --- | ---: | ---: |
| resogram | **10.16** | **exactly zero** |
| Morlet CWT | 20.32 | -1.3 |
| STFT (Hann 1442) | 42.09 | -0.2 |

This is the resogram's real win, and `out/click.png` shows it as a picture: a hard vertical wall at
the onset with a ring-down to the right and *nothing* to the left, against the Morlet's symmetric
bowtie. At matched $Q$ the causal kernel is half the width of the symmetric one, because it spends
none of its support before the event. "Exactly zero" is not a small number: it is
`np.all(e[:onset] == 0.0)`, asserted for every resonator in the bank.

**Two equal tones, time-averaged slice, Rayleigh-style (a dip 3 dB below the weaker peak counts):**

| separation | $Q$ | resogram | Morlet CWT | STFT |
| --- | ---: | ---: | ---: | ---: |
| semitone (5.95 %) | 20 | -1.12 dB (no) | -1.09 dB (no) | -1.31 dB (no) |
| semitone | 40 | -4.94 dB (yes) | -12.85 dB (yes) | -19.33 dB (yes) |
| semitone | 80 | -10.07 dB (yes) | -59.07 dB (yes) | -50.07 dB (yes) |
| quartertone (2.93 %) | 80 | -4.77 dB (yes) | -12.08 dB (yes) | -18.32 dB (yes) |

All three cross the resolve/not-resolve threshold at the same $Q$, which is what matching bandwidth
was supposed to buy. But the resogram's dips are far shallower, and that is a **real cost, not a
measurement artefact**: a resonator's magnitude response is a Lorentzian whose skirts fall at only
-6 dB/octave, while the Morlet's are Gaussian. At $Q=80$ the Morlet separates the same two tones by
59 dB where the resogram manages 10 dB. If the owner's use-case is picking a weak partial out from
beside a strong one, this is the number that decides against the resonator bank.

Two further honest results the measurement forced out:

- A filterbank driven by two close tones **beats** at $|f_1-f_2|$. A single instantaneous slice of
  $e(t)$ at the beat maximum shows a dip of exactly 0.00 dB, i.e. no resolution at all. Frequency
  resolution here is a statement about a time average, never about one instant.
- The resogram carries an intrinsic **+6 dB/octave tilt**: on resonance $e=(QA\omega)^2/2$, so two
  equal-amplitude tones an octave apart display at a measured ratio of 4.013 (predicted 4), where a
  spectrogram gives 1. That is the kinetic term doing its job, and it means a resogram is not a
  spectrogram with a nicer axis. It is a loudness-like display with a physical weighting built in.

**Chirp 200 to 4000 Hz over 1 s, median ridge error:** resogram 1.022 % with a median bias of
**-0.975 %**, Morlet 0.685 % with bias +0.028 %, STFT 0.164 % with bias +0.005 %. The resogram's
error is almost entirely bias: a causal filter must lag a rising chirp, and it does, by very nearly
one ring-down time. The symmetric kernels do not lag. This is the same causality, seen from the
other side, and it is a *cost* here.

**Cost, 1 s chirp, 139-resonator bank, hop 128, one core:** resogram 28.4 ms (0.028x realtime),
Morlet CWT 112.1 ms (0.112x), STFT 2.0 ms (0.002x). Peak RSS for the whole demo process was 195 MB.
The resogram is 4x cheaper than the FFT-domain CWT and 14x dearer than the STFT, and unlike either
it is $O(1)$ per sample per resonator with no lookahead, which is why the live path is even possible.

## 3. Is it a CWT in disguise?

Yes, essentially. Here is the precise statement, derived and then verified numerically.

Define the complex state $z = x + i\dot x/\omega$, so that the owner's specific energy is
$e = \tfrac{\omega^2}{2}|z|^2$ identically. Both $x$ and $\dot x$ are linear filters of the drive, so
$z = h_c * y$ exactly, with

$$
h_c(t) = h_x(t) + \frac{i}{\omega}h_x'(t)
       = \frac{\omega^2}{\Omega}e^{-\beta t}\Big[c_-e^{-i\Omega t} + c_+e^{+i\Omega t}\Big],
$$

$$
c_- = \tfrac{i}{2}\big(1+e^{i\gamma}\big),\qquad
c_+ = -\tfrac{i}{2}\big(1-e^{i\gamma}\big),\qquad
\gamma = \operatorname{atan2}(\beta,\Omega),
$$

using $\Omega + i\beta = \omega e^{i\gamma}$. So **the resogram is $|W|^2$ for a causal complex
wavelet** that is a damped complex exponential plus a counter-rotating leak of relative amplitude
$|c_+/c_-| = \tan(\gamma/2) \approx 1/(4Q)$. Measured: 0.05013 at $Q=5$ against $1/(4Q)=0.05$,
0.01250 at $Q=20$, 0.00313 at $Q=80$; and $|e - \tfrac{\omega^2}{2}|h_c*y|^2|$ came out at 4.6e-16
relative, i.e. machine precision, so the identity is exact and not an approximation.

Three consequences, each measured:

1. **The kernel already has a name.** $h_x$ is an order-1 gammatone,
   $t^{n-1}e^{-2\pi b t}\cos(2\pi f_c t+\phi)u(t)$ with $n=1$, $2\pi b=\beta$, $2\pi f_c=\Omega$,
   $\phi=-\pi/2$. Measured deviation: 4.3e-10. The gammatone filterbank is the standard model of
   cochlear filtering. **The resogram is, to numerical precision, an auditory filterbank display.**
   That is a compliment to the physics, not a deflation of it: the ear also solves this problem with
   causal damped resonators, because it has to.
2. **The bank is a dilation family.** $h_\omega(t) = \omega\,\psi(\omega t)$ with $\psi$ depending
   only on $Q$, asserted in `test_bank_is_constant_q_scale_invariant` to 5e-3. That is precisely the
   structure of a continuous wavelet transform.
3. **But it is not an *admissible* wavelet.** A wavelet needs zero mean, and $H_x(0)=1$ while the
   peak gain is $Q$, so there is a DC leak sitting at $-20\log_{10}Q$ dB below the passband: measured
   -13.99 dB at $Q=5$, -26.03 at $Q=20$, -38.07 at $Q=80$, against a prediction of -13.98/-26.02/-38.06.
   There is therefore no exact CWT inversion formula for the displacement channel. (The *velocity*
   channel does have $H_v(0)=0$ and is admissible. The energy mixes an admissible channel with an
   inadmissible one.)

So, plainly: **the owner did not invent a new transform.** What he did invent, or at least arrive at
independently and from an unusual direction, is worth naming precisely:

- The **energy method** as the route in. A CWT picks a mother wavelet and calls $|W|^2$ a scalogram.
  The resogram never chooses a kernel; it writes down a physical oscillator and reads off its energy,
  and the analysing kernel falls out. The quadrature pair that makes $|W|^2$ meaningful is the phase
  space $(x,\dot x)$, not an analytic continuation chosen for convenience. That is a genuinely
  different derivation of the same object, and it explains the $\omega^2$ tilt (which a scalogram
  does not have and cannot motivate).
- The **`ebar` kernel**, which has no CWT analogue at all: it is a second, per-scale, strictly causal
  post-filter on the display, not on the signal.

## 4. Surfaced for the owner

Located and evidenced. Not edited, not filed into any ledger.

**The `ebar` kernel's exponent sign.** `physics/Resogram.md` ends (line 118, carrying no rigor-debt badge, the
document stops there) with

$$
\bar e(t) := \frac{\Omega}{\pi}\int_0^{\pi/\Omega} e(t-t')\,e^{+2\beta t'}\,dt'.
$$

Substituting the owner's own `esol`, $e = \frac{A^2\omega}{2}e^{-2\beta t}(\omega+\beta\cos(2(\Omega
t+\phi)-\delta))$, and integrating symbolically:

- With $e^{-2\beta t'}$ the result is **exactly** $\frac{A^2\omega^2}{2}e^{-2\beta t}$. Every ripple
  term cancels identically, and $\bar e$ is the clean energy envelope.
- With $e^{+2\beta t'}$ as printed, a $\cos/\sin(2\Omega t - \delta + 2\phi)$ ripple of order
  $\beta^2$ survives, multiplied by a prefactor growing like $e^{4\pi\beta/\Omega}$.

Numerically, on a free ring-down, the residual ripple of $\bar e(t)e^{+2\beta t}$ (which should be
constant) is 29.3x larger with the printed sign at $Q=8$, 19.3x at $Q=20$, 7.3x at $Q=60$. Neither
sign flattens the *decay*: $e(t-t')\propto e^{-2\beta t}e^{+2\beta t'}$ already carries the $+$
factor, so the printed kernel doubles it rather than cancelling it.

The reproduction is `demo.py` section 1(d), the sympy one-liner quoted in
`resogram/core.py:ebar_kernel`, and a Lean proof: `docs/dreamed/lean/Resogram2.lean` proves
`ebar_minus_exact` from Mathlib, with `beta` entirely unconstrained, so the cancellation is algebraic
rather than asymptotic. It compiles with exit 0 and no `sorry` under

```
cd verify && nice -n19 lake env lean --threads=2 ../docs/dreamed/lean/Resogram2.lean
```

That file deliberately proves nothing `verify/Resogram.lean` already proves; alongside the main
result it states the discrete-time stability fact the implementation rests on, that the resonator's
pole modulus $e^{-\beta T}$ is below 1 exactly when $\beta > 0$. The library defaults to $-1$ because
that is the sign that does the job, and exposes `ebar_sign=+1` to reproduce the text verbatim. **Which sign the owner meant is his
call**; there is a reading (define $\bar e$ *at the start* of the window rather than at its end) on
which the printed form is right and only the interpretation of $\bar e(t)$'s time argument shifts.

**Contact with the three known discrepancies.** The library's numerics touch `esol` and `sol`
constantly (they are the validation targets) and reproduce both **as currently written**, with the
already-ratified corrections in place: the `sol` integrand parenthesisation, the `edot` second
equality, and the `esol` exact phase-shifted form all check out numerically to the tolerances in
section 1. Nothing here reopens them.

**One observation on the `edot` callout, offered not asserted.** That callout notes the closed form
$\dot e = -4\beta e + \omega^2(2\beta x^2 + \dot x y)$ is not manifestly $\le 0$ at $y=0$ while
$\dot e = -2\beta\dot x^2$ is. The numerics give the quantitative version: the fitted free decay rate
of $\bar e$ is $2\beta$ to 1e-08, not $4\beta$. Both forms are of course consistent, and the
half-period average is what reconciles them, since $\langle\omega^2x^2\rangle =
\langle\dot x^2\rangle = \bar e$ (measured on the free ring-down: 1.00320 and 0.99680 at $Q=20$,
1.00105 and 0.99895 at $Q=60$, the residual being $O(1/2Q)$), so
$\langle\dot e\rangle = -4\beta \bar e + 2\beta \bar e = -2\beta \bar e$. That is
the same "average over a half period" the `ebar` line is reaching for, which suggests `ebar` and the
"$\dot e$ varies between zero and $-4\beta e$, thus averaging to $\approx -2\beta e$" paragraph are
the same observation stated twice, once loosely and once exactly.

## 5. What is untested, and why

- **The `--live` microphone path.** Written, never run. The machine was headless with no capture
  device and no display, so `sounddevice`/PortAudio could not be opened and no animation could be
  drawn. It is marked UNTESTED-HERE in both the README and the module docstring, and **no screenshot
  of it exists or was fabricated.** What *is* tested is the streaming core beneath it: feeding a
  signal in 700-sample blocks reproduces whole-signal filtering to 1e-12 relative, so if PortAudio
  opens, the numbers will be right. The display code around it is unexercised.
- **Long files.** Everything measured here is 0.5 to 1.2 s at 22050 Hz. The memory discipline (one
  resonator at a time, decimate before storing) means an hour-long file should be fine, but that was
  not run, deliberately, under the memory cap.
- **`f_max` above about $0.2 f_s$.** Works, with the ripple documented above; not recommended.
- **Anything perceptual.** No listening test, no real music beyond a synthetic four-note figure.

## 6. Follow-up leads

1. **Synchrosqueezing.** The bank already has $x$ and $\dot x$, so instantaneous frequency
   $\operatorname{Im}(\dot z/z)$ is nearly free, and it would sharpen the Lorentzian skirts that are
   the display's weakest measured property (the shallow dips of section 2).
2. **Higher-order gammatones**, i.e. $n$ cascaded identical resonators, physically $n$ masses on
   springs in series and still strictly causal. They buy much faster skirt roll-off, which is exactly
   what section 2 says the resogram lacks, and they stay inside the owner's own physics.
3. **Fix the +6 dB/octave tilt, or keep it deliberately.** For a perceptual display it is arguably
   closer to right than a spectrogram; for a spectral estimator it wants dividing by $\omega^2$.
   **Owner's call**; the library should expose it as a flag either way.
4. **The `ebar` sign question above**, which needs an owner decision before the display's default
   mode is settled.
5. **A `.mw` target.** Section 1 is a hand-rolled version of what the sidecar machinery does for
   `physics/Resogram.md`, but its claims are about *numerics* rather than symbols, which the current
   SymPy-tier instruments cannot express. That makes it a plausible second north-star case.
