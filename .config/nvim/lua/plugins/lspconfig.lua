return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- ============================================
        -- Terraform LSP
        -- ============================================
        -- root_dir prefers git ancestor so terraform-ls
        -- uses workspace root (where terraform init ran)
        -- instead of nearest .terraform in a submodule.
        -- Matches VSCode behavior — no per-module init.
        terraformls = {
          -- Nvim 0.11+ passes bufnr not fname to root_dir.
          -- Prefer .git root so terraform-ls uses workspace
          -- root (where terraform init ran) over nearest
          -- .terraform in a submodule.
          root_dir = function(bufnr)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            return vim.fs.root(fname, ".git")
              or vim.fs.root(fname, ".terraform")
              or vim.fn.getcwd()
          end,
          single_file_support = true,
          -- Tell terraform-ls which dir is the root module.
          -- All other dirs with *.tf files become child modules
          -- and don't need separate terraform init.
          -- Mirrors VSCode behavior.
          on_new_config = function(cfg, root_dir)
            cfg.init_options = cfg.init_options or {}
            cfg.init_options.rootModulePaths = { root_dir }
          end,
        },
      },
    },
  },
}
