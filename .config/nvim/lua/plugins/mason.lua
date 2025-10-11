return {
  "mason-org/mason.nvim",
  "mason-org/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  opts = {
    ensure_installed = {
      -- Language Servers
      "ansible-language-server",
      "bashls",
      "docker_compose_language_service",
      "dockerls",
      "gopls",
      "helm_ls",
      "jsonls",
      "jqls",
      "lua_ls",
      "marksman",
      "pyright",
      "svelte",
      "terraformls",
      "yamlls",
      "sqlls",
      "sqls",

      -- Formatters
      "black",
      "gofumpt",
      "goimports",
      "golines",
      "prettier",
      "shfmt",
      "stylua",
      "terraform_fmt",
      "sql-formatter",

      -- Linters & Tools
      "ast-grep",
      "buf",
      "golangci-lint",
      "gospel",
      "gotests",
      "hadolint",
      "markdown-toc",
      "mypy",
      "pylint",
      "ruff",
      "shellcheck",
      "tflint",

      -- Debuggers
      "delve",
      "debugpy",
    },
  },
}
