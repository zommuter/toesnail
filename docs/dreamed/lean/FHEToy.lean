/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into any `*.toml` sidecar or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/fhe-toy-enumeration.md`, which
  brute-forces the owner's question at `crypto/fhe.md:14` ("how to sensibly reduce the
  amount of bijective functions such that there are no excessive keybits used") in the
  setting of a toy homomorphic scheme carrying TWO independent binary operations.

  Owner-authored source of the framing:

    `crypto/fhe.md:14`  "there is no point in using more than Pi_1 = 1 key bit per data
                         bit since that is equivalent to the OTP which is secure"
    `crypto/fhe.md:10`  bijective functions on n bits are the permutations, P = (2^n)!

  Nothing here corrects or extends the owner's page. The four results are about the
  MODEL the essay proposes, not about his text:

    1. `autOp`                  usable keys form a subgroup of the permutations
    2. `fixes_identity`         a usable key must fix the operation's identity element
    3. `nontrivial_key_incomplete`
                                any nonidentity key rules out some operation -- key
                                entropy and functional completeness are exactly
                                incompatible, which is the essay's central claim
    4. `eval_exists`            for a randomised (quotient) scheme, an evaluation
                                operation for ANY family of plaintext operations always
                                exists -- algebra is never the obstruction

  Plus two `decide` instances matching the exhaustive Python search in
  `docs/dreamed/fhe-search/fhe_search.py` (experiments A and A').

  Check with:
    cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/FHEToy.lean
-/

import Mathlib.Algebra.Group.Equiv.Basic
import Mathlib.Algebra.Group.Subgroup.Lattice
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Fintype.Perm
import Mathlib.Data.Fintype.Pi
import Mathlib.Logic.Equiv.Defs

namespace FHEToy

/-! ## 1. The strict model: ciphertext space = plaintext space, same public operation

A key is a permutation `π` of the message space. The evaluator is public and applies the
*same* operation `f` to ciphertexts that the plaintext semantics uses. Correctness for
every message is exactly equivariance. -/

/-- `π` is a usable key for the operation `f`: evaluating `f` on ciphertexts and
decrypting agrees with decrypting and evaluating `f`. -/
def Equivariant {M : Type*} (π : Equiv.Perm M) (f : M → M → M) : Prop :=
  ∀ x y, π (f x y) = f (π x) (π y)

/-- The usable keys for a fixed operation form a subgroup of the permutation group, so
the key space of a strict scheme is always a group and its size is always a divisor of
`(2^n)!` -- the `P` of `crypto/fhe.md:10`. -/
def autOp {M : Type*} (f : M → M → M) : Subgroup (Equiv.Perm M) where
  carrier := {π | Equivariant π f}
  one_mem' := by intro x y; rfl
  mul_mem' := by
    intro a b ha hb x y
    show a (b (f x y)) = f (a (b x)) (a (b y))
    rw [hb x y, ha (b x) (b y)]
  inv_mem' := by
    intro a ha x y
    apply a.injective
    have hz : ∀ z : M, a (a⁻¹ z) = z := by simp
    rw [hz, ha (a⁻¹ x) (a⁻¹ y), hz, hz]

/-- Keys for two operations are the intersection of two subgroups, hence a subgroup: the
key entropy of a two-operation scheme is `log₂` of the order of `autOp f ⊓ autOp g`. -/
def autOp₂ {M : Type*} (f g : M → M → M) : Subgroup (Equiv.Perm M) :=
  autOp f ⊓ autOp g

/-- A usable key must fix the two-sided identity of the operation it preserves.

Two-sidedness is load-bearing and not a convenience: with only a right identity the
statement is false, as `f x y = x` witnesses -- there every element is a right identity
and no permutation is constrained at all. -/
theorem fixes_identity {M : Type*} (f : M → M → M) (e : M)
    (hl : ∀ x, f e x = x) (hr : ∀ x, f x e = x)
    (π : Equiv.Perm M) (h : Equivariant π f) : π e = e := by
  -- equivariance plus surjectivity make `π e` a right identity as well
  have hright : ∀ z : M, f z (π e) = z := by
    intro z
    have h1 := h (π.symm z) e
    rw [hr (π.symm z), Equiv.apply_symm_apply] at h1
    exact h1.symm
  calc π e = f e (π e) := (hl (π e)).symm
    _ = e := hright e

/-- **Two operations with different identity elements pin two points of the key.** This
is the mechanism behind the collapse measured in experiment A' of the Python search:
on `GF(2^k)` addition has identity `0` and multiplication identity `1`, so every usable
key fixes both, and only the `k` Frobenius maps survive. -/
theorem fixes_two_identities {M : Type*} (f g : M → M → M) (e e' : M)
    (hfl : ∀ x, f e x = x) (hfr : ∀ x, f x e = x)
    (hgl : ∀ x, g e' x = x) (hgr : ∀ x, g x e' = x)
    (π : Equiv.Perm M) (h : π ∈ autOp₂ f g) : π e = e ∧ π e' = e' := by
  rw [autOp₂, Subgroup.mem_inf] at h
  exact ⟨fixes_identity f e hfl hfr π h.1, fixes_identity g e' hgl hgr π h.2⟩

/-! ## 2. Key entropy against expressive power

The essay's central claim, and the one the palette table of experiment A'' measures
numerically: a scheme has nonzero key entropy if and only if it cannot compute
everything. The proof is two lines, and the operation it exhibits is a constant. -/

/-- A constant operation is preserved by exactly the keys fixing that constant. -/
theorem const_equivariant_iff {M : Type*} (π : Equiv.Perm M) (c : M) :
    Equivariant π (fun _ _ => c) ↔ π c = c :=
  ⟨fun h => h c c, fun h _ _ => h⟩

/-- **Key entropy costs completeness, exactly.** If even one nonidentity key is usable,
some operation is not evaluable under the strict model. Contrapositive: a functionally
complete palette forces the key space to be trivial, i.e. zero key bits. -/
theorem nontrivial_key_incomplete {M : Type*} (π : Equiv.Perm M) (hπ : π ≠ 1) :
    ∃ f : M → M → M, ¬ Equivariant π f := by
  have : ∃ c : M, π c ≠ c := by
    by_contra hcon
    push_neg at hcon
    exact hπ (Equiv.ext hcon)
  obtain ⟨c, hc⟩ := this
  exact ⟨fun _ _ => c, fun h => hc ((const_equivariant_iff π c).mp h)⟩

/-- The converse direction, stated for completeness: if every operation is evaluable
then the key space is trivial. -/
theorem complete_forces_trivial_key {M : Type*} (π : Equiv.Perm M)
    (h : ∀ f : M → M → M, Equivariant π f) : π = 1 := by
  by_contra hπ
  obtain ⟨f, hf⟩ := nontrivial_key_incomplete π hπ
  exact hf (h f)

/-! ## 3. Two exhaustive instances, matching the Python search -/

/-- Experiment A, one bit: the only *bijection* of `Bool` commuting with both `and` and
`xor` is the identity, so a one-bit two-operation strict scheme has zero key bits.

Bijectivity is not decoration. Dropping it makes the statement FALSE: the constant map
`fun _ => false` commutes with `and` and with `xor` alike. It is not an encryption
because it is not invertible, which is exactly what the hypothesis records. -/
theorem bool_and_xor_only_id (π : Bool → Bool) (hπ : Function.Bijective π)
    (h₁ : ∀ x y, π (x && y) = (π x && π y))
    (h₂ : ∀ x y, π (xor x y) = xor (π x) (π y)) :
    ∀ x, π x = x := by
  revert π; decide

/-- The counterexample that forces the hypothesis, recorded so the reader need not
rediscover it: a non-injective map can be perfectly homomorphic. Homomorphism and
encryption are independent properties. -/
theorem const_false_homomorphic :
    (∀ x y : Bool, (fun _ => false) (x && y) = ((fun _ => false) x && (fun _ => false) y)) ∧
    (∀ x y : Bool, (fun _ => false) (xor x y) = xor ((fun _ => false) x) ((fun _ => false) y)) ∧
    ¬ Function.Bijective (fun _ : Bool => false) := by
  refine ⟨by decide, by decide, ?_⟩
  intro h
  exact absurd (h.1 (a₁ := true) (a₂ := false) rfl) (by decide)

/-- Experiment A' at `k = 2`: the four-element field `GF(4)`, addition as bitwise xor and
multiplication with `2` a primitive root. Exactly two maps preserve both -- the identity
and the Frobenius `x ↦ x²` -- so a two-operation deterministic bijective scheme on a
2-bit word carries exactly **one** key bit, against the one-time pad's two. -/
def add4 : Fin 4 → Fin 4 → Fin 4 :=
  ![![0, 1, 2, 3], ![1, 0, 3, 2], ![2, 3, 0, 1], ![3, 2, 1, 0]]

def mul4 : Fin 4 → Fin 4 → Fin 4 :=
  ![![0, 0, 0, 0], ![0, 1, 2, 3], ![0, 2, 3, 1], ![0, 3, 1, 2]]

theorem gf4_key_count :
    (Finset.univ.filter (fun π : Fin 4 → Fin 4 =>
        Function.Bijective π ∧
        (∀ x y, π (add4 x y) = add4 (π x) (π y)) ∧
        (∀ x y, π (mul4 x y) = mul4 (π x) (π y)))).card = 2 := by
  decide

/-- Without bijectivity the count is not 2, for the same reason as on `Bool`: the
constant-zero map is a homomorphism of both operations. Recorded so the `Function.Bijective`
conjunct above is visibly necessary rather than defensive. -/
theorem gf4_without_bijectivity :
    (Finset.univ.filter (fun π : Fin 4 → Fin 4 =>
        (∀ x y, π (add4 x y) = add4 (π x) (π y)) ∧
        (∀ x y, π (mul4 x y) = mul4 (π x) (π y)))).card ≠ 2 := by
  decide

/-! ## 4. The randomised model: algebra is never the obstruction

Drop the requirement that encryption be a bijection. Decryption is a surjection
`d : C → M` from a large ciphertext space; a ciphertext is any preimage, and the
encryptor is free to choose one at random. Then a correct evaluation operation exists
for *every* plaintext operation, simultaneously, with no constraint whatsoever. -/

/-- **Existence is free.** For any surjective decryption and any plaintext operation
there is a ciphertext operation inducing it. -/
theorem eval_exists {C M : Type*} (d : C → M) (hd : Function.Surjective d)
    (f : M → M → M) : ∃ F : C → C → C, ∀ a b, d (F a b) = f (d a) (d b) := by
  choose s hs using hd
  exact ⟨fun a b => s (f (d a) (d b)), fun a b => hs _⟩

/-- The same for an arbitrary family of operations at once: two independent operations,
sixteen, or all of them, cost nothing to arrange. Whatever makes fully homomorphic
encryption hard, it is therefore not the algebra -- it is that `d` must stay hidden even
though `F` is published. -/
theorem eval_exists_family {C M ι : Type*} (d : C → M) (hd : Function.Surjective d)
    (f : ι → M → M → M) :
    ∃ F : ι → C → C → C, ∀ i a b, d (F i a b) = f i (d a) (d b) := by
  choose s hs using hd
  exact ⟨fun i a b => s (f i (d a) (d b)), fun i a b => hs _⟩

/-- What the previous theorem does *not* say, recorded as a definition rather than a
theorem because it is a computational statement and not an algebraic one: a toy scheme is
useful only if the published `F` does not determine `d`. Experiment C of the Python search
measures exactly this quantity for small `C` and finds it fully degenerate: mean 1.000 consistent
partitions, maximum 1, at every size tested. Not even the complement survives, because flipping the
class labels turns XOR into NXOR. (An earlier version of this comment predicted 2; the measurement
said 1.) This is why real schemes never publish `F` as a table. STATED, NOT PROVED, and not provable at this level of abstraction. -/
def KeyHiding {C M : Type*} (F : C → C → C) (f : M → M → M) : Prop :=
  ∃ d₁ d₂ : C → M, d₁ ≠ d₂ ∧
    Function.Surjective d₁ ∧ Function.Surjective d₂ ∧
    (∀ a b, d₁ (F a b) = f (d₁ a) (d₁ b)) ∧
    (∀ a b, d₂ (F a b) = f (d₂ a) (d₂ b))

end FHEToy
