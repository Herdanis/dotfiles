function mysql
    docker run -it --rm --network host mysql:latest mysql $argv
end