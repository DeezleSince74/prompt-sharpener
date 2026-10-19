# Prompt Sharpener

A Claude Code plugin that does two things on every message you send.

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
- **Turn it off everywhere:** disable Prompt Sharpener with `/plugin`. Turn it back on
  the same way.

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
| `hooks/hooks.json` | Runs one script each time you submit a message (a `UserPromptSubmit` hook). |
| `hooks/scripts/prompt-sharpener.sh` | Prints the two short directions above. It reads no input, files or network. |
| `skills/prompt-sharpener/SKILL.md` | The full method: how to find what you really want, when to ask instead of guess, rewrite techniques, and how to ground facts quietly. |
| `skills/prompt-sharpener/references/` | Longer guides: general prompting techniques, coding prompts, and the grounding checklist with the verify-mode report. |
| `tests/test-hook.sh` | Checks the hook's output, with no model calls. |

The hook is a short `bash` script. On Windows, Claude Code runs hooks through Git Bash, so
the hook needs Git for Windows installed. Without it, the skill still works when you ask
for it, but the automatic rewrite on every message won't run.

Fact-checking uses whatever search or fetch tools your session has. With none, Claude
still answers but marks the facts it couldn't check as unverified.

## Privacy

The plugin collects nothing and sends nothing anywhere. See [PRIVACY.md](PRIVACY.md).

## License

MIT. See [LICENSE](LICENSE).
