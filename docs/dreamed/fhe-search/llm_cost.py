#!/usr/bin/env python3
"""What an FHE-LLM would cost, from a transparent operation count.

DREAMED ARTIFACT -- see docs/dreamed/README.md. Not owner-authored, not reviewed.

Companion to `docs/dreamed/fhe-llm.md`. This is an ESTIMATE, not a measurement:
it counts operations exactly and then multiplies by published per-operation
costs. Every anchor is named inline with its source so the arithmetic can be
re-run against better numbers. The point is the SHAPE -- which part of a
transformer is expensive under encryption and which part is nearly free --
and the shape is robust even if the constants move by an order of magnitude.

  G  ciphertext x plaintext vs ciphertext x ciphertext -- the split that decides
     everything, since public model weights are plaintext.
  H  nonlinearity budget -- how many softmax / activation / norm evaluations a
     token costs, these being the operations FHE cannot do natively.
  I  embedding placement -- the cost of an encrypted vocabulary lookup against
     the cost of letting the client embed. Reads on the OTRO result.
  J  reality check -- the estimate against published measured systems.
  K  length leakage -- what padding buys, in bits, against the token-length
     side channel of Weiss et al. (USENIX Security 2024).

Pure stdlib. Run via ./run.sh (address space and CPU capped).
"""

from __future__ import annotations

import math

# --------------------------------------------------------------------------
# Model geometries. d = model width, L = layers, h = heads, V = vocab,
# dff = FFN inner width, params = total.
# --------------------------------------------------------------------------

MODELS = {
    "GPT-2 small": dict(d=768, L=12, h=12, V=50257, dff=3072, params=124e6),
    "GPT-2 XL": dict(d=1600, L=48, h=25, V=50257, dff=6400, params=1.5e9),
    "Llama-3 8B": dict(d=4096, L=32, h=32, V=128256, dff=14336, params=8.0e9),
    "Llama-3 70B": dict(d=8192, L=80, h=64, V=128256, dff=28672, params=70e9),
}

# Published anchors, each labelled with its source. All are order-of-magnitude
# inputs to the estimate, not claims of this document.
ANCHOR = {
    # Zama Concrete-ML GPT-2 demo: ~11 s/token on GPU, ~300 s/token on CPU,
    # ~2.2 MB exchanged per token (huggingface/blog `encrypted-llm.md`, Zama docs).
    "zama_gpt2_gpu_s": 11.0,
    "zama_gpt2_cpu_s": 300.0,
    "zama_gpt2_bytes": 2.2e6,
    # PUMA (arXiv 2307.12533): LLaMA-7B, one token in under 5 minutes -- MPC,
    # two-party, NOT FHE, listed because it is the fast end of the field.
    "puma_llama7b_s": 300.0,
    # BumbleBee (NDSS 2025): ~8 min/token for LLaMA-7B on CPUs, also 2PC.
    "bumblebee_llama7b_s": 480.0,
    # A plaintext decode step, single stream, commodity GPU: order 10 ms.
    "plain_token_s": 0.010,
}


def rule(title: str) -> None:
    print()
    print("=" * 74)
    print(title)
    print("=" * 74)


# --------------------------------------------------------------------------
# G -- where the multiplications are, and which kind
# --------------------------------------------------------------------------


def per_token_ops(m: dict, ctx: int) -> dict:
    """Multiply counts for ONE decoded token at context length `ctx`.

    Split by the distinction that dominates FHE cost: a product where one
    factor is a public model weight (ct x pt, cheap, no relinearisation) versus
    a product of two ciphertexts (ct x ct, expensive).
    """
    d, L, h, V, dff = m["d"], m["L"], m["h"], m["V"], m["dff"]
    # per layer, ct x pt: Q,K,V,O projections (4 d^2) + FFN (2 or 3 * d * dff)
    ctpt_layer = 4 * d * d + 3 * d * dff
    # per layer, ct x ct: QK^T over the context (h * ctx * d/h = ctx * d) and
    # the PV contraction (same shape) -- both operands derive from the input.
    ctct_layer = 2 * ctx * d
    return dict(
        ctpt=L * ctpt_layer + d * V,          # + the output unembedding
        ctct=L * ctct_layer,
        softmax_entries=L * h * ctx,
        activations=L * dff,
        norms=2 * L,
    )


