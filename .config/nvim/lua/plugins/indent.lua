return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")

      -- Set up highlights for rainbow colors
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      -- Configure rainbow delimiters
      vim.g.rainbow_delimiters = { highlight = highlight }

      -- Setup indent-blankline with scope highlighting
      require("ibl").setup({
        indent = {
          char = "│", -- You can also use "┊", "┆", "⎸", or "▏"
          tab_char = "┊",
          smart_indent_cap = true,
          priority = 1,
        },
        whitespace = {
          remove_blankline_trail = true,
        },
        scope = {
          highlight = highlight,
          enabled = true,
          show_start = true,
          show_end = true,
          include = {
            node_type = {
              ["*"] = { "*" }, -- This will show indent lines for all blocks
            },
          },
        },
      })

      -- Register scope highlight hook
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
