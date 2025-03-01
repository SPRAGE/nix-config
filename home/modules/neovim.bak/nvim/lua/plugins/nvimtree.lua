return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("neo-tree").setup({
      filesystem = { filtered_items = { hide_dotfiles = false, hide_gitignored = false } },
    })
  end,
  keys = {
    { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree File Explorer" },
  },

}
