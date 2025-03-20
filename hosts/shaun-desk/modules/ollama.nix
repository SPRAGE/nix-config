{
  config,
  pkgs,
  inputs,
  ...
}:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with unstable; [
    ollama-rocm
  ];

  services.ollama = {
    enable = true;
    loadModels = [ "gemma3:12b" ];
  };
}
