/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-proof-gauge.md`.

  The essay invents a construction it calls the **Cut Connection**: a would-be gauge
  theory whose base points are proofs, whose transport is a group-valued comparison of
  two proofs, and whose curvature is the failure of that comparison to chain. The essay
  then asks whether the construction is real mathematics or a costume, and answers that
  it is exactly ONE theorem: a discrete connection on a set is flat if and only if it
  comes from a potential, and a normalising proof system supplies the potential (the
  normal form) for free. So the gauge theory of proofs of a single formula is FLAT, and
  its holonomy sees nothing beyond the connectivity of the base.

  Reading the Lean symbols back into the essay's language:

    `V`                the base: a set of PROOFS (of one fixed sequent), or of theory
                       presentations. Bare type. No topology, no smoothness: this is a
                       DISCRETE connection, on the complete graph over `V`.
    `G`                the STRUCTURE GROUP. The essay's candidate is the two-element
                       group of signs; the Lean below is uniform in `G`, which is the
                       point (nothing depends on the group being small).
    `w : V -> V -> G`  PARALLEL TRANSPORT along the edge `p -> q`. The essay's stipulated
                       reading is "the permutation that cut-elimination induces on atom
                       occurrences when the proof `p` is rewritten to the proof `q`".
                       That reading is NOT formalised here, and nothing below depends
                       on it.
    `curv w p q r`     CURVATURE: the failure of transport to chain around the triangle
                       `p -> q -> r` compared with `p -> r`. Equals a triangle holonomy
                       exactly (`curv_eq_triangle_holonomy`).
    `Flat w`           the curvature vanishes on every triangle.
    `Exact w`          the transport is a difference of endpoint values,
                       `w p q = (A p)^-1 * A q`. The essay reads `A` as the NORMAL FORM
                       MAP: confluence plus strong normalisation give every proof a
                       canonical representative, and the comparison of two proofs is
                       then a comparison of their normal forms.
    `hol w p l`        HOLONOMY along the walk that starts at `p` and visits the list
                       `l` in order.
    `endp p l`         the walk's endpoint, so a LOOP is `endp p l = p`.
    `Equiv.Perm.sign`  the essay's proposed structure group character: the sign of the
                       permutation a proof induces on atom occurrences.

  What the file discharges, in three groups.

    1. THE GAUGE COMMITMENTS. A gauge theory is not a mood; it makes checkable promises.
       Transport composes along concatenated walks (`hol_concat`); a backtracking loop
       has trivial holonomy (`hol_backtrack`); curvature IS the infinitesimal (here:
       triangular) holonomy (`curv_eq_triangle_holonomy`); and transport can genuinely
       be path-dependent (`wEx_path_dependent`), so the framework is not vacuous.

    2. THE FLATNESS THEOREM, which is the essay's central result and its central
       deflation. `flat_iff_exact`: a discrete connection over a NONEMPTY base is flat
       exactly when it has a potential. `hol_loop_trivial_of_flat`: over the complete
       graph on a set, a flat connection has trivial holonomy on EVERY loop, not merely
       on contractible ones, because a set has no nontrivial loops to begin with. So
       "the proofs of one formula carry a flat connection" is a true statement with no
       content beyond the potential itself.

    3. WHY THE SIGN IS NOT A CHOICE. `holonomy_character_dichotomy` and `sign_unique`:
       for a base with at least two atom occurrences, the sign character is the UNIQUE
       nontrivial homomorphism from the permutation group to the units of the integers.
       So if a proof-permutation holonomy valued in `{+1,-1}` exists at all, there is
       nothing to choose: it is the sign. `identity_and_braiding_differ` is the essay's
       minimal witness, the identity and the braiding on two atom occurrences.

  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):
    - The **Cut Connection is INVENTED**. The reading of `w p q` as "the atom-occurrence
      permutation induced by cut-elimination from `p` to `q`" is the essay's stipulation.
      Nothing here proves, or even states, that cut-elimination induces such a
      permutation, that it is well defined, or that it composes. `V`, `G` and `w` are a
      bare type, a bare group and a bare function.
    - No proof theory whatsoever appears below. No sequent calculus, no proof nets, no
      cut-elimination, no confluence, no strong normalisation, no Church-Rosser. The
      claim "normalisation supplies the potential `A`" is an ESSAY-LEVEL reading of
      `Exact`, not a theorem here.
    - No differential geometry appears below. There is no manifold, no Lie group, no
      connection form, no covariant derivative, no Bianchi identity in the smooth sense.
      `curv` is a finite-difference object on a complete graph and the analogy to a
      curvature 2-form is the essay's, argued there and not proved anywhere.
    - No linear logic, no braiding in a symmetric monoidal category, no determinant of a
      swap map on a tensor square. `identity_and_braiding_differ` is a statement about
      `Equiv.Perm (Fin 2)` and nothing more; identifying it with the braiding of
      `A (x) A` is the essay's reading.
    - No forcing, no independence, no monodromy over a family of theories. The essay's
      section on where nonflat holonomy could live is CONJECTURE and is formalised
      nowhere.
    - No cohomology. `bianchi` is an elementary identity in a commutative group; calling
      it a coboundary-squared statement is the essay's framing.
    - Nothing about the Bloch sphere, quantum mechanics, or U(1).
-/
import Mathlib.GroupTheory.Perm.Sign
import Mathlib.Algebra.Group.Subgroup.Ker
import Mathlib.Algebra.Ring.Int.Units
import Mathlib.Tactic.Group
import Mathlib.Tactic.Abel
import Mathlib.Tactic.NormNum

namespace Toesnail.LogicGauge

universe u v

/-! ## 1. A discrete connection, its curvature, and what flatness means

Everything in this section is uniform in the structure group `G`. That uniformity is a
finding, not a convenience: no property of the group is used anywhere, so no choice of
structure group can rescue a flat connection. -/

section Transport

variable {V : Type u} {G : Type v} [Group G]

/-- **Curvature of a discrete connection.** The failure of transport to chain around the
    triangle `p -> q -> r` when compared with the direct edge `p -> r`.

    In the essay's reading: transport `p -> q` and then `q -> r`, and compare with going
    straight from `p` to `r`. The residue is the curvature at that triangle. -/
def curv (w : V → V → G) (p q r : V) : G := w p q * w q r * (w p r)⁻¹

/-- **Flat**: the curvature vanishes on every triangle. -/
def Flat (w : V → V → G) : Prop := ∀ p q r, curv w p q r = 1

/-- **Exact**: the transport is a difference of endpoint values. The essay reads `A` as
    the normal-form map of a confluent, strongly normalising rewriting system. -/
def Exact (w : V → V → G) : Prop := ∃ A : V → G, ∀ p q, w p q = (A p)⁻¹ * A q

/-- An exact connection is flat. This direction is the cheap one, and it is the one the
    essay leans on: if a proof system hands you a canonical normal form, the connection
    built by comparing normal forms cannot curve. -/
theorem flat_of_exact {w : V → V → G} (h : Exact w) : Flat w := by
  obtain ⟨A, hA⟩ := h
  intro p q r
  simp only [curv, hA]
  group

/-- **The flatness theorem, converse direction.** Over a nonempty base, a flat discrete
    connection HAS a potential, and the potential is transport from an arbitrary
    basepoint. Together with `flat_of_exact` this says the two notions coincide, so
    "flat" carries no information that "has a potential" does not. -/
theorem exact_of_flat [Nonempty V] {w : V → V → G} (h : Flat w) : Exact w := by
  obtain ⟨p₀⟩ := ‹Nonempty V›
  refine ⟨fun x => w p₀ x, fun p q => ?_⟩
  have h1 : w p₀ p * w p q = w p₀ q := by
    have h2 := h p₀ p q
    rw [curv] at h2
    exact mul_inv_eq_one.mp h2
  calc w p q = (w p₀ p)⁻¹ * (w p₀ p * w p q) := by group
    _ = (w p₀ p)⁻¹ * w p₀ q := by rw [h1]

/-- **Flat iff exact.** The whole gauge theory of a discrete base collapses to this. -/
theorem flat_iff_exact [Nonempty V] {w : V → V → G} : Flat w ↔ Exact w :=
  ⟨exact_of_flat, flat_of_exact⟩

/-- A flat connection transports every point to itself trivially. -/
theorem flat_refl {w : V → V → G} (h : Flat w) (p : V) : w p p = 1 := by
  have h1 := h p p p
  rw [curv] at h1
  simpa using h1

/-- A flat connection is reversible: going back is the inverse of going forward. -/
theorem flat_symm {w : V → V → G} (h : Flat w) (p q : V) : w q p = (w p q)⁻¹ := by
  have h1 := h p q p
  rw [curv, flat_refl h p, inv_one, mul_one] at h1
  calc w q p = (w p q)⁻¹ * (w p q * w q p) := by group
    _ = (w p q)⁻¹ := by rw [h1, mul_one]

end Transport

/-! ## 2. The Bianchi identity, in the only sense a discrete connection has one

In a commutative structure group the curvature is a 2-cochain and is itself a cocycle.
This is elementary; it is recorded because the essay claims the analogy to gauge theory
is structural rather than verbal, and this is one of the few places the claim can be
made to say something checkable. -/

section Bianchi

variable {V : Type u} {G : Type v} [AddCommGroup G]

/-- The additive spelling of `curv`, for an abelian structure group. Written additively
    because that is the spelling in which the cochain statement below is legible: `acurv`
    is the simplicial coboundary of the 1-cochain `w`. -/
def acurv (w : V → V → G) (p q r : V) : G := w p q + w q r - w p r

/-- `acurv` really is `curv`, transported along `Multiplicative`. Recorded so the additive
    spelling below cannot be accused of being a different object. -/
theorem acurv_eq_curv (w : V → V → G) (p q r : V) :
    Multiplicative.ofAdd (acurv w p q r) =
      curv (fun x y => Multiplicative.ofAdd (w x y)) p q r := by
  rw [acurv, curv, sub_eq_add_neg, ofAdd_add, ofAdd_add, ofAdd_neg]

/-- **Bianchi identity (discrete, abelian).** The alternating sum of the curvature over
    the four faces of a tetrahedron vanishes. This is `delta^2 = 0` for the simplicial
    coboundary, with `acurv = delta w`. -/
theorem bianchi (w : V → V → G) (p q r s : V) :
    acurv w q r s - acurv w p r s + acurv w p q s - acurv w p q r = 0 := by
  simp only [acurv]
  abel

end Bianchi

/-! ## 3. Holonomy along a walk

A walk from `p` is a list of the points it visits after `p`. This keeps everything
structurally recursive and avoids any dependence on list-library corner cases. -/

section Holonomy

variable {V : Type u} {G : Type v} [Group G]

/-- The endpoint of the walk that starts at `p` and visits `l` in order. -/
def endp (p : V) : List V → V
  | [] => p
  | q :: t => endp q t

@[simp] theorem endp_nil (p : V) : endp p ([] : List V) = p := rfl

@[simp] theorem endp_cons (p q : V) (t : List V) : endp p (q :: t) = endp q t := rfl

/-- **Holonomy** along the walk starting at `p` and visiting `l` in order. -/
def hol (w : V → V → G) : V → List V → G
  | _, [] => 1
  | p, q :: t => w p q * hol w q t

@[simp] theorem hol_nil (w : V → V → G) (p : V) : hol w p [] = 1 := rfl

@[simp] theorem hol_cons (w : V → V → G) (p q : V) (t : List V) :
    hol w p (q :: t) = w p q * hol w q t := rfl

/-- Endpoints compose along concatenation. -/
theorem endp_append (p : V) (l m : List V) : endp p (l ++ m) = endp (endp p l) m := by
  induction l generalizing p with
  | nil => simp
  | cons q t ih => simpa using ih q

/-- **Gauge commitment 1: endpoint-composability.** Holonomy is multiplicative under
    concatenation of walks, provided the second walk starts where the first ended. This
    is the property that makes holonomy a *transport* rather than an arbitrary labelling
    of walks, and it holds for an arbitrary `w`, flat or not. -/
theorem hol_concat (w : V → V → G) (p : V) (l m : List V) :
    hol w p l * hol w (endp p l) m = hol w p (l ++ m) := by
  induction l generalizing p with
  | nil => simp
  | cons q t ih =>
      simp only [hol_cons, endp_cons, List.cons_append, mul_assoc]
      rw [ih q]

/-- **The flat holonomy is the endpoint difference.** For an exact connection with
    potential `A`, the holonomy of any walk depends on the two endpoints only. This is
    the precise sense in which a normalising proof system has nothing to remember about
    the route taken. -/
theorem hol_exact {w : V → V → G} {A : V → G} (hA : ∀ p q, w p q = (A p)⁻¹ * A q)
    (p : V) (l : List V) : hol w p l = (A p)⁻¹ * A (endp p l) := by
  induction l generalizing p with
  | nil => simp
  | cons q t ih =>
      rw [hol_cons, endp_cons, hA p q, ih q]
      group

/-- **The essay's central deflation, stated as a theorem.** Over a nonempty base, a flat
    connection has trivial holonomy around EVERY loop.

    Note what is and is not being said. In ordinary gauge theory a flat connection still
    has holonomy: it detects the fundamental group of the base. Here the base is a bare
    SET, carrying transport along every ordered pair, so it is the complete graph, whose
    fundamental group is trivial. Flatness therefore leaves nothing at all. Any hope of
    a nonzero invariant must come from restricting which edges exist, not from choosing
    a cleverer structure group. -/
theorem hol_loop_trivial_of_flat [Nonempty V] {w : V → V → G} (h : Flat w)
    (p : V) (l : List V) (hloop : endp p l = p) : hol w p l = 1 := by
  obtain ⟨A, hA⟩ := exact_of_flat h
  rw [hol_exact hA, hloop, inv_mul_cancel]

/-- **Gauge commitment 2: a backtracking loop is trivial.** Going out and coming back
    picks up nothing. Stated from reversibility alone, so it does not need full
    flatness. -/
theorem hol_backtrack {w : V → V → G} (hrev : ∀ p q, w q p = (w p q)⁻¹) (p q : V) :
    hol w p [q, p] = 1 := by
  simp [hrev q p]

/-- **Gauge commitment 3: curvature IS holonomy, at the smallest loop.** The curvature at
    the triangle `(p, q, r)` is exactly the holonomy of the two-step walk `p -> q -> r`
    divided by that of the direct edge `p -> r`. A discrete connection has no
    infinitesimals, so the triangle is the smallest loop there is, and this identity is
    the honest replacement for "curvature is infinitesimal holonomy". -/
theorem curv_eq_triangle_holonomy (w : V → V → G) (p q r : V) :
    curv w p q r = hol w p [q, r] * (hol w p [r])⁻¹ := by
  simp only [curv, hol_cons, hol_nil, mul_one]

end Holonomy

/-! ## 4. The framework is not vacuous: a curved connection exists

Three points, transport `-1` along every non-loop edge. This is the smallest curved
discrete connection, and it certifies that `Flat` is a real hypothesis rather than a
theorem, that transport can be genuinely path-dependent, and that the essay's flatness
result therefore says something. -/

section Witness

/-- The three-point witness: transport `-1` along every edge between distinct points. -/
def wEx : Fin 3 → Fin 3 → ℤˣ := fun p q => if p = q then 1 else -1

theorem neg_one_ne_one_units : (-1 : ℤˣ) ≠ 1 := by
  intro h
  have : ((-1 : ℤˣ) : ℤ) = ((1 : ℤˣ) : ℤ) := congrArg Units.val h
  norm_num at this

/-- The witness is curved at the triangle `(0, 1, 2)`. -/
theorem wEx_curved : curv wEx 0 1 2 = -1 := by
  simp [curv, wEx]

/-- Hence it is not flat. -/
theorem wEx_not_flat : ¬ Flat wEx := by
  intro h
  have := h 0 1 2
  rw [wEx_curved] at this
  exact neg_one_ne_one_units this

/-- Hence it has no potential: there is no `A` with `wEx p q = (A p)⁻¹ * A q`. Read back
    into the essay: a rewriting system whose transport curves cannot admit a normal-form
    map inducing that transport. -/
theorem wEx_not_exact : ¬ Exact wEx := fun h => wEx_not_flat (flat_of_exact h)

/-- **Transport is genuinely path-dependent.** Going `0 -> 2` directly and going
    `0 -> 1 -> 2` give different answers. Without this the framework would be a costume
    with nothing inside. -/
theorem wEx_path_dependent : hol wEx 0 [2] ≠ hol wEx 0 [1, 2] := by
  simp only [hol_cons, hol_nil, mul_one, wEx]
  norm_num
  exact neg_one_ne_one_units

/-- The triangle loop `0 -> 1 -> 2 -> 0` has nontrivial holonomy. -/
theorem wEx_loop_nontrivial : hol wEx 0 [1, 2, 0] = -1 := by
  simp [wEx]

end Witness

/-! ## 5. Why the sign is not a choice

If a `{+1,-1}`-valued holonomy on permutations of atom occurrences exists at all, there
is nothing to pick: the sign character is the unique nontrivial one. That is what makes
the essay's proposed structure group canonical rather than stipulated, and it is the one
place where the invented construction inherits a genuine rigidity from real mathematics. -/

section Sign

variable {α : Type u} [Fintype α] [DecidableEq α]

omit [Fintype α] in
/-- Any homomorphism from a permutation group into a COMMUTATIVE group takes the same
    value on all transpositions, because all transpositions are conjugate and conjugacy
    is trivial in a commutative group. -/
theorem hom_const_on_swaps {G : Type v} [CommGroup G] (f : Equiv.Perm α →* G)
    {a b c d : α} (hab : a ≠ b) (hcd : c ≠ d) :
    f (Equiv.swap a b) = f (Equiv.swap c d) :=
  isConj_iff_eq.mp (f.map_isConj (Equiv.Perm.isConj_swap hab hcd))

/-- Two homomorphisms out of a permutation group that agree on all transpositions are
    equal, because transpositions generate. -/
theorem hom_eq_of_eqOn_swaps {G : Type v} [Group G] (f g : Equiv.Perm α →* G)
    (h : ∀ a b : α, a ≠ b → f (Equiv.swap a b) = g (Equiv.swap a b)) : f = g := by
  refine MonoidHom.eq_of_eqOn_dense Equiv.Perm.closure_isSwap ?_
  rintro σ ⟨a, b, hab, rfl⟩
  exact h a b hab

/-- **The holonomy character dichotomy.** On a base with at least two atom occurrences,
    there are exactly two homomorphisms from the permutation group to the units of the
    integers: the trivial one and the sign. -/
theorem holonomy_character_dichotomy {a b : α} (hab : a ≠ b) (f : Equiv.Perm α →* ℤˣ) :
    f = 1 ∨ f = Equiv.Perm.sign := by
  rcases Int.units_eq_one_or (f (Equiv.swap a b)) with h | h
  · left
    refine hom_eq_of_eqOn_swaps f 1 ?_
    intro c d hcd
    rw [hom_const_on_swaps f hcd hab, h, MonoidHom.one_apply]
  · right
    refine hom_eq_of_eqOn_swaps f Equiv.Perm.sign ?_
    intro c d hcd
    rw [hom_const_on_swaps f hcd hab, h, Equiv.Perm.sign_swap hcd]

/-- The sign is itself nontrivial, so the dichotomy is not degenerate. -/
theorem sign_ne_trivial {a b : α} (hab : a ≠ b) :
    (Equiv.Perm.sign : Equiv.Perm α →* ℤˣ) ≠ 1 := by
  intro h
  have h1 : Equiv.Perm.sign (Equiv.swap a b) = (1 : Equiv.Perm α →* ℤˣ) (Equiv.swap a b) := by
    rw [h]
  rw [Equiv.Perm.sign_swap hab, MonoidHom.one_apply] at h1
  exact neg_one_ne_one_units h1

/-- **The sign is the unique nontrivial holonomy character.** This is the sense in which
    the essay's structure group is forced rather than chosen: two people who both find a
    nontrivial `{+1,-1}`-valued invariant of the atom-occurrence permutation have found
    the same invariant, on the nose and not merely up to a global flip. -/
theorem sign_unique {a b : α} (hab : a ≠ b) (f : Equiv.Perm α →* ℤˣ) (hf : f ≠ 1) :
    f = Equiv.Perm.sign :=
  (holonomy_character_dichotomy hab f).resolve_left hf

/-- **The essay's minimal witness.** The identity and the braiding on two atom
    occurrences have opposite sign. Read back: two proofs of the same sequent that no
    provability measurement can separate, distinguished by the holonomy. -/
theorem identity_and_braiding_differ :
    Equiv.Perm.sign (1 : Equiv.Perm (Fin 2)) ≠
      Equiv.Perm.sign (Equiv.swap (0 : Fin 2) 1) := by
  rw [map_one, Equiv.Perm.sign_swap (by decide)]
  exact fun h => neg_one_ne_one_units h.symm

end Sign

/-! ## 6. The two verdicts, restated side by side -/

/-- Flat is exactly exact, uniformly in the structure group. Nothing about `G` is used,
    so no choice of gauge group produces a nontrivial flat holonomy on a set base. -/
theorem the_theory_is_flat_or_it_is_curved {V : Type u} {G : Type v} [Group G]
    [Nonempty V] (w : V → V → G) : Flat w ↔ Exact w := flat_iff_exact

/-- And curvature is available, so flatness is a hypothesis with content. -/
theorem curvature_is_available : ¬ Flat wEx := wEx_not_flat

end Toesnail.LogicGauge
