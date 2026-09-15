#!/usr/bin/env python3
"""gtnsd2 follow-up probe: NLI (entailment) judging vs embeddings, plus a
conversation-segmentation sanity check.

Part A -- LLM as NLI judge. Each item is (premise, hypothesis, gold label).
The model must answer exactly one of entailment / neutral / contradiction
(GBNF grammar, temperature 0). For every item we record:
  * the constrained label, repeated REPEATS times (tests server determinism),
  * the label under a second prompt template that shows the hypothesis
    BEFORE the premise (same logical question, different surface order),
  * a soft score read from the first generated token's top logprobs, which
    llama-server reports from the unconstrained distribution.
Items cover TAGOGAT pairs, HANS-style lexical-overlap traps (McCoy et al.
2019 templates, re-worded), controls, and the four task/transcript cases
from 2026-09-15-gtnsd2-embeddings.py, turned into declaratives.

Part B -- segmentation. A synthetic 28-turn conversation: a contiguous
thread A, then threads A and B interleaved, then a shift to thread C.
BGE-M3 turn embeddings are tested for (1) TextTiling-style depth-score
boundaries, (2) agglomerative clustering into threads, (3) nearest-earlier-
turn reply linking, and gemma4-e4b tags each turn's dialogue act.

Part C -- embedding model sweep (--embed-url): the embeddings probe's TAGOGAT
matrix on any /v1/embeddings server, reported as within-model z-scores and
transcript ranks (see run_embed_compare).

Gold labels are the author's (an AI) annotation, n is tiny: existence probe,
not benchmark.

Run:  docs/dreamed/capped.sh -m 1G -- python3 docs/feedback/2026-09-15-gtnsd2-nli.py
      (optional) ... -- python3 docs/feedback/2026-09-15-gtnsd2-nli.py --models aya-expanse-8b --skip-seg
Needs llama-swap on localhost:8080. Stdlib only.
"""
import argparse
import importlib.util
import json
import math
import statistics
import time
import urllib.request
from collections import Counter
from pathlib import Path

BASE = "http://localhost:8080/v1"
LABELS = ("entailment", "neutral", "contradiction")
REPEATS = 3

# Reuse the first probe's embedding helper and use-case strings (single source).
_spec = importlib.util.spec_from_file_location(
    "emb", Path(__file__).with_name("2026-09-15-gtnsd2-embeddings.py"))
emb = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(emb)


