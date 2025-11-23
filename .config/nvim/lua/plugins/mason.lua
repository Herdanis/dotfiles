-- ============================================================================
-- Mason - LSP/DAP/Linter/Formatter Package Manager
-- ============================================================================
-- Mason manages installation of language servers, formatters, linters, and debuggers
-- Provides a unified interface for installing development tools
--
-- Plugin: https://github.com/williamboman/mason.nvim
-- Commands:
--   :Mason           - Open Mason UI to manage packages
--   :MasonInstall    - Install specific package
--   :MasonUninstall  - Remove package
--   :MasonUpdate     - Update all installed packages
--
-- This configuration ensures all specified tools are automatically installed
-- on first launch or when running :MasonInstall
-- ============================================================================

return {
  "mason-org/mason.nvim", -- Core Mason plugin
  "mason-org/mason-lspconfig.nvim", -- Bridge between Mason and lspconfig
  "neovim/nvim-lspconfig", -- LSP configuration plugin

  opts = {
    -- -------------------------------------------------------------------------
    -- Auto-Install Tools
    -- -------------------------------------------------------------------------
    -- All tools listed here will be automatically installed by Mason
    -- These tools cover multiple programming languages and DevOps workflows
    ensure_installed = {
      -- -----------------------------------------------------------------------
      -- Language Servers (LSP)
      -- -----------------------------------------------------------------------
      -- Provide IDE features: autocomplete, go-to-definition, hover docs, etc.
      "ansible-language-server", -- Ansible YAML playbooks
      "bashls", -- Bash/Shell scripts
      "docker_compose_language_service", -- Docker Compose YAML
      "dockerls", -- Dockerfile
      "gopls", -- Go language server
      "helm_ls", -- Kubernetes Helm charts
      "jsonls", -- JSON files
      "jqls", -- jq query language
      "lua_ls", -- Lua (Neovim config)
      "marksman", -- Markdown files
      "pyright", -- Python (type-aware)
      "svelte", -- Svelte framework
      "terraformls", -- Terraform/HCL
      "yamlls", -- YAML files
      "sqlls", -- SQL queries
      "sqls", -- SQL (alternative)

      -- -----------------------------------------------------------------------
      -- Code Formatters
      -- -----------------------------------------------------------------------
      -- Automatically format code to maintain consistent style
      "black", -- Python formatter (PEP 8)
      "gofumpt", -- Go formatter (stricter than gofmt)
      "goimports", -- Go import organizer
      "golines", -- Go long line formatter
      "prettier", -- JavaScript/TypeScript/JSON/YAML/Markdown
      "shfmt", -- Shell script formatter
      "stylua", -- Lua formatter
      "terraform_fmt", -- Terraform formatter
      "sql-formatter", -- SQL formatter

      -- -----------------------------------------------------------------------
      -- Linters & Static Analysis Tools
      -- -----------------------------------------------------------------------
      -- Detect code issues, bugs, and style violations
      "ast-grep", -- Structural code search/lint
      "buf", -- Protocol Buffers linter
      "golangci-lint", -- Go comprehensive linter suite
      "gospel", -- Go spell checker
      "gotests", -- Go test generator
      "hadolint", -- Dockerfile linter
      "markdown-toc", -- Markdown table of contents generator
      "mypy", -- Python static type checker
      "pylint", -- Python code analysis
      "ruff", -- Python fast linter (Rust-based)
      "tflint", -- Terraform linter

      -- -----------------------------------------------------------------------
      -- Debuggers (DAP - Debug Adapter Protocol)
      -- -----------------------------------------------------------------------
      -- Enable breakpoint debugging within Neovim
      "delve", -- Go debugger (dlv)
      "debugpy", -- Python debugger
    },
  },
}
