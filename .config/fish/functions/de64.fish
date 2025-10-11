# ============================================================================
# Base64 Decoder
# ============================================================================
# Decodes Base64-encoded strings back to their original format
# Useful for decoding API tokens, JWT payloads, encoded data, etc.
#
# Usage:
#   de64 <base64-string>
#
# Example:
#   de64 "SGVsbG8gV29ybGQ="
#   # Output: Hello World
#
#   de64 "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
#   # Output: {"alg":"HS256","typ":"JWT"}
#
# Common Use Cases:
#   - Decode JWT tokens (header and payload sections)
#   - Decode base64-encoded environment variables
#   - Decode encoded API responses
#   - Reverse encoding from CI/CD systems
#
# Note:
#   - Companion function to base64 encoding
#   - For encoding: echo "text" | base64
# ============================================================================

function de64
    echo $argv | base64 -d
end
