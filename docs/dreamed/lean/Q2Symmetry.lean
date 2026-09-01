/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`.

  Lean attestation for `docs/dreamed/q2-galilei-vs-poincare.md`, seeded from the
  owner's OPEN question Q2/D2 in `TODO.md` (`id:57e2`) and
  `docs/meeting-notes/2026-07-07-1228-toe-roadmap-evaluation.md` §7 D2:
  should the TOESNAIL spine build spacetime symmetry Galilei-first, Poincare-first,
  or hybrid?

  The essay's claim is that the branch-deciding fact is ALGEBRAIC and small enough to
  be checked, not a matter of taste. This file checks it.

  Everything below lives in 1+1 dimensions (one time, one space), which is the
  smallest setting in which the boost/translation commutator exists at all.
  The 1+1 restriction is a real weakening and is stated as such in the essay:
  in 3+1 the Poincare algebra is semisimple-plus-abelian with H^2 = 0 outright,
  while here a residual class survives (see `dim_H2_poincare_is_one` below).
  What survives the restriction is the ONE thing the branch decision turns on:
  the boost/translation central term is a coboundary for Poincare and is not one
  for Galilei.

  Notation map (physics <-> Lean). The abstract algebra is spanned by
      H  time translation   (energy generator)
      P  space translation  (momentum generator)
      K  boost
      M  the central mass generator (Bargmann), when present
  and a vector `X : Vec` records the coordinates `X.h, X.p, X.k` of
  `X = X.h * H + X.p * P + X.k * K`.

  Structure constants, with `eps` standing for `1/c^2`:
      [K,H] = P            (a boost of a time translation is a space translation)
      [K,P] = eps * H      (Poincare; `eps = 0` is Galilei)
      [H,P] = 0
  This is the matrix-representation sign convention. The vector-field realisation
  `H = d_t`, `P = d_x`, `K = t d_x + eps * x d_t` gives the same constants with an
  overall sign flip (the vector-field bracket is an ANTI-homomorphism); nothing below
  depends on the choice, and the essay states it once.

  Derivative-name convention (owner's, `CLAUDE.md` memory `lean-derivative-naming`):
  a derivative is `f_x`, the subscript naming the differentiation variable. No
  derivatives appear in this file, so the convention is inert here; it is recorded so
  a later extension does not invent `xd`.

  WHAT IS PROVED
  --------------
  1. `jacobi_h/p/k`      the one-parameter family of brackets is a Lie bracket for
                         every `eps`, so both endpoints of the contraction are real
                         Lie algebras and nothing is smuggled in at `eps = 0`.
  2. `contraction`       `eps = 0` returns EXACTLY the Galilei brackets. This is the
                         Inonu-Wigner contraction as an identity of structure
                         constants, not a limit of representations.
  3. `cochain_is_always_a_cocycle`
                         every antisymmetric 2-cochain on this algebra satisfies the
                         2-cocycle (Bargmann) condition, for every `eps`. So `Z^2` is
                         all of the 3-dimensional cochain space and the whole content
                         of `H^2` sits in which cochains are COBOUNDARIES.
  4. `poincare_KP_is_a_coboundary`
                         for `eps <> 0` the boost/translation central term `b` is
                         `delta f` for an explicit `f`. It can be absorbed into a
                         redefinition of the generators: Poincare needs no new
                         generator.
  5. `galilei_KP_coboundary_vanishes` and `galilei_mass_is_not_a_coboundary`
                         for `eps = 0` EVERY coboundary has zero boost/translation
                         component, so a nonzero mass `m` is a nontrivial class. The
                         Galilei central charge is unavoidable.
  6. `bargmann_*`        an explicit faithful 4x4 real matrix model of the extended
                         (Bargmann) Galilei algebra: `[K,H] = P`, `[K,P] = M`,
                         `[H,P] = 0`, `M` central, and `M` NOT in the span of
                         `H, P, K`. The extra generator is genuinely extra.
  7. `casimir_*`         `ad_K` acting as a derivation on quadratics in `H, P`; the
                         Poincare Casimir `eps*H^2 - P^2` (i.e. `H^2/c^2 - P^2`,
                         the mass-shell) is annihilated, is the unique such quadratic
                         up to scale, and at `eps = 0` every annihilated quadratic has
                         zero `H^2` coefficient: the contracted Casimir is blind to
                         energy, which is why Galilei must recover mass elsewhere.

  WHAT IS EXPLICITLY OUT OF SCOPE
  -------------------------------
  - Group cohomology proper. `H^2(g, R)` is modelled here by hand as an explicit
    3-parameter cochain space with an explicit coboundary map, not via Mathlib's
    Lie-algebra cohomology. The dimension statements below are therefore statements
    about THIS model.
  - Projective unitary representations, Wigner's theorem, and the passage from a
    group 2-cocycle to a Lie-algebra 2-cocycle. Not touched.
  - The mass superselection rule. It follows from the central charge in the
    representation theory; no representation theory appears here.
  - 3+1 dimensions, rotations, `W^2`, the little groups, Wigner's classification.
    The `casimir_*` block is a coefficient model of `ad_K` on quadratics, not the
    universal enveloping algebra.
  - Any claim that the essay's RECOMMENDATION follows from these theorems. It does
    not. The theorems fix the cost of one branch; the choice is the owner's.

  Companion SymPy run (all statements below were first checked numerically/symbolically
  there): see the ```computation block in the essay.
