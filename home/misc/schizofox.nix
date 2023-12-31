{...}: {
  programs.schizofox = {
    enable = true;
    security = {
      wrapWithProxychains = false;
      sandbox = false;
    };
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
    search = rec {
      defaultSearchEngine = "Searx";
      # removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia" "LibRedirect" "DuckDuckGo"];
      searxUrl = "https://search.notashelf.dev";
      searxQuery = "${searxUrl}/search?q={searchTerms}&categories=general";
      # addEngines = [
      #   {
      #     Name = "Searxng";
      #     Description = "Decentralized search engine";
      #     Alias = "sx";
      #     Method = "GET";
      #     URLTemplate = "${searxQuery}";
      #   }
      # ];
    };
  };
}
