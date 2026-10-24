# Prompt Sharpener documentation

Prompt Sharpener is a plugin for Claude Code, Cowork and Claude chat. In Claude Code and
Cowork it runs on every message you send. In Claude chat it runs when a request looks short
or vague, or when you ask (see [Using it](using-it.md#where-it-runs)). It does two things:

1. It shows you your request rewritten as a clear, full prompt, plus one line of
   assumptions, before Claude starts work.
2. It has Claude check outside facts (versions, prices, commands, limits) against
   official sources, and tells you only about the ones it couldn't confirm.

![An example reply: the request, the rewritten prompt, the Assumptions line, then the work](images/reply.png)
*Example reply, re-drawn to show the format. The model writes different words each time.*

![The Claude desktop app: a one-line request, then Claude's rewritten prompt and an Assumptions line](images/desktop.png)
*Real screenshot from the Claude desktop app's Code tab, October 17, 2026.*

## Guides

| Guide | Read it to |
| --- | --- |
| [Getting started](getting-started.md) | Install the plugin and send your first message. |
| [Using it](using-it.md) | Learn the three ways to use it: every message, improving a prompt, and verifying a claim. |
| [How it works](how-it-works.md) | See the hook, the skill, and the exact words the plugin adds. |
| [Control and privacy](control-and-privacy.md) | Turn the rewrite off, disable the plugin, and see what it reads and sends. |
| [Troubleshooting and FAQ](troubleshooting.md) | Fix common problems and get quick answers. |

A printable [user manual](https://madewithdeezle.com/downloads/prompt-sharpener-manual.pdf)
(a 15-page PDF with the same content and pictures) is on madewithdeezle.com.

## About the pictures

Every caption says what its picture is. **Real** means it was captured from the plugin
or its install. **Example** means a reply re-drawn to show the format: the layout is
accurate, but Claude writes different words each time.
