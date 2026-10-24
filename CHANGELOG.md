# Changelog

## 1.0.2 — unreleased

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
