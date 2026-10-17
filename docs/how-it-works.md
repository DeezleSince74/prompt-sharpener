# How it works

The plugin is small: one hook, one skill, and three reference guides.

![Flow, top to bottom: you send a message, the hook adds two short directions, Claude rewrites your request, shows the rewrite and Assumptions line, does the task, checks outside facts, marks any it couldn't confirm, and finishes the reply](images/flow.png)
*Real render from Deezle Infra Diagrams. Read it top to bottom.*

## The parts

| Part | File | What it does |
| --- | --- | --- |
| The hook | `hooks/hooks.json`, `hooks/scripts/prompt-sharpener.sh` | A hook is a small script Claude Code runs at a set moment. This one runs each time you send a message (a `UserPromptSubmit` hook). It adds two short directions to what Claude sees: rewrite first, and ground facts quietly. |
| The skill | `skills/prompt-sharpener/SKILL.md` | A skill is a set of instructions Claude loads when it needs them. This one holds the full method: finding what you really want, when to ask instead of guess, rewrite techniques, and how to ground facts. |
| References | `skills/prompt-sharpener/references/` | Longer guides the skill reads when needed: `techniques.md` (prompting techniques), `coding-prompts.md` (coding prompts), and `grounding.md` (the fact-checking checklist and the verify report format). |
| The test | `tests/test-hook.sh` | Checks the hook with no model calls. See below. |

## The hook's exact words

Nothing is hidden. This is everything the hook adds to each message:

![Terminal running the hook script and printing its two directions](images/hook.png)
*Real output, captured by running the script.*

The source is [`hooks/scripts/prompt-sharpener.sh`](../hooks/scripts/prompt-sharpener.sh).
It is only comments and `echo` lines. It reads no input, files or network.

## The test

Run it from the repository folder:

```bash
bash tests/test-hook.sh
```

It works in two steps:

1. **Before running anything**, it checks every line of the hook script. Each line must
   be the opening `#!/usr/bin/env bash` line, a comment, a blank line, or `echo` with one
   fixed, double-quoted string. A `$` or a backtick inside the string fails the check,
   so nothing can expand or run. If any line fails, the test stops and never runs the
   hook.
2. **Then it runs the hook** and checks the output: the rewrite comes before any tool
   call, there's an Assumptions line, the skill is named in full, the checks stay quiet,
   fetched pages are treated as data, a request to stop is honored, and the whole thing
   stays under 250 words.

The check is "fail closed": if the check itself breaks, it counts as a failure, not a
pass.

Next: [Control and privacy](control-and-privacy.md)
