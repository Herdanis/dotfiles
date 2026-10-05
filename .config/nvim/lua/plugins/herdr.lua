-- ============================================
-- Herdr Integration
-- ============================================
-- nvim halves of herdr plugins: chmarax/herdr-nvim sidebar + aimdevlee/herdr-nvim-nav.
-- Sidebar: toggle via herdr prefix+e. Nav: ctrl+hjkl across herdr panes/splits.

return {
  { "ChmaraX/herdr-nvim", opts = {} },
  {
    "aimdevlee/herdr-nvim-nav",
    dependencies = { "christoomey/vim-tmux-navigator" },
    config = function()
      require("herdr-nvim-nav").setup()
    end,
  },
}
