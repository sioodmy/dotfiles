{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.firefox;
in {
  options.modules.programs.firefox = { enable = mkEnableOption "firefox"; };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = with pkgs;
        wrapFirefox firefox-esr-102-unwrapped {
          forceWayland = true;
          nixExtensions = [
            (pkgs.fetchFirefoxAddon {
              name = "ublock-origin";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3989793/ublock_origin-1.44.0.xpi";
              sha256 = "rnYf5AFOMo/e+Di4HUPDDIRCLLgUDM7t8O16fB+OcKo=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "sponsorblock";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3978884/sponsorblock-4.7.1.xpi";
              sha256 = "APXLszXW9A4BnyiovABJncXxu5rGzrZMEorzpqCqABU=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "localcdn-fork-of-decentraleyes";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3985626/localcdn_fork_of_decentraleyes-2.6.32.xpi";
              sha256 = "IPJgB47N9hSKknvS0i3mUaMk3Ki35gGbSyaEdtsGexA=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "ether_metamask";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3987382/ether_metamask-10.18.3.xpi";
              sha256 = "TS472KTMNbY2iWV5G+UA5GChMxEsiCoipab6nGzmh4I=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "nord123";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3692469/nord123-1.1.xpi";
              sha256 = "CAFrUxw8Y7Mg8GXxFb0yalaFahxOPLRC1NFMmYzNcBI=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "clearurls";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3980848/clearurls-1.25.0.xpi";
              sha256 = "lr+DCSgwo0Qnrk8QXc4EIsMG2dlWacDJP05VgEmTQ1w=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "vimium";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3898202/vimium_ff-1.67.1.xpi";
              sha256 = "EnQIAnSOer/48TAUyEXbGCtSZvKA4vniL64K+CeJ/m0=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "save-webp-as-png-or-jpeg";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3919488/save_webp_as_png_or_jpeg-1.2.xpi";
              sha256 = "UO5Br7PQjPViAWjZsjcxih7W408/KfJsVBwVcKakmtI=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "single-file";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3990955/single_file-1.21.21.xpi";
              sha256 = "aLgfonqihTWGPUEhHa93tvnEcrdA3d0s7FRhugX2obE=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "h264ify";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3398929/h264ify-1.1.0.xpi";
              sha256 = "h708SrGiNZwBodhU19uEKLRDFv71sqwJ4ijFMYxXpRU=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "copy-plaintext";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3854095/copy_plaintext-1.13.xpi";
              sha256 = "6cRs2Y41r2iZNJ2Mkvy6FtL/bcMbqLDiETyfRe25eJY=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "fastforwardteam";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3976538/fastforwardteam-0.2039.xpi";
              sha256 = "OHyo3Kn9snO0hzR7YTwV41FfV1HAnC09WyAHgRihyVI=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "don-t-fuck-with-paste";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3630212/don_t_fuck_with_paste-2.7.xpi";
              sha256 = "7xfc734gNKJZgqEG5U0Z4kyfImQ0o5aoCBle8N4CGkA=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "temporary-containers";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3723251/temporary_containers-1.9.2.xpi";
              sha256 = "M0CgjCm+fIO9D+o/wn/eceRgikUy2TIRS0OappDn7cA=";
            })
          ];

          # see https://github.com/mozilla/policy-templates/blob/master/README.md
          extraPolicies = {
            CaptivePortal = false;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DisableFirefoxAccounts = true;
            DisableFormHistory = true;
            DisplayBookmarksToolbar = true;
            BlockAboutConfig = true;
            DontCheckDefaultBrowser = true;
            FirefoxHome = {
              Pocket = false;
              Snippets = false;
            };
            PasswordManagerEnabled = false;
            PromptForDownloadLocation = true;
            UserMessaging = {
              ExtensionRecommendations = false;
              SkipOnboarding = true;
            };
            Bookmarks = [
              # crypto
              {
                Title = "Pancake swap";
                URL = "https://pancakeswap.finance";
                Placement = "menu";
                Folder = "crypto";
              }
              {
                Title = "Binance";
                URL = "https://accounts.binance.com/en/login";
                Placement = "menu";
                Folder = "crypto";
              }
              {
                Title = "TradingView";
                URL = "https://www.tradingview.com/";
                Placement = "menu";
                Folder = "crypto";
              }
              {
                Title = "coin360";
                URL = "https://coin360.com/";
                Placement = "menu";
                Folder = "crypto";
              }
              {
                Title = "Crypto Bubbles";
                URL = "https://cryptobubbles.net/";
                Placement = "menu";
                Folder = "crypto";
              }
              {
                Title = "r/cryptocurrency";
                URL = "https://www.reddit.com/r/CryptoCurrency";
                Placement = "menu";
                Folder = "crypto";
              }

              # social 
              {
                Title = "Discord";
                URL = "https://discord.com/login";
                Placement = "menu";
                Folder = "social";
              }
              {
                Title = "Telegram";
                URL = "https://web.telegram.org";
                Placement = "menu";
                Folder = "social";
              }
              {
                Title = "Youtube";
                URL = "https://www.youtube.com/";
                Placement = "menu";
                Folder = "social";
              }
              {
                Title = "Twitter";
                URL = "https://twitter.com/home";
                Placement = "menu";
                Folder = "social";
              }
              {
                Title = "/g/";
                URL = "https://boards.4channel.org/g/";
                Placement = "menu";
                Folder = "social";
              }
            ];
            Preferences = {
              "browser.newtab.extensionControlled" = false;
              "browser.newtabpage.activity-stream.feeds.topsites" = false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" =
                false;
              "browser.send_pings" = false;
              "browser.urlbar.speculativeConnect.enabled" = false;
              "media.navigator.enabled" = false;
              "network.http.referer.XOriginPolicy" = 0;
              "beacon.enabled" = false;
              "browser.safebrowsing.downloads.remote.enabled" = false;
              "network.IDN_show_punycode" = true;
              "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
              "app.shield.optoutstudies.enabled" = false;
              "dom.security.https_only_mode_ever_enabled" = true;
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "browser.compactmode.show" = true;
              "browser.toolbars.bookmarks.visibility" = "never";
              "geo.enabled" = false;

              # Disable telemetry
              "browser.newtabpage.activity-stream.feeds.telemetry" = false;
              "browser.backspace_action" = 0;
              "browser.ping-centre.telemetry" = false;
              "browser.tabs.crashReporting.sendReport" = false;
              "devtools.onboarding.telemetry.logged" = false;
              "privacy.resistFingerprinting" = false;
              "dom.event.clipboardevents.enabled" = false;
              "dom.battery.enabled" = false;
              "privacy.resistFingerprinting.letterboxing" = false;
              "general.useragent.override" =
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:103.0) Gecko/20100101 Firefox/103.0";
              "privacy.window.maxInnerWidth" = 1800;
              "privacy.window.maxInnerHeight" = 900;
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.unified" = false;
              "toolkit.telemetry.server" = "";

              # Disable Pocket
              "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" =
                false;
              "browser.newtabpage.activity-stream.feeds.section.topstories" =
                false;
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
              "privacy.trackingprotection.fingerprinting.enabled" = true;
              "privacy.trackingprotection.cryptomining.enabled" = true;
              "privacy.trackingprotection.enabled" = true;
              "privacy.clearOnShutdown.history" = true;
              "privacy.clearOnShutdown.formdata" = true;
              "privacy.clearOnShutdown.downloads" = true;
              "browser.urlbar.shortcuts.bookmarks" = false;
              "browser.urlbar.shortcuts.history" = false;
              "browser.urlbar.shortcuts.tabs" = false;
              "browser.urlbar.suggest.bookmark" = false;
              "browser.urlbar.suggest.engines" = false;
              "browser.urlbar.suggest.history" = false;
              "browser.urlbar.suggest.openpage" = false;
              "browser.urlbar.suggest.topsites" = false;
              "browser.uidensity" = 1;
              "media.autoplay.enabled" = false;
              "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";

              "general.smoothScroll.lines.durationMaxMS" = 125;
              "general.smoothScroll.lines.durationMinMS" = 125;
              "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
              "general.smoothScroll.mouseWheel.durationMinMS" = 100;
              "general.smoothScroll.other.durationMaxMS" = 125;
              "general.smoothScroll.other.durationMinMS" = 125;
              "general.smoothScroll.pages.durationMaxMS" = 125;
              "general.smoothScroll.pages.durationMinMS" = 125;
              "mousewheel.system_scroll_override_on_root_content.horizontal.factor" =
                175;
              "mousewheel.system_scroll_override_on_root_content.vertical.factor" =
                175;
              "toolkit.scrollbox.horizontalScrollDistance" = 6;
              "toolkit.scrollbox.verticalScrollDistance" = 2;
              "ui.key.menuAccessKeyFocuses" = false;

              "webgl.disabled" = true;
              "security.dialog_enable_delay" = 1000;
              "privacy.firstparty.isolate" = false;
              "security.identityblock.show_extended_validation" = true;
              "security.tls.version.enable-deprecated" = false;
              "browser.uiCustomization.state" = ''
                {"placements":{"widget-overflow-fixed-list":["nixos_ublock-origin-browser-action","nixos_sponsorblock-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","urlbar-container","customizableui-special-spring2","save-to-pocket-button","nixos_temporary-containers-browser-action","fxa-toolbar-menu-button","nixos_cookie-autodelete-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","nixos_ether_metamask-browser-action","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","nixos_sponsorblock-browser-action","nixos_clearurls-browser-action","nixos_cookie-autodelete-browser-action","nixos_ether_metamask-browser-action","nixos_ublock-origin-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_vimium-browser-action","nixos_copy-plaintext-browser-action","nixos_h264ify-browser-action","nixos_fastforwardteam-browser-action","nixos_single-file-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","nixos_don-t-fuck-with-paste-browser-action","nixos_temporary-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":14}
              '';
            };
            ExtensionSettings = {
              # @ytb  -->  YouTube
              # @gh  -->  GitHub
              # @nix  -->  Nix Package
              # @ghnix  -->  Nix Code in Github
              "github@search" = {
                installation_mode = "force_installed";
                install_url =
                  "https://raw.githubusercontent.com/mlyxshi/FFExtension/main/github-search.xpi";
              };

              "youtube@search" = {
                installation_mode = "force_installed";
                install_url =
                  "https://raw.githubusercontent.com/mlyxshi/FFExtension/main/youtube-search.xpi";
              };

              "nix.package@search" = {
                installation_mode = "force_installed";
                install_url =
                  "https://raw.githubusercontent.com/mlyxshi/FFExtension/main/nix-search.xpi";
              };

              "github.nix@search" = {
                installation_mode = "force_installed";
                install_url =
                  "https://raw.githubusercontent.com/mlyxshi/FFExtension/main/github-nix.xpi";
              };

              # Uninstall all build-in search shortcuts except google <-- my default search engine

              "ebay@search.mozilla.org" = { installation_mode = "blocked"; };

              "amazondotcom@search.mozilla.org" = {
                installation_mode = "blocked";
              };

              "bing@search.mozilla.org" = { installation_mode = "blocked"; };

              "ddg@search.mozilla.org" = { installation_mode = "blocked"; };

              "wikipedia@search.mozilla.org" = {
                installation_mode = "blocked";
              };
            };
          };
        };

      profiles.privacy = {
        settings = { };
        isDefault = true;
        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };
}
