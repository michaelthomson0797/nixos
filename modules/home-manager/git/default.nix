{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Michael Thomson";
    userEmail = "michael@michaelthomson.dev";
  };
}
