-- ============================================================================
-- Custom Keymaps Configuration
-- ============================================================================
-- Custom keyboard shortcuts that extend or override LazyVim defaults
-- This file is automatically loaded on the VeryLazy event
--
-- LazyVim Default Keymaps:
--   https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Key Notation:
--   <C>   = Ctrl
--   <A>   = Alt/Option
--   <S>   = Shift
--   <CR>  = Enter
--   <Esc> = Escape
--
-- Modes:
--   "n" = Normal mode
--   "i" = Insert mode
--   "v" = Visual mode
--   "x" = Visual block mode
--   "t" = Terminal mode
-- ============================================================================

-- Load LazyVim utility functions for safe keymap setting
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

-- ============================================================================
-- Window Management
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Window Resizing (Currently Disabled - Commented Out)
-- ----------------------------------------------------------------------------
-- Move visual selection up/down (alternative to LazyVim's <A-j>/<A-k>)
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- ----------------------------------------------------------------------------
-- Window Resizing with Ctrl+Shift+Arrow Keys
-- ----------------------------------------------------------------------------
-- Resize splits using Ctrl+Shift+Arrow combinations
-- Increments/decrements by 2 lines/columns for smooth adjustments
map("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ============================================================================
-- Terminal Management
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Terminal Buffer Creation
-- ----------------------------------------------------------------------------
-- Open terminal in different layouts
map("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "Terminal (current window)" })
map("n", "<leader>th", "<cmd>split | terminal<cr>", { desc = "Terminal (horizontal split)" })
map("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal (vertical split)" })
map("n", "<leader>tT", "<cmd>tabnew | terminal<cr>", { desc = "Terminal (new tab)" })

-- Quick escape from terminal mode to normal mode
map("t", "<A-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ============================================================================
-- Mark Management
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Delete All Marks
-- ----------------------------------------------------------------------------
-- Delete all lowercase and uppercase marks in the current buffer
map("n", "<leader>dm", "<cmd>delmarks!<cr>", { desc = "Delete all marks" })

-- ============================================================================
-- Color Scheme Selection
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Quick Colorscheme Picker
-- ----------------------------------------------------------------------------
-- Open FzfLua colorscheme picker with live preview
-- Press Ctrl+n to browse and apply themes interactively
map("n", "<C-n>", "<Esc>:FzfLua colorschemes<CR>", { desc = "Browse colorschemes" })
