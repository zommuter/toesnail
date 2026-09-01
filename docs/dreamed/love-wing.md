---
title: The love wing, and whether its arc actually connects
permalink: /dreamed/love-wing
---

# The "L" in TOESNAIL: does the proposed arc hold together?

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](./). AI-written, 2026-09-01, from an
> owner-picked seed: the "L" in TOESNAIL (`physics/toesnail.md`: *"all is full of love"*, *"that's
> obviously what a theory of **everything** must include"*), ratification **D5** (love wing = game
> theory / simulations, plus the essays wing), and the still-open **Q11** from
> `docs/meeting-notes/2026-07-07-1257-corpus-dreaming-session.md` §4: adopt the 7-stage arc
> Resogram to Strogatz to Kuramoto to games to Gottman? It **proposes**; the owner disposes. Every
> verdict is a recommendation awaiting ratification, never a decision.

## 0. Headline

Three of the arc's four junctions are real and one is not, and they fail in that order of severity:

| Junction | Verdict |
|---|---|
| Resogram to Strogatz | **Real, and stronger than the note claims.** Same object (linear ODE system, eigenvalue classification); the Resogram is the `n=1` damped case, Strogatz the `n=2` case. |
| Strogatz to Kuramoto | **Real but a genuine jump.** Linear to nonlinear, 2-body to N-body, amplitude to phase. Three changes at once. What survives is the *energy method*, not the model. |
| Kuramoto to games | **Thematic, not mathematical.** Both are "coupled agents", which is a category, not a bridge. Replicator dynamics is a real shared formalism but it is a *different* ODE with a *different* state space. |
| games to Gottman | **An epistemic gear change, not a mathematical junction.** Everything upstream is derived; Gottman/Murray/Swanson is fitted. |

**One invariant does thread stages 1 to 4, and it is not the order parameter.** It is
**gain-versus-loss in a scalar Lyapunov quantity**: the Resogram's `ė = -4βe + drive`, the Strogatz
centre's conserved `cR² - bJ²`, the Ott-Antonsen reduced Kuramoto `r_t = -γr + (K/2)r(1-r²)`, and
the potential of a potential game. It **breaks at stage 5**: a model with fitted parameters has no
Lyapunov function *to derive*, only one to postulate. The break is the finding, not a failure.

---

## 1. Junction 1: Resogram to Strogatz

Strogatz's teaching model [S88] is Romeo's feeling $R$ and Juliet's feeling $J$ under

$$ R_t = aR + bJ, \qquad J_t = cR + dJ. $$

Set $T = a+d$ (trace) and $D = ad - bc$ (determinant). The characteristic polynomial is

$$ (a-\lambda)(d-\lambda) - bc = \lambda^2 - T\lambda + D \veq{charpoly}\lean $$

with roots

$$ \lambda_\pm = \frac{T \pm \sqrt{T^2 - 4D}}{2}, \qquad \lambda_+ + \lambda_- = T,\quad \lambda_+\lambda_- = D. \veq{quadratic}\lean $$

Classification, in the model's own terms: $T<0, D>0, T^2>4D$ two negative reals, both cool off
monotonically to mutual indifference; $T<0, D>0, T^2<4D$ complex with $\operatorname{Re}=T/2<0$,
they cycle with shrinking amplitude; $T>0, D>0$ runaway feedback; $D<0$ a saddle, outcome decided
entirely by initial conditions; $T=0, D>0$ purely imaginary, closed orbits forever. The stability
criterion, proved as a both-directions `iff` with the roots **constructed** rather than assumed to
exist:

$$ \big(\forall \lambda \in \mathbb{C}: \lambda^2 - T\lambda + D = 0 \implies \operatorname{Re}\lambda < 0\big) \iff \big(T<0 \ \wedge\ D>0\big) \veq{routh}\lean $$

### 1.1 The case worth telling: "out of touch with their own feelings"

Strogatz's $a = d = 0$ case is where neither lover responds to their own state, only to the
other's. Then $T = 0$, $D = -bc$, and $\lambda^2 = bc$. **One sign decides everything:**

