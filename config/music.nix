{ config, pkgs, ...}:

{
  services.mpd = {
    eanble = true;
    dataDir = "/home/sioodmy/.config/mpd";
    network = {
      listenAddress = "any";
      port = 6600;
    };
    extraConfig = ''     
      audio_output {
        type    "pipewire"
        name    "pipewire"
      }
      auto_update "yes"
    '';
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp;
    settings = {
      ncmpcpp_directory = "/home/ioodmy.config/ncmpcpp";
      lyrics_directory = "/home/sioodmy/.cache/lyrics";
      progressbar_look = "▄▄";
      media_library_primary_tag = "album_artist";
      follow_now_playing_lyrics = "yes";
      screen_switcher_mode = "playlist, media_library";
      display_bitrate = "yes";
    };
  };
}
