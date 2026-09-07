#!/usr/bin/env python3
"""Extract the dreamed infographics into standalone SVG files plus one self-contained
HTML gallery, so the figures can be viewed WITHOUT running Jekyll.

Why this exists: `docs/dreamed/fig-*.md` are Jekyll pages. Reading them needs a build
and a server, and the owner asked for files that open directly in a browser.

Two things a naive extraction gets wrong, both handled here:

  1. THREE pages (fig-fhe, fig-results, fig-thermo-laser) keep their CSS in a
     page-level <style> block OUTSIDE the <svg> elements, because inline SVG in HTML
     inherits it. Pulled out on its own, those SVGs render unstyled. This script
     injects the page's style block into every SVG it extracts from that page.
  2. Inline SVG in HTML needs no xmlns. A standalone .svg file DOES: without it a
     browser serves the file as XML and shows a parse tree instead of a picture.
     This script adds it where missing.

Handles two page sets, selected by the prefix argument:
  fig-     the dense infographics       -> docs/dreamed/figures/
  poster-  the ELI12 posters            -> docs/dreamed/posters/

Output (all git-tracked, all openable with file://):
  <outdir>/<page-slug>-NN.svg   one file per figure
  <outdir>/index.html           every figure inline, no external assets

Run:
  docs/dreamed/capped.sh -m 2G -c 100 -t 300 -- python3 docs/dreamed/figures/build-figures.py fig-
  docs/dreamed/capped.sh -m 2G -c 100 -t 300 -- python3 docs/dreamed/figures/build-figures.py poster-
"""

import html
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
DREAMED = os.path.dirname(HERE)

SVG_RE = re.compile(r"<svg\b.*?</svg>", re.DOTALL | re.IGNORECASE)
STYLE_RE = re.compile(r"<style\b[^>]*>(.*?)</style>", re.DOTALL | re.IGNORECASE)
TITLE_RE = re.compile(r"^title:\s*(.+?)\s*$", re.MULTILINE)
SVGTITLE_RE = re.compile(r"<title>(.*?)</title>", re.DOTALL | re.IGNORECASE)


def front_matter_title(text, fallback):
    head = text.split("---", 2)
    if len(head) >= 3:
        m = TITLE_RE.search(head[1])
        if m:
            return m.group(1).strip().strip('"').strip("'")
    return fallback


def ensure_xmlns(svg):
    if re.search(r"\bxmlns\s*=", svg[:400], re.IGNORECASE):
        return svg
    return re.sub(r"<svg\b", '<svg xmlns="http://www.w3.org/2000/svg"', svg, count=1)


def inject_style(svg, css):
    """Put the page-level CSS inside the SVG so it survives extraction."""
    if not css.strip():
        return svg
    if re.search(r"<style\b", svg, re.IGNORECASE):
        return svg
    block = "<style>\n" + css.strip() + "\n</style>\n"
    # After the opening tag, so it applies to everything that follows.
    m = re.search(r"<svg\b[^>]*>", svg, re.IGNORECASE)
    if not m:
        return svg
    return svg[: m.end()] + "\n" + block + svg[m.end() :]


SETS = {
    "fig-": ("figures", "Dreamed infographics",
             "extracted so they open <strong>without Jekyll and without a server</strong>"),
    "poster-": ("posters", "Dreamed posters (ELI12)",
                "plain-language posters, no maths background needed, opening "
                "<strong>without Jekyll and without a server</strong>"),
}


