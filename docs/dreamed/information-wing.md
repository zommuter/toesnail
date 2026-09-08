---
title: The information wing, and whether it is one wing
permalink: /dreamed/information-wing
---

> **DREAMED. UNREVIEWED. NOT OWNER-AUTHORED.** See [`docs/dreamed/README.md`](./README.md).
> This file *proposes*; the owner disposes. Nothing here is toesnail theory, and nothing may be
> promoted into `physics/`, `essays/` or `crypto/` without the owner authoring the move himself.
> The `\veq` badges below claim something about `docs/dreamed/lean/InfoWing.lean` **only**, and are
> deliberately not wired into `physics/*.toml` or `tests/test_verify.sh`.

**Seed (owner's own open question, `docs/meeting-notes/2026-07-07-1257-corpus-dreaming-session.md`,
verbatim):**

> **Q9 -- wings:** ratify the **information wing** (fhe + entropy + Landauer/Shannon, §1.6) as a
> named third wing beside physics spine and essays? It's the smallest new structure that makes
> fhe.md a first-class citizen.

Sharpened later the same day by the `gtnsd-archive` addendum into "ratify inflownistration as the
information wing's name/ancestor".

# 0. The verdict, stated first

**The wing coheres, and it coheres around one quantity: the logarithm of a count.** Not around the
word "entropy", which appears in the three candidate members in three different grammatical roles.
$\log W$ is the same object in all three **up to a base and units factor**, which is not a quibble:
$\ln$ and $\log_2$ differ by $1/\ln 2$, and `fhe-counting.md` shows that conflating them is exactly
what produced its 0.4068-bit offset. Boltzmann's $S = k_B\ln W$, Hartley's measure,
the owner's own "these functions can be enumerated using $m2^n$ bits" (`crypto/fhe.md` l.8), and the
$\ln Z_B$ his Lagrange calculation in `physics/entropy.md` maximizes. Shannon and Gibbs generalize
$\log W$ to a non-uniform measure; Jaynes argues that generalization is an inference principle rather
than a physical one; Landauer is the single point where $\log W$ is forced to carry joules, and it
has been measured twice.

**Three corrections to how the wing was proposed, though, and the third is fatal to one member:**

1. `crypto/fhe.md` contains **no fully homomorphic encryption**. It is a counting exercise over
   Boolean functions and permutations, with a one-line OTP remark. It belongs in the wing, but as
   *counting and reversibility*, not as cryptography. Anything about FHE noise budgets would be new
   content, which is the owner's to write, not an agent's to weld on.
2. **FHE has essentially no information-theoretic content at all**, so the wing cannot reach it even
   if the file were rewritten. Semantic security is a *computational* notion. Shannon's 1949 bound
   says perfect secrecy needs `H(K) ≥ H(M)`; an FHE key is short and fixed while the plaintext stream
   is unbounded, so the mutual information `I(M;C)` is necessarily large. The OTP belongs in the wing
   because its security **is** an entropy theorem; FHE does not, because its security is a
   complexity-theoretic conjecture wearing the same coat.
