#!/usr/bin/env bash
# Example PreToolUse hook script.
# Reads JSON from stdin, denies destructive shell patterns via permissionDecision.
# Exit code 0 = parse stdout JSON; 2 = blocking error; other = non-blocking warning.

set -euo pipefail

input="$(cat)"

# Extract tool_input.command if present (best-effort, no jq dep).
cmd="$(printf '%s' "$input" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"

deny() {
  cat <<JSON
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Blocked by check-dangerous.sh: $1"
  }
}
JSON
  exit 0
}

case "$cmd" in
  *"rm -rf /"*|*"rm -rf ~"*|*"mkfs"*|*"dd if=/dev/"*|*":(){ :|:& };:"*|*"DROP TABLE"*|*"DROP DATABASE"*)
    deny "destructive pattern detected"
    ;;
esac

# Allow by default — return empty JSON.
echo '{}'
