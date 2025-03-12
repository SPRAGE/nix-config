{ config, pkgs, lib, ... }:

let
  nixvimModule = import ./config; # Import the main Neovim configuration
  extraLib = import ./lib { inherit pkgs; }; # If there's a lib directory, include it
in
{
  programs.nixvim = {
    enable = true;
    module = nixvimModule;
    extraSpecialArgs = {
      inherit pkgs;
    } // extraLib;
  };
}
