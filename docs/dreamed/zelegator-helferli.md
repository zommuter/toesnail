---
title: The router, the microcontroller, and the bits between them
permalink: /dreamed/zelegator-helferli
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory and nothing may be
> promoted anywhere without the owner authoring the move himself.
>
> **This essay is about OTHER REPOSITORIES.** Its subjects are `~/src/zelegator` and
> `~/src/helferli`, both of which were read but never written. It is filed in toesnail only
> because the owner asked that this batch of dreaming land here. Every finding about either repo
> sits under "Surfaced for the owner", located by file and line, and **nothing was filed into
> either repo's `TODO.md`, `ROADMAP.md`, or `REVIEW_ME.md`.** The `\veq` badges below claim
> something about [`docs/dreamed/lean/Router.lean`](lean/Router.lean) **only**.

**Seed (owner, 2026-09-01):** *"dream a lot deeper on ... helferli and zelegator ..., check
current project states."*

# 0. The verdict, stated first

**Zelegator's classification bet is correct and its ceiling is already reached, in the exact
information-theoretic sense: the ten-tool router carries at most 3.3219 bits per query, and on
the repo's own 50-case eval set the current voter carries all 3.3219 of them.** The eval set is
therefore spent as a measuring instrument: it cannot rank two 100% routers and cannot score a
distilled student, because both saturate it.

**The microcontroller endgame closes on memory and compute, and does not close on data.** A
140K-parameter int8 student needs 140 KB of weights and 3.4 million MACs per forward pass, which
fits in the ESP32-S3's *internal* 512 KB SRAM without touching PSRAM and runs in 3 to 14 ms.
Hardware does not bind. What binds is an empty distillation corpus: `decision_log` defaults off
(`zelegator/src/zelegator/voter.py`) and `id:c106`, the item that would turn it on, is auto-gated
pending an owner decision.

**"helferli is zelegator-compatible" is, today, a sentence and not an artifact.** helferli's
relay never calls zelegator: `tools/relay/relay.py:72-73` names an ASR URL and an LLM URL and
nothing else, and the two mentions of "zelegator" under `tools/relay/` are both inside a
benchmark comment. The wire schema exists in exactly one place,
`zelegator/src/zelegator/serve.py:55`, and helferli neither imports nor mirrors it. That is the
drift shape toesnail's `CLAUDE.md` warns about, one step earlier than usual: not a derived doc
drifting from a ratified source, but a claimed contract with no source at all.

# 1. Where both projects actually stand, 2026-09-01

## 1.1 zelegator

Version **0.4.0**, tagged 2026-08-20. Last functional commit `ba6ad2a` (2026-08-20, German and
Swiss-German on/off particles, `id:5dc1`); the 2026-09-01 commit `0b781c1` is an inbox ingest,
not code. Phases 1 to 3 are done and measured. Ten tools ship in `data/tools.yaml`, exactly one
of them (`web_search`, line 30) carrying `egress: true`.

Shipped: the dual-path voter at 100% strict and 100% ambiguous on the 50-case set; the Darmok
pre-tokenizer; slot assembly with a device-and-state channel for `home_automation` (`id:366d`,
2026-07-28); `zelegator serve` over stdlib `http.server` (`id:0cd5`, 2026-07-26, warm loopback
median 39.1 ms / p95 54.2 ms); three language packs; the privacy scan plus vault.

In flight or blocked, with what blocks each:

| id | What | Blocked on |
|---|---|---|
| `c3d3` | Privacy-PROXY layer, "zelegator's core feature" | ratified 2026-07-18; build ladder `860c` → `039f` unstarted |
| `c106` | Turn on the Phase-5 decision-log corpus | **auto-gated** (`id:3801`): owner must pick corpus size `N` and the distillation trigger |
| `2cc5` | First public GitHub push | human lane: full-history identity-leak scan |
| `5431` | Real-device binding for `home_automation` | owner picks a backend; multi-word device phrases stay split |
| `285e` | Move `serve` from zomni loopback to fievel | owner decision, plus LAN mitigations |
| `06f4` | "Mechanical + Lean4-proven AI, LLM only at the HMI edge" | home undecided: zelegator, chidiAI, leAIrn2learn, or a new repo |
| `a54e` | Darmok placeholder path as a privacy boundary plus a leak test | ingested 2026-09-01 as `routed:1784` from helferli |

