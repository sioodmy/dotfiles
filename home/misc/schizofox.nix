{...}: {
  programs.schizofox = {
    enable = true;
    theme = {
      background-darker = "181825";
      background = "1e1e2e";
      foreground = "cdd6f4";
      font = "Lexend";
      simplefox.enable = true;
      darkreader.enable = true;
    };
    search.searxRandomizer.enable = true;

    extensions.extraExtensions = {
      "webextension@metamask.io".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
    };
  };
}
