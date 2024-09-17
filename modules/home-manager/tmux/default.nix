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
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -s escape-time 0
      set -g status-left-length 30 # could be any number
      fg="#CBCCC6"
      bg="#212732"
      status_bg="#34455A"
      border_fg="#70748C"
      border_active_fg="#FECB6E"
      status_left_bg="#FFA759"

      set -g status-style "bg=$status_bg,fg=$fg"

      set -g pane-border-style "bg=$bg,fg=$border_fg"
      set -g pane-active-border-style "bg=$bg,fg=$border_active_fg"

      set -g window-status-current-style "fg=$border_active_fg"
      set -g window-status-style "fg=$fg"
      '';
    };
  };
}
