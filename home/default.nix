{ config, pkgs, ... }:

{
  imports = [
    ./i3
    ./wezterm
    ./nvim
  ];
  home.username = "mthomson";
  home.homeDirectory = "/home/mthomson";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    cowsay
    firefox
    _1password-gui
    gcc
    fzf
    nodejs
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