Phase 4 and Phase 5, the two phases this essay is about, are both unstarted.

## 1.2 helferli

No version manifest at the repo root; the relay is `0.1.0`. Active today: commits through
`6047802` (2026-09-01 10:19 relay checkpoint). The 2026-09-01 positioning meeting ratified D1
to D9 and promoted six `[HARD]` items. Two hard external dates now drive everything, both under
`id:ec8a`: a **demo gate on 2026-09-10** and a **WEGA pitch on 2026-09-25**.

Ratified and directly relevant here: **D4**, helferli owns ASR plus *zelegator's slot-filled
routing* and integrates an execution backend rather than building an actuation layer; **D7**,
the demo target is a local store plus on-screen render (`id:29e3`) with a bexio write attempted
on top and a hard abort 2026-09-07 (`id:973c`); **D8**, demo on the VoCat with real
hold-to-talk (`id:4128`), removing VAD from the critical path; **D3b**, pseudonymised cloud
escalation stays a real design item routed to zelegator, because Darmok already implements the
mechanism.

Blocked: essentially the whole pre-2026-08 backlog is `[INPUT - access]` and needs the physical
VoCat (`id:0344`, `de3f`, `6687`, `e19a`, `db18`, `b411`, `ee21`, `08d4`, `83db`, `d0c8`), which
executors do not have. Fable's structural summary in the meeting note is the honest reading:
four of six original decisions were deferrals with unbudgeted prerequisites, against two dates
nine and twenty-four days out.

**The load-bearing observation for this essay:** D4 commits helferli to zelegator's routing,
and the demo that must exist by 2026-09-10 is a voice command producing a visible entry. The
relay as committed today has no routing stage at all. It sends ASR text to a chat-completions
endpoint, which is the "understand → generate English → parse the English back" architecture
that `zelegator/ARCHITECTURE.md` explicitly rejects.

# 2. The thesis, sharpened and then tested

The bet: **intent routing is classification, so it does not need a generative model.** As an
information claim it is nearly trivial and entirely correct. A router emits one of `N` labels; a
generative model's output space is `V^L`. Using the second to compute the first spends
`L log2 V` bits of machinery to deliver `log2 N` bits of answer, then needs a parser to throw
the surplus away.

What it buys, measured: 11.5 ms against roughly 700 to 1200 ms for the local 0.8B fallback
(`PROJECT_KNOWLEDGE.md`), two orders of magnitude in latency and the same in energy, plus privacy
structurally rather than by policy, since an argmax over ten cosine similarities has no channel
through which an utterance can leave and a generative fallback needs an explicit gate
(`privacy.py`, `dispatcher.py`).

**What it forecloses is sharper than "hard queries".** A router with `N` outputs is a function
into an `N`-element type, so three things are structurally out of reach, and none of the three
is about difficulty. **Compositional intents beyond the splitter's reach:** `splitter.py`
handles conjunctions, not nesting ("remind me to do what I said yesterday"), and the output
alphabet has no representation for a composite. **Novel intents:** a tool absent from
`tools.yaml` cannot be emitted, by pigeonhole, which is a theorem and not a quality problem
\eqref{pigeon}. **Multi-turn intents:** state lives in helferli's relay (`ARCHITECTURE.md` D5,
six turns in memory); the router is memoryless by construction.

**Where the boundary sits, concretely, in the repo's own taxonomy.** Nine of the ten tools are
*actuators*: `calculator`, `calendar`, `web_search`, `notes`, `home_automation`, `music`,
`timer`, `tasks`, `system`. Each has a bounded parameter set the slot assembler can fill. The
tenth, `chat`, is not a tool at all. It is the escape hatch, and `dispatcher.py` sends it to an
LLM. **So the boundary is already drawn in `tools.yaml`, and it is drawn at `chat`.** The router
is complete for the nine, and its accuracy question reduces entirely to "does this utterance
belong to the nine or to the tenth". That is a binary question worth 1 bit, embedded in a
3.32-bit decision, and it is exactly where every measured failure lives: the Phase-1 baseline
sent 32 of its 33 errors to `chat`.

