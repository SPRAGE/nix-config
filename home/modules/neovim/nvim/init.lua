local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.guicursor = ""

-- Fold settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99

-- Ensure only normal buffers open in tabs (excludes Neo-tree)
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local filetype = vim.bo.filetype
    -- Exclude Neo-tree and other sidebar plugins
    if not bufname:match("neo%-tree") and filetype ~= "neo-tree" then
      vim.cmd("tabnew %")
    end
  end
})

-- Diagnostics UI tweaks
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
    source = "if_many", -- Show diagnostic source if multiple are available
  },
})

-- Ensure Neo-tree remains open across tabs
vim.api.nvim_create_autocmd("TabEnter", {
  pattern = "*",
  command = "Neotree show"
})

-- Lazy.nvim setup
require("lazy").setup("plugins", {
    rocks = { enabled = false },
    dev = {
        path = "~/.local/share/nvim/nix",
        patterns = { "nvim-treesitter" },
        fallback = false,
    }
})

-- Load personal module
require("shaun")

