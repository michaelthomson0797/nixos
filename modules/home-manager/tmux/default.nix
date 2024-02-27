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
    };
  };
}
