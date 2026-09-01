---
title: "Casimir eigenvalue equations as field equations"
permalink: /dreamed/casimir-field-equations
---

# Casimir eigenvalue equations as field equations

**DREAMED, UNREVIEWED.** Written by an AI agent, not by the owner, not read by him.
Status contract and hard rules: [`docs/dreamed/README.md`](README.md). Nothing here is
theory, nothing here is a decision, and none of it may be moved into `physics/` except
by the owner authoring the move himself (ROADMAP `id:e552`).

Seed: `docs/se-corpus.md` row **P-C**, [physics.SE q/27195](https://physics.stackexchange.com/q/27195),
the owner's own question, **promoted 2026-07-08** (Q13 ratified,
`docs/meeting-notes/2026-07-08-1056-se-corpus-mining-and-lasercool-deepdive.md` §5b) as a
**step-5 headline exploration / epigraph**. Sibling inventory row **P-D**
([a/8627](https://physics.stackexchange.com/a/8627), "mass = Casimir `P²` of the whole
system").

---

## 0. First finding: the corpus row is not what the owner asked

Row P-C summarises q/27195 as *"Casimir eigenvalue eqs as field eqs (P²→KG, W²→spin?)"*.
The post's actual title is **"Can symmetry generators be used for quantization?"**, and the
mechanism the owner proposes is not an eigenvalue equation. It is a **variational** one.
Quoted verbatim:

> The state where the expectation value of a symmetry generator equals the conserved
> quantity must be stationary

$$ 0 \stackrel{!}{=} \delta\langle\psi|p^2-m_0^2|\psi\rangle \;\Longrightarrow\; 0 \stackrel{!}{=} (\Box+m_0^2)\psi(x) $$

That is a Rayleigh-quotient / Euler-Lagrange step, not `P²ψ = m²ψ` read off a Casimir. The
two coincide for a self-adjoint operator on a normalised state, which is why the row's
paraphrase survives, but they are different *arguments* and the owner's is the more
interesting one: it makes the field equation the **stationarity condition of a constraint**,
which is exactly what the accepted answer then generalises. His closing question is then
put as a conjecture, again verbatim:

> Does this e.g. yield the Dirac-equation for $s=\frac12$ when applied to the
> Pauli-Lubanski pseudo-vector $W_{\mu}=\frac{1}{2}\epsilon_{\mu \nu \rho \sigma} M^{\nu \rho} P^{\sigma}$
> squared (which has the expectation value $-m_0^2 s(s+1)$)?

**Two answers exist, both relevant, and neither is in the corpus row.**

**Urs Schreiber, accepted, +22.** Reframes it as the general relativistic phenomenon: time
translation is replaced by worldline-parameter translation, so the Hamiltonian *becomes a
constraint* and physical states are those annihilated by it. On the Dirac question, a
qualified **yes** that changes the mechanism: for the spinning particle the worldline
translation symmetry is refined to a worldline **supersymmetry**, and *"the odd generator of
the worldline supersymmetry turns out to be the Dirac operator. Again, states are required to
be annihilated by it and this gives the Dirac equation."* Pointer:
[nLab, spinning particle](http://ncatlab.org/nlab/show/spinning+particle).

**Misha, +7.** The colder half: *"To get the numbers you need to solve the equations, their
symmetry is not enough. Symmetry may tell you only which states should have the same energy."*

Schreiber's second paragraph is a **correction**, not a confirmation: Dirac does arrive by
annihilation-by-a-generator, but the generator is **not** `W²`. It is an odd, first-order,
square-root generator whose square is the bosonic constraint. Everything below is that
sentence made explicit.

## 1. `P² = m²` gives Klein-Gordon, with no caveat at all

With `P_μ = i∂_μ` and the mostly-minus metric the owner's own text fixes (he writes
`p² = -∂_μ∂^μ`), `P² = -\Box`, so

$$ P^2\psi = m^2\psi \iff (\Box + m^2)\psi = 0 \veq{kg-from-p2}\leanc $$

The part worth stating plainly, because it is routinely misread: **this holds for every
irreducible representation, whatever its spin.** `P²` is a Casimir; it acts as the same
scalar `m²` on every state of the irrep, including the four components of a Dirac spinor and
the four of a Proca field. Klein-Gordon is therefore **not "the spin-0 equation"**. It is the
universal mass-shell condition, satisfied component-wise by every free field of every spin.
The thing that is special about spin 0 is the *converse*: for `s = 0`, KG is the *whole*
equation of motion, and for nothing else is that true.

Put the other way: KG is **necessary** for every free field and **sufficient** only at
`s = 0`. The slogan is exactly true in that one case and in that one case only.

## 2. `W²` and spin: what it fixes, and what it leaves free

The Pauli-Lubanski vector (the owner's sign; this essay's Lean uses the opposite overall
sign, which changes `W_μ` and not `W²`) satisfies two facts.

$$ W_\mu P^\mu = 0 \veq{w-dot-p}\lean $$

identically, from `ε` antisymmetry alone. No Lie algebra, no antisymmetry of `J`, no
representation: `W` never has four independent components. And in the massive rest frame
`P^σ = (m,0,0,0)`,

$$ W_0 = 0, \qquad W_k = m\,S_k, \qquad W^2 = -m^2\left(S_1^2+S_2^2+S_3^2\right) \veq{w-rest}\lean $$

so `W² = -m² s(s+1)` **once you already know `ΣS_k² = s(s+1)` in the representation you
chose**. Note where the physics sits: `\eqref{w-rest}` is convention-arithmetic, and the
number `s(s+1)` comes from the representation, not from the Casimir equation.

Now the sharp question. Does `W²ψ = -\tfrac34 m^2 ψ` give the Dirac equation the way
`P²ψ = m²ψ` gives KG? **No, and the gap is large.** Three separate things are missing.

1. **Order.** `W²` is a second-order (in fact quadratic-in-generators) operator, and its
   eigenvalue equation is second-order. Dirac is **first-order**. The relation between them
   runs the other way: the slash operator squares to the mass-shell scalar,

   $$ (\gamma^\mu p_\mu)^2 = (p\cdot p)\,\mathbf{1} \veq{slash-sq}\lean $$

   so `(γ·p - m)ψ = 0 ⟹ (p·p)ψ = m²ψ`, and **not** conversely. Dirac is a square root of
   the `P²` Casimir equation, not a consequence of the `W²` one.
2. **Which Lorentz representation.** `s = 1/2` names an `SU(2)` label of the little group.
   It does not name a representation of the *Lorentz* group, and there are several with that
   little-group content: `(1/2,0)`, `(0,1/2)`, and the reducible `(1/2,0)⊕(0,1/2)` that
   Dirac actually uses. `W² = -\tfrac34 m^2` holds on all of them. Weyl and Dirac have the
   same `W²` and are different equations.
3. **The intertwiner.** Even after fixing `(1/2,0)⊕(0,1/2)`, the Dirac equation needs the
   specific `γ^μ` intertwining the two chiralities, i.e. the Clifford relation
   `{γ^μ,γ^ν} = 2η^{μν}`. That is a choice of *map*, not a choice of *eigenvalue*, and no
   eigenvalue equation can supply it.

**The same accounting for `s = 1`.** `W² = -2m²` on a massive spin-1 irrep. Proca,
`∂_μF^{μν} + m^2A^ν = 0`, unpacks into `(\Box + m^2)A^ν = 0` **plus** `∂_νA^ν = 0`. The KG
half is the `P²` Casimir, universal as in §1; the subsidiary condition cuts the four
components of `A^μ` down to the three of `s = 1`, and *that* is `W²`'s job -- done as a
**projector onto an irrep**, not as a dynamical equation. The honest general statement:

> `P²` supplies the dynamics; `W²` supplies the constraint that selects the irrep. Only for
> `s = 0` is there nothing to constrain, which is the only case where "the Casimir eigenvalue
> equations *are* the field equations" is literally true.

Schreiber's answer is the constructive version of the same point: the generator that gives
Dirac is the worldline-supersymmetry odd generator `Q` with `Q² ~ P² - m²`. Requiring
`Qψ = 0` is strictly stronger than requiring `Q²ψ = 0`, and it is the extra strength that
*is* the Dirac equation.

## 3. The massless seam, which is the interesting part

For `m = 0` both Casimirs vanish, `P² = 0` and `W² = 0`, and they no longer label anything.
The little group degenerates from `SO(3)` to `ISO(2)`, the Euclidean group of the plane, and
the labelling passes to **helicity**, `W_μ = λ P_μ`. Helicity is not a Casimir of the
Poincaré algebra in the sense `m²` and `s(s+1)` are: it is the eigenvalue of a generator
whose relation to `P` is a *coincidence of the null frame*.

The Lean file makes the seam explicit rather than assumed. On the null momentum
`P^σ = (E,0,0,E)`:

$$ W_0 = -W_3 \quad\text{for every } J \qquad\Longrightarrow\qquad W^2 = -\left(W_1^2+W_2^2\right) \veq{null-seam}\lean $$

The time and `z` components cancel **identically**, so `W² = 0` does **not** follow from
masslessness. It follows exactly when the two transverse components vanish, and those two
components are

$$ W_1 = E\,(J^{23}+J^{02}), \qquad W_2 = E\,(J^{31}-J^{01}) \veq{iso2-generators}\lean $$

that is, `E(S_1+K_2)` and `E(S_2-K_1)`: precisely the two "translation" generators of the
`ISO(2)` little group. Under the hypothesis that they annihilate the state, and only then,

$$ W_\mu = \lambda P_\mu, \qquad \lambda = -\tfrac12\left(J^{12}-J^{21}\right) \veq{helicity}\lean $$

**So the step from "massless" to "helicity" is an assumption with a name.** Representations
where `W_1, W_2` act nontrivially exist, are unitary and are irreducible: Wigner's
**continuous-spin** representations. They are discarded because their `ISO(2)` "translations"
have continuous spectrum, giving an unobserved continuum of internal states at fixed momentum
with no local free-field realisation. That is an **empirical** exclusion, not a mathematical
one, and it is what D3's ratified epistemic-status markers exist for: `[input]` or
`[hypothesis]`, never inside a `[derivation]`.

This is where the Casimir-equals-field-equation programme visibly tears, and it tears at the
**photon**, i.e. at `physics/photon.md`. The sibling essay
[`photon-localizability.md`](photon-localizability.md) (corpus row P-E, `-\tfrac14 F^2` and
the Proca degree-of-freedom count) reaches the same seam from the other side: it locates the
Newton-Wigner obstruction at `|λ| ≥ 1`, which is a statement about exactly the little group
that this section says stops being `SO(3)`. **Two independent dreamed essays hit the same
`ISO(2)` wall from opposite directions; that convergence is the argument for treating the
massless case as a named section rather than a footnote.**

## 4. Wigner's classification, with the discard stated as a discard

The classification of unitary irreps of the Poincaré group by `(P², W²)` orbit type:

| `P²` | orbit | little group | label | status |
|---|---|---|---|---|
| `m² > 0` | mass shell | `SU(2)` | `s = 0, 1/2, 1, 3/2, …` | physical |
| `0`, `P ≠ 0` | light cone | `ISO(2)` | helicity `λ ∈ \tfrac12 ℤ` | physical |
| `0`, `P ≠ 0` | light cone | `ISO(2)`, faithful | continuous spin `Ξ > 0` | **discarded** |
| `m² < 0` | tachyonic | `SU(1,1)` | -- | **discarded** |
| `P = 0` | vacuum | Lorentz | -- | vacuum only |

"Discarded on physical grounds" means, concretely: tachyonic irreps have no
Lorentz-invariant notion of positive energy and no stable vacuum; continuous-spin irreps have
an unobserved continuum of internal states and no local free-field realisation. Both
exclusions are **inputs**. Writing the table without the last column is the smuggle the D3
tags were ratified to prevent.

## 5. What this could give the spine, as an option and not a plan

The 2026-07-07 1228 note's ratified 11-step skeleton puts *"Spacetime symmetry:
Galilei → Poincaré; Wigner classification (Casimirs → mass, spin; little groups → helicity
for m=0)"* at **step 5**, and Q13 ratified P-C as its headline. One candidate opening
paragraph, offered as raw material for the owner to rewrite or bin:

> We have a group, and we have states. A group acting on states does not, by itself, tell you
> how anything moves. But it does tell you which operators are *blind* to the group: the ones
> that commute with everything, so that every state in one irreducible family shares their
> value. There are exactly two for the Poincaré group. Set the first equal to a number and you
> have written down the Klein-Gordon equation, for every particle there is. Set the second
> equal to a number and you have written down -- almost -- the spin. The gap in that "almost"
> is where the rest of this book lives.

**Three prerequisites, all before step 5.** (i) **The Poincaré algebra as brackets**, with
`J^{μν}`, `P^μ`, and the meaning of "commutes with everything" -- step 4. (ii)
**One-parameter groups and their generators** (Stone), so that "generator" is a thing the
reader owns rather than a word; the sibling dreamed essay
`docs/dreamed/time-and-operators.md` is being written on exactly that machinery in this same
batch. **Cite it as a dependency: without Stone, "eigenvalue equation of a generator" is not
yet meaningful and the epigraph above is decoration.** *(Not yet on disk when this essay was
written; the dependency is stated, not verified.)* (iii) **The spectral idea**, which
`physics/toesnail.md` currently defers on purpose -- its `## Observe` stub says *"Eigenvalues
of course, too, but not as 'measurement values' but rather to justify bases and such."* That
deferral is compatible with step 5 and worth keeping in view.

**What it demands mathematically:** finite-dimensional linear algebra over `ℂ`, the
Levi-Civita symbol, and one 4x4 matrix computation. Nothing analytic -- unusually cheap for
the payoff, and a real argument for the promoted step-5 placement. **What it does not demand,
and should not sneak in:** induced representations, Mackey theory, or any construction of the
irreps. The classification can be stated and exercised on the two Casimirs without them.

## Computation block

```computation
# Metric mostly-minus, eps_{0123} = +1, W_mu = -(1/2) eps_{mu nu rho sig} J^{nu rho} P^sig
gamma = [blockdiag(1,-1), offdiag(sigma_k)]        # Dirac basis, 4x4 over C
clifford  = gamma[m]*gamma[n] + gamma[n]*gamma[m] - 2*eta[m,n]*eye(4)
slash     = sum(p[m]*gamma[m] for m in range(4))
slash_sq  = slash*slash - (p0**2 - p1**2 - p2**2 - p3**2)*eye(4)
S         = [I/2*gamma[2]*gamma[3], I/2*gamma[3]*gamma[1], I/2*gamma[1]*gamma[2]]
spin_cas  = S[0]**2 + S[1]**2 + S[2]**2 - Rational(3,4)*eye(4)
W         = [-Rational(1,2)*Sum(LeviCivita(m,n,r,s)*J[n,r]*P[s], (n,r,s)) for m in Fin4]
WdotP     = Sum(W[m]*P[m], m)
Wsq       = W[0]**2 - W[1]**2 - W[2]**2 - W[3]**2
rest      = Wsq.subs({P0: m, P1: 0, P2: 0, P3: 0})
null      = Wsq.subs({P0: E, P1: 0, P2: 0, P3: E})
```

Run 2026-09-01, SymPy under `uv run --with sympy python` with `ulimit -v 4000000`.
Verdicts, verbatim: `clifford` zero for **all 16 index pairs**; `slash_sq` zero;
`S_k = diag(sigma_k/2, sigma_k/2)` `[True, True, True]`; `spin_cas` zero;
`[S1,S2] - i S3` zero; `WdotP` `0` for symbolic `J` and symbolic `P`;
rest-frame `W = [0, m*(J23-J32)/2, m*(-J13+J31)/2, m*(J12-J21)/2]`;
`rest` `= -m**2*(J12**2 + J23**2 + J31**2)` after imposing `J^{ab} = -J^{ba}`;
null-frame `W0 + W3 = 0` for symbolic `J`; null-frame antisymmetric components
`W1 = E*(J02+J23)`, `W2 = E*(-J01+J31)`, `W3 = E*J12`;
and `null + W1**2 + W2**2 = 0`. Every verdict matches the corresponding Lean theorem.

## Lean attestation

All `\veq{…}\lean` badges above refer to
[`docs/dreamed/lean/Casimir.lean`](lean/Casimir.lean) and to nothing else. They are **not**
wired into the repo's `verify/` sidecar machinery, per the `docs/dreamed/` contract.

Command, from `verify/`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Casimir.lean
```

**Exit status 0, no output, zero `sorry`, zero warnings** (run 2026-09-01, 21.8 s wall).

| Handle | Theorem(s) |
|---|---|
| `slash-sq` | `cliff_00`, `cliff_11`, `cliff_22`, `cliff_33`, `cliff_01`, `cliff_02`, `cliff_03`, `cliff_12`, `cliff_13`, `cliff_23`, `slash_sq`, `dirac_implies_mass_shell` |
| `w-dot-p` | `eps_swap_outer`, `W_dot_P` |
| `w-rest` | `rest_W0`, `rest_W1`, `rest_W2`, `rest_W3`, `rest_Wsq`, `rest_Wsq_antisym`, `spin_half_su2`, `spin_half_casimir`, `rest_Wsq_spin_half` |
| `null-seam` | `null_W0_eq_neg_W3`, `null_Wsq` |
| `iso2-generators` | `null_W1`, `null_W2`, `null_W3` |
| `helicity` | `null_helicity` |

`\eqref{kg-from-p2}` carries `\leanc`, not `\lean`: it is **open debt naming the desired
tier**, per the ratified escalation ladder. Nothing in the Lean file touches differential
operators, so the passage from `P²ψ = m²ψ` to `(\Box+m²)ψ = 0` is asserted, not attested.

The sibling [`lean/Q2Symmetry.lean`](lean/Q2Symmetry.lean) already proved `casimir_poincare`,
`casimir_unique` and `casimir_galilei_blind` (the 1+1 cohomology side). This file deliberately
shares nothing with it: explicit 3+1 matrices and an explicit `ε`, no Lie algebra.

**What was weakened, stated plainly.**

- **No Lie algebra anywhere.** `J` is an arbitrary 4x4 array of reals; the Poincaré brackets
  are never used, so **nothing here proves `W²` is a Casimir**. That it commutes with the
  algebra is quoted and attested nowhere in this repo.
- **No representation theory.** Wigner's classification (§4) is quoted, never derived; the
  discarded rows are asserted. **No differential operators**, hence §1's `\leanc`.
- **`dirac_implies_mass_shell` is one-directional by design.** §2's central claim is about
  what `W²` *fails* to determine, and a proof assistant does not prove absences. The
  three-item accounting in §2 is an argument, not a theorem.
- **The Clifford relation is ten lemmas, not one `∀ μ ν` statement.** The indexed-family
  version `gam : Fin 4 → Matrix …` typechecks but `fin_cases μ <;> fin_cases ν` on 256 leaf
  goals blew the heartbeat budget. Since the anticommutator is symmetric, ten pairs cover
  sixteen: a proof-engineering weakening, not a mathematical one.
- **Rest and null frames are given by hypotheses on `P`,** not by substituting `![m,0,0,0]`.
  `simp` does not reliably reduce `Matrix.cons` applications inside a 256-term sum.
  Mathematically identical, and the Lean header says so.
- **The spin matrices are the specific Dirac `(1/2,0)⊕(0,1/2)` rep.** Nothing proves it is
  the only rep with `s = 1/2` -- it is not, which is §2's point 2.

## Surfaced for the owner

Recommendations awaiting a ruling. **Nothing here has been written into `TODO.md`,
`ROADMAP.md` or `REVIEW_ME.md`**, and a delegated agent's verdict is never self-settling.

- **F1 -- `docs/se-corpus.md` row P-C is misleading and load-bearing.** The row reads
  "Casimir eigenvalue eqs as field eqs"; the post's mechanism is a **variational** stationarity
  condition, and its accepted answer's real content (Dirac comes from an odd worldline-SUSY
  generator, *not* from `W²`) is absent. The row is what a step-5 author would read.
  Suggested replacement text: *"Can symmetry generators be used for quantization?
  δ⟨p²-m²⟩=0 ⇒ KG; asks whether W² likewise gives Dirac. Accepted answer (Schreiber):
  worldline SUSY, the odd generator IS the Dirac operator."* Owner's call; the corpus is his.
- **F2 -- sign convention.** q/27195 writes `W_μ = +\tfrac12 ε_{μνρσ}M^{νρ}P^σ`; the common
  modern convention carries `-\tfrac12`. Nothing in `W²` or `W·P` depends on it, but the spine
  will need one convention stated once, in public.
- **F3 -- the massless seam deserves a named section, not a footnote.** Two dreamed essays
  (this one and `photon-localizability.md`) hit the same `ISO(2)` wall independently. If step
  5 states Wigner's table, the two discarded rows should carry a D3 `[input]` tag in the same
  breath.
- **F4 -- `physics/toesnail.md`'s `## Symmetry / Noether / Gauge` stub is one line** and does
  not mention Casimirs or Wigner, so the ratified step-5 headline has no landing site in the
  spine file. Whether step 5 lands there or gets its own file is an authoring decision
  (`id:e552`) and is not made here.
- **F5 -- §1's "KG is not the spin-0 equation" correction.** If the owner agrees it is worth
  making in public, the natural place is the step-5 epigraph, and it would also be a good
  self-answer on q/27195 (the P-C analogue of the still-open Q16 action on q/669175).

## Follow-up leads

1. **Prove `W²` actually is a Casimir** (`[W², J^{μν}] = [W², P^μ] = 0`) in Lean from explicit
   brackets. *Decidable by*: writing the Poincaré structure constants as an array and grinding
   the two commutators, the shape of `Q2Symmetry.lean`'s `ad_K` block but 3+1. Mechanical; cost
   is the only unknown. **Tooling, not physics -- outside `id:e552`.**
2. **Formalise §2's gap**: exhibit a spinor satisfying `slash_sq` at `m²` but not
   `slash p · v = m v`. *Decidable by*: a 4x4 eigenvector computation, fully closable. Turns
   §2's argument into a theorem.
3. **Is row P-E's `-\tfrac14 F^2` count the same fact as the `ISO(2)` seam?** *Decidable by*:
   checking whether the Proca `4-1 = 3` versus Maxwell `4-1-1 = 2` gap is exactly the two
   generators of `\eqref{iso2-generators}`. If yes, P-C and P-E merge and the spine saves a
   chapter. **Reading physics as physics -- owner-only.**
4. **Does the owner's *variational* framing survive where the eigenvalue framing fails?**
   Schreiber suggests yes. *Decidable by*: writing out `δ⟨ψ|W² + \tfrac34 m^2|ψ⟩ = 0` for a
   Dirac spinor and seeing what it produces. **Direction owner-only (`id:e552`); the algebra
   underneath is not.**
5. **Where does step 5 land in the file tree?** *Decidable by*: an owner ruling only, since
   F4 says the current stub does not host it.

## Sources

- physics.SE [q/27195](https://physics.stackexchange.com/q/27195), owner-authored, with the
  Schreiber (accepted, +22) and Misha (+7) answers, fetched via the SE API 2026-09-01.
- physics.SE [a/8627](https://physics.stackexchange.com/a/8627) -- corpus row P-D.
- E. Wigner, *Ann. Math.* **40**, 149-204 (1939) -- the classification of §4.
- [nLab, spinning particle](http://ncatlab.org/nlab/show/spinning+particle) -- Schreiber's
  pointer for the worldline-SUSY route to Dirac.
- Meeting notes `2026-07-07-1228` §5 (11-step skeleton) and §7 (D1-D5);
  `2026-07-08-1056` §5b (Q13).
- Sibling dreamed essays: [`q2-galilei-vs-poincare.md`](q2-galilei-vs-poincare.md),
  [`photon-localizability.md`](photon-localizability.md).
