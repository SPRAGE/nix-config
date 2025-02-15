{ config, pkgs,inputs, ... }:
{
pkgs = {
        # Optional, if you intend to follow nvf's obsidian-nvim input
        #     # you must also add it as a flake input
    obsidian-nvim.url = "github:epwalsh/obsidian.nvim";

# Required, nvf works best and only directly supports flakes
    nvf = {
        url = "github:notashelf/nvf";
# You can override the input nixpkgs to follow your system's
# instance of nixpkgs. This is safe to do as nvf does not depend
# on a binary cache.
        # inputs.nixpkgs.follows = "nixpkgs";
# Optionally, you can also override individual plugins
# for example:
        inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
        };
      };        #                                                                       }
  }
