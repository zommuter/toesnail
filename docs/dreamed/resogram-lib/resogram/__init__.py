"""resogram: a resonator-bank time-frequency display.

DREAMED, UNREVIEWED AI exploration. See docs/dreamed/README.md in the toesnail
repo. The physics it implements is the owner's (physics/Resogram.md); this
package neither edits nor ratifies it.
"""

from .core import (  # noqa: F401
    ResonatorBank,
    apply_ebar,
    ebar_kernel,
    log_freqs,
    make_bank,
    resogram,
    resonate,
    specific_energy,
    steady_state_amplitude,
)

__version__ = "0.1.0"
__all__ = [
    "ResonatorBank",
    "apply_ebar",
    "ebar_kernel",
    "log_freqs",
    "make_bank",
    "resogram",
    "resonate",
    "specific_energy",
    "steady_state_amplitude",
]
