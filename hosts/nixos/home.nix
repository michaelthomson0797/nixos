{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/i3
    ../../modules/home-manager/neovim
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
    ../../modules/home-manager/tmux
    ../../modules/home-manager/taskwarrior
    ../../modules/home-manager/zoxide
    ../../modules/home-manager/eza
    ../../modules/home-manager/bat
    ../../modules/home-manager/irssi
  ];
  home.username = "mthomson";
  home.homeDirectory = "/home/mthomson";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    firefox
    _1password-gui
    gcc
    fzf
    ripgrep
    jq
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
