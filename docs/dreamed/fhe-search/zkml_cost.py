#!/usr/bin/env python3
"""Is the zkML proving gap structural, or is it a constant factor?

DREAMED ARTIFACT -- see docs/dreamed/README.md. Not owner-authored, not reviewed.

Companion to `docs/dreamed/zkml-proofs.md`. Every input number below is somebody
else's PUBLISHED MEASUREMENT, named at the point of use. Everything this file prints
is arithmetic on those numbers and is labelled DERIVED. Nothing here loads a model,
runs a prover, or measures anything itself.

  A  proving overhead      -- published prover seconds against the plaintext forward
                              pass of the same model on the same accelerator. Answers
                              "how many orders of magnitude", with the MFU assumption
                              stated instead of hidden.
  B  scaling               -- the exponent. Three candidate cost models (parameters,
                              activations, layer count) tested against zkLLM's own
                              7B/13B pair. n=2, and the printout says so.
  C  where the time goes   -- zkGPT's published component breakdown, normalised.
                              Decides "linear algebra or nonlinearities".
  D  trajectory            -- proved-parameters per prover-second across three
                              published systems, 2024-2025. Extrapolation is labelled
                              as such and is the weakest thing in the file.
  E  sampled proving       -- amortised overhead when only a fraction of requests is
                              proved, at the deterrence rates derived in the sibling
                              essay `trustless-distributed-ai.md`.
  F  composition with FHE  -- naive multiplicative cost of proving a homomorphic
                              evaluation, against the FHE-native alternative.

Pure stdlib. Run via ./run.sh (hard cgroup memory cap, no swap, CPU quota) or
  ../capped.sh -m 2G -t 900 -- python3 -u zkml_cost.py
"""

from __future__ import annotations

import math


def rule(title: str) -> None:
    print()
    print("=" * 78)
    print(title)
    print("=" * 78)


# ----------------------------------------------------------------------------
# Published anchors. Each is a citation, not a measurement of this file.
# ----------------------------------------------------------------------------

# zkLLM (Sun, Li, Bi, Ai, Zhang, arXiv 2404.16109), Table 1.
# NVIDIA A100-SXM4 40GB, sequence length 2048 (C4), one full forward pass.
ZKLLM = [
    # name,        params,  layers, d_model, prover_s, verify_s, proof_kB
    ("LLaMa-2-7B",  7.0e9,  32, 4096, 620.0, None, None),
    ("LLaMa-2-13B", 13.0e9, 40, 5120, 803.0, 3.95, 188),
    ("OPT-13B",     13.0e9, 40, 5120, 713.0, 3.71, 160),
]
ZKLLM_SEQ = 2048
A100_PEAK_TFLOPS = 312.0  # NVIDIA A100 tensor-core peak, quoted by zkGPT itself.

# zkGPT (Qu, Sun, Liu, Lu, Guo, Chen, Zhang; USENIX Security 2025; eprint 2025/1184).
# Intel Xeon 6126 2.60GHz 16-core, 32 threads, 200GB RAM. GPT-2 (124M), input 32x768,
# so sequence length 32. Table 3 (totals) and Table 5 (breakdown, "all Opt" column).
ZKGPT_TOTAL_S = 21.8
ZKGPT_VERIFY_S = 0.35
ZKGPT_PROOF_KB = 101
ZKGPT_SEQ = 32
ZKGPT_PARAMS = 124e6
XEON_6126_TFLOPS = 10.2  # the zkGPT paper's own figure for its 16-core CPU.
ZKGPT_BREAKDOWN = [
    ("commit advice (weights + intermediates)", 0.8),
    ("GKR layer sumcheck (linear algebra)", 5.7),
    ("combine sumcheck (linear algebra)", 3.2),
    ("Lasso lookups (nonlinearities: softmax, GeLU, norm, rounding)", 12.1),
]

