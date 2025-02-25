{ config, lib, pkgs,inputs,outputs, ... }:

{
programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
      vim.languages.rust = {
	enable = true;
	lsp.enable = true;
	treesitter.enable = true;
    };
};
config.vim.lazy.plugins = {
    "aerial.nvim" = {
      package = pkgs.vimPlugins.aerial-nvim;
      setupModule = "aerial";
      setupOpts = {
        option_name = true;
      };
      after = ''
        -- custom lua code to run after plugin is loaded
        print('aerial loaded')
      '';

      # Explicitly mark plugin as lazy. You don't need this if you define one of
      # the trigger "events" below
      lazy = true;

      # load on command
      cmd = ["AerialOpen"];

      # load on event
      event = ["BufEnter"];

      # load on keymap
      keys = [
        {
          key = "<leader>a";
          action = ":AerialToggle<CR>";
        }
      ];
    };
  };
  };
  }
