{ pkgs, config, ... }:

{
  programs = {
    irssi = {
      enable = true;
      networks = {
        liberachat = {
          nick = "DrDeww";
          server = {
            address = "irc.libera.chat";
            port = 6697;
            autoConnect = false;
          };
        };
      };
    };
  };
}
