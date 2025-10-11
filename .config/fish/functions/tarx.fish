# ============================================================================
# Tar Archive Extractor
# ============================================================================
# Extracts gzip-compressed tar archives (.tar.gz or .tgz files)
# Provides a simple, memorable command for the most common tar extraction
#
# Usage:
#   tarx <archive.tar.gz>
#
# Example:
#   tarx myfiles.tar.gz
#   tarx backup-2024-10-11.tgz
#   tarx /path/to/archive.tar.gz
#
# Flags Explanation:
#   -x  = Extract files from archive
#   -v  = Verbose (show files being extracted)
#   -z  = Decompress using gzip
#   -f  = Specify archive file name (must be last flag)
#
# Output:
#   Lists all extracted files to stdout
#   Files are extracted to current directory
#
# Supported Formats:
#   - .tar.gz (gzip-compressed tar)
#   - .tgz (shorthand for .tar.gz)
#
# Note:
#   For other tar formats:
#   - .tar.bz2: tar -xvjf file.tar.bz2
#   - .tar.xz:  tar -xvJf file.tar.xz
#   - .tar:     tar -xvf file.tar
# ============================================================================

function tarx
    tar -xvzf $argv
end
