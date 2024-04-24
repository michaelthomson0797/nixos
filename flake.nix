{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-darwin, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos/configuration.nix
        ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/thinkpad/configuration.nix
        ];
      };
    };

    darwinConfigurations = {
      macbook = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/macbook/configuration.nix
        ];
      };
    };
  };
}
