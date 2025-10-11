# Fish Shell Configuration

Documentation for Fish shell configuration and custom functions.

## 📋 Table of Contents

- [Overview](#overview)
- [Configuration](#configuration)
- [Custom Functions](#custom-functions)
- [Creating Functions](#creating-functions)
- [Related Files](#related-files)

---

## 🐟 Overview

This directory contains Fish shell configuration including:
- Shell configuration (`config.fish`)
- Custom function library (`functions/`)
- Credentials template (`credentials.fish.template`)
- Completions and plugins

---

## ⚙️ Configuration

### Main Config (`config.fish`)

Key features:
- **Prompt**: Starship integration
- **Editor**: Neovim set as default
- **Shell Behavior**: Vim cursor shapes, FZF integration
- **Environment Setup**: PATH configuration, custom variables

### Environment Variables

Set via `credentials.fish` (created from template):
- API keys and tokens
- Cloud provider credentials
- Database connection strings
- Service-specific secrets

---

## 🛠️ Custom Functions

### Docker Utilities

**`buildx`** - Build multi-platform Docker images
```fish
buildx <tag>
```

**`buildx-push`** - Build and push to registry
```fish
buildx-push registry.io/app:latest
```

**`mysql`** - Run MySQL client in container
```fish
mysql -h localhost -u user -p database
```

### Security & Encoding

**`gen-passwd`** - Generate secure passwords
```fish
gen-passwd 32  # Generate 32-byte password
```

**`sha256`** - Calculate SHA-256 hash
```fish
sha256 "text to hash"
```

**`de64`** - Decode base64 strings
```fish
de64 "encoded_string"
```

### Utilities

**`tarx`** - Extract tar.gz archives
```fish
tarx archive.tar.gz
```

**`envsource`** - Load .env file variables
```fish
envsource .env
```

**`h-dry`** - Helm dry-run helper
```fish
h-dry ./chart/
```

**`nv`** - Navigate and open with Neovim
```fish
nv /path/to/project
```

### Node Version Manager

**`nvm`** - Manage Node.js versions
```fish
nvm install 20
nvm use 20
nvm list
```

---

## 📝 Creating Functions

### Quick Start

1. Create function file:
```fish
# functions/myfunction.fish
function myfunction
    echo "Hello from myfunction"
    # Implementation here
end
```

2. Function is automatically available in new shells

3. Document in this README

### Function Template

```fish
# functions/example.fish

# Description: Brief description of what this does
# Usage: example <required> [optional]
# Example: example input.txt

function example
    # Validate arguments
    if test (count $argv) -lt 1
        echo "Usage: example <required> [optional]"
        return 1
    end

    # Local variables
    set -l input $argv[1]
    set -l output $argv[2]

    # Implementation
    echo "Processing $input..."

    # Error handling
    if test $status -ne 0
        echo "Error occurred"
        return 1
    end
end
```

### Best Practices

- **Naming**: Use descriptive, lowercase names with hyphens
- **Arguments**: Use `$argv` for parameters
- **Variables**:
  - `set -l` for local variables
  - `set -g` for global (Fish only)
  - `set -gx` for exported environment variables
  - `set -U` for universal (persistent across sessions)
- **Error Handling**: Check `$status` and return appropriate codes
- **Documentation**: Add inline comments for complex logic

### Common Patterns

**Argument validation:**
```fish
if test (count $argv) -lt 1
    echo "Error: Missing argument"
    return 1
end
```

**Optional arguments with defaults:**
```fish
set -l port $argv[1]
test -z "$port"; and set port 8080
```

**Check if command exists:**
```fish
if not command -v docker >/dev/null
    echo "Docker not installed"
    return 1
end
```

**File/directory checks:**
```fish
if test -f myfile.txt
    echo "File exists"
end

if test -d mydir
    echo "Directory exists"
end
```

---

## 🔗 Related Files

- **[config.fish](config.fish)** - Main shell configuration
- **[credentials.fish.template](credentials.fish.template)** - Template for secrets
- **[functions/](functions/)** - Individual function files
- **[Main README](../../README.md)** - Repository documentation

---

## 🔐 Security Notes

- **credentials.fish** is gitignored - never commit secrets
- Use `credentials.fish.template` as a reference
- Store sensitive functions locally (not in repo)
- Rotate API keys and tokens regularly
- Use `set -gx` for temporary session secrets only

---

## 📚 Resources

- [Fish Shell Documentation](https://fishshell.com/docs/current/)
- [Fish Functions Guide](https://fishshell.com/docs/current/language.html#functions)
- [Starship Prompt](https://starship.rs/)
- [FZF Fish Integration](https://github.com/PatrickF1/fzf.fish)
