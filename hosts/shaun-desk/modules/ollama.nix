{ pkgs, nixpkgs-unstable, ... }:
{
  environment.systemPackages = with pkgs; [
    nixpkgs-unstable.ollama
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
