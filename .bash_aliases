# ============================================
# Tmux
# ============================================
alias t='tmux'
alias ta='tmux a -t'

# ============================================
# FZF Configuration
# ============================================
export FZF_DEFAULT_COMMAND="find . -maxdepth 3"
export FZF_CTRL_T_COMMAND="find . -maxdepth 3 -type d"
export FZF_CTRL_T_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--with-nth=3.."

# FZF key bindings (installed via /opt/fzf by install-debian.sh)
[ -f /opt/fzf/shell/key-bindings.bash ] && source /opt/fzf/shell/key-bindings.bash
[ -f /opt/fzf/shell/completion.bash ] && source /opt/fzf/shell/completion.bash
