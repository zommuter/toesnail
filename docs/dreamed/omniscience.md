---
title: Is omniscience impossible?
permalink: /dreamed/omniscience
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/` or `essays/` without the owner authoring the move himself. The `\veq`
> badge below claims something about `docs/dreamed/lean/Omniscience.lean` **only**, and is
> deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

**Seed (owner-authored, verbatim, `physics/toesnail.md` "Subsystems: Divide and Conquer!"):**

> If $\ket{42}$ is known, you're omniscient and don't need to read on (since you already know
> _everything_ including this very text. **#TODO: try and proof whether omniscience is
> impossible?**). Most mortals however don't, and it is infeasible to try and know everything
> about the entire universe at all times.

# 0. The headline, stated and not teased

**Omniscience is impossible, and the proof needs no physics at all.** Not energy, not information
capacity, not Heisenberg, not the size of the universe: it is defeated by *arity*. A knower inside
the thing he knows is a map from his own states to descriptions whose domain includes his own
states, and that shape, `A -> (A -> B)`, cannot be onto whenever `B` carries a fixed-point-free
operation such as "not". That is Lawvere's fixed-point theorem (Lawvere 1969), proved from
scratch and machine-checked in [`lean/Omniscience.lean`](lean/Omniscience.lean). It is the *right*
answer to the `#TODO` rather than one of several because it is the only candidate that survives a
completed TOE: every physics-flavoured impossibility result is hostage to the physics it assumes,
and this one assumes none.

# 1. Formalising the owner's question

## 1.1 What would "knowing $\ket{42}$" mean, from inside?

The spine's own move supplies the setup. The doc splits

$$\ket{42} = \ket{\text{coin}} \otimes \ket{\text{everything else}}$$

and the knower is not a spectator: he is one of the factors. Write $A$ for the state space of
the knowing subsystem, so $\ket{42}$ decomposes as $A \otimes R$. "Knowing" is a map: each state
$a \in A$ *is* a particular state of knowledge, answering questions about the whole. Take the
questions to be yes/no with answer type $B$. A description of $\ket{42}$ assigns an answer to
every constituent, and $A$ is one of the constituents, so a description is a map $A \to B$ and
knowledge is

$$\varphi : A \longrightarrow (A \to B) \veq{omni}\lean$$

Omniscience is the statement that $\varphi$ is **point-surjective**: every description
$g : A \to B$ is actually held by some state $a$, i.e. $\forall g\, \exists a : \varphi(a) = g$.
Weaker than categorical surjectivity, and still too strong to have.

## 1.2 The diagonal

Given omniscient $\varphi$ and *any* operation $f : B \to B$ on answers, define
$g(a) := f(\varphi(a)(a))$. Omniscience hands us an $a$ with $\varphi(a) = g$. Then
$b := \varphi(a)(a)$ satisfies $\varphi(a)(a) = g(a) = f(\varphi(a)(a))$, i.e. $f(b) = b$.
So omniscience forces every operation on answers to have a fixed point. Take $B = \mathrm{Bool}$
and $f = \lnot$: negation has no fixed point, so no such $\varphi$ exists, for any $A$ whatsoever.

Read back into the doc's voice: **no subsystem's state can encode a complete truthful description
of the system containing it.** The self-application $\varphi(a)(a)$ is "what my knowledge says
about *me*", and $f$ negates it. The doc's parenthesis "*you already know everything including
this very text*" is not decoration but the load-bearing clause: it is what puts the knower's own
state back inside the description's domain.

## 1.3 Which impossibility did the owner probably have in mind?

Three candidates, and they are not equally strong.

1. **Capacity.** The knower is smaller than the universe, so he cannot store it. This is the
   reading the spine's next sentence takes ("*infeasible*"). True, and weak: quantitative,
   dependent on holography and Bekenstein bounds and on whatever the eventual theory charges per
   degree of freedom, and silent about an *infinite* knower.
