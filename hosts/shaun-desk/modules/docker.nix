
{ config, pkgs, ... }:

{
  # Import Docker’s NixOS module to get default Docker configuration options
  imports = [
    (import "${pkgs.path}/nixos/modules/virtualisation/docker.nix")
  ];

  # Enable the Docker service
  services.docker.enable = true;

  # Install Docker client and additional tools as part of the system packages
  environment.systemPackages = with pkgs; [ docker ];

 
}
