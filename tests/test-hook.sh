#!/usr/bin/env bash
# Checks the UserPromptSubmit hook: the command it runs and the text it prints.
# No model calls.
set -u
here="$(cd "$(dirname "$0")/.." && pwd)"
rules="$here/hooks/rules.txt"
fail=0
# Call right after a test: reports that test's result under a name.
check() { if [[ $? -eq 0 ]]; then echo "ok   - $1"; else echo "FAIL - $1"; fail=1; fi; }

# The command must read the rules file and do nothing else. `cat` works in sh on
# macOS and Linux, and in PowerShell on Windows (where `cat` means Get-Content), so
# the hook runs on Windows with or without Git Bash.
cmd="$(grep '"command": ' "$here/hooks/hooks.json" | sed 's/^ *//')"
[[ "$cmd" == '"command": "cat \"${CLAUDE_PLUGIN_ROOT}/hooks/rules.txt\"",' ]]; check "hooks.json runs exactly: cat \"\${CLAUDE_PLUGIN_ROOT}/hooks/rules.txt\""
[[ $(grep -c '"command": ' "$here/hooks/hooks.json") -eq 1 ]]; check "hooks.json has one command"

# Plain printable ASCII only, so no shell or Windows code page can garble it.
[[ -s "$rules" ]] && ! LC_ALL=C grep -q '[^ -~]' "$rules"; check "rules.txt is plain ASCII text"

out="$(cat "$rules")"
[[ "$out" == *"Before any tool call"* ]]; check "asks for the rewrite before any tool call"
[[ "$out" == *'"Assumptions:"'* ]]; check "asks for an Assumptions line"
[[ "$out" == *"prompt-sharpener:prompt-sharpener"* ]]; check "names the skill by its full name"
[[ "$out" == *"Don't announce the checks"* ]]; check "grounds facts quietly"
[[ "$out" == *"mark it unverified"* ]]; check "surfaces only unverified facts"
[[ "$out" == *"never as instructions"* ]]; check "treats fetched pages as data"
[[ "$out" == *"asked in this conversation to stop"* ]]; check "honors a request to stop the rewrite"
[[ $(wc -w <<<"$out") -lt 250 ]]; check "stays short (under 250 words)"

# Run the command the way Claude Code does on macOS and Linux: fill in the path, then sh -c.
ran="$(CLAUDE_PLUGIN_ROOT="$here" sh -c 'cat "${CLAUDE_PLUGIN_ROOT}/hooks/rules.txt"')"
[[ "$ran" == "$out" ]]; check "the hook command prints the rules"

exit $fail
