{ config,inputs, ... }: { 
  imports = [ ./home.nix ../common ]; # Pass `inputs` to submodules
  _module.args = { inherit inputs; };
}
