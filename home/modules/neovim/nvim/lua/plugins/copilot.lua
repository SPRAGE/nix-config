-- NOTE: Only enable either copilot-vim or codeium-vim at the same time
return {
  -- Use native snippets from Neovim v0.10
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- Ensure opts.experimental exists before modifying it
      opts.experimental = opts.experimental or {}
      -- Disable ghost text for nvim-cmp, use copilot suggestion instead
      opts.experimental.ghost_text = false
    end,
    keys = function()
      return {}
    end,
  },
  -- Setup copilot.vim
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- Enable Copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ["TelescopePrompt"] = false,
      }

      -- Assume Copilot is already mapped
      vim.g.copilot_assume_mapped = true
      -- Set workspace folders
      vim.g.copilot_workspace_folders = "~/Projects"

      -- Setup keymaps
      local keymap = vim.keymap.set
      local opts = { silent = true }

      -- Set <C-y> to accept Copilot suggestion
      keymap("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

      -- Set <C-i> to accept line
      keymap("i", "<C-i>", "<Plug>(copilot-accept-line)", opts)

      -- Set <C-j> to next suggestion, <C-k> to previous suggestion, <C-l> to suggest
      keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
      keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
      keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)

      -- Set <C-d> to dismiss suggestion
      keymap("i", "<C-d>", "<Plug>(copilot-dismiss)", opts)
    end,
  },
  -- Add status line icon for Copilot
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Ensure sections table exists
      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}

      table.insert(opts.sections.lualine_x, 2, {
        function()
          -- Default Copilot icon
          local icon = " " -- GitHub logo or any other relevant symbol
          local ok, lazyvim = pcall(require, "lazyvim.config")
          if ok and lazyvim.icons and lazyvim.icons.kinds then
            icon = lazyvim.icons.kinds.Copilot or icon
          end
          return icon
        end,
        cond = function()
          -- Ensure compatibility with different Neovim versions
          for _, client in ipairs(vim.lsp.get_active_clients()) do
            if client.name == "copilot" then
              return true
            end
          end
          return false
        end,
        color = function()
          -- Default to green if Snacks.util.color is unavailable
          local default_fg = "#6CC644" -- Copilot Green
          local ok, Snacks = pcall(require, "Snacks.util")
          return ok and { fg = Snacks.color("Special") } or { fg = default_fg }
        end,
      })
    end,
  },
}

