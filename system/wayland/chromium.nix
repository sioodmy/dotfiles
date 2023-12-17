{...}: {
  programs.chromium = {
    enable = true;
    extraOpts = {
      BookmarkBarEnabled = true;
      BrowserSignin = 0;
      DefaultBrowserSettingEnabled = false;
      DefaultSearchProviderEnabled = true;
      DefaultSearchProviderSearchURL = "https://search.brave.com/search?q={searchTerms}&source=web";
      PasswordManagerEnabled = false;
      ShowAppsShortcutInBookmarkBar = false;
      SyncDisabled = true;
    };
  };
}
