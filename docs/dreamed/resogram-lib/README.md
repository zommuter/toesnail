# resogram

**DREAMED, UNREVIEWED.** AI-generated exploration under `docs/dreamed/`; see
`docs/dreamed/README.md`. The owner dictated the seed on 2026-09-01. Nothing here
is toesnail theory, and nothing here edits `physics/`. Findings about
`physics/Resogram.md` are SURFACED in `docs/dreamed/resogram-library.md`,
never applied.

A working time-frequency display built out of the owner's driven damped harmonic
oscillator: drive a bank of resonators with an audio signal and plot each one's
specific energy against its natural frequency and time.

    x_tt + 2*beta*x_t + omega**2 * (x - y) = 0
    e = x_t**2/2 + omega**2 * x**2/2

`physics/Resogram.md` handles `eom`, `e`, `sol`, `esol`, `ebar`.

## Install and run

Nothing is installed system-wide; every command below is self-contained.

```
cd docs/dreamed/resogram-lib

# tests (39 assertions, ~0.6 s)
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project \
    --with numpy --with scipy --with pytest python -m pytest tests -q )

# every number and figure in the essay
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project \
    --with numpy --with scipy --with matplotlib --with soundfile python demo.py )

# what audio decoders this machine actually has
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project \
    --with numpy --with scipy --with matplotlib --with soundfile \
    python -m resogram.cli probe )

# render one file (wav, mp3, flac, ogg, or anything ffmpeg can open)
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project \
    --with numpy --with scipy --with matplotlib --with soundfile \
    python -m resogram.cli render out/probe.mp3 -o out/r.png --q 24 )

# resogram vs Morlet CWT vs STFT, identical input, stacked panels
( ulimit -v 4000000; PYTHONPATH=. uv run --no-project \
    --with numpy --with scipy --with matplotlib --with soundfile \
    python -m resogram.cli compare out/probe.mp3 -o out/cmp.png )
```

`pyproject.toml` is a normal uv/hatch project too, so `uv sync && uv run resogram probe`
works if you prefer an installed environment.

The `ulimit -v 4000000` prefix is a hard requirement of the toesnail agent
contract after an out-of-memory incident; keep it.

## Status, honestly

| Piece | State |
| --- | --- |
| Resonator bank, energy, ebar | Working, validated against the owner's closed forms to 1e-6 relative or better below 2 kHz |
| WAV I/O | Working, exercised |
| MP3 I/O | Working, exercised: ffmpeg n9.0.1 encoded a file and soundfile 0.14.0 / libsndfile 1.2.2 decoded it back |
| STFT and Morlet CWT baselines | Working, exercised |
| Static PNG output | Working, four figures in `out/` |
| `--live` microphone mode | **UNTESTED HERE.** Written, never run: the machine had no capture device and no display. The block-streaming core underneath it IS tested (`test_streaming_matches_batch`, bit-identical to batch filtering within 1e-12). |

## Lean companion

`docs/dreamed/lean/Resogram2.lean` proves the `ebar` sign result (`ebar_minus_exact`) and the
discrete pole-stability condition. Check it with
`cd verify && nice -n19 lake env lean --threads=2 ../docs/dreamed/lean/Resogram2.lean`
(exit 0, no `sorry`). It is outside the `verify` lake target and cannot affect `make test`.

## Layout

    resogram/core.py     resonator bank, discretisation, e and ebar
    resogram/io.py       audio loading (soundfile -> scipy wav -> ffmpeg)
    resogram/compare.py  STFT and Morlet CWT baselines plus the metric harness
    resogram/live.py     streaming bank and the untested microphone display
    resogram/cli.py      render / compare / probe / live
    tests/test_core.py   39 assertions
    demo.py              produces out/validation.txt and the four PNGs

## Accuracy envelope, measured

At sr = 22050 Hz the on-resonance amplitude and energy match the closed forms to
about 3e-7 relative at 110 Hz and 7e-5 at 4 kHz. The one artefact worth knowing
about is a small ripple on an energy that should be flat, caused by the velocity
channel's phase relative to `i*omega*x`: 6.5e-5 at 110 Hz, 2.6e-4 at 440 Hz,
1.1e-3 at 1760 Hz, 2.3e-2 at 4 kHz. It falls roughly 4x per doubling of the
sample rate (`test_energy_ripple_vanishes_as_sample_rate_rises`). Keep
`f_max <= 0.2*sr` for sub-percent behaviour.

## What Q does

`beta = omega/(2*Q)`, so the bank is constant-Q: ring-down time `2*Q/omega`,
-3 dB power bandwidth `omega/Q` (measured 44.03 Hz at 880 Hz for Q = 20, against
44.00 Hz for the Q-matched Morlet). Higher Q buys frequency resolution and pays
in time smearing, linearly. There is no window length that makes an STFT
constant-Q at more than one frequency; `hann_nperseg_for_Q` matches at a stated
reference frequency and the code says so.
