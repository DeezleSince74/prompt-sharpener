# How it works

The plugin is small: one skill and three reference guides. It has no hook, no scripts and
no server. Everything in it is text that Claude reads.

## The parts

| Part | File | What it does |
| --- | --- | --- |
| The skill | `skills/prompt-sharpener/SKILL.md` | A skill is a set of instructions Claude loads when it needs them. This one holds the full method: when to rewrite, finding what you really want, when to ask instead of guess, rewrite techniques, and how to ground facts. |
| References | `skills/prompt-sharpener/references/` | Longer guides the skill reads when needed: `techniques.md` (prompting techniques), `coding-prompts.md` (coding prompts), and `grounding.md` (the fact-checking checklist and the verify report format). |

## How Claude decides to use it

Before each reply, Claude sees a short description of every skill you have installed.
It reads the full skill only when the description fits your message. Prompt Sharpener's
description asks to be used on every request, and lists what to do in order:

1. You asked to stop showing the rewrite: just do the work.
2. You asked for a better prompt: hand it back and stop.
3. You asked to verify something: a claim-by-claim report.
4. Your request is short or vague: the full rewrite and an Assumptions line, then the work.
5. Your request is clear: one "Taking this as: …" line, then the work.
6. Your message isn't a request, like "thanks": a normal reply.

Once the skill has loaded, it tells Claude to keep using it for the rest of the
conversation.

**Why it isn't guaranteed on every message.** Claude still makes the call. On a message
that already looks complete, it may skip the skill. If you want it every time, add the
one line in [Using it](using-it.md#every-message) to your standing instructions. That
line sits in front of Claude on every message, so the skill always runs.

## Why there's no hook

Versions 1.0.0 to 1.0.2 used a hook: a command Claude Code ran on every message to print
the two directions. The plugin Directory now accepts hooks only from verified
organizations, so version 1.0.3 moved those directions into the skill and the optional
standing-instruction line. What Claude is asked to do hasn't changed.

Next: [Control and privacy](control-and-privacy.md)
