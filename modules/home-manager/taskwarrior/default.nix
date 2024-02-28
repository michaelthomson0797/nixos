{ pkgs, config, ... }:

{
  programs = {
    taskwarrior = {
      enable = true;
    };
  };
}
