# ============================================================================
# Docker Buildx with Push - Build and Push to Registry
# ============================================================================
# Builds Docker images and immediately pushes them to a container registry
# Combines build and push operations in a single command
#
# Usage:
#   buildx-push <image:tag>
#
# Example:
#   buildx-push ghcr.io/username/myapp:latest
#   buildx-push registry.example.com/myapp:v1.0.0
#
# Prerequisites:
#   - Must be logged in to target registry (docker login)
#   - Image name must include registry if not Docker Hub
#
# Features:
#   - Builds for linux/amd64 platform
#   - Automatically pushes to registry after successful build
#   - Plain progress output for CI/CD friendliness
# ============================================================================

function buildx-push
    docker buildx build \
        --progress plain --push \        # Plain output and push after build
        --tag $argv[1] \                 # Image name and tag (first argument)
        --platform linux/amd64 \         # Target platform architecture
        --file ./Dockerfile .            # Use Dockerfile in current directory
end
