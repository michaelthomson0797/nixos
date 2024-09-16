{ pkgs, config, ... }:

{
  programs = {
    zk = {
      enable = true;
      settings = {
        notebook = {
          dir = "~/notes";
        };
        extra = {
          author = "Michael Thomson";
        };
        alias = {
          daily = "zk new --no-input \"$ZK_NOTEBOOK_DIR/journal/daily\"";
        };
        group = {
          daily = {
            paths = ["journal/daily"];
            note = {
              filename = "{{format-date now '%Y-%m-%d'}}";
              extension = "md";
              template = "daily.md";
            };
          };
        };
      };
    };
  };
}
