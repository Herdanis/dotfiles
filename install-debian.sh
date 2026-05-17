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
