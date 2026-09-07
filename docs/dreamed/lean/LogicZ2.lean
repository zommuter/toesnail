/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/logic-z2-grading.md`.

  ----------------------------------------------------------------------------------
  WHAT THIS FILE IS FOR
  ----------------------------------------------------------------------------------

  The predecessor essay `docs/dreamed/logic-bloch-phase.md` closed with one concrete
  recommendation (its section 8.3, and item 3 of its "Surfaced for the owner"):

      "the object to look for is a Z_2 grading, not a U(1) phase."

  It reached that recommendation after killing the owner's own "phase = provability"
  suggestion with a one-line algebraic argument, formalised there as `box_phase_trivial`:

      f multiplicative over an operation that is IDEMPOTENT  ==>  f is constant.

  The first job of this file is to check whether that argument also kills the
  recommendation. It does. `grading_trivial_of_idempotent` below is the same lemma with
  the codomain left arbitrary, and `units_grading_trivial_of_idempotent` /
  `zmod2_grading_trivial_of_idempotent` are the {+1,-1} and Z/2 instances. The
  predecessor's headline recommendation, read literally as "a sign attached to
  propositions, multiplying under conjunction", is self-defeating.

  The second job is to say precisely where the escape is, so the finding is a
  sharpening rather than a demolition. `perm_sign_is_a_nontrivial_z2_grading` exhibits a
  nontrivial {+1,-1}-valued grading of a genuine composition monoid, and
  `idempotent_only_in_a_group` says why the collapse does not reach it: composition of
  permutations has exactly one idempotent, so the hypothesis of the collapse lemma is
  never met there. Conjunction is a JOIN; composition is a CHAIN. The predecessor's own
  filter 3 said this and its recommendation then forgot it.

  The third job is the essay's null hypothesis: is Z_2 in logic just negation wearing a
  hat? `involution_powers`, `no_sign_at_a_fixed_point`, `sign_never_canonical` and
  `xor_grading_is_the_truth_value` between them say: negation gives a Z_2 ACTION, never a
  Z_2 GRADING; the sign of that action is definable only relative to a choice, and the one
  canonical Z_2-valued function on a Boolean ring is the truth value itself, which is
  exactly what a grading was required to be invisible to. And `cube_eq_self_not_involutive`
  records that "negation is an involution, hence Z_2" already assumes the excluded middle:
  intuitionistically the negation operator satisfies n^3 = n, not n^2 = 1, and a monoid
  element with n^3 = n need not be an involution.

  ----------------------------------------------------------------------------------
  SYMBOL DICTIONARY (Lean name -> what the essay calls it)
  ----------------------------------------------------------------------------------

    `L`, `op`          an abstract carrier with a binary combining operation. The essay
                       instantiates `op` as conjunction on the Lindenbaum-Tarski algebra,
                       as the join of two bodies of evidence, and as Artemov's proof-sum.
                       All three are idempotent, which is the only property used.
    `G`, `f : L -> G`  the candidate grading: a sign attached to each proposition,
                       multiplying under `op`. `G = Int^x` is literally the two-element
                       group {+1, -1}; `G = ZMod 2` is its additive spelling.
    `A0`, `A1`         the even and odd parts of a would-be Z_2-graded decomposition. This
                       is the SET-level notion of a grading, weaker than a homomorphism,
                       and `odd_part_trivial_of_idempotent` shows it collapses too.
    `Equiv.Perm a`     the group being permuted. In the essay this is the group of
                       permutations of ATOM OCCURRENCES inside a linear-logic proof
                       (equivalently, the exchange structure), whose only nontrivial
                       character is the sign -- the same sign the predecessor's section
                       5.3 found as the abelianisation of the finitary renumbering group.
    `sgn`              `Equiv.Perm.sign`, the sign character.
    `sigma`            an involution. In the essay: negation on the Lindenbaum algebra.
    `s : a -> ZMod 2`  a would-be sign labelling of the negation double cover, i.e. a
                       choice of one of {A, not A} for every A.

  ----------------------------------------------------------------------------------
  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is)
  ----------------------------------------------------------------------------------

    - NO Bloch sphere, NO qubit, NO U(1), NO quantum mechanics of any kind appears
      below. The connection to the Bloch phase is made in the essay's prose and is
      formalised nowhere.
    - NO linear logic. `Equiv.Perm` is the abstract symmetric group. The claim that the
      permutation of atom occurrences in an MLL proof net is multiplicative under cut
      elimination is stated in the essay with a worked two-atom example and is CITED,
      not proved here. What is proved here is only that the sign character is a
      nontrivial multiplicative {+1,-1}-valued invariant of a group.
    - NO focusing, NO polarity, NO shift operators. The claim that polarity is a genuine
      Z_2-valued syntactic invariant of formulas in a focused system (Andreoli, Girard,
      Liang-Miller) is prior art reported in the essay, not formalised.
    - NO cohomology. `H^1(X; Z/2)`, double covers as topological objects, and Abramsky et
      al.'s Cech obstruction are discussed in the essay and appear nowhere below. The
      "double cover" here is only a free involution on a bare type.
    - NO arithmetic, NO provability predicate, NO Goedel, NO Rosser. The essay's treatment
      of Rosser's proof ordering is entirely informal.
    - NO Boolean algebra API is used for the Boolean-ring results: the only hypothesis is
      `x * x = x`, stated by hand, so the reader can see that nothing else is smuggled in.
    - The intuitionistic `n^3 = n` fact is NOT proved. What is proved is the strictly
      weaker and purely monoid-theoretic `cube_eq_self_not_involutive`: a concrete
      operator with `n^3 = n` and `n^2 != id` exists, so `n^3 = n` cannot imply `n^2 = 1`.
-/
import Mathlib.GroupTheory.Perm.Sign
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Bool.Basic
import Mathlib.Order.Lattice
import Mathlib.Tactic.NormNum

namespace Toesnail.LogicZ2

universe u v

/-! ## 1. The collapse: an idempotent operation admits no nontrivial grading

    This is the predecessor essay's `box_phase_trivial` argument with the codomain group
    left completely arbitrary. The point of stating it this way is that `G = U(1)` and
    `G = {+1,-1}` are both instances, so the predecessor's escape route from `U(1)` to
    `Z_2` is not an escape route at all. -/

/-- In a group, the only idempotent is the identity. Nothing but associativity and
    invertibility is used: no commutativity, no order, no finiteness. -/
theorem idempotent_only_in_a_group {G : Type u} [Group G] {g : G} (h : g * g = g) :
    g = 1 :=
  mul_eq_left.mp h

/-- **The central collapse.** If a combining operation `op` is idempotent, then any
    group-valued `f` that is multiplicative over `op` is constantly the identity.

    Read logically: attach a sign to each proposition and demand that the sign of `A and B`
    be the product of the signs. Since `A and A = A`, every sign squares to itself, and
    in a group that forces it to be `1`.

    This holds for EVERY group `G`. Passing from the circle to the two-element group
    changes nothing, which is exactly the finding the essay reports. -/
theorem grading_trivial_of_idempotent {L : Type u} {G : Type v} [Group G]
    (op : L → L → L) (hidem : ∀ a, op a a = a)
    (f : L → G) (hmul : ∀ a b, f (op a b) = f a * f b) : ∀ a, f a = 1 := by
  intro a
  have h : f a * f a = f a := by rw [← hmul a a, hidem a]
  exact idempotent_only_in_a_group h

/-- The `{+1, -1}` instance, with the codomain spelled as `ℤˣ`, which IS the two-element
    group. This is the literal refutation of "look for a Z_2 grading, not a U(1) phase",
    when that recommendation is read as a sign on propositions multiplying under
    conjunction. -/
theorem units_grading_trivial_of_idempotent {L : Type u}
    (op : L → L → L) (hidem : ∀ a, op a a = a)
    (f : L → ℤˣ) (hmul : ∀ a b, f (op a b) = f a * f b) : ∀ a, f a = 1 :=
  grading_trivial_of_idempotent op hidem f hmul

/-- The same statement in additive `ZMod 2` spelling, which is how a grading is usually
    written. Proved directly rather than by transport, so no group isomorphism is smuggled
    in: `x = x + x` already forces `x = 0` in any additive group. -/
theorem zmod2_grading_trivial_of_idempotent {L : Type u}
    (op : L → L → L) (hidem : ∀ a, op a a = a)
    (d : L → ZMod 2) (hadd : ∀ a b, d (op a b) = d a + d b) : ∀ a, d a = 0 := by
  intro a
  have h : d a = d a + d a := by rw [← hadd a a, hidem a]
  exact left_eq_add.mp h

/-- Conjunction instance: on any meet-semilattice (the Lindenbaum-Tarski algebra of any
    logic is one), no nontrivial group-valued grading over `⊓` exists. -/
theorem meet_grading_trivial {L : Type u} [SemilatticeInf L] {G : Type v} [Group G]
    (f : L → G) (hmul : ∀ a b, f (a ⊓ b) = f a * f b) : ∀ a, f a = 1 :=
  grading_trivial_of_idempotent (· ⊓ ·)
    (fun _a => le_antisymm inf_le_left (le_inf le_rfl le_rfl)) f hmul

/-- Disjunction instance, for the same reason. Together with `meet_grading_trivial` this
    covers every "accumulate two bodies of support" reading: joining is idempotent, and
    idempotence is fatal. -/
theorem join_grading_trivial {L : Type u} [SemilatticeSup L] {G : Type v} [Group G]
    (f : L → G) (hmul : ∀ a b, f (a ⊔ b) = f a * f b) : ∀ a, f a = 1 :=
  grading_trivial_of_idempotent (· ⊔ ·)
    (fun _a => le_antisymm (sup_le le_rfl le_rfl) le_sup_left) f hmul

/-! ## 2. The collapse survives the weaker, set-level notion of a grading

    A homomorphism is not the only way to grade. A Z_2-GRADED ring is a decomposition
    `R = R_0 (+) R_1` with `R_i R_j` inside `R_{i+j}` -- a super-algebra. That is weaker
    than having a multiplicative sign function, so one might hope it escapes section 1.
    It does not, and the reason is one line: an odd element is its own square, so it is
    even as well, so it lies in the intersection. -/

/-- **No super-structure on an idempotent multiplication.** Given any decomposition of a
    carrier into an "even" part `A0` and an "odd" part `A1` satisfying the single grading
    law that a product of two odd elements is even, plus disjointness except at `z`, an
    idempotent multiplication forces the odd part to be trivial.

    `z` stands for whatever the two parts are permitted to share (`0` in a ring). The
    essay's instance: a Boolean ring, where `x * x = x` holds by definition, so a Boolean
    ring admits no nontrivial Z_2-grading over its multiplication and in particular is
    never a nontrivial super-algebra. -/
theorem odd_part_trivial_of_idempotent {R : Type u} [Mul R] (A0 A1 : Set R) (z : R)
    (hgrade : ∀ x ∈ A1, ∀ y ∈ A1, x * y ∈ A0)
    (hdisj : ∀ x, x ∈ A0 → x ∈ A1 → x = z)
    (hidem : ∀ x : R, x * x = x) :
    ∀ x ∈ A1, x = z := by
  intro x hx
  have hx0 : x ∈ A0 := by
    have := hgrade x hx x hx
    rwa [hidem x] at this
  exact hdisj x hx0 hx

/-- The Boolean-ring reading of the previous theorem, with the idempotence hypothesis
    spelled out as the defining law of a Boolean ring rather than imported from an
    algebraic class, so that nothing else about Boolean algebra is in play. -/
theorem boolean_ring_no_odd_part {R : Type u} [Mul R] (A0 A1 : Set R) (z : R)
    (hbool : ∀ x : R, x * x = x)
    (hgrade : ∀ x ∈ A1, ∀ y ∈ A1, x * y ∈ A0)
    (hdisj : ∀ x, x ∈ A0 → x ∈ A1 → x = z) :
    A1 ⊆ {z} :=
  fun _ hx => odd_part_trivial_of_idempotent A0 A1 z hgrade hdisj hbool _ hx

/-! ## 3. The escape: composition is not a join, and there the sign survives

    Nothing above is an argument that Z_2 is absent from logic. It is an argument that Z_2
    is absent from the LATTICE of propositions. The predecessor's own filter 3 demanded a
    chaining operation rather than a joining one; the results below say what changes when
    that demand is met.

    Composition in a group has exactly one idempotent (`idempotent_only_in_a_group`), so
    the hypothesis `∀ a, op a a = a` of section 1 is available only for the trivial group.
    The collapse therefore has no purchase, and a nontrivial sign genuinely exists. -/

variable {α : Type u} [DecidableEq α] [Fintype α]

/-- The sign character is multiplicative. Stated separately from Mathlib's `map_mul` so
    that the essay's table can point at a named theorem. -/
theorem sign_mul (σ τ : Equiv.Perm α) :
    Equiv.Perm.sign (σ * τ) = Equiv.Perm.sign σ * Equiv.Perm.sign τ :=
  map_mul _ _ _

/-- The sign character is not constant: a transposition has sign `-1`. -/
theorem sign_swap_ne_one {a b : α} (hab : a ≠ b) :
    Equiv.Perm.sign (Equiv.swap a b) ≠ 1 := by
  rw [Equiv.Perm.sign_swap hab]
  decide

/-- **The survivor, stated as the exact negation of section 1's conclusion.** There is a
    nontrivial `{+1,-1}`-valued multiplicative invariant of a composition monoid. Compare
    `units_grading_trivial_of_idempotent`: same codomain, same multiplicativity demand,
    opposite verdict. The only difference is that composition is a chaining and
    conjunction is a joining.

    Two distinct points are needed for a transposition to exist, which is why the
    hypothesis is `a ≠ b` rather than a cardinality bound. -/
theorem perm_sign_is_a_nontrivial_z2_grading {a b : α} (hab : a ≠ b) :
    ∃ f : Equiv.Perm α → ℤˣ,
      (∀ σ τ, f (σ * τ) = f σ * f τ) ∧ (∃ σ, f σ ≠ 1) :=
  ⟨fun σ => Equiv.Perm.sign σ, sign_mul, ⟨Equiv.swap a b, sign_swap_ne_one hab⟩⟩

/-- Why the collapse cannot reach it: the identity is the only permutation that composes
    with itself to give itself, so `∀ σ, σ * σ = σ` fails as soon as the group is
    nontrivial, and section 1's hypothesis is unavailable. -/
theorem composition_not_idempotent {a b : α} (hab : a ≠ b) :
    ¬ (∀ σ : Equiv.Perm α, σ * σ = σ) := by
  intro h
  have h1 : Equiv.swap a b = 1 := idempotent_only_in_a_group (h (Equiv.swap a b))
  exact sign_swap_ne_one hab (by rw [h1]; exact map_one _)

/-! ## 4. The null hypothesis: is Z_2 in logic just negation?

    Negation is an involution, involutions generate Z_2, and if that is all there is then
    the grading is a triviality rather than a discovery. The results below separate two
    things the informal argument runs together: a Z_2 ACTION ON a structure, and a Z_2
    GRADING OF it. Negation supplies the first and never the second. -/

/-- An involution generates a two-element monoid of powers, and nothing larger. This is
    the honest content of "negation generates Z_2": it is a statement about the ACTION,
    a homomorphism INTO the automorphisms, not a homomorphism OUT of the algebra. A
    grading is the latter. -/
theorem involution_powers {G : Type u} [Group G] {σ : G} (h : σ * σ = 1) :
    ∀ n : ℕ, σ ^ n = 1 ∨ σ ^ n = σ := by
  intro n
  induction n with
  | zero => exact Or.inl (pow_zero σ)
  | succ k ih =>
    rcases ih with hk | hk
    · exact Or.inr (by rw [pow_succ, hk, one_mul])
    · exact Or.inl (by rw [pow_succ, hk, h])

/-- **A sign for the negation double cover cannot exist at a fixed point.** If `s` labels
    each element with a `ZMod 2` sign that FLIPS under `σ`, then `σ` has no fixed point.

    Logically: a coherent labelling of the pairs `{A, not A}` by `+` and `-` is possible
    only because no proposition is its own negation, i.e. only because `A ↔ not A` is
    inconsistent. That inconsistency is doing the work, and it is the one nontrivial
    input the whole "negation gives Z_2" story has. -/
theorem no_sign_at_a_fixed_point {β : Type u} {σ : β → β} {s : β → ZMod 2}
    (hs : ∀ x, s (σ x) = s x + 1) {x : β} (hfix : σ x = x) : False := by
  have h : s x = s x + 1 := by rw [← hs x, hfix]
  exact absurd (left_eq_add.mp h) (by decide)

/-- **The sign is never canonical.** Whenever one flipping labelling exists, so does its
    pointwise complement, and the two differ everywhere. So "the sign of a proposition"
    is defined only relative to a choice of one element from each `{A, not A}` pair, and a
    coherent such choice is precisely a model. The sign of the negation action is
    therefore the TRUTH VALUE in disguise, which is what a grading was required to be
    blind to. -/
theorem sign_never_canonical {β : Type u} {σ : β → β} (s : β → ZMod 2)
    (hs : ∀ x, s (σ x) = s x + 1) :
    ∃ t : β → ZMod 2, (∀ x, t (σ x) = t x + 1) ∧ (∀ x, t x ≠ s x) := by
  refine ⟨fun x => s x + 1, fun x => ?_, fun x => ?_⟩
  · show s (σ x) + 1 = s x + 1 + 1
    rw [hs x]
  · intro hcon
    have hcon' : s x + 1 = s x := hcon
    exact absurd (add_eq_left.mp hcon') (by decide)

/-- **The one canonical `ZMod 2`-valued function on the Boolean ring is the truth value.**
    A grading over the ring's ADDITION (exclusive or) does exist and is nontrivial, unlike
    the multiplicative case of section 1 -- but it is exactly the truth value, so it fails
    the requirement of being invisible to truth. Stated on `Bool`, the two-element Boolean
    ring, where it can be checked exhaustively. -/
theorem xor_grading_is_the_truth_value (f : Bool → ZMod 2)
    (hadd : ∀ a b, f (xor a b) = f a + f b) (htrue : f true = 1) :
    ∀ a, f a = if a then 1 else 0 := by
  have hfalse : f false = 0 := by
    have h : f false = f false + f false := by simpa using hadd false false
    exact left_eq_add.mp h
  intro a
  cases a with
  | false => simpa using hfalse
  | true => simpa using htrue

/-- **"Negation is an involution" already assumes the excluded middle.** Intuitionistic
    negation satisfies `not not not A ↔ not A`, i.e. `n^3 = n`, not `n^2 = id`. This
    theorem records the purely monoid-theoretic half of that observation: `n^3 = n` does
    NOT imply `n^2 = id`, witnessed by a concrete operator on `Bool`. So the step from
    "negation is idempotent-up-to-triple" to "negation generates `Z_2`" is not free, and
    the group `Z_2` appears only after classical logic has been assumed. -/
theorem cube_eq_self_not_involutive :
    ∃ n : Bool → Bool, (∀ x, n (n (n x)) = n x) ∧ ¬ (∀ x, n (n x) = x) := by
  refine ⟨fun _ => false, fun x => rfl, ?_⟩
  intro h
  exact absurd (h true) (by decide)

/-! ## 5. The two verdicts side by side

    The essay's headline is the contrast between these two statements, which have the same
    codomain and the same multiplicativity requirement and differ only in whether the
    combining operation is a join or a chain. -/

/-- Restated for the essay's summary table: on any meet-semilattice of propositions there
    is NO nontrivial `{+1,-1}` grading over conjunction, no matter how the sign is chosen. -/
theorem no_sign_on_propositions {L : Type u} [SemilatticeInf L]
    (f : L → ℤˣ) (hmul : ∀ a b, f (a ⊓ b) = f a * f b) : ∀ a, f a = 1 :=
  meet_grading_trivial f hmul

/-- Restated for the essay's summary table: on the permutation group there IS one, and it
    is the sign character. -/
theorem sign_on_permutations {a b : α} (hab : a ≠ b) :
    ∃ f : Equiv.Perm α → ℤˣ,
      (∀ σ τ, f (σ * τ) = f σ * f τ) ∧ (∃ σ, f σ ≠ 1) :=
  perm_sign_is_a_nontrivial_z2_grading hab

end Toesnail.LogicZ2
