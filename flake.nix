{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    polymc.url = "github:PolyMC/PolyMC";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kuvpn = {
      url = "github:ealtun21/kuvpn";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, catppuccin, kuvpn, home-manager, spicetify-nix, ... }@inputs:

    let
      system = "x86_64-linux";
    in {

    # nixos - system hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system;
      };
      modules = [
        ./nixos/configuration.nix
        catppuccin.nixosModules.catppuccin
        inputs.spicetify-nix.nixosModules.default
      ];
    };

    homeConfigurations.gabechu = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ 
        ./home-manager/home.nix
        catppuccin.homeManagerModules.catppuccin 
        inputs.spicetify-nix.homeManagerModules.default
      ];
    };
  };
}
