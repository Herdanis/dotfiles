# AGENTS.md

Personal dotfiles repo. macOS-first; Fish + Neovim (LazyVim) + Tmux + Ghostty + Starship + herdr. Deployed via GNU Stow. Not an application — config files only.

## Deploy / Install

- **Stow from repo root**: `stow .` (restow: `stow --restow .`). Symlinks repo contents into `$HOME` / `$HOME/.config`.
- **macOS full setup**: `./install.fish` — installs Homebrew, Stow, Brewfile packages, deploys, sets Fish default, syncs nvim plugins, installs TPM. Destructive: removes conflicting files (backs up first to `~/.dotfiles-backup-<ts>`). Not idempotent for `chsh`.
- **Linux/container setup**: `./install-debian.sh [--skip <step> ...]`. Steps: `apt neovim starship fzf zoxide lazygit yazi dotfiles patch shell tpm nvim-plugins`. Used by `Dockerfile`.
- **Neovim plugins**: `nvim --headless "+Lazy! sync" +qa`
- **TPM install**: `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`, then `prefix + I` inside tmux (prefix = `M-Space`).

## Linux Patches — Never Commit

`install-debian.sh` (step `patch`) and the `Dockerfile` both sed-patch stowed files for Linux compat (brew no-op, strip macOS PATH, tmux fish path). These edits land inside `~/.dotfiles` via symlinks — committing them breaks the macOS config. After a Linux install, check `git -C ~/.dotfiles diff` and discard those changes.

## What Stow Deploys vs Not

Not stowed — excluded by `.stow-local-ignore`: `README.*`, `LICENSE.*`, `COPYING`, `Brewfile`, `archive/`, `.config/*/README.md`, `.config/nvim/lazy-lock.json`, `.config/nvim/.luarc.json`, backup/tmp files.

Not in the tree at all — kept out by gitignore (stow can't deploy what git doesn't hold):
- `.config/opencode/` — live local OpenCode config; repo has only templates (see below)
- `.config/tmux/plugins/` (`.config/tmux/.gitignore`), `.config/yazi/plugins/`, `.config/starship/starship_.toml` (generated)
- herdr runtime: `plugins/`, `session.json`, `*.log` (`.config/herdr/.gitignore`)
- env-specific fish functions: `*-*-prd.fish`, `*-*-stg.fish`, `*-*-dev.fish` (`.config/fish/functions/.gitignore`)

Local-only untracked files (`.git/info/exclude`): work-specific functions (`cavos.fish`, `gank.fish`, `haydn.fish`…), `graphify-out/`, `.understand-anything/`. Leave them alone.

## Credentials — Hard Rule

`credentials.fish` and `.env` are **blocked from commit** by pre-commit hook (only `*.template` versions pass) and by gitleaks. The local `credentials.fish` lives inside the repo tree (stowed to `~/.config/fish`) but is gitignored — never commit, never paste contents. Edit `.config/fish/credentials.fish.template`; sourced by `config.fish` if present.

## Pre-commit

- `pre-commit install` once. Hooks: gitleaks (custom `.gitleaks.toml`), large-file (>1MB, except `lazy-lock.json`), private-key detect, YAML/JSON syntax, trailing-ws/EOF/mixed-EOL, block-credentials.
- `pre-commit run --all-files` to check without committing.
- CI: `.github/workflows/gitleak.yaml` runs gitleaks on push/PR via reusable workflow `Herdanis/the-invisible-mouse`.

## OpenCode Config

- `.config/opencode/` is **gitignored entirely** — live local config (API keys, MCP servers) lives there, not in this repo.
- Tracked templates at root: `template_opencode.json` (permissions, MCP servers, plugin list) and `template_mcp.json`. To change inherited defaults, edit templates — not the local files.
- `.opencode/` at repo root = local plugin-dev scratch (package.json, node_modules, goals); self-ignored. Not deployed.
- Neovim side: `.config/nvim/lua/plugins/opencode.lua`.

## Herdr

`.config/herdr/` tracked: `config.toml`, `plugins.json`, `.plugins.lock`, `release-notes.json`. Runtime state (installed `plugins/`, `session.json`, logs, sockets) gitignored. `config.fish` sources the `herdr-automatic-rename` hook from `~/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.fish` — plugin dir is runtime state, don't commit.

## Shell

- **Fish is primary/default.** `.zshrc` exists (oh-my-zsh + p10k) but is secondary.
- Aliases all live in `config.fish` (~25, grouped by topic). Custom functions in `.config/fish/functions/` (~26 tracked). Lazy inits in `conf.d/` (gvm, nvm, omf, tmux_window_name, uv). Completions in `completions/`.
- Homebrew shellenv MUST stay at top of `config.fish` — comment says `DONT REMOVE`.
- Fish plugins in `.config/fish/fish_plugins` — `fisher update` if fisher installed.
- `config.fish` sets `OPENCODE_DISABLE_CLAUDE_CODE=1` — don't re-enable Claude Code compat layer.

## Docker

`docker build -t devenv .` — clones `github.com/Herdanis/dotfiles` at build time. Override:
- `--build-arg DOTFILES_BRANCH=feat/foo`
- `--build-arg DOTFILES_REPO=https://github.com/fork/dotfiles.git`

Run: `docker run -it --rm -v $(pwd):/workspace devenv`. Includes docker CLI — mount `/var/run/docker.sock` for inner docker. Image applies the Linux compat patches (see above). `TZ=Asia/Jakarta`, `LANG=en_US.UTF-8`.

## Conventions

- Block comments use 44-char `=` banner. No prose under banners.
- Minimal comments. No install/usage instructions in code — those go in README.
- Python 3.12 is the dev target (`penv` creates 3.12 venv, `p` = python3, `venv` activates `.venv`).

## Files Not To Touch Blindly

- `.config/nvim/lazy-lock.json` — plugin lockfile, auto-managed by Lazy.nvim.
- `.config/fish/credentials.fish` — user secrets, never commit.
- `.config/fish/fish_variables` — fish universal-variable state; tracked, but diffs are machine churn — don't commit casually.
- `Brewfile` — comment per line (169 comments / 406 lines); preserve format when adding/removing.
- `.gitleaks.toml` — custom secret rules; changes affect what commits pass.
- `.git/info/exclude` — machine-local excludes, not repo convention.
