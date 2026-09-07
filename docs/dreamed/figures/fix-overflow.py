#!/usr/bin/env python3
"""Widen each SVG's viewBox so no text is clipped, preserving rendered type size.

The problem: SVG text does not wrap, and anything past the viewBox is silently
clipped. The dreamed figures and posters were hand-authored with guessed coordinates,
so 91 lines ran off the right edge. Neither `test_render.sh` nor the advisory render
tier can see this: they check HTML structure and math, not geometry.

The fix, chosen because it is deterministic and preserves the design: widen the
viewBox to fit the widest line, and scale the element's `max-width` by the SAME ratio
so the type renders at the size it always did. The figure gets physically wider on
screen instead of smaller, which is what the posters want, and the page already
allows it.

What it does NOT do: rewrite anyone's words or move anything. Rewording is an
editorial act and stays with the author.

Widths are MEASURED with PIL against Noto Sans, which is what `system-ui` resolves to
here, not estimated from a per-character factor.

Run:  docs/dreamed/capped.sh -m 2G -c 100 -t 300 -- python3 docs/dreamed/figures/fix-overflow.py [--apply]
Without --apply it reports and changes nothing.
"""

import glob
import os
import re
import sys

from PIL import ImageFont

REG = "/usr/share/fonts/noto/NotoSans-Regular.ttf"
BOLD = "/usr/share/fonts/noto/NotoSans-Bold.ttf"
MARGIN = 24.0          # breathing room kept to the right of the widest line
DREAMED = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
_cache = {}


def measure(s, size, bold):
    key = (round(size), bold)
    if key not in _cache:
        _cache[key] = ImageFont.truetype(BOLD if bold else REG, max(1, int(round(size))))
    return _cache[key].getlength(s)


def class_table(*blobs):
    sizes, weights = {}, {}
    for blob in blobs:
        for block in re.findall(r"<style[^>]*>(.*?)</style>", blob, re.S | re.I):
            for sel, body in re.findall(r"([^{}]+)\{([^{}]*)\}", block):
                fs = re.search(r"font-size\s*:\s*([\d.]+)", body)
                fw = re.search(r"font-weight\s*:\s*(\d+|bold)", body)
                for name in re.findall(r"\.([A-Za-z0-9_-]+)", sel):
                    if fs:
                        sizes[name] = float(fs.group(1))
                    if fw:
                        weights[name] = True
    return sizes, weights


def extents(svg, sizes, weights):
    """Leftmost and rightmost pixel any text reaches, in user units."""
    right_max = float("-inf")
    left_min = float("inf")
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
            cm = re.search(r'class="([^"]+)"', attrs)
            fs = None
            if cm:
                for c in cm.group(1).split():
                    if c in sizes:
                        fs = sizes[c]
                        break
            if fs is None:
                continue

        cm = re.search(r'class="([^"]+)"', attrs)
        bold = ("bold" in attrs) or bool(
            cm and any(c in weights for c in cm.group(1).split())
        )
        w = measure(body, fs, bold)

        anchor = "start"
        am = re.search(r'text-anchor="(\w+)"', attrs)
        if am:
            anchor = am.group(1)
        cm2 = re.search(r'class="([^"]+)"', attrs)
        if cm2 and anchor == "start":
            # classes .m / .e are the idiom used for middle / end in these files
            cls = cm2.group(1).split()
            if "m" in cls:
                anchor = "middle"
            elif "e" in cls:
                anchor = "end"

        if anchor == "middle":
            left, right = x - w / 2, x + w / 2
        elif anchor == "end":
            left, right = x - w, x
        else:
            left, right = x, x + w
        right_max = max(right_max, right)
        left_min = min(left_min, left)
    return left_min, right_max


