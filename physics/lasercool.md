---
title: Lasercold
permalink: /Lasercold
---

Kinda part of my [Theory of Everything - Some Novel Approach Including Love ❤️ – Math on Demand Edition](./)
[![](img/cc-by-nc-sa-88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

# Super-simple overview

## One photon, one two-level system

### Resonance at rest

```
.
.                ------- E_1
.      w_p          A
.     ~~~>          |
.                   |--w_0
.                   V
.                ---x--- E_0
```

One of the most simple interactions between light and matter (aside from the fundamental QED Feynman graph) is that between a single photon of energy $\hbar\omega_p$ (and frequency $\omega_p$) and a two-level system with a resonance frequency $\omega_0 = (E_1-E_0)/\hbar$. If those frequencies match, the photon can get _absorbed_ to make the system excited.

```
.
.                ---x--- E_1
.                   A
.                   |
.                   |--w_0 = w_p
.                   V
.                ---o--- E_0
```

The excitement won't last forever though and due to a process know as _spontaneous emission_ the original photon can get emitted again in a _random direction away_, leaving the system again in its original, un-excited state.

```
.
.                ------- E_1
.                   A          w_p
.                   |         ~~~> (random direction away)
.                   |--w_0
.                   V
.                ---x--- E_0
```

But in reality, there are several assumptions not met exactly in the sentence _"One photon interacts with one two-level system at rest at exact resonance"_, and we'll go through each semantic block in this:

* There is more than "_one_ photon", leading to _stimulated emission_ as described in [Multiple photons, one two-level system](#multiple-photons-one-two-level-system)
* The photon could _not_ interact with the system at all, though that's trivial and thus boring
* There is more than "_one_ two-level system", leading to statistical effects, especially _temperature_
* There are more than "_two-level_"s for the system, which is actually important for a _laser_
* The system is not exactly "_at rest_" (with respect to the observer's laboratory system), see _relativistic Doppler shift_ in [Resonance in motion](#resonance-in-motion)
* The interaction doesn't happen "at _exact resonance_", i.e. the photon energy does not exactly match, see _Rabi oscillations_
* The interaction could be between something else than a _photon_ and a _system_ to be precise, but that is out of scope for this document

### Resonance in motion

As described in [the Wikipedia article on the relativistc Doppler shift](https://en.wikipedia.org/wiki/Relativistic_Doppler_effect) (named after physicist Christian Doppler, though his description is only valid for non-relativistic velocities), if the light source and the system are in motion relative to each other, a frequency shift depending on the relative velocity occurs. Light is "_blue-shifted_" (or more precisely, perceived as having a higher frequency than at relative rest) when the light source and the system are moving towards each other and "_red-shifted_" (having lowered frequency).

The energetic symmetry of [resonance at rest](#resonance-at-rest) is no longer guaranteed due to the random direction the photon can get emitted, thus leading to a change of the system's velocity and thus energy. In a simplified way this can be seen as an initial description of _laser cooling_ if a red-shifted photon gets absorbed, since it is more likely to get re-emitted in any other direction which is less red-shifted. Conversely, _leaser heating_ can also be described that way by re-emission of an originally blue-shifted photon.

## Multiple photons, one two-level system

```
.
.                ---x--- E_1               -------
.      w_p          A                                  2 identical photons
.     ~~~>          |           ------->               ~~~>
.                   |--w_0                             ~~~>
.                   V
.                ---o--- E_0               ---x---
```

If a photon interacts with an already excited system, it can cause an _identical_ photon to be emitted via _stimulated emission_ instead of the random _spontaneous emission_ mentioned before. In this case, the system will be back to its original velocity, only at a slightly shifted trajectory due to the temporary change of velocity during the excited phase.

This effect can counter the laser cooling/heating described in [Resonance in motion](#resonance-in-motion). This is a simple explanation why laser cooling only works at a limited speed, since the next photon should only interact once spontaneous emission has sufficiently likely occurred. Also note how the system changes velocity and thus its relative resonance frequency once a first photon has been absorbed, so [off-resonance](#off-resonance) effects need to be considered as well.

While stimulated emission may sound detrimental to the idea of laser cooling at first, the effect is crucial for the actual function of a laser itself -- however, due to the random nature of spontaneous emission, a two-level system cannot lase on its own since lasing requires a majority of excited systems to resonate with. It is the very effect described in [Multiple levels](#multiple-levels) later on that is required for lasers to work at all as well as the foundation for the idea of cooling described in this document.

## Multiple (two-level?) systems

## Multiple levels

## Off-resonance