# ============================================================================
# Environment Variable Sourcer
# ============================================================================
# Loads environment variables from a .env file into the current Fish session
# Useful for importing environment variables from .env files that use
# Bash/Zsh syntax (KEY=value format)
#
# Usage:
#   envsource <path-to-env-file>
#
# Example:
#   envsource .env
#   envsource config/.env.local
#
# Features:
#   - Ignores comment lines (starting with #)
#   - Ignores empty lines
#   - Removes quotes from values (single and double)
#   - Exports variables globally (-gx flag)
#   - Provides feedback for each exported variable
#
# File Format Expected:
#   KEY=value
#   DATABASE_URL="postgresql://localhost/mydb"
#   API_KEY='abc123'
#   # This is a comment and will be ignored
# ============================================================================

function envsource
    # Process each line from the file
    for line in (cat $argv | grep -v '^#' |  grep -v '^\s*$' | sed -e 's/=/ /' -e "s/'//g" -e 's/"//g' )
        set export (string split ' ' $line)
        set -gx $export[1] $export[2]
        echo "Exported key $export[1]"
    end
end
