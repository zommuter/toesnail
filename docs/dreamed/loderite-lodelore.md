---
title: Loderite and lodelore
permalink: /dreamed/loderite-lodelore
---

# The truncated-octahedron voxel, quantified: geometry, graph metric, and the drift question

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, from an
> owner-picked seed: *"if you feel like it, dream on Loderite/lodelore as well."* This essay is
> about **other repos** (`~/src/loderite`, `~/src/lodelore`) and is filed in toesnail only because
> the owner asked for the dreaming to land here. Both repos were **read-only** to this session;
> every finding below is located and surfaced, nothing was edited or filed anywhere. It proposes;
> the owner disposes.

## 0. What the two repos actually are right now

**loderite** (last commit `9089fa7c`, 2026-09-01, v0.126.0, pre-1.0 and playable): a PWA
creative-mode voxel game whose block is the truncated octahedron (TO), addressed on a BCC lattice
in "doubled" same-parity integer coordinates (`src/lattice.ts`). Far past MVP: a merged
face-culled chunk mesher, the 1/8 Lodule octant system plus the diagonal 4-segment Cleave algebra
(`src/seg-geometry.ts`), portals restricted to proper lattice isometries, procedural worldgen as a
pure generator under a player-edit overlay, three moons on 4:2:1 orbits (id:42b4, closed
2026-09-01). Live threads: the splat-library pilot `id:2ba7`, the Lane-B splat research `id:d54d`
(avenues 2/3/4 NO-GO, avenue 1 conditional), the real-GPU perf series `id:78b0`/`id:affd`, and
the seg re-key epic `id:d215` (ratified, not yet built).

**lodelore** (last commit `9ffb46a`, 2026-08-26): the family's terminology and lore
source-of-truth, minted 2026-07-11 (cross-repo strategy meeting D3) precisely to stop naming
drift between yinyang-puzzle, puzzle-pwa and loderite. Since 2026-07-31 it also hosts the
family's Lean 4 + Mathlib development (`lean/LodeloreGeometry/`, eight modules, zero `sorry`),
widened 2026-08-18 to be the family's proving home. Live threads: the Kachelwiese defer `id:e5ef`
(blocked on the external B1 survey), the creation-history prose `id:cd19` (ungated 2026-08-19),
the magnetism prose `id:34ce`, the 1/48 "lode-quark" meeting `id:409d`, the parked
particle-physics item `id:d96a`, and the dark-window takeover `id:6776`, which gates loderite.

