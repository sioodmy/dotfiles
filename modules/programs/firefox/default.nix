{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.firefox;
in {
  options.modules.programs.firefox = { enable = mkEnableOption "firefox"; };

  # Most schizo-privacy friendly firefox configuration 

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = with pkgs;
        wrapFirefox firefox-esr-102-unwrapped {
          forceWayland = true;
          nixExtensions = [
            (fetchFirefoxAddon {
              name = "ublock";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/4003969/ublock_origin-1.44.4.xpi";
              sha256 = "C+VQyaJ8BA0ErXGVTdnppJZ6J9SP+izf6RFxdS4VJoU=";
            })
            (fetchFirefoxAddon {
              name = "catppuccin-frappe-pink";
              url =
                "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_frappe_pink.xpi";
              sha256 = "UMkjWqNUzk72ZlP1roh1e4xlUpfDYrkKidRTIfAem9M=";
            })
            (fetchFirefoxAddon {
              name = "port-authority";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3847035/port_authority-1.1.1.xpi";
              sha256 = "34lEwmBaE6zBYX0+1CiDQmrWyegb6QKH28cqGYTtCIw=";
            })
            (fetchFirefoxAddon {
              name = "dontcare";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/4002797/i_dont_care_about_cookies-3.4.3.xpi";
              sha256 = "B1jga6WbGD55M9qx1ja5t0EDbSTjCealgwJtXRrnR9c=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "sponsor-block";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/4011816/sponsorblock-5.0.7.xpi";
              sha256 = "/XqkOnjPiHJyyNJt6cJnqbiWBbQRj5zh/XwbdfYx6uQ=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "df-yt";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3449086/df_youtube-1.13.504.xpi";
              sha256 = "WxCuNFwv4RUbt2AxNzi5s4YKeBu8VCdulc/tumXyzfM=";
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
              name = "skipredirect";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3920533/skip_redirect-2.3.6.xpi";
              sha256 = "2+iVAkXB9HXFwcbaq4nHm4O6RoBiHJHoDxW+ewm2GK4=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "vimium-ff";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3898202/vimium_ff-1.67.1.xpi";
              sha256 = "EnQIAnSOer/48TAUyEXbGCtSZvKA4vniL64K+CeJ/m0=";
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
            (pkgs.fetchFirefoxAddon {
              name = "4chanx";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/922561/4chanx-1.13.15.10.xpi";
              sha256 = "Ar7X8qYVV+VOdGYQortIqz++ITaJrROk0gAWGnyPTyM=";
            })

            (pkgs.fetchFirefoxAddon {
              name = "fb-container";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/4000006/facebook_container-2.3.4.xpi";
              sha256 = "kBP5Hx5eza/cnrPLdeOhlH1aE7VRxr1qeGJZcukCTWE=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "webarchive";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3894402/view_page_archive-3.1.0.xpi";
              sha256 = "uCdkebx7KszyNLsbRVuUlprN8esgWdgAIKtD6/SJSdQ=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "unstoppable";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3882243/unstoppable_extension-2.2.3.xpi";
              sha256 = "qEAZj82IgV9HW51lbdEg2uyr4kFX9lu+uPMlII7iVMI=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "image-search";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3988785/search_by_image-5.2.0.xpi";
              sha256 = "NAyyKKnvL5UG4xTzs3LEBBuP1FnVxlNAGeHVRtPtWC8=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "buster-captcha";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3997075/buster_captcha_solver-1.3.2.xpi";
              sha256 = "vYsTrrt0N7V6zYmMXwoTJuWvYaxBMWq7yjDAdWNvofc=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "proxy-switcher";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/1056777/switchyomega-2.5.20.xpi";
              sha256 = "Ng2mH5CKAKGQAkHt4g+KP4JnWyNlz984bvo1+yhMyjg=";
            })
            (pkgs.fetchFirefoxAddon {
              name = "clearurls";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3980848/clearurls-1.25.0.xpi";
              sha256 = "lr+DCSgwo0Qnrk8QXc4EIsMG2dlWacDJP05VgEmTQ1w=";
            })
            (fetchFirefoxAddon {
              name = "h264ify";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/3398929/h264ify-1.1.0.xpi";
              sha256 = "h708SrGiNZwBodhU19uEKLRDFv71sqwJ4ijFMYxXpRU=";
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
              "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";
              "browser.uidensity" = 1;
              # normie ass useragnet
              "general.useragent.override" =
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36";

              # remove useless stuff from the bar
              "browser.uiCustomization.state" = ''
                {"placements":{"widget-overflow-fixed-list":["nixos_ublock-origin-browser-action","nixos_sponsorblock-browser-action","nixos_temporary-containers-browser-action","nixos_ublock-browser-action","nixos_ether_metamask-browser-action","screenshot-button","panic-button","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_sponsor-block-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_darkreader-browser-action","bookmarks-menu-button","nixos_df-yt-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring1","urlbar-container","customizableui-special-spring2","save-to-pocket-button","fxa-toolbar-menu-button","nixos_cookie-autodelete-browser-action","nixos_absolute-copy-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","nixos_sponsorblock-browser-action","nixos_clearurls-browser-action","nixos_cookie-autodelete-browser-action","nixos_ether_metamask-browser-action","nixos_ublock-origin-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_vimium-browser-action","nixos_copy-plaintext-browser-action","nixos_h264ify-browser-action","nixos_fastforwardteam-browser-action","nixos_single-file-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","nixos_don-t-fuck-with-paste-browser-action","nixos_temporary-containers-browser-action","nixos_absolute-copy-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_unstoppable-browser-action","nixos_dontcare-browser-action","nixos_skipredirect-browser-action","nixos_ublock-browser-action","nixos_darkreader-browser-action","nixos_fb-container-browser-action","nixos_vimium-ff-browser-action","nixos_df-yt-browser-action","nixos_sponsor-block-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":22}
              '';
              "browser.startup.homepage" = "file://${./startpage.html}";

              # Arkenfox stuff
              # glowies crying rn
              # https://github.com/arkenfox/user.js/wiki/
              "browser.aboutConfig.showWarning" = false;
              "browser.shell.checkDefaultBrowser" = false;
              "browser.startup.page" = 1;
              "browser.newtabpage.enabled" = false;
              "browser.newtabpage.activity-stream.showSponsored" = false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" =
                false;
              "browser.newtabpage.activity-stream.default.sites" = "";
              "geo.provider.use_corelocation" = false;
              "geo.provider.use_gpsd" = false;
              "geo.provider.use_geoclue" = false;
              "geo.enabled" = false;
              "browser.region.network.url" = "";
              "browser.region.update.enabled" = false;
              "intl.accept_languages" = "en-US = en";
              "javascript.use_us_english_locale" = true;
              "extensions.getAddons.showPane" = false;
              "extensions.htmlaboutaddons.recommendations.enabled" = false;
              "browser.discovery.enabled" = false;
              "datareporting.policy.dataSubmissionEnabled" = false;
              "datareporting.healthreport.uploadEnabled" = false;
              "toolkit.telemetry.unified" = false;
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.server" = "data: =";
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
              "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
              "captivedetect.canonicalURL" = "";
              "network.captive-portal-service.enabled" = false;
              "network.connectivity-service.enabled" = false;
              "browser.safebrowsing.downloads.remote.enabled" = false;
              "network.prefetch-next" = false;
              "network.dns.disablePrefetch" = true;
              "network.predictor.enabled" = false;
              "network.predictor.enable-prefetch" = false;
              "network.http.speculative-parallel-limit" = 0;
              "browser.places.speculativeConnect.enabled" = false;
              "network.dns.disableIPv6" = true;
              "network.proxy.socks_remote_dns" = true;
              "network.file.disable_unc_paths" = true;
              "network.gio.supported-protocols" = "";
              "keyword.enabled" = true;
              "browser.fixup.alternate.enabled" = false;
              "browser.search.suggest.enabled" = false;
              "browser.urlbar.suggest.searches" = false;
              "browser.urlbar.speculativeConnect.enabled" = false;
              "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
              "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
              "browser.urlbar.suggest.quicksuggest.sponsored" = false;
              "browser.formfill.enable" = false;
              "signon.autofillForms" = false;
              "signon.formlessCapture.enabled" = false;
              "network.auth.subresource-http-auth-allow" = 1;
              "browser.cache.disk.enable" = false;
              "browser.privatebrowsing.forceMediaMemoryCache" = true;
              "media.memory_cache_max_size" = 65536;
              "browser.sessionstore.privacy_level" = 2;
              "toolkit.winRegisterApplicationRestart" = false;
              "browser.shell.shortcutFavicons" = false;
              "security.ssl.require_safe_negotiation" = true;
              "security.tls.enable_0rtt_data" = false;
              "security.OCSP.enabled" = 1;
              "security.OCSP.require" = true;
              "security.family_safety.mode" = 0;
              "security.cert_pinning.enforcement_level" = 2;
              "security.remote_settings.crlite_filters.enabled" = true;
              "security.pki.crlite_mode" = 2;
              "security.mixed_content.block_display_content" = true;
              "dom.security.https_only_mode" = true;
              "dom.security.https_only_mode_send_http_background_request" =
                false;
              "security.ssl.treat_unsafe_negotiation_as_broken" = true;
              "browser.ssl_override_behavior" = 1;
              "browser.xul.error_pages.expert_bad_cert" = true;
              "network.http.referer.XOriginPolicy" = 0;
              "network.http.referer.XOriginTrimmingPolicy" = 2;
              "privacy.userContext.enabled" = true;
              "privacy.userContext.ui.enabled" = true;
              "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
              "media.peerconnection.ice.default_address_only" = true;
              "media.eme.enabled" = true;
              "dom.disable_beforeunload" = true;
              "dom.disable_window_move_resize" = true;
              "dom.disable_open_during_load" = true;
              "dom.popup_allowed_events" =
                "click dblclick mousedown pointerdown";
              "accessibility.force_disabled" = 1;
              "beacon.enabled" = false;
              "browser.helperApps.deleteTempFileOnExit" = true;
              "browser.pagethumbnails.capturing_disabled" = true;
              "browser.uitour.enabled" = false;
              "browser.uitour.url" = "";
              "devtools.chrome.enabled" = false;
              "devtools.debugger.remote-enabled" = false;
              "middlemouse.contentLoadURL" = false;
              "permissions.manager.defaultsUrl" = "";
              "webchannel.allowObject.urlWhitelist" = "";
              "network.IDN_show_punycode" = true;
              "pdfjs.disabled" = false;
              "pdfjs.enableScripting" = false;
              "network.protocol-handler.external.ms-windows-store" = false;
              "permissions.delegation.enabled" = false;
              "browser.download.useDownloadDir" = false;
              "browser.download.alwaysOpenPanel" = false;
              "browser.download.manager.addToRecentDocs" = false;
              "browser.download.always_ask_before_handling_new_types" = true;
              "extensions.enabledScopes" = 5;
              "extensions.autoDisableScopes" = 15;
              "extensions.postDownloadThirdPartyPrompt" = false;
              "browser.contentblocking.category" = "strict";
              "privacy.partition.serviceWorkers" = true;
              "privacy.partition.always_partition_third_party_non_cookie_storage" =
                true;
              "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" =
                false;
              "privacy.sanitize.sanitizeOnShutdown" = true;
              "privacy.clearOnShutdown.cache" = false;
              "privacy.clearOnShutdown.downloads" = true;
              "privacy.clearOnShutdown.formdata" = true;
              "privacy.clearOnShutdown.history" = true;
              "privacy.clearOnShutdown.sessions" = false;
              "privacy.clearOnShutdown.cookies" = false;
              "privacy.clearOnShutdown.offlineApps" = true;
              "privacy.cpd.cache" = true;
              "privacy.cpd.formdata" = true;
              "privacy.cpd.history" = true;
              "privacy.cpd.sessions" = true;
              "privacy.cpd.offlineApps" = false;
              "privacy.cpd.cookies" = false;
              "privacy.sanitize.timeSpan" = 0;
              "privacy.resistFingerprinting" = true;
              "privacy.window.maxInnerWidth" = 1600;
              "privacy.window.maxInnerHeight" = 900;
              "privacy.resistFingerprinting.block_mozAddonManager" = true;
              "privacy.resistFingerprinting.letterboxing" = true;
              "browser.startup.blankWindow" = false;
              "browser.display.use_system_colors" = false;
              "widget.non-native-theme.enabled" = true;
              "browser.link.open_newwindow" = 3;
              "browser.link.open_newwindow.restriction" = 0;
              "webgl.disabled" = true;
              "extensions.blocklist.enabled" = true;
              "network.http.referer.spoofSource" = false;
              "security.dialog_enable_delay" = 1000;
              "privacy.firstparty.isolate" = false;
              "extensions.webcompat.enable_shims" = true;
              "security.tls.version.enable-deprecated" = false;
              "extensions.webcompat-reporter.enabled" = false;
              "browser.startup.homepage_override.mstone" = "ignore";
              "browser.messaging-system.whatsNewPanel.enabled" = false;
              "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" =
                false;
              "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =
                false;
              "browser.urlbar.suggest.quicksuggest" = false;
              "app.update.background.scheduling.enabled" = false;
              "security.csp.enable" = true;
              "security.ask_for_password" = 2;
              "security.password_lifetime" = 5;
              "dom.storage.next_gen" = true;
              "network.cookie.lifetimePolicy" = 2;
              "security.pki.sha1_enforcement_level" = 1;
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
