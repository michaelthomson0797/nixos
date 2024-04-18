{ config, pkgs, inputs, ... }:

{
  imports =
    [
      inputs.home-manager.darwinModules.default
    ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    trusted-users = ["mthomson"];

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  users.users.mthomson = {
    home = "/Users/mthomson";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    hello
  ];


  environment.variables = {
    EDITOR = "nvim";
    ZK_NOTEBOOK_DIR = "~/notes";
  };

  services = {
    skhd = {
      enable = true;
      skhdConfig = ''
        cmd - return : wezterm
      '';
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      mthomson = import ./home.nix;
    };
  };
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
