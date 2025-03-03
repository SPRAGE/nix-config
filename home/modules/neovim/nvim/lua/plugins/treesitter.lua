return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    dev = true,
    opts = {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "<S-CR>",
                node_decremental = "<BS>",
            },
        },
        -- Add this folding config
        fold = {
            enable = true
        }
    }
}

