"""Audio input.

Availability MEASURED on this machine (zomni, 2026-09-01):
  - soundfile 0.14.0 / libsndfile 1.2.2, available_formats() includes 'MP3'.
    MP3 decoding was exercised on a real file produced with ffmpeg n9.0.1
    (see demo.py --check-mp3); it worked.
  - ffmpeg n9.0.1 is on PATH, used as the fallback decoder for anything
    libsndfile refuses (m4a, opus in old builds, video containers).
  - scipy.io.wavfile is the zero-dependency WAV path and always works.

Order of attempts: soundfile (if importable) -> scipy wavfile (WAV only)
-> ffmpeg subprocess. Every failure is reported, never silently swallowed.
"""

from __future__ import annotations

import io as _io
import shutil
import subprocess
import wave

import numpy as np


def _to_mono_float(data: np.ndarray) -> np.ndarray:
    data = np.asarray(data)
    if data.ndim == 2:
        data = data.mean(axis=1)
    if np.issubdtype(data.dtype, np.integer):
        info = np.iinfo(data.dtype)
        data = data.astype(np.float64) / max(abs(info.min), info.max)
    return data.astype(np.float64, copy=False)


def _load_soundfile(path: str):
    import soundfile as sf

    data, sr = sf.read(path, always_2d=False)
    return _to_mono_float(data), float(sr)


def _load_scipy_wav(path: str):
    from scipy.io import wavfile

    sr, data = wavfile.read(path)
    return _to_mono_float(data), float(sr)


def _load_ffmpeg(path: str, sr: int | None = None):
    exe = shutil.which("ffmpeg")
    if exe is None:
        raise RuntimeError("ffmpeg not on PATH")
    cmd = [exe, "-v", "error", "-i", path, "-ac", "1", "-f", "wav"]
    if sr is not None:
        cmd += ["-ar", str(sr)]
    cmd += ["pipe:1"]
    raw = subprocess.run(cmd, check=True, capture_output=True).stdout
    with wave.open(_io.BytesIO(raw)) as w:
        n = w.getnframes()
        frames = w.readframes(n)
        width = w.getsampwidth()
        out_sr = w.getframerate()
    dtype = {1: np.uint8, 2: np.int16, 4: np.int32}[width]
    data = np.frombuffer(frames, dtype=dtype)
    if dtype is np.uint8:
        data = data.astype(np.float64) / 128.0 - 1.0
    return _to_mono_float(data), float(out_sr)


def load_audio(path: str, target_sr: float | None = None) -> tuple[np.ndarray, float]:
    """Load `path` as mono float64 in roughly [-1, 1] plus its sample rate.

    Raises RuntimeError listing every decoder that was tried and how it failed.
    """
    errors = []
    for name, fn in (
        ("soundfile", _load_soundfile),
        ("scipy.io.wavfile", _load_scipy_wav),
        ("ffmpeg", _load_ffmpeg),
    ):
        try:
            y, sr = fn(path)
            break
        except Exception as exc:  # noqa: BLE001 - we report every failure
            errors.append(f"{name}: {type(exc).__name__}: {exc}")
    else:
        raise RuntimeError("could not decode " + path + "\n  " + "\n  ".join(errors))

    if target_sr is not None and abs(sr - target_sr) > 1e-9:
        y, sr = resample_to(y, sr, target_sr)
    return y, sr


def resample_to(y: np.ndarray, sr: float, target_sr: float) -> tuple[np.ndarray, float]:
    """Polyphase resample (scipy.signal.resample_poly) to target_sr."""
    from fractions import Fraction

    from scipy.signal import resample_poly

    frac = Fraction(target_sr / sr).limit_denominator(1000)
    return resample_poly(y, frac.numerator, frac.denominator), float(target_sr)


def decoder_report() -> str:
    """Human-readable report of what this machine can actually decode."""
    lines = []
    try:
        import soundfile as sf

        fmts = sorted(sf.available_formats())
        lines.append(
            f"soundfile {sf.__version__} / libsndfile {sf.__libsndfile_version__}; "
            f"MP3 in formats: {'MP3' in fmts}"
        )
    except Exception as exc:  # noqa: BLE001
        lines.append(f"soundfile unavailable: {exc}")
    exe = shutil.which("ffmpeg")
    lines.append(f"ffmpeg: {exe or 'NOT FOUND'}")
    return "\n".join(lines)