# zkGPT Table 3, same GPT-2 task, competing systems.
GPT2_SYSTEMS = [
    ("Hao et al., USENIX Sec'24 (VOLE)", 6096.0, None, 6.85e6),
    ("ZKML, EuroSys'24 (Halo2/Plonkish, 32 thread)", 4026.0, 12.1, 7.8),
    ("Lu et al. (VOLE, 32 thread)", 112.3, 31.4, 2.24e6),
    ("zkLLM (A100, 6912 CUDA cores)", 15.8, 0.54, 126.0),
    ("zkGPT (32-thread CPU, all opt)", 21.8, 0.35, 101.0),
]


def flops_forward(params: float, seq: int) -> float:
    """Standard 2*N*T dense forward-pass FLOP count. Ignores attention's quadratic
    term, which at these (seq, d) is a few percent. DERIVED, and deliberately the
    OPTIMISTIC side for the plaintext baseline, so the overhead below is if anything
    an under-estimate of how well the prover does."""
    return 2.0 * params * seq


# ----------------------------------------------------------------------------
rule("A. Proving overhead against the plaintext forward pass (DERIVED)")
print("""
Plaintext baseline = 2*N*T FLOPs / (peak TFLOPS * MFU). MFU is the assumption; both
columns are shown because the honest answer is a range, not a point. Same accelerator
for prover and baseline in every row, which is the comparison that means anything.
""")
print(f"{'system / model':<34}{'prover s':>10}{'plain s':>10}"
      f"{'x @MFU 1.0':>12}{'x @MFU 0.4':>12}")
for name, params, layers, d, sec, _v, _p in ZKLLM:
    fl = flops_forward(params, ZKLLM_SEQ)
    plain_peak = fl / (A100_PEAK_TFLOPS * 1e12)
    plain_mfu = fl / (A100_PEAK_TFLOPS * 1e12 * 0.4)
    print(f"{'zkLLM ' + name:<34}{sec:>10.0f}{plain_peak:>10.3f}"
          f"{sec / plain_peak:>12,.0f}{sec / plain_mfu:>12,.0f}")
fl = flops_forward(ZKGPT_PARAMS, ZKGPT_SEQ)
plain_peak = fl / (XEON_6126_TFLOPS * 1e12)
plain_mfu = fl / (XEON_6126_TFLOPS * 1e12 * 0.1)  # 10% MFU is generous for a CPU
print(f"{'zkGPT GPT-2 (CPU)':<34}{ZKGPT_TOTAL_S:>10.1f}{plain_peak:>10.3f}"
      f"{ZKGPT_TOTAL_S / plain_peak:>12,.0f}{ZKGPT_TOTAL_S / plain_mfu:>12,.0f}")
print("""
  (the GPT-2 row's second column uses MFU 0.1, not 0.4: a 16-core CPU does not reach
  40% of its vector peak on a 32-token forward pass, and pretending it does would
  flatter the prover.)
""")
lo = min(sec / (flops_forward(p, ZKLLM_SEQ) / (A100_PEAK_TFLOPS * 1e12 * 0.4))
         for _n, p, _l, _d, sec, _v, _pr in ZKLLM)
hi = max(sec / (flops_forward(p, ZKLLM_SEQ) / (A100_PEAK_TFLOPS * 1e12))
         for _n, p, _l, _d, sec, _v, _pr in ZKLLM)
print(f"  LLM-scale overhead spans {lo:,.0f}x to {hi:,.0f}x, i.e. "
      f"10^{math.log10(lo):.2f} to 10^{math.log10(hi):.2f}.")

