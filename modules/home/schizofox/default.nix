{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.schizofox;
in {
  options.modules.programs.schizofox = {
    enable =
      mkEnableOption
      "Schizo firefox esr setup with vim bindings, discord screenshare works tho. Inspired by ArkenFox.";
    userAgent = mkOption {
      type = types.str;
      example = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
      default = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
      description = "Spoof user agent";
    };

    netflixCuckFix = mkOption {
      type = types.bool;
      default = false;
      description = "
      Enable drm content for netflix cucks (literally just torrent stuff)";
    };

    translate = {
      enable = mkEnableOption ''
        Enable !t LibreTranslate snippet
      '';
      sourceLang = mkOption {
        type = types.str;
        example = "en";
        description = ''
          Source language used in translation
        '';
      };

      targetLang = mkOption {
        type = types.str;
        example = "pl";
        description = ''
          Target language used in translation
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (wrapFirefox firefox-esr-102-unwrapped {
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
          SearchEngines = {
            Add =
              [
                {
                  Name = "Searx";
                  Description = "Decentralized search engine";
                  Alias = "sx";
                  Method = "GET";
                  URLTemplate = "https://searx.be/?preferences=eJxtV8uO6zYM_ZpmY9yg7V0UXWRVoNsW6N0btMTYHEuirh5JPF9fKrZjOZ7FeEaHMs3nIUdBwp4DYbz06DCAORlwfYYeL2DkwAoMXtCdICdWbL3BhJeeuTd4Iiv3Wh_4MV1-hIwni2lgffn3n_9-nCJcMSIENVx-PaUBLV4ilfdPAWM2KbbsWof3NkF3-RtMxJNmakXI5obhwiDHM4f-xFFB-BbTJJYY7kmxxts3DWE8zRrbWfZEFLqEoQVDvZU_F82gb-AU6naxaEZ_ZgxTS65NlOT9pwvkruQoiU4V2JgZ1BShM_I6up6cBOvPHvq2jawITGNRE_zy-1_gx8ZSCBza9koG4xMT-xp5NjFxwEogZtANG4ptu4T-iSZSbfsMbLnVketreTk3s_TtVnMjjSzo_PuJpi6rEZPcTHJWSn1Lt-oCe3QS6YiVKnE6xoBXcU4RSsgEm9DXNqgcDGGNaMRPiXlrcyT1PN8IXBJnKs1a943GZ3CJ3c5rDHwn3bYsZRLkfKeRNCTYfUNcKT89f40eo1LJ7ghF9faFOS0WvLwgz2KD5Q_yJZPbrd8elbqrDlyMXBN4NaTGUF8IiE3ka7pDwEZTQCUpn5boXwO5kaBObk-9VBXEVHvUSylCt6ZMKr3D0C_Hue2OmV5wb2AqpRY3I2uJ5Rvh7jXPWtd5G6ALUB7L98jqbosGOahe_qA48CYcJRgQqy8bEl1haopnkb4Q8LVR7Hrp9zpphruY8BziYgJ8mimQipuRwjGgPLjlgkO87QrFebuKJoDtu6XaA3quTPEgRvcU1w7xuTtL7S6nn3ep4VrzEzjW2QwfkhLRE8x0s0MLUPLalMerOMBCCcwKRLSilFQT1cAGQt2OsTSWL8xb2ZZ4nDix5GQsoVk9THdKhQ7fqSq7KDURh8qNCQbe9dbEOeUOK-NfyKvRgcxkuTR0de1GFrk636mbasUWgrCo-LvLm8yZBzgd9mihgo55jO-gTA7BynMBfmZO-H4rcg7qgBbSozQdYJ7eoqpJpU92O-y379__eGwR1lmj2_og4qcDu_OWPxDHXYXCraRkA0Luph7tWvMeMbxF_pk3-cQoLXy_Y1eJQrYymupw84NGdlLJTZwcu8liZd-HP_u723OtFVLeTZkgFtaAl54zay1_CR_bohbukiV1vvX3nKAhp43iXl84odtP3acuQy4_mmL2ShHhQbe6QTopIwXWb3Vabi_c_jZLd5Z1SVPfb7mVSRdE565QNMtIDc2QV45OYtq0ixYm6QkndlZxFynlisXknIqrs9OUNn0zZe9Gwkzihwgv-M6FBfuCNoZF78zsTsqFONeEVWGrleJDv2dXSw9lOOuKj0HmGq4jo7AsyOgr4zuiLHmVBatMaFZmJyxrwF4ek0zRJCN5nctel0bYLvlBaM69pBRkg-1gqkg9d9Itu1cmTzWn7yMmtmpKB4aUwpQq2rsqzKtGlua9Gr6v1RfH3GWX8lrQ2WPI8RUQ2WZJyx4ghZSq0fNk2-adxEpIoKwMr-5kM88GP1R7iZWWtrJaNCmAi0YiUC9PHLSjsQJSCmdaW37bZb3J0lbxUnr0cV5O57Lna9nxVVp25Xb9h2CZXttVhnbe2O9BFuaDOKK5ynJ95YNEwtGqAdV4kMjoaCXBI07x1f1f2zmU6TUfDloGjklYGMU0mXLqK9OenkkdqfkfoEmcNeLz0dQApd9b2XlFmy3JP8mslUK9_A8SUQFD&q={searchTerms}";
                }
                {
                  Name = "Sourcegraph/Nix";
                  Description = "Sourcegraph nix search";
                  Alias = "!snix";
                  Method = "GET";
                  URLTemplate = "https://sourcegraph.com/search?q=context:global+file:.nix%24+{searchTerms}&patternType=literal";
                }
                {
                  Name = "Torrent search";
                  Description = "Searching for legal linux isos ";
                  # feds go away
                  Alias = "!torrent";
                  Method = "GET";
                  URLTemplate = "https://librex.beparanoid.de/search.php?q={searchTerms}&t=3&p=0";
                }
                {
                  Name = "Etherscan";
                  Description = "Checking balances";
                  Alias = "!eth";
                  Method = "GET";
                  URLTemplate = "https://etherscan.io/search?f=0&q={searchTerms}";
                }
                {
                  Name = "Stackoverflow";
                  Description = "Stealing code";
                  Alias = "!so";
                  Method = "GET";
                  URLTemplate = "https://stackoverflow.com/search?q={searchTerms}";
                }
                {
                  Name = "Wikipedia";
                  Description = "Wikiless";
                  Alias = "!wiki";
                  Method = "GET";
                  URLTemplate = "https://wikiless.org/w/index.php?search={searchTerms}title=Special%3ASearch&profile=default&fulltext=1";
                }
                {
                  Name = "Crates.io";
                  Description = "Rust crates";
                  Alias = "crates";
                  Method = "GET";
                  URLTemplate = "https://crates.io/search?q={searchTerms}";
                }
                {
                  Name = "nixpkgs";
                  Description = "Nixpkgs query";
                  Alias = "!nix";
                  Method = "GET";
                  URLTemplate = "https://search.nixos.org/packages?&query={searchTerms}";
                }
                {
                  Name = "Librex";
                  Description = "A privacy respecting free as in freedom meta search engine for Google and popular torrent sites ";
                  Alias = "!librex";
                  Method = "GET";
                  URLTemplate = "https://librex.beparanoid.de/search.php?q={searchTerms}&p=0&t=0";
                }
              ]
              ++ lib.optionals cfg.translate.enable [
                {
                  Name = "Deepl";
                  Description = "Translator";
                  Alias = "!t";
                  Method = "GET";
                  URLTemplate = "https://www.deepl.com/pl/translator#${cfg.translate.sourceLang}/${cfg.translate.targetLang}/{searchTerms}%0A";
                }
              ];
            Default = "Searx";
            Remove = [
              "Google"
              "Bing"
              "Amazon.com"
              "eBay"
              "Twitter"
              "DuckDuckGo"
              "Wikipedia"
            ];
          };

          ExtensionSettings = let
            mkForceInstalled = extensions:
              builtins.mapAttrs
              (name: cfg: {installation_mode = "force_installed";} // cfg)
              extensions;
          in
            mkForceInstalled {
              "addon@darkreader.org".install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              "uBlock0@raymondhill.net".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              "{36bdf805-c6f2-4f41-94d2-9b646342c1dc}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/export-cookies-txt/latest.xpi";
              "{74145f27-f039-47ce-a470-a662b129930a}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
              "{b86e4813-687a-43e6-ab65-0bde4ab75758}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
              "DontFuckWithPaste@raim.ist".install_url = "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
              "{531906d3-e22f-4a6c-a102-8057b88a1a63}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/single-file/latest.xpi";
              "{c607c8df-14a7-4f28-894f-29e8722976af}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/temporary-containers/latest.xpi";
              "skipredirect@sblask".install_url = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
              "{b6129aa9-e45d-4280-aac8-3654e9d89d21}".install_url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_frappe_pink.xpi";
              "smart-referer@meh.paranoid.pk".install_url = "https://github.com/catppuccin/firefox/releases/download/old/smart-referer.xpi";
            };

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

          SanitizeOnShutdown = {
            Cache = true;
            History = true;
            Cookies = true;
            Downloads = true;
            FormData = true;
            Sessions = true;
            OfflineApps = true;
          };

          Preferences = {
            "browser.toolbars.bookmarks.visibility" = "never";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";
            "browser.uidensity" = 1;
            "general.useragent.override" = cfg.userAgent;

            # remove useless stuff from the bar
            "browser.uiCustomization.state" = ''
              {"placements":{"widget-overflow-fixed-list":["nixos_ublock-origin-browser-action","nixos_sponsorblock-browser-action","nixos_temporary-containers-browser-action","nixos_ublock-browser-action","nixos_ether_metamask-browser-action","nixos_cookie-autodelete-browser-action","screenshot-button","panic-button","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_sponsor-block-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_darkreader-browser-action","bookmarks-menu-button","nixos_df-yt-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","sponsorblocker_ajay_app-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","dontfuckwithpaste_raim_ist-browser-action","ryan_unstoppabledomains_com-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","save-to-pocket-button","fxa-toolbar-menu-button","nixos_absolute-copy-browser-action","webextension_metamask_io-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","nixos_sponsorblock-browser-action","nixos_clearurls-browser-action","nixos_cookie-autodelete-browser-action","nixos_ether_metamask-browser-action","nixos_ublock-origin-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_vimium-browser-action","nixos_copy-plaintext-browser-action","nixos_h264ify-browser-action","nixos_fastforwardteam-browser-action","nixos_single-file-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","nixos_don-t-fuck-with-paste-browser-action","nixos_temporary-containers-browser-action","nixos_absolute-copy-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_unstoppable-browser-action","nixos_dontcare-browser-action","nixos_skipredirect-browser-action","nixos_ublock-browser-action","nixos_darkreader-browser-action","nixos_fb-container-browser-action","nixos_vimium-ff-browser-action","nixos_df-yt-browser-action","nixos_sponsor-block-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","dontfuckwithpaste_raim_ist-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","ryan_unstoppabledomains_com-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","webextension_metamask_io-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action","sponsorblocker_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":29}
            '';
            "browser.startup.homepage" = "file://${./startpage.html}";

            # Arkenfox stuff
            # glowies crying rn
            # https://github.com/arkenfox/user.js/wiki/
            "browser.aboutConfig.showWarning" = false;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.startup.page" = 1;
            "browser.sessionstore.enabled" = false;
            "browser.sessionstore.resume_from_crash" = false;
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
            "reader.parse-on-load.enabled" = false;
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
            "browser.urlbar.unifiedcomplete" = false;
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
            "media.eme.enabled" = cfg.netflixCuckFix;
            "dom.disable_beforeunload" = true;
            "dom.disable_window_move_resize" = true;
            "dom.disable_open_during_load" = true;
            "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
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
            "pdfjs.disabled" = true;
            "dom.webnotifications.serviceworker.enabled" = false;
            "dom.webnotifications.enabled" = false;
            "dom.ipc.plugins.flash.subprocess.crashreporter.enabled" = false;
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
            "privacy.cpd.cache" = true;
            "privacy.cpd.formdata" = true;
            "privacy.cpd.history" = true;
            "privacy.cpd.sessions" = true;
            "privacy.cpd.offlineApps" = false;
            "privacy.cpd.cookies" = false;
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
            "webgl.disabled" = false;
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
            "network.cookie.lifetimePolicy" = 0;
            "security.pki.sha1_enforcement_level" = 1;
          };
        };
      })
    ];
  };
}
