{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    w3m
    mailcap
  ];

  home.file.".mailcap".source = ./mailcap;

  programs = {
    neomutt = {
      enable = true;
      sort = "reverse-date";
      sidebar = {
        enable = true;
      };
      binds = [
        {
          map = [ "index" "pager" ];
          key = "B";
          action = "sidebar-toggle-visible";
        }
        {
          map = [ "index" "pager" ];
          key = "\\CN";
          action = "sidebar-next";
        }
        {
          map = [ "index" "pager" ];
          key = "\\CP";
          action = "sidebar-prev";
        }
        {
          map = [ "index" "pager" ];
          key = "\\CO";
          action = "sidebar-open";
        }
      ];
      extraConfig = ''
      color normal		  default default         # Text is "Text"
      color index		    color2 default ~N       # New Messages are Green
      color index		    color1 default ~F       # Flagged messages are Red
      color index		    color13 default ~T      # Tagged Messages are Red
      color index		    color1 default ~D       # Messages to delete are Red
      color attachment	color5 default          # Attachments are Pink
      color signature	  color8 default          # Signatures are Surface 2
      color search		  color4 default          # Highlighted results are Blue

      color indicator		default color8          # currently highlighted message Surface 2=Background Text=Foreground
      color error		    color1 default          # error messages are Red
      color status		  color15 default         # status line "Subtext 0"
      color tree        color15 default         # thread tree arrows Subtext 0
      color tilde       color15 default         # blank line padding Subtext 0

      color hdrdefault  color13 default         # default headers Pink
      color header		  color13 default "^From:"
      color header	 	  color13 default "^Subject:"

      color quoted		  color15 default         # Subtext 0
      color quoted1		  color7 default          # Subtext 1
      color quoted2		  color8 default          # Surface 2
      color quoted3		  color0 default          # Surface 1
      color quoted4		  color0 default
      color quoted5		  color0 default

      color body		color2 default		[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+               # email addresses Green
      color body	  color2 default		(https?|ftp)://[\-\.,/%~_:?&=\#a-zA-Z0-9]+        # URLs Green
      color body		color4 default		(^|[[:space:]])\\*[^[:space:]]+\\*([[:space:]]|$) # *bold* text Blue
      color body		color4 default		(^|[[:space:]])_[^[:space:]]+_([[:space:]]|$)     # _underlined_ text Blue
      color body		color4 default		(^|[[:space:]])/[^[:space:]]+/([[:space:]]|$)     # /italic/ text Blue

      color sidebar_flagged   color1 default    # Mailboxes with flagged mails are Red
      color sidebar_new       color10 default   # Mailboxes with new mail are Green
      '';
    };
    msmtp = {
      enable = true;
    };
    mbsync = {
      enable = true;
    };
    password-store = {
      enable = true;
    };
  };

  accounts.email = {
    accounts.michaelthomson = {
      primary = true;
      address = "michael@michaelthomson.dev";
      realName = "Michael Thomson";
      userName = "michael@michaelthomson.dev";
      passwordCommand = "op read \"op://Personal/SES SMTP/password\"";
      neomutt = {
        enable = true;
        extraMailboxes = [ "Drafts" "Sent" "Trash" "Junk" ];
      };
      mbsync = {
        enable = true;
        create = "maildir";
      };
      imap = {
        host = "mail.michaelthomson.dev";
        port = 993;
        tls = {
          enable = true;
        };
      };
      msmtp = {
        enable = true;
      };
      smtp = {
        host = "mail.michaelthomson.dev";
        port = 465;
        tls = {
          enable = true;
        };
      };
    };
  };
}