# ----------------------------------------------------------------------------
rule("B. How does it scale? (DERIVED from n=2 -- read the caveat)")
print("""
zkLLM ran two LLaMa-2 models on identical hardware and identical sequence length, so
the ratio isolates model size. Three candidate cost models, each predicting the
7B -> 13B time ratio. WITH TWO POINTS NOTHING IS FITTED; this only rules models OUT.
""")
a = ZKLLM[0]
b = ZKLLM[1]
observed = b[4] / a[4]
cands = [
    ("prover cost ~ parameters", b[1] / a[1]),
    ("prover cost ~ activations (L * T * d)", (b[2] * b[3]) / (a[2] * a[3])),
    ("prover cost ~ layer count", b[2] / a[2]),
]
print(f"{'candidate cost model':<40}{'predicted':>12}{'observed':>12}{'error':>10}")
for label, pred in cands:
    print(f"{label:<40}{pred:>12.3f}{observed:>12.3f}"
          f"{100 * (pred - observed) / observed:>9.1f}%")
print(f"""
  Observed ratio {observed:.3f} for a {b[1] / a[1]:.3f}x parameter increase. The
  measured scaling is SUBLINEAR in parameters. Whatever the true law is, there is no
  superlinear term visible, and a superlinear term is what a structural wall looks
  like. The layer-count model is closest, which is consistent with C below: the
  dominant cost is per-layer nonlinearity lookups whose count grows with L*T and only
  weakly with d.

  Caveat, load-bearing: n=2, one family, one sequence length, one implementation.
  This rules out "cost ~ parameters"; it does not establish "cost ~ layers".
""")

# ----------------------------------------------------------------------------
rule("C. Where the prover's time actually goes (zkGPT Table 5, normalised)")
tot = sum(s for _l, s in ZKGPT_BREAKDOWN)
print(f"\n  reported total {tot:.1f}s (paper states {ZKGPT_TOTAL_S}s)\n")
print(f"{'component':<62}{'s':>7}{'share':>9}")
for label, s in ZKGPT_BREAKDOWN:
    print(f"{label:<62}{s:>7.1f}{100 * s / tot:>8.1f}%")
lin = ZKGPT_BREAKDOWN[1][1] + ZKGPT_BREAKDOWN[2][1]
non = ZKGPT_BREAKDOWN[3][1]
com = ZKGPT_BREAKDOWN[0][1]
print(f"""
  linear algebra (both sumchecks) : {100 * lin / tot:>5.1f}%
  nonlinearities (Lasso lookups)  : {100 * non / tot:>5.1f}%
  polynomial commitment           : {100 * com / tot:>5.1f}%
  nonlinearity : linear-algebra   = {non / lin:.2f} : 1
""")

# ----------------------------------------------------------------------------
rule("D. The trajectory on one fixed task: prove GPT-2 (zkGPT Table 3)")
print()
print(f"{'system':<46}{'prover s':>10}{'verify s':>10}{'proof kB':>14}")
for name, p, v, k in GPT2_SYSTEMS:
    vs = f"{v:.2f}" if v is not None else "n/a"
    print(f"{name:<46}{p:>10.1f}{vs:>10}{k:>14,.1f}")
best_plonkish = GPT2_SYSTEMS[1][1]
best_gkr = ZKGPT_TOTAL_S
print(f"""
  Plonkish (ZKML, EuroSys'24) -> GKR+Lasso (zkGPT, USENIX'25): {best_plonkish / best_gkr:,.0f}x
  on the SAME task and comparable CPU. That factor is a change of proof system, not
  of hardware, and it is the single largest term in the whole gap.

  Verification moves the other way and barely moves at all: {ZKGPT_VERIFY_S}s and
  {ZKGPT_PROOF_KB} kB for GPT-2, {ZKLLM[1][5]}s and {ZKLLM[1][6]} kB for a 13B model.
  A 105x larger model costs the verifier ~11x, and the proof grows under 2x.
""")

# ----------------------------------------------------------------------------
rule("E. Sampled proving: the overhead if you prove one request in N (DERIVED)")
print("""
Deterrence rates are the sibling essay's (trustless-distributed-ai.md section 1):
cheating is unprofitable when the catch probability q exceeds s/D, for a per-request
saving s against a forfeitable bond D. Amortised overhead = 1 + q * (zk overhead).
Overhead taken as 3000x, the midpoint of A.
""")
ZK_OVERHEAD = 3000.0
print(f"{'claimed -> substituted':<24}{'s':>8}{'bond D':>9}{'rate q':>10}"
      f"{'amortised cost':>16}")
