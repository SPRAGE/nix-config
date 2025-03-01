{ config,inputs,outputs, ... }: { 
  imports = [ ./home.nix ../common ]; # Pass `inputs` to submodules
}
