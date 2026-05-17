#!/usr/bin/env bash
set -euo pipefail

# ============================================
# Argument Parsing
# ============================================
SKIP=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --skip)
            shift
            while [[ $# -gt 0 && "$1" != --* ]]; do
                SKIP+=("$1")
                shift
            done
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

# ============================================
# Helpers
# ============================================
should_skip() {
    local name="$1"
    for item in "${SKIP[@]:-}"; do
        [[ "$item" == "$name" ]] && return 0
    done
    return 1
}

log_skip() { echo "[SKIP] $1"; }
log_ok()   { echo "[ OK ] $1"; }

# ============================================
# Step 1 — APT Packages
# ============================================
install_apt_packages() {
    should_skip apt && { log_skip apt; return; }
    sudo apt-get update -qq
    sudo apt-get install -y --no-install-recommends \
        curl wget git unzip tar xz-utils build-essential \
        fish tmux stow ripgrep fd-find bat python3
    sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd 2>/dev/null || true
    sudo ln -sf /usr/bin/batcat /usr/local/bin/bat 2>/dev/null || true
    log_ok apt
}

# ============================================
# Step 2 — Neovim
# ============================================
install_neovim() {
    should_skip neovim && { log_skip neovim; return; }
    local arch
    arch=$(uname -m | sed 's/aarch64/arm64/')
    curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz" \
        | sudo tar -C /usr/local -xz --strip-components=1
    log_ok neovim
}

# ============================================
# Step 3 — Starship
# ============================================
install_starship() {
    should_skip starship && { log_skip starship; return; }
    curl -fsSL https://starship.rs/install.sh | sudo sh -s -- --yes
    log_ok starship
}

# ============================================
# Step 4 — FZF
# ============================================
install_fzf() {
    should_skip fzf && { log_skip fzf; return; }
    if [[ ! -d /opt/fzf ]]; then
        sudo git clone --depth 1 https://github.com/junegunn/fzf.git /opt/fzf
    fi
    sudo /opt/fzf/install --bin
    sudo ln -sf /opt/fzf/bin/fzf /usr/local/bin/fzf
    log_ok fzf
}

# ============================================
# Step 5 — Zoxide
# ============================================
install_zoxide() {
    should_skip zoxide && { log_skip zoxide; return; }
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    sudo mv "$HOME/.local/bin/zoxide" /usr/local/bin/zoxide
    log_ok zoxide
}

# ============================================
# Step 6 — Deploy Dotfiles
# ============================================
deploy_dotfiles() {
    should_skip dotfiles && { log_skip dotfiles; return; }
    cd "$HOME/.dotfiles"
    stow .
    log_ok dotfiles
}

# ============================================
# Step 7 — Linux Compat Patches
# ============================================
patch_linux_compat() {
    should_skip patch && { log_skip patch; return; }
    local fish_cfg="$HOME/.config/fish/config.fish"
    local tmux_cfg="$HOME/.config/tmux/tmux.conf"

    # Patch 1: make brew sourcing a no-op when brew is absent
    if grep -q '/opt/homebrew/bin/brew shellenv | source' "$fish_cfg"; then
        sed -i 's@/opt/homebrew/bin/brew shellenv | source@command -q brew; and brew shellenv | source@' "$fish_cfg"
    fi

    # Patch 2: strip macOS-only PATH entries
    sed -i '/lm-studio\/bin/d; /\.opencode\/bin/d; /\.agent-view\/bin/d' "$fish_cfg"

    # Patch 3: fix tmux fish path (Homebrew → system)
    if grep -q '/opt/homebrew/bin/fish' "$tmux_cfg"; then
        sed -i 's@/opt/homebrew/bin/fish@/usr/bin/fish@g' "$tmux_cfg"
    fi

    echo ""
    echo "WARNING: patch_linux_compat modified files inside ~/.dotfiles via stow symlinks."
    echo "         Do NOT commit these changes — they would break the macOS config."
    echo "         Run: git -C ~/.dotfiles diff"
    log_ok patch
}

# ============================================
# Step 8 — Default Shell
# ============================================
set_default_shell() {
    should_skip shell && { log_skip shell; return; }
    local fish_path
    fish_path=$(which fish)
    if ! grep -qx "$fish_path" /etc/shells; then
        echo "$fish_path" | sudo tee -a /etc/shells
    fi
    chsh -s "$fish_path"
    log_ok shell
}

# ============================================
# Step 9 — TPM (Tmux Plugin Manager)
# ============================================
setup_tpm() {
    should_skip tpm && { log_skip tpm; return; }
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"
    if [[ ! -d "$tpm_dir" ]]; then
        git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
    tmux new-session -d -s tpm-install 2>/dev/null || true
    "$tpm_dir/bin/install_plugins" || true
    tmux kill-session -t tpm-install 2>/dev/null || true
    log_ok tpm
}

# ============================================
# Step 10 — Neovim Plugins
# ============================================
setup_nvim_plugins() {
    should_skip nvim-plugins && { log_skip nvim-plugins; return; }
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    log_ok nvim-plugins
}

# ============================================
# Main
# ============================================
main() {
    echo "=== Dotfiles: Debian Install ==="
    echo ""
    install_apt_packages
    install_neovim
    install_starship
    install_fzf
    install_zoxide
    deploy_dotfiles
    patch_linux_compat
    set_default_shell
    setup_tpm
    setup_nvim_plugins
    echo ""
    echo "Done. Start a new shell: exec fish"
}

main