2. **Disturbance.** Measuring perturbs. Quantum-specific, hostage to quantum mechanics being right.
3. **Diagonal.** The above. It counts nothing, measures nothing, assumes no dynamics. An infinite
   knower with unbounded memory in a classical, deterministic, non-chaotic universe is defeated
   just as thoroughly.

The diagonal one is strictly the strongest, and has the property a theory-of-everything project
should care about most: **it cannot be repealed by a better theory**, because the obstruction is
in the shape of the sentence, not in the world.

*Speculation, flagged:* the identification $A$ = the knower's Hilbert space is a reading, not a
theorem. Nothing in §1 uses linearity, tensor structure or normalisation, so making the argument
bite on $\ket{42}$ *specifically* rather than on "any subsystem of anything" is §3's job, and §3
does not finish it.

# 2. Four theorems that are routinely conflated

Precision here is most of this essay's value. `docs/se-corpus.md` row **M-5** welds the liar
paradox, describability-uncountability, Lawvere and the Goedel/Lean bridge into one line. They
are four different theorems with four different hypotheses.

| | Needs | Says | Applies to $\ket{42}$? |
|---|---|---|---|
| **(a) Cantor / Lawvere** | nothing but sets and functions | no point-surjection `A -> (A -> B)` when `B` has a fixed-point-free endomap | **Yes**, directly. This is the one. |
| **(b) Goedel I** | a consistent, effectively axiomatized theory interpreting enough arithmetic | that theory has a true-but-unprovable sentence | **No**, unless the owner commits to $\ket{42}$-knowledge being a recursively axiomatized formal theory. |
| **(c) Tarski undefinability** | a formal language with arithmetic | truth for a language is not definable inside it | **Nearly.** Closest in *spirit*; still needs a language, which $\ket{42}$ has not been given. |
| **(d) Wolpert / Breuer** | physics (inference devices; quantum or classical dynamics) | no device can predict/self-measure completely | **Yes, but conditionally.** They buy the physics-flavoured version at the price of assuming physics. |

- **(a)** is purely set-theoretic: no logic, no notion of proof, no consistency hypothesis.
  Cantor, Russell, the liar, Goedel I, Tarski, halting and Rice are all *instances* obtained by
  choosing `A`, `B` and `f` (Lawvere 1969; the sets-and-functions presentation is Yanofsky,
  *A universal approach to self-referential paradoxes, incompleteness and fixed points*,
  Bull. Symbolic Logic **9**(3), 362-386, 2003).
- **(b)** does **not** say "some truths are unknowable" in the loose internet sense; it says a
  *particular kind of formal system* cannot prove a particular sentence. Applying it to $\ket{42}$
  needs the large extra premise that omniscience *is* provability in an effectively axiomatized
  arithmetic theory, and that premise must be stated, not smuggled.
- **(c)** Tarski's conclusion is about *definability of truth*, not *provability*, which is why it
  fits "cannot describe your own universe from inside" best. The Lean file's `f := Not` instance
  is the liar, Tarski's engine.
- **(d)** Breuer, *The Impossibility of Accurate State Self-Measurements*, Philosophy of Science
  **62**(2), 1995: no observer can distinguish all states of a system containing that observer,
  classical or quantum, deterministic or stochastic. Wolpert, *Physical limits of inference*,
  Physica D **237** (2008) 1257-1281 (arXiv:0708.1362): observation, prediction and memory devices
  share one structure ("inference devices"), no universe contains two that each predict the other,
  and a universe holds at most one *strong* (universal) one. Cousins, not the same theorem.
  **Neither is proved in this repo and neither should be cited in `physics/` as if it were.**

