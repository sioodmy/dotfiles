{pkgs, ...}: {
  programs.schizofox = {
    enable = true;
    package = pkgs.firefox-esr-115-unwrapped;
    security = {
      sanitizeOnShutdown = false;
      sandbox = false;
      userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };

    theme = {
      background-darker = "181825";
      background = "1e1e2e";
      foreground = "cdd6f4";
      font = "Lexend";
      simplefox.enable = true;
      darkreader.enable = true;
    };

    extensions.extraExtensions = {
      "webextension@metamask.io".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
    };
    search = {
      defaultSearchEngine = "Google";
      removeEngines = [ "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
         addEngines = [
      {
        Name = "LibreY";
        Description = "femboy search :3";
        Alias = "!ly";
        Method = "GET";
        URLTemplate = "https://search.ahwx.org/search.php?q={searchTerms}&p=0&t=0";
      }
    ];
    };
  };
}
