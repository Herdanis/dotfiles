# AI session - opens/focuses a herdr workspace for the current directory
function ai
    if not herdr status server >/dev/null 2>&1
        echo "herdr server not running — run `herdr` first"
        return 1
    end

    set -l name (basename $PWD)
    set -l ws_id (herdr workspace list | jq -r --arg l $name \
        '.result.workspaces[] | select(.label == $l) | .workspace_id')
    if test -n "$ws_id"
        herdr workspace focus $ws_id
        return
    end

    set -l created (herdr workspace create --cwd $PWD --label $name)
    set -l ws_id (echo $created | jq -r '.result.workspace.workspace_id')
    if test -z "$ws_id"
        echo "workspace create failed: $created"
        return 1
    end
    herdr workspace focus $ws_id
end
