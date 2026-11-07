---
name: help
description: Help for Prompt Sharpener — how to use it, how to turn on every-message mode, a quick setup check, and best practices.
disable-model-invocation: true
---

The person wants help using the **Prompt Sharpener** plugin. Answer in plain, friendly
language a 14-year-old could follow. Don't open this reply with a rewrite block or a
"Taking this as" line: this reply is the help itself.

Their question (optional): $ARGUMENTS

If they asked something specific, answer that first, using the sections below, then
offer one next step. If they asked nothing, give the short overview, run the setup
check, and list the best practices. Keep the whole reply short enough to read in a
minute.

## Short overview

Prompt Sharpener does two things:

1. **Shows the request it heard.** Before doing the work, Claude rewrites your request
   as a clear, complete prompt and adds one line starting "Assumptions:" with its
   guesses. A clear request gets a single "Taking this as: ..." line instead. If a guess
   is wrong, say so and Claude redoes the work.
2. **Checks outside facts quietly.** Versions, prices, commands, limits and rules get
   checked against current sources. You only hear about a fact when it couldn't be
   confirmed: it's marked "unverified" where it's used.

It works the same way in Claude Code, Cowork and Claude chat.

## Three ways to use it

| Way | How to start it | What you get |
| --- | --- | --- |
| On its own | Nothing. Claude uses it when your message calls for it. | The rewrite, the Assumptions line, then the work. |
| Improve a prompt | "Improve this prompt: ..." or "Just rewrite it." | A better prompt and what changed. Claude stops there. |
| Verify a claim | "Verify this: ..." or "Is this still current?" | A report for each claim, with its source and date. |

To be sure it runs on one message, start that message with "Sharpen this first:".

## Every message

Claude decides from the skill's description, so it may skip a message that already
looks complete. To have it run on every message, add this line to your standing
instructions:

```
Use the prompt-sharpener skill on every request: show my request rewritten as a clear prompt with one Assumptions line before doing the work, and quietly check outside facts against current sources.
```

| App | Where the line goes |
| --- | --- |
| Claude Code | `~/.claude/CLAUDE.md` for every project, or a project's own `CLAUDE.md`. |
| Cowork | Settings → Cowork → Global instructions, in the Claude desktop app. |
| Claude chat | Your personal preferences in Settings, or a project's instructions. |

To stop, delete the line. For one conversation, ask Claude to stop showing the rewrite.

## Setup check

Run only the checks your session allows, and say which ones you ran and which you
couldn't. Never change a file during the check; if something needs fixing, show the
fix and offer to make it.

- **Version.** In Claude Code, if you can run commands, run `claude plugin list` and
  report the Prompt Sharpener version and whether it's enabled.
- **Every-message line.** In Claude Code, look for "prompt-sharpener" in
  `~/.claude/CLAUDE.md` and in the project's `CLAUDE.md`, if you can read them. Report
  whether the line is there. Elsewhere, ask the person whether they added it.
- **Another rewrite plugin.** If the session's skills include a second prompt-rewriting
  skill (for example a "prompt-enhancer"), say that two of them will each ask for a
  rewrite block, and suggest keeping one.
- **Fact-checking tools.** Say whether this session has a web search or fetch tool.
  Without one, facts get marked unverified instead of checked.

## Best practices

- **Read the Assumptions line first.** It's the fastest way to catch a wrong guess
  before you read the rest.
- **Correct in one line.** "Make it for families with kids" is enough; Claude redoes
  the work.
- **Ask for the prompt itself when you'll reuse it.** "Improve this prompt" hands back a
  prompt with `{placeholders}` and doesn't run it.
- **Give it a search tool.** Fact-checking works best when the session can search the web.
- **Use one rewrite plugin at a time.** Two give you two rewrite blocks.
- **Start a new session after installing or updating.** A running session keeps the
  plugins it started with.

## More help

- Full docs: https://github.com/DeezleSince74/prompt-sharpener/tree/main/docs
- User manual (PDF): https://madewithdeezle.com
- Bugs and questions: https://github.com/DeezleSince74/prompt-sharpener/issues