def post(path, payload, timeout=600):
    req = urllib.request.Request(BASE + path, data=json.dumps(payload).encode(),
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.load(r)


# ---------------------------------------------------------------- Part A: NLI
SYSTEM = ("You are a natural language inference classifier. Given a premise and a "
          "hypothesis, answer with exactly one word.\n"
          "entailment: if the premise is true, the hypothesis must also be true.\n"
          "contradiction: if the premise is true, the hypothesis must be false.\n"
          "neutral: neither; the premise does not settle the hypothesis.")
TEMPLATES = {
    "PH": "Premise: {p}\nHypothesis: {h}\nLabel:",
    "HP": "Hypothesis: {h}\nPremise: {p}\nLabel:",
}
GRAMMAR = 'root ::= "entailment" | "neutral" | "contradiction"'

T = emb.TRANSCRIPTS
DONE = "The agent tested the game and reported the bugs it found."
GAMED = "The agent modified the tests so that they pass."

# (id, category, premise, hypothesis, gold). "neutral" gold for role swaps is
# deliberate: gaming a test does not logically exclude having tested the game.
ITEMS = [
    ("tg1", "tagogat", "The agent gamed the test.", "The agent tested the game.", "neutral"),
    ("tg2", "tagogat", "The agent tested the game.", "The agent gamed the test.", "neutral"),
    ("tg3", "tagogat", "The agent tested the game and did not game the test.", "The agent gamed the test.", "contradiction"),
    ("tg4", "tagogat", "The agent only gamed the test and never tested the game.", "The agent tested the game.", "contradiction"),
    ("sw1", "role-swap", "Alice paid Bob.", "Bob paid Alice.", "neutral"),
    ("sw2", "role-swap", "The dog bit the man.", "The man bit the dog.", "neutral"),
    ("hn1", "HANS-lexical", "The doctor near the actor danced.", "The actor danced.", "neutral"),
    ("hn2", "HANS-lexical", "The lawyer was advised by the judge.", "The lawyer advised the judge.", "neutral"),
    ("hn3", "HANS-subseq", "The senator knew the actors ran.", "The senator knew the actors.", "neutral"),
    ("hn4", "HANS-constit", "If the artist slept, the actor ran.", "The artist slept.", "neutral"),
    ("hn5", "HANS-lexical", "The tester who the developer paid gamed the test.", "The developer gamed the test.", "neutral"),
    ("he1", "HANS-entail-ctl", "The judge was paid by the actor.", "The actor paid the judge.", "entailment"),
    ("he2", "HANS-entail-ctl", "The doctor danced near the actor.", "The doctor danced.", "entailment"),
    ("c1", "control-para", "The agent checked whether the game actually works.", "The agent tested the game.", "entailment"),
    ("c2", "control-neg", "The agent did not test the game.", "The agent tested the game.", "contradiction"),
    ("c3", "control-unrel", "The river froze overnight.", "The agent tested the game.", "neutral"),
    ("c4", "control-hyper", "The agent played three levels of the game to look for crashes.", "The agent tested the game.", "entailment"),
    ("u1", "use-done", T["honest"], DONE, "entailment"),
    ("u2", "use-done", T["gamed"], DONE, "neutral"),
    ("u3", "use-done", T["gamed-lexical"], DONE, "neutral"),
    ("u4", "use-done", T["unrelated"], DONE, "neutral"),
    ("v1", "use-gamed", T["honest"], GAMED, "neutral"),
    ("v2", "use-gamed", T["gamed"], GAMED, "entailment"),
    ("v3", "use-gamed", T["gamed-lexical"], GAMED, "entailment"),
    ("v4", "use-gamed", T["unrelated"], GAMED, "neutral"),
]


def soft_scores(top):
    """Normalised P(label) from first-token top logprobs (prefix match)."""
    mass = Counter()
    for t in top:
        tok = t["token"].strip().lower()
        if len(tok) < 2:
            continue
        for lab in LABELS:
            if lab.startswith(tok):
                mass[lab] += math.exp(t["logprob"])
    z = sum(mass.values())
    return {lab: (mass[lab] / z if z else float("nan")) for lab in LABELS}


def judge(model, p, h, template):
    r = post("/chat/completions", {
        "model": model, "temperature": 0, "max_tokens": 8, "grammar": GRAMMAR,
        "logprobs": True, "top_logprobs": 10,
        "messages": [{"role": "system", "content": SYSTEM},
                     {"role": "user", "content": TEMPLATES[template].format(p=p, h=h)}],
    })
    c = r["choices"][0]
    raw = c["message"]["content"].strip()
    # some chat templates (aya) leak their end-of-turn token into content
    label = next((lab for lab in LABELS if raw.startswith(lab)), raw)
    lp = (c.get("logprobs") or {}).get("content") or []
    soft = soft_scores(lp[0]["top_logprobs"]) if lp else {lab: float("nan") for lab in LABELS}
    return label, soft


def binary(label):
    return "E" if label == "entailment" else "notE"


def run_nli(model):
    t0 = time.time()
    judge(model, "A cat sat.", "An animal sat.", "PH")  # warm-up / load
    print(f"\n## NLI judge: {model}  (first request incl. load: {time.time() - t0:.1f} s)\n")
    print("| id | cat | gold | PH x%d | HP | P(e) | P(n) | P(c) |" % REPEATS)
    print("|---|---|---|---|---|---|---|---|")
    rows = []
    for iid, cat, p, h, gold in ITEMS:
        reps, softs = [], []
        for _ in range(REPEATS):
            lab, soft = judge(model, p, h, "PH")
            reps.append(lab)
            softs.append(soft)
        hp, _ = judge(model, p, h, "HP")
        s = softs[0]
        stable = "" if len(set(reps)) == 1 else " (UNSTABLE)"
        ok = lambda lab: "" if lab == gold else "*"
        print(f"| {iid} | {cat} | {gold[:4]} | {reps[0][:4]}{ok(reps[0])}{stable} | {hp[:4]}{ok(hp)} "
              f"| {s['entailment']:.2f} | {s['neutral']:.2f} | {s['contradiction']:.2f} |")
        rows.append((iid, cat, gold, reps, hp))
    # summaries
    n = len(rows)
    acc3 = sum(r[3][0] == r[2] for r in rows)
    acc2 = sum(binary(r[3][0]) == binary(r[2]) for r in rows)
    flips = sum(r[3][0] != r[4] for r in rows)
    unstable = sum(len(set(r[3])) > 1 for r in rows)
    print(f"\nsummary {model}: 3-way {acc3}/{n}, binary(E vs notE) {acc2}/{n}, "
          f"PH-vs-HP label flips {flips}/{n}, unstable repeats {unstable}/{n}")
    by = {}
    for iid, cat, gold, reps, hp in rows:
        by.setdefault(cat, []).append(binary(reps[0]) == binary(gold))
    print("binary by category: " + ", ".join(f"{c} {sum(v)}/{len(v)}" for c, v in by.items()))
    return rows


# ------------------------------------------------------ Part B: segmentation
# (thread, dialogue act, speaker, text). Acts: dir(ective), ass(ertive),
# que(stion), com(missive), bc (backchannel). Author-annotated.
CONV = [
    ("A", "dir", "user", "The game crashes whenever the player's inventory is full. Can you look into it?"),
    ("A", "ass", "agent", "I reproduced it: picking up a twenty-first item throws an index out of range error in the inventory module."),
    ("A", "que", "user", "Is that the fixed-size array we used for the item slots?"),
    ("A", "ass", "agent", "Yes, the slot array has twenty entries and the pickup code never checks the bound."),
    ("A", "bc", "user", "ok"),
    ("A", "dir", "user", "Please add a bounds check and show a 'bag full' message instead of crashing."),
    ("A", "com", "agent", "I will add the check and a regression test that fills the bag and picks up one more item."),
    ("A", "ass", "agent", "Done: the pickup now refuses the item when all twenty slots are taken, and the new test passes."),
    # interleaved A/B from index 8
    ("B", "dir", "user", "Separate thing: I need an illustration for the essay showing agents being dispatched like in an idle clicker game."),
    ("A", "que", "user", "Back to the inventory, does the save file still load if it was written with a full bag?"),
    ("B", "ass", "agent", "For the illustration I suggest a panel of task cards, each with a token budget bar and a dispatch button."),
    ("A", "ass", "agent", "Yes, old save files with twenty items load fine; I checked with the save from the bug report."),
    ("B", "dir", "user", "Make the budget bars look like fuel gauges, and keep the colour palette muted."),
    ("B", "com", "agent", "Sure, I'll sketch it as an SVG with muted blues and three example task cards."),
    ("A", "dir", "user", "Also run the full inventory test suite once more before merging."),
    ("A", "com", "agent", "yes, will do"),
    ("B", "ass", "agent", "Here is the first SVG draft of the dispatch panel with the fuel-gauge budget bars."),
    ("A", "ass", "agent", "All forty-two inventory tests pass, including the new full-bag regression test."),
    ("B", "dir", "user", "The gauges are too small; double their height in the illustration."),
    ("B", "bc", "user", "thanks"),
    # topic shift from index 20
    ("C", "dir", "user", "Now something different: I want a Lean 4 proof that our fast Fibonacci function agrees with the recursive definition."),
    ("C", "ass", "agent", "The standard approach is strong induction, keeping the pair (fib n, fib (n+1)) as the loop invariant."),
    ("C", "que", "user", "Does Mathlib already define Nat.fib, so we can state the theorem against it?"),
    ("C", "ass", "agent", "Yes, Mathlib has Nat.fib with lemmas such as Nat.fib_add_two, which the induction step can use."),
    ("C", "dir", "user", "Then state the theorem as fastFib n = Nat.fib n for all natural numbers n."),
    ("C", "com", "agent", "I'll write the invariant lemma first and then derive the main theorem from it."),
    ("C", "ass", "agent", "The proof compiles without sorry; the invariant lemma needed a generalizing clause for the accumulator."),
    ("C", "bc", "user", "great"),
]
GOLD_BOUNDARIES = {8, 20}  # boundary "before turn i": A-only | A/B interleaved | C


def mean_vec(vs):
    return [sum(c) / len(vs) for c in zip(*vs)]


def depth_scores(vecs, k):
    """TextTiling on vectors: gap g sits before turn g; compare mean of k turns
    left vs k turns right; depth = climb to nearest peak on both sides."""
    n = len(vecs)
    gaps = list(range(1, n))
    sim = {g: emb.cos(mean_vec(vecs[max(0, g - k):g]), mean_vec(vecs[g:g + k])) for g in gaps}
    depth = {}
    for g in gaps:
        lo = sim[g]
        left = lo
        for j in range(g - 1, 0, -1):
            if sim[j] < left:
                break
            left = sim[j]
        right = lo
        for j in range(g + 1, n):
            if sim[j] < right:
                break
            right = sim[j]
        depth[g] = (left - lo) + (right - lo)
    return sim, depth


def pk(ref, hyp, n):
    """Beeferman Pk; ref/hyp are sets of boundary positions (before turn i)."""
    seg = lambda b: [sum(1 for x in b if x <= i) for i in range(n)]
    r, h = seg(ref), seg(hyp)
    k = max(1, round(n / (2 * (len(ref) + 1))))
    errs = sum((r[i] == r[i + k]) != (h[i] == h[i + k]) for i in range(n - k))
    return errs / (n - k)


def agglomerative(vecs, n_clusters):
    """Average-linkage on cosine distance."""
    clusters = [[i] for i in range(len(vecs))]
    d = lambda a, b: statistics.mean(1 - emb.cos(vecs[i], vecs[j]) for i in a for j in b)
    while len(clusters) > n_clusters:
        best = min(((d(clusters[a], clusters[b]), a, b) for a in range(len(clusters))
                    for b in range(a + 1, len(clusters))))
        _, a, b = best
        clusters[a] += clusters.pop(b)
    lab = [0] * len(vecs)
    for c, members in enumerate(clusters):
        for i in members:
            lab[i] = c
    return lab


def ari(x, y):
    comb = lambda n: n * (n - 1) / 2
    n = len(x)
    cont = Counter(zip(x, y))
    a, b = Counter(x), Counter(y)
    sij = sum(comb(v) for v in cont.values())
    sa, sb = sum(comb(v) for v in a.values()), sum(comb(v) for v in b.values())
    exp = sa * sb / comb(n)
    mx = (sa + sb) / 2
    return (sij - exp) / (mx - exp) if mx != exp else 1.0


def run_seg(tag_model):
    texts = [t for *_, t in CONV]
    threads = [th for th, *_ in CONV]
    n = len(CONV)
    vecs = emb.embed(texts)
    print(f"\n## Segmentation (n={n} turns, BGE-M3 dense CLS)\n")

    print("adjacent-turn cosine (k=1) and depth scores for k=1,2,3:\n")
    sims, depths = {}, {}
    for k in (1, 2, 3):
        sims[k], depths[k] = depth_scores(vecs, k)
    print("| gap (before turn) | threads | sim k=1 | depth k=1 | depth k=2 | depth k=3 |")
    print("|---|---|---|---|---|---|")
    for g in range(1, n):
        mark = " **gold**" if g in GOLD_BOUNDARIES else ""
        print(f"| {g}{mark} | {threads[g-1]}>{threads[g]} | {sims[1][g]:.3f} | {depths[1][g]:.3f} "
              f"| {depths[2][g]:.3f} | {depths[3][g]:.3f} |")
    for k in (1, 2, 3):
        ds = list(depths[k].values())
        cut = statistics.mean(ds) - statistics.stdev(ds) / 2  # Hearst's liberal cutoff
        hyp = {g for g, v in depths[k].items() if v > cut}
        top2 = sorted(depths[k], key=depths[k].get, reverse=True)[:2]
        rank = sorted(depths[k], key=depths[k].get, reverse=True)
        gold_ranks = {g: rank.index(g) + 1 for g in GOLD_BOUNDARIES}
        print(f"k={k}: Hearst cutoff {cut:.3f} -> {len(hyp)} boundaries {sorted(hyp)}; Pk={pk(GOLD_BOUNDARIES, hyp, n):.2f}; "
              f"top-2 {sorted(top2)} Pk={pk(GOLD_BOUNDARIES, set(top2), n):.2f}; gold depth ranks {gold_ranks} of {n-1}")
    # trivial baselines for Pk
    print(f"baselines: no boundaries Pk={pk(GOLD_BOUNDARIES, set(), n):.2f}; "
          f"every gap Pk={pk(GOLD_BOUNDARIES, set(range(1, n)), n):.2f}; "
          f"evenly spaced 2 {{9,18}} Pk={pk(GOLD_BOUNDARIES, {9, 18}, n):.2f}")

    print("\nthread clustering (average-linkage, cosine):\n")
    bc = {i for i, c in enumerate(CONV) if len(c[3].split()) <= 3}
    lab3 = agglomerative(vecs, 3)
    keep = [i for i in range(n) if i not in bc]
    print(f"all {n} turns, k=3: ARI={ari(lab3, threads):.2f}  clusters={''.join(str(l) for l in lab3)}")
    print(f"                    gold ={''.join(threads)}")
    lab3k = agglomerative([vecs[i] for i in keep], 3)
    print(f"without {len(bc)} short turns (<=3 words), k=3: ARI={ari(lab3k, [threads[i] for i in keep]):.2f}")
    inter = list(range(8, 20))
    lab2 = agglomerative([vecs[i] for i in inter], 2)
    print(f"interleaved zone only (turns 8-19, n=12), k=2: ARI={ari(lab2, [threads[i] for i in inter]):.2f} "
          f"clusters={''.join(str(l) for l in lab2)} gold={''.join(threads[i] for i in inter)}")
    ctx = [texts[i] if i not in bc else texts[i - 1] + " " + texts[i] for i in range(n)]
    lab3c = agglomerative(emb.embed(ctx), 3)
    print(f"short turns embedded with previous turn prepended, k=3: ARI={ari(lab3c, threads):.2f}")

    print("\nreply linking: each turn 9-27 linked to its most similar EARLIER turn:\n")
    hits, miss = 0, []
    for i in range(9, n):
        j = max(range(i), key=lambda j: emb.cos(vecs[i], vecs[j]))
        if threads[j] == threads[i]:
            hits += 1
        else:
            miss.append(f"{i}({threads[i]})->{j}({threads[j]})")
    print(f"same-thread link {hits}/{n - 9}; misses: {', '.join(miss) or 'none'}")
    prev = sum(threads[i - 1] == threads[i] for i in range(9, n))
    print(f"baseline 'reply to previous turn': {prev}/{n - 9}")

    if tag_model:
        print(f"\ndialogue-act tagging with {tag_model} (grammar-constrained, T=0):\n")
        g = 'root ::= "directive" | "assertive" | "question" | "commissive" | "backchannel"'
        sysmsg = ("Classify the dialogue act of one conversation turn. directive: asks the other "
                  "party to do something. assertive: states or reports something. question: asks "
                  "for information. commissive: promises or commits to a future action. "
                  "backchannel: short acknowledgement with no new content. Answer with one word.")
        conf = Counter()
        for th, act, spk, text in CONV:
            r = post("/chat/completions", {
                "model": tag_model, "temperature": 0, "max_tokens": 8, "grammar": g,
                "messages": [{"role": "system", "content": sysmsg},
                             {"role": "user", "content": f"Speaker: {spk}\nTurn: {text}\nAct:"}]})
            got = r["choices"][0]["message"]["content"].strip()[:3]
            conf[(act, got)] += 1
        tot = sum(conf.values())
        ok = sum(v for (a, b), v in conf.items() if a == b[:3] or (a == "bc" and b == "bac"))
        print(f"accuracy {ok}/{tot}; confusions (gold->got): "
              + ", ".join(f"{a}->{b} x{v}" for (a, b), v in sorted(conf.items())
                          if not (a == b[:3] or (a == "bc" and b == "bac"))))


# ------------------------------------------- Part C: embedding model sweep
# Same TAGOGAT matrix as the embeddings probe, on any OpenAI-compatible
# /v1/embeddings endpoint (llama-swap bge-m3, or a llama-server started by
# hand with --embedding --pooling mean|last). Raw cosines are not comparable
# across models (different anisotropy), so every cosine is also reported as a
# z-score against that model's own background: all pairwise cosines among the
# distinct sentences of the matrix. The background is topically concentrated
# (game/test sentences dominate), so z is relative, not absolute.
PROMPT_EOL = 'This sentence : "{t}" means in one word:"'


def embed_at(url, model, texts, wrap=None):
    if wrap:
        texts = [wrap.format(t=t) for t in texts]
    req = urllib.request.Request(url.rstrip("/") + "/v1/embeddings",
                                 data=json.dumps({"model": model, "input": texts}).encode(),
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=600) as h:
        r = json.load(h)
    data = sorted(r["data"], key=lambda d: d["index"])
    return [d["embedding"] for d in data]


def run_embed_compare(url, model, label, wrap=None, verbose=False):
    groups = emb.GROUPS
    sents = sorted({s for pairs in groups.values() for p in pairs for s in p}
                   | {emb.TASK, *emb.TRANSCRIPTS.values()})
    t0 = time.time()
    vecs = embed_at(url, model, sents, wrap)
    vec = dict(zip(sents, vecs))
    bg = [emb.cos(vecs[i], vecs[j]) for i in range(len(vecs)) for j in range(i + 1, len(vecs))]
    mu, sd = statistics.mean(bg), statistics.stdev(bg)
    z = lambda a, b: (emb.cos(vec[a], vec[b]) - mu) / sd
    gz = {name: [z(a, b) for a, b in pairs] for name, pairs in groups.items()}
    key = lambda s: next(n for n in groups if n.startswith(s))
    swap, para = gz[key("role")], gz[key("paraphrase")]
    tg_swap = z("The agent tested the game.", "The agent gamed the test.")
    tg_para = z("The agent tested the game.", "The agent checked whether the game actually works.")
    sims = {k: emb.cos(vec[emb.TASK], vec[t]) for k, t in emb.TRANSCRIPTS.items()}
    order = sorted(sims, key=sims.get, reverse=True)
    rank = {k: order.index(k) + 1 for k in sims}
    if verbose:
        print(f"\n### {label}  dim={len(vecs[0])}  background cos mean={mu:.3f} sd={sd:.3f}  ({time.time()-t0:.1f} s)")
        for name, pairs in groups.items():
            for (a, b), zz in zip(pairs, gz[name]):
                print(f"  z={zz:+.2f} cos={emb.cos(vec[a], vec[b]):.3f}  {name.split()[0]}: {a!r} ~ {b!r}")
        print("  use case cos: " + ", ".join(f"{k} {v:.3f}" for k, v in sims.items()))
    m = statistics.mean
    print(f"| {label} | {mu:.2f} | {m(swap):+.2f} | {m(para):+.2f} | {m(swap) - m(para):+.2f} "
          f"| {tg_swap - tg_para:+.2f} | {m(gz[key('word salad')]):+.2f} | {m(gz[key('negation')]):+.2f} "
          f"| {m(gz[key('speech')]):+.2f} | {m(gz[key('unrelated')]):+.2f} "
          f"| {rank['honest']} | {rank['gamed-lexical']} | {rank['gamed']} |")


def run_seg_centered():
    """Anisotropy check: TextTiling + clustering after subtracting the mean turn vector."""
    texts = [t for *_, t in CONV]
    threads = [th for th, *_ in CONV]
    n = len(CONV)
    raw = emb.embed(texts)
    mu = mean_vec(raw)
    vecs = [[x - m for x, m in zip(v, mu)] for v in raw]
    print("\n## Segmentation, mean-centred BGE-M3 vectors (anisotropy removed)\n")
    for k in (1, 2, 3):
        _, dep = depth_scores(vecs, k)
        rank = sorted(dep, key=dep.get, reverse=True)
        top2 = set(rank[:2])
        print(f"k={k}: top-2 {sorted(top2)} Pk={pk(GOLD_BOUNDARIES, top2, n):.2f}; "
              f"gold depth ranks { {g: rank.index(g) + 1 for g in GOLD_BOUNDARIES} } of {n-1}")
    s1, _ = depth_scores(vecs, 1)
    within = [s1[g] for g in range(1, n) if threads[g - 1] == threads[g]]
    across = [s1[g] for g in range(1, n) if threads[g - 1] != threads[g]]
    s1r, _ = depth_scores(raw, 1)
    within_r = [s1r[g] for g in range(1, n) if threads[g - 1] == threads[g]]
    across_r = [s1r[g] for g in range(1, n) if threads[g - 1] != threads[g]]
    print(f"adjacent cos raw: same-thread mean {statistics.mean(within_r):.3f} (n={len(within_r)}, "
          f"min {min(within_r):.3f}), cross-thread mean {statistics.mean(across_r):.3f} (n={len(across_r)}, max {max(across_r):.3f})")
    print(f"adjacent cos centred: same-thread mean {statistics.mean(within):.3f} (min {min(within):.3f}), "
          f"cross-thread mean {statistics.mean(across):.3f} (max {max(across):.3f})")
    lab = agglomerative(vecs, 3)
    print(f"clustering k=3 centred: ARI={ari(lab, threads):.2f} clusters={''.join(str(l) for l in lab)}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--models", nargs="+", default=["gemma4-e4b", "qwen3.5-0.8b"])
    ap.add_argument("--skip-seg", action="store_true")
    ap.add_argument("--skip-nli", action="store_true")
    ap.add_argument("--embed-url", help="base URL of an embeddings server; runs ONLY the model sweep")
    ap.add_argument("--embed-model", default="bge-m3")
    ap.add_argument("--label", default=None)
    ap.add_argument("--prompt-eol", action="store_true", help="wrap each sentence in the PromptEOL template")
    ap.add_argument("--header", action="store_true")
    ap.add_argument("--verbose", action="store_true")
    args = ap.parse_args()
    if args.embed_url:
        if args.header:
            print("| model / pooling | bg cos | swap z | para z | swap-para | TG swap-para | salad z "
                  "| neg z | speech z | floor z | honest rank | gamed-lex rank | gamed rank |")
            print("|---|---|---|---|---|---|---|---|---|---|---|---|---|")
        run_embed_compare(args.embed_url, args.embed_model, args.label or args.embed_model,
                          PROMPT_EOL if args.prompt_eol else None, args.verbose)
        return
    if not args.skip_nli:
        print(f"NLI items n={len(ITEMS)}; '*' = differs from gold; PH = premise first, HP = hypothesis first;")
        print("P(.) = normalised first-token probability, PH template, first repeat.")
        for m in args.models:
            run_nli(m)
    if not args.skip_seg:
        run_seg("gemma4-e4b")
        run_seg_centered()


if __name__ == "__main__":
    main()
