return {
  "tiagovla/tokyodark.nvim",
  opts = {
    -- custom options here
  },
  -- enabled = false,
  config = function(_, opts)
    require("tokyodark").setup(opts) -- calling setup is optional
    vim.cmd([[colorscheme tokyodark]])
  end,
}