$$ bc < 0 \implies \operatorname{Re}\lambda = 0,\ \lambda \neq 0 \quad\text{(centre)}; \qquad bc > 0 \implies \lambda = \pm\sqrt{bc} \quad\text{(saddle)}. \veq{outoftouch}\lean $$

If $b$ and $c$ have **opposite** signs (one is drawn by warmth, the other repelled by it) the orbit
is a closed curve: a never-ending cycle of love and hate, with no equilibrium and no decay. If they
have the **same** sign, the origin is a saddle and the pair runs away along the unstable
eigendirection, either into mutual escalation or mutual withdrawal, decided by initial conditions.
This is genuinely charming and genuinely true, and it is the single best advertisement the love
wing has.

The centre has an exactly conserved quantity, which the Lean file proves with a `HasDerivAt`
witness rather than `deriv`:

$$ Q := cR^2 - bJ^2, \qquad \frac{dQ}{dt} = 2cR\,(bJ) - 2bJ\,(cR) = 0. \veq{invariant}\lean $$

For $bc<0$ this $Q$ is a definite quadratic form, so the level sets are ellipses. **This is the
love wing's first energy function, and it is the same move as the Resogram's `e`:** define a
scalar, differentiate it along the flow, read off the dynamics without solving anything.

$Q$ is also the *only* one. Solving $A^{\mathsf T}P + PA = 0$ for a symmetric $P$ with $a = d$ gives
$P = 0$ for $a \neq 0$, and for $a = 0$ exactly the one-parameter family $P \propto
\operatorname{diag}(c, -b)$, i.e. $Q$ up to scale. So the conserved quantity exists precisely when
the trace vanishes, and "no damping" and "there is an energy" are the same statement.

**Verdict on junction 1: real.** The Resogram is a driven damped oscillator, i.e. a linear
2D system in $(x, \dot x)$ with trace $-2\beta$ and determinant $\omega^2$; Strogatz is a linear 2D
system in $(R, J)$. Same classification theorem, different labels on the axes. The connection is
not an analogy, it is an instance.

---

## 2. Junction 2: Strogatz to Kuramoto

Three things change at once here, and the note's "extend the cast" phrasing understates it:
linear to nonlinear ($\sin(\theta_j-\theta_i)$ replaces $bJ$), two-body to N-body (mean-field
coupling replaces a pair), and amplitude to phase. The third is the one that matters: Strogatz's
state is *how much* each feels, Kuramoto's is *when* each peaks, and nothing in the Strogatz model
has a phase at all. That is a change of subject at the level of the state space. Stages 2 and 3
share a **method** (find a scalar, watch it grow or shrink), not a model.

What Kuramoto gives in exchange is worth the jump. The order parameter

$$ r e^{i\psi} := \frac1N \sum_{j=1}^{N} e^{i\theta_j}, \qquad 0 \le r \le 1 \veq{orderparam}\lean $$

is the population's coherence: $r=1$ perfect synchrony, $r\approx 0$ incoherence. The mean-field
self-consistency condition for a symmetric unimodal frequency density $g$ gives the critical
coupling

$$ 1 = K\int_{-\pi/2}^{\pi/2}\cos^2\theta\; g(Kr\sin\theta)\,d\theta \ \xrightarrow{\ r\to 0^+\ }\ K_c = \frac{2}{\pi g(0)}. $$

For the Lorentzian $g(\omega) = \gamma/\pi(\omega^2+\gamma^2)$, $g(0) = 1/(\pi\gamma)$, hence

$$ K_c = 2\gamma. \veq{kc-lorentzian}\lean $$

**Checked numerically** ($\gamma=0.7$, so $K_c=1.4$): the closed form $r=\sqrt{1-K_c/K}$ satisfies
the self-consistency integral to residual $\le 2.7\times10^{-15}$ at $K=1.5,2,3,5$, and a direct
root-find reproduces it to six digits. An $N=4000$ simulation of the full Kuramoto ODE gives
$r=0.5459, 0.7290, 0.8474$ at $K=2,3,5$ against the predicted $0.5477, 0.7303, 0.8485$, and sits at
the finite-size floor $r\approx0.02\approx1/\sqrt N$ for $K\le K_c$.

