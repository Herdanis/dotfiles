return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- Remove shellcheck if it gets added by other configs
      opts.ensure_installed = opts.ensure_installed or {}
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "shellcheck"
      end, opts.ensure_installed)
    end,
  },
}
