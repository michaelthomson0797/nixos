{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/neovim
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
    ../../modules/home-manager/tmux
  ];
  home.username = "mthomson";
  home.homeDirectory = "/Users/mthomson";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    btop
    spotify-player
    tmuxifier
    neofetch
    nodejs
    corepack_latest
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
