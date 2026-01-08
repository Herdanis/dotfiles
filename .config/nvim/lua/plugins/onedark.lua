-- return {
--   "navarasu/onedark.nvim",
--   -- version = "v0.1.0", -- Pin to legacy version
--   version = "v1.0.3 - Fix JSX/TSX/HTML Highlighting", -- Pin to legacy version
--   priority = 1000,
--   -- enabled = false,
--   config = function()
--     require("onedark").setup({
--       style = "darker",
--     })
--     require("onedark").load()
--   end,
-- }

return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  -- enabled = false,
}
