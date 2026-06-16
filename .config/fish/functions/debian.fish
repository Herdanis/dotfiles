function debian --description "Run bash in ephemeral Debian bookworm-slim container"
    docker run --rm -it --platform linux/amd64 debian:bookworm-slim bash
end
