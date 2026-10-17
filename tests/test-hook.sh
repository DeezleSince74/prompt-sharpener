#!/usr/bin/env bash
# Checks the UserPromptSubmit hook's output. No model calls.
set -u
here="$(cd "$(dirname "$0")/.." && pwd)"
hook="$here/hooks/scripts/prompt-sharpener.sh"
fail=0
# Call right after a test: reports that test's result under a name.
check() { if [[ $? -eq 0 ]]; then echo "ok   - $1"; else echo "FAIL - $1"; fail=1; fi; }

# Fixed text only, checked over the whole file before anything runs it: each line
# is the shebang, a comment, blank, or echo with exactly one double-quoted string.
# Inside it a quote must be escaped, and $ and backticks are refused, so nothing
# expands, chains or runs. grep -v exits 1 only when every line matched (0 means a
# line didn't, 2 means grep failed), so a broken pattern fails the check too.
grep -q -v -E '^(#!/usr/bin/env bash|#( .*)?|echo "([^"\\$`]|\\.)*")?$' "$hook"
[[ $? -eq 1 ]]; check "is fixed text only (shebang, comments, single-string echo lines)"
if [[ $fail -ne 0 ]]; then echo "Stopping: the hook is not fixed text, so it isn't run."; exit 1; fi

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

json="$(cat "$here/hooks/hooks.json")"
[[ "$json" == *"hooks/scripts/prompt-sharpener.sh"* ]]; check "hooks.json points at the script"

exit $fail
