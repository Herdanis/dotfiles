# AGENTS.md

Personal dotfiles repo. macOS-first; Fish + Neovim (LazyVim) + Tmux + Ghostty + Starship. Deployed via GNU Stow. Not an application — config files only.

## Deploy / Install

- **Stow from repo root**: `stow .` (restow: `stow --restow .`). Symlinks into `$HOME/.config/` and `$HOME/` per `.stow-local-ignore`.
- **macOS full setup**: `./install.fish` — installs Homebrew, Stow, packages from `Brewfile`, deploys, sets Fish as default shell, syncs nvim plugins, installs TPM. Destructive: removes conflicting files/symlinks (backs up first to `~/.dotfiles-backup-<ts>`). Not idempotent for `chsh`.
- **Linux/container setup**: `./install-debian.sh [--skip <step> ...]`. Used by `Dockerfile`.
- **Neovim plugins**: `nvim --headless "+Lazy! sync" +qa`
- **TPM install**: `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`, then `prefix + I` inside tmux (prefix = `M-Space`).

## Stow Exclusions (`.stow-local-ignore`)

These are NOT deployed by `stow .` — leave alone:
- `.config/opencode/` (agent/serena local state, plugins, user AGENTS.md)
- `.config/serena/`
- `.config/tmux/plugins/` (TPM clones)
- `.config/nvim/lazy-lock.json`, `.config/nvim/.luarc.json`
- `.config/yazi/plugins/`
- `.config/starship/starship_.toml` (generated)
- `archive/`, `Brewfile`, `README.*`, `LICENSE.*`

## Credentials — Hard Rule

`credentials.fish` and `.env` are **blocked from commit** by pre-commit hook (only `*.template` versions pass). Never edit a local `credentials.fish` — edit `.config/fish/credentials.fish.template`. Sourced by `config.fish` if present.

## Pre-commit

- `pre-commit install` once. Hooks: gitleaks (custom `.gitleaks.toml`), large-file (>1MB, except `lazy-lock.json`), private-key detect, YAML/JSON syntax, trailing-ws/EOF/mixed-EOL.
- `pre-commit run --all-files` to check without committing.
- CI: `.github/workflows/gitleak.yaml` runs gitleaks on push/PR via reusable workflow `Herdanis/resuseable-workflow`.

## OpenCode Config

- `.config/opencode/opencode.json` is **gitignored** (local-only, has API keys/paths). Tracked template: `template_opencode.json`. To change defaults everyone inherits, edit the template — not the local file.
- In-repo plugin: `.config/opencode/plugins/caveman/` (caveman mode) and `plugins/engram.ts` (Engram adapter → local `engram` Go binary on port 7437).
- `.opencode/` at repo root = just `package.json` pinning `@opencode-ai/plugin` + `goals/` dir. Not deployed by stow.
- MCP servers (tmux, browsermcp, serena, context7, engram, codegraph) configured in local `opencode.json`.

## Shell

- **Fish is primary/default.** `.zshrc` exists (oh-my-zsh + p10k) but is secondary.
- Custom functions live in `.config/fish/functions/*.fish` (~22). Aliases defined in `config.fish` and `aliases.fish`.
- Homebrew shellenv MUST stay at top of `config.fish` — comment says `DONT REMOVE`.
- Fish plugins listed in `.config/fish/fish_plugins` — install via `fisher update` if fisher installed.

## Docker

`docker build -t devenv .` — clones `github.com/Herdanis/dotfiles` main at build time. Override:
- `--build-arg DOTFILES_BRANCH=feat/foo`
- `--build-arg DOTFILES_REPO=https://github.com/fork/dotfiles.git`

Run: `docker run -it --rm -v $(pwd):/workspace devenv`. Mount socket for inner docker CLI.

## Conventions

- Block comments use 44-char `=` banner (see user-level AGENTS.md). No prose under banners.
- Minimal comments. No install/usage instructions in code — those go in README.
- `TZ=Asia/Jakarta`, `LANG=en_US.UTF-8` in Dockerfile.
- Python 3.12 = default python (`p` / `python` alias).

## Files Not To Touch Blindly

- `.config/nvim/lazy-lock.json` — plugin lockfile, auto-managed by Lazy.nvim.
- `.config/fish/credentials.fish` — if it exists locally, it's user secrets. Never commit.
- `Brewfile` — has comment per line; preserve format when adding/removing.
- `.gitleaks.toml` — custom secret rules; changes affect what commits pass.
