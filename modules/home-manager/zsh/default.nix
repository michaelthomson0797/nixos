{ pkgs, config, ... }:

{

  home.sessionVariables = {
    ZK_NOTEBOOK_DIR = "\${HOME}/notes";
  };

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = false;
      };
      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-history-substring-search"
        ];
      };
      shellAliases = {
        cd = "z";
        cdi = "zi";
      };
      initExtra = ''
        . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
      '';
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
