---
title: What Noether doesn't give you
permalink: /dreamed/discrete-noether
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badges below claim something about `docs/dreamed/lean/DiscreteNoether.lean` **only**, and are
> deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

**Seed (owner-authored, verbatim):** [physics.SE q/8518](https://physics.stackexchange.com/q/8518)
(Tobias Kienzler, uid 97, score 115, corpus row P-A, **promoted 2026-07-08**):

> Noether's theorem states that, for every *continuous* symmetry of an action, there exists a
> conserved quantity, e.g. energy conservation for time invariance, charge conservation for
> $U(1)$. Is there any similar statement for *discrete* symmetries?

# 0. The headline, stated and not teased

Noether's proof varies the fields by an infinitesimal parameter; a symmetry with no infinitesimal
version gives it nothing to vary, so **a discrete symmetry yields no conserved current**. What it
yields instead, in quantum mechanics, is a **multiplicative conserved quantum number**: a unitary
$S$ with $S^n = 1$ commuting with $H$ has eigenvalues that are $n$-th roots of unity, each
eigenvector keeps its eigenvalue under evolution, and the charges of composed symmetries
*multiply* where Noether charges *add*. The physical content is selection rules and forced
degeneracies, not a flow. The closest thing to a genuine discrete Noether charge is **Bloch
quasi-momentum, conserved modulo a reciprocal lattice vector**, and that "modulo" is exactly the
statement that the charge lives in $\mathbb{Z}_n$ (ring) or $\mathbb{R}/2\pi\mathbb{Z}$ (chain)
rather than in $\mathbb{R}$. All of the above except the classical no-go is machine-checked in
[`lean/DiscreteNoether.lean`](lean/DiscreteNoether.lean).

# 1. Noether, with the hypotheses showing

The one-sentence form (Qmechanic's, in the q/8518 answers): a **continuous, global, off-shell
symmetry of the action** implies a **local on-shell conservation law**. Three hypotheses are
doing work, and each is worth a beat in the aside:

- **Of the action, not of the equations of motion.** A symmetry of the EOM need not preserve
  $S[q]$ (scaling symmetries are the standard counterexample) and earns no charge. The spine can
  make this distinction cheaply once step 4 has an action to point at.
- **Off-shell.** The variation must be a symmetry for *all* field configurations; conservation
  then holds only on-shell.
- **Continuous.** The proof machine takes $\delta q = \epsilon\, K[q]$ and works to first order
  in $\epsilon$. Parity has no $\epsilon$. This is the load-bearing word, and it is why the
  question q/8518 has real content instead of a definition-chase.

# 2. What a discrete symmetry gives you

"Nothing" is wrong. The honest inventory has five entries.

## 2.1 Not a conserved current

Parity, time reversal and charge conjugation have no classical Noether charge and no current.
The q/8518 answer by mathphysicist states the reason in one line (no infinitesimal form, hence
no characteristic to build the current from); the accepted answer (user566) adds the structural
reason a *finite* group cannot even in principle have a local conservation law: a locally
conserved density must vary continuously in space, and a $\mathbb{Z}_n$ label cannot.

## 2.2 A multiplicative conserved quantum number

Quantum mechanics changes the game because the symmetry becomes an *operator*. If $S^n = 1$ and
$[S, H] = 0$, then

$$S\psi = \mu\,\psi,\ \psi \neq 0 \implies \mu^n = 1 \veq{zn-charge}\lean$$

so the charge is an $n$-th root of unity, a $\mathbb{Z}_n$ label. Parity is the $n = 2$ case:

$$P^2 = 1,\ P\psi = \mu\,\psi,\ \psi \neq 0 \implies \mu = 1 \ \text{or}\ \mu = -1 \veq{parity}\lean$$

Conservation is the statement that evolution keeps a state inside its eigenspace: for any $U$
commuting with $S$,

$$S\psi = \mu\,\psi \implies S(U\psi) = \mu\,(U\psi) \veq{stays}\lean$$

and $[S, H] = 0$ delivers such a $U = e^{-iHt}$ via the sibling essay
`time-and-operators.md` (its `TimeEvolution.lean` proves `U_commute`). The sharpest single
sentence for the aside: **composing two discrete symmetries multiplies their charges, while a
continuous one-parameter family adds its labels**, $e^{itE}e^{isE} = e^{i(t+s)E}$; the additive
charge of Noether and the multiplicative charge of parity are the two group laws of
$\mathbb{R}$ and $\mathbb{Z}_n$ wearing physics. Both halves of the contrast are theorems
(`charges_multiply`, `phase_additive`), not slogans.

## 2.3 Selection rules

The physical cash value of a multiplicative charge is what it *forbids*. If initial and final
states carry different $\mathbb{Z}_n$ labels, the amplitude between them vanishes for a
symmetric $H$; the accepted answer states exactly this for parity ("otherwise the amplitude for
it is zero"). Concretely in the Lean file: the hopping Hamiltonian on a 3-site chain commutes
with the reflection $P_3$, so it maps the even sector to the even sector
(`H3_preserves_parity`); no dynamics generated by it ever connects $(1,0,1)$ to $(1,0,-1)$.
A discrete symmetry polices transitions instead of conserving a flow.

## 2.4 Degeneracy

A symmetry group, discrete or continuous, acts on each energy eigenspace, so eigenspaces
decompose into irreps and every irrep of dimension $d > 1$ forces a $d$-fold degeneracy. This is
the one structural consequence that does not care whether the group has an infinitesimal form.
(Not formalized here; representation theory of finite groups in Lean is a separate outing.)

## 2.5 Bloch: the best answer, and the accepted answer's key distinction

The accepted answer's central move is to split "discrete symmetry" into **finite** and
**infinite discrete**. For an infinite discrete group like lattice translations the conserved
quantity is *continuous but periodic*: quasi-momentum, conserved modulo a reciprocal lattice
vector, with genuinely local conservation just as in the continuous case. This is the closest
thing to a discrete Noether charge, and it is quantitative. On the 1D chain (lattice constant
$1$), $\psi_q(x) = e^{iqx}$ is a translation eigenvector with eigenvalue $e^{iq}$, and

$$\psi_{q + 2\pi}(x) = \psi_q(x) \veq{umklapp}\lean$$

with the sharp converse that two quasi-momenta give the *same* eigenvalue **iff** they differ by
an integer multiple of $2\pi$ (`translation_eigenvalue_eq_iff`): the conserved label is a point
of the circle, full stop. On a ring of $n$ sites the two stories fuse: translation satisfies
$T^n = 1$ (`translate_pow_n`), so §2.2's theorem applies verbatim and the quasi-momentum label
is an $n$-th root of unity, conserved modulo $n$ (`ring_quasimomentum`). Umklapp scattering is
this arithmetic happening to phonons.

```computation
bloch_eigenvalue = exp(I*q)
umklapp = Eq(exp(I*(q + 2*pi)), exp(I*q))
ring_charge = Eq(exp(2*pi*I*k/n)**n, 1)
```

Two q/8518 answers extend the map beyond this essay's scope, worth naming so the aside can
footnote them: Qmechanic builds an honest *variational* discrete Noether theorem on a lattice
world (Baez and Gilliam 1994: with discrete time and a cyclic variable, the discrete momentum
$p_{t+1/2} = \partial L_t/\partial v_{t+1/2}$ is exactly conserved; the price is letting the
*virtual* variations leave the lattice), and Nikos M. cites Ashton 2008, where for *linear*
PDEs with (skew-)self-adjoint operator every symmetry of the operator, including CPT-like
discrete ones, generates a conservation law. Both are genuine "similar statements"; neither is
the general-Lagrangian theorem the question asks for, which is why the accepted answer's
charge/selection-rule story remains the canonical reply.

# 3. The converse direction (row P-B, briefly)

The owner's follow-ups [q/8626](https://physics.stackexchange.com/q/8626) (can *all* conserved
quantities of an $N$-DOF system be explained by symmetries with $N$ parameters?) and
[q/8860](https://physics.stackexchange.com/q/8860) (what counts as a DOF in the first place) are
the inventory sibling. One q/8518 answer (Kalitvianski's "sobering thoughts": any system has
$2N - 1$ locally conserved combinations of initial data regardless of symmetry) actually lives
in that row's territory: it is the observation that makes the converse *interesting*, since
generic integrals of motion are non-local ugly functions and the Hamiltonian converse (every
conserved $Q$ generates a symmetry via its own flow, $\dot{q} = \{q, Q\}$) trades one conserved
quantity for one symmetry only when $Q$ is a decent function on phase space. The discrete case
is precisely where the correspondence breaks: a $\mathbb{Z}_n$ charge has no generator to flow
along. Not developed further here; P-B is still inventory, not promoted.

# 4. Where this belongs in the spine

Corpus row P-A files this as "step 4 <-> 1", and the link is real: step 4 (Lie groups,
generators, Noether, `[Q,H] = 0`) is where the theorem lives, but step 1 is where the *discrete*
groups live (the permutation group $S_n$ enters there as the first non-commutative example, and
reversibility motivates inverses). The spine's very first move is splitting $\lvert 42\rangle$
into subsystems, and the reason a subsystem carries conserved *labels* at all is symmetry; the
aside closes that loop by saying which kind of label which kind of symmetry can fund: additive
real labels from continuous symmetries, multiplicative $\mathbb{Z}_n$ labels from finite ones,
circle-valued labels from lattice translations.

**Proposal (owner's to ratify, with cost).** An aside box at the end of the step 4 chapter,
after `[Q,H] = 0` is in hand, titled "What Noether doesn't give you", opening sentence:

> Noether's machine has a hard input requirement: the symmetry must come with a dial you can
> turn by $\epsilon$; parity is a switch, not a dial, and switches earn a different wage.

Form: the ratified D4 ("everyone, layered reading") makes an aside the right container, since
the "everyone" reader gets the switch/dial sentence and the selection-rule idea while the
physicist layer gets $\mathbb{Z}_n$ charges and umklapp; the ratified D3 epistemic-status tags
give it a home (this material is textbook-solid, so it would carry the highest confidence tag,
unlike its speculative `dreamed/` siblings). Cost: step 4 is unauthored; writing the aside first
risks the tail wagging the chapter, and the Bloch half may fit step 6 (lattice/field material)
better than step 4. Both placements are defensible; the owner should pick one, not the agent.

# 5. Follow-up leads (each one sentence, with what would decide it)

1. **Author the aside itself**: decidable by the owner writing it into the step 4 chapter when
   that chapter exists; squarely inside `id:e552` owner-only scope, this essay is at most quarry.
2. **Promote row P-B**: decidable by an owner reading of q/8626's answers against the aside's §3
   paragraph to see whether the converse deserves its own rigor-debt aside; promotion is an
   owner call (the corpus contract reserves status flips to him).
3. **Degeneracy-from-irreps in Lean**: decidable by checking whether Mathlib's
   `RepresentationTheory` can state "commutant acts on eigenspaces" at reasonable cost; tooling,
   so relay-eligible, but pointless before the owner wants §2.4 load-bearing.
4. **Time reversal / antiunitarity**: decidable by attempting `Commute`-style statements for an
   antilinear operator in Mathlib (semilinear maps exist); the physics narrative around it is
   owner-only, the Lean feasibility probe is not.
5. **Discrete variational Noether (Baez-Gilliam) as a checked example**: decidable by
   formalizing Qmechanic's cyclic-variable lattice argument (finite sums, no analysis); a clean
   candidate for a future dreamed batch, owner-seeded since picking it is direction.

# Lean attestation

File: [`docs/dreamed/lean/DiscreteNoether.lean`](lean/DiscreteNoether.lean). Checked 2026-09-01
from `verify/` (outside the lake targets, cannot affect `make test`) with

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/DiscreteNoether.lean
```

exit status **0**, zero `sorry`, zero warnings. Theorems, in essay order:
`eigenvalue_pow_eq_one` (badge `zn-charge`), `parity_eigenvalue` (badge `parity`),
`eigenvector_stays` (badge `stays`), `charges_multiply`, `phase_additive` (the
multiplicative-vs-additive contrast), `P3_sq`, `P3_comm_H3`, `P3_even`, `P3_odd`,
`H3_preserves_parity`, `P3_eigenvalue_pm_one` (explicit 3-site parity),
`blochWave_translate`, `quasimomentum_umklapp` (badge `umklapp`),
`translation_eigenvalue_eq_iff`, `translate_pow_apply`, `translate_pow_n`,
`ring_quasimomentum` (Bloch). Named hypotheses throughout (`horder : S ^ n = 1`,
`hcomm : Commute S U`); finiteness and commutation are never smuggled in.

Deliberate weakenings, stated: the continuous side ($U(t) = e^{-iHt}$, its group law, and
`Commute A H -> Commute A (U t)`) is **cited from the sibling** `TimeEvolution.lean`, not
reproved; classical Noether (actions, currents) is not formalized at all, so §1 rests on the
literature, not on Lean; §2.4 (degeneracy) and everything about antiunitary time reversal is
prose only.

# Surfaced for the owner

- The corpus row's one-line summary ("Noether for discrete symmetries") is faithful to q/8518,
  but the *accepted answer's* finite-vs-infinite-discrete split is the essay-shaping fact a
  summary cannot carry; if the aside gets authored, that split deserves to be its skeleton.
- Kalitvianski's q/8518 answer is P-B material misfiled under P-A; worth a cross-reference note
  in `docs/se-corpus.md` if the owner agrees (not written there by this agent).
- The proposed opening sentence and the step 4 vs step 6 placement question in §4 are open
  decisions, presented with costs; nothing has been filed into any ledger.
