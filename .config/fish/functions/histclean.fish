function histclean --description "Remove duplicate commands from fish history"
    set -l history_file ~/.local/share/fish/fish_history
    set -l backup_file $history_file.bak.(date +%Y%m%d_%H%M%S)

    cp $history_file $backup_file
    and echo "Backup saved: $backup_file"
    or begin
        echo "Failed to create backup, aborting."
        return 1
    end

    python3 -c "
import re, os

path = os.path.expanduser('~/.local/share/fish/fish_history')
with open(path, encoding='utf-8', errors='replace') as f:
    content = f.read()

raw = content.strip()
entries = re.split(r'\n(?=- cmd:)', raw)

seen = {}
for entry in entries:
    m = re.match(r'- cmd: (.*)', entry, re.DOTALL)
    if m:
        cmd = m.group(1).split('\n')[0].strip()
        seen[cmd] = entry.rstrip()

with open(path, 'w', encoding='utf-8') as f:
    f.write('\n'.join(seen.values()) + '\n')

print(f'Done: {len(entries)} entries → {len(seen)} unique commands')
"
    builtin history merge
end
