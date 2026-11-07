# Prompt Sharpener

A plugin for Claude Code, Cowork and Claude chat that does two things to your requests.
Claude uses it on its own for most requests, and one line in your instructions makes it run
on every message (see [Where it runs](#where-it-runs)).

1. **It rewrites your request into a clear prompt, and shows you that first.** Before
   Claude starts any work, the reply opens with your request rewritten as a complete
   prompt, followed by one line starting "Assumptions:". That line lists what Claude
   guessed, such as the audience, format or scope. If a guess is wrong, you can see it right
   away and correct it, instead of finding out at the end. Then Claude does the
   rewritten task in the same reply.
2. **It checks outside facts quietly.** Before Claude states a fact that lives outside
   your conversation, such as a version number, a price, a command, a limit, an
   application programming interface (API) shape or a rule, it checks it against a current,
   official source. You don't see the checks. You only hear about a fact when it
   couldn't be confirmed: Claude marks it "unverified" where it's used and tells you
   how to check it yourself.

Full guides with pictures are in [docs/](docs/README.md): getting started, the three ways
to use it, how it works, control and privacy, and troubleshooting.

## Example

You type:

```
write a blog post about dogs
```

The reply starts with:

```
Write an engaging, beginner-friendly blog post (700–900 words) for first-time
dog owners: choosing a breed that fits your life, what the first month involves,
and the ongoing time and cost. Warm, practical tone; 3–4 sections with subheadings.
```
Assumptions: first-time owners as the audience, a practical how-to angle, about 800 words.

Then the finished post follows.

## Example prompts

- `plan a 3-day trip to Lisbon` — the reply opens with a fuller prompt (budget, pace,
  interests guessed and listed under Assumptions), then the plan.
- `Improve this prompt: summarize this article` — you get a better prompt and what
  changed, and Claude stops there.
- `Verify this: Python 3.8 still gets security fixes` — you get a claim-by-claim report
  with the source and the date checked.

## Other ways to use it

- **Improve a prompt without running it:** "Improve this prompt: …" or "Just rewrite
  it." You get the better prompt and a short list of what changed and why, and Claude
  stops there.
- **Fact-check something on purpose:** "Verify this: …" or "Is this still current?"
  You get a short report for each claim: verified or not, what the source says, the
  link, and the date checked.
- **Turn the rewrite off for one conversation:** ask Claude to stop showing the
  rewrite. Fact-checking keeps running.
- **Get help:** type `/prompt-sharpener:help` in Claude Code, or ask for "Prompt
  Sharpener help" in Cowork or Claude chat. You get tips, the every-message setup, a
  quick check of your setup, and best practices.
- **Turn it off everywhere:** disable Prompt Sharpener with `/plugin`. Turn it back on
  the same way.

## Where it runs

It works the same way in Claude Code (terminal, IDE, desktop Code tab), Cowork, and Claude
chat (web, desktop, mobile). Claude uses it on its own for most requests, and keeps using
it for the rest of a conversation once it starts. On a message that already looks
complete, Claude may skip it. To be sure for one message, start with "Sharpen this first:".

**To run it on every message**, add this line to your standing instructions:

```
Use the prompt-sharpener skill on every request: show my request rewritten as a clear prompt with one Assumptions line before doing the work, and quietly check outside facts against current sources.
```

| App | Where the line goes |
| --- | --- |
| Claude Code | `~/.claude/CLAUDE.md` (every project) or a project's own `CLAUDE.md` |
| Cowork | Settings → Cowork → Global instructions, in the Claude desktop app |
| Claude chat | Your personal preferences in Settings, or a project's instructions |

## Installing

From the Claude plugin Directory: Prompt Sharpener is listed for Claude Code, Cowork and the Claude apps. Open the plugin browser, search for **Prompt Sharpener**, and install it.

Or add this repository as a marketplace in Claude Code:

```
/plugin marketplace add DeezleSince74/prompt-sharpener
/plugin install prompt-sharpener@prompt-sharpener
```

Start a new session after installing, since a running session keeps the plugins it
started with.

## How it works

| Part | What it does |
| --- | --- |
| `skills/prompt-sharpener/SKILL.md` | The full method: when to rewrite (an ordered list of cases), how to find what you really want, when to ask instead of guess, rewrite techniques, and how to ground facts quietly. |
| `skills/prompt-sharpener/references/` | Longer guides: general prompting techniques, coding prompts, and the grounding checklist with the verify-mode report. |
| `skills/help/SKILL.md` | Help for using the plugin: the three ways to use it, how to turn on every-message mode, a quick setup check, and best practices. It runs only when you ask for it. |

The plugin is only text. It has no hooks, scripts or server, so it runs the same on
macOS, Linux and Windows with nothing to install.

Fact-checking uses whatever search or fetch tools your session has. With none, Claude
still answers but marks the facts it couldn't check as unverified.

## Privacy

The plugin collects nothing and sends nothing anywhere. See [PRIVACY.md](PRIVACY.md).

## License

MIT. See [LICENSE](LICENSE).
