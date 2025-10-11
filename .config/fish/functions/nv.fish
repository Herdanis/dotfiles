# ============================================================================
# Neovim Directory Launcher
# ============================================================================
# Quick function to change directory and open Neovim in one command
# Useful for quickly opening projects in a new location
#
# Usage:
#   nv <directory>
#
# Example:
#   nv ~/projects/myapp      # cd to myapp and open nvim
#   nv .config/nvim          # cd to nvim config and open nvim
#   nv                       # Open nvim in current directory
#
# Behavior:
#   - Changes to specified directory
#   - Only opens Neovim if cd succeeds (uses && logic)
#   - If no directory given, opens Neovim in current directory
# ============================================================================

function nv
    cd $argv; and nvim
end
