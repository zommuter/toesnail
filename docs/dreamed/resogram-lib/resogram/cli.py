"""Command line entry point.

  resogram render FILE.mp3 -o out.png     # offline resogram, TESTED here
  resogram compare FILE.wav -o cmp.png    # resogram vs STFT vs Morlet CWT
  resogram probe                          # which decoders exist on this machine
  resogram live                           # microphone, UNTESTED-HERE
"""

from __future__ import annotations

import argparse
import sys

import numpy as np


def _plot_tf(ax, times, freqs, P, title, floor_db=80.0):
    P = np.maximum(P, 1e-300)
    db = 10.0 * np.log10(P / P.max())
    im = ax.pcolormesh(
        times, freqs, np.maximum(db, -floor_db), shading="nearest", cmap="magma"
    )
    ax.set_yscale("log")
    ax.set_ylabel("frequency [Hz]")
    ax.set_title(title)
    return im


def cmd_render(args) -> int:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    from .core import resogram
    from .io import load_audio

    y, sr = load_audio(args.file, target_sr=args.sr)
    if args.seconds:
        y = y[: int(args.seconds * sr)]
    freqs, times, E = resogram(
        y,
        sr,
        hop=args.hop,
        mode=args.mode,
        f_min=args.fmin,
        f_max=args.fmax,
        bins_per_octave=args.bpo,
        Q=args.q,
    )
    fig, ax = plt.subplots(figsize=(11, 5))
    im = _plot_tf(ax, times, freqs, E, f"resogram ({args.mode}), Q={args.q}, {args.file}")
    ax.set_xlabel("time [s]")
    fig.colorbar(im, ax=ax, label="specific energy [dB rel. max]")
    fig.tight_layout()
    fig.savefig(args.out, dpi=130)
    print(f"wrote {args.out}  ({len(freqs)} resonators x {len(times)} frames, sr={sr:.0f})")
    return 0


def cmd_compare(args) -> int:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    from .compare import hann_nperseg_for_Q, morlet_cwt_power, stft_power
    from .core import resogram
    from .io import load_audio

    y, sr = load_audio(args.file, target_sr=args.sr)
    if args.seconds:
        y = y[: int(args.seconds * sr)]
    freqs, times, E = resogram(
        y, sr, hop=args.hop, mode="e", f_min=args.fmin, f_max=args.fmax,
        bins_per_octave=args.bpo, Q=args.q,
    )
    _, C = morlet_cwt_power(y, sr, freqs, args.q, hop=args.hop)
    nper = hann_nperseg_for_Q(sr, args.q, args.fref)
    sf, st, S = stft_power(y, sr, nper, hop=args.hop)

    fig, axes = plt.subplots(3, 1, figsize=(11, 11), sharex=True)
    _plot_tf(axes[0], times, freqs, E, f"resogram (energy), Q={args.q}")
    _plot_tf(axes[1], times, freqs, C, f"Morlet CWT |W|^2, Q={args.q}")
    _plot_tf(axes[2], st, sf[1:], S[1:], f"STFT, Hann N={nper} (Q={args.q} at {args.fref} Hz)")
    axes[2].set_xlabel("time [s]")
    fig.tight_layout()
    fig.savefig(args.out, dpi=130)
    print(f"wrote {args.out}")
    return 0


def cmd_probe(args) -> int:
    from .io import decoder_report

    print(decoder_report())
    return 0


def cmd_live(args) -> int:
    from .live import run_live

    print("live mode is UNTESTED on the machine this package was written on.")
    run_live(
        sr=args.sr, f_min=args.fmin, f_max=args.fmax, bins_per_octave=args.bpo,
        Q=args.q, seconds=args.window, hop=args.hop,
    )
    return 0


def main(argv=None) -> int:
    p = argparse.ArgumentParser(prog="resogram", description=__doc__)
    sub = p.add_subparsers(dest="cmd", required=True)

    def common(sp):
        sp.add_argument("--sr", type=float, default=22050.0)
        sp.add_argument("--fmin", type=float, default=55.0)
        sp.add_argument("--fmax", type=float, default=8000.0)
        sp.add_argument("--bpo", type=int, default=12, help="bins per octave")
        sp.add_argument("--q", type=float, default=16.0)
        sp.add_argument("--hop", type=int, default=64, help="output decimation")

    sp = sub.add_parser("render")
    sp.add_argument("file")
    sp.add_argument("-o", "--out", default="resogram.png")
    sp.add_argument("--mode", choices=["e", "ebar"], default="e")
    sp.add_argument("--seconds", type=float, default=0.0)
    common(sp)
    sp.set_defaults(func=cmd_render)

    sp = sub.add_parser("compare")
    sp.add_argument("file")
    sp.add_argument("-o", "--out", default="compare.png")
    sp.add_argument("--seconds", type=float, default=0.0)
    sp.add_argument("--fref", type=float, default=440.0)
    common(sp)
    sp.set_defaults(func=cmd_compare)

    sp = sub.add_parser("probe")
    sp.set_defaults(func=cmd_probe)

    sp = sub.add_parser("live")
    sp.add_argument("--window", type=float, default=4.0)
    common(sp)
    sp.set_defaults(func=cmd_live)

    args = p.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
