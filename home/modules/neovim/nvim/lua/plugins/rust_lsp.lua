local M = {}

M.setup = function()
    local lspconfig = require("lspconfig")

    lspconfig.rust_analyzer.setup({
        cmd = { "rust-analyzer" }, -- Uses system-installed rust-analyzer
        filetypes = { "rust" },
        root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
                cargo = {
                    allFeatures = true,
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    })
end

return M
