function psql17
    docker run -it --rm --network host postgres:17 psql $argv
end
