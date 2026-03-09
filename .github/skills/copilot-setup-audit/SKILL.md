---
name: copilot-setup-audit
description: Audit repository Copilot customization setup. Use this skill to analyze existing configuration, identify missing files, check for best practices, and suggest improvements for agents, prompts, instructions, and skills.
---

# Copilot Setup Audit

This skill provides comprehensive checklists and best practices for auditing a repository's GitHub Copilot customization setup.

## When to use this skill

- Setting up Copilot customizations in a new repository
- Reviewing an existing setup for improvements
- Migrating from legacy patterns (chat modes → agents)
- Ensuring team-wide consistency
- Onboarding new team members to the Copilot setup

## Audit Checklist

### 1. Directory Structure

Check for correct directory structure:

```
.github/
├── agents/                    # Custom agents
│   └── *.agent.md
├── prompts/                   # Prompt templates
│   └── *.prompt.md
├── instructions/              # Scoped instructions
│   └── *.instructions.md
├── skills/                    # Agent skills
│   └── */SKILL.md
├── hooks/                     # Hook configurations
│   └── *.json
├── copilot-instructions.md    # Workspace-wide instructions
└── (optional) AGENTS.md       # Alternative: root-level agent instructions
.vscode/
└── settings.json              # Workspace settings
```

#### Directory Checks

| Check | Status | Notes |
|-------|--------|-------|
| `.github/` exists | | Required for most customizations |
| `.github/agents/` exists | | Required for custom agents |
| `.github/prompts/` exists | | Required for prompt templates |
| `.github/instructions/` exists | | Recommended for scoped instructions |
| `.github/skills/` exists | | Optional, for Agent Skills |
| `.vscode/` exists | | Recommended for workspace settings |

### 2. Custom Instructions

#### Files to check

| File | Purpose | Priority |
|------|---------|----------|
| `.github/copilot-instructions.md` | Workspace-wide coding guidelines | **High** |
| `.github/instructions/*.instructions.md` | File-type specific rules | Medium |
| `AGENTS.md` (root) | Multi-agent workspace instructions | Optional |

#### Instruction Quality Checks

- [ ] Instructions are concise and actionable
- [ ] No duplicate rules across instruction files
- [ ] `applyTo` globs are specific (not overly broad)
- [ ] Instructions reference relevant tools with `#tool:` syntax where helpful
- [ ] No deprecated settings used (`codeGeneration.instructions`, `testGeneration.instructions`)

#### Recommended Instructions by Project Type

| Project Type | Suggested `applyTo` Patterns |
|--------------|------------------------------|
| TypeScript/JavaScript | `**/*.ts`, `**/*.tsx`, `**/*.js`, `**/*.jsx` |
| Python | `**/*.py` |
| Go | `**/*.go` |
| Rust | `**/*.rs` |
| Documentation | `**/*.md`, `**/docs/**` |
| Tests | `**/*.test.*`, `**/*.spec.*`, `**/tests/**` |
| Config | `**/*.json`, `**/*.yaml`, `**/*.yml` |

### 3. Custom Agents

#### Agent File Checks

- [ ] All agents have `.agent.md` extension
- [ ] Agents are in `.github/agents/` directory
- [ ] YAML frontmatter is valid
- [ ] `description` is present and descriptive
- [ ] `name` is set (recommended)
- [ ] `tools` list is explicit (avoid giving all tools)
- [ ] No deprecated `.chatmode.md` files exist
- [ ] Uses `user-invocable` / `disable-model-invocation` instead of deprecated `infer`

#### Recommended Agents

Consider creating agents for these common workflows:

| Agent | Purpose | Suggested Tools |
|-------|---------|-----------------|
| Planner | Generate implementation plans without editing | `search`, `fetch`, `githubRepo`, `usages` |
| Reviewer | Code review and security analysis | `search`, `usages`, `problems` |
| Documenter | Generate and update documentation | `search`, `editFiles` |
| Tester | Write and run tests | `search`, `editFiles`, `runCommand` |
| Debugger | Diagnose and fix issues | `search`, `editFiles`, `runCommand`, `problems` |

#### Agent Quality Checks

- [ ] Agents have clear, focused purposes
- [ ] Tool lists are minimal and intentional
- [ ] Handoffs defined for workflow agents
- [ ] `user-invocable: false` set for subagent-only agents
- [ ] `disable-model-invocation: true` set for agents that shouldn't be auto-invoked
- [ ] `model` specified where appropriate (can be array for fallback)

### 4. Prompt Files

#### Prompt File Checks

- [ ] All prompts have `.prompt.md` extension
- [ ] Prompts are in `.github/prompts/` directory
- [ ] YAML frontmatter is valid
- [ ] `description` helps users understand the prompt
- [ ] `agent` is specified when needed
- [ ] `tools` list matches the prompt's needs
- [ ] Variables use correct syntax: `${input:name}`, `${file}`, etc.

#### Recommended Prompts

Consider creating prompts for repetitive tasks:

| Prompt | Purpose |
|--------|---------|
| `/new-component` | Scaffold a new UI component |
| `/new-api-endpoint` | Create a new API endpoint |
| `/add-tests` | Generate tests for selected code |
| `/explain` | Explain selected code |
| `/refactor` | Refactor with specific pattern |
| `/document` | Generate documentation |
| `/review` | Code review checklist |

### 5. Agent Skills

#### Skill Checks

