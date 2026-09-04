/-
  DREAMED, UNREVIEWED. See `docs/dreamed/README.md`. Not owner-authored, not part of the
  `verify` lake target, not wired into any `*.toml` sidecar or `tests/test_verify.sh`.

  Lean attestation for the dreamed essay `docs/dreamed/model-attestation.md`, on the owner's
  question: how do you trust a trustless server to run the LLM it promised?

  This file has NO owner-authored source; it is systems security, not physics.

  The essay's central claim is a composition that runs opposite to the framing of its two
  siblings (`fhe-llm.md`, `trustless-distributed-ai.md`), both of which said FHE gives
  confidentiality and no integrity. That is true of FHE *alone* and false of FHE *plus an
  audit*, because the audit's power depends on the provider being unable to recognise it:

    `cheating_is_caught`   a provider whose behaviour is a function of what it observes
                           cannot cheat on a real request and behave on an audit, when the
                           two are observationally identical. Encryption is exactly what
                           makes them identical, so the audit becomes unevadable.

    `requiredRate_mono`    conversely, if the provider CAN recognise audits with
                           probability d, the audit rate needed to deter it grows without
                           bound as d -> 1.

    `evasion_total`        at d = 1 no audit rate whatsoever suffices. Auditing a plaintext
                           API against a published prompt set is closer to this end than is
                           comfortable.

    `waldN_log_cost`       tightening the false-accusation rate by a factor c costs only
                           log(c)/KL extra observations -- certainty is logarithmically
                           cheap, which is why sampled attestation is affordable at all.

  Check with:
    cd verify && ../docs/dreamed/capped.sh -m 6G -- lake env lean --threads=2 ../docs/dreamed/lean/ModelAttestation.lean
-/

import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Real.Basic

namespace ModelAttestation

/-! ## 1. Audit blindness

A provider is a strategy: a function from what it can observe to what it does. "Cheating"
is any behaviour we would like to catch; the only structure needed is that the provider
must decide it from its own view, since it has nothing else to decide from. -/

/-- The provider cheats or not, as a function of what it observes. -/
abbrev Strategy (View : Type*) := View → Bool

/-- **Audit blindness.** If an audit request and a real request are observationally
identical to the provider, then a provider that cheats on the real request also cheats on
the audit -- and is caught.

The mathematics is one rewrite. The content is entirely in the hypothesis `hview`, and the
essay's argument is that FHE *supplies* that hypothesis: distinguishing an encrypted audit
from an encrypted request is exactly the distinguishing task the encryption is assumed to
prevent. Under a plaintext API the hypothesis is simply false, because published audit
prompt sets are recognisable. -/
theorem cheating_is_caught {View : Type*} (σ : Strategy View) (vAudit vReal : View)
    (hview : vAudit = vReal) (hcheat : σ vReal = true) : σ vAudit = true := by
  rw [hview]; exact hcheat

/-- The contrapositive, which is the form the deterrence argument uses: a provider that
passes the audit was not cheating on the indistinguishable real request either. -/
theorem passes_audit_is_honest {View : Type*} (σ : Strategy View) (vAudit vReal : View)
    (hview : vAudit = vReal) (hpass : σ vAudit = false) : σ vReal = false := by
  rw [← hview]; exact hpass

/-! ## 2. What recognisable audits cost

Drop the blindness hypothesis. A provider that recognises an audit with probability `d`
and behaves honestly for it is caught at rate `r(1-d)` under an audit rate `r`, so the
rate needed to make cheating unprofitable is `s / (D(1-d))`. -/

/-- Audit rate required to deter a provider saving `s` per request against a bond `D`,
when it can recognise an audit with probability `d`. -/
noncomputable def requiredRate (s D d : ℝ) : ℝ := s / (D * (1 - d))

/-- **Recognisable audits are expensive.** The required audit rate is strictly increasing
in the provider's ability to spot an audit. -/
theorem requiredRate_mono (s D d₁ d₂ : ℝ) (hs : 0 < s) (hD : 0 < D)
    (h12 : d₁ < d₂) (h2 : d₂ < 1) :
    requiredRate s D d₁ < requiredRate s D d₂ := by
  unfold requiredRate
  have hb2 : 0 < D * (1 - d₂) := by nlinarith
  have hb1 : 0 < D * (1 - d₁) := by nlinarith
  rw [div_lt_div_iff₀ hb1 hb2]
  have hstep : D * (1 - d₂) < D * (1 - d₁) := by nlinarith
  exact mul_lt_mul_of_pos_left hstep hs

/-- **At perfect recognition, nothing works.** If the provider always spots the audit, the
catch rate is zero whatever the audit rate, so the deterrence condition `s < q D` is
unsatisfiable. Checking *every* request does not help, because it is honest exactly when
checked. -/
theorem evasion_total (s D r d : ℝ) (hs : 0 < s) (hd : d = 1) :
    ¬ (s < (r * (1 - d)) * D) := by
  subst hd
  simp only [sub_self, mul_zero, zero_mul]
  linarith

/-! ## 3. Certainty is logarithmically cheap

The sequential-test sample size scales as `log((1-β)/α) / KL`. The essay leans on the
consequence that a much stricter false-accusation rate costs very little, which is what
makes attestation practical: you can afford to be nearly certain before accusing a
provider. -/

/-- Wald's expected sample size for a sequential likelihood-ratio test. -/
noncomputable def waldN (kl alpha beta : ℝ) : ℝ := Real.log ((1 - beta) / alpha) / kl

/-- **Tightening the false-accusation rate by a factor `c` costs `log c / KL` extra
observations, not a factor `c` more.** Going from one wrong accusation in a hundred to one
in a million costs four extra units of `log(10)/KL`, not ten thousand times the work. -/
theorem waldN_log_cost (kl alpha beta c : ℝ) (halpha : 0 < alpha) (hbeta : 0 < 1 - beta)
    (hc : 0 < c) :
    waldN kl (alpha / c) beta = waldN kl alpha beta + Real.log c / kl := by
  unfold waldN
  have h1 : (1 - beta) / (alpha / c) = c * ((1 - beta) / alpha) := by
    field_simp
  rw [h1, Real.log_mul (ne_of_gt hc) (ne_of_gt (div_pos hbeta halpha))]
  ring

/-- What this file does NOT establish, recorded as a definition because it is an empirical
claim about a particular deployment and not a theorem: that the provider's view of an
encrypted audit really is identical to its view of an encrypted request. Ciphertexts hide
values, but timing, length, arrival pattern and account identity are not hidden by
encryption, and each is a channel by which an audit might be recognised. `hview` in
section 1 is an assumption to be engineered, not a given. STATED, NOT PROVED. -/
def AuditIndistinguishable {View Request : Type*} (view : Request → View)
    (audits requests : Set Request) : Prop :=
  ∀ a ∈ audits, ∃ r ∈ requests, view a = view r

end ModelAttestation
