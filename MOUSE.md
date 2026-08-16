# dotfiles Agent Runbook

## Ownership
Personal macOS development environment configuration. Manages dotfiles for Neovim (LazyVim), Fish shell, tmux, Ghostty, Starship, lazygit, k9s, and OpenCode. Deployed via GNU Stow. Includes Brewfile, Dockerfile, and install.fish bootstrap script.

## Conventions
- Language: Fish shell scripts, Lua (Neovim), JSON/YAML configs
- Deploy: `stow .` from repo root
- Install: `brew bundle install` then `nvim --headless "+Lazy! sync" +qa`
- CI: GitLeak secret scan on push/PR (reusable workflow `Herdanis/resuseable-workflow`)
- Commit style: Conventional Commits
- Config style: Caveman + Ponytail modes for AI agents (per `~/.config/opencode/AGENTS.md`)
- Comments: `# ====` 44-char banner style, minimal density

## Dependencies
- Homebrew (package source of truth via Brewfile)
- GNU Stow (symlink deployment)
- LM Studio local server (OpenCode backend, http://127.0.0.1:1234/v1)
- MCP servers: Jam, Tmux, BrowserMCP, GCP, AWS, Serena
- No external service dependencies detected.

## Guardrails
- Commands: no deny list, no ask list (all allowed per user)
- Files: no deny list (all accessible)
- A2A policy: inbound=true, outbound=true
- Rule: do NOT modify other services directly — engage their agent via hmf
- Rule: if unsure, ask the user before making changes outside repo root
- Credentials: `.config/fish/credentials.fish` is gitignored — use template, never commit secrets
- GitLeak enforces no secrets in commits

## Escalation
- If task requires changes in another registered project, use `engage_project_agent` tool to delegate to that project's agent.
- If task is unclear or crosses ownership boundaries, ask the user.
- If a denied command is needed, ask the user to run it manually (none currently denied).
- Secret material: route through `credentials.fish.template` only; never inline API keys.
