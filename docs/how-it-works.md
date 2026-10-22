# How it works

The plugin is small: one hook, one skill, and three reference guides.

![Flow, top to bottom: you send a message, the hook adds two short directions, Claude rewrites your request, shows the rewrite and Assumptions line, does the task, checks outside facts, marks any it couldn't confirm, and finishes the reply](images/flow.png)
*Real render from Deezle Infra Diagrams. Read it top to bottom.*

## The parts

| Part | File | What it does |
| --- | --- | --- |
| The hook | `hooks/hooks.json`, `hooks/rules.txt` | A hook is a command Claude Code runs at a set moment. This one runs each time you send a message (a `UserPromptSubmit` hook). It adds two short directions to what Claude sees: rewrite first, and ground facts quietly. |
| The skill | `skills/prompt-sharpener/SKILL.md` | A skill is a set of instructions Claude loads when it needs them. This one holds the full method: finding what you really want, when to ask instead of guess, rewrite techniques, and how to ground facts. |
| References | `skills/prompt-sharpener/references/` | Longer guides the skill reads when needed: `techniques.md` (prompting techniques), `coding-prompts.md` (coding prompts), and `grounding.md` (the fact-checking checklist and the verify report format). |
| The test | `tests/test-hook.sh` | Checks the hook with no model calls. See below. |

## The hook's exact words

Nothing is hidden. This is everything the hook adds to each message:

![Terminal running cat hooks/rules.txt and printing the two directions](images/hook.png)
*Real output, captured by running the hook's command.*

The text is [`hooks/rules.txt`](../hooks/rules.txt), and the hook's whole command is
`cat "${CLAUDE_PLUGIN_ROOT}/hooks/rules.txt"`. It prints that file and nothing else, and
reads no input, other files or network. `cat` works in Bash on macOS and Linux and in
PowerShell on Windows, so the hook needs nothing extra installed on any of them.

## The test

Run it from the repository folder:

```bash
bash tests/test-hook.sh
```

It checks four things:

1. **The command.** `hooks/hooks.json` must hold exactly one command, and it must be
   `cat` on the rules file. Nothing else can run.
2. **The text is plain.** `hooks/rules.txt` must be plain ASCII (basic letters, numbers
   and punctuation), so no shell or Windows setting can garble it.
3. **The words.** The rewrite comes before any tool call, there's an Assumptions line,
   the skill is named in full, the checks stay quiet, fetched pages are treated as data,
   a request to stop is honored, and the whole thing stays under 250 words.
4. **It runs.** The test runs the command the way Claude Code does on macOS and Linux
   and checks that it prints the rules.

Next: [Control and privacy](control-and-privacy.md)
