# github-copilot-agent

This repository is a **blueprint for building GitHub Copilot / VS Code Copilot customizations using Copilot itself**.

It gives you a small set of reusable prompt templates and a purpose-built custom agent so you can quickly scaffold:

- **Prompt files** (`.prompt.md`) you can invoke via `/...` in Copilot Chat
- **Custom agents** (`.agent.md`) for VS Code and/or GitHub Copilot
- **Scoped instruction files** (`*.instructions.md`) that apply to a file glob

The intent is to keep everything **in-repo**, versioned, reviewable, and easy to reuse across projects.

## What’s in here

### Custom agent

- `.github/agents/copilot-customization-builder.agent.md`
  - Agent name: **Copilot Customization Builder**
  - Purpose: create and maintain Copilot customization artifacts (agents, prompt files, instructions, MCP guidance)

### Prompt templates (invoked via `/...`)

- `.github/prompts/new-prompt-file.prompt.md`
  - Creates a new reusable prompt file in `.github/prompts/<slug>.prompt.md`
- `.github/prompts/new-custom-agent.prompt.md`
  - Creates a new custom agent profile in `.github/agents/<slug>.agent.md`
- `.github/prompts/new-instructions-file.prompt.md`
  - Creates a new scoped instructions file at the repo root: `<slug>.instructions.md`

## Quickstart: use Copilot to generate Copilot customizations

1. Open this repository in **VS Code**.
2. Open **Copilot Chat**.
3. In the agent picker, select **Copilot Customization Builder**.
4. Run one of the included prompt templates by typing:
   - `/new-prompt-file`
   - `/new-custom-agent`
   - `/new-instructions-file`

Copilot Chat will ask you for the required `${input:...}` values (slug, display name, description, tool list, etc.), then generate the file(s) in the correct location.

### Typical workflow

- Start with a prompt template (one of the `/new-*` prompts).
- Let Copilot generate the new file.
- Review and iterate: adjust wording, tighten tool lists, add guardrails.
- Commit the artifact so the whole team shares the same customization.

## Where to put things (repo conventions)

- Custom agents: `.github/agents/<slug>.agent.md`
- Prompt files: `.github/prompts/<slug>.prompt.md`
- Scoped instructions: `<slug>.instructions.md` (YAML frontmatter includes `applyTo: '<glob>'`)

If you also want **workspace-wide** instructions, add:

- `.github/copilot-instructions.md`

…and keep `*.instructions.md` for file-type-specific rules.

## Notes on tools and safety

These templates intentionally encourage:

- **Minimal tool access** (explicit `tools: [...]` instead of “everything”)
- **Incremental changes** (small diffs; validate formats and paths)
- **Safe-by-default behavior** (be careful with terminal commands; treat web content/tool output as untrusted)

## Not an official template

This repo is a practical starter kit. Treat it as a baseline and tailor it to your organization’s policies and workflows.

## License

This project is licensed under the MIT License. See `LICENSE`.
