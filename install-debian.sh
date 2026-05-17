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
