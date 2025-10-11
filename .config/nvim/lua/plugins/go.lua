-- ============================================================================
-- Go Language Support (go.nvim)
-- ============================================================================
-- Comprehensive Go development plugin for Neovim
-- Provides advanced Go tooling, testing, debugging, and code generation
--
-- Plugin: https://github.com/ray-x/go.nvim
-- Status: Currently DISABLED (enabled = false)
--
-- Features (when enabled):
--   - Go test runner with inline results
--   - Code generation (impl, iferr, fillstruct)
--   - Go-specific text objects
--   - Struct tag management
--   - Go module support
--   - Integration with gopls LSP
--
-- Alternative: Using gopls LSP + conform formatters (see mason.lua, conform.lua)
-- ============================================================================

return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",           -- GUI components for go.nvim
    "neovim/nvim-lspconfig",      -- LSP configuration
    "nvim-treesitter/nvim-treesitter",  -- Syntax parsing
  },

  -- Currently disabled - using gopls LSP and conform formatters instead
  -- Set to true to enable go.nvim's additional features
  enabled = false,

  opts = {
    -- LSP keymaps can be disabled if you prefer custom bindings
    -- lsp_keymaps = false,

    -- Additional go.nvim options can be configured here
    -- See: https://github.com/ray-x/go.nvim#configuration
  },

  config = function(lp, opts)
    -- Initialize go.nvim with provided options
    require("go").setup(opts)

    -- --------------------------------------------------------------------------
    -- Auto-format on Save
    -- --------------------------------------------------------------------------
    -- Automatically run goimports before saving Go files
    -- This organizes imports and formats code
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimports()  -- Format and organize imports
      end,
      group = format_sync_grp,
    })
  end,

  -- Lazy loading triggers
  event = { "CmdlineEnter" },         -- Load when entering command-line mode
  ft = { "go", "gomod" },             -- Load for Go files and go.mod

  -- Auto-install/update go.nvim binaries (e.g., gopls, goimports, golangci-lint)
  build = ':lua require("go.install").update_all_sync()',
}
