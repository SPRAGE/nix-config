{ config, pkgs, ... }:

{
  networking = {
    hostName = "shaundesk";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [8501];
    interfaces.enp8s0.wakeOnLan.enable = true;
  };

}

