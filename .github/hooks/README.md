# Hooks

This directory holds [agent hook](https://code.visualstudio.com/docs/copilot/customization/hooks)
configurations (`*.json`) that VS Code loads automatically.

Hooks execute shell commands at lifecycle points during agent sessions
(`SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `PreCompact`,
`SubagentStart`, `SubagentStop`, `Stop`) and can block, allow, or augment
agent actions.

## Files

- [`example-block-dangerous.json.example`](./example-block-dangerous.json.example) —
  inert `PreToolUse` hook sample that warns on dangerous shell patterns. Copy it
  to `.github/hooks/<name>.json` before use.

## Scaffolding new hooks

Use the bundled prompt template:

```text
/copilot-new-hook
```

Or follow the [hooks spec](https://code.visualstudio.com/docs/copilot/customization/hooks).

## Notes

- Hook scripts must be executable (`chmod +x script.sh`).
- Default timeout is 30 seconds; override via the `timeout` field.
- Workspace hooks (`.github/hooks/*.json`) are shared with the team via Git.
- Agent-scoped hooks (in `.agent.md` frontmatter) require
  `chat.useCustomAgentHooks` to be enabled.
- VS Code also reads `.claude/settings.json`, `.claude/settings.local.json`,
  and `~/.claude/settings.json` by default. Use the `chat.hookFilesLocations`
  setting to customize loading.
