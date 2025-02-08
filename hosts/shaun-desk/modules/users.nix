{ config, pkgs, ... }:

{
  users.users.shaun = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    # shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "shaun" ]; 

}
