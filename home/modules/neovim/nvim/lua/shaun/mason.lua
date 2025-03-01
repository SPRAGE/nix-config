local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup({
    PATH = "prepend" -- Prefer system-installed LSPs over Mason’s versions
})

mason_lspconfig.setup({
    ensure_installed = {}, -- Do not auto-install any LSPs
})

-- Rust LSP
lspconfig.rust_analyzer.setup {}

-- Python LSP
lspconfig.pyright.setup {}

-- Nix LSP
lspconfig.nil_ls.setup({
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixpkgs-fmt" } -- Use Nix formatter
            }
        }
    }
})