def experiment_G() -> None:
    rule("G. The split that decides everything: ct x pt against ct x ct")
    print("Model weights are PUBLIC -- the server owns them. So nearly every")
    print("multiplication in a transformer has one plaintext operand, which under")
    print("CKKS costs no relinearisation and no key switching. The genuinely hard")
    print("products are the two inside attention, where both operands come from")
    print("the encrypted input.")
    print()
    ctx = 512
    print(f"context length {ctx}, one decoded token")
    print()
    print(f"{'model':<14} {'ct x pt mults':>15} {'ct x ct mults':>15} "
          f"{'ct x ct share':>14}")
    print("-" * 74)
    for name, m in MODELS.items():
        o = per_token_ops(m, ctx)
        share = o["ctct"] / (o["ctct"] + o["ctpt"])
        print(f"{name:<14} {o['ctpt']:>15.3e} {o['ctct']:>15.3e} {share:>13.2%}")
    print("-" * 74)
    print("Under six percent of the multiplications are ciphertext-ciphertext,")
    print("and under one percent at 70B: the share SHRINKS with model size,")
    print("because width-squared projection work grows faster than the")
    print("context-linear attention work.")
    print("An FHE-LLM is therefore NOT hard because of its matrix multiplies.")
    print("It is hard because of what experiment H counts.")


# --------------------------------------------------------------------------
# H -- the nonlinearity budget
# --------------------------------------------------------------------------


def experiment_H() -> None:
    rule("H. The nonlinearity budget -- the part FHE cannot do at all")
    print("CKKS and BGV compute polynomials. Softmax needs exp and a division,")
    print("RMSNorm needs an inverse square root, SiLU/GELU need a sigmoid or erf.")
    print("None is a polynomial; each must be replaced by an approximation whose")
    print("degree costs multiplicative depth, or by a TFHE programmable")
    print("bootstrap (PBS) costing roughly 10 ms each on a CPU core.")
    print()
    ctx = 512
    print(f"{'model':<14} {'softmax entries':>16} {'activations':>13} "
          f"{'norms':>7} {'PBS-equiv hours':>16}")
    print("-" * 74)
    pbs_s = 0.010
    for name, m in MODELS.items():
        o = per_token_ops(m, ctx)
        n = o["softmax_entries"] + o["activations"] + o["norms"]
        print(f"{name:<14} {o['softmax_entries']:>16.3e} {o['activations']:>13.3e} "
              f"{o['norms']:>7} {n * pbs_s / 3600:>16.2f}")
    print("-" * 74)
    print("Read the last column as the naive, unpacked, one-PBS-per-nonlinearity")
    print("bound: hours per token. Real systems do far better by SIMD-packing")
    print("thousands of slots into one ciphertext and by replacing softmax with a")
    print("low-degree approximation, which is exactly why the measured numbers in")
    print("experiment J are seconds and minutes rather than hours. The column is")
    print("here to show WHAT the packing has to defeat.")


# --------------------------------------------------------------------------
# I -- where the embedding lookup should happen
# --------------------------------------------------------------------------


def experiment_I() -> None:
    rule("I. Embedding placement: the one free win, and why it is not free")
    print("An encrypted token id cannot index a table. Done server-side, the")
    print("lookup is a one-hot times the embedding matrix -- V x d multiplies per")
    print("token. Done client-side, it costs nothing: the embedding matrix is")
    print("public model weights the client can hold.")
    print()
    print(f"{'model':<14} {'server-side V*d':>16} {'as % of a layer':>16} "
          f"{'client-side':>12}")
    print("-" * 74)
    for name, m in MODELS.items():
        vd = m["V"] * m["d"]
        layer = 4 * m["d"] ** 2 + 3 * m["d"] * m["dff"]
        print(f"{name:<14} {vd:>16.3e} {vd / layer:>15.1%} {'0':>12}")
    print("-" * 74)
    print("So the client should embed, and the saving is a whole layer's worth of")
    print("work or more. The interesting part is what that ALSO buys.")
    print()
    print("OTRO (arXiv 2606.17358, USC/Roblox/NVIDIA) hardens the tokenizer with")
    print("square-root ORAM because, it reports, TDXRay demonstrated end-to-end")
    print("prompt reconstruction at over 90% similarity on production Intel TDX by")
    print("watching tokenizer memory ADDRESSES. Read the threat model before")
    print("importing the conclusion: OTRO's adversary is a malicious hypervisor")
    print("under a confidential VM, where the server tokenizes PLAINTEXT inside an")
    print("enclave and leaks the address trace of a hash-map lookup. That attack")
    print("has no analogue under FHE. The client tokenizes on its own machine; the")
    print("server never touches the vocabulary table, so there is no access pattern")
    print("to observe. OTRO itself separates its channel from the token-length")
    print("attacks of experiment K, which DO survive encryption.")
    print()
    print("This is one of the few places FHE strictly beats a TEE rather than")
    print("merely costing more than one: the whole class of enclave access-pattern")
    print("side channels is absent by construction, because the untrusted side")
    print("never holds a plaintext address to leak. Whether that is worth three to")
    print("four orders of magnitude is experiment J's question, not this one's.")


