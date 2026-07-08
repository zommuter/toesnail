# SE corpus — the owner's StackExchange posts mapped to toesnail

Durable inventory of owner-authored StackExchange material worth drawing on, mined
2026-07-08 (see `docs/meeting-notes/2026-07-08-1056-se-corpus-mining-and-lasercool-deepdive.md`
for the full findings + rationale). One line per post/cluster. Maintenance is
mechanical (`[ROUTINE]`-able): add rows as new posts appear, flip **Status** when the
owner promotes/authors an item. The AI never authors the physics these rows point at.

**Status values:** `promoted` (owner-ratified for authoring; date) · `inventory`
(parked until its spine step is authored) · `deep-dive` (has its own findings memo) ·
`open-on-SE` (the SE post itself is still unanswered).

Accounts: network [125888](https://stackexchange.com/users/125888/tobias-kienzler) ·
physics.SE uid 97 (26 Q / 54 A) · math.SE uid 163 (93 Q / 63 A) · also infosec,
crypto, bitcoin, MathOverflow.

## Physics.SE

| Ref | Post(s) | Subject | Feeds | Candidate form | Status |
|---|---|---|---|---|---|
| P-A | [q/8518](https://physics.stackexchange.com/q/8518) (115) | Noether for discrete symmetries | step 4 ↔ 1 | "What Noether doesn't give you" aside | **promoted 2026-07-08** |
| P-B | [q/8626](https://physics.stackexchange.com/q/8626), [q/8860](https://physics.stackexchange.com/q/8860) | converse of Noether; DOF counting | steps 1, 4 | rigor-debt aside pair | inventory |
| P-C | [q/27195](https://physics.stackexchange.com/q/27195) | Casimir eigenvalue eqs as field eqs (P²→KG, W²→spin?) | steps 3–5 | step-5 headline exploration/epigraph | **promoted 2026-07-08** |
| P-D | [a/8627](https://physics.stackexchange.com/a/8627) | mass = Casimir P² of the whole system | steps 3, 5 | sidebar citation | inventory |
| P-E | [q/48349](https://physics.stackexchange.com/q/48349)+own answer, [a/281724](https://physics.stackexchange.com/a/281724) | −¼F² ⇒ massless photon; Proca DOF count | step 7 (+5) | rigor-debt aside | inventory |
| P-F | [q/27279](https://physics.stackexchange.com/q/27279) = MO [89955](https://mathoverflow.net/q/89955), [q/759844](https://physics.stackexchange.com/q/759844) | VSH under Poincaré; so(d) ladder ops | steps 3–4 | exploration file (SymPy-friendly) | inventory · open-on-SE |
| P-G | [q/671433](https://physics.stackexchange.com/q/671433) | multi-particle notation: Fock vs ⊗ vs Hilbert-of-Hilbert | step 0 (Q1 evidence) | notation sidebar | inventory |
| P-H | [q/625](https://physics.stackexchange.com/q/625) (56) | the quantization ladder / "third quantization" | step 6 | narrative aside | inventory |
| P-I | [q/143075](https://physics.stackexchange.com/q/143075) | Wick rotation of entropy (it↔β, iS↔?) | wirohsh, entropy, step 11 | verify-marked open speculation | inventory |
| P-J | [q/817764](https://physics.stackexchange.com/q/817764) | time-reversal of stimulated emission vs absorption | lasercool, step 4 | aside | inventory |
| P-K | [q/787284](https://physics.stackexchange.com/q/787284) | acoustic Fresnel formulas | acoustics | new section/citation | inventory |
| P-L | [q/1324](https://physics.stackexchange.com/q/1324) (55) | is the world C^∞? | step 6/2, wirohsh, essays | essay-wing aside | inventory |
| — | [q/669175](https://physics.stackexchange.com/q/669175) | laser-cool a laser-pumped cavity / entropy via lasing | lasercool | anchors ratified for the 3 empty sections (Q14) | **deep-dive 2026-07-08** |
| — | [q/595522](https://physics.stackexchange.com/q/595522), [q/80157](https://physics.stackexchange.com/q/80157), [q/206108](https://physics.stackexchange.com/q/206108), [q/129158](https://physics.stackexchange.com/q/129158), [a/23960](https://physics.stackexchange.com/a/23960), [a/364789](https://physics.stackexchange.com/a/364789) | momenton; proper-time; regularized Coulomb (self-answered, verify-ready); measuring entropy; wave-cancellation energy; d-dim Laplacian | steps 6/10/11, entropy | lower-priority asides / worked examples | inventory |

## Math.SE and rest of network

| Ref | Post(s) | Subject | Feeds | Candidate form | Status |
|---|---|---|---|---|---|
| M-1 | [116633](https://math.stackexchange.com/q/116633)+[a/116639](https://math.stackexchange.com/a/116639), [337971](https://math.stackexchange.com/q/337971), [186201](https://math.stackexchange.com/q/186201) | generators: e^{a d/dx}, dilation α^{x d/dx} (self-answered), curl as skew so(3), curl eigenvectors | step 4 | exploration/aside, owner-worked | **promoted 2026-07-08** |
| M-2 | [2043](https://math.stackexchange.com/q/2043)+[a/2047](https://math.stackexchange.com/a/2047), [57832](https://math.stackexchange.com/q/57832) | d/dx e^{A(x)} non-commuting; BCH ln(AB) | steps 3–4 | rigor-debt lemmas (`\veq` candidates) | **promoted 2026-07-08** |
| M-3 | [4734748](https://math.stackexchange.com/q/4734748) | unitaries with {Uᵢ†,Uⱼ}=2δ → Clifford algebra | steps 3/5/6 | aside → gamma matrices | inventory |
| M-4 | [468839](https://math.stackexchange.com/q/468839), [469568](https://math.stackexchange.com/q/469568) | ζ-regularization consistency | step 6 | rigor-debt aside | inventory |
| M-5 | [119639](https://math.stackexchange.com/q/119639) (40), [2447217](https://math.stackexchange.com/q/2447217) | liar paradox; uncountability via describability | step 11/info wing, essays | welds to Lawvere/omniscience + MDL | inventory |
| M-6 | [444826](https://math.stackexchange.com/q/444826), [5696](https://math.stackexchange.com/q/5696), [503548](https://math.stackexchange.com/q/503548) | Fourier : transform :: Laurent : ?; analytic⟺one-sided FT | wirohsh (theme №3) | aside/citation | inventory |
| M-7 | [518845](https://math.stackexchange.com/q/518845), [537284](https://math.stackexchange.com/q/537284) | Euler's theorem for non-coprime a; aⁿ mod n | crypto/info wing | exploration material | inventory |
| M-8 | crypto [86629](https://crypto.stackexchange.com/q/86629), [26658](https://crypto.stackexchange.com/q/26658); infosec [48022](https://security.stackexchange.com/q/48022) (111); bitcoin [21270](https://bitcoin.stackexchange.com/q/21270) | mental poker/commutative encryption; unordered hashing; post-quantum survivability; ECDSA-vs-RSA | info wing ∩ love-wing games | wing material | inventory |
| M-9 | [a/1297](https://math.stackexchange.com/a/1297) (28) | trig identities from e^{ix} | step 2 | "ℂ pays rent" demo | inventory |
