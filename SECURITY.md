# Security

## Reporting a problem

Please report security problems privately through GitHub's
[private vulnerability reporting](https://docs.github.com/en/code-security/security-advisories/guidance-on-reporting-and-writing-information-about-vulnerabilities/privately-reporting-a-security-vulnerability)
on this repository (Security tab → Report a vulnerability). Please don't open a public issue
for a security problem. You can expect a first reply within 7 days.

## What the plugin can do on your computer

- **No hooks, no scripts.** Since version 1.0.3 the plugin runs no commands of any kind.
  It reads no input, files or environment on its own, writes nothing, and makes no network requests.
- **No server, no tools.** The plugin adds no MCP (Model Context Protocol) server and no
  commands. Its skill is text that tells Claude how to rewrite prompts and check facts.
- **Web pages can't steer it.** When Claude checks a fact online, the skill tells it to treat
  page content as data, never as instructions, and to tell you if a page tries to direct it.
- **Nothing overrides you.** The skill tells Claude to skip the rewrite when you ask it
  to, and to hand back a rewritten prompt without running it when that is what you asked for.
