return {
  -- ============================================
  -- nvim-lint overrides
  -- ============================================
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      -- terraform_validate runs `terraform -chdir=<buf_dir> validate`
      -- per buffer. Child modules that aren't separately init'd always
      -- fail with "Missing required provider" / "Module not installed".
      -- terraform-ls LSP already handles syntax + type checking.
      -- Disable to avoid false positives in module subdirectories.
      linters_by_ft = {
        terraform = {},
        tf = {},
      },
    },
  },
}