def main():
    prefix = sys.argv[1] if len(sys.argv) > 1 else "fig-"
    if prefix not in SETS:
        print("usage: build-figures.py [fig-|poster-]", file=sys.stderr)
        return 2
    subdir, heading, lede_tail = SETS[prefix]
    outdir = os.path.join(DREAMED, subdir)
    os.makedirs(outdir, exist_ok=True)

    pages = sorted(
        p for p in os.listdir(DREAMED)
        if p.startswith(prefix) and p.endswith(".md")
    )
    if not pages:
        print("no {}*.md pages found".format(prefix), file=sys.stderr)
        return 1

    gallery = []
    total = 0

    for page in pages:
        slug = page[:-3]
        path = os.path.join(DREAMED, page)
        with open(path, encoding="utf-8") as fh:
            text = fh.read()

        page_title = front_matter_title(text, slug)
        css = "\n".join(m.group(1) for m in STYLE_RE.finditer(text))
        svgs = SVG_RE.findall(text)

        gallery.append(
            '<section class="page">\n<h2 id="{sid}">{t}</h2>\n'
            '<p class="src">source: <code>docs/dreamed/{p}</code> '
            '&middot; {n} figure{s}</p>'.format(
                sid=html.escape(slug), t=html.escape(page_title),
                p=html.escape(page), n=len(svgs), s="" if len(svgs) == 1 else "s",
            )
        )

        for i, svg in enumerate(svgs, 1):
            svg = inject_style(svg, css)
            standalone = ensure_xmlns(svg)

            name = "{}-{:02d}.svg".format(slug, i)
            with open(os.path.join(outdir, name), "w", encoding="utf-8") as fh:
                fh.write('<?xml version="1.0" encoding="UTF-8"?>\n')
                fh.write(standalone)
                fh.write("\n")

            cap = SVGTITLE_RE.search(svg)
            caption = cap.group(1).strip() if cap else name
            caption = re.sub(r"\s+", " ", caption)

            gallery.append(
                '<figure>\n{svg}\n<figcaption>{n}. {c} '
                '<a href="{f}">open the SVG</a></figcaption>\n</figure>'.format(
                    svg=svg, n=i, c=html.escape(caption), f=html.escape(name)
                )
            )
            total += 1

        gallery.append("</section>")

    toc = "\n".join(
        '<li><a href="#{s}">{t}</a></li>'.format(
            s=html.escape(p[:-3]),
            t=html.escape(front_matter_title(
                open(os.path.join(DREAMED, p), encoding="utf-8").read(), p[:-3])),
        )
        for p in pages
    )

    doc = DOC_TEMPLATE.format(
        npages=len(pages), nfigs=total, toc=toc, body="\n".join(gallery),
        heading=html.escape(heading), lede_tail=lede_tail,
    )
    with open(os.path.join(outdir, "index.html"), "w", encoding="utf-8") as fh:
        fh.write(doc)

    print("wrote {} standalone SVG files from {} pages".format(total, len(pages)))
    print("wrote " + os.path.join(outdir, "index.html"))
    return 0


DOC_TEMPLATE = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{heading}</title>
<style>
  :root {{ color-scheme: light; }}
  body {{ margin: 0 auto; padding: 2rem 1.25rem 5rem; max-width: 60rem;
         background: #fdfdfc; color: #1a1a1a;
         font: 16px/1.6 system-ui, -apple-system, Segoe UI, Roboto, sans-serif; }}
  h1 {{ font-size: 1.7rem; margin: 0 0 .4rem; }}
  h2 {{ font-size: 1.25rem; margin: 3rem 0 .2rem; padding-top: 1.2rem;
       border-top: 2px solid #e4e2dd; }}
  .lede {{ color: #555; margin: 0 0 1.5rem; }}
  .lede strong {{ color: #1a1a1a; }}
  .src {{ color: #6b6b6b; font-size: .85rem; margin: .1rem 0 1.2rem; }}
  code {{ background: #f0efec; padding: .1em .35em; border-radius: 3px;
         font-size: .88em; }}
  figure {{ margin: 0 0 2.2rem; padding: 1rem; border: 1px solid #e4e2dd;
           border-radius: 8px; background: #fff; overflow-x: auto; }}
  figure svg {{ display: block; max-width: 100%; height: auto; }}
  figcaption {{ margin-top: .7rem; color: #555; font-size: .85rem; }}
  figcaption a {{ color: #2a78d6; }}
  nav ul {{ columns: 2; margin: 0; padding-left: 1.2rem; }}
  nav li {{ margin: .15rem 0; break-inside: avoid; }}
  nav a {{ color: #2a78d6; }}
  .note {{ background: #fbf6e9; border: 1px solid #e8dcb8; border-radius: 8px;
          padding: .8rem 1rem; margin: 1.5rem 0 0; font-size: .9rem; }}
</style>
</head>
<body>
<h1>{heading}</h1>
<p class="lede">{nfigs} figures from {npages} pages, {lede_tail}. Everything below is
inline: no CDN, no scripts, no external assets. Each figure also exists as its own
<code>.svg</code> file in this directory.</p>

<nav><ul>
{toc}
</ul></nav>

<div class="note"><strong>Status.</strong> These illustrate <code>docs/dreamed/</code>,
which is AI-generated, owner-seeded exploration. Nothing here is ratified theory. The one
ratified record is
<code>docs/meeting-notes/2026-09-07-1508-bloch-truth-rulings.md</code>.</div>

{body}
</body>
</html>
"""


if __name__ == "__main__":
    sys.exit(main())
