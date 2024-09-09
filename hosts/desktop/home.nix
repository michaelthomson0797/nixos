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
    ../../modules/home-manager/syncthing
    ../../modules/home-manager/email
    ../../modules/home-manager/password-store
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
    mangohud
    kubectl
    k9s
    kubeseal
    velero
    fluxcd
    zoom-us
    crawl
    obsidian
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.home-manager.enable = true;
}
