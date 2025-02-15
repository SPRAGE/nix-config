{ config,inputs, ... }: { 
  imports = [ ./home.nix ../common ]; # Pass `inputs` to submodules
  # specialArgs = { inherit inputs; };
}
