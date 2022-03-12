{ config, pkgs, theme, ...}:

{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      sponsorblock
      h264ify
      darkreader
    ];
    profiles.default = {
      settings = {
        "extensions.webextensions.ExtensionStorageIDB.migrated.uBlock0@raymondhill.net" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.sponsorBlocker@ajay.app" = true;
        "fission.autostart" = true;
        "geo.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "app.shield.optoutstudies.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = " ";
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "network.dns.disableIPv6" = true;
        "browser.places.speculativeConnect.enabled" = false;
        "keyword.enabled" = true;
        "browser.urlbar.trimURLs" = false;
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
"browser.cache.disk.enable" = false;
"browser.privatebrowsing.forceMediaMemoryCache" = true;
"media.memory_cache_max_size" = 65536;
"browser.sessionstore.privacy_level" = 2;
"browser.sessionstore.interval" = 30000;
"toolkit.winRegisterApplicationRestart" = false;
"browser.shell.shortcutFavicons" = false;
"security.ssl.require_safe_negotiation" = true;
"security.tls.enable_0rtt_data" = false;
"security.OCSP.enabled" = 1;
"security.OCSP.require" = true;
"security.pki.sha1_enforcement_level" = 1;
"security.family_safety.mode" = 0;
"security.cert_pinning.enforcement_level" = 2;
"security.pki.crlite_mode" = 2;
"dom.security.https_only_mode" = true;
"dom.security.https_only_mode_send_http_background_request" = false;
"security.ssl.treat_unsafe_negotiation_as_broken" = true;
"browser.ssl_override_behavior" = 1;
"browser.xul.error_pages.expert_bad_cert"= true;
"network.http.referer.XOriginPolicy" = 2;
"network.http.referer.XOriginTrimmingPolicy" = 2;
"privacy.userContext.enabled" = true;
"privacy.userContext.ui.enabled" = true;
"media.peerconnection.ice.proxy_only_if_behind_proxy" = false;
"media.peerconnection.ice.default_address_only" = false;
"media.eme.enabled" = true;
"media.autoplay.blocking_policy" = 2;
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
"devtools.debugger.remote-enabled" = false;
"middlemouse.contentLoadURL" = false;
"permissions.manager.defaultsUrl" = "";
"webchannel.allowObject.urlWhitelist" = "";
"network.IDN_show_punycode" = true;
"permissions.delegation.enabled" = false;
"extensions.postDownloadThirdPartyPrompt" = false;
"extensions.autoDisableScopes" = 15;
"extensions.enabledScopes" = 5;
"browser.contentblocking.category" = "strict";
"privacy.partition.serviceWorkers" = true;
"network.cookie.lifetimePolicy" = 2;
"network.cookie.thirdparty.sessionOnly" = true;
"network.cookie.thirdparty.nonsecureSessionOnly" = true;
"privacy.sanitize.sanitizeOnShutdown" = true;
"privacy.clearOnShutdown.cache" = true;
"privacy.clearOnShutdown.downloads" = true;
"privacy.clearOnShutdown.formdata" = true;
"privacy.clearOnShutdown.history" = true;
"privacy.clearOnShutdown.sessions" = true;
"privacy.clearOnShutdown.offlineApps" = false;
"privacy.clearOnShutdown.cookies" = false;
"privacy.cpd.cache" = true;
"privacy.cpd.formdata" = true;
"privacy.cpd.history" = true;
"privacy.cpd.offlineApps" = false;
"privacy.cpd.cookies" = false;
"privacy.cpd.sessions" = true;
"privacy.sanitize.timeSpan" = 0;
"privacy.resistFingerprinting" = true;
"privacy.resistFingerprinting.block_mozAddonManager" = true;
"privacy.resistFingerprinting.letterboxing" = false;
"browser.startup.blankWindow" = true;
"widget.non-native-theme.enabled" = true;
"browser.link.open_newwindow" = 3;
"browser.link.open_newwindow.restriction" = 0;
"webgl.disabled" = false;

"browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
"browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
"browser.newtabpage.activity-stream.showSponsored" = false;
"extensions.pocket.enabled" = false;
"pdfjs.enableScripting" = false;
"identity.fxaccounts.enabled" = false;
"browser.urlbar.shortcuts.bookmarks" = true;
"browser.urlbar.shortcuts.history" = true;
"browser.urlbar.shortcuts.tabs" = true;
"browser.urlbar.suggest.bookmark" = false;
"browser.urlbar.suggest.engines" = false;
"browser.urlbar.suggest.history" = false;
"browser.urlbar.suggest.openpage" = false;
"browser.urlbar.suggest.topsites" = false;
"browser.newtabpage.activity-stream.feeds.telemetry" = false;
"browser.newtabpage.activity-stream.telemetry" = false;
"browser.newtabpage.activity-stream.default.sites" = " ";
"geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
"geo.provider.use_gpsd" = false;
"javascript.use_us_english_locale" = true;
"extensions.getAddons.showPane" = false;
"extensions.htmlaboutaddons.recommendations.enabled" = false;
"browser.discovery.enabled" = false;
"datareporting.policy.dataSubmissionEnabled" = false;
"datareporting.healthreport.uploadEnabled" = false;       
"browser.uidensity" = 1;
"media.autoplay.enabled" = false;
"toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";

"privacy.firstparty.isolate" = true;
"network.http.sendRefererHeader" = 0;
        };

        userChrome = with theme.colors; "
        :root {

        /*---+---+---+---+---+---+---+
        | C | O | L | O | U | R | S |
        +---+---+---+---+---+---+---*/


        /* Comment this block out if you want to keep the default theme colour. */
        /* This will also work with custom colours from color.firefox.com. */

        /* Theme Colour Suggestions
        *                              Dark        Light   */
        --window-colour:               #${bg}; /* #${fg}; */
        --secondary-colour:            #${ba}; /* #${fg}; */
        --inverted-colour:             #${c0}; /* #${bg}; */


        /* Containter Tab Colours */
        --uc-identity-color-blue:      #${c4};
        --uc-identity-color-turquoise: #${c5};
        --uc-identity-color-green:     #${c2};
        --uc-identity-color-yellow:    #${c3};
        --uc-identity-color-orange:    #${c11};
        --uc-identity-color-red:       #${c1};
        --uc-identity-color-pink:      #${c6};
        --uc-identity-color-purple:    #${c5};


        /* URL colour in URL bar suggestions */
        --urlbar-popup-url-color: var(--uc-identity-color-purple) !important;



        /*---+---+---+---+---+---+---+
        | V | I | S | U | A | L | S |
        +---+---+---+---+---+---+---*/

        /* global border radius */
        --uc-border-radius: 0;

        /* dynamic url bar width settings */
        --uc-urlbar-width: clamp(200px, 40vw, 500px);

        /* dynamic tab width settings */
        --uc-active-tab-width:   clamp(100px, 20vw, 300px);
        --uc-inactive-tab-width: clamp( 50px, 15vw, 200px);

        /* if active always shows the tab close button */
        --show-tab-close-button: none; /* DEFAULT: -moz-inline-box; */ 

        /* if active only shows the tab close button on hover*/
        --show-tab-close-button-hover: none; /* DEFAULT: -moz-inline-box; */

        /* adds left and right margin to the container-tabs indicator */
        --container-tabs-indicator-margin: 10px;

        }

" + builtins.readFile ./userChrome.css;
};
};
}
