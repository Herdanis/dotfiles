function buildx
    docker buildx build \
        --progress plain \
        --tag $argv[1] \
        --tag $argv[2] \
        --file ./Dockerfile .
end
# Uncomment the next line if you need platform support
# --platform linux/amd64 \