for claimed, sub, s in (("70B", "8B", 0.886), ("70B", "1B", 0.986),
                        ("8B", "1B", 0.875)):
    for D in (10.0, 100.0, 1000.0, 10000.0):
        q = s / D
        if q > 1.0:
            continue
        print(f"{claimed + ' -> ' + sub:<24}{s:>8.3f}{D:>9,.0f}{q:>10.4%}"
              f"{1 + q * ZK_OVERHEAD:>15.2f}x")
print(f"""
  Break-even: proving is affordable as an overhead of at most F when the audit rate
  is below F/{ZK_OVERHEAD:.0f}. For a 2x total bill (F = 1), that is a rate of
  {1 / ZK_OVERHEAD:.3%} -- i.e. one request in {ZK_OVERHEAD:,.0f}.
""")
for D in (100.0, 1000.0, 10000.0):
    q = 0.886 / D
    print(f"    bond {D:>7,.0f}x  ->  q = {q:.4%}  ->  total bill "
          f"{1 + q * ZK_OVERHEAD:.2f}x of honest serving")

# ----------------------------------------------------------------------------
rule("F. Composing zkML with FHE: naive versus native (DERIVED, order of magnitude)")
print("""
Two ways to get a proof that an ENCRYPTED inference was done right.

  naive : express the homomorphic evaluation itself as the arithmetic circuit and
          prove that. The circuit is now the FHE circuit, so the two overheads
          multiply.
  native: prove the homomorphic computation in the FHE scheme's own algebra. Fherret
          (CiC 2025) reports a prover overhead of ~110-170 homomorphic evaluations of
          random functions, with verifier overhead ~58-93 -- an additive factor over
          FHE, not a multiplicative one against plaintext.
""")
FHE_OVERHEAD = 10 ** 3.5  # fhe-llm.md's cited 10^3-10^4 latency gap, midpoint
for label, factor in (("FHE alone", FHE_OVERHEAD),
                      ("zkML alone", ZK_OVERHEAD),
                      ("naive zk-over-FHE", FHE_OVERHEAD * ZK_OVERHEAD),
                      ("FHE + native proof (Fherret, x140)", FHE_OVERHEAD * 140)):
    print(f"  {label:<38}{factor:>14,.0f}x  = 10^{math.log10(factor):.2f}")
print("""
  The naive composition is the one to avoid: it is not merely expensive, it is the
  product of two separately-hard problems. The native route keeps the exponent near
  the FHE term alone plus two orders, because the proof lives in the same algebra as
  the computation instead of simulating it.
""")

# ----------------------------------------------------------------------------
rule("G. Amdahl on ZK hardware acceleration (DERIVED, exact)")
print("""
ZK accelerators (Cysic's C1, SZKP, ZK-Flex, Ingonyama) target MSM and NTT, because
those dominate Plonkish/pairing-based provers. In a GKR + Lasso prover they do not: the
polynomial commitment is the only MSM-heavy stage. Amdahl's law on zkGPT's own
breakdown, with the commitment made infinitely fast:
""")
share = com / tot
print(f"  commitment share of prover time      : {share:.3%}")
print(f"  best possible speedup, MSM -> free   : {1 / (1 - share):.3f}x")
for label, s in ZKGPT_BREAKDOWN:
    sh = s / tot
    print(f"  if only '{label[:34]:<34}' were free: {1 / (1 - sh):.2f}x")
print("""
  So the hardware-acceleration story and the fastest-known software story point at
  different components. An accelerator built for MSM buys a GKR prover about 4%. The
  stage worth accelerating is the lookup argument, and that is a different kernel.
""")

print()
print("done. every input is a published measurement, cited in the essay; every")
print("output is arithmetic on those inputs and is labelled DERIVED.")
