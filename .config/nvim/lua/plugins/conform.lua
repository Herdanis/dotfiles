-- ============================================================================
-- Conform.nvim - Code Formatter Configuration
-- ============================================================================
-- Conform provides a unified interface for running code formatters
-- Automatically formats code on save for consistent code style
--
-- Plugin: https://github.com/stevearc/conform.nvim
-- Commands:
--   :ConformInfo      - Show formatter info for current buffer
--   :Format           - Manually format current buffer
--   gq                - Format with motion (e.g., gqip for paragraph)
--
-- Features:
--   - Format on save with configurable timeout
--   - Fallback to LSP formatting if formatter unavailable
--   - Multiple formatters can run in sequence
--   - Per-filetype formatter configuration
-- ============================================================================

return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- -----------------------------------------------------------------------
      -- Formatter Assignment by File Type
      -- -----------------------------------------------------------------------
      -- Each filetype can have one or more formatters (run in sequence)
      -- Formatters must be installed via Mason or system package manager
      formatters_by_ft = {
        -- ---------------------------------------------------------------------
        -- Go Language
        -- ---------------------------------------------------------------------
        -- goimports: Organizes imports and formats code
        -- gofumpt: Stricter formatting than standard gofmt
        go = { "goimports", "gofumpt" },

        -- ---------------------------------------------------------------------
        -- Python
        -- ---------------------------------------------------------------------
        -- black: Opinionated Python formatter (PEP 8 compliant)
        -- ruff_format: Fast Python formatter (Rust-based, black-compatible)
        python = { "black", "ruff_format" },

        -- ---------------------------------------------------------------------
        -- Infrastructure as Code (Terraform/HCL)
        -- ---------------------------------------------------------------------
        -- terraform_fmt: Official Terraform code formatter
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },

        -- ---------------------------------------------------------------------
        -- Data Formats (YAML/JSON)
        -- ---------------------------------------------------------------------
        -- prettier: Multi-language formatter for web/config files
        yaml = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },        -- JSON with Comments

        -- ---------------------------------------------------------------------
        -- Containers
        -- ---------------------------------------------------------------------
        dockerfile = { "prettier" },

        -- ---------------------------------------------------------------------
        -- Lua (Neovim Configuration)
        -- ---------------------------------------------------------------------
        -- stylua: Opinionated Lua formatter
        lua = { "stylua" },

        -- ---------------------------------------------------------------------
        -- Shell Scripts
        -- ---------------------------------------------------------------------
        -- shfmt: Shell script formatter (supports bash, sh, mksh)
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- ---------------------------------------------------------------------
        -- Database (SQL)
        -- ---------------------------------------------------------------------
        -- sql_formatter: Formats SQL queries with consistent style
        sql = { "sql_formatter" },

        -- ---------------------------------------------------------------------
        -- Documentation (Markdown)
        -- ---------------------------------------------------------------------
        markdown = { "prettier" },

        -- ---------------------------------------------------------------------
        -- Web Development (JavaScript/TypeScript)
        -- ---------------------------------------------------------------------
        -- Included for occasional frontend work
        javascript = { "prettier" },
        typescript = { "prettier" },
      },

      -- -----------------------------------------------------------------------
      -- Format on Save Settings
      -- -----------------------------------------------------------------------
      format_on_save = {
        timeout_ms = 500,      -- Maximum time to wait for formatting (0.5s)
        lsp_fallback = true,   -- Use LSP formatter if conform formatter unavailable
      },
    },
  },
}
