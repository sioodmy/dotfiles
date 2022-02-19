{ pkgs, config, ...}:

{
    programs.firefox = {
        enable = true;
        profiles.default = {
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true; 
            "media.peerconnection.enabled" = false;
            "media.peerconnection.turn.disable" = true;
            "media.peerconnection.use_document_iceservers" = false;
            "media.peerconnection.video.enabled" = false;
            "media.peerconnection.identity.timeout" = 1;
            "privacy.firstparty.isolate" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.cryptomining.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "browser.send_pings" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "dom.event.clipboardevents.enabled" = false;
            "media.navigator.enabled" = false;
            "network.cookie.cookieBehavior" = 1;
            "network.http.referer.XOriginPolicy" = 2;
            "network.http.referer.XOriginTrimmingPolicy" = 2;
            "beacon.enabled" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "network.predictor.enabled" = false;
            "network.predictor.enable-prefetch" = false;
            "network.prefetch-next" = false;
            "network.IDN_show_punycode" = true;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "app.shield.optoutstudies.enabled" = false;
            "dom.security.https_only_mode_ever_enabled" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.toolbars.bookmarks.visibility" = "never";
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
            "media.autoplay.enabled" = false;
            "extensions.pocket.enabled" = false;
            "identity.fxaccounts.enabled" = false;
            "toolkit.zoomManager.zoomValues" = ".8,.95,1,1.1,1.2";
          };


            userChrome = ''
:root {
  --navbarWidth     : 360px; /* Set width of navbar. Use px for a fixed width 
                                or vw for a percentage of your window. */
  --animationSpeed  : 0.15s;
}


/* H I D I N G   E L E M E N T S */
/* Comment or uncomment depending of what elements you want to hide */

/* Back button */
/* #back-button { display: none !important } */

/* Hide back button only when disabled */
#back-button[disabled="true"] { display: none !important }

/* Forward button */
/* #forward-button { display: none !important } */

/* Hide forward button only when disabled */
#forward-button[disabled="true"] { display: none !important }

/* "Shield" icon */
#tracking-protection-icon-container { display: none !important }

/* Site information button */
#identity-box { display: none !important }

/* This is the "Search with" indicator on the urlbar */
/* #urlbar-search-mode-indicator { display: none !important } */

/* Zoom button */
/* #urlbar-zoom-button { display: none !important } */

/* Page action (right three dash button) */
/* #pageActionButton { display: none !important } */

/* These are the buttons on the right of the urlbar */
/* #page-action-buttons { display: none !important } */

/* #urlbar-label-box { display: none !important } */

/* This one is the hamburger menu! */
/* CAUTION: if you hide this some popups may be bugged */
/* #PanelUI-button { display: none !important } */

/* Tab close button */
/* .tab-close-button { display: none !important } */

/* Enable this to show the tab close button when hovering the tab */
/* .tabbrowser-tab:hover .tab-close-button { display: -moz-inline-box !important } */

/*============================================================================*/


/* Oneline tweak */

#TabsToolbar {
  margin-left : var(--navbarWidth) !important;
}

#nav-bar {
  margin-right: calc(100vw - var(--navbarWidth)) !important;
}

#urlbar-container {
  min-width   : 0px !important;
}

:root[uidensity="compact"] #nav-bar {
  margin-top  : -37px !important;
  height      : 37px !important;
}

:root:not([uidensity="compact"]):not([uidensity="touch"]) #nav-bar {
  margin-top  : -44px !important;
  height      : 44px !important;
}

:root[uidensity="touch"] #nav-bar {
  margin-top  : -49px !important;
  height      : 49px !important;
}


/* Dragging space */
:root[sizemode="maximized"] #TabsToolbar {
  margin-top: 1px;
}

#TabsToolbar {
  margin-top: 5px;
}


/* Simplifying interface */

#nav-bar {
  background  : none !important;
  box-shadow  : none !important;
}

#navigator-toolbox {
  border      : none !important;
}

.titlebar-spacer {
  display     : none !important;
}

#urlbar-background {
  border      : none !important;
}

#urlbar:not(:hover):not([breakout][breakout-extend]) > #urlbar-background {
  box-shadow  : none !important;
  background  : none !important;
}


/* Hide urlbar elements when not active */

.urlbar-icon, #userContext-indicator, #userContext-label {
  fill        : transparent !important;
  background  : transparent !important;
  color       : transparent !important;
}

#urlbar:hover .urlbar-icon,
#urlbar:active .urlbar-icon, 
#urlbar[focused] .urlbar-icon {
  fill        : var(--toolbar-color) !important;
}


/* animations */
.subviewbutton,
#urlbar-background,
.urlbar-icon,
#userContext-indicator,
#userContext-label,
.urlbar-input-box, 
#identity-box,
#tracking-protection-icon-container,
[anonid=urlbar-go-button],
.urlbar-icon-wrapper,
#tracking-protection-icon,
#identity-box image,
stack,
tab:not(:active) .tab-background,
tab:not([beforeselected-visible])::after,
tab[visuallyselected] .tab-background::before,
tab[visuallyselected] .tab-background::before,
.tab-close-button {
  transition  : var(--animationSpeed) !important;
}
            '';
        };
    };
}