### 2.1 Where the Resogram's own equation reappears

Under the Ott-Antonsen ansatz [OA08] the Lorentzian case has a **closed first-order ODE for $r$**:

$$ r_t = -\gamma r + \frac{K}{2}r\,(1-r^2). $$

Compare the Resogram's `edot`, $\dot e = -4\beta e + \omega^2(2\beta x^2 + \dot x y)$. Both read
*linear loss plus drive*, and both have a threshold where drive beats loss: the Resogram's `eincr`
condition $\lvert y\rvert > 2\tfrac{\beta}{\omega^2}\lvert\dot x\rvert$ against Kuramoto's
$K > 2\gamma$. The frequency **spread** plays the damping's role. That correspondence is the strongest thing I
found in the whole arc, and it is checkable rather than poetic: the fixed point of the OA equation
is $r^2 = 1 - 2\gamma/K$, which is exactly the $\sqrt{1-K_c/K}$ verified above against both the
self-consistency integral and the simulation.

**Verdict on junction 2: real, but say out loud that it is a jump.** Do not write "extend the
cast"; write "we keep the method and change the model".

---

## 3. Junction 3: Kuramoto to games

Synchronization is agents converging on a common phase because the coupling makes them; strategic
choice is agents picking actions because of what they *get*. Payoff has no analogue in Kuramoto,
phase has none in a normal-form game, and "both are coupled agents with individual objectives" is a
true sentence about a category, not a bridge.

The honest candidate link is **replicator dynamics**, $\dot x_i = x_i\big((Ax)_i -
x\!\cdot\!Ax\big)$: nonlinear coupled ODEs with an aggregate scalar, like Kuramoto. But the state
space is a simplex of population shares, not a torus of phases, and the coupling is through payoffs
rather than through $\sin$. It is a **second instance of the same method**, which is exactly what
the corpus session's theme "same equation, different world" wants; the book should sell it that way
rather than as a continuation.

The scalar that carries over is the **potential**. For an exact-potential game (each player's
payoff is a shared interaction term plus a term that player cannot influence), unilateral payoff
differences equal potential differences, so better-response dynamics ascends the potential and a
maximiser of the potential is a pure Nash equilibrium:

$$ u_1(x,y) = \Phi(x,y) + f(y),\quad u_2(x,y) = \Phi(x,y) + g(x) \implies u_1(x',y) > u_1(x,y) \Rightarrow \Phi(x',y) > \Phi(x,y) \veq{potential}\lean $$

The counter-case is the point. Rock-Paper-Scissors is **not** a potential game: I integrated its
replicator flow for $2\times10^6$ steps and the mean payoff stays identically zero (max
$\lvert\phi\rvert = 2.8\times10^{-17}$) while the orbit cycles, with $-\tfrac13\sum\log x_i$
conserved to $4.4\times10^{-6}$. Cycling with a conserved quantity but **no ascent**: exactly the
Strogatz centre again, one stage later.

**Verdict on junction 3: thematic. Real formalism, different subject.** Keep it, label it as a
new chapter rather than the next step.

---

## 4. Junction 4: games to Gottman, the epistemic gear change

Gottman, Murray and Swanson's *The Mathematics of Marriage* [GM02] is real published work and its
model is a discrete-time influence system,

$$ W_{t+1} = r_1 W_t + a + I_{HW}(H_t), \qquad H_{t+1} = r_2 H_t + b + I_{WH}(W_t), $$

where $W_t, H_t$ are per-turn affect scores from coded video of couples, $r_i$ are "emotional
inertia", $a, b$ are uninfluenced steady states, and $I$ are piecewise (bilinear or ojive)
influence functions. **Every one of those parameters is fitted, per couple, from observation
data.** Nothing about them is derived from anything upstream in the arc.

That is the arc's biggest risk, and it is not a defect of Gottman's work but of *placing it at the
end of a derivation chain*. Stages 1 to 4 answer "what follows from these assumptions?"; stage 5
answers "what fits this data?" A reader trained by four chapters to expect the first question will
read fitted parameters as derived ones.

