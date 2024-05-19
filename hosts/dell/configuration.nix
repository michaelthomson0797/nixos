{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      inputs.nixos-hardware.nixosModules.dell-xps-15-9560
      ../../modules/nixos/bootloader.nix
      ../../modules/nixos/user.nix
      ../../modules/nixos/i3.nix
      ../../modules/nixos/nvidia.nix
      ../../modules/nixos/nm.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/env.nix
      ../../modules/nixos/1password.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];

  networking.hostName = "dell";

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
