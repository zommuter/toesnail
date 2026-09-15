# Getting Things not-so-done Part II

## 20260915

Has it really been almost ten years already?

Lots has happened since, and I'm not just talking about the Rise of LLMs... But yeah, I've tried my fair share of vibe-coding with more or less interesting results, let's see where they lead.

I'm still seeking the "perfekt [supertool](supertool.md)" of course, mixed with inflownistration which now thanks to LLMs should also support semantic similarity tracking and so on. But instead of describing features, let's try and visualize what I'd like to use to work - there might be some abstract concepts involved, even stuff like PLM/ALM, project management, linguistic atoms and the likes, so let's dive in straight.

### Starting to work

So you've awoken, did whatever your morning routine was and now you want to get to work. Since you're reading this, that most likely means switching on your PC or at least using a smartphone or similar. "Now what?". Yes, if you're following some productivity guides, most likely you've heard the "prepare something for you to get started with the next day" so you don't start from scratch. Ideally you've managed to wrap up something in the previous evening/night (or whatever your chronotype actually requires) and left a simple yet motivating task for the next day (or sprint, iteration, whatever), to be relaxed enough for a good night's sleep, while already having a task prepared.

### Abstraction: TODOs

So what is "a task prepared"? Hopefully you're using some issue tracker or other tool that works well for _you_. Unfortunately for me, picking "the" perfect tracker tool turns into a rabithole (and while I'm writing this I'm once again distracted by the question of setting up a spell-checker in vscode which I'm currently using, lacking the dreamed-of supertool). Ugh, getting side-tracked, eh? Yes, we could dive into issue terminology, epics, planning poker and the likes, but let's _not_.

Nowadays with AI agents (or maybe you're a meatworld teamlead anyway) you do not only have your own tasks, but those of your ~~minions~~ agents/subordinates. Coordination is imperative. Just have a look at my [dotclaude-skills](../../dotclaude-skills/README.md) repo and the mess its manual `TODO.md` files bloated to. Its works somehow, but it's clearly far from ideal and basically I'm reinventing yet another square-shaped wheel - or rather, enable Claude Code to do it for me, instead of adapting decades-established tools properly. That needs to change - hundreds of lines of code to turn markdown into a "database" of kind with the worst of all worlds, that's just not efficient at all.

But issue tracking is already behind the curtains, I want to dream about the UX - maybe a BDD approach.

### "The" UX

In contrast to an idle clicker game, the actual costs and results of letting your delegates work on a task can probably only be roughly estimated (though ideally those estimates improve over time). But maybe the analogy is not _that_ bad - you do have some budget, be that AI tokens (API calls or subscription quota) or the infamous "~~man~~ employee hours" that you have to invest into task that hopefully yield adequate returns. So indeed you do have some kind of **dispatch** feature. But more importantly, in contrast to such a simple game the dispatch has no output guarantee, some issues/questions/ideas might arise alongside the road. Which is "good" - if everything went on its own, that means you can be automated away. What you _should_ want is automating away the boring, tedious parts of your work. If you manage to automate yourself away, that's also _good_ in some way, it means you're available for something new, hopefully more challenging yet also rewarding. Don't be someone who tries to hide that their tasks are inefficient - if you don't optimize it yourself, someone else will, and that in turn _will_ question your value.

Hm, so a neat tool for writing this very document would now provide the neat animations or illustrations a good essay (or whatever this actually is). Imagine an idle-clicker like interface where you just clicked the "create neat illustration" task, with either some AI token budget or a human's time/salary required. Maybe the item actually has some options, like which AI model and token budget you want to alot, or which expertise level of human work you request. And in a pilot phase you may want to try multiple configurations to compare the results vs costs.

So you've dispatched a task, neat. Again unlike a game, you don't have an accurate progress bar. Maybe your colleague told you they'll have it done in twenty minutes (or [6-8 weeks](https://meta.stackexchange.com/a/19514/146482) if your task isn't that well-structured), which is hopefully less jumpy than the [Windows installation progress bar](https://store.steampowered.com/app/1304550/Progressbar95/) (suit yourself, I use Linux anyway). And if you've ever watched an AI agent code, you know that sometimes you really want to intervene, or wish you'd made a better prompt etc. But anyway, let's say the task is "done" (whatever that means, we haven't discussed workflows like TDD, reviews, pull-requests etc. yet).



---

(side-not for later on semantics: "TAGOGAT - test a game, or game a test?" as alternative to the "watch a play / play on a watch" example)