-- ============================================================================
-- Docker & Kubernetes Support
-- ============================================================================
-- Plugins for Docker devcontainers and Kubernetes Helm charts
-- Enables development container integration and Helm syntax support
-- ============================================================================

return {
  -- --------------------------------------------------------------------------
  -- Devcontainer Support
  -- --------------------------------------------------------------------------
  -- Provides integration with VS Code-style .devcontainer.json
  -- Allows Neovim to work inside Docker development containers
  --
  -- Plugin: https://codeberg.org/esensar/nvim-dev-container
  -- Features:
  --   - Detects .devcontainer/devcontainer.json
  --   - Connects to running containers
  --   - LSP servers run inside container
  --   - File editing within container context
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},  -- Use default configuration
  },

  -- --------------------------------------------------------------------------
  -- Helm Chart Support
  -- --------------------------------------------------------------------------
  -- Syntax highlighting and filetype detection for Kubernetes Helm charts
  -- Helm uses Go templates in YAML files for Kubernetes manifests
  --
  -- Plugin: https://github.com/towolf/vim-helm
  -- File detection: values.yaml, Chart.yaml, templates/*.yaml in helm charts
  {
    "towolf/vim-helm",
    ft = "helm",  -- Lazy load only for Helm files
  },
}
