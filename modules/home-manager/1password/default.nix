{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    _1password
    _1password-gui
  ];
  
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
}