-/
import Mathlib.Data.Real.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum

namespace Q2Symmetry

/-! ## 1. The one-parameter spacetime algebra -/

/-- A point of the 3-dimensional real Lie algebra spanned by `H, P, K`:
    `X = X.h * H + X.p * P + X.k * K`. -/
@[ext]
structure Vec where
  h : ℝ
  p : ℝ
  k : ℝ

/-- Basis vector `H` (time translation / energy generator). -/
def eH : Vec := ⟨1, 0, 0⟩
/-- Basis vector `P` (space translation / momentum generator). -/
def eP : Vec := ⟨0, 1, 0⟩
/-- Basis vector `K` (boost). -/
def eK : Vec := ⟨0, 0, 1⟩

/-- The bracket of the 1+1 spacetime algebra with deformation parameter
    `eps = 1/c^2`: `[K,H] = P`, `[K,P] = eps*H`, `[H,P] = 0`, extended bilinearly
    and antisymmetrically. `eps = 1` is Poincare in units `c = 1`; `eps = 0` is
    Galilei. -/
def br (eps : ℝ) (X Y : Vec) : Vec :=
  ⟨eps * (X.k * Y.p - X.p * Y.k), X.k * Y.h - X.h * Y.k, 0⟩

@[simp] lemma br_h (eps : ℝ) (X Y : Vec) :
    (br eps X Y).h = eps * (X.k * Y.p - X.p * Y.k) := rfl
@[simp] lemma br_p (eps : ℝ) (X Y : Vec) :
    (br eps X Y).p = X.k * Y.h - X.h * Y.k := rfl
@[simp] lemma br_k (eps : ℝ) (X Y : Vec) : (br eps X Y).k = 0 := rfl

@[simp] lemma eH_h : eH.h = 1 := rfl
@[simp] lemma eH_p : eH.p = 0 := rfl
@[simp] lemma eH_k : eH.k = 0 := rfl
@[simp] lemma eP_h : eP.h = 0 := rfl
@[simp] lemma eP_p : eP.p = 1 := rfl
@[simp] lemma eP_k : eP.k = 0 := rfl
@[simp] lemma eK_h : eK.h = 0 := rfl
@[simp] lemma eK_p : eK.p = 0 := rfl
@[simp] lemma eK_k : eK.k = 1 := rfl

/-- The three structure constants, read off the definition: `[K,H] = P`. -/
theorem br_K_H (eps : ℝ) : br eps eK eH = eP := by
  ext <;> simp
/-- `[K,P] = eps * H`.  This is the whole question in one line: the boost/translation
    commutator lands on the EXISTING generator `H`, with coefficient `1/c^2`. -/
theorem br_K_P (eps : ℝ) : br eps eK eP = ⟨eps, 0, 0⟩ := by
  ext <;> simp
/-- `[H,P] = 0`: translations commute. -/
theorem br_H_P (eps : ℝ) : br eps eH eP = ⟨0, 0, 0⟩ := by
  ext <;> simp

/-- Antisymmetry, for every `eps`. -/
theorem br_antisymm (eps : ℝ) (X Y : Vec) : br eps X Y = ⟨-(br eps Y X).h, -(br eps Y X).p, 0⟩ := by
  ext <;> simp <;> ring

/-- Jacobi identity, `h` component, for every `eps`. -/
theorem jacobi_h (eps : ℝ) (X Y Z : Vec) :
    (br eps (br eps X Y) Z).h + (br eps (br eps Y Z) X).h + (br eps (br eps Z X) Y).h = 0 := by
  simp; ring

