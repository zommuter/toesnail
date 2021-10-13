---
title: 🦶TOESNAIL-MODE🐌
permalink: /
author: Zommuter
---

Theory of Everything - Some Novel Approach Including Love ❤️ – Math on Demand Edition
[![](img/cc-by-nc-sa-88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

# About
Doesn't [Theory of Everything (TOE)](https://en.wikipedia.org/wiki/Theory_of_everything) sound just great? So that's the general idea. A theory explaining [life, the universe and everything](https://en.wikipedia.org/wiki/Phrases_from_The_Hitchhiker%27s_Guide_to_the_Galaxy#The_Answer_to_the_Ultimate_Question_of_Life,_the_Universe,_and_Everything_is_42). And since I was looking for an unused acronym starting with TOE that is sufficiently easy to pronounce I thought of TOENAIL. Then I thought better of potential internet search results and added the 🐌S. And since [all is full of love](https://youtu.be/u0cS1FaKPWY) and [all you need is love](https://youtu.be/_7xMfIp-irg), that's obviously what a theory of _everything_ must include. Well, that's the theory at least, let's see where we really end up…

[![](img/xkcd-55-useless.jpg)  
https://xkcd.com/55 (CC BY-NC 2.5)](https://xkcd.com/55/)

So the idea I've been carrying around is a bit different from the typical textbook approaches I know of. In [Physics](https://en.wikipedia.org/wiki/Physics) there's usually the eternal cycle of observation, theoretical explanation, extrapolation (to new potential observations) and experimentation leading to both confirmed or new observation. This [Scientific Method](https://en.wikipedia.org/wiki/Scientific_method) is just marvellous and really should be applied more in our everyday lives instead of hearsay, fake news and alternative facts. And that's what I love about [Theoretical Physics](https://en.wikipedia.org/wiki/Theoretical_physics) and [Pure Mathematics](https://en.wikipedia.org/wiki/Pure_mathematics) – you cannot argue with $$1+1=2$$. It's pure theory, and no experiment can be [rigged](https://en.wikipedia.org/wiki/Scientific_misconduct) in order to favour a desired outcome, nor can measurement errors yield wrong conclusions. That is not to say it's perfect let alone trivial, and what's the point of [a great theory if there's no reality to apply it to](https://en.wikipedia.org/wiki/String_theory#Number_of_solutions)? So ultimately the goal of this project is to describe the actual world, and yes, even including love despite it's incredible capability to escape most logical explanations 😅

## Math on Demand Edition?
Not everybody likes maths<sup>[\[citation needed\]](https://xkcd.com/285/)</sup>. Crazy, I know 😜 No, let me be honest: I like maths [**iff**](https://en.wikipedia.org/wiki/If_and_only_if "If and only if") it is useful. So maybe [Pure Mathematics](https://en.wikipedia.org/wiki/Pure_mathematics) is not actually my preference. As an example back when studying I saw no purpose in learning about [Eigenvalues](https://en.wikipedia.org/wiki/Eigenvalues_and_eigenvectors) in Linear Algebra lectures until much later when in Physics they were applied to e.g. [Quantum Mechanics](https://en.wikipedia.org/wiki/Eigenvalues_and_eigenvectors#Schr%C3%B6dinger_equation). So in this project I try a different approach called "math on demand". There _will_ be maths, and not too little (I intend to basically directly use [Group Theory](https://en.wikipedia.org/wiki/Group_theory) as an example), but only when it's actually needed and motivated. Anything we don't need here I won't bother to explain – think [YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it "You aren't gonna need it"), or even better, [Occam's razor](https://en.wikipedia.org/wiki/Occam's_razor), which boils down to "don't overthink it (unless you have to)", and good old [KISS](https://en.wikipedia.org/wiki/KISS_principle "Keep it simple, stupid").

## [The Shape of Things to Come](https://www.youtube.com/watch?v=x8zsE5zdlsQ&list=RDMW9FDByKsC4&index=2 "which word's are not capitalized in title case again?") – What to expect, and when?
Let's see where this leads to… Consider yourself lucky I woke up way too early tonight so I felt like finally starting to write this, but be aware that I'm an expert in [getting things not-so-done](../gtnsd) aka procrastination, so don't get your hopes up too much. Then again, feel free to [motivate me gently](https://github.com/zommuter/toesnail/issues).

# Getting started
## Name it to tame it
First of all, always writing something like "life, the universe and everything" is quite tedious. It is _very_ convenient to use single-letter[^variables] variables as abbreviations instead, such as $$t$$ for a time. For various reasons, not only Latin letters are used, but sometimes also Greek ones. In order determine the **_state_** of a system, the letter Psi $$\Psi$$ (or it's lowercase version $$\psi$$) is a very typical choice. And in order to indicate that it's a state, it is surrounded by a bar $$|$$ and an angle bracket $$\rangle$$ as $$\ket\Psi$$. Since this is using the right half of an angle bracket pair, this is called a **_ket_ vector**. And yes, we'll later also encounter the left bracket counterpart $$\bra\Psi$$, called a _bra_ vector[^bra-ket]. Such a ket-vector can describe things as complicated as "life, the universe and everything" and as simple as a tossed coin. The entirety of all possible _ket_ vectors is called a **vector space**. Now if multiple states are considered, some options occur:

* Just use different letters, such as Phi $$\Phi$$ (lowercase $$\phi$$ or sometime $$\varphi$$ though that usually rather denotes an angle),
* Add indices as subscripts, e.g. $$\ket{\Psi_{\text{in}}}$$,
* Explicit labels, such as $$\ket{42}$$ or $$\ket{\text{coin=heads}}$$.

[^variables]: Programmers actually frown upon this, and indeed when programming there's often too many variables to still keep an overview, so they use _descriptive_ variable names instead. In physics, formulae such as "velocity = (elapsed distance) / (elapsed time)" instead of $$v =\frac{\Delta x}{\Delta t}$$ would get quite messy quickly, especially when doing maths by hand.

[^bra-ket]:  For more information feel free to consult the Wikipedia article on the [bra-ket notation](https://en.wikipedia.org/wiki/Bra%E2%80%93ket_notation), but be advised it is _heavy_ on maths and will quickly invoke terms such as _Hilbert space_ – a very important concept, but way too soon to explain here.

# Observation: _(Insert witty headline here)_
So describing the entirety of existence as $$\ket{42}$$ is all fun and games until you try to actually work with it. To get more serious, reality and theory must meet somewhere. 

## Subsystems: [Divide and Conquer!](https://en.wikipedia.org/wiki/Divide-and-conquer_algorithm "Veni, vidi, vici")
If $$\ket{42}$$ is known, you're omniscient and don't need to read on (since you already know _everything_ including this very text. #TODO: try and proof whether omniscience is impossible?). Most mortals however don't, and it is infeasible to try and know everything about the entire universe at all times. Let us therefore split $$\ket{42}$$ into smaller parts that ideally don't interact too strongly with one another, e.g.

$$\ket{42} = \begin{pmatrix}\ket{\text{coin}} \\ \ket{\text{everything else}}\end{pmatrix}.$$

IIRC there are many ways of notation for composite systems, one #TODO for me is [making sure I choose a sensible one / don't mix up various concepts I learned too long ago...](https://physics.stackexchange.com/q/671433/97)

As mentioned before, the split should be made in such a way that $\ket{\text{everything else}}$ does not interfere much, at least for a while. Now, when we say "a while" so nonchalantly, we are very much ignoring that we have not even defined the passage of time so far. Let's fix this next.

## Transition: [Time keeps on slippin'](https://youtu.be/9gF2UySGZAU "Fly Like An Eagle")
Basically $$\ket{42}$$ encodes _everything forever_. But being beings that perceive time in a linear fashion we're typically interested in transitions between states, such as the question how a state evolves over time. Interactions between systems are of interest as well. Let's take the coin example again:

$$\ket{\text{coin}} \to \ket{\text{tossed coin}}$$

The arrow $$\to$$ just denotes this transition. #TODO: get to operators...

## Projection: [What you perceive is what you believe](https://en.wikipedia.org/wiki/Psychological_projection "forms the basis of empathy by the projection of personal experiences to understand someone else's subjective world")
In the coin example, the outcome can be either[^klugscheisserCoin] $\ket{\text{heads}}$ or $\ket{\text{tails}}$. If the probability of $\ket{\text{heads}}$ is $p$ (ideally 50% for a fair coin tossed fairly), then the probability of $\ket{\text{tails}}$ is $1-p$. Before the result of the toss is checked, or "measured", we hence have

$$\ket{\text{tossed coin}} = p\cdot\ket{\text{heads}} + (1-p)\cdot\ket{\text{tails}}.$$

Before we talk about actual measurement, let's finally properly introduce a very convenient tool: The **_bra_ vector** $\bra{\Psi}$, which is the _dual_ vector to the _ket_ vector $\ket{\Psi}$. The term **"duality"** indicates that for each ket vector there exists precisely one "partnering" bra vector and vice versa - a very important concept, it is (#TODO, for now c.f. https://math.stackexchange.com/q/2470393/163) probably worth a first more mathematical excursion to prove this uniqueness in duality (though more precisely that's not something to proof but rather "by definition"). Since the entirety of ket vectors is called vector space, its dual counterpart (the entirety of bra vectors) is called a **dual (vector) space**.

[^klugscheisserCoin]: Yes, yes, it could also be $\ket{\text{picked by a bird mid-air}}$ and the likes, but remember KISS?

---

Let's continue with a roughly commented outline, consider this a sneak preview.

## Observe
Measurement via operators, but not the Eigenvalue-Approach, rather some product space or such. Eigenvalues of course, too, but not as "measurement values" but rather to justify bases and such.

## Symmetry / Noether / Gauge
Gently get from dynamics via operators to group theory, conservation thanks to Noether's Theroem, and the connection between particle fields and gauge theory. Probably something about symmetry breaking à la Higgs, but I'll have to read up on that again first...
