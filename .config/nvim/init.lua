-- ============================================================================
-- Neovim Configuration (LazyVim)
-- ============================================================================
-- Main initialization file for Neovim using LazyVim distribution
-- This file bootstraps the plugin manager and sets up core functionality
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Plugin Manager Bootstrap
-- ----------------------------------------------------------------------------
-- Initialize lazy.nvim plugin manager and load LazyVim framework
-- This loads all plugin configurations from lua/plugins/ directory
-- Additional config files are loaded from lua/config/ directory
require("config.lazy")

-- ============================================================================
-- Color Scheme Configuration
-- ============================================================================
-- Multiple themes are available - uncomment the one you want to use
-- Only one theme should be active at a time
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Dracula Theme (Currently Disabled)
-- ----------------------------------------------------------------------------
-- A dark theme inspired by Dracula color palette
-- Uncomment to enable:
-- require("dracula")

-- ----------------------------------------------------------------------------
-- Catppuccin Theme (Currently Disabled)
-- ----------------------------------------------------------------------------
-- Catppuccin is a community-driven pastel theme
-- Available variants: latte, frappe, macchiato, mocha
-- Uncomment to enable:
-- require("catppuccin")
-- vim.cmd.colorscheme("catppuccin-mocha")

-- ----------------------------------------------------------------------------
-- Sonokai Theme (Currently Disabled)
-- ----------------------------------------------------------------------------
-- High contrast theme with vivid colors
-- Uncomment to enable:
-- vim.cmd("colorscheme sonokai")

-- ----------------------------------------------------------------------------
-- OneDark Theme (Currently Active)
-- ----------------------------------------------------------------------------
-- OneDark theme inspired by Atom's One Dark color scheme
-- Available styles: dark, darker, cool, deep, warm, warmer
require("onedark").setup({
  style = "warmer",  -- Using warmer variant for softer colors
})
require("onedark").load()

-- ============================================================================
-- LSP (Language Server Protocol) Configuration
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Mason Setup
-- ----------------------------------------------------------------------------
-- Mason: Package manager for LSP servers, DAP servers, linters, and formatters
-- Provides easy installation and management of development tools
require("mason").setup()
require("mason-lspconfig").setup()  -- Bridge between mason.nvim and lspconfig

-- ----------------------------------------------------------------------------
-- Go Language Support (Currently Disabled)
-- ----------------------------------------------------------------------------
-- Additional Go-specific configuration
-- Uncomment to enable:
-- require("go").setup()

-- ============================================================================
-- Rainbow Delimiters Configuration (Currently Disabled)
-- ============================================================================
-- This configuration adds colorful highlighting to matching brackets/parentheses
-- Uses indent-blankline (ibl) plugin with rainbow colors
-- Uncomment the entire block below to enable rainbow delimiter highlighting
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Define Rainbow Color Palette
-- ----------------------------------------------------------------------------
-- Seven distinct colors for nested delimiter levels
-- local highlight = {
--   "RainbowRed",
--   "RainbowYellow",
--   "RainbowBlue",
--   "RainbowOrange",
--   "RainbowGreen",
--   "RainbowViolet",
--   "RainbowCyan",
-- }

-- ----------------------------------------------------------------------------
-- Setup Highlight Groups
-- ----------------------------------------------------------------------------
-- local hooks = require("ibl.hooks")
-- Register hook to create highlight groups when colorscheme changes
-- This ensures rainbow colors persist across theme switches
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--   -- Define each rainbow color with specific hex values
--   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })      -- Red for level 1
--   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })   -- Yellow for level 2
--   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })     -- Blue for level 3
--   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })   -- Orange for level 4
--   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })    -- Green for level 5
--   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })   -- Violet for level 6
--   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })     -- Cyan for level 7
-- end)

-- ----------------------------------------------------------------------------
-- Apply Rainbow Colors to Delimiters and Scope
-- ----------------------------------------------------------------------------
-- Configure rainbow-delimiters plugin to use defined colors
-- vim.g.rainbow_delimiters = { highlight = highlight }
-- Configure indent-blankline to use rainbow colors for scope highlighting
-- require("ibl").setup({ scope = { highlight = highlight } })

-- Register scope highlighting from extmarks (provides smooth scope detection)
-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
