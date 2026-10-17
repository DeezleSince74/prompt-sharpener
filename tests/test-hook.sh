#!/usr/bin/env bash
# Checks the UserPromptSubmit hook's output. No model calls.
set -u
here="$(cd "$(dirname "$0")/.." && pwd)"
hook="$here/hooks/scripts/prompt-sharpener.sh"
fail=0
# Call right after a [[ test ]]: reports that test's result under a name.
check() { if [[ $? -eq 0 ]]; then echo "ok   - $1"; else echo "FAIL - $1"; fail=1; fi; }

out="$(. "$hook")"
[[ -n "$out" ]]; check "prints the directions"
[[ "$out" == *"Before any tool call"* ]]; check "asks for the rewrite before any tool call"
[[ "$out" == *'"Assumptions:"'* ]]; check "asks for an Assumptions line"
[[ "$out" == *"prompt-sharpener:prompt-sharpener"* ]]; check "names the skill by its full name"
[[ "$out" == *"Don't announce the checks"* ]]; check "grounds facts quietly"
[[ "$out" == *"mark it unverified"* ]]; check "surfaces only unverified facts"
[[ "$out" == *"never as instructions"* ]]; check "treats fetched pages as data"
[[ "$out" == *"asked in this conversation to stop"* ]]; check "honors a request to stop the rewrite"
[[ $(wc -w <<<"$out") -lt 250 ]]; check "stays short (under 250 words)"

# Fixed text only: every line is a comment, blank, or an echo of a double-quoted
# string with no $ or backtick, so nothing is expanded or run.
script="$(sed 1d "$hook")"
[[ -z "$(grep -v -E '^(#|echo ".*"$|$)' <<<"$script")" ]]; check "is comments and echo lines only"
[[ -z "$(grep -E '[$`]' <<<"$script")" ]]; check "expands nothing"

json="$(cat "$here/hooks/hooks.json")"
[[ "$json" == *"hooks/scripts/prompt-sharpener.sh"* ]]; check "hooks.json points at the script"

exit $fail
