# ============================================================================
# Secure Password Generator
# ============================================================================
# Generates cryptographically secure random passwords using OpenSSL
# Produces 64-character passwords with mixed alphanumeric and special characters
#
# Usage:
#   gen-passwd [bytes]
#
# Example:
#   gen-passwd 32      # Generate password from 32 random bytes
#   gen-passwd 64      # Generate password from 64 random bytes (more entropy)
#   gen-passwd         # If no argument, may produce shorter output
#
# Character Set:
#   - Uppercase: A-Z
#   - Lowercase: a-z
#   - Numbers: 0-9
#   - Special chars: !@%&^+-_
#
# Security Features:
#   - Uses OpenSSL's cryptographically secure random number generator
#   - Removes base64 padding characters (=)
#   - Filters to allowed character set only
#   - Fixed 64-character output length
# ============================================================================

function gen-passwd
    # Generate random bytes, encode as base64, filter characters, truncate to 64 chars
    openssl rand -base64 "$argv" | tr -d '=' | tr -dc 'a-zA-Z0-9!@%&^+\-_' | head -c 64
end
