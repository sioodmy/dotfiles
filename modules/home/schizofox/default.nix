{
  config,
  lib,
  pkgs,
  ...
}: {
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
        DisplayBookmarksToolbar = false;
        DontCheckDefaultBrowser = true;
        SearchEngines = {
          Add = [
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
              Alias = "!rs";
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
              Name = "youtube";
              Description = "not really";
              Alias = "!yt";
              Method = "GET";
              URLTemplate = "https://yt.femboy.hu/search?q={searchTerms}";
            }
            {
              Name = "Librex";
              Description = "A privacy respecting free as in freedom meta search engine for Google and popular torrent sites ";
              Alias = "!librex";
              Method = "GET";
              URLTemplate = "https://librex.beparanoid.de/search.php?q={searchTerms}&p=0&t=0";
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
          mkForceInstalled =
            builtins.mapAttrs
            (name: cfg: {installation_mode = "force_installed";} // cfg);
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
            "{0a2d1098-69a9-4e98-a62c-a861766ac24d}".install_url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_mocha_pink.xpi";
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
          # "general.useragent.override" = cfg.userAgent;

          # remove useless stuff from the bar
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":["nixos_ublock-origin-browser-action","nixos_sponsorblock-browser-action","nixos_temporary-containers-browser-action","nixos_ublock-browser-action","nixos_ether_metamask-browser-action","nixos_cookie-autodelete-browser-action","screenshot-button","panic-button","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_sponsor-block-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_darkreader-browser-action","bookmarks-menu-button","nixos_df-yt-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","sponsorblocker_ajay_app-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","dontfuckwithpaste_raim_ist-browser-action","ryan_unstoppabledomains_com-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","save-to-pocket-button","fxa-toolbar-menu-button","nixos_absolute-copy-browser-action","webextension_metamask_io-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","nixos_sponsorblock-browser-action","nixos_clearurls-browser-action","nixos_cookie-autodelete-browser-action","nixos_ether_metamask-browser-action","nixos_ublock-origin-browser-action","nixos_localcdn-fork-of-decentraleyes-browser-action","nixos_vimium-browser-action","nixos_copy-plaintext-browser-action","nixos_h264ify-browser-action","nixos_fastforwardteam-browser-action","nixos_single-file-browser-action","treestyletab_piro_sakura_ne_jp-browser-action","nixos_don-t-fuck-with-paste-browser-action","nixos_temporary-containers-browser-action","nixos_absolute-copy-browser-action","nixos_image-search-browser-action","nixos_webarchive-browser-action","nixos_unstoppable-browser-action","nixos_dontcare-browser-action","nixos_skipredirect-browser-action","nixos_ublock-browser-action","nixos_darkreader-browser-action","nixos_fb-container-browser-action","nixos_vimium-ff-browser-action","nixos_df-yt-browser-action","nixos_sponsor-block-browser-action","nixos_proxy-switcher-browser-action","nixos_port-authority-browser-action","nixos_i-hate-usa-browser-action","nixos_qr-browser-action","dontfuckwithpaste_raim_ist-browser-action","jid1-om7ejgwa1u8akg_jetpack-browser-action","ryan_unstoppabledomains_com-browser-action","_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_ffd50a6d-1702-4d87-83c3-ec468f67de6a_-browser-action","7esoorv3_alefvanoon_anonaddy_me-browser-action","addon_darkreader_org-browser-action","cookieautodelete_kennydo_com-browser-action","skipredirect_sblask-browser-action","ublock0_raymondhill_net-browser-action","_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action","webextension_metamask_io-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","_c607c8df-14a7-4f28-894f-29e8722976af_-browser-action","sponsorblocker_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":29}
          '';

          # glowies crying rn
          "privacy.webrtc.legacyGlobalIndicator" = false;
          "http://127.0.0.1/" = "http://127.0.0.1/";
          "app.vendorURL" = "http://127.0.0.1/";
          "app.privacyURL" = "http://127.0.0.1/";
          "plugins.hide_infobar_for_missing_plugin" = true;
          "plugins.hide_infobar_for_outdated_plugin" = true;
          "plugins.notifyMissingFlash" = false;
          "network.http.pipelining" = true;
          "network.http.proxy.pipelining" = true;
          "network.http.pipelining.maxrequests" = 10;
          "nglayout.initialpaint.delay" = 0;
          "network.cookie.cookieBehavior" = 1;
          "privacy.firstparty.isolate" = true;
          # tor
          # "network.proxy.socks" = "127.0.0.1";
          # "network.proxy.socks_port" = 9050;
          "extensions.update.enabled" = false;
          "intl.locale.matchOS" = true;
          "extensions.langpacks.signatures.required" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.EULA.override" = true;
          "extensions.autoDisableScopes" = 3;
          "extensions.shownSelectionUI" = true;
          "extensions.blocklist.enabled" = false;
          "app.update.url" = "http://127.0.0.1/";
          "startup.homepage_welcome_url" = "";
          "browser.startup.homepage_override.mstone" = "ignore";
          "app.support.baseURL" = "http://127.0.0.1/";
          "app.support.inputURL" = "http://127.0.0.1/";
          "app.feedback.baseURL" = "http://127.0.0.1/";
          "browser.uitour.url" = "http://127.0.0.1/";
          "browser.uitour.themeOrigin" = "http://127.0.0.1/";
          "plugins.update.url" = "http://127.0.0.1/";
          "browser.customizemode.tip0.learnMoreUrl" = "http://127.0.0.1/";
          "browser.dictionaries.download.url" = "http://127.0.0.1/";
          "browser.search.searchEnginesURL" = "http://127.0.0.1/";
          "layout.spellcheckDefault" = 0;
          "browser.download.useDownloadDir" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.translation.engine" = "";
          "media.gmp-provider.enabled" = false;
          "browser.urlbar.update2.engineAliasRefresh" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.topsites" = false;
          "security.OCSP.enabled" = 0;
          "security.OCSP.require" = false;
          "browser.discovery.containers.enabled" = false;
          "browser.discovery.enabled" = false;
          "services.sync.prefs.sync.browser.startup.homepage" = false;
          "browser.contentblocking.report.monitor.home_page_url" = "http://127.0.0.1/";
          "dom.ipc.plugins.flash.subprocess.crashreporter.enabled" = false;
          "browser.safebrowsing.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.provider.google.updateURL" = "";
          "browser.safebrowsing.provider.google.gethashURL" = "";
          "browser.safebrowsing.provider.google4.updateURL" = "";
          "browser.safebrowsing.provider.google4.gethashURL" = "";
          "browser.safebrowsing.provider.mozilla.gethashURL" = "";
          "browser.safebrowsing.provider.mozilla.updateURL" = "";
          "services.sync.privacyURL" = "http://127.0.0.1/";
          "social.enabled" = false;
          "social.remote-install.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.healthreport.about.reportUrl" = "datareporting.healthreport.about.reportUrl";
          "datareporting.healthreport.documentServerURI" = "http://127.0.0.1/";
          "healthreport.uploadEnabled" = false;
          "social.toast-notifications.enabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "browser.slowStartup.notificationDisabled" = true;
          "network.http.sendRefererHeader" = 2;
          "network.http.referer.spoofSource" = true;
          "network.http.originextension" = false;
          "dom.event.clipboardevents.enabled" = true;
          "network.user_prefetch-next" = false;
          "network.dns.disablePrefetch" = true;
          "network.http.sendSecureXSiteReferrer" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "";
          "experiments.manifest.uri" = "";
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "plugins.enumerable_names" = "";
          "plugin.state.flash" = 0;
          "browser.search.update" = false;
          "dom.battery.enabled" = false;
          "device.sensors.enabled" = false;
          "camera.control.face_detection.enabled" = false;
          "camera.control.autofocus_moving_callback.enabled" = false;
          "network.http.speculative-parallel-limit" = 0;
          "browser.urlbar.userMadeSearchSuggestionsChoice" = true;
          "browser.search.suggest.enabled" = false;
          "browser.sessionstore.max_resumed_crashes" = 0;
          "security.certerrors.mitm.priming.enabled" = false;
          "security.certerrors.recordEventTelemetry" = false;
          "extensions.shield-recipe-client.enabled" = false;
          "browser.newtabpage.directory.source" = "";
          "browser.newtabpage.directory.ping" = "";
          "browser.newtabpage.introShown" = true;
          "privacy.trackingprotection.enabled" = false;
          "privacy.trackingprotection.pbmode.enabled" = false;
          "urlclassifier.trackingTable" = "test-track-simple,base-track-digest256,content-track-digest256";
          "privacy.donottrackheader.enabled" = false;
          "privacy.trackingprotection.introURL" = "https://www.mozilla.org/%LOCALE%/firefox/%VERSION%/tracking-protection/start/";
          "geo.enabled" = false;
          "geo.wifi.uri" = "";
          "browser.search.geoip.url" = "";
          "browser.search.geoSpecificDefaults" = false;
          "browser.search.geoSpecificDefaults.url" = "";
          "browser.search.modernConfig" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "privacy.resistFingerprinting" = true;
          "webgl.disabled" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "gecko.handlerService.schemes.mailto.0.name" = "";
          "gecko.handlerService.schemes.mailto.1.name" = "";
          "handlerService.schemes.mailto.1.uriTemplate" = "";
          "gecko.handlerService.schemes.mailto.0.uriTemplate" = "";
          "browser.contentHandlers.types.0.title" = "";
          "browser.contentHandlers.types.0.uri" = "";
          "browser.contentHandlers.types.1.title" = "";
          "browser.contentHandlers.types.1.uri" = "";
          "gecko.handlerService.schemes.webcal.0.name" = "";
          "gecko.handlerService.schemes.irc.0.name" = "";
          "gecko.handlerService.schemes.irc.0.uriTemplate" = "";
          "gecko.handlerService.schemes.webcal.0.uriTemplate" = "";
          "extensions.webservice.discoverURL" = "http://127.0.0.1/";
          "extensions.getAddons.search.url" = "http://127.0.0.1/";
          "extensions.getAddons.search.browseURL" = "http://127.0.0.1/";
          "extensions.getAddons.get.url" = "http://127.0.0.1/";
          "extensions.getAddons.link.url" = "http://127.0.0.1/";
          "extensions.getAddons.discovery.api_url" = "http://127.0.0.1/";
          "extensions.systemAddon.update.url" = "";
          "extensions.systemAddon.update.enabled" = false;
          "extensions.getAddons.langpacks.url" = "http://127.0.0.1/";
          "lightweightThemes.getMoreURL" = "http://127.0.0.1/";
          "browser.geolocation.warning.infoURL" = "";
          "browser.xr.warning.infoURL" = "";
          "pfs.datasource.url" = "http://127.0.0.1/";
          "pfs.filehint.url" = "http://127.0.0.1/";
          "media.gmp-manager.url.override" = "data:text/plain,";
          "media.gmp-manager.url" = "";
          "media.gmp-manager.updateEnabled" = false;
          "media.gmp-gmpopenh264.enabled" = false;
          "media.gmp-eme-adobe.enabled" = false;
          "middlemouse.contentLoadURL" = false;
          "browser.selfsupport.url" = "";
          "browser.apps.URL" = "";
          "loop.enabled" = false;
          "browser.user_preferences.inContent" = false;
          "browser.aboutHomeSnippets.updateUrl" = "data:text/html";
          "browser.user_preferences.moreFromMozilla" = false;
          "gfx.direct2d.disabled" = true;
          "browser.casting.enabled" = false;
          "social.directories" = "";
          "security.ssl.errorReporting.enabled" = false;
          "security.tls.unrestricted_rc4_fallback" = false;
          "security.tls.insecure_fallback_hosts.use_static_list" = false;
          "security.tls.version.min" = 1;
          "security.ssl.require_safe_negotiation" = false;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "security.ssl3.rsa_seed_sha" = true;
          "security.ssl3.dhe_rsa_aes_128_sha" = false;
          "security.ssl3.dhe_rsa_aes_256_sha" = false;
          "security.ssl3.dhe_dss_aes_128_sha" = false;
          "security.ssl3.dhe_rsa_des_ede3_sha" = false;
          "security.ssl3.rsa_des_ede3_sha" = false;
          "browser.pocket.enabled" = false;
          "extensions.pocket.enabled" = false;
          "browser.preferences.moreFromMozilla" = false;
          "extensions.allowPrivateBrowsingByDefault" = true;
          "network.IDN_show_punycode" = true;
          "extensions.screenshots.disabled" = true;
          "browser.onboarding.newtour" = "performance,private,addons,customize,default";
          "browser.onboarding.updatetour" = "performance,library,singlesearch,customize";
          "browser.onboarding.enabled" = false;
          "browser.newtabpage.activity-stream.showTopSites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.disableSnippets" = true;
          "browser.newtabpage.activity-stream.tippyTop.service.endpoint" = "";
          "gfx.xrender.enabled" = true;
          "dom.webnotifications.enabled" = false;
          "dom.webnotifications.serviceworker.enabled" = false;
          "dom.push.enabled" = false;
          "browser.newtabpage.activity-stream.asrouter.useruser_prefs.cfr" = false;
          "extensions.htmlaboutaddons.discover.enabled" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "services.settings.server" = "";
          "browser.region.network.scan" = false;
          "browser.contentblocking.report.hide_vpn_banner" = true;
          "browser.contentblocking.report.mobile-ios.url" = "";
          "browser.contentblocking.report.mobile-android.url" = "";
          "browser.contentblocking.report.show_mobile_app" = false;
          "browser.contentblocking.report.vpn.enabled" = false;
          "browser.contentblocking.report.vpn.url" = "";
          "browser.contentblocking.report.vpn-promo.url" = "";
          "browser.contentblocking.report.vpn-android.url" = "";
          "browser.contentblocking.report.vpn-ios.url" = "";
          "browser.privatebrowsing.promoEnabled" = false;
          "browser.region.network.url" = "";
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "layout.css.font-visibility.private" = 1;
          "layout.css.font-visibility.standard" = 1;
          "layout.css.font-visibility.trackingprotection" = 1;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          "dom.disable_window_move_resize" = true;
          "accessibility.force_disabled" = 1;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "devtools.debugger.remote-enabled" = false;
          "webchannel.allowObject.urlWhitelist" = "";
          "permissions.manager.defaultsUrl" = "";
          "pdfjs.enableScripting" = false;
          "permissions.delegation.enabled" = false;
          "browser.contentblocking.category" = "strict";
          "security.tls.version.enable-deprecated" = false;
          "extensions.webcompat.enable_shims" = true;
          "privacy.resistFingerprinting.letterboxing" = true;
          "privacy.window.maxInnerWidth" = 1600;
          "privacy.window.maxInnerHeight" = 900;
        };
      };
    })
  ];
}
