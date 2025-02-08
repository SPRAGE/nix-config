{ config, pkgs, ... }:

{
  services.openssh.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
  };

}

