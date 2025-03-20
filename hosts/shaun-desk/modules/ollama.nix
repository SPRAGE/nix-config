{ config, pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with unstable; [
    ollama
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}

