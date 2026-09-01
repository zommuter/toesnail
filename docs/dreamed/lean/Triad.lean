/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/mw-collaib-triad.md`.

  The sibling `docs/dreamed/lean/EssayWing.lean` already modelled the sidecar entry,
  freshness, the drift add/remove asymmetry, and a toy staleness DAG in which staleness
  propagates transitively. None of that is reproved here. This file goes to the three
  places it did not:

    PART 1 -- **propagation is sound AND decidable.** The stale set is the set of claims
      reaching an edited claim through dependency edges. `staleSet` builds it as the
      intersection of every dependency-closed `Finset` containing the edit seed, which is
      computable because `Finset C` is itself a `Fintype`; `mem_staleSet_iff` proves that
      Finset equals reachability, so `decidableReaches` discharges decidability of the
      transitive closure on a finite DAG rather than assuming it. EssayWing left this out.

    PART 2 -- **but propagation is not origination.** A checker sees the dependency graph
      and the edit set; it never sees whether a claim is TRUE. `checker_blind_to_correctness`
      says two worlds agreeing on (dep, edited) get identical verdicts whatever their
      correctness, and `propagation_without_origination` exhibits the twin pair: an
      all-correct world and an all-wrong world that no quiescence-silent checker can tell
      apart. This is the exact bound on what `.mw`'s DAG can ever promise, and the reason
      `mathematical_writing/dag.py`'s own docstring calls fidelity "not a DAG-checkable
      property" (id:ad8c).

    PART 3 -- **content addressing beats position addressing.** An anchor is a text offset
      or a content hash; an edit is an insertion. Offsets at or after the insertion point
      move (`offset_anchor_shifts`), content hashes never do (`content_anchor_stable`), and
      the concrete `insertion_breaks_offset` / `insertion_preserves_content` pair shows an
      offset-keyed attestation re-binding to the WRONG fragment while a content-keyed one
      stays put. This settles the anchoring half of ROADMAP `id:d973`.

  Everything here is elementary. The point is that the essay's two load-bearing claims --
  "a DAG catches propagation" and "a DAG cannot catch origination" -- have a small, honest,
  machine-checked kernel, not that any of it is deep.
-/
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Powerset
import Mathlib.Logic.Relation

namespace Toesnail.Triad

/-! ## Part 1 -- the staleness DAG: propagation is sound and decidable

`dep a b` reads "claim `a` depends on claim `b`", the orientation of
`mathematical_writing.dag.DependencyDAG` (an edge `B → A` is added whenever
`A.uses ∩ B.defines ≠ ∅`). `seed` is the set of claims the edit touched. -/

section Reach

variable {C : Type*} (dep : C → C → Prop)

/-- `Reaches seed c`: claim `c` is stale after the edit, i.e. it reaches some edited claim
    through zero or more dependency edges. This is the specification; `staleSet` below is
    the implementation. -/
def Reaches (seed : Finset C) (c : C) : Prop :=
  ∃ e ∈ seed, Relation.ReflTransGen dep c e

/-- An edited claim is stale (the zero-edge case). -/
theorem reaches_seed {seed : Finset C} {e : C} (he : e ∈ seed) : Reaches dep seed e :=
  ⟨e, he, Relation.ReflTransGen.refl⟩

/-- **Propagation.** Whatever depends on a stale claim is stale. One dependency step. -/
theorem reaches_step {seed : Finset C} {a b : C} (hab : dep a b)
    (hb : Reaches dep seed b) : Reaches dep seed a := by
  obtain ⟨e, he, hbe⟩ := hb
  exact ⟨e, he, hbe.head hab⟩

/-- **Propagation, transitively.** The whole downstream cone of an edited claim is stale:
    the Resogram `edot` sign fix reaching four hand-checked claims, as a one-liner. -/
theorem reaches_trans {seed : Finset C} {a b : C}
    (hab : Relation.ReflTransGen dep a b) (hb : Reaches dep seed b) : Reaches dep seed a := by
  obtain ⟨e, he, hbe⟩ := hb
  exact ⟨e, he, hab.trans hbe⟩

/-- **No false alarms.** A claim with no path to any edited claim is not stale. Staleness
    is exactly reachability, not an over-approximation of it. -/
theorem not_reaches_of_no_path {seed : Finset C} {c : C}
    (h : ∀ e ∈ seed, ¬ Relation.ReflTransGen dep c e) : ¬ Reaches dep seed c := by
  rintro ⟨e, he, hce⟩
  exact h e he hce

/-- A `Finset` is dependency-closed over `seed` when it contains the seed and is closed
    under taking dependents. -/
def Closed (seed s : Finset C) : Prop :=
  seed ⊆ s ∧ ∀ a b : C, dep a b → b ∈ s → a ∈ s

/-- Every stale claim lies in every dependency-closed set. Induction runs from the HEAD of
    the path (the stale claim) toward the edited claim, which is the direction the closure
    condition walks. -/
theorem mem_of_closed {seed s : Finset C} (hs : Closed dep seed s) {c : C}
    (h : Reaches dep seed c) : c ∈ s := by
  obtain ⟨e, he, hce⟩ := h
  induction hce using Relation.ReflTransGen.head_induction_on with
  | refl => exact hs.1 he
  | head h' _ ih => exact hs.2 _ _ h' ih

end Reach

/-! Decidability needs the finiteness assumptions; the lemmas above do not. -/

section Decide

variable {C : Type*} [Fintype C] [DecidableEq C]
variable (dep : C → C → Prop) [DecidableRel dep]

instance (seed s : Finset C) : Decidable (Closed dep seed s) := by
  unfold Closed
  infer_instance

/-- The stale set, computed: the intersection of every dependency-closed `Finset`
    containing the seed. This is a genuine fixpoint computation and it is *computable*,
    because `Finset C` is a `Fintype` when `C` is, so the inner `∀ s : Finset C` is a
    finite check. -/
def staleSet (seed : Finset C) : Finset C :=
  Finset.univ.filter (fun c => ∀ s : Finset C, Closed dep seed s → c ∈ s)

/-- The computed `staleSet` is exactly the specified reachability set. -/
theorem mem_staleSet_iff (seed : Finset C) (c : C) :
    c ∈ staleSet dep seed ↔ Reaches dep seed c := by
  classical
  constructor
  · intro hc
    have hall := (Finset.mem_filter.mp hc).2
    set R : Finset C := Finset.univ.filter (Reaches dep seed) with hR
    have hRclosed : Closed dep seed R := by
      constructor
      · intro e he
        exact Finset.mem_filter.mpr ⟨Finset.mem_univ e, reaches_seed dep he⟩
      · intro a b hab hb
        exact Finset.mem_filter.mpr
          ⟨Finset.mem_univ a, reaches_step dep hab (Finset.mem_filter.mp hb).2⟩
    exact (Finset.mem_filter.mp (hall R hRclosed)).2
  · intro h
    exact Finset.mem_filter.mpr ⟨Finset.mem_univ c, fun s hs => mem_of_closed dep hs h⟩

/-- **Transitive staleness is DECIDABLE on a finite DAG.** Not assumed: derived from the
    `Finset`-fixpoint computation above. This is what makes `stale_after_edit` a mechanical
    check rather than a judgement call. -/
instance decidableReaches (seed : Finset C) : DecidablePred (Reaches dep seed) :=
  fun c => decidable_of_iff (c ∈ staleSet dep seed) (mem_staleSet_iff dep seed c)

end Decide

/-! ## Part 2 -- propagation is not origination

A staleness checker is a function of the dependency graph and the edit set. It is not
given, and cannot consult, whether a claim is actually true. -/

section Origination

variable {C : Type*}

/-- A world: a dependency graph, which claims were just edited, and -- invisible to any
    checker -- which claims are actually correct. `correct` stands for the property
    `mathematical_writing/dag.py`'s docstring calls transcription/semantic fidelity: the
    mirror's `ebar = Omega/pi*e` is *wrong* while every DAG edge around it holds. -/
structure World (C : Type*) where
  dep     : C → C → Bool
  edited  : C → Bool
  correct : C → Bool

/-- What any staleness checker gets to look at. Note the absence of `correct`: that is the
    entire content of this section, made structural. -/
abbrev Checker (C : Type*) := (C → C → Bool) → (C → Bool) → (C → Bool)

/-- The verdict a checker returns in a world. -/
def World.flags (w : World C) (chk : Checker C) : C → Bool := chk w.dep w.edited

/-- Nothing was edited. -/
def Quiescent (w : World C) : Prop := ∀ c, w.edited c = false

/-- The one soundness property every real staleness checker has, `stale_after_edit`
    included: with no edit, nothing is stale. (`stale_after_edit(f, f) = ∅`.) -/
def SilentWhenQuiescent (chk : Checker C) : Prop :=
  ∀ (dep : C → C → Bool) (edited : C → Bool), (∀ c, edited c = false) → ∀ c, chk dep edited c = false

/-- **Blindness.** Two worlds that agree on the dependency graph and the edit set receive
    identical verdicts, however far apart their correctness. -/
theorem checker_blind_to_correctness (chk : Checker C) (w₁ w₂ : World C)
    (hd : w₁.dep = w₂.dep) (he : w₁.edited = w₂.edited) :
    w₁.flags chk = w₂.flags chk := by
  simp [World.flags, hd, he]

/-- **The bound.** Every quiescence-silent checker has a world containing a wrong claim in
    which it flags nothing. A DAG cannot catch origination. -/
theorem no_checker_flags_origination [Inhabited C] (chk : Checker C)
    (h : SilentWhenQuiescent chk) :
    ∃ w : World C, Quiescent w ∧ (∃ c, w.correct c = false) ∧ ∀ c, w.flags chk c = false := by
  refine ⟨⟨fun _ _ => false, fun _ => false, fun _ => false⟩, fun _ => rfl, ⟨default, rfl⟩, ?_⟩
  intro c
  exact h _ _ (fun _ => rfl) c

/-- **The promise and the limit, side by side.** Two worlds sharing a dependency graph and
    an empty edit set: in one every claim is correct, in the other every claim is wrong.
    The checker returns the same verdict in both, and that verdict is "nothing stale".

    Part 1 says the DAG catches every propagated consequence of an edit. This says the DAG
    says nothing whatsoever about the edit that introduced the error in the first place --
    which is why the `edot` sign error had to be found by running a SymPy instrument, and
    why mirror fidelity stays an owner gate. -/
theorem propagation_without_origination [Inhabited C] (chk : Checker C)
    (h : SilentWhenQuiescent chk) :
    ∃ w₁ w₂ : World C,
      w₁.dep = w₂.dep ∧ w₁.edited = w₂.edited ∧
      (∀ c, w₁.correct c = true) ∧ (∀ c, w₂.correct c = false) ∧
      w₁.flags chk = w₂.flags chk ∧ (∀ c, w₂.flags chk c = false) := by
  refine ⟨⟨fun _ _ => false, fun _ => false, fun _ => true⟩,
          ⟨fun _ _ => false, fun _ => false, fun _ => false⟩,
          rfl, rfl, fun _ => rfl, fun _ => rfl, rfl, ?_⟩
  intro c
  exact h _ _ (fun _ => rfl) c

end Origination

/-! ## Part 3 -- content addressing beats position addressing

The sibling `EssayWing.lean` proved that removing a marked equation orphans its sidecar
attestation (`removal_orphans`). This proves the finer point that decides how an anchor
should be KEYED: under an insertion, a byte-offset anchor moves and a content hash does
not. `.mw`'s ARCHITECTURE.md D5 already rejects byte offsets ("Breaks reflow-stability;
rejected outright"); this is that rejection as a theorem, and it is the same argument the
site annotation system `id:d973` will need. -/

section Anchors

/-- Content hashes; the sidecar `physics/Resogram.toml` uses 8-hex-digit srepr hashes, the
    model needs only decidable equality. -/
abbrev Hash := ℕ

/-- A document, modelled as its sequence of fragment hashes. -/
abbrev Doc := List Hash

/-- Two ways to point at a fragment. -/
inductive Anchor
  | offset (n : ℕ)
  | content (h : Hash)
  deriving DecidableEq, Repr

/-- Re-anchoring after inserting `len` fragments at position `pos`. -/
def Anchor.shift (pos len : ℕ) : Anchor → Anchor
  | .offset n => .offset (if pos ≤ n then n + len else n)
  | .content h => .content h

/-- **A content anchor never moves.** Any insertion, anywhere, any size. -/
theorem content_anchor_stable (pos len : ℕ) (h : Hash) :
    (Anchor.content h).shift pos len = Anchor.content h := rfl

/-- **An offset anchor at or after the insertion point always moves.** -/
theorem offset_anchor_shifts {pos len n : ℕ} (hle : pos ≤ n) (hlen : 0 < len) :
    (Anchor.offset n).shift pos len ≠ Anchor.offset n := by
  intro hc
  simp only [Anchor.shift, if_pos hle, Anchor.offset.injEq] at hc
  omega

/-- The asymmetry, for completeness: an offset anchor BEFORE the insertion point survives.
    So position addressing is not uniformly broken -- it is broken exactly by edits earlier
    in the document, which is the common case when prose is added above an equation. -/
theorem offset_anchor_stable_before {pos len n : ℕ} (hlt : n < pos) :
    (Anchor.offset n).shift pos len = Anchor.offset n := by
  simp only [Anchor.shift, if_neg (Nat.not_le.mpr hlt)]

/-- Resolving an anchor against a document. -/
def Anchor.resolve (d : Doc) : Anchor → Option Hash
  | .offset n => d[n]?
  | .content h => if h ∈ d then some h else none

/-- **Position addressing re-binds silently to the wrong fragment.** Offset 0 pointed at
    fragment `7`; after one fragment is inserted above, it resolves to `9` -- not an error,
    not a miss, a confident answer about a different claim. This is the failure mode a
    dangling-attestation check cannot see, because nothing is dangling. -/
theorem insertion_breaks_offset :
    (Anchor.offset 0).resolve [7, 8] = some 7 ∧
    (Anchor.offset 0).resolve [9, 7, 8] = some 9 := by
  constructor <;> rfl

/-- **Content addressing survives the same insertion.** -/
theorem insertion_preserves_content :
    (Anchor.content 7).resolve [7, 8] = some 7 ∧
    (Anchor.content 7).resolve [9, 7, 8] = some 7 := by
  constructor <;> rfl

/-- The two put together: after an insertion above them, the offset anchor and the content
    anchor disagree about which claim they point at, and the content anchor is the one that
    is still right. -/
theorem anchors_diverge_under_insertion :
    (Anchor.offset 0).resolve [9, 7, 8] ≠ (Anchor.content 7).resolve [9, 7, 8] := by
  decide

end Anchors

end Toesnail.Triad
