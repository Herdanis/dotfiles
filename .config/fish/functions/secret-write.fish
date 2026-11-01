# ============================================
# secret-write
# ============================================
# Copy one .env value into a YAML file through yq. The value is never
# printed, so it never enters an agent's context.
function secret-write -d "Write a .env value into a YAML file without exposing it"
    if test (count $argv) -ne 3
        echo "usage: secret-write KEY YQ_PATH FILE" >&2
        echo "example: secret-write DB_PASSWORD '.db.password' app.yaml" >&2
        return 1
    end

    set -l key $argv[1]
    set -l path $argv[2]
    set -l target $argv[3]
    set -l env_file ./.env
    test -n "$SECRET_ENV_FILE"; and set env_file $SECRET_ENV_FILE

    for f in $env_file $target
        if not test -e $f
            echo "secret-write: $f not found" >&2
            return 1
        end
    end

    if not command -q yq
        echo "secret-write: yq missing (brew install yq)" >&2
        return 1
    end

    set -l line (grep -m1 -- "^$key=" $env_file)
    if test -z "$line"
        echo "secret-write: $key not set in $env_file" >&2
        return 1
    end

    set -l raw (string replace -- "$key=" "" $line | string trim)
    set -l value
    if string match -q '"*' -- $raw
        set value (string replace -r -- '^"([^"]*)".*$' '$1' $raw)
    else if string match -q "'*" -- $raw
        set value (string replace -r -- "^'([^']*)'.*\$" '$1' $raw)
    else
        set value (string replace -r -- '\s+#.*$' "" $raw)
    end

    if test -z "$value"
        echo "secret-write: $key is empty in $env_file" >&2
        return 1
    end

    if not env SECRET_WRITE_VALUE="$value" yq -i "$path = strenv(SECRET_WRITE_VALUE)" $target
        echo "secret-write: yq failed on $target" >&2
        return 1
    end

    echo "secret-write: $key -> $target ($path)"
end
