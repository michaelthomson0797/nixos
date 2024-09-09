{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/i3
    ../../modules/home-manager/ssh
    ../../modules/home-manager/git
    ../../modules/home-manager/neovim
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
    ../../modules/home-manager/tmux
    ../../modules/home-manager/taskwarrior
    ../../modules/home-manager/zoxide
    ../../modules/home-manager/irssi
  ];
  home.username = "mthomson";
  home.homeDirectory = "/home/mthomson";
  home.stateVersion = "23.11";

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [
    firefox
    gcc
    fzf
    ripgrep
    jq
    protonup
    lutris
    pavucontrol
    pasystray
    networkmanagerapplet 
    upower
    acpi
  ];

  programs.home-manager.enable = true;
}
