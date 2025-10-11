#!/usr/bin/env fish

# Dotfiles Installation Script
# Automates the setup of dotfiles on a fresh macOS system

set -l DOTFILES_DIR (pwd)
set -l BACKUP_DIR "$HOME/.dotfiles-backup-"(date +%Y%m%d-%H%M%S)

echo "🚀 Dotfiles Installation Script"
echo "================================"
echo ""

# ========================================
# Check Prerequisites
# ========================================

echo "📋 Checking prerequisites..."

# Check if running on macOS
if not test (uname) = "Darwin"
    echo "❌ Error: This script is designed for macOS only"
    exit 1
end

# Check for Homebrew
if not command -v brew >/dev/null 2>&1
    echo "❌ Homebrew not found. Installing Homebrew..."
    /bin/bash -c (curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)

    # Add Homebrew to PATH for Apple Silicon
    if test -d /opt/homebrew/bin
        eval (/opt/homebrew/bin/brew shellenv)
    end
else
    echo "✅ Homebrew found"
end

# Check for Stow
if not command -v stow >/dev/null 2>&1
    echo "📦 Installing GNU Stow..."
    brew install stow
else
    echo "✅ GNU Stow found"
end

echo ""

# ========================================
# Backup Existing Configs
# ========================================

echo "💾 Backing up existing configurations..."

set -l configs_to_backup \
    "$HOME/.config/nvim" \
    "$HOME/.config/fish" \
    "$HOME/.config/tmux" \
    "$HOME/.config/starship" \
    "$HOME/.config/ghostty" \
    "$HOME/.zshrc"

set -l backed_up 0

for config in $configs_to_backup
    if test -e $config
        if not test -d $BACKUP_DIR
            mkdir -p $BACKUP_DIR
        end

        echo "  → Backing up: $config"
        cp -r $config $BACKUP_DIR/
        set backed_up (math $backed_up + 1)
    end
end

if test $backed_up -gt 0
    echo "✅ Backed up $backed_up configurations to: $BACKUP_DIR"
else
    echo "ℹ️  No existing configurations to backup"
end

echo ""

# ========================================
# Install Homebrew Packages
# ========================================

echo "📦 Installing Homebrew packages from Brewfile..."

if test -f "$DOTFILES_DIR/Brewfile"
    brew bundle install --file="$DOTFILES_DIR/Brewfile"
    echo "✅ Homebrew packages installed"
else
    echo "⚠️  Warning: Brewfile not found, skipping package installation"
end

echo ""

# ========================================
# Deploy Dotfiles with Stow
# ========================================

echo "🔗 Deploying dotfiles with GNU Stow..."

cd $DOTFILES_DIR

# Remove existing symlinks/files that might conflict
set -l stow_conflicts \
    "$HOME/.config/nvim" \
    "$HOME/.config/fish" \
    "$HOME/.config/tmux" \
    "$HOME/.config/starship" \
    "$HOME/.config/ghostty" \
    "$HOME/.config/lazygit" \
    "$HOME/.config/k9s" \
    "$HOME/.zshrc" \
    "$HOME/.fzf.zsh"

for item in $stow_conflicts
    if test -L $item
        echo "  → Removing symlink: $item"
        rm $item
    else if test -e $item
        # Already backed up above, safe to remove
        if test $backed_up -gt 0
            echo "  → Removing: $item (backed up)"
            rm -rf $item
        end
    end
end

# Deploy with Stow
if stow . 2>&1 | tee /tmp/stow-output.log
    echo "✅ Dotfiles deployed successfully"
else
    echo "❌ Error deploying dotfiles with Stow"
    echo "Check /tmp/stow-output.log for details"
    exit 1
end

echo ""

# ========================================
# Setup Fish Shell
# ========================================

echo "🐟 Setting up Fish shell..."

# Set Fish as default shell
if not test $SHELL = (which fish)
    echo "  → Setting Fish as default shell..."
    if not grep -q (which fish) /etc/shells
        echo (which fish) | sudo tee -a /etc/shells
    end
    chsh -s (which fish)
    echo "✅ Fish shell set as default (restart terminal to apply)"
else
    echo "✅ Fish is already the default shell"
end

# Setup credentials file
if test -f "$HOME/.config/fish/credentials.fish.template"
    if not test -f "$HOME/.config/fish/credentials.fish"
        echo "  → Creating credentials.fish from template..."
        cp "$HOME/.config/fish/credentials.fish.template" "$HOME/.config/fish/credentials.fish"
        echo "✅ Created credentials.fish (edit with your API keys)"
    else
        echo "ℹ️  credentials.fish already exists"
    end
end

echo ""

# ========================================
# Install Neovim Plugins
# ========================================

echo "⚡ Installing Neovim plugins..."

if command -v nvim >/dev/null 2>&1
    echo "  → Running Lazy.nvim sync..."
    nvim --headless "+Lazy! sync" +qa
    echo "✅ Neovim plugins installed"
else
    echo "⚠️  Neovim not found, skipping plugin installation"
end

echo ""

# ========================================
# Setup Tmux Plugins
# ========================================

echo "🖥️  Setting up Tmux plugins..."

if command -v tmux >/dev/null 2>&1
    set -l tpm_dir "$HOME/.config/tmux/plugins/tpm"

    if not test -d $tpm_dir
        echo "  → Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm $tpm_dir
        echo "✅ TPM installed"
        echo "ℹ️  Run 'tmux' then press 'prefix + I' to install plugins"
    else
        echo "✅ TPM already installed"
    end
else
    echo "⚠️  Tmux not found, skipping TPM installation"
end

echo ""

# ========================================
# Final Steps
# ========================================

echo "✨ Installation Complete!"
echo ""
echo "📝 Next Steps:"
echo ""
echo "1. Restart your terminal for changes to take effect"
echo ""
echo "2. Edit credentials file with your API keys:"
echo "   nvim ~/.config/fish/credentials.fish"
echo ""
echo "3. Configure Git (if not already done):"
echo "   git config --global user.name \"Your Name\""
echo "   git config --global user.email \"your.email@example.com\""
echo ""
echo "4. Setup Tmux plugins:"
echo "   - Start tmux: tmux"
echo "   - Press: prefix (M-Space or Ctrl-b) + I"
echo ""
echo "5. Authenticate with cloud providers:"
echo "   gcloud auth login"
echo "   az login"
echo "   doctl auth init"
echo ""
if test -d $BACKUP_DIR
    echo "6. Your old configs are backed up at:"
    echo "   $BACKUP_DIR"
    echo ""
end
echo "📚 Documentation:"
echo "   - Main README: $DOTFILES_DIR/README.md"
echo "   - Fish functions: $DOTFILES_DIR/.config/fish/README.md"
echo ""
echo "🎉 Happy coding!"
