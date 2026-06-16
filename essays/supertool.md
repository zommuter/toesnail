---
title: The perfect supertool
author: Zommuter
permalink: /Supertool
---

# Introduction

So what do I need for TOESNAIL-MODE or many of my projects in general?

Clearly some typesetting capabilities so both myself and interested readers can later on actually read it comfortably. $\LaTeX$ sure does a great job at that but is way too complex for direct use. But fortunately e.g. `pandoc` can convert simpler input formats into nice output using that in the background. Markdown certainly is a first simple choice but has some limitations that require extensions, e.g. for tables and bibliographies - the latter of which isn't my strength anyway, but I shouldn't neglect it nonetheless.

A cell-like structure like Jupyter notebooks provide is certainly beneficial, though I have to stop myself here from drifting into questions such as infinite nestability of cell-types etc. - technologically interesting for sure, but YAGNI... What is however one thing that I do want in addition to Jupyter functionality is the ability to decide whether to output the (code) input alongside the output or not. This also heads towards the idea that Markdown cells are basically input cells that are converted by a fictional markdown kernel into the rendered output with a "no input shown" setting. In general, it might be desirable to only display a code block's output while keeping the code itself hidden in the final output (or maybe referenced to an appendix for readability). Output artifacts should be kept outside the source document but may still be kept cached in a versioning friendly manner, maybe using git LFS or similar.
