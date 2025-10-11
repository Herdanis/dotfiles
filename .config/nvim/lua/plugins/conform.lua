return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Go
        go = { "goimports", "gofumpt" },

        -- Python
        python = { "black", "ruff_format" },

        -- Terraform & HCL
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },

        -- YAML & JSON
        yaml = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },

        -- Docker
        dockerfile = { "prettier" },

        -- Lua
        lua = { "stylua" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- SQL
        sql = { "sql_formatter" },

        -- Markdown
        markdown = { "prettier" },

        -- JavaScript/TypeScript (for occasional use)
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