# 3. The information-theoretic floor

## 3.1 Capacity

Zelegator ships `N = 10` tools. A router emitting one of ten labels conveys at most

$$ H(\text{tool}) \ \le\ \log_2 N \ =\ \log_2 10 \ =\ 3.3219\ \text{bits} \veq{capacity}\lean $$

per query, with equality if and only if the output distribution is uniform. The inequality is
`Toesnail.InfoWing.entropy_le_log_card` in the sibling [`lean/InfoWing.lean`](lean/InfoWing.lean)
and is **cited, not reproved**; `Router.lean` adds the attainment half
(`uniform_entropy_eq_log_card`), the `N = 2^k` corollary (`bits_of_card_pow_two`), and the exact
bracket `3 < \log_2 10 < 4` from `8 < 10 < 16` (`logb_ten_between`), which needs no numerics.
Read the other way: ten tools is not a round number of bits, and that is a fact about
`tools.yaml`, not about any model.

## 3.2 The empirical channel matrix, from checked-in data

`baseline.txt` (Phase 1, description-only embedding, 34% strict) lists all 33 failures with
their expected and actual tool. `tests/test_router.py` gives the 50 test cases, **five per tool,
so the input prior is exactly uniform and `H(X) = log2 10` exactly.** Together they are a
complete 10x10 empirical channel matrix. Computing on it:

```computation
# tool: zelegator baseline.txt x tests/test_router.py TEST_CASES
# reads: 33 (expected, got) pairs; 50 cases, 5 per tool
H(X)      = 3.3219 bits      # uniform over 10 tools, by construction
H(Y)      = 1.3436 bits      # the router's OUTPUT entropy
I(X;Y)    = 0.9401 bits      # 28.3% of the 3.3219-bit capacity
P(Y=chat) = 0.74
H(X|Y)    = 2.3818 bits
# Fano check at P_e = 33/50 = 0.66, |X| = 10:
#   H(P_e) + P_e*log2(9) = 0.9250 + 2.0920 = 3.0170 >= 2.3818  [satisfied, slack 0.635]
```

**The diagnostic is `H(Y) = 1.34`, not `I = 0.94`.** The Phase-1 router could not have conveyed
more than 1.34 bits whatever the input was, because it hardly ever said anything except `chat`.
Its capacity was not limited by the task, by the encoder, or by the embedding dimension; it was
limited by having collapsed its own output alphabet. `ARCHITECTURE.md` diagnoses this as "the
chat description was semantically close to everything" and fixes it with exemplars. That
diagnosis is right, and the output-entropy number is what makes it a measurement.

**And now the uncomfortable half.** The current voter is 100% on the same 50 cases, so its
`I(X;Y) = H(X) = 3.3219` bits, saturating capacity exactly. `ARCHITECTURE.md` states "the eval
set is the contract". As an information instrument that contract is now spent: a saturated
channel matrix has no gradient. It cannot rank two 100% routers, cannot detect a regression
smaller than one case in fifty (2 percentage points), and cannot give a distilled student a
score that means anything. Phase 5's success criterion does not currently exist.

## 3.3 Fano, honestly

Fano's inequality, $H(X \mid Y) \le H(P_e) + P_e \log(|X| - 1)$, is the right formal instrument
and it is **not proved in the Lean file**. What is proved is the counting bound the essay
actually leans on: at most `card Tool` intents can be routed correctly, hence

$$ P_e \ \ge\ 1 - \frac{N}{M} \veq{errfloor}\lean $$

for `M` equiprobable intents and `N` tools (`correct_card_le_tools`, `error_rate_ge`). This is
strictly weaker than Fano: it is cardinality-only and says nothing once `N \ge M`, which is
precisely the regime zelegator is in. The Fano line in the computation block above is
arithmetic on the measured matrix, not a theorem, and is labelled as such.

Fano's practical bite here is the reverse direction. At `P_e = 0` it forces `H(X | Y) = 0`:
perfect routing requires the utterance to determine the intent with no residual entropy. The
voter achieves `P_e = 0` on 50 cases, so it asserts `H(intent | utterance) = 0` **on those 50
cases only**, and the set contains no utterance whose true intent depends on context, so the
assertion is never tested. `AMBIGUOUS_CASES` does not test it either: accepting a *list* of
tools measures whether the router lands in an allowed set, not whether it resolves an ambiguity.

