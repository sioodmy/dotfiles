{
  pkgs,
  config,
  inputs,
  ...
}: {
  home.packages = [pkgs.spotify-tui];
  services = {
    playerctld.enable = true;

    spotifyd = {
      enable = true;
      package = pkgs.spotifyd.override {withMpris = true;};
      settings.global = {
        autoplay = true;
        backend = "pulseaudio";
        bitrate = 320;
        cache_path = "${config.xdg.cacheHome}/spotifyd";
        device_type = "computer";
        initial_volume = "100";
        password_cmd = "head -1 /run/agenix/spotify";
        use_mpris = true;
        username_cmd = "tail -1 /run/agenix/spotify";
        volume_normalisation = true;
      };
    };
  };

  xdg.configFile."spotify-tui/config.yml".text = ''
    theme:
      error_border: "243, 139, 168" # error dialog border is Red
      error_text: "235, 160, 172" # error message text (e.g. "Spotify API reported error 404") is Maroon
      hint: "249, 226, 175" # hint text in errors Yellow
      playbar_background: "17, 17, 27" # background of progress bar "Crust"
      playbar_progress: "24, 24, 37" # filled-in part of the progress bar Mantle
      playbar_progress_text: "166, 227, 161" # song length and time played/left indicator in the progress bar "Green"
      playbar_text: "166, 173, 200" # artist name in player pane is "Subtext 0"
      inactive: "108, 112, 134" # borders of inactive panes "Overlay 0"
      text: "205, 214, 244" # text in panes is "Text"
      active: "203, 166, 247" # current playing song in list Mauve
      banner: "245, 194, 231" # the "spotify-tui" banner on launch pink
      hovered: "245, 194, 231" # hovered pane border Pink
      selected: "180, 190, 254" # a) selected pane border, b) hovered item in list, & c) track title in player Lavender
      header: "180, 190, 254" # header text in panes (e.g. 'Title', 'Artist', etc.) Lavender

    behavior:
      set_window_title: true
      show_loading_indicator: true
  '';
}