def process(path, apply):
    text = open(path, encoding="utf-8").read()
    page_style = "".join(re.findall(r"<style[^>]*>.*?</style>", text, re.S | re.I))
    out, last, changed = [], 0, []

    for m in re.finditer(r"<svg\b.*?</svg>", text, re.S):
        svg = m.group(0)
        vb = re.search(r'viewBox="\s*([-\d.]+)\s+([-\d.]+)\s+([\d.]+)\s+([\d.]+)"', svg)
        if not vb:
            continue
        vx, vy, vw, vh = (float(g) for g in vb.groups())
        sizes, weights = class_table(page_style, svg)
        left_min, right_max = extents(svg, sizes, weights)
        if right_max == float("-inf"):
            continue
        # Pad SYMMETRICALLY. Widening only the right edge leaves centre-anchored
        # text sitting left of the new centre, which looks broken even though
        # nothing is clipped. Equal padding keeps the old centre as the new one.
        need_l = (vx + MARGIN) - left_min
        need_r = (right_max + MARGIN) - (vx + vw)
        pad = max(need_l, need_r, 0.0)
        if pad < 1:
            continue

        pad = float(int(pad) + 1)
        new_vx = vx - pad
        new_w = vw + 2 * pad
        ratio = new_w / vw
        new_svg = svg.replace(
            vb.group(0), 'viewBox="%g %g %g %g"' % (new_vx, vy, new_w, vh), 1
        )

        # extend a full-width background rect so the new area is painted
        def widen_bg(mm):
            if abs(float(mm.group("w")) - vw) < 2:
                s = mm.group(0)
                s = s.replace('width="%s"' % mm.group("w"), 'width="%g"' % new_w)
                s = re.sub(r'\bx="0"', 'x="%g"' % new_vx, s, count=1)
                return s
            return mm.group(0)

        new_svg = re.sub(
            r'<rect[^>]*\bx="0"[^>]*\bwidth="(?P<w>[\d.]+)"[^>]*>', widen_bg, new_svg
        )

        # keep the rendered type size: scale max-width by the same ratio
        stym = re.search(r'\bstyle="([^"]*)"', new_svg[: new_svg.find(">") + 1])
        mwm = re.search(r"max-width:\s*([\d.]+)px", stym.group(1)) if stym else None
        if mwm:
            new_mw = round(float(mwm.group(1)) * ratio)
            new_svg = new_svg.replace(
                stym.group(0),
                stym.group(0).replace(
                    "max-width:%spx" % mwm.group(1), "max-width:%dpx" % new_mw
                ).replace(
                    "max-width: %spx" % mwm.group(1), "max-width: %dpx" % new_mw
                ),
                1,
            )
        else:
            head_end = new_svg.find(">")
            head = new_svg[:head_end]
            cm = re.search(r'class="([^"]+)"', head)
            base = None
            if cm:
                for c in cm.group(1).split():
                    pm = re.search(
                        r"\.%s\s*\{[^}]*max-width:\s*([\d.]+)px" % re.escape(c), page_style
                    )
                    if pm:
                        base = float(pm.group(1))
                        break
            if base:
                new_svg = (
                    head + ' style="max-width:%dpx"' % round(base * ratio)
                    + new_svg[head_end:]
                )

        out.append(text[last:m.start()])
        out.append(new_svg)
        last = m.end()
        changed.append((round(vw), round(new_w)))

    if changed and apply:
        out.append(text[last:])
        open(path, "w", encoding="utf-8").write("".join(out))
    return changed


def main():
    apply = "--apply" in sys.argv
    files = sorted(
        glob.glob(os.path.join(DREAMED, "poster-*.md"))
        + glob.glob(os.path.join(DREAMED, "fig-*.md"))
    )
    total = 0
    for f in files:
        ch = process(f, apply)
        if ch:
            print("%-34s %s" % (os.path.basename(f),
                                ", ".join("%d->%d" % c for c in ch)))
            total += len(ch)
    print("\n%d svg(s) widened%s" % (total, "" if apply else "  (dry run, use --apply)"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
