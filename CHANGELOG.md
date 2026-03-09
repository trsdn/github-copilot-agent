# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
## [v0.4.2] - 2026-03-09

## What's Changed

### ♻️ Refactoring
- refactor: remove all Claude references — this is a GitHub Copilot blueprint


## [v0.4.1] - 2026-03-09

## What's Changed

### 📚 Documentation
- docs: add agentskills.io spec fields, plugin settings, and CLAUDE.md audit checks


## [v0.4.0] - 2026-03-09

## What's Changed

### ✨ Features
- feat: add hooks support, agent plugins docs, and align with latest VS Code Copilot docs


## [v0.4.0] - 2026-03-09

### ✨ Features

- feat: add hooks support — new `/copilot-new-hook` prompt template for lifecycle automation
- feat: add agent plugins documentation across all skills
- feat: add `argument-hint`, `user-invocable`, `disable-model-invocation` fields to skill-builder
- feat: add hooks section to setup-audit, compatibility-checker, and customization-selector skills

### ♻️ Refactoring

- refactor: update all skills, prompts, and agent with latest VS Code Copilot docs
- refactor: fix `user-invokable` typo to `user-invocable` across all files
- refactor: replace deprecated `infer` references with `user-invocable`/`disable-model-invocation`
- refactor: update VS Code settings with new Copilot feature flags
- refactor: update compatibility matrix with hooks, plugins, and stable Agent Skills
- refactor: update copilot-instructions.md with hooks and updated file structure

### 📚 Documentation

- docs: update README with hooks, plugins, new prompt template, and VS Code 1.95+ prereq
- docs: add hooks lifecycle events, configuration format, and best practices
- docs: add agent-scoped hooks documentation
- docs: expand decision matrix with hooks and agent plugins columns

## [v0.3.0] - 2026-02-12

## What's Changed



## [v0.2.10] - 2025-02-12

### 🐛 Bug Fixes

- fix: add missing newlines for improved readability in SKILL.md

## [v0.2.9] - 2025-02-12

### ♻️ Refactoring

- refactor: rename skills and prompts with copilot- prefix for clarity

## [v0.2.0] - 2025-02-12

### ✨ Features

- feat: add validation workflow, changelog automation, VS Code config, and analytics

## [v0.1.0] - 2025-02-12

### ✨ Features

- feat: add professional repository structure with auto-release workflow
