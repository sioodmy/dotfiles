{ config, pkgs, theme, ... }:

{
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
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
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

      userChrome = with theme.colors;
        "\n        :root {\n\n        /*---+---+---+---+---+---+---+\n        | C | O | L | O | U | R | S |\n        +---+---+---+---+---+---+---*/\n\n\n        /* Comment this block out if you want to keep the default theme colour. */\n        /* This will also work with custom colours from color.firefox.com. */\n\n        /* Theme Colour Suggestions\n        *                              Dark        Light   */\n        --window-colour:               #${bg}; /* #${fg}; */\n        --secondary-colour:            #${ba}; /* #${fg}; */\n        --inverted-colour:             #${c0}; /* #${bg}; */\n\n\n        /* Containter Tab Colours */\n        --uc-identity-color-blue:      #${c4};\n        --uc-identity-color-turquoise: #${c5};\n        --uc-identity-color-green:     #${c2};\n        --uc-identity-color-yellow:    #${c3};\n        --uc-identity-color-orange:    #${c11};\n        --uc-identity-color-red:       #${c1};\n        --uc-identity-color-pink:      #${c6};\n        --uc-identity-color-purple:    #${c5};\n\n\n        /* URL colour in URL bar suggestions */\n        --urlbar-popup-url-color: var(--uc-identity-color-purple) !important;\n\n\n\n        /*---+---+---+---+---+---+---+\n        | V | I | S | U | A | L | S |\n        +---+---+---+---+---+---+---*/\n\n        /* global border radius */\n        --uc-border-radius: 0;\n\n        /* dynamic url bar width settings */\n        --uc-urlbar-width: clamp(200px, 40vw, 500px);\n\n        /* dynamic tab width settings */\n        --uc-active-tab-width:   clamp(100px, 20vw, 300px);\n        --uc-inactive-tab-width: clamp( 50px, 15vw, 200px);\n\n        /* if active always shows the tab close button */\n        --show-tab-close-button: none; /* DEFAULT: -moz-inline-box; */ \n\n        /* if active only shows the tab close button on hover*/\n        --show-tab-close-button-hover: none; /* DEFAULT: -moz-inline-box; */\n\n        /* adds left and right margin to the container-tabs indicator */\n        --container-tabs-indicator-margin: 10px;\n\n        }\n\n"
        + builtins.readFile ./userChrome.css;
    };
  };
}
