# ============================================================================
# Fish Shell Configuration
# ============================================================================
# Main configuration file for Fish shell
# This file is sourced on every new Fish session
# ============================================================================

# ----------------------------------------------------------------------------
# Homebrew Setup
# ----------------------------------------------------------------------------
# Initialize Homebrew environment variables (HOMEBREW_PREFIX, PATH, etc.)
# WARNING: DONT REMOVE - Required for all Homebrew packages to work
/opt/homebrew/bin/brew shellenv | source

# ----------------------------------------------------------------------------
# Interactive Shell Check
# ----------------------------------------------------------------------------
# This block runs only in interactive shells (not scripts)
# Add interactive-only configurations here
if status is-interactive
end

# ----------------------------------------------------------------------------
# Load Credentials
# ----------------------------------------------------------------------------
# Source API keys, tokens, and other sensitive environment variables
# File should be created from credentials.fish.template
# This file is .gitignored and should never be committed
if test -f ~/.config/fish/credentials.fish
    source ~/.config/fish/credentials.fish
end

# ----------------------------------------------------------------------------
# Prompt Configuration (Starship)
# ----------------------------------------------------------------------------
# Starship: Cross-shell prompt with Git integration and customization
set -Ux STARSHIP_CONFIG "$HOME/.config/starship/starship.toml" # Custom config location
set -Ux STARSHIP_CACHE "$HOME/.starship/cache" # Cache directory
starship init fish | source

# ----------------------------------------------------------------------------
# FZF (Fuzzy Finder) Setup
# ----------------------------------------------------------------------------
# Initialize FZF key bindings and completion for Fish
fzf --fish | source

# Alternative prompt (Oh My Posh) - currently disabled
#oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.omp.json' | source

# ============================================================================
# Environment Variables
# ============================================================================

# ----------------------------------------------------------------------------
# Default Editor
# ----------------------------------------------------------------------------
set -Ux EDITOR nvim # Use Neovim as default editor for git, etc.

# ----------------------------------------------------------------------------
# Go Language Path
# ----------------------------------------------------------------------------
# Add Go binaries to PATH (for tools installed with 'go install')
set -U fish_user_paths (go env GOPATH)/bin $fish_user_paths

# ----------------------------------------------------------------------------
# FZF Configuration
# ----------------------------------------------------------------------------
# Default search command: find files up to 3 directories deep
set -Ux FZF_DEFAULT_COMMAND "find . -maxdepth 3"
# Ctrl+T command: same as default
set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# Ctrl+T preview: show directory tree with colors, limited to 200 lines
set -Ux FZF_CTRL_T_OPTS "--preview 'tree -C {} | head -200'"

# ----------------------------------------------------------------------------
# Vim-style Cursor Configuration
# ----------------------------------------------------------------------------
# Emulate Vim's cursor shape behavior for different modes
set fish_cursor_default block # Normal/Visual mode: block cursor
set fish_cursor_insert line # Insert mode: line cursor
set fish_cursor_replace_one underscore # Single-character replace: underscore
set fish_cursor_replace underscore # Replace mode: underscore
set fish_cursor_external block # External commands: block cursor
set fish_cursor_visual block # Visual mode: block cursor (same as default)

# ============================================================================
# Shell Aliases
# ============================================================================
# Quick shortcuts for commonly used commands
# Aliases provide shorter command names and useful defaults
# ============================================================================

# ----------------------------------------------------------------------------
# Git Aliases
# ----------------------------------------------------------------------------
alias gitlog="git log --all --decorate --oneline --graph" # Pretty git log with graph
alias lzgit="lazygit" # Terminal UI for git

# ----------------------------------------------------------------------------
# Kubernetes & Container Orchestration
# ----------------------------------------------------------------------------
alias k="kubectl" # Kubernetes CLI shortcut
alias h="helm" # Helm package manager
alias kali="docker exec -it kali bash" # Quick access to Kali Linux container
alias k9s-logs="cd $HOME/Library/Application\ Support/k9s/screen-dumps/ && nvim" # View k9s logs

# ----------------------------------------------------------------------------
# Editor Aliases
# ----------------------------------------------------------------------------
alias n="nvim" # Quick Neovim launch
alias vim="nvim" # Replace vim with neovim
alias gvim="nvim" # Replace gvim with neovim
alias nremote="nvim --remote-ui --server" # Start Neovim in server mode

# ----------------------------------------------------------------------------
# Tmux (Terminal Multiplexer)
# ----------------------------------------------------------------------------
alias t="tmux" # Quick tmux launch
alias ta="tmux a -t" # Attach to tmux session
alias tn="tmux new -s" # Create new named tmux session
alias mux="tmuxinator" # Tmux session manager

# ----------------------------------------------------------------------------
# Python Development
# ----------------------------------------------------------------------------
alias venv="source .venv/bin/activate.fish" # Activate Python virtual environment
alias penv="python3.12 -m venv .venv" # Create new virtual environment
alias p="python3.12" # Python 3.12 shortcut
alias python="python3.12" # Default to Python 3.12
alias pip-freeze="pip freeze > requirements.txt" # Export Python dependencies

# ----------------------------------------------------------------------------
# Infrastructure as Code
# ----------------------------------------------------------------------------
alias tf="terraform" # Terraform CLI shortcut

# ----------------------------------------------------------------------------
# Docker & Containers
# ----------------------------------------------------------------------------
alias dock="docker" # Docker shortcut
alias dcompose="docker-compose" # Docker Compose shortcut
alias lzdoc="lazydocker" # Terminal UI for Docker

# ----------------------------------------------------------------------------
# Cloud Providers (Google Cloud)
# ----------------------------------------------------------------------------
alias g="gcloud" # Google Cloud CLI shortcut
alias gs="gsutil" # Google Cloud Storage utility

# ----------------------------------------------------------------------------
# File Operations & Navigation
# ----------------------------------------------------------------------------
alias fcat="fzf --preview -m 'bat --color=always {}'" # Fuzzy find with preview using bat

# ----------------------------------------------------------------------------
# Configuration Management
# ----------------------------------------------------------------------------
alias dotfile="cd ~/.dotfiles && nvim" # Quick access to dotfiles repo
alias dotconfig="cd ~/.config && nvim" # Quick access to config directory
alias ssh-config="nvim ~/.ssh/config" # Edit SSH configuration
alias brew-export="brew bundle dump --describe" # Export Brewfile with descriptions

# ----------------------------------------------------------------------------
# File Management
# ----------------------------------------------------------------------------
alias yz="yazi" # Terminal file manager shortcut

# ----------------------------------------------------------------------------
# AI Development Tools
# ----------------------------------------------------------------------------
alias c="claude" # Anthropic Claude CLI shortcut
alias o="opencode" # OpenCode editor shortcut

# ----------------------------------------------------------------------------
# Additional Tools
# ----------------------------------------------------------------------------
# LM Studio CLI path (AI/LLM development tool)
set -gx PATH $PATH /Users/herdanis/.cache/lm-studio/bin

# opencode
fish_add_path /Users/herdanis/.opencode/bin