## 3.4 How few parameters can carry 3.32 bits

Capacity says nothing about capacity-to-realise: the model must partition a high-dimensional
input space into ten regions, not run a lookup. But the parameter arithmetic is checkable, and
it lands on zelegator's own target:

```computation
# transformer encoder parameter count: L*(4d^2 + 2*ff*d^2) + vocab*d + ctx*d + d*ntool
d=384 L=6 vocab=30522 ctx=512  ->  22,537,728   # reproduces MiniLM-L6-v2's 22.7M
d=128 L=2 vocab=600   ctx=32   ->     475,392   # docs/encoder-deep-dive.md's "~300K", optimistic
d=64  L=2 vocab=600   ctx=32   ->     139,392   # ARCHITECTURE.md's "~140K-param encoder"
```

**The 140K target is not a round guess: it is a 64-dimensional, 2-layer encoder over a
600-token Darmok vocabulary with a 32-token context.** The reconstruction reproduces MiniLM
exactly at its own hyperparameters, which is the check that the arithmetic is right, and it
locates the reduction. The embedding matrix is 51.6% of MiniLM (30522 x 384 = 11.72M of 22.54M);
taking the vocabulary 30522 → 600 and the width 384 → 64 turns 11.72M into 38.4K, a factor of
305. **Darmok's payoff is a vocabulary-table payoff, not a representation payoff** -- a claim
`docs/darmok.md` makes philosophically and this arithmetic makes numerically.

Ten classes in 64 dimensions is nowhere near tight: a 10-way linear separation needs 9
hyperplanes in general position. If the distilled student fails it will fail on the *encoder*
(2 layers over a 32-token context), never on the classification head.

# 4. The microcontroller endgame, quantified

ESP32-S3 on VoCat (`zelegator/firmware/vocat/README.md`): dual Xtensa LX7 at 240 MHz, 512 KB
internal SRAM, 16 MB PSRAM (octal), 16 to 32 MB flash, 128-bit SIMD for int8 via esp-nn. No FPU
worth using for matmul.

**Memory.** 140K parameters at int8 is 140 KB of weights; a generous tensor arena for a
32-token, 64-wide, 2-layer encoder is 30 to 60 KB. Total under 256 KB, so **it fits in internal
SRAM and never needs PSRAM.** That beats `ARCHITECTURE.md`'s own estimate ("~1-2MB int8 models
loaded into PSRAM"), and it matters: internal SRAM is roughly an order of magnitude faster than
octal PSRAM, and this workload is memory-bandwidth bound, not arithmetic bound.

```computation
# MACs per forward, d=64, L=2, seq=32, ff=4x:
#   per layer: 4*seq*d^2 (QKVO) + 2*seq^2*d (scores) + 2*ff*seq*d^2 (FFN)
MACs = 3,407,872
  @ 0.25 GMAC/s (conservative esp-nn int8)  ->  13.6 ms
  @ 1.00 GMAC/s (optimistic esp-nn int8)    ->   3.4 ms
# target in firmware/vocat/README.md: <200 ms for interactive feel
```

Compute clears the target by 15x to 60x. **Neither memory nor compute binds.**

**Compression factor required.** MiniLM at fp32 is 90.8 MB against a 140 KB target: 649x in
bytes, of which quantisation supplies exactly 4x. The remaining 162x is a parameter-count
reduction, so it is **not** reachable by quantisation or pruning, both of which start from the
teacher's architecture. It needs techniques 4 and 5 of `docs/parameter-reduction.md` (design
small, shrink the vocabulary), and both of those need a corpus.

**So what binds is data, in two separate ways.** First, **the corpus is empty**: `decision_log`
defaults to `None` in `voter.py`, `id:c106` is auto-gated on an owner decision, and zero
decisions have been logged, so the Phase-5 clock has not started. Second, **the teacher cannot
teach the student the product's languages.** MiniLM is English-only (`ARCHITECTURE.md`, "Model
choice"); DE and gsw route through the *keyword* path. A keyword table emits hard labels with no
soft distribution, so `parameter-reduction.md` §3's "soft labels carry the teacher's uncertainty
structure" argument does not apply to two of the three served languages, and the student would
inherit English competence and Darmok placeholders and nothing else.

