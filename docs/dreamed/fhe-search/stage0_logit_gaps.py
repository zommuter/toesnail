#!/usr/bin/env python3
"""Stage 0: measure on a real model what four essays in this batch only modelled.

DREAMED ARTIFACT -- see docs/dreamed/README.md. Not owner-authored, not reviewed.

Stage 0 of the plan in `docs/dreamed/model-attestation.md` section 9, run at the owner's
instruction (2026-09-04). Unlike its five siblings in this directory, this script is NOT
pure stdlib: it loads GPT-2 through transformers/torch. It is therefore excluded from
`run.sh`'s default list and must be asked for by name.

It tests four claims that the essays made parametrically or by proxy, and each test can
come out against the essay:

  U  top-2 logit gap distribution   -- `trustless-distributed-ai.md` section 4 modelled
                                       this as Exponential and warned the guess was
                                       "wrong in the direction that hurts". Now measured.
  V  honest-implementation spread   -- that essay's section 2 estimated cross-provider
                                       logit divergence from synthetic dot products
                                       (~1e-5 at float32). Here it is the real thing:
                                       the same model in float32 against float64.
  W  argmax flip rate               -- feeds the amplification table of section 3, whose
                                       whole point is that this rate compounds.
  X  precision-swap KL              -- `model-attestation.md` section 3 DERIVED
                                       ~0.023 nats/token for 4-bit quantization by
                                       inverting DiFR's threshold. bfloat16 is a much
                                       milder swap, so this is a sanity bound rather
                                       than a confirmation: the measured value must come
                                       out well BELOW 0.023 or the derivation is wrong.

Run:  cd docs/dreamed/fhe-search && ../capped.sh -m 8G -c 400 -t 1800 -- python3 -u stage0_logit_gaps.py
"""

from __future__ import annotations

import math
import os
import pathlib
import sys

os.environ.setdefault("HF_HUB_DISABLE_TELEMETRY", "1")
os.environ.setdefault("TOKENIZERS_PARALLELISM", "false")

try:
    import torch
    from transformers import AutoModelForCausalLM, AutoTokenizer
except Exception as exc:  # pragma: no cover
    print(f"SKIP: torch/transformers unavailable ({exc})")
    sys.exit(0)

MODEL = "gpt2"
torch.set_num_threads(4)


def rule(title: str) -> None:
    print()
    print("=" * 74)
    print(title)
    print("=" * 74)


def corpus() -> list[str]:
    """Text to measure on. Uses this repository's own prose, so the run is
    self-contained and needs no dataset download. Physics prose is not a neutral
    sample of English and the essay must say so."""
    root = pathlib.Path(__file__).resolve().parents[3]
    texts = []
    for rel in ("crypto/fhe.md", "physics/toesnail.md", "README.md",
                "essays/Narrativium.md"):
        p = root / rel
        if p.exists():
            body = p.read_text(encoding="utf-8", errors="ignore")
            body = "\n".join(l for l in body.splitlines()
                             if not l.startswith(("|", "$$", "---", "#")))
            if len(body) > 400:
                texts.append(body[:12000])
    if not texts:
        texts = ["The quick brown fox jumps over the lazy dog. " * 200]
    return texts


