{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/neovim
    ../../modules/home-manager/emacs
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
    ../../modules/home-manager/tmux
    ../../modules/home-manager/zoxide
    ../../modules/home-manager/eza ../../modules/home-manager/bat
    ../../modules/home-manager/irssi
    ../../modules/home-manager/email
  ];
  home.username = "mthomson";
  home.homeDirectory = "/Users/mthomson";
  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    ZK_NOTEBOOK_DIR = "notes";
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs; [
    btop
    spotify
    spotify-player
    neofetch
    jq
    tldr
    cowsay
    lazygit
    k9s
    tintin
    nb
    w3m
    kubectl
    k9s
    kubeseal
    velero
    fluxcd
    wireguard-tools
    kompose
    inetutils
    taskwarrior3
    taskwarrior-tui
    devenv
    _1password
    calcurse
    glow
    gcc
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
