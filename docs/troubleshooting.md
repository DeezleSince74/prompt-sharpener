# Troubleshooting and FAQ

## Troubleshooting

Start with `/prompt-sharpener:help` (or ask for "Prompt Sharpener help" in Cowork or
Claude chat). Its setup check covers the most common causes below.

### I installed it, but replies don't start with a rewrite

- On a message that already looks complete, Claude may skip it. Start with "Sharpen
  this first:" to be sure, or add the one line in
  [Using it](using-it.md#every-message) to have it run on every message.
- Start a new session. Running sessions keep the plugins they started with.
- Run `/plugin` and check that Prompt Sharpener is enabled.
- Check that you didn't ask Claude to stop the rewrite earlier in this conversation.

### I asked for a better prompt, and Claude ran it instead

Say it plainly, like "Improve this prompt, don't run it: …". The words "improve this
prompt" or "just rewrite it" tell Claude to hand the prompt back and stop.

### Facts are marked unverified a lot

Your session probably has no web search or fetch tool. Turn one on, and Claude can check
facts instead of flagging them.

### The rewrite feels like too much for quick questions

For a short request, the rewrite is a single "Taking this as: …" line. If you'd rather
not see it at all for a while, ask Claude to stop showing it for this conversation.

### Another plugin also asks for a rewrite

Use one prompt-rewriting plugin at a time. Two will both ask for a rewrite block, and
you'll see two.

## FAQ

**Does it slow Claude down?**
Barely. Loading the skill takes a moment the first time in a conversation. The
rewrite adds a few lines to the start of each reply. Fact-checks take time only when a
reply depends on an outside fact.

**Does it change what Claude does, or only how the reply starts?**
Both, a little. Claude works from the rewritten prompt instead of your original words,
so the result matches the rewrite you can see.

**Can I use it with my own `CLAUDE.md` rules?**
Yes. The plugin never overrides what you or your organization tell Claude.

**Does it work in the desktop app, Cowork and editor extensions?**
Yes. It's a skill, so it works anywhere Claude runs plugin skills: Claude Code (the
terminal, the desktop app's Code tab and the editor extensions), Cowork, and Claude chat.

**Where do I report a bug?**
Open an issue at
[github.com/DeezleSince74/prompt-sharpener/issues](https://github.com/DeezleSince74/prompt-sharpener/issues).
For a security problem, use the **Security** tab instead.
