function sha256
    echo -n $argv | shasum -a 256
end