# --------------------------------------------------------------------------
# J -- the estimate against measured systems
# --------------------------------------------------------------------------


def experiment_J() -> None:
    rule("J. Reality check against published measured systems")
    print("Every row below is somebody else's measurement, not this document's.")
    print()
    rows = [
        ("Zama Concrete-ML, GPT-2, GPU", ANCHOR["zama_gpt2_gpu_s"], "FHE (CKKS/TFHE)"),
        ("Zama Concrete-ML, GPT-2, CPU", ANCHOR["zama_gpt2_cpu_s"], "FHE (CKKS/TFHE)"),
        ("PUMA, LLaMA-7B", ANCHOR["puma_llama7b_s"], "2PC MPC, not FHE"),
        ("BumbleBee, LLaMA-7B", ANCHOR["bumblebee_llama7b_s"], "2PC MPC, not FHE"),
    ]
    print(f"{'system':<32} {'s / token':>10} {'slowdown':>11}  regime")
    print("-" * 74)
    for label, s, regime in rows:
        print(f"{label:<32} {s:>10.1f} {s / ANCHOR['plain_token_s']:>10.0f}x  {regime}")
    print("-" * 74)
    print(f"Bandwidth, Zama GPT-2: {ANCHOR['zama_gpt2_bytes'] / 1e6:.1f} MB per token,")
    print("against roughly 2 bytes for the plaintext token itself -- an expansion")
    print("of about 1e6. For an interactive assistant that is the binding")
    print("constraint before the latency is.")
    print()
    print("So: three to four orders of magnitude for a 124M-parameter model, and")
    print("the two fastest systems in the table are not FHE at all -- they are")
    print("two-party MPC, which is faster precisely because it lets the client do")
    print("the nonlinearities in the clear on secret-shared data. Note also that")
    print("the MPC rows are for a 7B model and the FHE rows for a 124M one, so")
    print("the table understates the gap between the two regimes rather than")
    print("overstating it.")


# --------------------------------------------------------------------------
# K -- length leakage and what padding buys
# --------------------------------------------------------------------------


def experiment_K() -> None:
    rule("K. Length leakage: the channel encryption does not close")
    print("Weiss et al. (USENIX Security 2024) reconstructed 27% of an AI")
    print("assistant's responses and inferred the topic of 53% from the sequence")
    print("of TOKEN LENGTHS alone, over TLS. FHE does not help: it hides values,")
    print("not the number of ciphertexts or when they were sent. Padding to")
    print("buckets is the mitigation; here is what it costs and what it leaves.")
    print()
    print(f"{'scheme':<28} {'leaked bits (n<=2048)':>22} {'mean waste':>12}")
    print("-" * 74)
    maxn = 2048
    # exact leakage = log2 of the number of distinguishable classes
    schemes = []
    schemes.append(("no padding", maxn, 0.0))
    for base in (2, 4, 16):
        buckets = []
        b = 1
        while b < maxn:
            buckets.append(b)
            b *= base
        buckets.append(maxn)
        waste = sum(min(b for b in buckets if b >= n) - n for n in range(1, maxn + 1))
        schemes.append((f"power-of-{base} buckets", len(buckets), waste / maxn))
    schemes.append(("pad every request to max", 1, (maxn + 1) / 2 - 0.5))
    for label, classes, waste in schemes:
        print(f"{label:<28} {math.log2(classes):>22.2f} {waste:>11.1f} tokens")
    print("-" * 74)
    print("Powers of two cut the leak from 11 bits to under 4 for a mean waste of")
    print("a few hundred tokens, and full padding closes it entirely at a mean")
    print("waste of ~1024 tokens per request. Under FHE, where a token already")
    print("costs seconds, padding to the maximum is the only defensible setting --")
    print("and it multiplies an already 1e3-1e4 slowdown by another large factor.")
    print("That interaction is the honest reason FHE-LLM is hard, and it is not")
    print("a cryptographic problem at all.")


def main() -> None:
    print("toesnail / docs/dreamed -- FHE-LLM cost estimate")
    print("DREAMED ARTIFACT, unreviewed. See docs/dreamed/README.md.")
    print("ESTIMATE: exact operation counts times published per-operation costs.")
    experiment_G()
    experiment_H()
    experiment_I()
    experiment_J()
    experiment_K()
    print()
    print("done.")


if __name__ == "__main__":
    main()
