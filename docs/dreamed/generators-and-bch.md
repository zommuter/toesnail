---
title: "Generators, and what goes wrong when they do not commute"
permalink: /dreamed/generators-and-bch
---

# Generators, and what goes wrong when they do not commute

> **DREAMED, UNREVIEWED.** See [`docs/dreamed/README.md`](README.md). AI-written 2026-09-01,
> owner-picked seed. Nothing here is theory and nothing here is a decision. It **proposes**;
> the owner disposes. Nothing may be promoted into `physics/` without him authoring the move
> (`ROADMAP` `id:e552`).

Seed: `docs/se-corpus.md` rows **M-1** and **M-2**, both **promoted 2026-07-08** (Q13, meeting note
`2026-07-07-1318` / `2026-07-08-1056` §5b). Both rows are the owner's own math.SE material, three
of the five posts self-answered by him.

The unifying idea is one idea: **a group element is the exponential of its generator, and reading
$e^{a\,d/dx}$ as "translate by $a$" turns calculus into group theory.** That is the most
"math on demand" moment the spine has available, because the demand ("what generates a
translation?") produces the whole of Lie theory as its answer.

---

## 0. Headline, with the corrections up front

1. **Two of the row's labels point at the wrong post.** Row M-1 tags `337971` as the
   dilation-generator post and marks it `(self-answered)`. It is not. `337971` is
   *"Can the curl operator be generalized to non-3D?"*, and the dilation material is in
   `116633` + his own [a/116639](https://math.stackexchange.com/a/116639). `337971` *is* also
   self-answered, on a different subject the row does not mention at all. Details in
   "Surfaced for the owner".
2. **The owner already published the counterexample the row asks for.** [a/2047](https://math.stackexchange.com/a/2047)
   gives $X(t)=\cos t\,\sigma_3+\sin t\,\sigma_1$, i.e. $X(0)=\sigma_3$, $\dot X(0)=\sigma_1$.
   Checked below with exact numbers, it fails harder than "the naive formula is wrong": *both*
   orderings and their average are wrong, and the naive ones are not even symmetric when the true
   derivative must be.
3. **The dilation-to-translation substitution $u=\ln x$ is the same map two sibling essays already
   use.** [`wick-entropy.md`](wick-entropy.md) uses $z=\exp(2\pi(\sigma+i\tau)/(\hbar\beta c))$ and
   [`wirohsh-approximation.md`](wirohsh-approximation.md) uses $x=e^{-w}$. Third independent
   appearance, one map: $\exp$ carries the additive line to the multiplicative ray, and carries
   translation to dilation. This is a *methodology theme* candidate in the D1 sense, not a
   coincidence to note in passing.

---

## 1. The translation generator, done honestly

Taylor, rearranged and nothing more:

$$ f(x+a) \;=\; \sum_{k=0}^{\infty}\frac{a^k}{k!}\,\frac{d^k f}{dx^k}(x) \;=\; e^{a\,d/dx} f(x) \veq{trans-gen}\lean $$

The badge is honest only because of what is proved rather than what is written. For a
**polynomial** the sum is finite, no convergence hypothesis exists, and the identity is a theorem:
`taylor_polynomial` in the Lean file. For a general $f$ the equation carries a hypothesis the
notation hides.

**The hypothesis, stated.** It holds pointwise for $f$ real-analytic at $x$ with radius of
convergence $>|a|$, and for all $a$ only when $f$ is entire. For merely $C^\infty$ $f$ the
right-hand side is a *formal* series that may diverge off $a=0$, or converge to the wrong function
($e^{-1/x^2}$ has every derivative zero at the origin). This is the analytic-versus-smooth gap
[`wirohsh-approximation.md`](wirohsh-approximation.md) §2 turns into a theorem pointing the other
way (no nonzero real-analytic function has compact support): here analyticity is what *lets* the
operator exponential mean something, there it is what *forbids* localization.

**What it buys.** Once translations are $e^{aD}$ with $D=d/dx$, the group's generator *is* $D$;
requiring unitary action on a Hilbert space forces it anti-self-adjoint, so the observable is
$-i\hbar D$, and

$$ \hat p \;=\; -i\hbar\,\frac{d}{dx} \veq{momentum-from-translation}\sorry $$

is a **derivation**, not a postulate. This is the analytic half of the story, and it belongs to the
sibling [`time-and-operators.md`](time-and-operators.md) (Stone's theorem, one-parameter unitary
groups), which supplies the theorem that makes "the generator exists and is self-adjoint" true
rather than formal. This essay supplies the algebraic half: what the generators do to *each other*.

---

## 2. The dilation generator (`a/116639`, his own)

His answer, in his own construction: define $g(y):=f(e^y)$, so $f(x)=g(\ln x)$. Then

$$ f(\alpha x) \;=\; g(\ln\alpha+\ln x) \;=\; e^{\ln\alpha\,\frac{d}{d\ln x}}g(\ln x),
   \qquad \frac{d}{d\ln x}=\frac{dx}{d\ln x}\frac{d}{dx}=x\frac{d}{dx} $$

giving

$$ f(\alpha\cdot x) \;=\; \alpha^{\,x\,d/dx} f(x) \veq{dilation-gen}\sympy $$

with his own caveat attached and correct: $x\neq 0$ because the logarithm is undefined there, while
$\alpha\neq 0$ is already caught by $e^{\ln\alpha}=\alpha$.

**Why it is diagonal.** $x\frac{d}{dx}x^n = n\,x^n$. The monomials are eigenfunctions with
eigenvalue $n$, so on $x^n$ the operator series collapses to a scalar exponential:

$$ \alpha^{x\,d/dx}x^n=\sum_{k\ge 0}\frac{(\ln\alpha)^k}{k!}n^k\,x^n=e^{n\ln\alpha}x^n=\alpha^n x^n $$

which is $f(\alpha x)$ for $f=x^n$, and the linear span settles every polynomial and every
convergent power series. SymPy closes the sum in closed form, not by truncation.

**Where this connects.** Because dilation is diagonal in the monomial basis, its "Fourier
transform" is the transform whose characters are the powers: the **Mellin** transform. That is the
cell [`wirohsh-approximation.md`](wirohsh-approximation.md) §1 identified as the missing entry in
row M-6's *"Fourier : transform :: Laurent : ?"*. Row M-6 and row M-1 are therefore the same
question asked twice, once about bases and once about generators, and the answer is the same map.
Recommendation, not a decision: if the owner writes M-1, the Mellin sentence is the join.

---

## 3. Curl as a skew `so(3)` element (`186201`, his own question)

His question already contains the construction: curl written as the skew matrix
$\bigl(\begin{smallmatrix}0&-\partial_z&\partial_y\\ \partial_z&0&-\partial_x\\ -\partial_y&\partial_x&0\end{smallmatrix}\bigr)$.
Strip the derivatives and it is the **hat map**, $w\mapsto W$ with $Wv=w\times v$:

$$ W \;=\; \begin{pmatrix}0&-w_3&w_2\\ w_3&0&-w_1\\ -w_2&w_1&0\end{pmatrix},
   \qquad W^{\mathsf T}=-W,\qquad Wv=w\times v \veq{hat-map}\lean $$

Three facts, all machine-checked (`hat_antisymm`, `hat_mulVec`, `hat_bracket`, `hat_cube`):

1. $W^{\mathsf T}=-W$, and every antisymmetric real $3\times3$ matrix is a $W$, so the hat map is a
   linear isomorphism $\mathbb R^3\to\mathfrak{so}(3)$.
2. It is an isomorphism **of Lie algebras**: $[W_a,W_b]=\widehat{a\times b}$. The cross product is
   not an analogy for the $\mathfrak{so}(3)$ bracket, it is the bracket in coordinates. This is the
   single line that makes angular momentum's $[L_i,L_j]=i\hbar\epsilon_{ijk}L_k$ inevitable rather
   than memorized.
3. $W^3=-\lVert w\rVert^2 W$, so for a unit $w$, $W^3=-W$. Every power of $W$ lies in
   $\operatorname{span}\{W,W^2\}$, the exponential series splits into its odd and even halves, and

$$ e^{\theta W} \;=\; \mathbb 1 + \sin\theta\,W + (1-\cos\theta)\,W^2 \veq{rodrigues}\sympy $$

which is Rodrigues. SymPy verifies the closed form; Lean proves the engine $W^3=-W$ that forces it.
The distinction is stated in the Lean file rather than blurred.

**The payoff for the spine.** Curl is $\nabla\times$, so by the hat map curl is *the infinitesimal
generator of local rotation*, $\mathfrak{so}(3)$-valued at each point. That is why Kelvin's
circulation theorem and the vorticity equation are conservation statements about a rotation
symmetry rather than accidents of three dimensions. It also explains, without spinors, why his
`186201` eigenvalue computation gave $\lambda_\pm^2=-\Delta$: on the plane orthogonal to $\nabla$,
$W$ acts like $i$, scaled by the norm.

---

## 4. The trap: $\frac{d}{dx}e^{A(x)}$ (`q/2043` + his `a/2047`)

$$ \frac{d}{dt}e^{X(t)} \;=\; \int_0^1 e^{sX(t)}\,\dot X(t)\,e^{(1-s)X(t)}\,ds \veq{deriv-exp}\sympy $$

**Derivation, not quotation.** Write $F(s,t)=e^{sX(t)}$ and $G(s)=e^{sX}\,\partial_t e^{(1-s)X}$ at
fixed $t$. Differentiating $G$ in $s$ and using $\partial_s e^{sX}=Xe^{sX}=e^{sX}X$ (legitimate:
$X$ commutes with itself) gives $G'(s)=e^{sX}\dot X e^{(1-s)X}$, because the two $X$-terms produced
by the product rule cancel. Integrating from $0$ to $1$ collapses the telescope to
$G(1)-G(0)=\partial_t e^{X}$, which is the formula. Equivalently, pulling the $e^{X}$ out on the
right turns the integral into the Maurer-Cartan form
$\bigl(\tfrac{1-e^{-\operatorname{ad}_X}}{\operatorname{ad}_X}\dot X\bigr)e^{X}$; the naive answer
is the $\operatorname{ad}_X\to 0$ limit of that fraction, which is exactly the commuting case.

**His counterexample, with numbers.** $X(t)=\bigl(\begin{smallmatrix}\cos t&\sin t\\ \sin t&-\cos t\end{smallmatrix}\bigr)$,
so $X(0)=\sigma_3$, $\dot X(0)=\sigma_1$, $[X(0),\dot X(0)]=\bigl(\begin{smallmatrix}0&2\\-2&0\end{smallmatrix}\bigr)\ne 0$.
Since $X(t)^2=\mathbb 1$ for every $t$, $e^{X}=\cosh 1\cdot\mathbb 1+\sinh 1\cdot X$ exactly, and at
$t=0$:

| quantity | exact | numeric |
|---|---|---|
| true $\frac{d}{dt}e^{X}\big\vert_0$ | $\sinh(1)\,\sigma_1$ | $\bigl(\begin{smallmatrix}0&1.17520\\1.17520&0\end{smallmatrix}\bigr)$ |
| naive $\dot X e^{X}$ | $\bigl(\begin{smallmatrix}0&e^{-1}\\ e&0\end{smallmatrix}\bigr)$ | $\bigl(\begin{smallmatrix}0&0.36788\\2.71828&0\end{smallmatrix}\bigr)$ |
| naive $e^{X}\dot X$ | $\bigl(\begin{smallmatrix}0&e\\ e^{-1}&0\end{smallmatrix}\bigr)$ | $\bigl(\begin{smallmatrix}0&2.71828\\0.36788&0\end{smallmatrix}\bigr)$ |
| symmetrized average | $\cosh(1)\,\sigma_1$ | $\bigl(\begin{smallmatrix}0&1.54308\\1.54308&0\end{smallmatrix}\bigr)$ |

The integral formula reproduces the first row exactly (SymPy residual $0$). Three things worth
stating:

- **Both orderings fail, and by different errors.** There is no "right side to put $\dot X$ on".
- **The naive answers are not even symmetric.** $X(t)$ is symmetric for all $t$, so $e^{X(t)}$ is
  symmetric, so its $t$-derivative must be. $\dot X e^{X}$ is not. That single observation refutes
  the naive formula without evaluating anything, and it is the cheapest possible presentation of
  this lemma for the spine.
- **Symmetrizing does not save it.** $\cosh 1 \ne \sinh 1$; the average is wrong by
  $e^{-1}\approx0.368$ in every entry. The correct answer needs the *whole* integral, not a fix-up
  of the ordering.

The Lean file proves the same phenomenon with a different witness (§5), because $\sigma_3$'s
exponential is a $\cosh$/$\sinh$ combination and the nilpotent witness needs no series argument.

---

## 5. BCH, honestly (`q/57832`)

$$ \ln(e^Ae^B) = A+B+\tfrac12[A,B]+\tfrac1{12}\bigl([A,[A,B]]+[B,[B,A]]\bigr)-\tfrac1{24}[B,[A,[A,B]]]+\cdots \veq{bch4}\sympylean $$

Computed to order 4 in a free non-commuting algebra (residual $0$ at every order, orders 0 through
4) and confirmed numerically on an explicit $3\times3$ pair, where each retained order drops the
error by one power of the expansion parameter: at $\varepsilon=10^{-2}$ the residuals are
$4.0\cdot10^{-4}$, $5.4\cdot10^{-6}$, $4.4\cdot10^{-8}$, $3.9\cdot10^{-10}$ for truncations at
orders 1 to 4. That is the $\varepsilon^{n+1}$ scaling a genuine asymptotic series must show, and it
is the check that distinguishes "I typed the formula from Wikipedia" from "the formula is right".

**What BCH is not.** A formal Lie series with a finite radius: for matrices it converges when
$\lVert A\rVert+\lVert B\rVert<\ln 2$ (Dynkin; sharper bounds exist, none of them "always").
$\ln(AB)$ in `q/57832`'s framing has a further problem the row does not mention: the matrix
logarithm is multivalued, so "the" $\ln(AB)$ is a branch choice before it is an algebra problem,
the same branch issue [`lambertw-statistics.md`](lambertw-statistics.md) found in the entropy
inversion. And his extra hypothesis there, *similar and diagonalizable*, does not buy
commutativity: $\sigma_3$ and $\sigma_1$ are similar, diagonalizable, and do not commute.

**When it terminates.** If $[A,[A,B]]=[B,[A,B]]=0$ the series stops:
$e^Ae^B=e^{A+B+\frac12[A,B]}$, exactly. The $3\times3$ strictly-upper-triangular (Heisenberg) pair
$A=E_{12}$, $B=E_{23}$ satisfies this, and there

$$ e^Ae^B = \mathbb 1+A+B+[A,B] \;\ne\; \mathbb 1+A+B+\tfrac12[A,B] = e^{A+B} \veq{bch-nilpotent}\lean $$

with the two sides differing in the $(0,2)$ entry by exactly $1$ versus $\tfrac12$. Both statements
are Lean theorems (`heis_exp_mul_ne_exp_add`, `heis_bch2`), decided entrywise with no analysis.

**Where the spine would need it.** Composing two symmetry transformations: $e^Ae^B$ is a group
element, and asking "which generator is it?" is asking for BCH. And the converse split,
Zassenhaus/Trotter $e^{A+B}=\lim_n(e^{A/n}e^{B/n})^n$, is what makes $e^{-iHt}$ computable when
$H=T+V$ with $T$ and $V$ separately easy. Both are step-4 material.

---

## 6. What this offers the spine (an option, not a plan)

`physics/toesnail.md`'s `## Symmetry / Noether / Gauge` section is currently four lines of intent.
The curriculum note `2026-07-07-1318` places generators at **Step 4** (*Lie groups/algebras,
generators, Noether*) and rates steps 1 to 4 Mathlib-friendly. Row M-1 feeds step 4; row M-2 feeds
steps 3 to 4.

**Correction to my own brief.** I was told step 3 is "the corpus's largest gap" and that these rows
sit in it. Checked against the ratified text: `2026-07-07-1318` item 1 says the gap is step 3
**projective reps / Bargmann** and names its filler as a spin/double-cover/belt-trick file, not this
material. BCH is a *prerequisite* for the Bargmann argument (a 2-cocycle is exactly the obstruction
to $e^Ae^B=e^{A+B}$ lifting), and [`q2-galilei-vs-poincare.md`](q2-galilei-vs-poincare.md) works
that cocycle side. M-1 and M-2 lean on the step-3 gap; they do not fill it.

A candidate opening paragraph, for the owner to accept, rewrite, or bin:

> You already know what a translation is. Ask instead what *generates* one, and calculus answers:
> shifting by $a$ is $e^{a\,d/dx}$, which is Taylor's series wearing a group-theory hat. Every
> symmetry in physics arrives this way, as the exponential of something small, and the whole
> difficulty of the subject is that these small things do not commute.

What it demands, in the order the demands arise: (i) a one-parameter group and its generator, which
is Stone and the sibling essay's job; (ii) the commutator, demanded the moment two symmetries are
composed in both orders; (iii) BCH, demanded the moment you ask which single generator that
composition equals; (iv) $\mathfrak{so}(3)$ via the hat map, demanded by rotations and paid for by
the cross product the reader already has.

---

## 7. Follow-up leads

1. **Is $\alpha^{x\,d/dx}$ worth a `\veq` handle in the spine, or only the aside?** Decidable by the
   owner ruling on whether Mellin appears at all; if it does, the dilation generator is its
   generator and earns a numbered equation. Owner-only (`id:e552`).
2. **Do M-1 and M-6 merge into one aside?** Both are "the exponential map turns the ray into the
   line". Decidable by writing the joint paragraph and seeing whether it is shorter than the two
   separate ones. Owner-only.
3. **Does "$e^X$ symmetric, so its derivative is symmetric" generalize to a cheap obstruction?**
   Decidable: try anti-symmetry, unitarity, and other involutions on a chosen $X(t)$ family.
   Mechanizable, not owner-only.
4. **Is Dynkin's $\ln 2$ the constant to quote?** Decidable by a literature check plus a numerical
   probe of where the series actually diverges for a chosen pair. Mechanizable.
5. **Can `heis_bch2` generalize in Lean to any nilpotent pair meeting the Hall condition?**
   Decidable by attempting it; the obstruction is Mathlib's `Matrix.exp` nilpotent API, which today
   is absent (this file proved `exp_of_sq_zero` by hand). A candidate upstream contribution.

---

## Surfaced for the owner

Findings only. **Nothing here was written into `TODO.md`, `ROADMAP.md`, `REVIEW_ME.md`, or
`docs/se-corpus.md`.** Routing is his decision.

1. **`docs/se-corpus.md` row M-1 mislabels two of its three posts.** The row reads
   *"generators: e^{a d/dx}, dilation α^{x d/dx} (self-answered), curl as skew so(3), curl
   eigenvectors"* against IDs `116633`, `337971`, `186201`. Fetched from the SE API 2026-09-01:
   - `116633` *"Is there a formula similar to $f(x+a)=e^{a\frac{d}{dx}}f(x)$ to express
     $f(\alpha\cdot x)$?"*, score 18, **self-answered** at `a/116639` (score 14). The dilation
     material and the `(self-answered)` tag both belong here.
   - `337971` *"Can the curl operator be generalized to non-3D?"*, score 35. **Not dilation.** Also
     self-answered (his own answer proposes
     $\operatorname{curl}^2:=\sharp\circ\ast\circ d_{n-2}\circ\ast\circ d_1\circ\flat$ and ends on
     an open question: *"can $A$ be $d_1^{-1}$ and $d_{n-2}^{-1}$ at the same time for $n\neq3$?"*).
     Its actual subject, generalizing curl to $d$ dimensions via de Rham and Hodge, appears nowhere
     in the row. It is his highest-scoring post in this cluster.
   - `186201` *"What are the Eigenvectors of the curl operator?"*, score 14. Covers **both** the
     skew-$\mathfrak{so}(3)$ writing and the eigenvectors, so the row's last two labels are one post.

   Recommendation: split `337971` into its own row (it sits next to P-F's so(d) material, not next
   to the generators), and move `(self-answered)` onto `116633`. His call.
2. **`337971` contains an open question of his own that no answer addressed.** The accepted answers
   (Qiaochu Yuan on de Rham, another on geometric algebra) reframe the question; his own follow-up
   answer, scored 1, poses the $A=d_1^{-1}=d_{n-2}^{-1}$ condition and says *"I am not yet sure how
   to express $\Delta$ and therefore can't check whether $\operatorname{curl}^2=\operatorname{grad}\operatorname{div}-\Delta$."*
   That is a concrete, checkable gap in his own reasoning, thirteen years old, and it is
   SymPy-sized in low $n$. Flagging as a candidate `verify:` target, not as a defect.
3. **His `q/57832` premise is too weak for what it asks.** Similar + diagonalizable does not imply
   commuting, so BCH does not collapse; the question as posed has no simplification. If it becomes
   an aside, the honest form is the negative result plus the nilpotent case where it *does*
   terminate.
4. **One `\veq` handle is `\sorry` on purpose.** `momentum-from-translation` is checked by nothing
   in this batch: its content is Stone's theorem, which belongs to the sibling essay. Left open
   rather than badged from another file's work.
5. **Three-map coincidence.** $u=\ln x$ (here), $z=\exp(2\pi(\sigma+i\tau)/\hbar\beta c)$
   (`wick-entropy.md`), $x=e^{-w}$ (`wirohsh-approximation.md`). If the D1 "methodology themes" list
   is being assembled, *"exponentiate to trade scaling for shifting"* has now earned three
   independent citations from his own material. Recommendation only.

---

## Computation

`.mw`-style, in the shape of `verify/mirror/resogram_esol.mw`. Run under
`uv run --with sympy python`, memory-capped. These are the checks behind the `\sympy` badges;
they are **not** wired into `physics/*.toml` or `tests/test_verify.sh` (dreamed files are
deliberately outside the sidecar machinery).

```computation
# dilation-gen: alpha^{x d/dx} is diagonal on monomials, summed in closed form
S = Sum(log(alpha)**k * n**k / factorial(k), (k, 0, oo)).doit()
dilation_residual = simplify(S - alpha**n)            # -> 0

# rodrigues: closed form for w = e_z
W = Matrix([[0,-1,0],[1,0,0],[0,0,0]])
rodrigues_residual = simplify(exp(theta*W).rewrite(cos)
                              - (eye(3) + sin(theta)*W + (1-cos(theta))*W**2))   # -> 0

# deriv-exp: the owner's a/2047 family, X(t)^2 = 1 so exp is cosh/sinh-closed
X = Matrix([[cos(t), sin(t)], [sin(t), -cos(t)]])
true_deriv  = diff(simplify(exp(X).rewrite(cosh)), t).subs(t, 0)   # -> sinh(1)*sigma_1
integral    = integrate(exp(s*X0)*Xd0*exp((1-s)*X0), (s, 0, 1))    # -> equals true_deriv
naive_right = Xd0 * exp(X0)                                        # -> [[0,exp(-1)],[E,0]]
naive_left  = exp(X0) * Xd0                                        # -> [[0,E],[exp(-1),0]]

# bch4: free non-commuting series, truncated at degree 4 (memory-capped, no unbounded simplify)
L = log_series(exp_series(A) * exp_series(B), order=4)
bch_residual[d] = expand(L[d] - predicted[d])   # -> 0 for d = 0,1,2,3,4
```

## Lean attestation

- **File:** `docs/dreamed/lean/Generators.lean`
- **Command:** `cd /home/tobias/src/toesnail/verify && nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/Generators.lean`
- **Status:** exit `0`, zero `sorry` (`grep -c sorry` = 0). One style lint warning
  (`unnecessarySeqFocus` at line 210), no errors. An in-file `#print axioms` block audits all
  thirteen theorems: each depends on `propext, Classical.choice, Quot.sound` and nothing else.
- **Theorems:** `hat_antisymm`, `hat_mulVec`, `hat_bracket`, `hat_cube`, `hat_cube_unit`,
  `exp_of_sq_zero`, `exp_of_cube_zero`, `heis_bracket_ne_zero`, `heis_ad_A`, `heis_ad_B`,
  `heis_exp_mul_ne_exp_add`, `heis_bch2`, `taylor_polynomial`.
- **Weakened, and said so in the file's header:** Rodrigues itself is SymPy-checked; Lean proves
  only its engine `W^3=-W`. The `\veq{deriv-exp}` counterexample is Lean-proved with the
  *nilpotent Heisenberg* pair rather than the owner's Pauli pair, because the Pauli exponentials are
  not polynomials; the Pauli version is the SymPy one above. The dilation generator is not in Lean
  at all ($x\,d/dx$ is unbounded and would need a functional calculus this file does not build).
- **Not an attestation against the repo's verify machinery.** Per `docs/dreamed/README.md`, `\veq`
  badges in dreamed essays are claims about the dreamed Lean file only.
