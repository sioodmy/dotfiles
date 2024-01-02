{
  pkgs,
  lib,
  config,
  ...
}: let
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';
  browser = ["schizofox.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["imv.desktop"];
    "application/json" = browser;
    "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
  };
in {
  imports = [./run-as-service.nix];
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    file = {
      ".local/bin/updoot" = {
        # Upload and get link
        executable = true;
        text = import ./updoot.nix {inherit lib pkgs;};
      };

      ".local/bin/preview" = {
        # Preview script for fzf tab
        executable = true;
        text = import ./preview.nix {inherit lib pkgs;};
      };

      ".local/bin/extract" = {
        # Extract the compressed file with the correct tool based on the extension
        executable = true;
        text = import ./extract.nix {inherit lib pkgs;};
      };

      ".local/bin/compilec" = {
        executable = true;
        text = import ./compilec.nix {};
      };
    };

    packages = [ocrScript];
  };
  services = {
    udiskie.enable = true;
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSshSupport = true;
      enableZshIntegration = true;
    };
  };
  programs = {
    gpg.enable = true;
    man.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "catppuccin-mocha";
      };
      themes = {
        catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "Catppuccin-mocha.tmTheme";
        };
      };
    };
  };
  xdg = {
    userDirs = {
      enable = true;
      documents = "$HOME/other";
      download = "$HOME/download";
      videos = "$HOME/vids";
      music = "$HOME/music";
      pictures = "$HOME/pics";
      desktop = "$HOME/other";
      publicShare = "$HOME/other";
      templates = "$HOME/other";
    };
    mimeApps.enable = true;
    mimeApps.associations.added = associations;
    mimeApps.defaultApplications = associations;
  };
}
