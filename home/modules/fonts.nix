{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; })  # Install only MesloLGS Nerd Font
  ];

  fonts.fontconfig.enable = true;
}

