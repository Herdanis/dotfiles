# WARNING: DONT REMOVE
#
/opt/homebrew/bin/brew shellenv | source

if status is-interactive
end

set -Ux STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
set -Ux STARSHIP_CACHE "$HOME/.starship/cache"
starship init fish | source
fzf --fish | source
#oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.omp.json' | source

# Setup ENV
#
set -Ux EDITOR nvim
set -U fish_user_paths (go env GOPATH)/bin $fish_user_paths
set -Ux FZF_DEFAULT_COMMAND "find . -maxdepth 3"
set -Ux FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -Ux FZF_CTRL_T_OPTS "--preview 'tree -C {} | head -200'"

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external block
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

# Setup Alias
#
alias gitlog="git log --all --decorate --oneline --graph"
alias k="kubectl"
alias kali="docker exec -it kali bash"
alias n="nvim"
alias vim="nvim"
alias gvim="nvim"
alias nremote="nvim --remote-ui --server"
alias t="tmux"
alias ta="tmux a -t"
alias tn="tmux new -s"
alias h="helm"
alias venv="source .venv/bin/activate.fish"
alias penv="python3.12 -m venv .venv"
alias p="python3.12"
alias python="python3.12"
alias pip-freeze="pip freeze > requirements.txt"
alias tf="terraform"
alias dock="docker"
alias dcompose="docker-compose"
alias g="gcloud"
alias gs="gsutil"
alias lzgit="lazygit"
alias lzdoc="lazydocker"
alias mux="tmuxinator"
alias fcat="fzf --preview -m 'bat --color=always {}'"
alias dotfile="cd ~/.dotfiles && nvim"
alias dotconfig="cd ~/.config && nvim"
alias ssh-config="nvim ~/.ssh/config"
alias brew-export="brew bundle dump --describe"

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/herdanis/.cache/lm-studio/bin
