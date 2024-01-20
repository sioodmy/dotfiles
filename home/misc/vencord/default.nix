{pkgs, ...}: {
  # credits: neoney
  xdg.configFile."VencordDesktop/VencordDesktop/themes/Catppuccin.theme.css".source = ./theme.css;
  home.packages = [
    pkgs.vesktop
    # (pkgs.vesktop.overrideAttrs (old: {
    #   patches = (old.patches or []) ++ [./readonlyFix.patch];
    #   postFixup = ''
    #     wrapProgram $out/bin/vencorddesktop \
    #       --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
    #   '';
    # }))
  ];

  xdg.configFile."VencordDesktop/VencordDesktop/settings.json".text = builtins.toJSON {
    discordBranch = "canary";
    firstLaunch = false;
    arRPC = "on";
    splashColor = "rgb(219, 222, 225)";
    splashBackground = "rgb(49, 51, 56)";
    enableMenu = false;
    staticTitle = false;
    transparencyOption = "I love NixOS";
  };

  xdg.configFile."VencordDesktop/VencordDesktop/settings/settings.json".text = builtins.toJSON {
    notifyAboutUpdates = false;
    autoUpdate = false;
    autoUpdateNotification = false;
    useQuickCss = true;
    themeLinks = [];
    enabledThemes = ["Catppuccin.theme.css"];
    enableReactDevtools = true;
    frameless = false;
    transparent = true;
    winCtrlQ = false;
    macosTranslucency = false;
    disableMinSize = false;
    winNativeTitleBar = false;
    plugins = {
      AlwaysAnimate.enabled = false;
      AlwaysTrust.enabled = false;
      AnonymiseFileNames.enabled = false;
      BadgeAPI.enabled = true;
      CommandsAPI.enabled = true;
      ContextMenuAPI.enabled = true;
      MemberListDecoratorsAPI.enabled = false;
      MessageAccessoriesAPI.enabled = false;
      MessageDecorationsAPI.enabled = false;
      MessageEventsAPI.enabled = false;
      MessagePopoverAPI.enabled = false;
      NoticesAPI.enabled = true;
      ServerListAPI.enabled = false;
      SettingsStoreAPI.enabled = false;
      "WebRichPresence (arRPC)".enabled = true;
      BANger.enabled = false;
      BetterFolders.enabled = false;
      BetterGifAltText.enabled = true;
      BetterNotesBox.enabled = false;
      BetterRoleDot.enabled = false;
      BetterUploadButton.enabled = true;
      BlurNSFW.enabled = false;
      CallTimer.enabled = true;
      ClearURLs.enabled = true;
      ColorSighted.enabled = false;
      ConsoleShortcuts.enabled = false;
      CrashHandler.enabled = true;
      CustomRPC.enabled = false;
      DisableDMCallIdle.enabled = false;
      EmoteCloner.enabled = false;
      Experiments.enabled = true;
      F8Break.enabled = false;
      FakeNitro.enabled = true;
      FakeProfileThemes.enabled = false;
      Fart2.enabled = false;
      FixInbox.enabled = false;
      ForceOwnerCrown.enabled = true;
      FriendInvites.enabled = false;
      FxTwitter.enabled = false;
      GameActivityToggle.enabled = true;
      GifPaste.enabled = false;
      HideAttachments.enabled = false;
      iLoveSpam.enabled = false;
      IgnoreActivities.enabled = false;
      ImageZoom.enabled = true;
      InvisibleChat.enabled = false;
      KeepCurrentChannel.enabled = false;
      LastFMRichPresence.enabled = false;
      LoadingQuotes.enabled = false;
      MemberCount.enabled = true;
      MessageClickActions.enabled = false;
      MessageLinkEmbeds.enabled = true;
      MessageLogger.enabled = true;
      MessageTags.enabled = false;
      MoreCommands.enabled = false;
      MoreKaomoji.enabled = false;
      MoreUserTags.enabled = false;
      Moyai.enabled = false;
      MuteNewGuild.enabled = false;
      NoBlockedMessages.enabled = false;
      NoCanaryMessageLinks.enabled = false;
      NoDevtoolsWarning.enabled = true;
      NormalizeMessageLinks.enabled = true;
      NoF1.enabled = true;
      NoReplyMention.enabled = true;
      NoScreensharePreview.enabled = false;
      NoTrack.enabled = true;
      NoUnblockToJump.enabled = true;
      NSFWGateBypass.enabled = false;
      oneko.enabled = false;
      petpet.enabled = false;
      PinDMs.enabled = false;
      PlainFolderIcon.enabled = false;
      PlatformIndicators.enabled = true;
      PronounDB.enabled = false;
      QuickMention.enabled = false;
      QuickReply.enabled = true;
      ReadAllNotificationsButton.enabled = true;
      RelationshipNotifier.enabled = true;
      RevealAllSpoilers.enabled = false;
      ReverseImageSearch.enabled = false;
      ReviewDB.enabled = true;
      RoleColorEverywhere.enabled = true;
      SearchReply.enabled = false;
      SendTimestamps.enabled = false;
      ServerListIndicators.enabled = false;
      Settings = {
        enabled = true;
        settingsLocation = "aboveActivity";
      };
      ShikiCodeblocks.enabled = false;
      ShowHiddenChannels.enabled = false;
      ShowMeYourName.enabled = false;
      SilentMessageToggle.enabled = false;
      SilentTyping.enabled = true;
      SortFriendRequests.enabled = false;
      SpotifyControls.enabled = false;
      SpotifyCrack.enabled = false;
      SpotifyShareCommands.enabled = false;
      StartupTimings.enabled = false;
      SupportHelper.enabled = true;
      TimeBarAllActivities.enabled = false;
      TypingIndicator.enabled = true;
      TypingTweaks.enabled = true;
      Unindent.enabled = true;
      ReactErrorDecoder.enabled = false;
      UrbanDictionary.enabled = false;
      UserVoiceShow.enabled = false;
      USRBG.enabled = false;
      UwUifier.enabled = true;
      VoiceChatDoubleClick.enabled = true;
      VcNarrator.enabled = false;
      ViewIcons.enabled = false;
      ViewRaw.enabled = false;
      WebContextMenus = {
        enabled = true;
        addBack = false;
      };
      GreetStickerPicker.enabled = false;
      WhoReacted.enabled = true;
      Wikisearch.enabled = false;
    };
    notifications = {
      timeout = 5000;
      position = "bottom-right";
      useNative = "not-focused";
      logLimit = 50;
    };
    cloud = {
      authenticated = false;
      url = "https://api.vencord.dev/";
      settingsSync = false;
      settingsSyncVersion = 1682768329526;
    };
  };
}
