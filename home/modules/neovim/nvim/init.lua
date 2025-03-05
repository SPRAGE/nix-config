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
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.guicursor = ""
-- Fold settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99

vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
    source = "if_many", -- Show diagnostic source if multiple are available
  },
})


require("lazy").setup("plugins", {
    rocks = { enabled = false },
    dev = {
        path = "~/.local/share/nvim/nix",
        patterns = { "nvim-treesitter" },
        fallback = false,
    }
})
require("shaun")