**What the D3 epistemic-status tags must do here** (D3 ratified tags as a machine-greppable marker
family alongside `\veq`): the boundary needs a tag the earlier stages never use. `[derivation]` and
`[input]` are both wrong; what stage 5 is, is `[empirical fit]`, and it must carry two fields the
physics tags do not, **which dataset** and **what the model was not fitted on**. It should render as
a visible gear change rather than a footnote, because the narrative momentum of four derived
chapters is exactly what will carry a reader past it.

Sharper: stages 1 to 4 each have a scalar whose monotonicity **follows from the model**. A fitted
difference equation has none. You can compute a Lyapunov function numerically for a particular
fitted parameter set, but it is a property of that fit, not of the theory. That is where the
invariant breaks, and saying so is worth more than patching it.

---

## 5. The strongest objection, stated fairly

A physicist modelling love with coupled ODEs is a well-worn genre, and much of it is bad. The case
against, as strongly as I can make it:

1. **The metaphor does the work the mathematics pretends to do.** $R$ is not measurable. There is
   no unit of Romeo. Every theorem above is a theorem about $\mathbb{R}^2$; the love content lives
   entirely in the naming, and naming is free. The Lean file proves the Strogatz classification and
   proves nothing whatsoever about people, which is why its header says exactly that.
2. **Unfalsifiability by parameter freedom.** With $a,b,c,d$ free the model reproduces decay,
   growth, oscillation and saddle behaviour. A model that can produce every qualitative outcome
   predicts none of them. Fatal to the *predictive* reading, harmless to the *taxonomic* one, and
   the two are easy to conflate in prose.
3. **The Kuramoto rhyme is a rhyme.** The corpus note's "sync spontaneously breaks U(1), the same
   mathematical move as the Higgs mechanism" is correct about the symmetry and does real
   pedagogical work, but it is a statement about the equations, not about the lovers. If a reader
   slides from "sync breaks U(1)" to "falling in love breaks U(1)", the book has cheated.
4. **Gottman's own record.** The often-quoted "94% divorce prediction accuracy" is post-hoc
   classification on the sample the model was fitted to, not out-of-sample prediction, and has been
   criticized on that ground. Citing it unqualified is the exact failure `docs/rigor-debt.md`
   exists to prevent.

**What would make toesnail's version not that**, in decreasing order of how much I believe in it:
**confine derived claims to the derivable stages** (tag the §4 boundary and never let a `\veq`
badge cross it; a `\veq{h}\lean` on a Gottman equation would be a category error, and this repo's
badge machinery *could* mechanically attest one, which is itself worth the owner's attention);
**make the taxonomic reading explicit and drop the predictive one** (the honest claim is *these are
the qualitative behaviours a two-variable coupled system can have, and each has a recognisable
emotional description*, which needs no parameter to be measurable); **take one testable prediction
from stage 3**, the onset threshold, which the Strogatz stage cannot offer, checkable in the
synchronization literature and closest to human social coupling in the applause case [N00], far
short of love but more than a metaphor, and notably *not* Gottman; and **use the open-debt ladder
`CONVENTIONS.md` already has**, since an honest badge naming the desired verifier beats a confident
unmarked claim.

The objection does not kill the wing. It does kill the version where the arc is one smooth
derivation, which is the version Q11 as written proposes.

---

## 6. Verdict on Q11 (a recommendation; the owner ratifies)

**Adopt the arc, with three amendments.** Weaknesses of this recommendation stated after.

1. **Merge stages 1 and 2 into one chapter.** They are the same theorem. The Resogram already
   exists, is already verified, and already teaches the energy method; Strogatz is its second
   worked example, not its successor. Merging removes the arc's weakest transition (there is no
   transition) and makes the "out of touch with their own feelings" dichotomy the chapter's payoff.
2. **Insert an explicit "method, not model" hinge between stages 2 and 3**, naming the three
   simultaneous changes (§2). Without it, the reader is entitled to think Kuramoto is Strogatz with
   more lovers, and it is not.
