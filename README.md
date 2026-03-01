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
│   ├── k9s/            # Kubernetes TUI configuration
│   └── opencode/       # OpenCode AI editor configuration
├── archive/            # Old/backup configurations
├── Brewfile            # Homebrew package list
├── Dockerfile          # Development container image
├── install.fish        # Automated installation script
├── template_mcp.json   # MCP server configuration template
└── README.md           # This file
```

## 🛠️ Key Tools & Technologies

### AI & Development Tools

- **Claude Code**: Anthropic's CLI (`c` alias)
- **OpenCode**: AI-powered code editor with LM Studio integration
- **MCP Servers**: 6 configured servers (Jam, Tmux, Browser, GCP, AWS, Serena)
- **Neovim**: LazyVim with AI assistance and comprehensive plugin ecosystem

### Neovim Configuration

- **Framework**: LazyVim
- **AI Assistance**: Avante.nvim (OpenAI, Claude, Moonshot)
- **MCP Integration**: Model Context Protocol support
- **Language Support**: Go, Python, Terraform, Docker, Kubernetes, Helm
- **Formatters**: Black, Ruff, goimports, gofumpt, prettier, stylua
- **LSP**: Comprehensive language server support via Mason
- **UI**: Snacks.nvim for pickers, explorer, notifications
- **Themes**: OneDark, Catppuccin, Kanagawa, Dracula, Sonokai, Cyberdream

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

### MCP (Model Context Protocol) Integration

The repository includes MCP server configurations for AI-enhanced development:

**Configured Servers** (see `template_mcp.json`):

- **Jam**: Browser automation via HTTP
- **Tmux**: Terminal session management with Fish shell
- **BrowserMCP**: Browser control and automation
- **GCP**: Google Cloud Platform operations
- **AWS**: AWS infrastructure management (awslabs.core-mcp-server)
- **Serena**: Additional AI capabilities via Oraios Serena

**Usage**:

```bash
# Copy template for Claude Code
cp template_mcp.json ~/.config/claude-code/mcp.json

# Or use directly with AI tools that support MCP
```

### OpenCode AI Editor

OpenCode is configured with LM Studio for local LLM inference:

**Features**:

- Local LM Studio integration (http://127.0.0.1:1234/v1)
- Environment protection middleware
- OpenAI-compatible API
- MCP Integration: Tmux and Serena servers

**Configuration**: `.config/opencode/opencode.json`

### Fish Shell Aliases

Quick reference for common aliases:

```fish
# AI Tools
c                    # Claude Code CLI
o                    # OpenCode editor

# Development
n, vim, gvim         # Neovim shortcuts
dotfile              # Edit dotfiles repository
dotconfig            # Edit .config directory
ssh-config           # Edit SSH configuration

# Kubernetes
k                    # kubectl
h                    # helm
k9s-logs             # View k9s screen dumps

# Git
gitlog               # Pretty git log graph
lzgit                # Lazygit TUI

# Python
p, python            # Python 3.12
penv                 # Create venv
venv                 # Activate venv
pip-freeze           # Export requirements.txt

# Docker
dock                 # docker
dcompose             # docker-compose
lzdoc                # lazydocker TUI
kali                 # Access Kali Linux container

# Terraform
tf                   # terraform

# Cloud
g                    # gcloud
gs                   # gsutil

# Tmux
t                    # tmux
ta                   # tmux attach -t
tn                   # tmux new -s
mux                  # tmuxinator

# Utilities
fcat                 # Fuzzy find files with bat preview
brew-export          # Export Brewfile with descriptions
```

### Custom Fish Functions

**20+ Custom Functions**:

**Docker Utilities**:

- `buildx` - Build multi-platform Docker images
- `buildx-push` - Build and push to registry

**Security & Encoding**:

- `gen-passwd` - Generate secure passwords
- `sha256` - Calculate SHA-256 hash
- `de64` - Decode base64 strings

**General Utilities**:

- `tarx` - Extract tar.gz archives
- `envsource` - Load .env file variables
- `h-dry` - Helm dry-run helper
- `nv` - Navigate and open with Neovim
- `git-test` - Git testing utility

### Tmux Configuration

**Key Features**:

- **Prefix**: Alt/Option + Space (macOS optimized)
- **Theme**: Catppuccin Mocha
- **Navigation**: Vim-style (hjkl) with vim-tmux-navigator
- **Plugins**:
  - tmux-sensible (sensible defaults)
  - vim-tmux-navigator (seamless Vim/Tmux navigation)
  - tmux-resurrect (session save/restore)
  - tmux-menus (interactive menus)
- **Copy Mode**: Vi-style with system clipboard integration (pbcopy)
- **Shell**: Fish as default
- **Mouse**: Enabled for pane selection, resizing, scrolling

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

   # Cloud credentials
   set -gx GITHUB_TOKEN "your_token"
   set -gx GOOGLE_APPLICATION_CREDENTIALS "/path/to/credentials.json"
   ```

3. The file is gitignored and will not be committed.

## 🔒 Security

Pre-commit hooks are configured to prevent credential leaks:

- **Gitleaks**: Scans for hardcoded secrets, API keys, tokens
- **Custom checks**: Blocks `credentials.fish`, `.env` files (without `.template`)
- **File size check**: Prevents files >1MB (excludes lazy-lock.json)
- **Syntax validation**: YAML, JSON
- **Private key detection**: SSH/PGP keys
- **Code quality**: Trailing whitespace, EOF newlines, mixed line endings

**Setup pre-commit** (one-time):

```bash
pre-commit install
```

The hooks will automatically run before each commit and **reject commits** if:

- Credentials or API keys are detected
- `credentials.fish` or `.env` files are staged (without `.template`)
- Private keys are found
- Large files are added (>1MB)
- YAML/JSON syntax is invalid

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

Available colorschemes (switch with `<C-n>` for FzfLua picker):

- OneDark (Darker) - Active
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

# Re-deploy with Stow (if needed)
cd ~/.dotfiles
stow --restow .

# Update pre-commit hooks
pre-commit autoupdate
```

## 📝 Notes

- Uses GNU Stow for symlink management
- Follows XDG Base Directory specification (`~/.config/`)
- Credentials are excluded via `.gitignore`
- Archive directory for old/experimental configs
- Python 3.12 is the default Python version

## 🤝 Contributing

Feel free to fork and customize for your own use. If you find improvements or bugs, please open an issue or PR.

## 📄 License

Personal configuration files - use at your own discretion.
