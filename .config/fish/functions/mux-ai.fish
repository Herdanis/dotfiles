# Tmux ai session - opens/creates session "tmux-ai" with numbered windows
function mux-ai
    set -l session_name "tmux-ai"
    set -l workspace (pwd)
    set -l base_name (basename $workspace)

    # Determine window name with counter
    set -l counter 0
    if tmux has-session -t $session_name 2>/dev/null
        set -l existing_windows (tmux list-windows -t $session_name -F '#W')
        while contains "$base_name-"(printf "%02d" $counter) $existing_windows
            set counter (math $counter + 1)
        end
    end
    set -l window_name "$base_name-"(printf "%02d" $counter)

    # Create or attach to session
    if not tmux has-session -t $session_name 2>/dev/null
        # Create new session
        if set -q TMUX
            TMUX= tmux new-session -d -s $session_name -c $workspace -n $window_name
            tmux switch-client -t $session_name
        else
            tmux new-session -s $session_name -c $workspace -n $window_name
        end
    else if set -q TMUX
        # Inside tmux - create window and switch if needed
        set -l current_session (tmux display-message -p '#S')
        tmux new-window -t $session_name -c $workspace -n $window_name
        test "$current_session" != "$session_name"; and tmux switch-client -t $session_name
    else
        # Outside tmux - attach and create window
        tmux attach-session -t $session_name \; new-window -c $workspace -n $window_name
    end
end
