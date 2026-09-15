---
title: Getting Things not-so-done Part II
author: Zommuter
permalink: /gtnsd2
---

# Getting Things not-so-done Part II

## 20260915

Has it really been almost ten years already?

Lots has happened since, and I'm not just talking about the Rise of LLMs... But yeah, I've tried my fair share of vibe-coding with more or less interesting results, let's see where they lead.

I'm still seeking the "perfekt [supertool](supertool.md)" of course, mixed with inflownistration which now thanks to LLMs should also support semantic similarity tracking and so on. But instead of describing features, let's try and visualize what I'd like to use to work - there might be some abstract concepts involved, even stuff like PLM/ALM, project management, linguistic atoms and the likes, so let's dive in straight.

### Starting to work

So you've awoken, did whatever your morning routine was and now you want to get to work. Since you're reading this, that most likely means switching on your PC or at least using a smartphone or similar. "Now what?". Yes, if you're following some productivity guides, most likely you've heard the "prepare something for you to get started with the next day" so you don't start from scratch. Ideally you've managed to wrap up something in the previous evening/night (or whatever your chronotype actually requires) and left a simple yet motivating task for the next day (or sprint, iteration, whatever), to be relaxed enough for a good night's sleep, while already having a task prepared.

### Abstraction: TODOs

So what is "a task prepared"? Hopefully you're using some issue tracker or other tool that works well for _you_. Unfortunately for me, picking "the" perfect tracker tool turns into a rabbithole (and while I'm writing this I'm once again distracted by the question of setting up a spell-checker in vscode which I'm currently using, lacking the dreamed-of supertool). Ugh, getting side-tracked, eh? Yes, we could dive into issue terminology, epics, planning poker and the likes, but let's _not_.