The toesnail connection on record is ROADMAP `id:ff32` ("[INBOUND routed:b0c5 from loderite]
T-matrix <-> Gaussian-splat <-> WiRoHSH relationship"). Two sibling essays already ruled on it:
[`wirohsh-splats.md`](wirohsh-splats.md) recommends **NO-GO as framed** with four independent
breaks (a splat is a one-sided SH vector, not a two-sided operator; no wave equation in the
pipeline; wrong convergence domain; wrong direction of compression), and
[`wirohsh-approximation.md`](wirohsh-approximation.md) adds a fifth (a nonzero real-analytic
function has no compact support, so the basis can never localize; Lean:
`analytic_hasCompactSupport_eq_zero`). That ruling is **not redone here**; section 6.3 only checks
what survives of the one salvage they left gated.

## 1. The solid, verified rather than repeated

The loderite `README.md:4-7` claims: only Archimedean solid that tiles space alone, Voronoi cell
of BCC, 14 neighbours (6 square + 8 hexagonal). Checking each:

**Combinatorics.** 24 vertices, 36 edges, 14 faces (6 squares, 8 regular hexagons). The face
vector forces the rest: every edge borders two faces, so $6\cdot4+8\cdot6=72=2E$ gives $E=36$;
every vertex has degree 3 (one square, two hexagons), so $3V=2E$ gives $V=24$; and

$$ V - E + F = 24 - 36 + 14 = 2. \veq{to-euler}\lean $$

It is the **permutohedron of order 4** (the 24 permutations of $(1,2,3,4)$ in the hyperplane
$\sum x_i = 10$); loderite's canonical mesh uses the equivalent presentation "all permutations of
$(0,\pm1,\pm2)$" (`src/geometry.ts`), which makes the edge length $a=\sqrt2$ world units.
(lodelore's `UNIVERSAL_EDGE_LENGTH` is **not** this quantity: `GLOSSARY.md:52` records it as a
puzzle-pwa pixel constant, 32 px, and marks loderite "n/a".)

**The tiling, derived not asserted.** Voronoi cells of *any* point lattice tile space by
construction: every point of space has a nearest lattice point, ties lie on measure-zero
bisector planes, and the lattice translations carry the cell of one site to the cell of any
other. So "the TO tiles space" reduces to "the BCC Voronoi cell *is* the TO", and that is a
theorem lodelore already machine-checks in the repo's own coordinates:
`TruncOct.lean` proves `truncOct_eq_voronoiCell` with
$\mathrm{truncOct}=\{p : |p_i|\le 2\ \forall i,\ \sum_i|p_i|\le 3\}$, exactly the intersection of
the half-spaces bisecting toward the 6 square-face neighbours (world $(\pm4,0,0)\ldots$, giving
$|p_i|\le2$) and the 8 hex-face neighbours (world $(\pm2,\pm2,\pm2)$, giving $\sum|p_i|\le3$).

**The load-bearing uniqueness claim is exactly right, under the standard convention.** The
truncated octahedron is the only one of the 13 Archimedean solids that fills 3-space by itself
(Wikipedia "Truncated octahedron"; U. Glasgow Archimedean-solids fact sheet). The precision that
matters: "Archimedean" here follows the usual convention that **excludes the two infinite
families of prisms and antiprisms**, because the hexagonal prism (and the triangular prism) is a
uniform, semiregular space-filler too. The cube is Platonic, the gyrobifastigium is a Johnson
solid, and the rhombic dodecahedron (FCC's Voronoi cell, loderite's rejected alternative) is a
Catalan solid, so none of them threatens the statement. `README.md:4-5` as worded is correct.

**Size and roundness**, for edge $a$ (numbers for loderite's $a=\sqrt2$ in parentheses):

$$ V = 8\sqrt2\,a^3\ (=32), \qquad A = (6+12\sqrt3)\,a^2\ (\approx 53.569), \veq{to-volume-area}\sympy $$

matching lodelore's proved `volume_truncOct = 32`. The isoperimetric quotient
$Q = 36\pi V^2/A^3$:

$$ Q_{\mathrm{TO}} = \frac{64\pi(30\sqrt3-37)}{3993} \approx 0.7534, \qquad
   Q_{\mathrm{cube}} = \frac{\pi}{6} \approx 0.5236, \qquad Q_{\mathrm{sphere}} = 1.
   \veq{to-isoperimetric}\sympy $$

The TO is markedly rounder than the cube: at equal volume it has 9.9% more surface than a sphere
where the cube has 24.0% more. That roundness is not free (section 5).

## 2. What 14 face-neighbours change, quantified

The neighbour graph (`faceToNeighborOffset`, a first-class engine invariant per
`ARCHITECTURE.md:50-55`) is the BCC lattice: offsets $(\pm2,0,0)$-type across squares,
$(\pm1,\pm1,\pm1)$ across hexagons, in cell coordinates; world $=2\times$ cell. Every contact is
a genuine 2D face: there are **no edge-only or corner-only contacts to adjudicate**, which is the
qualitative win over both cubic conventions (6-adjacency ignores real diagonal proximity;
26-adjacency lets paths and floods leak through zero-area corner contacts).

**The two classes have different lengths.** In world units,

$$ d_{\square} = 4 = 2\sqrt2\,a \approx 2.828\,a, \qquad
   d_{\mathrm{hex}} = 2\sqrt3 = \sqrt6\,a \approx 2.449\,a, \qquad
   \frac{d_{\mathrm{hex}}}{d_{\square}} = \frac{\sqrt3}{2} \approx 0.866.
   \veq{metric-anisotropy}\lean $$

The hexagonal-face neighbours are the *closer* class; they are BCC's true nearest neighbours
(squared cell norms 3 vs 4, `Voxel.lean: metric_anisotropic`). So the graph is vertex-transitive
but **not metrically edge-transitive**: any algorithm that treats a hop as a unit (flood fill,
BFS "distance", unweighted Dijkstra ties) is anisotropic, and any weighted algorithm must carry
two edge weights.

**The hop metric, exactly.** The two classes are also asymmetric as generators: every square
offset is a sum of two hex offsets ($(2,0,0)=(1,1,1)+(1,-1,-1)$), but no hex offset is a sum of
two square offsets, because a hex hop flips the all-even/all-odd parity class and an axis hop
never does (`Voxel.lean: axis_eq_two_diag`, `diag_ne_two_axis`). BFS over 2330 interior lattice
points confirms the closed form, in doubled coordinates with $|x|\ge|y|\ge|z|$ sorted:

$$ d_{\mathrm{hop}}(x,y,z) = \left\lceil \frac{|x|+|y|}{2} \right\rceil
   \veq{hop-formula}\numeric $$

(half the sum of the two largest coordinates, rounded up; 0 mismatches in 2330). The critical
case pinning it against the tempting $\lceil\max|x_i|/2\rceil$ is $(4,2,0)$: three hops, not two,
proved as `hop3_two_hops_ne` + `hop3_three_hops` \veq{hop-metric}\lean. This formula is an exact,
admissible, $O(1)$ A* heuristic for loderite pathfinding, should it ever want one.

**Wavefront anisotropy, compared honestly.** Speed of an unweighted BFS front (world distance per
hop) by direction, and the max/min ratio:

| graph | axis | face diagonal | body diagonal | max/min |
|---|---|---|---|---|
| BCC-14 (loderite) | 4 | $2\sqrt2\approx2.83$ | $2\sqrt3\approx3.46$ | $\sqrt2\approx1.414$ |
| cubic-6 | 1 | 0.707 | 0.577 | $\sqrt3\approx1.732$ |
| cubic-26 | 1 | 1.414 | 1.732 | $\sqrt3\approx1.732$ |

BCC-14 has the roundest hop-ball of the three, but it is not round: fronts run 41% faster along
axes than along face diagonals. For **Euclidean-weighted** shortest paths (edge cost = length),
the worst-case path stretch over straight-line distance is $\sqrt{5-2\sqrt3}\approx1.239$ for
BCC-14 (worst direction in an axis plane, $\approx(0.807,0.591,0)$; verified by a
$4\times10^5$-direction sweep), vs $\approx1.128$ for cubic-26 and $\sqrt3\approx1.732$ for
cubic-6. Stated plainly rather than flattered: **cubic-26 beats BCC-14 on weighted path stretch**;
what BCC-14 buys is that every step crosses a real face (no corner-cutting through point
contacts) and a 14-entry neighbour table instead of 26 with three contact types.

## 3. Addressing, and what it costs

Same-parity triples are exactly $1/4$ of $\mathbb{Z}^3$ (all-even $1/8$ + all-odd $1/8$), so a
dense array indexed by doubled coordinates wastes 75% of its slots. The standard dense scheme is
a cubic index plus a parity bit, $c = 2(i,j,k) + s\,(1,1,1)$, $s\in\{0,1\}$, which is bijective
and waste-free; square hops keep $s$ and move $(i,j,k)\pm e_a$, hex hops flip $s$ and add
$d\in\{0,-1\}^3$ (from $s=0$) or $d\in\{0,+1\}^3$ (from $s=1$).

loderite does something different, and for visible reasons: `src/world.ts` stores a **sparse**
string-keyed `Map` as a player-edit overlay over a pure `generator(cell)`, so unbounded worlds
cost only their edits and no dense array of any shape exists to waste. The doubled-coordinate
choice buys the repo its best invariant: face centroid $=$ neighbour offset numerically
(`ARCHITECTURE.md:85-98`), because `cellToWorld = 2 x cell` cancels the bisector's $\tfrac12$.
The parity-bit scheme is worth a note only if a profiler ever demands chunk-local dense occupancy
bitmasks; the branded-type work already underway (`id:8730`, `lattice.ts:16-45`) guards the
cell/world confusion that any second representation would deepen.

## 4. Rendering cost of roundness, and the greedy-meshing surprise

A fully exposed cell needs 44 triangles (6 squares at 2 + 8 hexagons at 4) against a cube's 12.
Normalizing to equal volume 32 (cube side $32^{1/3}$, area $\approx60.48$): 0.82 vs 0.20
triangles per unit surface area, a factor of $\approx4.1$ before any merging.

In cube worlds the standard rescue is greedy meshing: coplanar, same-normal, adjacent faces merge
into large quads. **On whole TO cells this optimization does not exist at all.** Computed over a
$5^3$-cell block, enumerating every face of every cell and grouping by exact oriented plane:
coplanar same-normal faces from distinct cells never share an edge, 0 mergeable pairs
\veq{no-greedy-merge}\numeric. The reason is visible by hand: the exposed $+x$ square faces in
the plane $x=2$ sit at in-plane centres $(4j,4k)$ with half-diagonal 1, isolated diamonds with a
gap of 2 covered by *slanted* hexagons of the odd sublattice; hexagons in one $\{111\}$ plane
are likewise isolated. Merging only becomes possible on **sub-cell cut faces**: an octant-built
flat wall lies in the 4.8.8 truncated-square tiling (`ARCHITECTURE.md:188-191`), whose octagons
and squares genuinely tile a plane. loderite's actual mitigations, face culling and run-granular
seg emission (`segRuns`, `id:3890`), are the right shape for this geometry. This contradicts one
sentence of loderite's own architecture doc; surfaced, not edited, in section 7.

## 5. Is lodelore mechanically enforced, or can the anti-drift repo itself drift?

**Finding: nothing mechanical fails when a sibling uses a term lodelore has retired.** This is
not an oversight but a recorded decision, twice over: `ARCHITECTURE.md` D2 (2026-07-11) rejects
a Markdown linter with the exact right diagnosis, that it *"would police formatting, not the
thing that actually drifts (whether the glossary still matches the siblings' code)"*
(`ARCHITECTURE.md:52-54`), and D3 makes any new toolchain an owner decision, re-affirmed when
the 2026-07-31 Lean amendment authorised "Lean and Lean only" (`:110-113`). The live defence is
procedural: D4's "cross-check the sibling repo's source before writing about it", plus
grep-based done-checks per roadmap item.

The exposure is exactly this fleet's documented derived-doc failure mode, and lodelore's own
ledger already exhibits it *internally*: the `id:cd19` gate ("no prose until f508 lands") went
stale 21 hours after its own pool run landed f508's prose, was carried forward as live, and was
caught only by a closing `--fabled` pass (TODO.md `id:cd19`, "the derived-doc-rot shape").
Discipline caught it; nothing mechanical would have.

**Smallest mechanization that respects D3, proposed for the owner to accept or reject.** Put the
enforcement in the *siblings*, which already own test runners, and keep lodelore prose:

1. lodelore `GLOSSARY.md` gains a machine-readable **retired-terms table** (term, retired date,
   replacement, one grep pattern per term). Cost: one Markdown section, maintained exactly when
   a term is retired, which is when the fact is in hand anyway. No toolchain enters lodelore.
2. loderite and puzzle-pwa each add one ~30-line Vitest test that parses that table (path
   injected, since lodelore is private-remote) and greps its own `src/` + top-level docs for
   retired terms. A hit names the replacement. yinyang-puzzle mirrors it in pytest.

Weaknesses stated with it: it is one-way (nothing checks that glossary *descriptions* of sibling
code are current, the harder half of D4, which stays procedural); it adds a cross-repo read to
sibling test runs; and the retired-terms list starts empty, so per the fleet's
observe-before-preventing rule the cheapest first step is the table alone as a **logger**, with
sibling tests added once it has entries. Candidate first entries exist: the Loderia world-name
history, and the ratified "octant" vs "Lodule" usage split (`loderite/ARCHITECTURE.md:157-165`).

## 6. Speculative half. Clearly labelled: none of this is a finding

**6.1 The sampling-lattice angle checks out and is worth one experiment.** BCC is the lattice
$A_3^*$, and it is the optimal sampling lattice for isotropically band-limited 3D signals: its
reciprocal lattice is FCC, whose sphere packing is the densest lattice packing, so spectrum
replicas pack tightest. The saving over Cartesian sampling at equal band limit is exactly

$$ \frac{n_{\mathrm{BCC}}}{n_{\mathrm{CC}}} = \frac{\pi/6}{\pi/\sqrt{18}} = \frac{\sqrt2}{2}
   \approx 0.707, \veq{sampling-ratio}\sympy $$

29.3% fewer samples ("about 30%" is the honest rounding). The speculation: loderite's world
already lives on the optimal sampling lattice, so any per-cell scalar field it ever wants (baked
AO, light probes, an SDF, LOD density) gets the $A_3^*$ advantage for free, with reconstruction
filters (BCC box-splines) ready in the volume-rendering literature. Decidable cheaply: sample a
band-limited light field at equal sample count on BCC vs cubic in `benchmark.html`'s harness and
compare RMS reconstruction error; theory predicts BCC wins at fixed budget.

**6.2 Greedy meshing with two face classes.** Section 4 shows the classic algorithm is void on
whole cells, so the speculative question inverts: is there a TO-native merge at all? The only
coplanar-adjacent surfaces in the system are 4.8.8 sub-cell walls (octant cut faces) and seg cut
faces; a polygon-union pass over those planes could merge a flat wall's octagons and squares
into large polygons. Decidable by counting: instrument `chunkmesh.ts` on a representative flat
build and report what fraction of emitted triangles lie in axis-aligned cut planes; if the
fraction is small, the idea is dead on arrival and the culling story is complete as is.

**6.3 The `id:ff32` salvage, checked against loderite's actual renderer.** The sibling essays
left one gated salvage: a per-primitive T-matrix in a Wick-rotated basis becomes coherent *"if
loderite ever needs genuine wave behaviour"* (diffraction, acoustics, an RF forward model).
Reading the renderer: three.js rasterization, alpha compositing, geometric optics throughout; no
Helmholtz problem exists or is planned anywhere in `ARCHITECTURE.md` or the ledgers. **The gate
is not met.** What *does* survive is unrelated to WiRoHSH: `id:2ba7`'s precompute-per-config
library stands on its own (finite {octant config} x {material} space, edit = lookup), but its
analogy anchor should be precomputed radiance transfer (Sloan et al. 2002), the one-sided
precompute the pipeline actually needs, not the two-sided T-matrix, per break 1 of the splats
essay. Recommendation (owner's call, in loderite's ledger, not mine to file): mark `id:ff32`'s
salvage branch dormant with its gate spelled out, and drop the "WiRoHSH as candidate compact
basis" clause from `id:2ba7` (`TODO.md:271`), citing the five recorded breaks.

## 7. Surfaced for the owner (located; nothing edited, nothing filed)

1. **`loderite/ARCHITECTURE.md:75-77`**: "square faces can be greedy-merged, hex faces never
   can". Section 4's census finds *no* coplanar same-normal edge-adjacent whole-cell faces of
   either class, so as written the square half appears false. If it means cut-face merging
   inside 4.8.8 walls it is defensible; the repo may also have a reading I cannot see.
2. **`loderite/TODO.md:271` (`id:2ba7`)**: the "Hyper-spherical harmonics (WiRoHSH, toesnail) are
   a candidate compact BASIS" clause is contradicted by five independent recorded breaks
   (`wirohsh-splats.md` section 4; `wirohsh-approximation.md` section 3.2, no compact support).
   The precompute-library idea itself is untouched by all five.
3. **toesnail `ROADMAP.md` `id:ff32`**: the salvage gate ("loderite needs wave behaviour") is
   not met by loderite's current or planned renderer (section 6.3); evidence now seems complete
   for the owner's disposition ruling on the split the splats essay proposed.
4. **lodelore enforcement gap** (section 5): deliberate per D2/D3, but the repo's own `id:cd19`
   stale-gate incident shows the drift class is live; the retired-terms table + sibling-side
   tests is the smallest mechanization, offered with its weaknesses. Owner decides which side of
   D3 this falls on.
5. **`loderite/README.md:4-5`** is confirmed exactly right under the standard 13-Archimedean
   convention (prisms/antiprisms excluded); no change needed, recorded here so nobody "fixes" it.

## 8. Follow-up leads

1. (loderite) Adopt $\lceil(|x|{+}|y|)/2\rceil$ (two largest coords) as the A* heuristic and
   admissibility test; decidable by a property test against BFS on random cell pairs.
2. (loderite) The BCC-sampling experiment of 6.1; decidable by one benchmark scene comparing
   reconstruction error at equal sample count.
3. (loderite) The cut-plane triangle census of 6.2; decidable by instrumenting `chunkmesh.ts` on
   a flat-wall build.
4. (lodelore) Start the retired-terms table as a logger only; decidable after 2-4 weeks by
   whether it accumulates entries, per the observe-before-preventing rule.
5. (shared, owner) Rule on `id:ff32`'s disposition and `id:2ba7`'s WiRoHSH clause together, since
   the same five breaks decide both; decidable now, all evidence cited above.

## Lean attestation

Proved in [`docs/dreamed/lean/Voxel.lean`](lean/Voxel.lean), namespace `Voxel`. Written after
reading `~/src/lodelore/lean/LodeloreGeometry/` (which already proves the 14-offset count, the
same-parity closure, `cellToWorld`, the Voronoi identity, volume 32); **none of that is
duplicated**, and the file's header lists it. What this file adds:

| handle | theorems | content |
|---|---|---|
| `to-euler` | `faceVector`, `edge_handshake`, `vertex_handshake`, `euler` | $6+8=14$; $6\cdot4+8\cdot6=2\cdot36$; $3\cdot24=2\cdot36$; $24-36+14=2$ over ℤ |
| `offsets-distinct` | `neighborOffsets_nodup` | the 14 offsets are pairwise distinct (lodelore proves length, not distinctness) |
| `offsets-symmetric` | `offsets_neg_closed`, `offsets_ne_zero` | closed under negation; no offset is zero |
| `metric-anisotropy` | `axis_sqNorm`, `diag_sqNorm`, `metric_anisotropic`, `sqNorm_dbl` | squared norms 4 vs 3 in cell coords; every hex neighbour strictly closer; world scales by 4 |
| `hop-metric` | `axis_eq_two_diag`, `diag_ne_two_axis`, `hop3_not_one`, `hop3_two_hops_ne`, `hop3_three_hops` | axis = two hex hops, never conversely; $(4,2,0)$ needs exactly three hops |

Checked with:

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Voxel.lean
```

**Exit status 0**, zero `sorry`, zero warnings (2026-09-01). The general hop formula
\veq{hop-formula}\numeric is deliberately **not** proved in Lean, only its critical case; the
formula's evidence is the 2330-point BFS below. The `\veq` badges here attest this dreamed Lean
file and the recorded computations only, never the repo's sidecar machinery.

## Computation record

```computation
# truncated octahedron, edge a; loderite world units have a = sqrt(2)
V_to  = 8*sqrt(2)*a**3                     # = 32 at a = sqrt(2); matches lodelore volume_truncOct
A_to  = (6 + 12*sqrt(3))*a**2              # ~ 53.569 at a = sqrt(2)
Q_to  = 36*pi*V_to**2 / A_to**3            # = 64*pi*(30*sqrt(3)-37)/3993 ~ 0.7534
Q_cube = pi/6                              # ~ 0.5236
d_square = 2*sqrt(2)*a                     # world 4     (cell offset (2,0,0), |.|^2 = 4)
d_hex    = sqrt(6)*a                       # world 2*sqrt(3) (cell offset (1,1,1), |.|^2 = 3)
sampling = (pi/6) / (pi/sqrt(18))          # = sqrt(2)/2 ~ 0.707: BCC needs 29.3% fewer samples
```

Numerics (sympy/numpy, run 2026-09-01, not committed): BFS on the 14-offset graph, 2330 interior
points, 0 mismatches against the hop formula; weighted-stretch sweep over $4\times10^5$
directions (BCC-14 worst $\sqrt{5-2\sqrt3}\approx1.239$, cubic-26 $\approx1.128$, cubic-6
$\sqrt3$); coplanarity census over $5^3$ cells, 0 same-normal coplanar edge-sharing face pairs
from distinct cells (sanity: interface faces of neighbour pairs coincide exactly).

Sources for section 1's uniqueness claim:
[Wikipedia, Truncated octahedron](https://en.wikipedia.org/wiki/Truncated_octahedron);
[U. Glasgow, Archimedean solids facts](https://www.gla.ac.uk/media/Media_954136_smxx.pdf);
[matematicasvisuales](http://www.matematicasvisuales.com/english/html/geometry/space/truncatedoctahedrontessela.html).
