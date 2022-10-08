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
            (fetchFirefoxAddon {
              name = "ublock"; # Has to be unique!
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3679754/ublock_origin-1.31.0-an+fx.xpi";
              sha256 = "1h768ljlh3pi23l27qp961v1hd0nbj2vasgy11bmcrlqp40zgvnr";
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
                URL = "https://www.tradingview.com/chart/rwZ5GJdv/";
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
                Title = "g/";
                URL = "https://boards.4channel.org/g/";
                Placement = "menu";
                Folder = "social";
              }
              {
                Title = "Netflix";
                URL = "https://netflix.com";
                Placement = "menu";
                Folder = "social";
              }

              # Code
              {
                Title = "Github";
                URL = "https://github.com/";
                Placement = "menu";
                Folder = "code";
              }
            ];
            Preferences = {
              "browser.toolbars.bookmarks.visibility" = "never";
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "browser.uiCustomization.state" = ''
                {"placements":{"widget-overflow-fixed-list":["nixos_ublock-origin-browser-action","nixos_sponsorblock-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","urlbar-container","customizableui-special-spring2","save-to-pocket-button","nixos_temporary-containers-browser-action","fxa-toolbar-menu-button","nixos_cookie-autodelete-browser-action","nixos_absolute-copy-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","nixos_ether_metamask-browser-action","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","nixos_sponsorblock-browser-action","nixos_clearurls-browser-action","nixos_cookie-autodelete-browser-action","nixos_ether_metamask-browser-action","nixos_ublock-origin-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_vimium-browser-action","nixos_copy-plaintext-browser-action","nixos_h264ify-browser-action","nixos_fastforwardteam-browser-action","nixos_single-file-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","nixos_don-t-fuck-with-paste-browser-action","nixos_temporary-containers-browser-action","nixos_absolute-copy-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_unstoppable-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":15}
              '';

              "browser.shell.checkDefaultBrowser" = false;
              "browser.startup.page" = "0";
              "browser.startup.homepage" = "about:blank";
              "browser.newtabpage.enabled" = false;
              "browser.newtabpage.activity-stream.showSponsored" = false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" =
                false;
              "browser.newtabpage.activity-stream.default.sites" = "";
              "browser.search.region" = "US";
              "intl.accept_languages" = "en-US, en, pl";
              "javascript.use_us_english_locale" = true;
              "extensions.getAddons.showPane" = false;
              "extensions.htmlaboutaddons.recommendations.enabled" = false;
              "browser.discovery.enabled" = false;
              "datareporting.policy.dataSubmissionEnabled" = false;
              "datareporting.healthreport.uploadEnabled" = false;
              "toolkit.telemetry.unified" = false;
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.server" = "data:,";
              "toolkit.telemetry.archive.enabled" = false;
              "toolkit.telemetry.newProfilePing.enabled" = false;
              "toolkit.telemetry.shutdownPingSender.enabled" = false;
              "toolkit.telemetry.updatePing.enabled" = false;
              "toolkit.telemetry.bhrPing.enabled" = false;
              "toolkit.telemetry.firstShutdownPing.enabled" = false;
              "toolkit.telemetry.coverage.opt-out" = true;
              "toolkit.coverage.opt-out" = true;
              "toolkit.coverage.endpoint.base" = "";
              "browser.ping-centre.telemetry" = false;
              "browser.newtabpage.activity-stream.feeds.telemetry" = false;
              "browser.newtabpage.activity-stream.telemetry" = false;
              "app.shield.optoutstudies.enabled" = false;
              "app.normandy.enabled" = false;
              "app.normandy.api_url" = "";
              "breakpad.reportURL" = "";
              "browser.tabs.crashReporting.sendReport" = false;
              "browser.crashReports.unsubmittedCheck.enabled" = false;
              "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
              "captivedetect.canonicalURL" = "";
              "network.captive-portal-service.enabled" = false;
              "network.connectivity-service.enabled" = false;
              "browser.safebrowsing.malware.enabled" = false;
              "browser.safebrowsing.phishing.enabled" = false;
              "browser.safebrowsing.downloads.enabled" = false;
              "browser.safebrowsing.downloads.remote.enabled" = false;
              "browser.safebrowsing.downloads.remote.url" = "";
              "browser.safebrowsing.downloads.remote.block_potentially_unwanted" =
                false;
              "browser.safebrowsing.downloads.remote.block_uncommon" = false;
              "browser.safebrowsing.allowOverride" = false;
              "network.prefetch-next" = false;
              "network.dns.disablePrefetch" = true;
              "network.dns.disablePrefetchFromHTTPS" = true;
              "network.predictor.enabled" = false;
              "network.predictor.enable-prefetch" = false;
              "network.http.speculative-parallel-limit" = "0";
              "browser.places.speculativeConnect.enabled" = false;
              "browser.send_pings" = false;
              "network.dns.disableIPv6" = true;
              "network.proxy.socks_remote_dns" = true;
              "network.file.disable_unc_paths" = true;
              "network.gio.supported-protocols" = "";
              "network.proxy.failover_direct" = false;
              "network.proxy.allow_bypass" = false;
              "network.trr.mode" = "5";
              "keyword.enabled" = false;
              "browser.fixup.alternate.enabled" = false;
              "browser.search.suggest.enabled" = false;
              "browser.urlbar.suggest.searches" = false;
              "browser.urlbar.speculativeConnect.enabled" = false;
              "browser.urlbar.dnsResolveSingleWordsAfterSearch" = "0";
              "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
              "browser.urlbar.suggest.quicksuggest.sponsored" = false;
              "browser.urlbar.suggest.engines" = false;
              "browser.formfill.enable" = false;
              "layout.css.visited_links_enabled" = false;
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
