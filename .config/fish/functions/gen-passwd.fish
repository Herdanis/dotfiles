function gen-passwd
    openssl rand -base64 "$argv" | tr -d '=' | tr -dc 'a-zA-Z0-9!@%&^+\-_' | head -c 64
end
