{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/neovim
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
    ../../modules/home-manager/tmux
    ../../modules/home-manager/taskwarrior
  ];
  home.username = "mthomson";
  home.homeDirectory = "/Users/mthomson";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    btop
    spotify-player
    neofetch
    jq
    fzf
    ripgrep
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
