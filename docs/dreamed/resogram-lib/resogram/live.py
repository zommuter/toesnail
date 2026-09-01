"""Live microphone resogram.

UNTESTED-HERE. The machine this was written on (zomni, 2026-09-01) ran the
agent headless with no audio capture device and no display, so this module was
never executed against real hardware. It is written to be correct by
construction from the offline path (which IS tested) but you should treat any
claim about its behaviour as unverified until you run it yourself.

Design: the resonator bank is an IIR filterbank, so it is genuinely streamable.
`lfilter` carries per-block state in `zi`, which means block-by-block filtering
gives BIT-IDENTICAL output to filtering the whole signal at once. That is the
resogram's structural advantage for live use over both the STFT (needs a whole
window) and the CWT (needs a two-sided kernel, hence future samples).

Run:  python -m resogram.cli live --sr 22050 --q 16
"""

from __future__ import annotations

import numpy as np
from scipy.signal import lfilter, lfilter_zi

from .core import ResonatorBank, make_bank


class StreamingBank:
    """Block-streaming wrapper around a ResonatorBank.

    Verified offline (tests/test_core.py::test_streaming_matches_batch): feeding
    a signal in blocks reproduces the batch result to within 1e-12 relative.
    """

    def __init__(self, bank: ResonatorBank):
        self.bank = bank
        n = len(bank)
        self.zi_x = np.zeros((n, 2))
        self.zi_v = np.zeros((n, 2))

    def reset(self) -> None:
        self.zi_x[:] = 0.0
        self.zi_v[:] = 0.0

    def push(self, block: np.ndarray) -> np.ndarray:
        """Filter one block; return the specific energy, shape (n_freqs, len)."""
        block = np.asarray(block, dtype=float)
        out = np.empty((len(self.bank), len(block)), dtype=float)
        for i in range(len(self.bank)):
            x, self.zi_x[i] = lfilter(
                self.bank.b_x[i], self.bank.a[i], block, zi=self.zi_x[i]
            )
            v, self.zi_v[i] = lfilter(
                self.bank.b_v[i], self.bank.a[i], block, zi=self.zi_v[i]
            )
            out[i] = 0.5 * v**2 + 0.5 * self.bank.omega[i] ** 2 * x**2
        return out


def run_live(
    sr: int = 22050,
    f_min: float = 55.0,
    f_max: float = 8000.0,
    bins_per_octave: int = 12,
    Q: float = 16.0,
    seconds: float = 4.0,
    hop: int = 128,
    block: int = 1024,
    device=None,
) -> None:
    """Open the default input device and animate a scrolling resogram.

    UNTESTED-HERE. Requires `sounddevice` (PortAudio) and `matplotlib`.
    """
    import matplotlib.pyplot as plt
    import sounddevice as sd
    from matplotlib.animation import FuncAnimation

    bank = make_bank(
        sr, f_min=f_min, f_max=f_max, bins_per_octave=bins_per_octave, Q=Q
    )
    stream_bank = StreamingBank(bank)
    n_frames = int(seconds * sr / hop)
    display = np.full((len(bank), n_frames), 1e-12)
    phase = 0  # sample offset of the next decimation point inside a block

    def callback(indata, frames, time_info, status):
        nonlocal display, phase
        if status:
            print("audio status:", status)
        e = stream_bank.push(indata[:, 0].astype(float))
        take = np.arange(phase, e.shape[1], hop)
        phase = (phase - e.shape[1]) % hop
        cols = e[:, take]
        k = cols.shape[1]
        if k:
            display = np.roll(display, -k, axis=1)
            display[:, -k:] = np.maximum(cols, 1e-12)

    fig, ax = plt.subplots(figsize=(10, 5))
    img = ax.imshow(
        10.0 * np.log10(display),
        origin="lower",
        aspect="auto",
        interpolation="nearest",
        extent=(-seconds, 0.0, 0.0, float(len(bank))),
        vmin=-90,
        vmax=10,
        cmap="magma",
    )
    ticks = np.linspace(0, len(bank) - 1, 8).astype(int)
    ax.set_yticks(ticks + 0.5)
    ax.set_yticklabels([f"{bank.freqs_hz[i]:.0f}" for i in ticks])
    ax.set_xlabel("time relative to now [s]")
    ax.set_ylabel("resonator frequency [Hz]")
    ax.set_title(f"live resogram, Q={Q} (UNTESTED path)")
    fig.colorbar(img, ax=ax, label="specific energy [dB]")

    def update(_):
        img.set_data(10.0 * np.log10(np.maximum(display, 1e-12)))
        return (img,)

    with sd.InputStream(
        samplerate=sr, channels=1, blocksize=block, callback=callback, device=device
    ):
        anim = FuncAnimation(fig, update, interval=50, blit=False, cache_frame_data=False)
        plt.show()
        del anim