/-- Jacobi identity, `p` component, for every `eps`. -/
theorem jacobi_p (eps : ℝ) (X Y Z : Vec) :
    (br eps (br eps X Y) Z).p + (br eps (br eps Y Z) X).p + (br eps (br eps Z X) Y).p = 0 := by
  simp; ring

/-- Jacobi identity, `k` component (trivially, the bracket never has a boost part). -/
theorem jacobi_k (eps : ℝ) (X Y Z : Vec) :
    (br eps (br eps X Y) Z).k + (br eps (br eps Y Z) X).k + (br eps (br eps Z X) Y).k = 0 := by
  simp

/-! ## 2. The Inonu-Wigner contraction

The Galilei bracket, written independently, and the theorem that it is exactly the
`eps = 0` member of the family. -/

/-- The 1+1 Galilei bracket, defined on its own terms: `[K,H] = P` and nothing else. -/
def galBr (X Y : Vec) : Vec := ⟨0, X.k * Y.h - X.h * Y.k, 0⟩

/-- **Inonu-Wigner contraction.** Setting `1/c^2 = 0` in the Poincare structure
    constants gives exactly the Galilei structure constants. An identity, not a limit. -/
theorem contraction (X Y : Vec) : br 0 X Y = galBr X Y := by
  ext <;> simp [galBr]

/-- The contracted boost/translation commutator vanishes: classically, a Galilei boost
    commutes with a space translation. -/
theorem galilei_br_K_P : br 0 eK eP = ⟨0, 0, 0⟩ := by
  ext <;> simp

/-! ## 3. Two-cocycles and coboundaries

A 2-cochain is an antisymmetric bilinear form, fixed by its three values on basis
pairs: `a = w(K,H)`, `b = w(K,P)`, `d = w(H,P)`. -/

/-- The antisymmetric 2-cochain with `w(K,H) = a`, `w(K,P) = b`, `w(H,P) = d`. -/
def om (a b d : ℝ) (X Y : Vec) : ℝ :=
  d * (X.h * Y.p - X.p * Y.h) + a * (X.k * Y.h - X.h * Y.k) + b * (X.k * Y.p - X.p * Y.k)

@[simp] lemma om_K_H (a b d : ℝ) : om a b d eK eH = a := by simp [om]
@[simp] lemma om_K_P (a b d : ℝ) : om a b d eK eP = b := by simp [om]
@[simp] lemma om_H_P (a b d : ℝ) : om a b d eH eP = d := by simp [om]

/-- The coboundary of the linear functional `f` with `f(H) = fh`, `f(P) = fp`,
    `f(K) = fk`: `(delta f)(X,Y) = -f([X,Y])`. -/
def cob (eps fh fp fk : ℝ) (X Y : Vec) : ℝ :=
  -(fh * (br eps X Y).h + fp * (br eps X Y).p + fk * (br eps X Y).k)

/-- **Every antisymmetric 2-cochain on this algebra is a 2-cocycle**, for every `eps`.
    The Bargmann/Jacobi cocycle condition
    `w([X,Y],Z) + w([Y,Z],X) + w([Z,X],Y) = 0`
    holds identically, so `Z^2` is the full 3-parameter cochain space and all of `H^2`
    is decided by the coboundaries. -/
theorem cochain_is_always_a_cocycle (eps a b d : ℝ) (X Y Z : Vec) :
    om a b d (br eps X Y) Z + om a b d (br eps Y Z) X + om a b d (br eps Z X) Y = 0 := by
  simp [om]; ring

/-- The coboundary map read off on basis pairs: `(delta f)(K,H) = -fp`. -/
@[simp] theorem cob_K_H (eps fh fp fk : ℝ) : cob eps fh fp fk eK eH = -fp := by
  simp [cob]
/-- `(delta f)(K,P) = -eps * fh`.  The `eps` in front is the entire asymmetry. -/
@[simp] theorem cob_K_P (eps fh fp fk : ℝ) : cob eps fh fp fk eK eP = -(eps * fh) := by
  simp [cob]; ring
/-- `(delta f)(H,P) = 0`: no functional can ever produce a translation/translation
    central term, in either algebra. -/
@[simp] theorem cob_H_P (eps fh fp fk : ℝ) : cob eps fh fp fk eH eP = 0 := by
  simp [cob]

/-! ### 3a. Poincare: the boost/translation central term is removable -/

/-- **Poincare (`eps <> 0`): the boost/translation cocycle is a coboundary.**
    For any central charge `b` the cochain `w(K,H) = 0`, `w(K,P) = b`, `w(H,P) = 0`
    equals `delta f` for the explicit functional `f(H) = -b/eps`, `f(P) = f(K) = 0`.
    Physically: the would-be central term is absorbed by shifting the energy
    generator, so Poincare needs no extra generator. -/
