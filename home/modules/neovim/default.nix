{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ]; # ✅ Import nixvim properly

  programs.nixvim = {
    enable = true;
    extraConfigLua = ''
      print("Neovim is now managed by Nixvim!")
    '';
  };
}
