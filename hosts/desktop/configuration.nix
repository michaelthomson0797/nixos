# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Enable networking
  networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "America/Toronto";

# Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
  };

# i3 relates stuff
  environment.pathsToLink = [ "/libexec" ];
  services.xserver = {
    enable = true; 

    desktopManager = {
      xterm.enable = false;
    };

    videoDrivers = [ "nvidia "];

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        feh
        arandr
      ];
    };

    layout = "us";
    xkbVariant = "";
  };

# pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mthomson = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Michael Thomson";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

# Allow unfree packages
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


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
  ];

  environment.variables.EDITOR = "nvim";

  programs = {
    zsh.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      mthomson = import ./home.nix;
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
# Add any missing dynamic libraries for unpackaged programs
# here, NOT in environment.systemPackages
  ];

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
