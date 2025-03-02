return {
    {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = "v4.x",
        lazy = true,
        config = false
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'onsails/lspkind.nvim' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
        },
        config = function()
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_mappings = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

            local lspkind = require("lspkind")

            cmp.setup({
                mapping = cmp_mappings,
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 75,
                        ellipsis_char = '...',
                        symbol_map = {
                            Copilot = "",
                            Supermaven = ""
                        },
                    })
                },
                sources = {
                    { name = 'supermaven' },
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'copilot' },
                    { name = 'path' },
                    { name = 'luasnip' },
                }
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
            { 'nvim-treesitter/nvim-treesitter' },
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- Setup Mason LSP Manager
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'gopls', 'terraformls' },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({})
                    end,
                }
            })

            -- LSP Keybindings
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                client.server_capabilities.semanticTokensProvider = nil
            end

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                underline = true,
                severity_sort = false,
                float = true,
            })
        end
    }
}

