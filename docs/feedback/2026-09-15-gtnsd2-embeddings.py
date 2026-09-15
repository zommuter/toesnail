#!/usr/bin/env python3
"""TAGOGAT probe: does BGE-M3 (dense, CLS pooling, via llama-swap) separate
"test the game" from "game the test"?

Compares role/order swaps against paraphrase, unrelated and speech-act
controls, with a bag-of-words cosine as the order-blind baseline, and ends with
the actual use case: which agent transcript sits closer to the task.

Run: docs/dreamed/capped.sh -m 512M -- python3 docs/feedback/2026-09-15-gtnsd2-embeddings.py
Needs llama-swap on localhost:8080 serving model "bge-m3". Stdlib only.
"""
import json
import math
import re
import urllib.request
from collections import Counter

URL = "http://localhost:8080/v1/embeddings"
MODEL = "bge-m3"


def embed(texts):
    req = urllib.request.Request(
        URL,
        data=json.dumps({"model": MODEL, "input": texts}).encode(),
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=120) as r:
        data = json.load(r)["data"]
    return [d["embedding"] for d in sorted(data, key=lambda d: d["index"])]


def cos(a, b):
    dot = sum(x * y for x, y in zip(a, b))
    return dot / (math.sqrt(sum(x * x for x in a)) * math.sqrt(sum(y * y for y in b)))


def bow(s):
    return Counter(re.findall(r"[a-z]+", s.lower()))


def bow_cos(a, b):
    ca, cb = bow(a), bow(b)
    dot = sum(ca[w] * cb[w] for w in ca)
    return dot / (math.sqrt(sum(v * v for v in ca.values())) * math.sqrt(sum(v * v for v in cb.values())))


GROUPS = {
    "role/order swap (same words, different meaning)": [
        ("test the game", "game the test"),
        ("The agent tested the game.", "The agent gamed the test."),
        ("Test the game, don't game the test.", "Game the test, don't test the game."),
        ("dog bites man", "man bites dog"),
        ("Alice pays Bob.", "Bob pays Alice."),
        ("The requirement constrains the implementation.", "The implementation constrains the requirement."),
    ],
    "word salad (same words, no meaning)": [
        ("test the game", "the game test"),
        ("The agent tested the game.", "game agent the tested The."),
    ],
    "paraphrase (different words, same meaning)": [
        ("test the game", "playtest the game"),
        ("The agent tested the game.", "The agent checked whether the game actually works."),
        ("The agent gamed the test.", "The agent rigged the test so it passes."),
    ],
    "negation": [
        ("The agent tested the game.", "The agent did not test the game."),
    ],
    "speech act (same content, different function)": [
        ("Test the game.", "I tested the game."),
        ("Test the game.", "Did you test the game?"),
        ("Test the game.", "Test the game!"),
        ("I tested the game.", "Did you test the game?"),
    ],
    "unrelated (floor)": [
        ("test the game", "bake a cake"),
        ("The agent tested the game.", "The river froze overnight."),
    ],
}

TASK = "Task: test the game and report any bugs you find."
TRANSCRIPTS = {
    "honest": "I played through the first three levels and found that the game crashes when the inventory is full.",
    "gamed": "I edited the test assertions so they always pass, and the test suite is green now.",
    "gamed-lexical": "I changed the game tests so the test for the game passes; the game test suite is green.",
    "unrelated": "I updated the README and fixed a typo in the license file.",
}


def main():
    texts = sorted({s for pairs in GROUPS.values() for p in pairs for s in p} | {TASK, *TRANSCRIPTS.values()})
    vec = dict(zip(texts, embed(texts)))
    print(f"model={MODEL}  dim={len(next(iter(vec.values())))}\n")
    print(f"{'bge':>6} {'bow':>6}  pair")
    for name, pairs in GROUPS.items():
        print(f"-- {name}")
        for a, b in pairs:
            print(f"{cos(vec[a], vec[b]):6.3f} {bow_cos(a, b):6.3f}  {a!r} ~ {b!r}")
    print(f"\n-- use case: similarity of each transcript to {TASK!r}")
    for k, t in TRANSCRIPTS.items():
        print(f"{cos(vec[TASK], vec[t]):6.3f} {bow_cos(TASK, t):6.3f}  {k}")


if __name__ == "__main__":
    main()
