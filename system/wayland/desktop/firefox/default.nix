{pkgs, ...}:
pkgs.wrapFirefox pkgs.firefox-esr-128-unwrapped {
  extraPolicies = {
    OverrideFirstRunPage = "";
    DisableTelemetry = true;
    AppAutoUpdate = false;
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisableFirefoxAccounts = true;
    DisablePocket = true;
    DisableFormHistory = true;
    DisplayBookmarksToolbar = true;
    DontCheckDefaultBrowser = true;
    DisableSetDesktopBackground = true;
    PasswordManagerEnabled = false;
    PromptForDownloadLocation = true;
    SanitizeOnShutdown = false;

    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;

    EnableTrackingProtection = {
      Cryptomining = true;
      Fingerprinting = true;
      Locked = true;
      Value = true;
    };

    FirefoxHome = {
      Search = true;
      Pocket = false;
      Snippets = false;
      TopSites = false;
      Highlights = false;
    };

    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };

    Cookies = {
      Behavior = "accept";
      ExpireAtSessionEnd = false;
      Locked = false;
    };
    Preferences = import ./preferences.nix;
  };
}
