-- Ensure the gruvbox.nvim plugin is installed
vim.cmd("colorscheme gruvbox")

-- Set the theme variant to 'soft'
vim.g.gruvbox_contrast_dark = "soft"

-- Enable true colors for better visuals
vim.opt.termguicolors = true

-- Customize Gruvbox settings (optional)
vim.g.gruvbox_italic = 1
vim.g.gruvbox_bold = 1
vim.g.gruvbox_invert_selection = 0

-- Apply Gruvbox settings
vim.cmd("colorscheme gruvbox")
