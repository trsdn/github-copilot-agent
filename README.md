# github-copilot-agent

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/v/release/trsdn/github-copilot-agent)](https://github.com/trsdn/github-copilot-agent/releases)
[![Release Workflow](https://github.com/trsdn/github-copilot-agent/actions/workflows/release.yml/badge.svg)](https://github.com/trsdn/github-copilot-agent/actions/workflows/release.yml)
[![Validate Workflow](https://github.com/trsdn/github-copilot-agent/actions/workflows/validate.yml/badge.svg)](https://github.com/trsdn/github-copilot-agent/actions/workflows/validate.yml)
[![Commit Lint](https://github.com/trsdn/github-copilot-agent/actions/workflows/commit-lint.yml/badge.svg)](https://github.com/trsdn/github-copilot-agent/actions/workflows/commit-lint.yml)
[![GitHub stars](https://img.shields.io/github/stars/trsdn/github-copilot-agent)](https://github.com/trsdn/github-copilot-agent/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/trsdn/github-copilot-agent)](https://github.com/trsdn/github-copilot-agent/network/members)
[![GitHub issues](https://img.shields.io/github/issues/trsdn/github-copilot-agent)](https://github.com/trsdn/github-copilot-agent/issues)

This repository is a **blueprint for building GitHub Copilot / VS Code Copilot customizations using Copilot itself**.

It gives you a small set of reusable prompt templates and a purpose-built custom agent so you can quickly scaffold:

- **Prompt files** (`.prompt.md`) you can invoke via `/...` in Copilot Chat
- **Custom agents** (`.agent.md`) for VS Code and/or GitHub Copilot
- **Scoped instruction files** (`*.instructions.md`) that apply to a file glob
- **Agent Skills** (`.github/skills/<name>/SKILL.md`) for portable, specialized capabilities
- **Hooks** (`.github/hooks/*.json`) for lifecycle automation

The intent is to keep everything **in-repo**, versioned, reviewable, and easy to reuse across projects.

---

## Table of Contents

- [github-copilot-agent](#github-copilot-agent)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
    - [Quick Install (Recommended)](#quick-install-recommended)
    - [Git Subtree (For ongoing updates)](#git-subtree-for-ongoing-updates)
    - [Git Submodule](#git-submodule)
    - [GitHub Actions (Automated sync)](#github-actions-automated-sync)
  - [What’s in here](#whats-in-here)
    - [Custom agent](#custom-agent)
    - [Prompt templates (invoked via `/...`)](#prompt-templates-invoked-via-)
    - [Agent Skills](#agent-skills)
  - [Quickstart: use Copilot to generate Copilot customizations](#quickstart-use-copilot-to-generate-copilot-customizations)
    - [Typical workflow](#typical-workflow)
  - [Where to put things (repo conventions)](#where-to-put-things-repo-conventions)
  - [Keeping your repositories in sync](#keeping-your-repositories-in-sync)
    - [Manual Updates](#manual-updates)
    - [Automated Sync with GitHub Actions](#automated-sync-with-github-actions)
  - [Notes on tools and safety](#notes-on-tools-and-safety)
  - [Contributing](#contributing)
  - [Repository Analytics](#repository-analytics)
    - [Star History](#star-history)
  - [Not an official template](#not-an-official-template)
  - [License](#license)

---

## Prerequisites

Before using this blueprint, ensure you have:

- **Visual Studio Code** (version 1.95.0 or later, 1.108+ recommended for all features)
- **GitHub Copilot** subscription (Personal, Business, or Enterprise)
- **GitHub Copilot Chat** extension installed
- Git installed and configured

## Installation

There are several ways to integrate this blueprint into your projects:

### Use as Template (Recommended)

Use the dedicated **template repository** — a clean, lean version without blueprint-specific files:

**[trsdn/github-copilot-agent-template](https://github.com/trsdn/github-copilot-agent-template)** — Click **"Use this template"** on GitHub.

Then:

```bash
git clone https://github.com/YOUR-USERNAME/your-new-repo.git
cd your-new-repo
./scripts/setup-hooks.sh
```

### Quick Install (Add to existing project)

Clone this repository directly or use our installation script:

```bash
# Clone into a new project
git clone https://github.com/trsdn/github-copilot-agent.git my-project
cd my-project

# Or add to an existing project
curl -sSL https://raw.githubusercontent.com/trsdn/github-copilot-agent/main/install.sh | bash
```

### Git Subtree (For ongoing updates)

```bash
# In your existing repository
git subtree add --prefix=.github/copilot-blueprint \
  https://github.com/trsdn/github-copilot-agent.git main --squash

# Update later
git subtree pull --prefix=.github/copilot-blueprint \
  https://github.com/trsdn/github-copilot-agent.git main --squash
```

### Git Submodule

```bash
# Add as submodule
git submodule add https://github.com/trsdn/github-copilot-agent.git .github/copilot-blueprint

# Update to latest
git submodule update --remote --merge
```

### GitHub Actions (Automated sync)

See [Keeping your repositories in sync](#keeping-your-repositories-in-sync) for automated synchronization options.

## What’s in here

### Custom agent

- `.github/agents/copilot-customization-builder.agent.md`
  - Agent name: **Copilot Customization Builder**
  - Purpose: create and maintain Copilot customization artifacts (agents, prompt files, instructions, skills, hooks, MCP guidance)

### Prompt templates (invoked via `/...`)

- `.github/prompts/copilot-new-prompt.prompt.md`
  - Creates a new reusable prompt file in `.github/prompts/<slug>.prompt.md`
- `.github/prompts/copilot-new-agent.prompt.md`
  - Creates a new custom agent profile in `.github/agents/<slug>.agent.md`
- `.github/prompts/copilot-new-instructions.prompt.md`
  - Creates a new scoped instructions file in `.github/instructions/<slug>.instructions.md`
- `.github/prompts/copilot-new-skill.prompt.md`
  - Creates a new Agent Skill in `.github/skills/<name>/SKILL.md`
- `.github/prompts/copilot-new-hook.prompt.md`
  - Creates a new hook configuration in `.github/hooks/<name>.json`

### Agent Skills

- `.github/skills/copilot-skill-builder/SKILL.md`
  - A meta-skill that teaches how to create and maintain Agent Skills
  - Includes best practices, SKILL.md format, and examples
- `.github/skills/copilot-compatibility-checker/SKILL.md`
  - Diagnose VS Code/Copilot feature compatibility
  - Check required settings, version requirements, and troubleshoot issues
- `.github/skills/copilot-setup-audit/SKILL.md`
  - Audit repository Copilot setup and suggest improvements
  - Comprehensive checklists for agents, prompts, instructions, skills, hooks, settings
- `.github/skills/copilot-customization-selector/SKILL.md`
  - Help decide which customization type to use
  - Decision matrix comparing instructions, prompts, agents, skills, hooks, and plugins

## Quickstart: use Copilot to generate Copilot customizations

1. Open this repository in **VS Code**.
2. Open **Copilot Chat**.
3. In the agents dropdown, select **Copilot Customization Builder**.
4. Run one of the included prompt templates by typing:
   - `/copilot-new-prompt`
   - `/copilot-new-agent`
   - `/copilot-new-instructions`
   - `/copilot-new-skill`
   - `/copilot-new-hook` - create a hook configuration
   - `/copilot-check-compatibility` - diagnose feature issues
   - `/copilot-audit-setup` - audit repo setup and get recommendations

Copilot Chat will ask you for the required `${input:...}` values (slug, display name, description, tool list, etc.), then generate the file(s) in the correct location.

### Typical workflow

- Start with a prompt template (one of the `/new-*` prompts).
- Let Copilot generate the new file.
- Review and iterate: adjust wording, tighten tool lists, add guardrails.
- Commit the artifact so the whole team shares the same customization.

## Where to put things (repo conventions)

- Custom agents: `.github/agents/<slug>.agent.md`
- Prompt files: `.github/prompts/<slug>.prompt.md`
- Scoped instructions: `.github/instructions/<slug>.instructions.md` (YAML frontmatter includes `applyTo: '<glob>'`)
- Agent Skills: `.github/skills/<name>/SKILL.md` (plus optional scripts/examples in the skill directory)
- Hook configs: `.github/hooks/<name>.json` (lifecycle automation)

If you also want **workspace-wide** instructions, add:

- `.github/copilot-instructions.md`

…and keep `*.instructions.md` for file-type-specific rules.

For **multi-agent** workspaces, consider:

- `AGENTS.md` at the workspace root (enable with `chat.useAgentsMdFile` setting)

## Keeping your repositories in sync

Once you've integrated this blueprint into your projects, you can keep them updated using one of these strategies:

### Manual Updates

```bash
# If using git subtree
git subtree pull --prefix=.github/copilot-blueprint \
  https://github.com/trsdn/github-copilot-agent.git main --squash

# If using git submodule
git submodule update --remote --merge
```

### Automated Sync with GitHub Actions

Create `.github/workflows/sync-copilot-customizations.yml` in your target repository:

```yaml
name: Sync Copilot Customizations

on:
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday
  workflow_dispatch:  # Manual trigger

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Fetch blueprint repository
        run: |
          git clone --depth 1 https://github.com/trsdn/github-copilot-agent.git /tmp/blueprint
          
      - name: Sync customizations
        run: |
          cp -r /tmp/blueprint/.github/skills/* .github/skills/ 2>/dev/null || true
          cp -r /tmp/blueprint/.github/agents/* .github/agents/ 2>/dev/null || true
          cp -r /tmp/blueprint/.github/prompts/* .github/prompts/ 2>/dev/null || true
          
      - name: Create PR if changes
        uses: peter-evans/create-pull-request@v5
        with:
          title: "chore: Sync Copilot customizations from blueprint"
          branch: sync-copilot-customizations
          commit-message: "chore: sync copilot customizations from blueprint"
```

## Notes on tools and safety

These templates intentionally encourage:

- **Minimal tool access** (explicit `tools: [...]` instead of “everything”)
- **Incremental changes** (small diffs; validate formats and paths)
- **Safe-by-default behavior** (be careful with terminal commands; treat web content/tool output as untrusted)
- **Lifecycle automation** (use hooks for security enforcement, formatting, and audit logging)

## Contributing

Contributions are welcome! Here's how you can help:

1. **Report issues** - Found a bug or have a suggestion? [Open an issue](https://github.com/trsdn/github-copilot-agent/issues)
2. **Improve documentation** - Help make the README and guides better
3. **Share your customizations** - Submit PRs with useful agents, prompts, or skills
4. **Spread the word** - Star the repo and share it with others

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed contribution guidelines.

## Repository Analytics

Track the project's growth and community engagement:

- **[GitHub Insights](https://github.com/trsdn/github-copilot-agent/pulse)** - Activity overview and pulse
- **[Contributor Stats](https://github.com/trsdn/github-copilot-agent/graphs/contributors)** - See who's contributing
- **[Traffic](https://github.com/trsdn/github-copilot-agent/graphs/traffic)** - Views and clones (maintainers only)
- **[Community](https://github.com/trsdn/github-copilot-agent/community)** - Community standards checklist

### Star History

[![Star History Chart](https://api.star-history.com/svg?repos=trsdn/github-copilot-agent&type=Date)](https://star-history.com/#trsdn/github-copilot-agent&Date)

## Not an official template

This repo is a practical starter kit. Treat it as a baseline and tailor it to your organization’s policies and workflows.

## License

This project is licensed under the MIT License. See `LICENSE`.
