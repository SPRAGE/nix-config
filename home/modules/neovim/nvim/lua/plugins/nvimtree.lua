return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = true, -- Keeps Neo-tree focused on the current file
      },
      window = {
        width = 35, -- Adjust sidebar width
        mappings = {
          ["<CR>"] = "open_tabnew", -- Open files in new tabs when pressing Enter
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd("setlocal relativenumber") -- Enable relative numbers inside Neo-tree
          end,
        },
      },
    })

    -- Ensure Neo-tree stays open when switching tabs
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        if vim.fn.tabpagenr("$") > 1 then
          vim.cmd("Neotree show") -- Reopen Neo-tree on tab switch
        end
      end,
    })
  end,
  keys = {
    { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree File Explorer" },
    { "<leader>E", ":Neotree focus<CR>", desc = "Focus Neo-tree" },
  },
}

