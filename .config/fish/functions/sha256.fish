# ============================================================================
# SHA-256 Hash Calculator
# ============================================================================
# Calculates SHA-256 hash of a string input
# Useful for verifying data integrity, checksums, or generating unique identifiers
#
# Usage:
#   sha256 <string>
#
# Example:
#   sha256 "hello world"
#   sha256 mypassword123
#   sha256 "$(cat file.txt)"    # Hash file contents
#
# Output Format:
#   Returns 64-character hexadecimal hash followed by a dash
#   Example: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  -
#
# Note:
#   - Uses echo -n to exclude trailing newline from hash calculation
#   - Algorithm: SHA-256 (Secure Hash Algorithm 256-bit)
# ============================================================================

function sha256
    echo -n $argv | shasum -a 256
end
