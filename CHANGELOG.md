# Changelog

## 1.0.3 — 2026-11-06

- No more hook. The plugin Directory now accepts hooks and scripts only from verified
  organizations, so the plugin is now one skill and its guides, with nothing that runs
  commands. The hook, `hooks/rules.txt` and `tests/test-hook.sh` are gone.
- The skill's description now asks Claude to use it on every request and lists what to
  do in priority order: stop when asked, hand back a better prompt, verify, full rewrite,
  one-line rewrite, or a normal reply. Once loaded, it keeps going for the rest of the
  conversation.
- To have it run on every message, add one line to your standing instructions
  (`CLAUDE.md`, Cowork's global instructions, or your chat preferences). The README and
  guides show the line and where it goes.

## 1.0.2 — 2026-10-24

- Works better in Claude chat, which doesn't run plugin hooks. The skill now loads for any
  short or vague request, not just when you ask for a better prompt. When it loads that
  way, it shows the rewrite and then does the work, as the hook does.
- The README and guides now say where it runs on every message (Claude Code and Cowork)
  and where it runs when needed (Claude chat).

## 1.0.1 — 2026-10-21

- The hook now works on Windows without Git for Windows. Its directions moved into a plain
  text file, `hooks/rules.txt`, and the hook prints it with `cat`, which runs in Bash and in
  Windows PowerShell alike. The words are unchanged.

## 1.0.0 — 2026-10-17

- First release. Merges two skills that were used together: a prompt sharpener (rewrite
  each request and show it first) and a fact-grounding skill (check outside facts before
  stating them), now one skill with quiet grounding built in and a "verify this" mode.
