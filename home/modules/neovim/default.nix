{ pkgs, ... }:

let
  # Treesitter with grammars
  treesitterWithGrammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.fish
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.javascript
    p.jq
    p.json5
    p.json
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.rust
    p.toml
    p.typescript
    p.vue
    p.yaml
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };

in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    rust-analyzer-unwrapped
    black
    nodejs_22
    gh
    clippy
    clang
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    withNodeJs = true;

    plugins = [
      treesitterWithGrammars
      pkgs.vimPlugins.LazyVim  # Install LazyVim
    ];
  };

  # LazyVim expects configuration in ~/.config/nvim
  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  # LazyVim requires an init.lua file to bootstrap
  home.file."./.config/nvim/init.lua".text = ''
    -- Set LazyVim as the main config
    require("lazyvim.config").setup()
  '';

  # Ensure Treesitter is available
  home.file."./.config/nvim/lua/shaun/init.lua".text = ''
    require("shaun.set")
    require("shaun.remap")
    require("shaun.theme")
    require("shaun.autocommand")
    require("shaun.clipboard")
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  # Treesitter is configured as a locally developed module in LazyVim
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}

