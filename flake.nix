{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
    };
  };

  outputs = { self, home-manager, nixpkgs, nvf, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        shaun-desk = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/shaun-desk
            home-manager.nixosModules.home-manager  # ✅ Install Home Manager as a NixOS module
            {
              home-manager.useGlobalPkgs = true; # Use system-wide nixpkgs
              home-manager.useUserPackages = true; # Allow user-level package installs
              home-manager.users.shaun = import ./home/shaun/shaun-desk.nix; # ✅ Set up Home Manager for user "shaun"
            }
          ];
        };
      };

      homeConfigurations = {
        "shaun@shaun-desk" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/shaun/shaun-desk.nix ];
        };
      };
    };
}

