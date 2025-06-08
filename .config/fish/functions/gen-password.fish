function gen-password
    openssl rand -base64 $argv | tr -dc 'a-z0-9!@%&^+\-=_' | head -c 64
end
