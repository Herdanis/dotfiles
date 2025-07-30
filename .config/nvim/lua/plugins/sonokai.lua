return {
  {
    "sainnhe/sonokai",
    priority = 1000, -- Ensure it loads first
    lazy = false,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = true
      vim.cmd.colorscheme("sonokai")
    end,
  },
}
