{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    htop
    wget
    #neovim
    alvr
    vimPlugins.LazyVim 
  ];
}

