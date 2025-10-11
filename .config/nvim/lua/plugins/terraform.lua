-- ============================================================================
-- Terraform/HCL Support
-- ============================================================================
-- Vim-terraform provides Terraform and HCL language support
-- Includes syntax highlighting, formatting, and folding for IaC files
--
-- Plugin: https://github.com/hashivim/vim-terraform
-- File types: .tf, .tfvars, .hcl
--
-- Features:
--   - Syntax highlighting for Terraform/HCL
--   - Automatic formatting with terraform fmt on save
--   - Code folding for resource blocks
--   - Alignment of = signs in assignments
-- ============================================================================

return {
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },  -- Lazy load only for Terraform/HCL files
    config = function()
      -- Enable automatic alignment of = signs in Terraform code
      -- Example: resource "aws_instance" "example" {
      --            ami           = "ami-123456"
      --            instance_type = "t2.micro"
      --          }
      vim.g.terraform_align = 1

      -- Enable folding for Terraform resource/module blocks
      -- Use 'za' to toggle folds, 'zR' to open all, 'zM' to close all
      vim.g.terraform_fold_sections = 1

      -- Automatically run 'terraform fmt' on save to format files
      vim.g.terraform_fmt_on_save = 1
    end,
  },
}
