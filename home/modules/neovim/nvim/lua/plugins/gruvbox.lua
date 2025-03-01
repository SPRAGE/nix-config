{
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    vim.o.background = "dark" -- Or "light"
    vim.g.gruvbox_contrast_dark = "soft"
    vim.cmd("colorscheme gruvbox")
  end
}
