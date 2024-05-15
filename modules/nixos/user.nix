{ pkgs, ... }:

{
  programs.zsh.enable = true;

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
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Michael Thomson";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
