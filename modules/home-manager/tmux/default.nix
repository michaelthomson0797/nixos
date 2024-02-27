{ pkgs, config, ... }:

{
  programs = {
    tmux = {
      enable = true;
      shortcut = "Space";
      mouse = true;
      baseIndex = 1;
      tmuxp.enable = true;
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
      ];
      extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -s escape-time 0
      set -g status-left-length 30 # could be any number
      set -g status-style 'bg=#333333 fg=#5eacd3'
      '';
    };
  };
}
