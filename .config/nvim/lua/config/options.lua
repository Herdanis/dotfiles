-- ============================================================================
-- Neovim Options Configuration
-- ============================================================================
-- Custom Vim options that override LazyVim defaults
-- This file is loaded automatically before lazy.nvim startup
--
-- LazyVim Default Options:
--   https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
-- Vim Options Reference:
--   :help vim.opt
--   :help options
-- ============================================================================

-- ============================================
-- Filetype Overrides
-- ============================================
-- Nvim 0.12+ detects .tf as "tf" but the entire
-- ecosystem (lspconfig, LazyVim, treesitter)
-- expects "terraform". Remap here so everything
-- works without per-tool patches.
vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform-vars",
  },
})

-- ============================================
-- Python LSP Configuration
-- ============================================
-- Set Pyright as the default Python Language Server
-- Alternatives: "basedpyright", "pylsp", "ruff_lsp"
vim.g.lazyvim_python_lsp = "pyright"

-- ----------------------------------------------------------------------------
-- Editor Display Options
-- ----------------------------------------------------------------------------
local opt = vim.opt

-- Enable line wrapping for long lines
-- When enabled, long lines will wrap to the next line instead of extending off-screen
opt.wrap = true
