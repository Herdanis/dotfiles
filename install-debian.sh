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
