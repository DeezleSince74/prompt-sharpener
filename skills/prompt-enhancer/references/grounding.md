# Grounding: checklist and verify-mode report

Anything that lives outside the conversation can be wrong or out of date. This file
is the long form of the **Behind-the-scenes grounding** section in `SKILL.md`.

## Hard rules

- **Never guess a version number or a command.** If unsure, look it up.
- **Prefer the official source.** Vendor docs, release notes, the package registry,
  the regulator's own site. Not blog posts, not memory.
- **Confirm it's current.** Check the page's date and which version it covers.
- **Name your uncertainty.** If a fact can't be confirmed, say so plainly, at the
  point where the fact is used.
- **When sources disagree,** go with the newest official one and mention the conflict.

## Checklist

For each fact the answer depends on:

1. **Name the claim.** Write the exact statement to check, to yourself.
2. **Find the source.** Use web search or fetch to reach the official page. For local
   tools, run `--version` or `--help` where you can.
3. **Check date and version.** Make sure the source is current and applies to the
   version in play. Note today's date.
4. **Decide what the reader sees.** Confirmed: state the fact plainly; add a link only
   if it helps them act. Not confirmed: mark it unverified and say how to check.
5. **Flag what's shaky.** Call out anything ambiguous, regional, or likely to change
   soon (prices and limits especially).

## If you can't look it up

Some surfaces have no web search. When a fact can't be checked, still answer, but
label it ("unverified: I couldn't check this") and say how the person can check it:
the vendor's docs page, their account dashboard, or running the command locally.

## Verify mode: the visible report

Only when the person asks to verify something. For each claim:

- **Claim:** the statement.
- **Verified:** yes / no / partly.
- **Finding:** what the source actually says, with the specific version, price, or
  limit.
- **Source:** name, link, and the date checked.
- **Caveats:** uncertainty, regional differences, or "confirm before relying on it."

Keep each claim to a few lines. If there are more than five claims, a table with the
same five columns reads faster.
