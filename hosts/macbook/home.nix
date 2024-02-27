{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/wezterm
  ];
  home.username = "mthomson";
  #home.homeDirectory = "/Users/mthomson";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    hello
    cowsay
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
