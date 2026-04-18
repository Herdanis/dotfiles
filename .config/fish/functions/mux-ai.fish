# Tmux ai session - opens/creates session "tmux-ai" with numbered windows
function mux-ai
    set -l session_name tmux-ai
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

    # Create or attach to session, capture window index for reliable targeting
    set -l win_idx
    if not tmux has-session -t $session_name 2>/dev/null
        TMUX= tmux new-session -d -s $session_name -c $workspace -n $window_name
        set win_idx 0
    else
        set win_idx (tmux new-window -d -P -F "#{window_index}" -t $session_name -c $workspace -n $window_name)
    end

    # Launch claude code in the new window (target by index, immune to auto-rename)
    tmux send-keys -t "$session_name:$win_idx" "claude" Enter
end
