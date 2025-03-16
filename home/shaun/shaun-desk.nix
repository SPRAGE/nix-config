{ config, inputs, outputs, ... }: { 
  imports = [ ./home.nix ../common ]; # Pass `inputs` to submodules

  # Enable rootless Docker
  modules.docker.enable = true;
}
