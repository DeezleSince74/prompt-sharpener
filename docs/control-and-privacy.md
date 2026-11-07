# Control and privacy

The plugin asks Claude to do two things. It never overrides what you or your
organization tell Claude.

## Turning things on and off

| You want to | Do this |
| --- | --- |
| Skip the rewrite for now | Ask Claude to stop showing the rewrite. It stops for the rest of that conversation. Fact-checking keeps going. |
| Run it on every message | Add the one line in [Using it](using-it.md#every-message) to your standing instructions. Delete it to stop. |
| Turn it all off | Run `/plugin`, find Prompt Sharpener, and disable it. Start a new session. |
| Turn it back on | Enable it the same way, then start a new session. |
| Remove it | Uninstall it from `/plugin`. |

## What it reads and writes

The plugin is only text: one skill and its reference guides. It runs no commands, reads
nothing on its own, and writes nothing.

Fact-checks use your session's own search and fetch tools, under the same permissions
as everything else Claude does for you. The plugin adds no tools of its own.

## Privacy

The plugin collects nothing and sends nothing anywhere. There's no server, no telemetry
(automatic usage reporting) and no account. The full policy is
[PRIVACY.md](../PRIVACY.md).

## Security

The plugin has no hook, no scripts and no server, so there's no code of its own to run
(see [How it works](how-it-works.md)). To report a
security problem privately, use this repository's **Security** tab on GitHub.
[SECURITY.md](../SECURITY.md) has the details.

## License

MIT. You can use, change and share it, including at work. See [LICENSE](../LICENSE).

Next: [Troubleshooting and FAQ](troubleshooting.md)
