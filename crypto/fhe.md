---
title: FHE
permalink: /FHE
---

# Intro

For $n$ input bits there are $I = 2^n$ possible inputs. For each input, there are two possible outputs for each of the $m$ output bits, so there are $O(n,m)=(2^I)^m = 2^{m2^n}$ possible functions from $n$ to $m$ bits. These functions can be enumerated using $m2^n$ bits.

For $m=n$ a function is bijective iff the output map is a permutation of the input map, which means there are $P=(2^n)!$ bijective functions for $n$ bits, which can be enumerated using

$$\Pi_n := \log_2(2^n)! \approx 2^n(n - \log_2e)+\frac n2 + \ln\sqrt{2\pi} + \mathcal O(2^{-n}) \quad\text{(by Stirling's approximation)}$$

bits. For encryption, there is no point in using more than $\Pi_1= 1$ key bit per data bit since that is equivalent to the OTP which is secure -  or put differently, anything beyond that means it's easier to guess the plaintext message itself than the key. However, $\frac1n\Pi_n>1\forall n\ge2$ (starting with $\frac12\Pi_2 \approx2.3$), so the question is how to sensibly reduce the amount of bijective functions such that there are no excessive keybits used.


# $n = 0, m = 1$

Without input, a single output can either be set (SET, 1) or cleared (CLR, 0). This corresponds to the $O(0,1) = 2^{2^0}=2$ outputs. Half of the outputs here and in the following are always obtained by inverting all output bits.

# $n=m=1$

There are $O(1,1) = 2^{2^1}=4$ possible functions with one output bit, of which $2=O(0,1)$ ignore the input.

| enumeration | permutation |   0 |   1 | name | destructive |
| ----------: | ----------: | --: | --: | :--- | :---------: |
|          00 |           - |   0 |   0 | CLR  |      Y      |
|          01 |           0 |   0 |   1 | ID   |      N      |
|          10 |           1 |   1 |   0 | NOT  |      N      |
|          11 |           - |   1 |   1 | SET  |      Y      |

For a single bit, if the permutation index is used as key that is equivalent to XORing, i.e. the OTP.



# $n=2$


## $m=1$

There are $2^{2^2}=16$ possible outputs for two input bits, which can be split the following way:

- (0): $2$ ignoring all input (CLR, SET)
- (1): $4 = 2\cdot2$ only depending on one input each
- (2): 10 truly depending on both inputs


In the following tables, the inputs are named $A,B,C,...$ for convenience and omitted where obvious (e.g. AND means A AND B).

| 00    | 01    | 10    | 11    | FUN         | SUM   | BE    | LE     |
| ----- | ----- | ----- | ----- | ----------- | ----- | ----- | ------ |
| 0     | 0     | 0     | 0     | CLR         | 0     | 0     | 0      |
| 0     | 0     | 0     | 1     | AND         | 1     | 1     | 8      |
| 0     | 0     | 1     | 0     | A AND NOT B | 1     | 2     | 4      |
| **0** | **0** | **1** | **1** | **A**       | **2** | **3** | **12** |
| 0     | 1     | 0     | 0     | NOT A AND B | 1     | 4     | 2      |
| **0** | **1** | **0** | **1** | **B**       | **2** | **5** | **10** |
| **0** | **1** | **1** | **0** | **XOR**     | **2** | **6** | **6**  |
| 0     | 1     | 1     | 1     | OR          | 3     | 7     | 14     |
| 1     | 0     | 0     | 0     | NOR         | 1     | 8     | 1      |
| **1** | **0** | **0** | **1** | **NXOR**    | **2** | **9** | **9**      |
| ...   |       |       |       |             |       |       |        |
| 1     | 1     | 1     | 1     | SET         | 4     | 15    | 15     |

The second half of the table is abbreviated for simplicity, since it consist of the output inversions of the upper half. The columns BE and LE interpret the four output variations big-endian and little-endian respectively for enumerating the functions. Since it makes more sense for A,B to have low numbers instead of their negations, we'll stick with BE from now on. For each sum $s$ of truth-outputs per function there are $\binom4s$ functions, i.e. 1,4,6,4,1. Only the six balanced functions A, B, XOR and there inverses are "semi-destructive", i.e. can be used as output bit of a bijective function, all others destroy information and make it impossible to retrieve the original inputs with just one other bit. Therefore it makes more sense to split the functions like this:

- $\binom{2^n}{2^{n-1}}=6$ semi-destructive functions A, B, XOR and inverses, consisting of the 4 single-input functions (1) from above and only 2 of the 10 dual-input ones (2)
- the other 10 fully destructive functions



# $n=2$

For brevity, only the $(2^2)! = 24$ bijective functions of the $2^{2\cdot 2^2}=256$ functions for bits (A,B) are shown:

TODO switch endianess of permutation

| permutation |  00 |  01 |  10 |  11 | OUT1 | OUT2 | name |
| ----------: | --: | --: | --: | --: | :--- | :--- | ---: |
|       0 000 |  00 |  01 |  10 |  11 | A    | B    |   ID |
|       1 001 |  01 |  00 |  10 |  11 | A    | NXOR |      |
|       2 010 |  00 |  10 |  01 |  11 | B    | A    | SWAP |
|       3 011 |  10 |  00 |  01 |  11 | NXOR | A    |      |
|       4 020 |  01 |  10 |  00 |  11 | B    | NXOR |      |
|       5 021 |  10 |  01 |  00 |  11 | NXOR | B    |      |
|       6 100 |  00 |  01 |  11 |  10 | A    | XOR  |      |
|       7 101 |  01 |  00 |  11 |  10 | A    | -B   |      |
|       8 110 |  00 |  11 |  01 |  10 | B    | XOR  |      |
|       9 111 |  11 |  00 |  01 |  10 | NXOR | -B   |      |
|      10 120 |  01 |  11 |  00 |  10 | B    | -A   |      |
|      11 121 |  11 |  01 |  00 |  10 | NXOR | -A   |      |
|      12 200 |  00 |  10 |  11 |  01 | XOR  | A    | -121 |
|      13 201 |  10 |  00 |  11 |  01 | -B   | A    | -120 |
|      14 210 |  00 |  11 |  10 |  01 | XOR  | B    | -111 |
|      15 211 |  11 |  00 |  10 |  01 | -B   | NXOR | -110 |
|      16 220 |  10 |  11 |  00 |  01 | -A   | B    | -101 |
|      17 221 |  11 |  10 |  00 |  01 | -A   | NXOR | -100 |
|      18 300 |  01 |  10 |  11 |  00 | XOR  | -B   | -021 |
|      19 301 |  10 |  01 |  11 |  00 | -B   | XOR  | -020 |
|      20 310 |  01 |  11 |  10 |  00 | XOR  | -A   | -011 |
|      21 311 |  11 |  01 |  10 |  00 | -B   | -A   | -010 |
|      22 320 |  10 |  11 |  01 |  00 | -A   | XOR  | -001 |
|      23 321 |  11 |  10 |  01 |  00 | -A   | -B   |  NOT |

As can be seen there are six possible output bits: A,B,-A,-B,XOR and NXOR, but not all combinations yield bijective functions. Another option to obtain all functions is by using the combinations for two out of A,B,XOR (yielding $3\cdot2=6$ choices) multiplied by the $2^2=4$ choices of which output bits to invert. In fact there's a 1:1 mapping for this:

- Radix 4 (the leading digit ranging from 0 to 3) binary-encodes to the output signs to be inverted (0 = none, 1 = out2, 2 = out1, 3 = both)
- Radix 3 denotes which output yields the first input A (0 = out1, 1 = out2, 2 = neither)
- Radix 2 finally denotes whether the first non-A output is B (0) or A NXOR B (1)
- Radix 1 is always 0 and therefore omitted

```python
print("hello")
```