**Verdict: the endgame closes on silicon and does not close on data. The binding constraint is
one gated owner decision (`id:c106`) plus one that has not been recognised as a decision at all
(what teaches the student German).**

# 5. The contract seam, and how it can silently drift

Three artifacts claim the compatibility, and none of them is a schema:

| Where | What it says | Line |
|---|---|---|
| `helferli/CLAUDE.md` | "ESP-IDF firmware for a **zelegator-compatible** voice assistant" | 19 |
| `zelegator/firmware/vocat/README.md` | "Text query → zelegator router on fievel"; the directory is "a placeholder for the zelegator-side interface spec" | 5, 38 |
| `zelegator/ARCHITECTURE.md` | "Firmware lives in `~/src/helferli/` -- this repo only owns the interface spec (`firmware/vocat/`)" | 124 |

Against that, the code: `helferli/tools/relay/relay.py:72-73` defines an ASR URL and an LLM URL,
with no zelegator URL, no `/route` call and no import, while `helferli/CLAUDE.md:187` lists
"zelegator MCP integration" under **What's deferred**. The one machine-readable contract is
`zelegator/src/zelegator/serve.py:55`, `WIRE_FIELDS`, mirrored in `tests/test_serve.py` and
nowhere else.

**The located finding: `firmware/vocat/README.md` calls itself the interface spec and specifies
a topology, not an interface.** It lists which box talks to which box and names not one field of
the request or response, while the actual field set is frozen in a Python tuple in the other
repo, guarded by that repo's tests only. A helferli change and a zelegator change can each stay
green while the pair stops fitting, and nothing anywhere would fail. That is the shape
`~/src/lodelore` was minted to stop, and the shape toesnail's `CLAUDE.md` warns about under
"check a derived doc against its ratified source" -- except that here there is no ratified
source to check against, which is worse and cheaper to fix.

It is also newly urgent rather than theoretical. D4 (2026-09-01) commits helferli to zelegator's
routing, and `id:29e3` must demo a voice command producing a visible entry by 2026-09-10, nine
days after ratification, over a relay that has no routing stage.

# 6. Speculative, clearly labelled

**Everything in this section is speculation. None of it is measured, and each carries what
would decide it.**

## 6.1 A router that reports calibrated uncertainty and escalates on a threshold

Section 2 drew the router-versus-model boundary at `chat`, statically, in `tools.yaml`. Make it
a runtime decision instead: the voter emits a confidence, only queries below a threshold `tau`
reach the LLM, and `chat` stops being a tool and becomes a *decision*. Zelegator can measure the
cost curve today, because the voter already computes agreement (94%, 11.5 ms router, roughly
1000 ms local fallback):

```computation
# escalate-on-disagreement, using PROJECT_KNOWLEDGE.md numbers
E[latency] = 0.94*11.5ms + 0.06*1000ms = 70.8 ms
# versus 1000 ms always-LLM (14x faster) and 11.5 ms never-escalate (6x slower)
```

