#!/usr/bin/env python3
"""Find SVG text that runs outside its own viewBox.

Why: inline SVG is clipped at the viewBox, silently. The render tier checks MATH, and
`test_render.sh` checks HTML structure, so neither can see a headline sliding off the
right edge. The owner caught one by looking at it, which is not a scalable detector.

Two things a naive version gets wrong, and both were hit on the first attempt:
  1. Text styled by CSS CLASS has no font-size attribute. The class table lives in a
     <style> block, so it has to be parsed and resolved.
  2. `text-anchor` decides what x MEANS. For "middle" x is the centre, for "end" it is
     the right edge. Ignoring it reports centred text as overflowing when it is fine.

Width is estimated, not measured: there is no font engine here. The factor is
deliberately conservative, so this OVER-reports rather than under-reports, and every
hit still wants an eyeball.

Run: docs/dreamed/capped.sh -m 2G -c 100 -t 300 -- python3 docs/dreamed/figures/check-overflow.py
"""

import glob
import os
import re
import sys

# Text is MEASURED, not estimated. `system-ui` resolves to Noto Sans on this box
# (fc-match), and PIL reads the real advance widths out of the TTF. An earlier
# version of this file guessed a per-character factor and over-reported by about
# ten percent, which is exactly enough noise to bury the real hits.
REG = "/usr/share/fonts/noto/NotoSans-Regular.ttf"
BOLD = "/usr/share/fonts/noto/NotoSans-Bold.ttf"
SLACK = 4.0  # units of tolerance before reporting

from PIL import ImageFont
_cache = {}


def measure(s, size, bold):
    key = (round(size), bold)
    if key not in _cache:
        _cache[key] = ImageFont.truetype(BOLD if bold else REG, max(1, int(round(size))))
    return _cache[key].getlength(s)

DREAMED = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def class_sizes(svg, page_style):
    """font-size per CSS class, from the svg's own <style> and the page-level one."""
    sizes, weights = {}, {}
    for block in re.findall(r"<style[^>]*>(.*?)</style>", page_style + svg, re.S | re.I):
        for sel, body in re.findall(r"([^{}]+)\{([^{}]*)\}", block):
            fs = re.search(r"font-size\s*:\s*([\d.]+)", body)
            fw = re.search(r"font-weight\s*:\s*(\d+|bold)", body)
            for name in re.findall(r"\.([A-Za-z0-9_-]+)", sel):
                if fs:
                    sizes[name] = float(fs.group(1))
                if fw:
                    weights[name] = True
    return sizes, weights


def check(path):
    text = open(path, encoding="utf-8").read()
    page_style = "".join(re.findall(r"<style[^>]*>.*?</style>", text, re.S | re.I))
    hits = []
    for idx, svg in enumerate(re.findall(r"<svg.*?</svg>", text, re.S), 1):
        m = re.search(r'viewBox="\s*([-\d.]+)\s+([-\d.]+)\s+([\d.]+)\s+([\d.]+)"', svg)
        if not m:
            continue
        vx, vy, vw, vh = (float(g) for g in m.groups())
        sizes, weights = class_sizes(svg, page_style)

        for t in re.finditer(r"<text\b([^>]*)>(.*?)</text>", svg, re.S):
            attrs, body = t.group(1), t.group(2)
            body = re.sub(r"<[^>]+>", "", body)
            body = re.sub(r"&#\d+;|&[a-z]+;", "x", body).strip()
            if not body:
                continue
            xm = re.search(r'\bx="([-\d.]+)"', attrs)
            if not xm:
                continue
            x = float(xm.group(1))

            fsm = re.search(r'font-size="([\d.]+)"', attrs)
            if fsm:
                fs = float(fsm.group(1))
            else:
                cls = re.search(r'class="([^"]+)"', attrs)
                fs = None
                if cls:
                    for c in cls.group(1).split():
                        if c in sizes:
                            fs = sizes[c]
                            break
                if fs is None:
                    continue  # cannot resolve, do not guess

            bold = "bold" in attrs or (
                re.search(r'class="([^"]+)"', attrs)
                and any(c in weights for c in re.search(r'class="([^"]+)"', attrs).group(1).split())
            )
            w = measure(body, fs, bool(bold))

            anchor = "start"
            am = re.search(r'text-anchor="(\w+)"', attrs)
            if am:
                anchor = am.group(1)
            if anchor == "middle":
                left, right = x - w / 2, x + w / 2
            elif anchor == "end":
                left, right = x - w, x
            else:
                left, right = x, x + w

            over_r = right - (vx + vw)
            over_l = vx - left
            if over_r > SLACK or over_l > SLACK:
                hits.append(
                    (idx, round(max(over_r, over_l)), round(vw), anchor, round(fs), body[:52])
                )
    return hits


def main():
    files = sorted(
        glob.glob(os.path.join(DREAMED, "poster-*.md"))
        + glob.glob(os.path.join(DREAMED, "fig-*.md"))
    )
    total = 0
    for f in files:
        hits = check(f)
        if not hits:
            continue
        print("\n" + os.path.basename(f))
        for idx, over, vw, anchor, fs, body in hits:
            print("  svg %-2d +%-4d over (viewBox %s, anchor %-6s %spx)  %s"
                  % (idx, over, vw, anchor, fs, body))
        total += len(hits)
    print("\n%d suspected overflow(s) across %d pages" % (total, len(files)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
