# Tmux window name hooks for ssh and k9s
# Sets window name to ssh|hostname or k9s|cluster on preexec,
# and re-enables automatic-rename on postexec

function _tmux_window_preexec --on-event fish_preexec
    not set -q TMUX; and return

    set -l args (string split --no-empty ' ' $argv[1])
    set -l cmd $args[1]

    switch $cmd
        case ssh
            # Find first non-option argument as the hostname
            set -l host ""
            for arg in $args[2..]
                if not string match -q -- '-*' $arg
                    set host $arg
                    break
                end
            end
            if test -n "$host"
                tmux rename-window "ssh|$host"
                set -g _tmux_window_renamed 1
            end

        case k9s
            set -l cluster (kubectl config current-context 2>/dev/null; or echo "?")
            tmux rename-window "k9s|$cluster"
            set -g _tmux_window_renamed 1
    end
end

function _tmux_window_postexec --on-event fish_postexec
    not set -q TMUX; and return
    not set -q _tmux_window_renamed; and return

    set -e _tmux_window_renamed
    tmux set-window-option automatic-rename on
end