3. **Demote stage 5 from the arc's terminus to a labelled epistemic appendix.** The arc should end
   at stage 4, where the last theorem is. Gottman then appears as *what happens when you try to
   measure this*, with the `[empirical fit]` tag (§4) and the out-of-sample caveat. This inverts the
   note's structure, which reads Gottman as the climax.

Stages 6 (thermodynamic frame) and 7 (essays) I would leave exactly as the note has them. Stage 6
is already correctly marked `[hypothesis]` for Friston, and stage 7 is where D5's "the essays wing
stays as the parallel non-mathematical track" already lands.

**Weaknesses of this recommendation.** (a) It makes the wing shorter and less romantic, which cuts
against the owner's stated intent that the ❤️ be load-bearing rather than decorative. (b) Demoting
Gottman loses the only stage with actual humans in it, and a wing about love with no data about
couples is a fair thing to object to. (c) I have not read the Gottman book, only its model
structure and its critical literature, so amendment 3 rests on a characterisation the owner should
check before ratifying. (d) The merge in amendment 1 assumes the Resogram chapter is willing to
carry a second worked example, which is a narrative call, not a mathematical one.

### Q11's neighbour, unprompted but adjacent

`docs/se-corpus.md` row **M-8** flags mental poker / commutative encryption as
"info wing ∩ love-wing games". Mental poker is a genuinely load-bearing example for stage 4: it is
a game played *without a trusted third party*, i.e. cooperation constructed from cryptography
rather than from repeated interaction. That is a different mechanism for trust than
Axelrod-Hamilton reciprocity, and the contrast (trust by reputation vs trust by protocol) is a real
chapter. Not part of Q11; recorded because the seed pointed at it.

---

## 7. Lean attestation

File: `docs/dreamed/lean/LoveWing.lean`. Command, run from `verify/`:

```
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/LoveWing.lean
```