- [ ] Skills use `SKILL.md` filename
- [ ] Skills are in `.github/skills/<name>/` directories
- [ ] YAML frontmatter has `name` and `description`
- [ ] Description is specific (helps Copilot decide when to load)
- [ ] Supporting files are referenced with relative paths
- [ ] `user-invocable` / `disable-model-invocation` configured appropriately

#### Recommended Skills

Consider creating skills for:

| Skill | Purpose |
|-------|---------|
| Project-specific patterns | Document unique conventions, architecture |
| API documentation | Include API specs, schemas |
| Deployment procedures | Step-by-step deployment guides |
| Troubleshooting | Common issues and solutions |
| Testing strategies | Project-specific test patterns |

### 6. Hooks (Lifecycle Automation)

#### Hook File Checks

- [ ] Hook configs are valid JSON in `.github/hooks/` directory
- [ ] Each hook entry has `type: "command"` and a `command` field
- [ ] Hook scripts exist and are executable
- [ ] Timeouts are set appropriately (default: 30s)
- [ ] `Stop` hooks check `stop_hook_active` to prevent infinite loops
- [ ] Agent-scoped hooks use `chat.useCustomAgentHooks` setting

#### Recommended Hooks

| Hook Event | Purpose | Example |
|------------|---------|---------|
| `PreToolUse` | Block dangerous commands | Security policy enforcement |
| `PostToolUse` | Auto-format after edits | Run Prettier/ESLint after file changes |
| `SessionStart` | Inject project context | Add environment info to session |
| `Stop` | Enforce quality gates | Require test runs before finishing |

#### Hook configuration locations

| Location | Scope |
|----------|-------|
| `.github/hooks/*.json` | Workspace (shared with team) |
| `.claude/settings.json` | Workspace (Claude compatibility) |
| `.claude/settings.local.json` | Local only (not committed) |
| `~/.claude/settings.json` | User (all workspaces) |
| Agent frontmatter `hooks:` | Agent-scoped (preview) |

### 7. Settings Configuration

#### Workspace Settings (.vscode/settings.json)

Check for recommended settings:

```json
{
  // Enable instruction files
  "github.copilot.chat.codeGeneration.useInstructionFiles": true,
  
  // Enable AGENTS.md support
  "chat.useAgentsMdFile": true,
  
  // Enable Agent Skills
  "chat.useAgentSkills": true,
  
  // Enable MCP servers
  "chat.mcp.enabled": true,
  
  // Optional experimental/preview features
  "chat.useNestedAgentsMdFiles": true,
  "chat.customAgentInSubagent.enabled": true,
  "chat.useCustomAgentHooks": true,
  "chat.useClaudeMdFile": true
}
```

#### Setting Checks

- [ ] Instruction files enabled (`useInstructionFiles: true`)
- [ ] Experimental features enabled as needed
- [ ] No conflicting or deprecated settings
- [ ] Settings committed to repo (shared with team)

### 8. Legacy/Deprecated Patterns

#### Files to migrate or remove

| Deprecated | Migrate To |
|------------|------------|
| `.github/chatmodes/*.chatmode.md` | `.github/agents/*.agent.md` |
| `*.instructions.md` at repo root | `.github/instructions/*.instructions.md` |
| `.claude/skills/` | `.github/skills/` (recommended) |
| `~/.claude/skills/` | `~/.copilot/skills/` (recommended) |

#### Deprecated Settings

| Deprecated Setting | Replacement |
|--------------------|-------------|
| `github.copilot.chat.codeGeneration.instructions` | `.github/copilot-instructions.md` |
| `github.copilot.chat.testGeneration.instructions` | `*.instructions.md` with `applyTo` |

### 9. Security & Best Practices

#### Security Checks

- [ ] No sensitive data in instruction files
- [ ] Terminal commands in prompts are safe and scoped
- [ ] MCP server configurations are reviewed
- [ ] Shared skills are audited before use
- [ ] Hook scripts are reviewed for security implications
- [ ] Agent plugins are audited before installation

#### Version Control

- [ ] All customization files are committed
- [ ] `.gitattributes` marks `*.md` files appropriately
- [ ] Sensitive configurations in `.gitignore` if needed

## Audit Report Template

```markdown
# Copilot Setup Audit Report

**Repository**: [name]
**Date**: [date]
**Auditor**: [name/tool]

## Summary

| Category | Status | Score |
|----------|--------|-------|
| Directory Structure | ✅/⚠️/❌ | X/Y |
| Instructions | ✅/⚠️/❌ | X/Y |
| Custom Agents | ✅/⚠️/❌ | X/Y |
| Prompt Files | ✅/⚠️/❌ | X/Y |
| Agent Skills | ✅/⚠️/❌ | X/Y |
| Hooks | ✅/⚠️/❌ | X/Y |
| Settings | ✅/⚠️/❌ | X/Y |
| Legacy Patterns | ✅/⚠️/❌ | X/Y |
| Security | ✅/⚠️/❌ | X/Y |

## Findings

### Critical (must fix)
- 

### Warnings (should fix)
- 

### Suggestions (nice to have)
- 

## Recommended Actions

1. 
2. 
3. 

## Files to Create

- [ ] 
- [ ] 

## Files to Migrate

- [ ] 
- [ ] 
```

## Reference Documentation

- [Customization Overview](https://code.visualstudio.com/docs/copilot/customization/overview)
- [Custom Instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [Custom Agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [Prompt Files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [Agent Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Hooks](https://code.visualstudio.com/docs/copilot/customization/hooks)
- [Agent Plugins](https://code.visualstudio.com/docs/copilot/customization/agent-plugins)
- [Awesome Copilot](https://github.com/github/awesome-copilot)
