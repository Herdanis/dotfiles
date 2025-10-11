-- ============================================================================
-- Lazy.nvim Plugin Manager Setup
-- ============================================================================
-- Bootstrap and configure lazy.nvim - a modern plugin manager for Neovim
-- Lazy.nvim features:
--   - Lazy loading for fast startup times
--   - Automatic plugin updates
--   - Lock file for reproducible environments
--   - Clean UI for managing plugins
--
-- Documentation: https://github.com/folke/lazy.nvim
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Bootstrap lazy.nvim
-- ----------------------------------------------------------------------------
-- Check if lazy.nvim is installed, if not, clone it from GitHub
-- Installation path: ~/.local/share/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Lazy.nvim not found, clone it from GitHub
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",    -- Partial clone for faster download
    "--branch=stable",       -- Use stable branch
    lazyrepo,
    lazypath
  })

  -- Handle clone errors
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Lazy.nvim Configuration
-- ============================================================================

require("lazy").setup({
  -- --------------------------------------------------------------------------
  -- Plugin Specifications
  -- --------------------------------------------------------------------------
  spec = {
    -- Import LazyVim core distribution and all its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Import custom plugin configurations from lua/plugins/ directory
    -- Each .lua file in lua/plugins/ defines additional plugins
    { import = "plugins" },
  },

  -- --------------------------------------------------------------------------
  -- Default Plugin Behavior
  -- --------------------------------------------------------------------------
  defaults = {
    -- Lazy loading: false = load all custom plugins at startup (safer)
    -- Set to true only if you understand lazy loading implications
    lazy = false,

    -- Version pinning: false = use latest git commit (recommended)
    -- Many plugins have outdated releases that may break functionality
    version = false,  -- Always use latest git commit
    -- version = "*",  -- Alternative: use latest stable semver tag
  },

  -- --------------------------------------------------------------------------
  -- Installation Settings
  -- --------------------------------------------------------------------------
  -- Fallback colorschemes to use during initial plugin installation
  install = { colorscheme = { "tokyonight", "habamax" } },

  -- Default colorscheme (overridden in init.lua)
  colorscheme = "onedark_vivid",

  -- --------------------------------------------------------------------------
  -- Plugin Update Checker
  -- --------------------------------------------------------------------------
  checker = {
    enabled = true,   -- Automatically check for plugin updates
    notify = false,   -- Don't show notifications for available updates
  },

  -- --------------------------------------------------------------------------
  -- Performance Optimizations
  -- --------------------------------------------------------------------------
  performance = {
    rtp = {
      -- Disable built-in Neovim plugins that are rarely used
      -- This improves startup time
      disabled_plugins = {
        "gzip",        -- gzip file support
        -- "matchit",  -- Extended % matching (keep enabled)
        -- "matchparen", -- Highlight matching parentheses (keep enabled)
        -- "netrwPlugin", -- File browser (keep enabled, or use neo-tree)
        "tarPlugin",   -- tar archive support
        "tohtml",      -- Convert buffer to HTML
        "tutor",       -- Neovim tutor
        "zipPlugin",   -- zip archive support
      },
    },
  },

  -- --------------------------------------------------------------------------
  -- LazyGit Integration
  -- --------------------------------------------------------------------------
  -- Terminal UI for Git operations within Neovim
  {
    "kdheepak/lazygit.nvim",
    -- Lazy load: only load when one of these commands is used
    cmd = {
      "LazyGit",                  -- Open lazygit
      "LazyGitConfig",            -- Open lazygit config
      "LazyGitCurrentFile",       -- Open lazygit for current file
      "LazyGitFilter",            -- Open lazygit with filter
      "LazyGitFilterCurrentFile", -- Filter current file in lazygit
    },
    dependencies = {
      "nvim-lua/plenary.nvim",    -- Required dependency for floating windows
    },
  },
})