**Exit status 0, zero `sorry`, zero warnings.** 17 theorems, by handle:
`charpoly` = `strogatz_charpoly`; `quadratic` = `strogatz_root_add`, `strogatz_root_sub`,
`strogatz_sum`, `strogatz_prod`; `routh` = `real_pair_neg_iff`, `root_re_im` (private),
`strogatz_stable_iff`; `outoftouch` = `out_of_touch_center`, `out_of_touch_saddle`; `invariant` =
`out_of_touch_invariant`; `orderparam` = `kuramoto_order_le_one`; `kc-lorentzian` =
`kuramoto_Kc_lorentzian`; plus `kuramoto_two_gradient` (stage 3's potential) and `potential` =
`potential_game_exact`, `potential_game_monotone`, `potential_game_nash`.

Positivity and sign conditions are **named hypotheses** throughout (`hdisc`, `hbc`, `hγ`), never
implicit: `Real.sqrt` truncates to 0 off-domain and would otherwise make `strogatz_root_add` false.
Derivative claims use `HasDerivAt` witnesses, never `deriv`, per `lean-deriv-fidelity-hasderivat`.

**Out of scope, therefore not proved:** that any of this models people; the Kuramoto
self-consistency integral and its bifurcation (only the *algebra* of $K_c$ is in Lean, the integral
is numerics); and everything at stage 5, where a fitted model has no theorem to state.

**What I weakened.** Nothing was reduced to reach exit 0. Two scope choices:
`kuramoto_two_gradient` proves the gradient-flow structure only for $N=2$ (Adler's equation), the
general-$N$ identical-frequency case being verified with SymPy at $N=4$ but not in Lean; and
`potential_game_nash` is stated for two-strategy players (`Bool`), where finiteness is immediate,
the general finite case needing no new idea but more plumbing.

## 8. Computation block

```computation
charpoly = l**2 - (a + d)*l + (a*d - b*c)
lam_pm = ((a+d) + sqrt((a+d)**2 - 4*(a*d - b*c)))/2
out_of_touch = charpoly.subs({a: 0, d: 0})     # l**2 - b*c
invariant = c*R(t)**2 - b*J(t)**2              # dQ/dt = 0 under R_t=b*J, J_t=c*R
g = gamma/(pi*(w**2 + gamma**2))
Kc = 2/(pi*g.subs(w, 0))                       # = 2*gamma
selfconsistency = Eq(1, K*Integral(cos(th)**2 * g.subs(w, K*r*sin(th)), (th, -pi/2, pi/2)))
OA_ode = Eq(Derivative(r, t), -gamma*r + K/2*r*(1 - r**2))
r_OA = sqrt(1 - 2*gamma/K)                     # its nonzero fixed point
replicator = Eq(Derivative(x[i], t), x[i]*((A*x)[i] - x.dot(A*x)))
```

All numerics in §2 and §3 were run under a 4 GB address-space cap (`ulimit -v 4000000`) after a
sibling agent's runaway triggered the kernel OOM killer at 11:48. Nothing had to be shrunk to fit:
the largest object was the $N=4000$ Kuramoto simulation.

## 9. Follow-up leads

1. **Is the damping-to-frequency-spread correspondence (§2.1) an isomorphism or a coincidence?**
   Decidable by writing both as the same normal form: check whether the OA equation and the
   Resogram's `edot` are related by a change of variables, or merely share the shape "linear loss
   plus drive".
2. **Does the "trace vanishes iff an energy exists" statement (§1.1) survive to stage 3?**
   Decidable by asking whether the Kuramoto flow's divergence on the torus vanishes exactly when
   the frequencies are identical; if so, the same one-line criterion governs stages 2 and 3 and
   becomes the wing's named methodology theme.
3. **Does the applause-synchronization literature actually show a threshold, or just a
   transition?** Decidable by reading the primary papers for a fitted critical coupling; if the
   data only shows gradual onset, the wing's one testable prediction (§5) is weaker than claimed.
4. **Would an `[empirical fit]` tag with a `dataset:` and an `out-of-sample:` field fit the D3
   marker family, or does it need a different mechanism?** Decidable by drafting one against the
   `.mw` fragment lowering rule in `CONVENTIONS.md` §1 and seeing whether it lowers cleanly.
5. **Is mental poker (M-8) a stage-4 chapter or an info-wing chapter?** Decidable by asking which
   theorem it would carry: commutative-encryption correctness (info wing) or the equilibrium of a
   game with no trusted party (love wing).

## Surfaced for the owner, deliberately NOT filed

Nothing below has been written into `TODO.md`, `ROADMAP.md`, or `REVIEW_ME.md`. Routing a dreamed
finding into a ledger is the owner's decision.

- The **Q11 verdict** (§6): adopt with three amendments, one of which inverts the note's ending.
- The **`\veq` category-error risk** (§5): the badge machinery would mechanically attest an
  empirical-fit equation, and nothing currently stops it.
- The **Gottman 94% figure** should not be cited without the in-sample qualifier (§5.4).
- The **M-8 / mental poker** placement question (§6, neighbour).
- The corpus note's **"same mathematical move as the Higgs mechanism"** phrasing (§5.3) is correct
  about the symmetry and easy to over-read; it may want a hedge if it survives into the text.

## References

- [GM02] J. M. Gottman, J. D. Murray, C. C. Swanson, R. Tyson, K. R. Swanson, *The Mathematics of
  Marriage: Dynamic Nonlinear Models*, MIT Press (2002).
- [K75] Y. Kuramoto, "Self-entrainment of a population of coupled non-linear oscillators",
  Springer LNP **39** (1975).
- [OA08] E. Ott, T. M. Antonsen, "Low dimensional behavior of large systems of globally coupled
  oscillators", *Chaos* **18**, 037113 (2008).
- [S88] S. H. Strogatz, "Love Affairs and Differential Equations", *Math. Mag.* **61**, 35 (1988).
- [S00] S. H. Strogatz, "From Kuramoto to Crawford", *Physica D* **143**, 1 (2000).
- [AH81] R. Axelrod, W. D. Hamilton, "The Evolution of Cooperation", *Science* **211**, 1390 (1981).
- [MS96] D. Monderer, L. S. Shapley, "Potential Games", *Games Econ. Behav.* **14**, 124 (1996).
- [N00] Z. Neda, E. Ravasz, Y. Brechet, T. Vicsek, A.-L. Barabasi, "The sound of many hands
  clapping", *Nature* **403**, 849 (2000).
