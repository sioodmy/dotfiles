{pkgs, ...}: {
  programs.schizofox = {
    enable = false;
    package = pkgs.firefox-esr-115-unwrapped;
    security = {
      sanitizeOnShutdown = false;
      sandbox = true;
      userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };

    theme = {
      background-darker = "181825";
      background = "1e1e2e";
      foreground = "cdd6f4";
      darkTheme = true;
      font = "Lexend";
      wavefox = {
        enable = true;
        transparency = "High";
        tabs = {
          oneline = "NavBarFirst";
          shadowSaturation = "High";
        };
        menu.density = "Compact";
      };
      darkreader.enable = true;
    };
    search = {
      searx-randomizer = {
        enable = true;
        instances = ["searx.be" "search.notashelf.dev" "searx.tiekoetter.com" "opnxng.com"];
      };
      defaultSearchEngine = "Searx";
      removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
    };
    extensions.extraExtensions = {
      "webextension@metamask.io".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
    };
  };
}
