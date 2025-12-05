return {
  {
    "nvim-telescope/telescope.nvim",
    -- Disable treesitter-based highlighting in previewers to avoid ft_to_lang issues
    opts = function(_, opts)
      opts = opts or {}
      opts.defaults = opts.defaults or {}
      opts.defaults.preview = opts.defaults.preview or {}
      opts.defaults.preview.treesitter = false
      return opts
    end,
  },
}
