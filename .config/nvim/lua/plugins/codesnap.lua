return {
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
      {
        "<leader>csc",
        "<Esc><cmd>CodeSnap<cr>",
        mode = "x",
        desc = "Save selected code snapshot into clipboard",
      },
      {
        "<leader>csC",
        "<cmd>CodeSnapSave<cr>",
        mode = "x",
        desc = "Save selected code snapshot in ~/Desktop",
      },
      {
        "<leader>csh",
        "<cmd>CodeSnapHighlight<cr>",
        mode = "x",
        desc = "Save selected code add Highlight snapshot into clipboard",
      },
      {
        "<leader>csH",
        "<cmd>CodeSnapSaveHighlight<cr>",
        mode = "x",
        desc = "Save selected code add Highlight snapshot in ~/Desktop",
      },
      {
        "<leader>csa",
        "<Esc><cmd>CodeSnapASCII<cr>",
        mode = "x",
        desc = "Save selected code to ASCII snapshot into clipboard",
      },
    },
    opts = {
      save_path = "~/Desktop",
      has_breadcrumbs = true,
      bg_theme = "bamboo",
      watermark = "",
    },
  },
}
