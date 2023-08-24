{ ...}: {
  programs.schizofox = {
    enable = true;
    security = {
      sanitizeOnShutdown = false;
      sandbox = true;
      userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };

    theme = {
      background-darker = "181825";
      background = "1e1e2e";
      foreground = "cdd6f4";
      font = "Lexend";
    };

    extensions.extraExtensions = {
      "webextension@metamask.io".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
    };
    search = {
      defaultSearchEngine = "Brave";
    };
  };
}
