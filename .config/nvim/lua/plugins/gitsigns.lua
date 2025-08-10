return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })
    local wk = require("which-key")
    wk.add({
      {
        { "<leader>gS", group = "Gitsigns" },
        { "<leader>gSa", ":Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
        { "<leader>gSp", ":Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
        { "<leader>gSr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
      },
    })
  end,
}
