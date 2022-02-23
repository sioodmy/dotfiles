{ pkgs, config, builtins, ...}:

{
    programs.firefox = {
        enable = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            decentraleyes
            ublock-origin
            clearurls
            sponsorblock
            darkreader
            h264ify
        ];
        profiles.default = {
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "toolkit.zoomManager.zoomValues" = ".8,.95,1,1.1,1.2";
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "browser.tabs.crashReporting.sendReport" = false;
            "devtools.onboarding.telemetry.logged" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.server" = false;
            "toolkit.telemetry.unified" = false;
            "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "extensions.pocket.enabled" = false;
            "network.dns.disablePrefetch" = false;
            "network.prefetch-next" = false;
            "pdfjs.enableScripting" = false;
            "security.ssl.require_safe_negotiation" = false;
            "identity.fxaccounts.enabled" = false;
            "geo.enabled" = false;
            "privacy.resistFingerprinting" = true;
            "privacy.firstparty.isolate" = true;
            "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:95.0) Gecko/20100101 Firefox/95.0";


          };

        userChrome = builtins.readFile ./userChrome.css;
        };
    };
}
