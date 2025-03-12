{ config, pkgs, lib, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    extraConfigLua = ''
      print("Neovim with nixvim loaded!")
    '';
  };
}