**What would decide it:** sweep `tau` over the decision log, plot accuracy against escalation
rate. The confidence is calibrated for this purpose if and only if it ranks errors above correct
routes, measurable as an AUC on an eval set extended past 50 cases. A knee in the curve makes
the section-2 boundary a dial; no knee means confidence is uninformative and the static `chat`
boundary was right. This is also the cleanest first slice for `id:06f4` ("Lean4-proven AI, LLM
only at the HMI edge"): a calibration bound is a provable object, a routing heuristic is not.

## 6.2 Darmok as a learned compression, measured in bits

Darmok is justified philosophically (structural versus referential) and penalised empirically
(86% with MiniLM against 96% without). Both readings miss the measurement that would settle it.
Darmok is a compressor into a shorter alphabet, so the question is **how many bits it discards
and whether any were routing bits.** Per token the alphabet shrinks from `log2(30522) = 14.90`
to about `log2(600) = 9.23` bits, throwing away roughly 5.67 bits per token, against a whole
routing decision worth 3.32 bits. The factorization is *lossless for routing* exactly when
`I(skeleton; tool) = I(utterance; tool)`.

**What would decide it:** estimate both mutual informations on a decision-log corpus. Equality
means Darmok is a free 5.67-bits-per-token compression and the 86% is purely the known
MiniLM-never-saw-`[THING]` mismatch, which a placeholder-native student removes by construction.
A measurably lower `I(skeleton; tool)` means Darmok discards routing signal and the scoring rule
needs work before Phase 5 rests on it. One experiment converts the repo's oldest
accepted-mismatch note into a number, and **it is gated on the same `id:c106` decision.**

## 6.3 The Landauer floor for one routing decision

The sibling essay [`information-wing.md`](information-wing.md) argues that the wing coheres
around `\log W`, and that Landauer is the single place where `\log W` is forced to carry joules.
An edge device with a battery is that place taken literally. A ten-way routing decision destroys
`\log_2 10` bits of input distinction; at `T = 300` K:

$$ E_{\min} \ =\ \log_2 N \cdot k_B T \ln 2 \ =\ k_B T \ln N \ =\ 9.537 \times 10^{-21}\ \text{J} \veq{landauerN}\lean $$

That the two forms agree is `landauer_decision`; the per-bit bound is `InfoWing.landauer_heat`,
cited not re-derived, with the second law a named hypothesis. One routing decision therefore has
a thermodynamic floor of **9.54 zeptojoules**. Against the ESP32-S3 actually doing it:

```computation
# assumptions STATED, datasheet-typical bands, measured in neither repo:
#   CPU active 240 MHz, radio off, ~40 mA at 3.3 V -> 132 mW; inference 3.4-13.6 ms (section 4)
#   WiFi TX ~250 mA at 3.3 V -> 825 mW
E_inference = 0.45 mJ .. 1.80 mJ            ratio to E_Landauer = 4.7e16 .. 1.9e17
E_tx(0.5 s) = 0.41 J                        ratio to E_inference(1.80 mJ) =  229x
E_tx(3.0 s) = 2.47 J                        ratio to E_inference(1.80 mJ) = 1375x
```

**A routing decision on an ESP32-S3 costs between 5x10^16 and 2x10^17 times the Landauer floor.**
Its value is not that it is large, since every CMOS number is large, but that it says where the
headroom is not: seventeen orders of magnitude means physics is nowhere near a design constraint
here, so any energy argument for the edge has to be about the *radio*, not the arithmetic. The
transmit rows above say how much: half a second of WiFi TX costs 229 times the whole inference.

**The correct energy case for the microcontroller endgame is that on-device routing avoids a
radio round trip, worth two to three orders of magnitude.** The inference is thermodynamically
free at this scale. That reframes Phase 5: the payoff is latency, privacy and *airtime*, and it
should be argued that way rather than on compute cost.

**What would decide it:** a current-clamp measurement on a VoCat over one wake-to-response cycle,
separating CPU-active from TX energy. The milliamp figures above are datasheet bands and must not
be quoted by anyone as measurements.

# 7. Surfaced for the owner

Located, never edited. Every one is a recommendation; the ruling is the owner's.

1. **`zelegator/tests/test_router.py` (the 50-case set) is saturated as an information
   instrument.** At 100% on a uniform 10-class set `I(X;Y) = log2 10` exactly, so it has no
   discriminating power left, and `ARCHITECTURE.md` calls it "the contract". *Recommendation:*
   decide what scores a distilled student before Phase 5, because today nothing does.
2. **`zelegator/ARCHITECTURE.md:124-128` under-states the ESP32 headroom** ("~1-2MB int8 models
   loaded into PSRAM"): a 140K int8 encoder with its arena is under 256 KB and fits in internal
   SRAM, materially faster for a bandwidth-bound workload. *The number is the owner's to correct.*
3. **The Phase-5 teacher is English-only while the product is trilingual.** DE and gsw route
   through the keyword path, which emits hard labels and cannot supply soft targets; neither
   `ARCHITECTURE.md` nor `parameter-reduction.md` addresses it. *Recommendation:* fold it into the
   `id:c106` decision rather than discover it after the corpus is collected.
4. **`zelegator/firmware/vocat/README.md` calls itself an interface spec and specifies a
   topology.** The only machine-readable contract is `serve.py:55` `WIRE_FIELDS`.
   *Recommendation:* one versioned shared artifact with a conformance test on both sides, more
   urgent after D4 than before it.
5. **`helferli/tools/relay/relay.py:72-73` has no routing stage**, so the relay implements the
   architecture `zelegator/ARCHITECTURE.md` names as its rejected alternative, while D4 commits
   helferli to zelegator routing and `id:29e3` is due 2026-09-10. *Recommendation:* record
   whether the demo path goes through `zelegator serve` or stays LLM-only; the two answers imply
   different work in the nine days available.
6. **`id:c106` gates more than it looks like.** It reads as "enable a log" and is the single
   blocker on Phase 5, on 6.2, and on 6.1. *Recommendation:* say so at the `/meeting`.

# 8. Follow-up leads

1. **Replace the saturated eval set with a graded one** -- add utterances whose true intent is
   genuinely context-dependent, so `H(intent | utterance) > 0` and the metric has a gradient
   again. *Decidable by:* whether a second annotator agrees on the label. **zelegator.**
2. **Run the calibration sweep of 6.1** and plot accuracy against escalation rate. *Decidable by:*
   whether the curve has a knee, and by the confidence-versus-error AUC. **zelegator**, gated on
   `id:c106`.
3. **Measure `I(skeleton; tool)` against `I(utterance; tool)`** to settle the Darmok bet in bits
   rather than in accuracy points. *Decidable by:* equality within the corpus's sampling error.
   **zelegator**, gated on `id:c106`.
4. **Instrument one wake-to-response cycle with a current clamp**, separating CPU-active from TX
   energy. *Decidable by:* a single measurement; the datasheet bands in 6.3 are not one.
   **helferli.**
5. **Mint one versioned wire-contract artifact with a conformance test on both sides.**
   *Decidable by:* a test in each repo that fails when the other's schema changes. **Shared
   decision** -- it needs one owner in one repo, and choosing which is exactly the call an agent
   must not make.

# 9. Lean attestation

File: [`docs/dreamed/lean/Router.lean`](lean/Router.lean), namespace `Toesnail.Router`.

Checked with, from `verify/`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Router.lean
```

**Exit status 0. Zero `sorry`. Zero errors.** Two `unused variable` warnings remain
deliberately, on `hN` in `landauer_decision` and `hT` in `landauer_decision_bound`: `Real.log` is
total and returns junk off-domain, so the arithmetic holds without them, and they are named
anyway to record the domain on which the equation is about heat rather than about a junk value.

| Handle | Theorem(s) | Claim |
|---|---|---|
| `capacity` | `uniform_entropy_eq_log_card`, `bits_of_card_pow_two`, `logb_ten_between` | equality case of `H ≤ log|s|`; `N = 2^k` gives exactly `k` bits; `3 < log2 10 < 4` |
| `pigeon` | `router_pigeonhole`, `router_mistakes_someone` | more intents than tools forces a collision, and forces at least one wrong answer |
| `errfloor` | `correct_card_le_tools`, `error_ge_of_card`, `error_rate_ge` | at most `N` intents can be correct, so `P_e ≥ 1 - N/M` |
| `landauerN` | `landauer_decision`, `landauer_decision_bound`, `landauer_ten_between` | `log2(N)·k_BT ln2 = k_BT ln N`; the `k`-bit chaining; the 10-tool bracket |

**Weakened, and stated plainly.** (i) **Fano's inequality is not proved.** It needs conditional
Shannon entropy over a joint distribution, which the file does not build; the counting bound
`P_e ≥ 1 - N/M` stands in for it and is strictly weaker, being cardinality-only and vacuous once
`N ≥ M`, which is zelegator's actual regime. The Fano line in §3.2 is arithmetic on the measured
matrix, not a theorem. (ii) The channel bound `H ≤ log2 N` is **cited** from
`InfoWing.entropy_le_log_card`, not reproved, as is (iii) the Landauer per-bit bound from
`InfoWing.landauer_heat` with the second law a named hypothesis; only the scaling to a whole
decision is added. (iv) **No theorem says anything about zelegator's code.** A router is a bare
function `Intent → Tool`; no accuracy, latency, parameter count or joule figure in this essay is
formalised, and none could be.
