function git-test
    docker run --rm -it -v (pwd):/home/ git-test $argv
end
