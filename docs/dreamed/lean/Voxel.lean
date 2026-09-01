/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/loderite-lodelore.md` (owner seed: "dream on
  Loderite/lodelore as well"). Sources transcribed, never invented:

    ~/src/loderite/src/lattice.ts        (AXIS_OFFSETS lines 48-55, DIAGONAL_OFFSETS 58-67,
                                          cellToWorld = 2 x cell, line 109-111)
    ~/src/loderite/ARCHITECTURE.md       (doubled same-parity coordinates, the 14 neighbours)
    ~/src/lodelore/lean/LodeloreGeometry (read before writing this file, to avoid duplication)

  WHAT LODELORE'S OWN LEAN DEVELOPMENT ALREADY PROVES (checked 2026-09-01 at
  `~/src/lodelore/lean/LodeloreGeometry/`, no `sorry` anywhere):
    - `Lattice.lean`: `neighborOffsets_length = 14` (6 + 8), `neighborOffsets_mem_cellLattice`
      (every offset preserves the same-parity invariant), `neighbor_mem_cellLattice`,
      `cellToWorld = 2 • cellPoint`, the lattice as an `AddSubgroup` (kernel of a parity hom).
    - `TruncOct.lean`: `truncOct_eq_voronoiCell` (the cell IS the BCC Voronoi cell -- the
      load-bearing tiling fact), the 24 vertices, `faceCentre_eq_half_cellToWorld`.
    - `Dissection.lean`: `volume_truncOct = 32`.  `SecondMoment.lean`: rank-2 isotropy.
  NONE of that is restated here.  This file adds ONLY what lodelore does not state:

  1. `faceVector`, `edge_handshake`, `vertex_handshake`, `euler`
       (handle `to-euler`)   the face-vector arithmetic: 6 squares + 8 hexagons = 14 faces,
       the degree handshakes 6*4 + 8*6 = 72 = 2*36 and 3*24 = 72 forcing E = 36 and V = 24,
       and Euler 24 - 36 + 14 = 2.  Stated over the INTEGERS: Nat subtraction truncates.
  2. `neighborOffsets_nodup`  (handle `offsets-distinct`)   lodelore proves the LIST has
       length 14; this proves its entries are pairwise DISTINCT, so together the cell really
       has fourteen different neighbours.
  3. `offsets_neg_closed`, `offsets_ne_zero`  (handle `offsets-symmetric`)   the adjacency
       relation is symmetric and irreflexive -- loderite/ARCHITECTURE.md line 73-74 states
       the negation closure as a corollary in prose; here it is a decidable theorem.
  4. `axis_sqNorm`, `diag_sqNorm`, `metric_anisotropic`, `sqNorm_dbl`
       (handle `metric-anisotropy`)   THE CENTREPIECE: the 6 square-face offsets have squared
       length 4 and the 8 hex-face offsets squared length 3 in cell coordinates (16 vs 12 in
       world coordinates, `sqNorm_dbl` carrying the factor 2^2 = 4), so the neighbour graph is
       vertex-transitive but NOT metrically edge-transitive: two edge classes, two lengths.
  5. `axis_eq_two_diag`, `diag_ne_two_axis`, `hop3_not_one`, `hop3_two_hops_ne`,
       `hop3_three_hops`  (handle `hop-metric`)   the hop asymmetry: every square-face offset
       is a sum of two hex-face offsets, no hex-face offset is a sum of two square-face
       offsets (a hex hop flips the even/odd parity class, axis hops never do), and the cell
       (4,2,0) needs exactly three hops -- the witness that hop distance is NOT
       ceil(max|coord|/2).  The general hop formula d = ceil((sum of the two largest
       |coords|)/2) is OUT OF SCOPE here: it is verified numerically (BFS, 2330 interior
       points) in the essay's computation block, not proved.

  Identifier mapping (loderite naming):
    `Cell`            <-> loderite `Cell` (doubled integer cell coordinates, same-parity)
    `axisOffsets`     <-> `AXIS_OFFSETS`      (square-face neighbours)
    `diagOffsets`     <-> `DIAGONAL_OFFSETS`  (hexagonal-face neighbours)
    `dbl`             <-> `cellToWorld` (world = 2 x cell); `sqNorm` = squared Euclidean norm
-/
import Mathlib.Data.List.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace Voxel

/-! ## 1. Face vector and Euler formula (handle `to-euler`) -/

/-- 6 square faces + 8 hexagonal faces = 14 faces. -/
theorem faceVector : (6 : ℤ) + 8 = 14 := by norm_num

/-- Degree handshake over faces: 6 squares contribute 4 edges each, 8 hexagons 6 each,
every edge shared by exactly 2 faces: `6*4 + 8*6 = 72 = 2*E`, forcing `E = 36`. -/
theorem edge_handshake : (6 * 4 + 8 * 6 : ℤ) = 2 * 36 := by norm_num

/-- Every truncated-octahedron vertex has degree 3 (one square, two hexagons):
`3*V = 2*E`, forcing `V = 24` from `E = 36`. -/
theorem vertex_handshake : (3 * 24 : ℤ) = 2 * 36 := by norm_num

/-- Euler: `V - E + F = 24 - 36 + 14 = 2`.  Over ℤ deliberately -- the Nat reading of
`24 - 36` would truncate to `0` and the statement would be false-but-provable-looking. -/
theorem euler : (24 : ℤ) - 36 + 14 = 2 := by norm_num

/-! ## 2. The offsets, verbatim from `loderite/src/lattice.ts` -/

/-- A cell address in loderite's doubled integer coordinates. -/
abbrev Cell : Type := ℤ × ℤ × ℤ

/-- Componentwise sum (one graph hop). -/
def add (a b : Cell) : Cell := (a.1 + b.1, a.2.1 + b.2.1, a.2.2 + b.2.2)

/-- Componentwise negation. -/
def neg (a : Cell) : Cell := (-a.1, -a.2.1, -a.2.2)

/-- `cellToWorld`: world coordinates are twice cell coordinates (`lattice.ts:109`). -/
def dbl (a : Cell) : Cell := (2 * a.1, 2 * a.2.1, 2 * a.2.2)

/-- Squared Euclidean norm of a cell vector. -/
def sqNorm (a : Cell) : ℤ := a.1 * a.1 + a.2.1 * a.2.1 + a.2.2 * a.2.2

/-- `AXIS_OFFSETS` -- the 6 square-face neighbour offsets (`lattice.ts:48-55`). -/
def axisOffsets : List Cell :=
  [(2, 0, 0), (-2, 0, 0), (0, 2, 0), (0, -2, 0), (0, 0, 2), (0, 0, -2)]

/-- `DIAGONAL_OFFSETS` -- the 8 hexagonal-face neighbour offsets (`lattice.ts:58-67`). -/
def diagOffsets : List Cell :=
  [(1, 1, 1), (1, 1, -1), (1, -1, 1), (1, -1, -1),
   (-1, 1, 1), (-1, 1, -1), (-1, -1, 1), (-1, -1, -1)]

/-- `NEIGHBOR_OFFSETS` -- all 14. -/
def neighborOffsets : List Cell := axisOffsets ++ diagOffsets

/-! ## 3. Distinctness and symmetry (handles `offsets-distinct`, `offsets-symmetric`) -/

/-- The 14 offsets are pairwise distinct.  Complements (does not restate) lodelore's
`neighborOffsets_length = 14`: length + Nodup = exactly fourteen different neighbours. -/
theorem neighborOffsets_nodup : neighborOffsets.Nodup := by decide

/-- The offset set is closed under negation, so cell adjacency is symmetric
(`loderite/ARCHITECTURE.md:73-74`, stated there as prose). -/
theorem offsets_neg_closed : ∀ o ∈ neighborOffsets, neg o ∈ neighborOffsets := by decide

/-- No offset is zero: a cell is never its own neighbour. -/
theorem offsets_ne_zero : ∀ o ∈ neighborOffsets, o ≠ ((0, 0, 0) : Cell) := by decide

/-! ## 4. Metric anisotropy (handle `metric-anisotropy`) -/

/-- Every square-face offset has squared cell-length 4 (world: 16, i.e. distance 4). -/
theorem axis_sqNorm : ∀ o ∈ axisOffsets, sqNorm o = 4 := by decide

/-- Every hexagonal-face offset has squared cell-length 3 (world: 12, i.e. distance 2*sqrt 3).
The hex neighbours are the NEARER class -- they are BCC's true nearest neighbours. -/
theorem diag_sqNorm : ∀ o ∈ diagOffsets, sqNorm o = 3 := by decide

/-- The two neighbour classes have different lengths: every hex-face neighbour is strictly
closer than every square-face neighbour.  The graph is vertex-transitive but not
metrically edge-transitive; a uniform-cost search on it is anisotropic. -/
theorem metric_anisotropic :
    ∀ oa ∈ axisOffsets, ∀ od ∈ diagOffsets, sqNorm od < sqNorm oa := by decide

/-- `world = 2 x cell` scales squared norms by 4: the world-space gaps are 16 vs 12. -/
theorem sqNorm_dbl (a : Cell) : sqNorm (dbl a) = 4 * sqNorm a := by
  unfold sqNorm dbl; ring

/-! ## 5. Hop asymmetry (handle `hop-metric`) -/

/-- Every square-face offset is the sum of two hexagonal-face offsets:
e.g. `(2,0,0) = (1,1,1) + (1,-1,-1)`.  The hex class generates the axis class. -/
theorem axis_eq_two_diag :
    ∀ oa ∈ axisOffsets, ∃ d₁ ∈ diagOffsets, ∃ d₂ ∈ diagOffsets, add d₁ d₂ = oa := by decide

/-- No hexagonal-face offset is a sum of two square-face offsets: an axis hop keeps the
even/odd parity class, a hex hop flips it, and two axis hops therefore land all-even. -/
theorem diag_ne_two_axis :
    ∀ od ∈ diagOffsets, ∀ a₁ ∈ axisOffsets, ∀ a₂ ∈ axisOffsets, add a₁ a₂ ≠ od := by decide

/-- `(4,2,0)` is not a neighbour ... -/
theorem hop3_not_one : ((4, 2, 0) : Cell) ∉ neighborOffsets := by decide

/-- ... and not reachable in two hops ... -/
theorem hop3_two_hops_ne :
    ∀ o₁ ∈ neighborOffsets, ∀ o₂ ∈ neighborOffsets, add o₁ o₂ ≠ ((4, 2, 0) : Cell) := by
  decide

/-- ... but reachable in three: `(2,0,0) + (1,1,1) + (1,1,-1) = (4,2,0)`.  So hop distance
is 3 where `ceil(max|coord|/2)` would say 2 -- the witness pinning the essay's BFS-verified
formula `d = ceil((sum of two largest |coords|)/2)` on its critical case. -/
theorem hop3_three_hops :
    ∃ o₁ ∈ neighborOffsets, ∃ o₂ ∈ neighborOffsets, ∃ o₃ ∈ neighborOffsets,
      add (add o₁ o₂) o₃ = ((4, 2, 0) : Cell) := by decide

end Voxel