Nowadays with AI agents (or maybe you're a meatworld teamlead anyway) you do not only have your own tasks, but those of your ~~minions~~ agents/subordinates. Coordination is imperative. Just have a look at my [dotclaude-skills](../../dotclaude-skills/README.md) repo and the mess its manual `TODO.md` files bloated to. It works somehow, but it's clearly far from ideal and basically I'm reinventing yet another square-shaped wheel - or rather, enable Claude Code to do it for me, instead of adapting decades-established tools properly. That needs to change - hundreds of lines of code to turn markdown into a "database" of sorts with the worst of all worlds, that's just not efficient at all.

But issue tracking is already behind the curtains, I want to dream about the UX - maybe a BDD approach.

### "The" UX

In contrast to an idle clicker game, the actual costs and results of letting your delegates work on a task can probably only be roughly estimated (though ideally those estimates improve over time). But maybe the analogy is not _that_ bad - you do have some budget, be that AI tokens (API calls or subscription quota) or the infamous "~~man~~ employee hours" that you have to invest into tasks that hopefully yield adequate returns. So indeed you do have some kind of **dispatch** feature. But more importantly, in contrast to such a simple game the dispatch has no output guarantee, some issues/questions/ideas might arise alongside the road. Which is "good" - if everything went on its own, that means you can be automated away. What you _should_ want is automating away the boring, tedious parts of your work. If you manage to automate yourself away, that's also _good_ in some way, it means you're available for something new, hopefully more challenging yet also rewarding. Don't be someone who tries to hide that their tasks are inefficient - if you don't optimize it yourself, someone else will, and that in turn _will_ question your value. TODO: since we mention dispatch, some spatial orientation might be useful for quicker assessment, and I'm not only talking about tabular sorting by priority etc., but also in the projection-of-embedding/meaning sense.

Hm, so a neat tool for writing this very document would now provide the neat animations or illustrations a good essay (or whatever this actually is). Imagine an idle-clicker like interface where you just clicked the "create neat illustration" task, with either some AI token budget or a human's time/salary required. Maybe the item actually has some options, like which AI model and token budget you want to allot, or which expertise level of human work you request. And in a pilot phase you may want to try multiple configurations to compare the results vs costs.

So you've dispatched a task, neat. Again unlike a game, you don't have an accurate progress bar. Maybe your colleague told you they'll have it done in twenty minutes (or [6-8 weeks](https://meta.stackexchange.com/a/19514/146482) if your task isn't that well-structured), which is hopefully less jumpy than the [Windows installation progress bar](https://store.steampowered.com/app/1304550/Progressbar95/) (suit yourself, I use Linux anyway). And if you've ever watched an AI agent code, you know that sometimes you really want to intervene, or wish you'd made a better prompt etc. But anyway, let's say the task is "done" - whatever that means, we haven't discussed workflows like TDD, reviews, pull-requests etc. yet.

### Semantics & Inflownistration

Maybe it's time for a detour to semantics. Weird for me as a Physicist to be interested in something that seems to defy the mathematical beauty of formulas, and yet here we are. But for Inflownistration we need to be able to determine how similar two connected "things" are at the very least semantically if not mathematically.

Let's say you're developing a game. Does your AI agent **test a game, or game a test?** (TAGOGAT) Same words, different order, _very_ different meaning. So when you originally had the task state "test the game", yet the transcript of the agent shows "game the test" Inflownistration should clearly surface the violation. Modern embeddings fortunately associate those two statements with very different vectors in the abstract space of "meaning". But both of them are instructions, or in the [jargon of semantics](https://en.wikipedia.org/wiki/Sentence_(linguistics)#By_function_or_speech_act), _imperative sentences_. The other three kinds of function listed are _interrogative_ (a question, though one might say there is some overlap/ambiguity to an imperative like "tell me...", or rather, a non-rhetorical question is automatically an imperative request for a reply), _declarative_ (statements) and _exclamative_ - though that seems again a blend of the others. (TODO: read https://linguisticsgirl.com/sentence-purpose-declarative-interrogative-imperative-exclamatory/). Another rabbithole for sure...

Inflownistration means administrating/managing/tracking/supervising/... the flow of information (side-note maybe Inflownedgement then?). If you wrote `city_speed_limit = 50 km/h` ([and _please_ use physical units!](https://en.wikipedia.org/wiki/Mars_Climate_Orbiter#Cause_of_failure)) in your self-driving car's code, that should not be a number you just made up but rather have a reference for it, like the local laws or a design document (whether that linkage is directly in the code or a sidecar file or a database is an open design question). Can we put this in more physical terms? Maybe _meaning_ is a quantity that should be conserved? Numbers are relatively easy if their context (like SI units) is accounted for. But even verifying a piece of code links to a rather simple requirement such as "the function `fib(n)` shall yield the `n`-th Fibonacci number" (or its unit test or Lean4 proof properly encode that meaning) is not exactly trivial. TODO: _make_ it trivial

To make matters worse, there is no single obvious implementation. The Fibonacci example is typical educational material to show it can be implemented recursively, use memoization, or simply an analytical formula. The results are identical, but the time and memory requirements vary significantly for higher input numbers. In other words, any implementation of a requirement must be part of its solution space, and if there are multiple requirements, an implementation must fulfill them _all_ i.e.

$$\textrm{implementation}\in \bigcap \textrm{solutions}(\textrm{requirement})$$

where $\bigcap$ denotes intersection. That formulation also has the nice effect of showing that non-intersecting solutions cannot be implemented. The "fulfills" ("is a member ($\in$) of the solution space $\textrm{solutions}$ of the $\textrm{requirement}$") needs an actual implementation itself - don't I love it when things get meta? (spoiler: yes I do) In the Fibonacci example that would ideally be a Lean4 proof or at least a sufficiently good unit test. And proving _that_ corresponds to fulfilling the requirement is again part of Inflownistration - linking the requirement semantics to a more mathematical or programmatic formulation.

We're touching the v-Model here: Top level requirements (be that from the business case, the user requirements specification (URS) or deeper down) are usually vague enough for the next layer to have some wiggle room for the details - but barring hopefully avoidable exceptions like contradictions, those "filled gaps" should never violate the original requirements. In theory. And it does probably make sense - the project initiator most likely won't even _know_ the project needs Fibonacci numbers let alone have the competence to decide that a recursive approach may not be ideal. And similarly it shouldn't be too big a surprise that multiple AI agents (even the same model) can implement your task in different ways that may be more or less adequate.

However, more often than not we're in the middle of a more or less cyclic process or iteration. Not necessarily Scrum or agile, but just think of the scientific principle: an observation is explained by one or more **falsifiable** theories with potentially different predictions about future observations. Then new observations discard some theories, encourage others but maybe yield more open questions, requiring tuning or reworking the theories and so on. Again we can write this more formally:

$$\begin{align*}
  \textrm{theory} & \in \bigcap\textrm{explanations}(\textrm{observation}),
  \\\textrm{observation} &\in \bigcap\textrm{confirmations}(\textrm{theory}),
\end{align*}$$

with the restriction to actually true observations and actually confirmed theories. TODO: formulate better, dive deeper

---

What else did I want to write about here but am distracted from by my Claude Code quota being refreshed?

- DAG/CRDT for the issue tracking
- (un)biased embeddings
- tokenization and embedding/transformer meaning propagation visualized
- a "dispatch AI agents" idle-clicker like mockup (cf. proj ideas ca75)