**Honest gap:** I could not retrieve M-5's two math.SE posts
([q/119639](https://math.stackexchange.com/q/119639),
[q/2447217](https://math.stackexchange.com/q/2447217)); the fetch tool refuses that host. This
essay therefore does **not** know what the owner argued there and claims nothing about it.

# 3. The QM-specific echo, and what would settle it

*This whole section is speculation. It is not proved and not attested.* The doc has bras, kets and
an inner product by the time the `#TODO` appears, which is partly enough.

- $\braket{42\vert 42}$ is fine: self-*overlap* is not self-*description*, it returns one number,
  not a map.
- A complete self-measurement would need an observable $\hat{O}$ on the whole whose eigenbasis
  resolves the observer's own state, with pointer states living in the observer factor $A$. The
  map "final pointer state $\mapsto$ the eigenvalue it records" is then §1's $\varphi$ exactly,
  and the diagonal applies.
- No-cloning is a *different* obstruction with the same flavour: it forbids $\ket{\psi} \mapsto
  \ket{\psi}\otimes\ket{\psi}$ by linearity, not by diagonalisation. Two independent reasons the
  same wish fails; conflating them would be an error.

**What would settle it:** fix $\mathcal{H} = \mathcal{H}_A \otimes \mathcal{H}_R$, a unitary $U$,
and a pointer basis $\{\ket{a_i}\}$ of $\mathcal{H}_A$, then ask whether $U$ can be chosen so that
for every initial whole-state the final $A$-marginal records it. Breuer 1995 answers no, and is
the paper to read before doing this by hand.

# 4. What this buys toesnail, narratively

The spine currently motivates the subsystem split by *feasibility*: "it is infeasible to try and
know everything about the entire universe at all times". That is a practical excuse. The diagonal
upgrades it to a theorem: **the subsystem decomposition is forced, not chosen.** You do not split
$\ket{42}$ because you are busy, but because no inhabitant of it can hold it.

Genuine strengthening or rhetorical flourish? *Genuine, with one caveat.* Genuine because the
spine's method is "math on demand", and this is the earliest point in the document where a piece
of mathematics is *demanded by the narrative rather than imported for later use*. The caveat: it
is a theorem about *any* self-containing knower, so it justifies "split it" without justifying
"split it *this* way, into weakly-interacting parts". That choice stays motivated by feasibility.

**Suggested placement (a proposal, not a decision).** One paragraph, immediately after the
`#TODO` sentence, before "Let us therefore split":

> It is worse than infeasible: it is impossible, and not for want of a bigger notebook. Anything
> that knows $\ket{42}$ is *part* of $\ket{42}$, so its knowledge is a function whose input space
> includes itself. Ask it what it says about itself, then flip the answer, and you have written
> down a description it cannot be holding. This is Cantor's diagonal wearing a lab coat, and no
> future theory repeals it. So we split, not out of laziness, but because the alternative is a
> contradiction.

# 5. The Lean4 bridge the owner flagged (M-5), verified

Checked, not assumed:

- **Mathlib** (verified against the Mathlib4 docs) has `Function.cantor_surjective {α : Type u} (f : α → Set α) : ¬Surjective f` and
  `Function.cantor_injective {α : Type u} (f : Set α → α) : ¬Injective f`, both in
  `Mathlib/Logic/Function/Basic.lean`. It does **not**, as far as I found, ship Lawvere in the
  general `A -> (A -> B)` form; hence the dreamed file proves it rather than importing it.
- **FormalizedFormalLogic/Foundation** (Lean 4) states that it formalizes Goedel I *and* II,
  alongside first-order completeness, cut-elimination and modal logic. I read the project's own
  description and index, **not** the proof terms: treat "gap-free" as their claim, not as
  something this session verified.

**What toesnail could exercise at its `\lean` tier:** §1's argument, in full, today. Eight lines
of real proof, about a second against the existing `v4.30.0-rc2` Mathlib pin, no new dependency.
**What it could not:** Goedel I. Vendoring `Foundation` means a second Mathlib-scale dependency
and a second toolchain pin to keep in sync with `verify/lean-toolchain` (provenance rule in
`CLAUDE.md`: derived from the vendored Mathlib rev, never hand-edited), paid for one narrative
aside. Recommendation for the owner to accept or reject: **cite `Foundation`, do not vendor it**,
and keep the repo's `\lean` tier on the Lawvere lemma, which is the theorem the argument needs.

# Lean attestation

File [`docs/dreamed/lean/Omniscience.lean`](lean/Omniscience.lean), namespace
`Toesnail.Omniscience`. Command, from `verify/`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Omniscience.lean
```

**Exit status 0, no output, no `sorry`.** Under 2 s on warm Mathlib oleans. `Not`'s
fixed-point-freeness goes through `iff_not_self`, hence classical; the `Bool` version is `decide`
and constructive.

| theorem | statement |
|---|---|
| `lawvere` | `(φ : A → (A → B)) (hφ : ∀ g, ∃ a, φ a = g) (f : B → B) : ∃ b, f b = b` |
| `no_pointSurjective_of_fixedPointFree` | contrapositive: fixed-point-free `f` kills every point-surjective `φ` |
| `no_self_describing_subsystem` | `B := Bool`, `f := not`: no point-surjective `φ : A → (A → Bool)` |
| `not_ne_self` | `(p : Prop) : (¬p) ≠ p` -- the liar has no home in `Prop` |
| `no_self_describing_subsystem_prop` | `Prop`-valued form; `f := Not` |
| `cantor_no_surjection` | `(φ : A → Set A) : ¬ Function.Surjective φ`, derived from the above |
| `omniscience_impossible` | `¬ ∃ φ : A → (A → Prop), ∀ g, ∃ a, φ a = g` |

`cantor_no_surjection` is the **same** statement as Mathlib's `Function.cantor_surjective`, not a
strengthening: it re-derives it to display Cantor as an instance of the diagonal. Mathlib's dual
`cantor_injective` is not derived. The `\veq{omni}\lean` badge in §1.1 marks the arity claim and
its impossibility of being onto; per `docs/dreamed/README.md` it is scoped to this file and is
**not** a sidecar attestation.

# A future `.mw` sketch

What a `.mw` document would carry, in the style of `verify/mirror/resogram_esol.mw`. Sketch of
intent, not a runnable mirror; being Lean-tier claims, a real `.mw` version routes them to the
Lean backend, not SymPy.

```computation
# handle: omni. Knowledge of a self-containing whole has this arity, necessarily.
phi : A -> (A -> B)
g = lambda a: f(phi(a)(a))          # the diagonal omniscience would have to realise
```

```computation
# Lawvere: point-surjectivity of phi forces a fixed point of every f,
# and negation on Bool has none, so phi is never point-surjective.
lawvere = Implies(ForAll(g, Exists(a, Eq(phi(a), g))), Exists(b, Eq(f(b), b)))
omni    = Not(ForAll(g, Exists(a, Eq(phi(a), g))))   # with B = Bool, f = Not
```

# Follow-up leads

1. **Does Breuer's obstruction reduce to §1's diagonal or is it independent?** Decidable by
   writing §3's unitary self-measurement out and seeing whether the impossibility survives
   dropping unitarity; if it does, it was the diagonal all along.
2. **The describability half of M-5 (q/2447217).** Decidable by fetching the post from a session
   that can reach math.stackexchange.com and checking whether the owner's argument is Cantor,
   Richard's paradox, or a third thing.
3. **Is point-surjectivity the right formalisation of "knows $\ket{42}$", or too strong?**
   Decidable by the owner saying what "knowing" means: if coarse-grained knowledge suffices, `B`
   becomes a metric space and `f` a fixed-point-free *continuous* map, which may not exist, and
   Brouwer then argues the other way.
4. **Cost of vendoring `FormalizedFormalLogic/Foundation`.** Decidable by one build against the
   existing `v4.30.0-rc2` pin: if its toolchain matches and `lake build` reuses the warm
   `~/.cache/mathlib`, §5's "too expensive" recommendation is wrong and should be reversed.
5. **Does the doc need the argument before operators are introduced?** Decidable only by the
   owner: §4's paragraph lands ~100 lines before "measurement" is defined, so it reads either as
   an early payoff or as a detour.
