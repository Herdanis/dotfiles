# Personal Dotfiles

Personal macOS development environment configuration featuring Neovim with AI assistance, Fish shell, and modern terminal tooling.

## 🚀 Quick Start

```bash
# Clone repository
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles

# Install Homebrew packages
brew bundle install

# Deploy configurations using GNU Stow
stow .

# Install Neovim plugins
nvim --headless "+Lazy! sync" +qa

# Setup Fish shell credentials (optional)
cp .config/fish/credentials.fish.template .config/fish/credentials.fish
# Edit credentials.fish with your API keys and tokens
```

## 📁 Structure

```
.
├── .config/
│   ├── nvim/           # Neovim configuration (LazyVim)
│   ├── fish/           # Fish shell with custom functions
│   ├── tmux/           # Tmux multiplexer configuration
│   ├── ghostty/        # Ghostty terminal emulator
│   ├── starship/       # Starship prompt configuration
│   ├── lazygit/        # Lazygit configuration
│   └── k9s/            # Kubernetes TUI configuration
├── archive/            # Old/backup configurations
├── Brewfile            # Homebrew package list
├── Dockerfile          # Development container image
└── README.md           # This file
```

## 🛠️ Key Tools & Technologies

### Neovim (30+ Plugins)
- **Framework**: LazyVim
- **AI Assistance**: Avante.nvim (OpenAI, Claude, Moonshot)
- **MCP Integration**: Model Context Protocol support
- **Language Support**: Go, Python, Terraform, Docker, Kubernetes, Helm
- **Formatters**: Black, Ruff, goimports, gofumpt, prettier, stylua
- **UI**: Snacks.nvim for pickers, explorer, notifications

### Shell & Terminal
- **Shell**: Fish with 22+ custom functions
- **Prompt**: Starship (configured for cloud/dev workflows)
- **Terminal**: Ghostty with Dark+ theme
- **Multiplexer**: Tmux with Catppuccin theme

### Cloud & Infrastructure
- **Kubernetes**: kubectl, k9s, helm, helmfile, kubeshark
- **Cloud**: gcloud, azure-cli, doctl
- **IaC**: Terraform, Pulumi
- **Containers**: Docker, lazydocker
- **CI/CD**: ArgoCD, Woodpecker

## ⚙️ Configuration Highlights

### Neovim Features
- AI-powered coding with Avante (GPT-4o-mini, Claude Sonnet, Kimi)
- Format-on-save with language-specific formatters
- Comprehensive LSP support (Mason)
- Extensive keybindings via Snacks.nvim
- Multiple colorscheme options (OneDark, Catppuccin, Kanagawa, etc.)
- Vim-tmux integration for seamless navigation

### Fish Shell Aliases

Quick reference for common aliases:

```fish
# Development
n, vim, gvim         # Neovim shortcuts
dotfile              # Edit dotfiles
dotconfig            # Edit .config

# Kubernetes
k                    # kubectl
h                    # helm

# Git
gitlog               # Pretty git log graph
lzgit                # Lazygit

# Python
p, python            # Python 3.12
penv                 # Create venv
venv                 # Activate venv

# Docker
dock                 # docker
dcompose             # docker-compose
lzdoc                # lazydocker

# Terraform
tf                   # terraform

# Cloud
g                    # gcloud
gs                   # gsutil

# Utilities
fcat                 # Fuzzy find files with preview
```

### Custom Fish Functions

See [.config/fish/README.md](.config/fish/README.md) for detailed documentation of custom functions including:

- **Docker utilities**: `buildx`, `buildx-push`, `mysql`
- **Security & Encoding**: `gen-passwd`, `sha256`, `de64`
- **Utilities**: `tarx`, `envsource`, `h-dry`

## 🔐 Credentials Setup

1. Copy the template:
   ```bash
   cp .config/fish/credentials.fish.template .config/fish/credentials.fish
   ```

2. Edit and add your secrets:
   ```fish
   # API Keys
   set -gx OPENAI_API_KEY "your_openai_key"
   set -gx ANTHROPIC_API_KEY "your_anthropic_key"

   # Cloud credentials (if needed)
   # set -gx GITHUB_TOKEN "your_token"
   ```

3. The file is gitignored and will not be committed.

## 🔒 Security

Pre-commit hooks are configured to prevent credential leaks:

- **Gitleaks**: Scans for hardcoded secrets, API keys, tokens
- **Custom checks**: Blocks `credentials.fish`, `.env` files
- **Company info**: Prevents company-specific data in docs

**Setup pre-commit** (one-time):
```bash
pre-commit install
```

The hooks will automatically run before each commit and **reject commits** if:
- Credentials or API keys are detected
- `credentials.fish` or `.env` files are staged (without `.template`)
- Private keys are found
- Company-specific information is in documentation files

## 📦 Brewfile Highlights

The Brewfile includes:

**Cloud & Infrastructure**: k9s, helm, terraform, pulumi, argocd, kubectl
**Languages**: go, python, node, rust
**Utilities**: fzf, ripgrep, bat, lazygit, lazydocker
**Cloud CLIs**: gcloud, azure-cli, doctl
**Security**: gitleaks, age
**Terminals**: ghostty

## 🐳 Docker Development Container

The included `Dockerfile` provides a development container with:
- Debian stable-slim base
- Go 1.22.4
- Neovim
- Docker CLI
- Build tools

Build and use:
```bash
docker build -t devenv .
docker run -it --rm -v $(pwd):/workspace devenv
```

## 🎨 Neovim Themes

Available colorschemes (switch with `<leader>uC`):
- OneDark (Warmer) - Active
- Catppuccin Mocha
- Kanagawa
- Dracula
- Sonokai
- Cyberdream

## 🔄 Updating

```bash
# Update Homebrew packages
brew bundle install

# Update Neovim plugins
nvim --headless "+Lazy! sync" +qa

# Pull latest dotfiles
git pull origin main
```

## 📝 Notes

- Uses GNU Stow for symlink management
- Follows XDG Base Directory specification
- Credentials are excluded via `.gitignore`
- Archive directory for old/experimental configs
- Python 3.12 is the default Python version

## 🤝 Contributing

Feel free to fork and customize for your own use. If you find improvements or bugs, please open an issue or PR.

## 📄 License

Personal configuration files - use at your own discretion.
