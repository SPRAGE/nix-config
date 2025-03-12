return {
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        event = "InsertEnter", -- Load Copilot only when needed
        opts = {
            panel = {
                enabled = true,
                auto_refresh = false, -- Prevents unnecessary updates
                keymap = {
                    open = "<M-CR>", -- Meta+Enter opens Copilot panel
                    refresh = "gr", -- Refresh Copilot suggestions
                    accept = "<CR>", -- Accept suggestion
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true, -- Enables inline suggestions automatically
                debounce = 75, -- Slight delay for better performance
                keymap = {
                    accept = "<Tab>", -- Accept the entire suggestion
                    accept_word = "<M-w>", -- Accept one word
                    accept_line = "<C-.>", -- Accept one line (Ctrl + >)
                    next = "<M-]>", -- Next suggestion
                    prev = "<M-[>", -- Previous suggestion
                    dismiss = "<C-]>", -- Dismiss suggestion
                },
            },
            filetypes = {
                markdown = true, -- Enable Copilot for Markdown
                yaml = true, -- Enable Copilot for YAML
                gitcommit = true, -- Enable for Git commits
                lua = true,
                rust = true,
                go = true,
                python = true,
                ["*"] = false, -- Disable by default for all other filetypes
            },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        enabled = true,
        dependencies = { "hrsh7th/nvim-cmp" }, -- Ensure nvim-cmp is loaded
        config = function()
            require("copilot_cmp").setup({
                method = "getCompletionsCycling", -- Cycles through Copilot suggestions
                formatters = {
                    insert_text = require("copilot_cmp.format").remove_existing,
                },
            })
        end,
    },
}