theorem poincare_KP_is_a_coboundary (eps b : ℝ) (heps : eps ≠ 0) (X Y : Vec) :
    cob eps (-b / eps) 0 0 X Y = om 0 b 0 X Y := by
  simp [cob, om]
  field_simp

/-- The same statement in its bluntest form on the basis pair that matters. -/
theorem poincare_KP_is_a_coboundary_basis (eps b : ℝ) (heps : eps ≠ 0) :
    cob eps (-b / eps) 0 0 eK eP = b := by
  simp [cob]
  field_simp

/-- In this model the coboundary map `f |-> delta f` hits `(a, b, 0)` for `eps <> 0`,
    i.e. its image is 2-dimensional, so `dim H^2 = 3 - 2 = 1`, the surviving class
    being the translation/translation one `w(H,P)`. Stated here as the surjectivity
    onto the first two slots. -/
theorem dim_H2_poincare_is_one (eps a b : ℝ) (heps : eps ≠ 0) :
    ∃ fh fp fk : ℝ, cob eps fh fp fk eK eH = a ∧ cob eps fh fp fk eK eP = b
      ∧ cob eps fh fp fk eH eP = 0 := by
  refine ⟨-b / eps, -a, 0, by simp, ?_, by simp⟩
  simp [cob]
  field_simp

/-! ### 3b. Galilei: the mass class is unavoidable -/

/-- Every Galilei coboundary has zero boost/translation component, because
    `[K,P] = 0` there and a coboundary can only see brackets. -/
theorem galilei_KP_coboundary_vanishes (fh fp fk : ℝ) : cob 0 fh fp fk eK eP = 0 := by
  simp [cob]

/-- **Galilei: a nonzero mass is a nontrivial cohomology class.**
    No linear functional `f` has `delta f` equal to the cochain with `w(K,P) = m`
    for `m <> 0`. The central charge cannot be absorbed into a redefinition of the
    generators, so the Galilei algebra a quantum theory actually represents is the
    4-generator Bargmann algebra, not the 3-generator Galilei one. -/
theorem galilei_mass_is_not_a_coboundary (m : ℝ) (hm : m ≠ 0) (fh fp fk : ℝ) :
    ¬ (∀ X Y : Vec, cob 0 fh fp fk X Y = om 0 m 0 X Y) := by
  intro hall
  have h := hall eK eP
  rw [galilei_KP_coboundary_vanishes, om_K_P] at h
  exact hm h.symm

/-- The contrast in one theorem: the SAME cochain (`w(K,P) = m`, `m <> 0`) is a
    coboundary when `eps <> 0` and is not one when `eps = 0`. -/
theorem branch_asymmetry (m : ℝ) (hm : m ≠ 0) :
    (∃ fh fp fk : ℝ, ∀ X Y : Vec, cob 1 fh fp fk X Y = om 0 m 0 X Y)
    ∧ (¬ ∃ fh fp fk : ℝ, ∀ X Y : Vec, cob 0 fh fp fk X Y = om 0 m 0 X Y) := by
  constructor
  · exact ⟨-m / 1, 0, 0, fun X Y => poincare_KP_is_a_coboundary 1 m one_ne_zero X Y⟩
  · rintro ⟨fh, fp, fk, hall⟩
    exact galilei_mass_is_not_a_coboundary m hm fh fp fk hall

/-! ## 4. Explicit 4x4 matrix model of the Bargmann algebra

The abstract statement above says a fourth generator is needed. Here it is,
concretely and faithfully: real 4x4 matrices acting on `(t, x, xi, 1)`, where `xi` is
the extra coordinate whose translations the central generator `M` implements. -/

open Matrix

/-- `H`, time translation: the elementary matrix `E(0,3)`. -/
def Hm : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,0,1; 0,0,0,0; 0,0,0,0; 0,0,0,0]
/-- `P`, space translation: `E(1,3)`. -/
def Pm : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,0,0; 0,0,0,1; 0,0,0,0; 0,0,0,0]
/-- `K`, the Galilei boost, extended: `E(1,0) + E(2,1)`. The `E(1,0)` part is the
    classical `x -> x + v t`; the `E(2,1)` part is the extra action on `xi` that makes
    the algebra close on `M`. -/
def Km : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,0,0; 1,0,0,0; 0,1,0,0; 0,0,0,0]
/-- `M`, the central mass generator: `E(2,3)`. -/
def Mm : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,0,0; 0,0,0,0; 0,0,0,1; 0,0,0,0]

