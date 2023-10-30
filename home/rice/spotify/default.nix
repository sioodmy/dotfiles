{
  pkgs,
  inputs,
  ...
}: {
  # themable spotify
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.hostPlatform.system}.default;
  in {
    enable = true;

    theme = spicePkgs.themes.catppuccin;

    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      hidePodcasts
      shuffle
      skipStats
      autoVolume
      autoSkip
      savePlaylists
      phraseToPlaylist
      wikify
      autoSkip
      copyToClipboard
      history
      groupSession
      loopyLoop
      trashbin
      bookmark
      keyboardShortcut
      fullAppDisplayMod
      # i aint paying for shit
      adblock
    ];
    enabledCustomApps = with spicePkgs.apps; [
      reddit
      lyrics-plus
      localFiles
    ];
  };
}
