{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/neovim
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
  ];
  home.username = "mthomson";
  home.homeDirectory = "/Users/mthomson";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    btop
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
