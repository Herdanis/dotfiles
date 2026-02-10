# ============================================================================
# Docker Buildx - Multi-platform Image Builder
# ============================================================================
# Builds Docker images using Buildx (Docker's extended build capabilities)
# Buildx supports multi-platform builds, caching, and BuildKit features
#
# Usage:
#   buildx <image:tag> [docker buildx build args...]
#   buildx <image:tag> -- [args including context]
#
# Example:
#   buildx myapp:latest
#   buildx ghcr.io/username/myapp:v1.0.0
#
# Features:
#   - Target platform: linux/amd64 (Intel/AMD 64-bit)
#   - Plain progress output (no fancy formatting)
#   - Uses Dockerfile in current directory
#   - Supports optional --push/--load and extra build args
#   - Shorthand: -e KEY=VAL expands to --build-arg KEY=VAL
# ============================================================================

function buildx
    if test (count $argv) -lt 1
        echo "Usage: buildx <image:tag> [docker buildx build args...]" >&2
        echo "       buildx <image:tag> -- [args including context]" >&2
        return 1
    end

    set -l image $argv[1]
    set -l rest $argv[2..-1]

    # Default: treat remaining args as extra flags and keep context as '.'
    # Use '--' to pass a custom context (and any other args) verbatim.
    set -l extra
    set -l add_default_context 1
    if contains -- -- $rest
        set -l idx (contains -i -- -- $rest)
        set extra $rest[(math $idx + 1)..-1]
        set add_default_context 0

        if test (count $extra) -eq 0
            set add_default_context 1
        end
    else
        set extra $rest
    end

    # Shorthand: -e KEY=VAL [KEY2=VAL2 ...] (or -e=KEY=VAL) -> --build-arg ...
    set -l mapped
    set -l i 1
    while test $i -le (count $extra)
        set -l a $extra[$i]

        if test "$a" = "-e"
            set i (math $i + 1)

            if test $i -gt (count $extra)
                echo "buildx: -e requires at least one KEY=VAL" >&2
                return 1
            end

            set -l added 0
            while test $i -le (count $extra)
                set -l kv $extra[$i]

                # Stop consuming once the next flag/option starts.
                if string match -qr '^-{1,2}[^=].*' -- $kv
                    break
                end

                if not string match -qr '^[^=]+=.*$' -- $kv
                    echo "buildx: -e expects KEY=VAL (got '$kv')" >&2
                    return 1
                end

                set mapped $mapped --build-arg $kv
                set added 1
                set i (math $i + 1)
            end

            if test $added -eq 0
                echo "buildx: -e requires at least one KEY=VAL" >&2
                return 1
            end

            continue
        else if string match -qr '^-e=.+' -- $a
            set mapped $mapped --build-arg (string replace -r '^-e=' '' -- $a)
            set i (math $i + 1)
            continue
        end

        set mapped $mapped $a
        set i (math $i + 1)
    end

    set -l have_platform 0
    set -l have_file 0
    set -l have_progress 0

    for a in $mapped
        if string match -qr '^--platform(=|$)' -- $a
            set have_platform 1
        else if string match -qr '^(-f|--file)(=|$)' -- $a
            set have_file 1
        else if string match -qr '^--progress(=|$)' -- $a
            set have_progress 1
        end
    end

    set -l cmd docker buildx build --tag $image --no-cache

    if test $have_progress -eq 0
        set cmd $cmd --progress plain
    end
    if test $have_platform -eq 0
        set cmd $cmd --platform linux/amd64
    end
    if test $have_file -eq 0
        set cmd $cmd --file ./Dockerfile
    end

    set cmd $cmd $mapped

    if test $add_default_context -eq 1
        set cmd $cmd .
    end

    command $cmd
end
