/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into any `*.toml` sidecar or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/zkml-proofs.md`, on the owner's
  seed: "if we find a FHE-LLM, next dream can be zero knowledge / trustless distributed
  AI" -- the zkML half.

  This file has NO owner-authored source; it is systems security, not physics.

  The essay's job was to decide whether the zkML proving gap is STRUCTURAL or
  ENGINEERING. Its answer is "engineering, and the real wall is somewhere else". Four
  design conclusions carry that answer, and they are what is formalised here.

    `perParam_decreasing`   the criterion itself, made precise. A cost that grows
                            SUBLINEARLY in model size has a per-parameter overhead that
                            SHRINKS. Measured proving times for zkLLM's 7B/13B pair
                            satisfy the hypothesis, so the observed gap is a constant
                            factor rather than a widening one. A structural wall would
                            show up as the opposite inequality.

    `pinned_relation_certifies` / `relation_not_certifies`
                            the Hollow-LLM gap, both halves. A zkML proof establishes
                            an EXISTENTIAL over weights ("some weights consistent with
                            the commitment produce this output"). That does NOT imply
                            the promised weights ran -- there is an explicit
                            counterexample. Pinning the weights publicly closes it. So
                            the zero-knowledge property over the weights is exactly
                            what costs you the identity guarantee.

    `requiredRate_commit_le` commit-then-challenge beats blind-audit. In the sibling
                            essay `model-attestation.md` the audit rate needed to deter
                            a provider blows up as its ability `d` to RECOGNISE audits
                            approaches 1. If the provider must commit to its transcript
                            before the challenge is drawn, `d` drops out of the
                            arithmetic entirely. This matters because a demanded proof
                            is self-announcing: sampled zkML sits at d = 1 and would
                            otherwise be worthless.

    `amortised_bond_tendsto_one`
                            a large enough bond makes sampled proving arbitrarily close
                            to free, at fixed proving overhead. This is why a 3000x
                            per-request cost is not the end of the discussion.

    `naive_composition_costly`
                            proving a homomorphic evaluation by simulating it inside
                            the circuit multiplies the two overheads. Trivial as
                            arithmetic; it is here because the essay's section 6 rests
                            on it and the trivial direction is the one people skip.

  Check with:
    cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/ZkmlProofs.lean
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace ZkmlProofs

/-! ## 1. Structural or engineering: the criterion

The essay's whole question is whether the proving gap is a constant factor or a
growing one. That is a statement about the per-parameter cost, not about the total.
The only content here is that "sublinear growth" and "shrinking overhead ratio" are
the same statement, which is worth pinning down before any measurement is read into
one of them. -/

/-- **Sublinear growth means shrinking overhead.** If a larger model's proving time
grew by less than its parameter count did, then the proving cost *per parameter*
strictly fell. Inference cost is proportional to parameters, so this is exactly the
ratio the essay calls "the overhead", and the hypothesis is what zkLLM's own 7B/13B
measurements satisfy (`803/620 = 1.295 < 1.857 = 13/7`).

A structural wall is the reverse inequality: overhead that grows without bound as
models do. Nothing in the measured data has that shape. -/
theorem perParam_decreasing (p₁ p₂ t₁ t₂ : ℝ) (hp₁ : 0 < p₁) (hp₂ : 0 < p₂)
    (hsub : t₂ * p₁ < t₁ * p₂) :
    t₂ / p₂ < t₁ / p₁ := by
  rw [div_lt_div_iff₀ hp₂ hp₁]
  linarith

/-- The converse direction, stated so the criterion is not read as one-way: superlinear
growth really does mean the overhead widens. Together these say the essay's
structural-versus-engineering test is exactly the sublinearity test and nothing more. -/
theorem perParam_increasing (p₁ p₂ t₁ t₂ : ℝ) (hp₁ : 0 < p₁) (hp₂ : 0 < p₂)
    (hsup : t₁ * p₂ < t₂ * p₁) :
    t₁ / p₁ < t₂ / p₂ := by
  rw [div_lt_div_iff₀ hp₁ hp₂]
  linarith

/-! ## 2. What a zkML proof actually says about model identity

This is the essay's central correction, and the Hollow-LLM attack (arXiv 2607.28884)
is the concrete instance. A proof of inference certifies membership in an NP relation:
there EXIST private weights, consistent with a commitment, such that running the public
architecture on the input yields the output. The quantifier is existential, and that is
precisely the zero-knowledge property doing its job.

The seed's question -- "did the promised model run" -- is a different, universal-flavour
claim about WHICH weights. The two are not the same, and no amount of prover speed
closes the difference. -/

/-- What the verifier wants: the promised weights `w₀` really produced this output. -/
def Certifies {W I O : Type*} (eval : W → I → O) (w₀ : W) (i : I) (o : O) : Prop :=
  eval w₀ i = o

/-- What a zero-knowledge proof of inference actually establishes: *some* admissible
weight vector produces this output on the public architecture. `Admissible` stands for
"opens the published commitment"; in the zero-knowledge setting the verifier knows only
that such a witness exists. -/
def ProvenRelation {W I O : Type*} (eval : W → I → O) (Admissible : W → Prop)
    (i : I) (o : O) : Prop :=
  ∃ w, Admissible w ∧ eval w i = o

/-- The easy direction, which is all soundness gives you: an honest provider's proof is
a valid proof. -/
theorem certifies_implies_relation {W I O : Type*} (eval : W → I → O)
    (Admissible : W → Prop) (w₀ : W) (i : I) (o : O)
    (hadm : Admissible w₀) (h : Certifies eval w₀ i o) :
    ProvenRelation eval Admissible i o :=
  ⟨w₀, hadm, h⟩

/-- **The Hollow-LLM gap, as an explicit counterexample.** A valid proof can exist for
an output the promised weights never produce. The witness here is deliberately as small
as the statement allows -- the point is not that the counterexample is deep, it is that
the implication people read into a zkML proof is *false*, and one line of Lean is enough
to say so.

The real attack is this shape with content: the provider commits to weights of the
declared size and shape whose algebraic structure collapses the effective computation
to a much smaller model. Every check the verifier can run passes. -/
theorem relation_not_certifies :
    ∃ (W I O : Type) (eval : W → I → O) (Admissible : W → Prop) (w₀ : W) (i : I) (o : O),
      Admissible w₀ ∧ ProvenRelation eval Admissible i o ∧ ¬ Certifies eval w₀ i o := by
  refine ⟨Bool, Unit, Bool, fun w _ => w, fun _ => True, true, (), false, trivial, ?_, ?_⟩
  · exact ⟨false, trivial, rfl⟩
  · simp [Certifies]

/-- **And how to close it: stop hiding the weights.** If the admissible set is the
singleton `{w₀}` -- the commitment opens to a *publicly known* weight vector, as it can
for an open-weights model or any published checkpoint -- then the existential collapses
and the proof does certify identity.

This is the essay's design conclusion. The zero-knowledge property over the weights is
not free: it is exactly what you trade away the identity guarantee for. A provider that
wants to prove it ran Llama-3-70B can do so; a provider that wants to keep its weights
secret cannot, and no improvement in proving speed changes that. -/
theorem pinned_relation_certifies {W I O : Type*} (eval : W → I → O) (w₀ : W) (i : I)
    (o : O) (h : ProvenRelation eval (fun w => w = w₀) i o) :
    Certifies eval w₀ i o := by
  obtain ⟨w, hw, hev⟩ := h
  rw [Certifies, ← hw]
  exact hev

/-! ## 3. Sampled proving, and why commitment beats blindness

The sibling essay `model-attestation.md` derives the audit rate needed to deter a
provider that saves `s` per request against a bond `D` and can recognise an audit with
probability `d`: it is `s / (D (1 - d))`, unbounded as `d -> 1`.

Sampled zkML sits at `d = 1`. A demanded proof announces itself: the provider learns
which requests are checked at the moment it is asked to prove them. Under that essay's
model, sampled zkML deters nothing.

The fix is not cryptographic exotica, it is ordering. Make the provider commit to the
transcript when it serves, and draw the challenge afterwards. The cheat decision is
then taken before the audit decision exists, so `d` never enters. -/

/-- The sibling essay's rate, repeated here so the comparison is in one file. -/
noncomputable def requiredRate (s D d : ℝ) : ℝ := s / (D * (1 - d))

/-- The commit-then-challenge rate: no dependence on `d` at all. -/
noncomputable def requiredRateCommit (s D : ℝ) : ℝ := s / D

/-- **Committing first is never worse, and is strictly better whenever the provider has
any ability to recognise an audit.** This is the theorem that rescues sampled zkML from
the `d = 1` catastrophe of the sibling essay: a self-announcing proof request is fatal
under blind auditing and harmless under commit-then-challenge. -/
theorem requiredRate_commit_le (s D d : ℝ) (hs : 0 < s) (hD : 0 < D) (hd0 : 0 ≤ d)
    (hd1 : d < 1) :
    requiredRateCommit s D ≤ requiredRate s D d := by
  unfold requiredRate requiredRateCommit
  have hb : 0 < D * (1 - d) := by nlinarith
  rw [div_le_div_iff₀ hD hb]
  nlinarith [mul_nonneg (mul_nonneg hs.le hD.le) hd0]

/-- Strictly better as soon as `d > 0`. -/
theorem requiredRate_commit_lt (s D d : ℝ) (hs : 0 < s) (hD : 0 < D) (hd0 : 0 < d)
    (hd1 : d < 1) :
    requiredRateCommit s D < requiredRate s D d := by
  unfold requiredRate requiredRateCommit
  have hb : 0 < D * (1 - d) := by nlinarith
  rw [div_lt_div_iff₀ hD hb]
  nlinarith [mul_pos (mul_pos hs hD) hd0]

/-! ## 4. Why a 3000x per-request overhead is not the end of the discussion -/

/-- Total bill relative to honest serving, when a fraction `r` of requests carries a
proof costing `ov` times the inference. -/
noncomputable def amortised (r ov : ℝ) : ℝ := 1 + r * ov

/-- **A budget converts directly into an audit rate.** If you are willing to pay a
factor `1 + F`, you can prove a fraction `F / ov` of requests. At `ov = 3000` a
doubling of the bill buys one proof in three thousand. -/
theorem amortised_budget (F ov : ℝ) (hov : 0 < ov) (r : ℝ) (hr : r ≤ F / ov) :
    amortised r ov ≤ 1 + F := by
  unfold amortised
  have : r * ov ≤ (F / ov) * ov := by nlinarith
  rw [div_mul_cancel₀ F (ne_of_gt hov)] at this
  linarith

/-- **A large enough bond makes sampled proving arbitrarily cheap.** At the deterrence
rate `r = s / D`, the total bill is `1 + s * ov / D`, which can be brought within any
`ε > 0` of honest serving by raising `D` -- at *fixed* proving overhead `ov`.

This is why the essay declines to treat the measured 3000x as a verdict. The per-request
cost sets the exchange rate between capital (the bond) and compute; it does not by
itself decide affordability. -/
theorem amortised_bond_tendsto_one (s ov ε : ℝ) (hs : 0 < s) (hov : 0 < ov)
    (hε : 0 < ε) :
    ∃ D : ℝ, 0 < D ∧ amortised (s / D) ov < 1 + ε := by
  have hεne : ε ≠ 0 := ne_of_gt hε
  have hDpos : (0 : ℝ) < s * ov / ε + 1 := by positivity
  refine ⟨s * ov / ε + 1, hDpos, ?_⟩
  unfold amortised
  have hstep : s / (s * ov / ε + 1) * ov = s * ov / (s * ov / ε + 1) := by
    field_simp
  rw [hstep]
  have hexp : ε * (s * ov / ε + 1) = s * ov + ε := by
    field_simp
  have hlt : s * ov / (s * ov / ε + 1) < ε := by
    rw [div_lt_iff₀ hDpos, hexp]
    linarith
  linarith

/-! ## 5. Composing with FHE -/

/-- **Naive composition multiplies.** Proving a homomorphic evaluation by expressing
that evaluation as the arithmetic circuit costs the product of the two overheads, and a
product of factors each at least one is at least either factor. Stated because the
essay's recommendation against the naive route rests on it, and because the arithmetic
being obvious is not a reason to leave the design conclusion unanchored. -/
theorem naive_composition_costly (a b : ℝ) (ha : 1 ≤ a) (hb : 1 ≤ b) :
    a ≤ a * b ∧ b ≤ a * b := by
  constructor
  · nlinarith
  · nlinarith

/-- What this file does NOT establish, recorded as a definition because it is an
empirical claim about a particular proof system and not a theorem: that the prover's
work really is bounded by a constant multiple of the inference's, uniformly in model
size. The measurements support it over the one decade tested (124M to 13B) and the
sumcheck literature gives a mechanism -- Thaler's matrix-multiplication protocol proves
an `n x n` product with `O(n^2)` extra work against the product's own `O(n^3)` -- but
"uniformly, for all future architectures" is not something two data points and an
asymptotic can deliver. STATED, NOT PROVED. -/
def ConstantFactorOverhead (proveCost inferCost : ℕ → ℝ) : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∀ n, proveCost n ≤ C * inferCost n

/-- Also not established, and the more interesting of the two: that a provider forced
to commit before the challenge cannot adapt. Sequencing is only as good as the binding,
and a commitment that the provider can equivocate on -- or a challenge it can predict
because the client's sampling is deterministic, or seeded from something it supplies --
restores exactly the `d = 1` failure that section 3 removed. STATED, NOT PROVED. -/
def ChallengeUnpredictable {Req Chal : Type*} (view : Req → Chal → Prop) : Prop :=
  ∀ r : Req, ∀ c₁ c₂ : Chal, view r c₁ ↔ view r c₂

end ZkmlProofs
