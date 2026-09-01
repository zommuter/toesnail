/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into `physics/*.toml` or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/essay-wing.md`.

  The essay's one formalizable core is the repo's own attestation discipline: a cached
  verdict is only as good as the hash it was taken against. This file models the shape
  of `physics/Resogram.toml` (tier_floor / tiers / claim / by), defines freshness, and
  proves:

    1. `stale_entry_proves_nothing` / `verdict_transfer_fails`: an attestation pinned
       to a hash other than the current one carries NO information about the current
       claim (freshness is necessary);
    2. `fresh_transfers`: under freshness the verdict does carry over, exactly as far
       as "same hash = same claim" holds (hash collisions are outside the model);
    3. `fresh` and the `tests/test_verify.sh` drift check (sidecar handles as a subset
       of source handles) are decidable;
    4. `driftFree_insert_source` vs `removal_orphans`: the drift check survives ADDING
       a source handle but not REMOVING one. Deleting a marked equation silently
       orphans its attestation; the subset check exists to catch exactly that.
    5. a toy `.mw` DAG: staleness after an edit is reachability through dependency
       edges and propagates transitively (`staleAfterEdit_trans`), mirroring
       `mathematical_writing.dag.stale_after_edit` (used by the post-commit hook).

  Everything here is elementary. The point is that the essay's thesis has a small,
  honest, machine-checked kernel, not that any of it is deep.
-/
import Mathlib.Data.Finset.Basic
import Mathlib.Logic.Relation

namespace Toesnail.EssayWing

/-- Content hashes. `physics/Resogram.toml` uses 8-hex-digit srepr hashes; the model
    only needs decidable equality, so `ℕ` stands in. -/
abbrev Hash := ℕ

/-- Verify tiers, as in `CONVENTIONS.md` (`\sympy` / `\numeric` / `\lean` /
    `\sympylean`). -/
inductive Tier
  | sympy | numeric | lean | sympylean
  deriving DecidableEq, Repr

/-- One sidecar entry, mirroring the shape of a `physics/Resogram.toml` table:
    `tier_floor`, `tiers`, `claim` (content hash the instrument verified),
    `by` (instrument file-hashes). -/
structure SidecarEntry where
  tierFloor : Tier
  tiers     : List Tier
  claim     : Hash
  by_       : List Hash
  deriving DecidableEq, Repr

/-- Freshness: the recorded claim hash equals the current claim hash. This is check (a)
    of `tests/test_verify.sh` ("no claim/file-hash drift"). -/
def fresh (e : SidecarEntry) (current : Hash) : Prop :=
  e.claim = current

/-- Freshness is decidable. The whole design depends on this check being cheap and
    mechanical, and it is: hash equality. -/
instance fresh.decidable (e : SidecarEntry) (current : Hash) :
    Decidable (fresh e current) :=
  inferInstanceAs (Decidable (e.claim = current))

/-- **A stale entry proves nothing.** Witness: a world `holds` in which the claim whose
    hash was recorded (0) is true while the current claim (1) is false, under one and
    the same sidecar entry. The recorded verdict `true` does not transfer. -/
theorem stale_entry_proves_nothing :
    ∃ (holds : Hash → Bool) (e : SidecarEntry) (current : Hash),
      ¬ fresh e current ∧ holds e.claim = true ∧ holds current = false := by
  refine ⟨fun h => h == 0, ⟨.sympy, [.sympy], 0, []⟩, 1, ?_, rfl, rfl⟩
  decide

/-- The transfer principle "a recorded `true` verdict is a `true` verdict about the
    current claim" is FALSE in general; freshness is necessary. -/
theorem verdict_transfer_fails :
    ¬ ∀ (holds : Hash → Bool) (recorded current : Hash),
        holds recorded = true → holds current = true := fun h =>
  absurd (h (fun x => x == 0) 0 1 rfl) (by decide)

/-- With freshness the verdict does carry over, trivially, because within the model a
    hash IS the claim's identity. (Hash collisions are deliberately outside the model:
    the repo's 8-hex srepr hash makes `fresh` an approximation of "same claim", and
    this theorem is exactly as strong as that approximation.) -/
theorem fresh_transfers (holds : Hash → Bool) (e : SidecarEntry) (current : Hash)
    (hf : fresh e current) (hv : holds e.claim = true) : holds current = true :=
  hf ▸ hv

/-! ## The drift check: sidecar handles are a subset of source handles -/

/-- Equation handles (`edot`, `ymaint`, ...); again only decidable equality is
    needed. -/
abbrev Handle := ℕ

/-- Check (b) of `tests/test_verify.sh`: every attested handle still exists in the
    source ("no dangling attestation"). -/
def driftFree (sidecar source : Finset Handle) : Prop :=
  sidecar ⊆ source

/-- The drift check is decidable: it is a finite subset test. -/
instance driftFree.decidable (sc src : Finset Handle) : Decidable (driftFree sc src) :=
  inferInstanceAs (Decidable (sc ⊆ src))

/-- Adding a NEW marked equation to the source can never break the drift check. -/
theorem driftFree_insert_source (sc src : Finset Handle) (h : driftFree sc src)
    (a : Handle) : driftFree sc (insert a src) :=
  Finset.Subset.trans h (Finset.subset_insert a src)

/-- Removing one CAN: the check is not preserved downward. Witness: one attested
    handle, present in the source; erase it and the attestation dangles. This
    asymmetry is why deleting a marked equation silently orphans its sidecar entry
    until the subset check fires. -/
theorem removal_orphans :
    ∃ (sc src : Finset Handle) (a : Handle),
      driftFree sc src ∧ ¬ driftFree sc (src.erase a) := by
  refine ⟨{0}, {0}, 0, Finset.Subset.refl _, fun h => ?_⟩
  have h0 := h (Finset.mem_singleton_self 0)
  simp at h0

/-! ## A toy `.mw` staleness DAG -/

section Dag

variable {Node : Type*} (dep : Node → Node → Prop)

/-- `staleAfterEdit dep e n`: after editing node `e`, node `n` is stale, i.e. it reaches
    the edited node through zero or more dependency edges (`dep a b` = "a depends on
    b"). Reflexive-transitive closure, mirroring
    `mathematical_writing.dag.stale_after_edit`. -/
def staleAfterEdit (e n : Node) : Prop :=
  Relation.ReflTransGen dep n e

/-- The edited node itself is stale. -/
theorem staleAfterEdit_self (e : Node) : staleAfterEdit dep e e :=
  Relation.ReflTransGen.refl

/-- A direct dependent of a stale node is stale. -/
theorem staleAfterEdit_of_dep {e a b : Node} (hab : dep a b)
    (hb : staleAfterEdit dep e b) : staleAfterEdit dep e a :=
  Relation.ReflTransGen.head hab hb

/-- **Staleness propagates transitively**: whatever depends, through any chain, on a
    stale node is stale. One edited definition invalidates its whole downstream cone:
    the Resogram `edot` sign-fix incident (4 propagated discrepancies), as a
    one-liner. -/
theorem staleAfterEdit_trans {e a b : Node} (hab : Relation.ReflTransGen dep a b)
    (hb : staleAfterEdit dep e b) : staleAfterEdit dep e a :=
  hab.trans hb

end Dag

end Toesnail.EssayWing
