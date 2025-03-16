{ config, pkgs, ... }:

{
  users.users.shaun = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    # shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "shaun" ]; 

}
