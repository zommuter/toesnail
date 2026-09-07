/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/weltformel-impossibility.md`.

  Owner-picked seed (verbatim, this session):

      "https://www.spektrum.de/news/warum-eine-weltformel-unmoeglich-ist/2278705 has some
       interesting claims about the impossibility of a world formula, so tackle that."

  The press piece reports Faizal, Krauss, Shabir and Marino, "Consequences of
  Undecidability in Physics on the Theory of Everything", arXiv:2507.22950, J. Holography
  Appl. Phys. 5(2) (2025) 10-21, and its predecessor Faizal, Shabir and Khan,
  "Implications of Tarski's Undefinability Theorem on the Theory of Everything",
  arXiv:2410.10903, EPL 148 (2024), DOI 10.1209/0295-5075/ad80c2.

  WHAT THIS FILE DISCHARGES, and only this:

  (1) An abstract Tarski undefinability skeleton. Given a set of "sentences" `S` with a
      truth valuation `eval : S -> Prop`, a negation, and a DIAGONAL operator, there is no
      `T : S -> S` that internally names truth. The proof uses NO consistency hypothesis,
      NO effectivity hypothesis, NO arithmetic, NO physics -- only negation plus the
      diagonal. That is the essay's claim (b) about hypothesis strength: the Tarski step
      survives dropping the recursive-enumerability that Goedel I needs, so it is NOT
      decoration on top of the Goedel step. It is the load-bearing one.

  (2) The trivial-but-load-bearing converse: an EXTERNAL truth predicate always exists,
      unconditionally, as `M.eval` itself. So Tarski forbids INTERNALITY, not truth. The
      "external truth predicate T(x)" that arXiv:2507.22950 eq. (2) adjoins to build its
      "Meta-Theory of Everything" is this object. Adjoining it costs one line of Lean and
      buys no non-algorithmic understanding, no Platonic realm, and no physics.

  (3) The separation between "uncomputable" and "unpredictable in a given finite regime".
      For ANY function `f : Nat -> Bool` whatsoever -- computable, uncomputable, chosen by
      an oracle, chosen by an adversary -- and any finite horizon `N`, a finite lookup
      TABLE reproduces `f` exactly on `{0, ..., N}`. Hence no test whose verdict depends
      only on the first `N+1` values can distinguish `f` from a finite table. Uncomputability
      is a statement about the infinite tail, never about any experiment.

  Reading the Lean symbols back into the essay's language:

    `S`                  sentences of the candidate world formula's language.
    `M.eval s`           "s is true", in the intended interpretation. NOT provability.
    `M.neg`              the language's own negation, matched to `eval` by `neg_spec`.
    `D.diag F`           the diagonal/self-reference device: a sentence that is true
                         exactly when `F` applied to itself is true. In arithmetic this is
                         Goedel's fixed-point lemma; here it is a HYPOTHESIS, which is the
                         honest way to carry it, because whether a physical theory's
                         language admits it is exactly the unargued step in the papers.
    `T : S -> S`         an INTERNAL truth predicate: takes a sentence and returns another
                         sentence of the same language ("...is true").
    `Tr : S -> Prop`     an EXTERNAL truth predicate: lives in the metalanguage.
    `table t`            a finite lookup table, padded with `false`: the most boring
                         computable function there is.

  EXPLICITLY OUT OF SCOPE (do not read this file as more than it is):
    - This is NOT Tarski's theorem for arithmetic. Real Tarski PROVES the diagonal lemma
      from Goedel numbering in a theory interpreting Robinson arithmetic Q. Here `diag` is
      assumed. That is deliberate: the essay's whole objection to arXiv:2410.10903 is that
      it asserts, in one sentence and without argument, that a quantum-gravity language is
      "definitely robust enough to cover the arithmetic". This file makes that hypothesis
      VISIBLE as a field of a structure instead of hiding it in prose.
    - This is NOT Goedel's first or second incompleteness theorem. No provability
      predicate, no recursive enumerability, no consistency statement appears below.
    - This is NOT Chaitin's information-theoretic incompleteness. No Kolmogorov complexity
      is defined here, and the essay's finding that arXiv:2507.22950 misstates Chaitin is
      argued in prose, NOT machine-checked.
    - Nothing below is about physics. There is no Hilbert space, no Hamiltonian, no
      spectral gap. The essay's account of Cubitt-Perez-Garcia-Wolf, Pour-El-Richards,
      Wolpert and Breuer is citation, not formalization, and none of those is proved in
      this repo.
    - `no_finite_test_separates` says nothing about whether an uncomputable `f` EXISTS.
      It is a statement about finite agreement, which is why it is cheap and why it is
      still the right rebuttal to "undecidability bounds what physics can predict".
    - Sibling: `docs/dreamed/lean/Omniscience.lean` proves Lawvere's fixed-point theorem.
      This file's `diag_fixedPoint` is the same diagonal wearing different clothes, but it
      is NOT derived from Lawvere here, and the essay says so.
-/
import Mathlib.Logic.Basic
import Mathlib.Data.Nat.Basic
import Mathlib.Data.Fin.Basic

namespace Toesnail.Weltformel

universe u

/-! ## Part 1. Abstract Tarski: no internal truth predicate -/

/-- A bare semantics: sentences `S`, a truth valuation into `Prop`, and a negation that
    the valuation respects. Note what is ABSENT: no axioms, no derivability relation, no
    consistency hypothesis, no notion of a computation. `eval` may be any predicate at
    all, including one that is not recursively enumerable. -/
structure Semantics (S : Type u) where
  eval : S → Prop
  neg : S → S
  neg_spec : ∀ s, eval (neg s) ↔ ¬ eval s

/-- The self-reference device, carried as an explicit hypothesis rather than smuggled.
    `diag F` is a sentence asserting that `F` holds of it. In Peano arithmetic this is a
    theorem (the diagonal lemma, proved from Goedel numbering); for a language of quantum
    gravity it is an open question, and the essay's objection is precisely that
    arXiv:2410.10903 treats it as obvious. -/
structure Diagonal {S : Type u} (M : Semantics S) where
  diag : (S → S) → S
  diag_spec : ∀ F : S → S, M.eval (diag F) ↔ M.eval (F (diag F))

variable {S : Type u}

/-- The diagonal, stated as a fixed-point property of TRUTH VALUES. Every syntactic
    operation `F` on sentences has a sentence whose truth value equals that of its own
    image under `F`.

    This is the point of contact with `Omniscience.lean`'s Lawvere theorem: there,
    point-surjectivity of `phi : A -> (A -> B)` manufactures a fixed point of every
    `f : B -> B`; here, `diag` supplies the same fixed point directly. Both essays run
    on one engine. -/
theorem diag_fixedPoint (M : Semantics S) (D : Diagonal M) (F : S → S) :
    ∃ s, (M.eval s ↔ M.eval (F s)) :=
  ⟨D.diag F, D.diag_spec F⟩

/-- **Tarski's undefinability theorem, skeleton form.** No `T : S → S` satisfies the
    T-schema `eval (T s) ↔ eval s` for every sentence `s`.

    The witness is the liar: apply the diagonal to `fun s => neg (T s)`, obtaining a
    sentence `L` with `eval L ↔ ¬ eval (T L) ↔ ¬ eval L`.

    HYPOTHESES ACTUALLY USED: a negation matched to the valuation, and a diagonal. That
    is all. In particular there is NO consistency assumption and NO effectivity
    assumption -- which is why this result, unlike Goedel I, still applies to a theory
    whose axiom set is not recursively enumerable. -/
theorem no_internal_truth_predicate (M : Semantics S) (D : Diagonal M) (T : S → S) :
    ¬ (∀ s, M.eval (T s) ↔ M.eval s) := by
  intro hT
  obtain ⟨L, hL⟩ := diag_fixedPoint M D (fun s => M.neg (T s))
  have hliar : M.eval L ↔ ¬ M.eval L :=
    hL.trans ((M.neg_spec (T L)).trans (not_congr (hT L)))
  exact iff_not_self hliar

/-- Adding SEMANTIC COMPLETENESS does not help. Even if every sentence is decided one way
    or the other by the valuation -- the property `Axiom 2` of arXiv:2410.10903 demands
    of a Theory of Everything -- there is still no internal truth predicate.

    The hypothesis is deliberately redundant (classically it holds for any `eval`), and
    the redundancy IS the finding: completeness is not the thing Tarski takes away. -/
theorem no_internal_truth_predicate_of_complete (M : Semantics S) (D : Diagonal M)
    (_hcomplete : ∀ s, M.eval s ∨ M.eval (M.neg s)) (T : S → S) :
    ¬ (∀ s, M.eval (T s) ↔ M.eval s) :=
  no_internal_truth_predicate M D T

/-- **A restriction that does not touch a hypothesis changes nothing.** `Restriction` is an
    arbitrary side condition: drop an axiom, forbid a construction, demand renormalizability,
    work without the axiom of choice. Unless it removes `neg` or `diag`, the conclusion is
    untouched.

    The statement is trivial and the triviality IS the content. It is the shape of the
    essay's organising claim: an impossibility theorem is only escaped by falsifying one of
    the hypotheses it actually uses. Cross-reference, not duplicated here: the sibling essay
    `docs/dreamed/logic-bloch-poles.md` applies the same shape to the owner's own note that
    "core layer should only be complete, e.g. ZF without C". -/
theorem irrelevant_restriction_does_not_help (M : Semantics S) (D : Diagonal M)
    (Restriction : Prop) (_hR : Restriction) (T : S → S) :
    ¬ (∀ s, M.eval (T s) ↔ M.eval s) :=
  no_internal_truth_predicate M D T

/-! ## Part 2. The external truth predicate is free -/

/-- **An external truth predicate always exists**, for every semantics, unconditionally,
    with no hypothesis whatsoever -- not even `Diagonal`.

    The witness is `M.eval` itself. This is one line, and it is the essay's sharpest
    point about arXiv:2507.22950: the "Meta-Theory of Everything" of its eq. (2) is built
    by adjoining an external truth predicate `T(x)` to the computational core, and that
    move is Tarski's own metalanguage from 1933, not a discovery about physics. Tarski
    forbids INTERNAL truth. He hands you external truth for nothing. -/
theorem external_truth_predicate_exists (M : Semantics S) :
    ∃ Tr : S → Prop, ∀ s, Tr s ↔ M.eval s :=
  ⟨M.eval, fun _ => Iff.rfl⟩

/-- The two results together, as the essay states them: an external truth predicate
    exists and an internal one does not. The gap between them is a LANGUAGE boundary,
    not an ontological one, and certainly not a Platonic realm. -/
theorem truth_is_external_not_internal (M : Semantics S) (D : Diagonal M) :
    (∃ Tr : S → Prop, ∀ s, Tr s ↔ M.eval s) ∧
      (∀ T : S → S, ¬ (∀ s, M.eval (T s) ↔ M.eval s)) :=
  ⟨external_truth_predicate_exists M, no_internal_truth_predicate M D⟩

/-! ## Part 3. Uncomputable is not unpredictable-in-a-finite-regime -/

/-- A finite lookup table of `m` booleans, padded with `false` past the end. This is the
    most boring computable function there is: it is literally its own finite description. -/
def table {m : ℕ} (t : Fin m → Bool) : ℕ → Bool :=
  fun k => if h : k < m then t ⟨k, h⟩ else false

/-- **Every function agrees with a finite table on every finite regime.**

    `f` is arbitrary: it may be the halting function, a Chaitin Omega bit sequence, an
    oracle's answers, or the spectral-gap verdict for the Cubitt-Perez-Garcia-Wolf family.
    None of that matters. On `{0, ..., N}` it is a table. -/
theorem exists_table_agreeing (f : ℕ → Bool) (N : ℕ) :
    ∃ (m : ℕ) (t : Fin m → Bool), ∀ k, k ≤ N → table t k = f k := by
  refine ⟨N + 1, fun i => f i.val, ?_⟩
  intro k hk
  have h : k < N + 1 := Nat.lt_succ_of_le hk
  simp [table, h]

/-- **No finite test separates.** If a property `P` of infinite bit-streams is determined
    by the first `N+1` values -- which is what any finite body of measurements can be --
    then for every `f` there is a finite table that `P` cannot tell apart from `f`.

    Read into the essay: uncomputability of a physical quantity is compatible with every
    finite experiment ever performed agreeing with a computable model. That is why claim
    (c) ("some physically meaningful quantities are uncomputable") is TRUE and yet does
    NOT yield "a world formula is impossible" -- the two are about different regimes. -/
theorem no_finite_test_separates (N : ℕ) (P : (ℕ → Bool) → Prop)
    (hP : ∀ u v : ℕ → Bool, (∀ k, k ≤ N → u k = v k) → (P u ↔ P v))
    (f : ℕ → Bool) :
    ∃ (m : ℕ) (t : Fin m → Bool), (P (table t) ↔ P f) := by
  obtain ⟨m, t, ht⟩ := exists_table_agreeing f N
  exact ⟨m, t, hP _ _ ht⟩

/-- Contrapositive packaging, the form the essay quotes: a property that DOES separate
    some `f` from every finite table cannot be determined by any finite regime. So a
    claim of the shape "undecidability limits what physics can predict" is committed to
    an infinite-regime observable, and owes an argument that such an observable is
    physically meaningful. -/
theorem separating_property_is_not_finitely_determined (P : (ℕ → Bool) → Prop)
    (f : ℕ → Bool)
    (hsep : ∀ (m : ℕ) (t : Fin m → Bool), ¬ (P (table t) ↔ P f)) (N : ℕ) :
    ¬ (∀ u v : ℕ → Bool, (∀ k, k ≤ N → u k = v k) → (P u ↔ P v)) := by
  intro hP
  obtain ⟨m, t, h⟩ := no_finite_test_separates N P hP f
  exact hsep m t h

end Toesnail.Weltformel
