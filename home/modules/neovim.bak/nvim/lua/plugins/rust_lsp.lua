return {
    "neovim/nvim-lspconfig",
    config = function()
        require("lspconfig").rust_analyzer.setup({
            cmd = { "rust-analyzer" }, -- Uses system-installed rust-analyzer
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = { command = "clippy" },
                    cargo = { allFeatures = true },
                    procMacro = { enable = true },
                },
            },
        })
    end,
}
