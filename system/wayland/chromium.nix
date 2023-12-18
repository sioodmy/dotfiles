_: {
  programs.chromium = {
    enable = true;
    extraOpts = {
      BookmarkBarEnabled = true;
      BrowserSignin = 0;
      DefaultBrowserSettingEnabled = false;
      DefaultSearchProviderEnabled = true;
      DefaultSearchProviderSearchURL = "https://search.notashelf.dev/search?q={searchTerms}";
      HomepageLocation = "https://search.notashelf.dev";
      PasswordManagerEnabled = false;
      ShowAppsShortcutInBookmarkBar = false;
      SyncDisabled = true;
    };
  };
}