3. Corpus row **M-7** (Euler's theorem for non-coprime `a`) has no entropy content whatsoever and
   should not be filed under the wing. It is number theory that happens to be adjacent to crypto.

The wing's one-sentence thesis, if ratified: *counting states is the same act whether you are
computing a partition function, sizing a key, or paying for an erasure, and `log W` is the receipt.*

# 1. The honest coherence test

## 1.1 What is actually in each candidate member

I read the three files rather than their descriptions. What is there:

| File | What it computes | Is there a probability measure? |
|---|---|---|
| `physics/entropy.md` | max of $-\sum p_k\ln p_k$ under two constraints; truncated geometric $Z_B$; BE at $N\to\infty$, FD at $N=2$; Lambert-$W$ inversion | **Yes.** This is Jaynes/Gibbs in full. |
| `crypto/fhe.md` | $O(n,m)=2^{m2^n}$, $\Pi_n=\log_2(2^n)!$, $\binom{4}{2}=6$ balanced functions, $(2^2)!=24$ bijections, radix decomposition of $S_4$ | **No.** Every quantity is a cardinality or its logarithm. |
| Landauer/Shannon (proposed, unwritten) | $k_BT\ln 2$; perfect secrecy | Yes for both. |

That table is the coherence test, and it answers it. `fhe.md`'s quantities are *counts*;
`entropy.md`'s are *expectations under a distribution*. They are the same quantity exactly when the
distribution is uniform, because then and only then $-\sum p\ln p = \ln W$. So the wing is not three
subjects in a trenchcoat, but neither is it one subject: it is **one subject and its uniform-measure
special case**, joined by a bridge that has a name.

## 1.2 The bridge is Jaynes, and the owner has already built it

`physics/entropy.md` line 8 does not assume the Boltzmann distribution. It *derives* it, by
maximizing $-\sum p_k \ln p_k$ under normalization and mean energy with multipliers $\alpha,\beta$.
That derivation contains no physics: no Hamiltonian, no ergodicity, no ensemble of copies, no $\hbar$.
It is an inference procedure, and it is exactly the argument Jaynes published in 1957 to identify
statistical mechanics as a branch of inference. The owner reached it independently and wrote it as
the file's first line. That is what makes the wing possible at all: had `entropy.md` started from the
microcanonical ensemble, the connection to `fhe.md`'s counting would be an analogy, whereas from
max-entropy it is an identity, the same functional under different constraints.

One thing the Lagrange calculation does **not** establish, and which the file does not claim either
way: multipliers give a *stationary point*, not a maximum. That the Boltzmann distribution is the
maximum is Gibbs' inequality, proved in the Lean companion,

$$ \sum_i p_i \ln\frac{p_i}{q_i} \ \ge\ 0 \qquad\text{for probability vectors } p,q>0 \veq{gibbs}\lean $$

with the corollary that closes the owner's own line 8:

$$ S(p) \le \ln Z_B + \beta\langle E\rangle \quad\text{for every } p \text{ with } \textstyle\sum_i p_i E_i = \langle E\rangle \veq{maxent}\lean $$

and equality exactly at $p_k = e^{-\beta E_k}/Z_B$. `\beta` is unconstrained in sign in the Lean
statement, so negative temperatures are covered.

## 1.3 The one quantity, and the same sum read twice

The mechanical witness that the bridge is not verbal: the owner's truncated partition function

$$ Z_B = \sum_{k=0}^{N-1} Z_1^k = \frac{1-Z_1^{N}}{1-Z_1} $$

is, at $Z_1 = 2$, the count of binary strings shorter than $N$ bits:

$$ \sum_{k=0}^{N-1} 2^k + 1 = 2^N \veq{bincount}\lean $$

That is not a pun; it is the observation that a partition function *is* a generating function for a
count, weighted. Set every energy to zero (equivalently $\beta\to 0$, $Z_1\to 1$) and $Z_B\to N$ and
$S\to\ln N$: Boltzmann's formula falls out of Gibbs' as the flat-measure limit. In Lean:

$$ H(p) \le \ln|s| \quad\text{with equality iff } p \text{ uniform} \veq{hartley}\lean $$

## 1.4 Three places the bridge stops, stated because a wing needs its edges

1. **Shannon entropy is a property of a distribution; Kolmogorov complexity is a property of an
   object.** No amount of Jaynes converts one into the other. They agree only in expectation, and
   only for computable sources: for a computable pmf, the expected complexity sits within an additive
   constant of $H$, where the constant is the length of a program for the source. The wing must say
   which of the two it means every single time, or it will silently equivocate.
2. **Thermodynamic entropy carries units and a temperature; Shannon entropy carries neither.** The
   conversion factor is $k_B$, and the *only* thing that forces a particular value of $k_B$ into an
   information statement is a heat bath. That is Landauer, and it is why Landauer is the beam and not
   an application.
3. **Computational security is not an information quantity.** See §3.

# 2. Landauer as the load-bearing beam

## 2.1 Derived from the owner's own setup, not quoted

Take `entropy.md`'s flat-measure limit: a one-bit memory in a bath at temperature $T$ has $W=2$
accessible macrostates before erasure and $W=1$ after. Boltzmann's $S = k_B\ln W$ gives

$$ \Delta S_{\text{sys}} = k_B\ln 1 - k_B\ln 2 = -k_B\ln 2 \veq{landauerS}\lean $$

The system's entropy went down. The second law applies to system plus bath, and the bath's entropy
change at fixed temperature is $Q/T$ with $Q$ the heat it absorbs. Requiring
$\Delta S_{\text{sys}} + Q/T \ge 0$ gives

$$ Q \ \ge\ k_B T\ln 2 \veq{landauer}\lean $$

The Lean statement takes the second law as a **named hypothesis** rather than deriving it, which is
the honest shape: the physics is entirely in that hypothesis and in the identification of $Q/T$ as
the bath's entropy change. Everything after it is arithmetic. A wing that pretends otherwise is
overselling.

```computation
# k_B T ln 2 at room temperature, and the same for one megabyte
kB = 1.380649e-23
T  = 300
E_bit = kB * T * log(2)          # 2.871e-21 J
E_MB  = E_bit * 8e6              # 2.297e-14 J
```

## 2.2 It has been measured, twice

Bérut, Arakelyan, Petrosyan, Ciliberto, Dillenschneider and Lutz, *Experimental verification of
Landauer's principle linking information and thermodynamics*, **Nature 483**, 187 (2012): a single
colloidal particle in a modulated double-well potential, mean dissipated heat saturating at the
Landauer bound in the long-cycle limit. Jun, Gavrilov and Bechhoefer, *High-precision test of
Landauer's principle in a feedback trap*, **Phys. Rev. Lett. 113**, 190601 (2014): the same bound in
a feedback-trap virtual potential. Both verified before citing; neither is invented.

That matters for the roadmap's `[derivation]/[input]/[hypothesis]` tag. Landauer is the one member
that is `[derivation]` *and* empirically anchored; `fhe.md`'s counting is pure `[derivation]`;
Wheeler's "it from bit", proposed in the meeting note as the wing's epigraph, is `[hypothesis]` at
best and should be labelled decoration rather than content.

## 2.3 The four caveats, none of which the wing may skip

- **Landauer bounds erasure, not computation.** A logically irreversible *gate* has the cost; a
  logically reversible computation does not, and Bennett 1973 showed any computation can be made
  logically reversible at polynomial cost in space. This is precisely the owner's `fhe.md`
  distinction between destructive and semi-destructive functions, arrived at from the other side: his
  six balanced functions $\binom{2^n}{2^{n-1}}=\binom{4}{2}=6$ are the ones usable as an output bit
  of a bijection, hence the ones that cost nothing. Counting and thermodynamics pick the same set.
- **The bound is on the average, and attained only quasistatically.** Real erasure at finite speed
  dissipates far more; the 2012 experiment needed long cycles to approach saturation.
- **The Maxwell-demon resolution turns on the demon's memory, not its measurement.** Measurement can
  in principle be done reversibly; it is the demon's eventual need to *reset* its record that pays
  $k_BT\ln 2$ and saves the second law (Bennett 1982). The wing gets the demon story wrong if it puts
  the cost at the measurement step, which is the popular version.
- **The bound is astronomically slack in practice.** Erasing a megabyte costs $2.3\times10^{-14}$ J
  at 300 K. A CPU core drawing 20 W for 0.1 s spends about 2 J, some **fourteen orders of magnitude**
  above the Landauer floor. Landauer says what thermodynamics permits, never what engineering
  approaches.

# 3. The weld to `crypto/fhe.md`: which parts are real

The seed offered three candidate welds. Checked rather than asserted:

**Candidate A, "FHE noise growth is an entropy budget": half real, and not in the owner's file.**
In LWE-based schemes the ciphertext carries an error term and decryption is correct only while the
error stays below $q/4$. Under *addition* the errors add, variances add, and for Gaussian error the
differential entropy $h = \tfrac12\ln(2\pi e\sigma^2)$ grows by exactly the log of the variance
ratio, so "remaining headroom" genuinely is a difference of entropies and the budget language is
literal. Under *multiplication* the error is a product of near-independent terms, is no longer
Gaussian, and grows multiplicatively in magnitude; the honest description there is a **magnitude
budget in $\log q$**, and calling that entropy is a metaphor. Bootstrapping resets the budget by
homomorphically evaluating the decryption circuit. All of this is real mathematics. **None of it is
in `crypto/fhe.md`,** which never mentions noise, ciphertexts, lattices or homomorphism. Proposing it
is proposing new owner content.

**Candidate B, "semantic security means the ciphertext carries ~zero mutual information with the
plaintext": false, and worth stating plainly because it is a common slip.** Semantic security is
*computational* indistinguishability. Information-theoretically, an FHE ciphertext determines its
plaintext completely once the key is fixed, and the key is short. Shannon 1949: perfect secrecy
requires $H(K)\ge H(M)$. Encrypt more bits than the key is long and the mutual information $I(M;C)$
is bounded below by $H(M)-H(K)$, which grows without bound. The owner's own line in `fhe.md` already
carries the correct version of this: *"there is no point in using more than $\Pi_1 = 1$ key bit per
data bit since that is equivalent to the OTP which is secure"*. That sentence **is** Shannon's
perfect-secrecy theorem in counting form, and it is the single strongest crypto claim in the file.
It belongs in the wing. FHE does not.

**Candidate C, "Landauer applies to the erasure a bootstrap performs": true and irrelevant.**
Discarding a stale ciphertext is an erasure costing $k_BT\ln 2$ per bit; §2.3's factor of $10^{14}$
makes the bill invisible next to the arithmetic.

**Consequence for Q9.** `fhe.md` is a first-class citizen of the wing on its counting content, which
the wing needs: it supplies the reversibility half of the Landauer story and the permutation group's
third appearance. It is not a citizen on its title.

# 4. The self-reference thread, and what the wing's spine really is

[`omniscience.md`](omniscience.md) established that no subsystem can hold a complete description of a
whole containing it, and that the obstruction is **arity**, not capacity: `φ : A → (A → B)` cannot be
point-surjective when `B` has a fixed-point-free operation. That argument counts nothing at all.

Its information-theoretic cousin counts *only*. Fewer than $2^n$ programs are shorter than $n$ bits,
because $\sum_{k<n}2^k = 2^n - 1$, so for any decompressor whatsoever there is a length-$n$ string
outside its image:

$$ \forall\, \mathrm{dec}:\ \{\text{descriptions} < n\ \text{bits}\}\to\{0,1\}^n,\ \exists s:\ s\notin \mathrm{im}\,\mathrm{dec} \veq{incompr}\lean $$

and, sharpened, the fraction of length-$n$ strings compressible by $c$ bits or more is under $2^{-c}$:
99.9% of strings resist compression by even 10 bits. Both are in the Lean companion, over an
**arbitrary** `dec` with no computability assumption, because the counting bound never needs one.

This is the same diagonal as Lawvere in a different coat: Lawvere's contradiction comes from a map
being onto something it is inside; this one comes from a map being onto something strictly bigger.
Corpus row **M-5** already gestures at exactly this ("uncountability via describability"), and the
owner's note there welding it to the Gödel/Lean4 bridge is the same instinct.

**Should the counting argument be the wing's spine rather than thermodynamics?** My recommendation is
no. Kolmogorov complexity is uncomputable: no instrument in this repo, at any tier, can ever produce
a `K(x)`, and a spine whose central quantity cannot be evaluated gives a wing that can only quote
itself. Thermodynamics gives the wing a quantity that is computable, measurable, and measured. The
right structural role for the counting argument is the one Coleman-Mandula plays at spine step 9: a
**ceiling theorem**, stated late, saying what the wing cannot do. It is load-bearing precisely
because it is negative, and it is the wing's natural handshake with the essay wing.

# 5. Verdict on Q9, and its weakness

**Recommendation: ratify the information wing, with membership as follows.** This is a
recommendation, not a decision; the wing's existence and name are the owner's call.

| Candidate | Verdict | Reason |
|---|---|---|
| `physics/entropy.md` | **In**, as the wing's engine | Its Lagrange derivation *is* the Jaynes bridge; nothing else in the repo does this. |
| Landauer + Shannon (to be written) | **In**, as the beam | The only member with joules and the only one with experiments. |
| `crypto/fhe.md` counting half | **In** | Reversibility, permutation counting, and Shannon's key bound in the owner's own voice. |
| FHE proper, noise budgets | **Out** | Security is computational; the material is not in the file. |
| Corpus M-5 (describability) | **In**, as the ceiling theorem | Same diagonal as `omniscience.md`, elementary and provable. |
| Corpus M-8 (mental poker, commutative encryption) | **Weakly in** | Commuting encryptions form an abelian subgroup of $S_{2^n}$: it extends the permutation-group protagonist, not the entropy thread. |
| Corpus M-7 (Euler, non-coprime $a$) | **Out** | No entropy content. Number theory, not information. |

**Where it attaches to the ratified 11-step spine.** Not as a third parallel wing hanging off nothing.
It attaches at **step 1** and returns at **step 11**:

- **Step 1** already says *"reversibility → group; counting copies → ℕ"*. The information wing is that
  sentence taken seriously: `fhe.md`'s bijections are $S_{2^n}$, the third appearance of the
  permutation group, and Landauer is what the word "reversibility" costs when it fails. The wing's
  opening chapter can therefore be *demanded* by step 1 rather than bolted beside it, which is what
  "math on demand" requires.
- **Step 11**, the emergence wing, already opens with *"thermodynamics [J57]"*, and [J57] is Jaynes.
  The information wing is the missing derivation under that citation.

**The weakness of this recommendation, stated rather than buried.** The wing as scoped has exactly
**one** owner-authored file with real content (`entropy.md`) plus **one half** of a second
(`fhe.md`'s counting). The Landauer chapter, the perfect-secrecy chapter and the ceiling theorem are
all unwritten. A wing of one-and-a-half files is organizationally indistinguishable from two branch
files that cross-reference each other, and the cost of naming a wing is that every later file must be
assigned to one. The conservative alternative, which I cannot rule out on the evidence, is **no new
wing**: Landauer as a section inside `entropy.md`, `fhe.md` as a branch file citing it, revisit if a
third substantial file appears. The `gtnsd-archive` provenance argument is a reason the wing would be
*authentic*, not evidence that it is *needed*. Which of those matters more is exactly the call this
repo reserves for the owner.

# Lean attestation

File: [`docs/dreamed/lean/InfoWing.lean`](lean/InfoWing.lean). Checked with

```
cd /home/tobias/src/toesnail/verify
nice -n19 lake env lean --threads=2 /home/tobias/src/toesnail/docs/dreamed/lean/InfoWing.lean
```

**Exit status 0, no output, zero `sorry`, zero warnings.** Fourteen theorems:

| Handle | Theorem | Statement |
|---|---|---|
| `gibbs` | `gibbs_nonneg` | $\sum p_i\ln(p_i/q_i)\ge 0$ for strictly positive normalized $p,q$ on a `Finset` |
| `hartley` | `entropy_le_log_card` | $H(p)\le\ln|s|$; uniform maximizes |
| `maxent` | `boltzmann_maximizes` | $S(p)\le\ln Z+\beta\langle E\rangle$ at fixed mean energy |
| `maxent` | `boltzmann_entropy_value` | $S = \ln Z+\beta\langle E\rangle$ *at* $p_k=e^{-\beta E_k}/Z$ |
| `bincount` | `geom_two_succ`, `partition_truncated` | $\sum_{k<n}2^k+1=2^n$; and $Z_B=(1-r^N)/(1-r)$ in the owner's orientation |
| `bincount` | `card_short_descriptions` | $|\{$descriptions $<n$ bits$\}|+1=2^n$ |
| `incompr` | `exists_incompressible` | every `dec` misses some length-$n$ string |
| `incompr` | `few_compressible` | $|\{$desc $<m\}|\cdot 2^c<2^n$ for $m+c=n$ |
| `landauerS` | `log_halving`, `boltzmann_erasure` | $\ln 2W-\ln W=\ln 2$; $\Delta S=-k_B\ln 2$ |
| `landauer` | `landauer_heat` | $Q\ge k_BT\ln 2$, second law as a **named hypothesis** |
| -- | `binary_entropy_le_log_two`, `binary_entropy_half` | $h(p)\le\ln 2$ on $(0,1)$, attained at $p=1/2$ |

**What was weakened, explicitly.** (i) `gibbs_nonneg` requires both vectors strictly positive on the
index set; the $0\ln 0 = 0$ boundary convention is avoided, not handled. (ii) Kolmogorov complexity
is never defined; only the counting bound is proved, over an arbitrary `dec`, and the uncomputability
half of §4 is cited, not proved. (iii) `landauer_heat` assumes the second law rather than deriving it
-- deliberate, and stated in the theorem's own doc comment. (iv) Nothing about FHE is formalized;
§3's verdict is an argument, not a theorem. No `sorry` was used anywhere, and no target was dropped
silently.

Import note for anyone re-running this: the vendored Mathlib has `Mathlib.Algebra.Field.GeomSum`
built but **not** `Mathlib.Algebra.GeomSum` (the source exists, the `.olean` does not).

# Surfaced for the owner

Findings about owner-authored text. **None of these has been filed** into `TODO.md`, `ROADMAP.md`, or
`REVIEW_ME.md`; routing them is the owner's decision.

1. **`crypto/fhe.md` is misnamed relative to its content.** The file's title and permalink say FHE;
   its content is enumeration of Boolean functions, the balanced/semi-destructive split, and $S_4$
   for two bits. There is no encryption scheme, no ciphertext, no homomorphism. This matters for Q9
   because the wing was proposed on the strength of the title.
2. **`crypto/fhe.md` line 14 states Shannon's perfect-secrecy theorem without naming it.** *"There is
   no point in using more than $\Pi_1=1$ key bit per data bit since that is equivalent to the OTP
   which is secure"* is $H(K)\ge H(M)$ in counting form. The corpus meeting note already spotted this
   ([S49]); it is worth a citation in the file itself, since it is the file's sharpest claim.
3. **The three `\leanc` open-debt markers in `crypto/fhe.md` are all now discharge-able**, and two of
   them by a `decide`: `ocount` ($2^{m2^n}$, `Fintype.card_fun`), `bij24` ($(2^2)!=24$,
   `Fintype.card_perm`), `semidestr` ($\binom{4}{2}=6$, `Nat.choose`). I did **not** formalize them,
   because the fourth claim attached to `semidestr` -- *"only the six balanced functions are
   semi-destructive, i.e. can be used as output bit of a bijective function"* -- is an owner
   **modelling** identification (balanced $\iff$ semi-destructive), not a counting fact, and freezing
   its Lean signature is a physics-direction call, not a tooling one. That is the
   `routine-vs-hard-test-gates-real-goal` pattern: the count would go green while the identification
   went unchecked.
4. **`physics/entropy.md` line 8 proves stationarity, not maximality.** Lagrange multipliers give a
   critical point; the second-order fact is Gibbs' inequality. `boltzmann_maximizes` closes it. If the
   owner wants that stated in the file, it is one sentence and a `\veq{...}\lean`.
5. **`crypto/fhe.md` line 76 carries a live `TODO switch endianess of permutation`** inside the
   24-row bijection table, whose `LE`/`BE` columns are explained in the $m=1$ section while the table
   below uses a third convention (radix 4/3/2). Notation snag only; I did not check whether the radix
   decomposition on lines 107-110 is consistent with the table.
6. **Row M-7 is filed under "crypto/info wing" in `docs/se-corpus.md` and does not belong there.**
   Euler's theorem for non-coprime $a$ is a number-theory result with no information content.
7. **`crypto/fhe.md` has two sections both headed `# $n=2$`** (lines 36 and 72), the first being the
   $m=1$ case. On the rendered site both become the same anchor.

# Follow-up leads

1. **Does the reversibility/Landauer pairing survive to the quantum case?** Unitary evolution is
   reversible by construction, so the wing's claim would be that measurement is where the bill
   arrives. Decidable by checking whether the Groenewold-Ozawa information gain of a projective
   measurement reproduces $k_BT\ln 2$ per outcome bit under §2.1's bookkeeping.
2. **Is $N$ in `entropy.md`'s truncated $Z_B$ the same $N$ as a Hartley alphabet size?** Decidable by
   computing $S = \ln Z_B + \beta\langle E\rangle$ at $\beta\to 0$ for general $N$ and checking
   whether it reduces to $\ln N$ exactly. If it does, the wing gets a second mechanical weld as strong
   as `bincount`, and it connects to the Gentile-statistics reading in `lambertw-statistics.md`.
3. **Does `gtnsd-archive`'s "inflownistration" name this quantity or a different one?** Decidable by
   reading that branch's README for whether its "information flow" is a count, a rate, or a metaphor.
   I did not read it. If it is a rate, the wing's name is wrong and the archive stays essays-wing
   material, as `CLAUDE.md` already suspects.
4. **Would the wing pay for itself in `.mw` terms?** Decidable by counting the cross-file DAG edges a
   wing boundary would add against those `physics/entropy.md` already has. Fewer new edges than a
   single file's internal chain means organizational overhead, not structure.
5. **Is the balanced $\iff$ semi-destructive identification in `fhe.md` line 65 true for $n\ge 3$?**
   For $n=2$ it holds by inspection over 16 functions. Decidable by brute force for $n=3$ (256
   functions), and if it fails there, surfaced item 3 becomes a rigor-debt finding rather than a
   formalization opportunity.

---

*Sources verified during this session:*
[Bérut et al., Nature 483, 187 (2012)](https://www.nature.com/articles/nature10872) ·
[Jun, Gavrilov, Bechhoefer, PRL 113, 190601 (2014)](https://link.aps.org/doi/10.1103/PhysRevLett.113.190601)
