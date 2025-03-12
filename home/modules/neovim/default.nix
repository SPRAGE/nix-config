{ config, pkgs, inputs, ... }:

let
  helpers = import ../lib/icons.nix { inherit pkgs; }; # ✅ Import helpers
in
{
  imports = [ 
	inputs.nixvim.homeManagerModules.nixvim 
	./config/default.nix

]; # ✅ Import nixvim properly

  programs.nixvim = {
    enable = true;
    extraConfigLua = ''
      print("Neovim is now managed by Nixvim!")
    '';
  };
extraSpecialArgs = {
    inherit helpers;
  };

}
