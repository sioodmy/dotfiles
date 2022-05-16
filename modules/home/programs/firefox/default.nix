{ config, lib, pkgs, theme, ... }:
with lib;
let cfg = config.modules.programs.firefox;
in {
  options.modules.programs.firefox = { enable = mkEnableOption "firefox"; };

  config = mkIf cfg.enable {
    home.file.".mozilla/firefox/sioodmy/chrome/left-arrow.svg".source = ./left-arrow.svg;
    home.file.".mozilla/firefox/sioodmy/chrome/right-arrow.svg".source = ./right-arrow.svg;
    home.file.".mozilla/firefox/sioodmy/chrome/add.svg".source = ./add.svg;

    programs.firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        sponsorblock
        h264ify
        darkreader
        vimium
      ];
      profiles.sioodmy = {
        settings = {
          "browser.send_pings" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "dom.event.clipboardevents.enabled" = true;
          "media.navigator.enabled" = false;
          #        "network.cookie.cookieBehavior" = 1;
          "network.http.referer.XOriginPolicy" = 2;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "beacon.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "network.IDN_show_punycode" = true;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "app.shield.optoutstudies.enabled" = false;
          "dom.security.https_only_mode_ever_enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.toolbars.bookmarks.visibility" = "never";
          "geo.enabled" = false;

          # Disable telemetry
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.server" = "";

          # Disable Pocket
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" =
            false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" =
            false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "extensions.pocket.enabled" = false;

          # Disable prefetching
          "network.dns.disablePrefetch" = true;
          "network.prefetch-next" = false;

          # Disable JS in PDFs
          "pdfjs.enableScripting" = false;

          # Harden SSL 
          "security.ssl.require_safe_negotiation" = true;

          # Extra
          "identity.fxaccounts.enabled" = false;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.shortcuts.history" = false;
          "browser.urlbar.shortcuts.tabs" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.uidensity" = 1;
          "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";

          "privacy.firstparty.isolate" = true;
          "network.http.sendRefererHeader" = 0;
        };

        userChrome = builtins.readFile ./userChrome.css;
        userContent = builtins.readFile ./userContent.css;
      };
    };
  };
}
