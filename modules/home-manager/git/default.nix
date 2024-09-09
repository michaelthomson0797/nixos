{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Michael Thomson";
    userEmail = "michael@michaelthomson.dev";
    includes = [
      {
        condition = "gitdir:~/dev/work/";
        contents = {
          user = {
            email = "mthomson@konradgroup.com";
            name = "Michael Thomson";
          };
        };
      }
    ];
  };
}
