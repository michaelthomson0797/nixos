{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.home-manager.darwinModules.default
    ];

  users.users.mthomson = {
    home = "/Users/mthomson";
  };

  environment.systemPackages = with pkgs; [
    hello
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "mthomson" = import ./home.nix;
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