/-- Matrix commutator. -/
def cm (A B : Matrix (Fin 4) (Fin 4) ℝ) : Matrix (Fin 4) (Fin 4) ℝ := A * B - B * A

/-- `[K,H] = P` in the matrix model. -/
theorem bargmann_K_H : cm Km Hm = Pm := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [cm, Km, Hm, Pm]

/-- **`[K,P] = M`**: the Galilei boost/translation commutator is nonzero and lands on
    a generator that is not `H`, not `P`, and not `K`. This is the central charge, and
    it is what a Poincare-first spine does not have to introduce. -/
theorem bargmann_K_P : cm Km Pm = Mm := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [cm, Km, Pm, Mm]

/-- `[H,P] = 0`. -/
theorem bargmann_H_P : cm Hm Pm = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [cm, Hm, Pm]

/-- `M` commutes with `H`. -/
theorem bargmann_M_H : cm Mm Hm = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [cm, Mm, Hm]

/-- `M` commutes with `P`. -/
theorem bargmann_M_P : cm Mm Pm = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [cm, Mm, Pm]

/-- `M` commutes with `K`. Together with the previous two: `M` is central. -/
theorem bargmann_M_K : cm Mm Km = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [cm, Mm, Km]

/-- **`M` is genuinely a new generator**: it is not any linear combination of
    `H`, `P`, `K`. Read off the `(2,3)` entry, where `H`, `P`, `K` all vanish and `M`
    is `1`. -/
theorem bargmann_M_not_in_span (a b c : ℝ) : a • Hm + b • Pm + c • Km ≠ Mm := by
  intro hcon
  have h := congrFun (congrFun hcon 2) 3
  simp [Hm, Pm, Km, Mm] at h

/-! ## 5. Casimirs, and what the contraction does to them

`ad_K` acts as a derivation on quadratics in the commuting translations `H` and `P`.
A quadratic is recorded by its coefficient triple `(alpha, beta, gamma)`, meaning
`alpha*H^2 + beta*H*P + gamma*P^2`.  With `ad_K H = P` and `ad_K P = eps*H` the
derivation is `(alpha, beta, gamma) |-> (eps*beta, 2*alpha + 2*eps*gamma, beta)`.

This is a COEFFICIENT MODEL of the action on the universal enveloping algebra, not the
enveloping algebra itself. It is honest for quadratics in two commuting generators,
which is all that is used. -/

/-- `ad_K` on the coefficients of a quadratic in `H, P`. -/
def adK (eps a b c : ℝ) : ℝ × ℝ × ℝ := (eps * b, 2 * a + 2 * eps * c, b)

/-- **The Poincare Casimir.** `eps*H^2 - P^2`, i.e. `H^2/c^2 - P^2`, is annihilated by
    `ad_K` (and trivially by `ad_H`, `ad_P`, since translations commute). This is the
    mass-shell invariant `m^2 c^2 = E^2/c^2 - p^2`. -/
theorem casimir_poincare (eps : ℝ) : adK eps eps 0 (-1) = (0, 0, 0) := by
  simp only [adK, Prod.mk.injEq]
  refine ⟨by ring, by ring, trivial⟩

/-- **Uniqueness up to scale.** A quadratic in `H, P` is `ad_K`-invariant exactly when
    its `H*P` coefficient vanishes and its `H^2` coefficient is `-eps` times its `P^2`
    coefficient. So the mass-shell quadratic is the only Casimir of this degree. -/
theorem casimir_unique (eps a b c : ℝ) :
    adK eps a b c = (0, 0, 0) ↔ (b = 0 ∧ a = -(eps * c)) := by
  simp only [adK, Prod.mk.injEq]
  constructor
  · rintro ⟨_, h2, h3⟩
    exact ⟨h3, by linarith⟩
  · rintro ⟨rfl, rfl⟩
    refine ⟨by ring, by ring, by ring⟩

/-- **The contraction is blind to mass.** At `eps = 0` every `ad_K`-invariant quadratic
    has zero `H^2` coefficient: the surviving invariant is `P^2` alone. The Poincare
    Casimir that WAS the mass does not survive `c -> infinity`, which is exactly why a
    Galilei-first development has to recover mass from the central extension of
    section 3b instead of from a Casimir. -/
theorem casimir_galilei_blind (a b c : ℝ) (h : adK 0 a b c = (0, 0, 0)) : a = 0 := by
  rw [casimir_unique] at h
  simpa using h.2

end Q2Symmetry
