{...}: {
  programs.schizofox = {
    enable = true;
    theme = {
      colors = {
        background-darker = "181825";
        background = "1e1e2e";
        foreground = "cdd6f4";
        primary = "f5c2e7";
      };
      font = "Lexend";
    };
    extensions = {
      simplefox.enable = true;
      darkreader.enable = true;
      extraExtensions = {
        "webextension@metamask.io".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
      };
    };
    search = {
      searxUrl = "search.notashelf.dev";
      defaultSearchEngine = "Searx";
    };

  };
}
