function buildx-push
    docker buildx build \
        --progress plain --push \
        --tag $argv[1] \
        --platform linux/amd64 \
        --file ./Dockerfile .
end
