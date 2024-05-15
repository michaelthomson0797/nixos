{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/user.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/i3.nix
      ../../modules/nixos/nm.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/steam.nix
      ../../modules/nixos/env.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "desktop";

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    curl
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      mthomson = import ./home.nix;
    };
  };

  system.stateVersion = "23.11";

}
