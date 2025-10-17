# ============================================================================
# Docker Buildx - Multi-platform Image Builder
# ============================================================================
# Builds Docker images using Buildx (Docker's extended build capabilities)
# Buildx supports multi-platform builds, caching, and BuildKit features
#
# Usage:
#   buildx <image:tag>
#
# Example:
#   buildx myapp:latest
#   buildx ghcr.io/username/myapp:v1.0.0
#
# Features:
#   - Target platform: linux/amd64 (Intel/AMD 64-bit)
#   - Plain progress output (no fancy formatting)
#   - Uses Dockerfile in current directory
# ============================================================================

function buildx
    docker buildx build \
        --progress plain \
        --tag $argv[1] \
        --platform linux/amd64 \
        --file ./Dockerfile .
end
