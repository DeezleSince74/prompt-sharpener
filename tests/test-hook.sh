#!/usr/bin/env bash
# Checks the UserPromptSubmit hook's output. No model calls.
set -u
here="$(cd "$(dirname "$0")/.." && pwd)"
hook="$here/hooks/scripts/prompt-enhancer.sh"
fail=0
check() { if eval "$2"; then echo "ok   - $1"; else echo "FAIL - $1"; fail=1; fi; }

out="$(echo '{"prompt":"hi"}' | bash "$hook")"; code=$?
check "exits 0" '[[ $code -eq 0 ]]'
check "asks for the rewrite before any tool call" '[[ "$out" == *"Before any tool call"* ]]'
check "asks for an Assumptions line" '[[ "$out" == *"\"Assumptions:\""* ]]'
check "names the skill by its full name" '[[ "$out" == *"prompt-enhancer:prompt-enhancer"* ]]'
check "grounds facts quietly" '[[ "$out" == *"Don'"'"'t announce the checks"* ]]'
check "surfaces only unverified facts" '[[ "$out" == *"mark it unverified"* ]]'
check "honors a request to stop the rewrite" '[[ "$out" == *"asked in this conversation to stop"* ]]'
check "stays short (under 250 words)" '[[ $(wc -w <<<"$out") -lt 250 ]]'

off="$(PROMPT_ENHANCER_OFF=1 bash "$hook")"; code=$?
check "PROMPT_ENHANCER_OFF=1 prints nothing" '[[ $code -eq 0 && -z "$off" ]]'

json="$(cat "$here/hooks/hooks.json")"
check "hooks.json points at the script" '[[ "$json" == *"hooks/scripts/prompt-enhancer.sh"* ]]'

exit $fail