def main() -> None:
    print("toesnail / docs/dreamed -- stage 0: real logit measurements")
    print("DREAMED ARTIFACT, unreviewed. See docs/dreamed/README.md.")
    print(f"model: {MODEL}")

    tok = AutoTokenizer.from_pretrained(MODEL)
    model32 = AutoModelForCausalLM.from_pretrained(MODEL, dtype=torch.float32).eval()

    texts = corpus()
    print(f"corpus: {len(texts)} documents from this repository")

    gaps: list[float] = []
    spreads: list[float] = []
    flips = 0
    total = 0
    kl_sum = 0.0

    model64 = model32.to(torch.float64)
    model32 = AutoModelForCausalLM.from_pretrained(MODEL, dtype=torch.float32).eval()

    with torch.no_grad():
        for text in texts:
            ids = tok(text, return_tensors="pt", truncation=True, max_length=512)
            out32 = model32(**ids).logits[0].to(torch.float64)
            out64 = model64(**{k: v for k, v in ids.items()}).logits[0]
            outbf = model32(**ids).logits[0].to(torch.bfloat16).to(torch.float64)

            top2 = torch.topk(out64, k=2, dim=-1).values
            gaps.extend((top2[:, 0] - top2[:, 1]).tolist())

            spreads.extend((out32 - out64).abs().max(dim=-1).values.tolist())

            a32 = out32.argmax(dim=-1)
            a64 = out64.argmax(dim=-1)
            flips += int((a32 != a64).sum())
            total += a64.numel()

            lp64 = torch.log_softmax(out64, dim=-1)
            lpbf = torch.log_softmax(outbf, dim=-1)
            kl_sum += float((lp64.exp() * (lp64 - lpbf)).sum(dim=-1).sum())

    n = len(gaps)
    gaps_sorted = sorted(gaps)

    # ---------------- U ----------------
    rule("U. The top-2 logit gap distribution, measured")
    mean = sum(gaps) / n
    print(f"positions measured: {n}      mean gap: {mean:.4f} nats")
    print()
    print(f"{'quantile':>10} {'gap':>12}")
    print("-" * 74)
    for q in (0.0001, 0.001, 0.01, 0.05, 0.25, 0.5, 0.75, 0.95):
        print(f"{q:>10.2%} {gaps_sorted[min(int(q * n), n - 1)]:>12.5f}")
    print("-" * 74)
    print("Escalation rate P(gap <= 2*eps), MEASURED against the Exponential model that")
    print("`trustless-distributed-ai.md` section 4 used with the same mean:")
    print()
    print(f"{'eps':>10} {'measured':>14} {'Exp(mean) model':>18} {'ratio':>10}")
    print("-" * 74)
    for eps in (1e-5, 1e-4, 1e-3, 1e-2):
        thr = 2 * eps
        emp = sum(1 for g in gaps if g <= thr) / n
        modelled = 1 - math.exp(-thr / mean)
        ratio = (emp / modelled) if modelled > 0 else float("nan")
        print(f"{eps:>10.0e} {emp:>14.3e} {modelled:>18.3e} {ratio:>10.2f}")
    print("-" * 74)

    # ---------------- V ----------------
    rule("V. Honest-implementation logit spread: float32 against float64")
    spreads_sorted = sorted(spreads)
    print("The same weights, the same input, one model in float32 and one in float64.")
    print("This is the real version of the synthetic dot-product estimate in")
    print("`trustless-distributed-ai.md` section 2 (which predicted ~1e-5 at float32).")
    print()
    print(f"{'quantile':>10} {'max |logit diff| at that position':>36}")
    print("-" * 74)
    for q in (0.5, 0.95, 0.99, 1.0):
        print(f"{q:>10.0%} {spreads_sorted[min(int(q * len(spreads)), len(spreads) - 1)]:>36.3e}")
    print("-" * 74)

    # ---------------- W ----------------
    rule("W. Argmax flip rate between the two precisions")
    print(f"positions: {total}      flips: {flips}      rate: {flips / total:.3e}")
    print()
    print("This is the per-token divergence probability p that the amplification table")
    print("of `trustless-distributed-ai.md` section 3 compounds. At this rate, the")
    print("probability that a completion is reproduced exactly:")
    print()
    p = flips / total
    print(f"{'n tokens':>10} {'P(exact match)':>18}")
    print("-" * 74)
    for nt in (16, 64, 256, 1024, 4096):
        print(f"{nt:>10} {(1 - p) ** nt:>18.4f}")
    print("-" * 74)

    # ---------------- X ----------------
    rule("X. Precision-swap KL divergence per token")
    kl = kl_sum / total
    print(f"KL(float32 || bfloat16-rounded) = {kl:.6f} nats/token")
    print()
    print(f"`model-attestation.md` section 3 DERIVED 0.0230 nats/token for 4-bit")
    print("quantization by inverting DiFR's 300-token detection threshold. bfloat16 is")
    print("a far milder distortion than 4-bit, so the derivation is consistent only if")
    print("this measurement lands well below that figure.")
    print()
    if kl < 0.023:
        print(f"CONSISTENT: {kl:.6f} < 0.0230, by a factor of {0.023 / max(kl, 1e-12):.0f}.")
    else:
        print(f"INCONSISTENT: {kl:.6f} >= 0.0230. The derived figure is too small,")
        print("which would mean DiFR's 300-token threshold implies a LARGER per-token")
        print("KL than the essay claims, and section 3's 150x ratio needs revisiting.")
    print()
    print("Caveat: bfloat16 rounding of the OUTPUT logits is not the same distortion as")
    print("running the whole network in a lower precision, which compounds through every")
    print("layer. This is a lower bound on a precision swap's KL, not an estimate of one.")


if __name__ == "__main__":
    main()
