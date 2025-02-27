{ config, lib, pkgs,inputs,outputs, ... }:
{
  imports = [
    ../../modules/waybar.nix
    ../../modules/fonts.nix
    ../../modules/kitty.nix
    ../../modules/hyprland.nix
    ./git-config.nix

  ];
}
