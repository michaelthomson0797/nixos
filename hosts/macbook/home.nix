{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/git
    ../../modules/home-manager/neovim
    ../../modules/home-manager/emacs
    ../../modules/home-manager/wezterm
    ../../modules/home-manager/zsh
    ../../modules/home-manager/tmux
    ../../modules/home-manager/zoxide
    ../../modules/home-manager/irssi
    ../../modules/home-manager/email
    ../../modules/home-manager/zk
    ../../modules/home-manager/password-store
  ];
  home.username = "mthomson";
  home.homeDirectory = "/Users/mthomson";
  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    spotify-player = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    btop
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
    keepassxc
    luajit
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
