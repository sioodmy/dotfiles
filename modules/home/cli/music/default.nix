{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.cli.music;
in {
  options.modules.cli.music = { enable = mkEnableOption "music"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ mpc_cli playerctl ];

    services.mpd = {
      enable = true;
      # dataDir = "/home/grajap/.config/mpd";
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
        ncmpcpp_directory = "/home/grajap/.config/ncmpcpp";
        mpd_crossfade_time = 2;
        lyrics_directory = "/home/grajap/.cache/lyrics";
        progressbar_look = "▃▃▃";
        progressbar_elapsed_color = 5;
        progressbar_color = "black";
        media_library_primary_tag = "album_artist";
        follow_now_playing_lyrics = "yes";
        connected_message_on_startup = "no";
        ignore_leading_the = "yes";
        screen_switcher_mode = "playlist, media_library";
        song_columns_list_format = "(50)[]{t|fr:Title} (0)[magenta]{a}";
        song_list_format = "$8%a - %t$R  %l";
        song_library_format = "{{%a - %t} (%b)}|{%f}";
        song_status_format = "$7%t";
        song_window_title_format = "Now Playing ..";
        now_playing_prefix = "$b$2$7 ";
        now_playing_suffix = "  $/b$8";
        current_item_prefix = "$b$7$/b$3 ";
        current_item_suffix = "  $8";
        statusbar_color = "white";
        color1 = "white";
        color2 = "blue";
        header_visibility = "no";
        statusbar_visibility = "no";
        titles_visibility = "no";
        enable_window_title = "yes";
        cyclic_scrolling = "yes";
        mouse_support = "yes";
        mouse_list_scroll_whole_page = "yes";
        lines_scrolled = "1";
        message_delay_time = "1";
        playlist_shorten_total_times = "yes";
        playlist_display_mode = "columns";
        browser_display_mode = "columns";
        search_engine_display_mode = "columns";
        playlist_editor_display_mode = "columns";
        autocenter_mode = "yes";
        centered_cursor = "yes";
        user_interface = "classic";
        locked_screen_width_part = "50";
        ask_for_locked_screen_width_part = "yes";
        display_bitrate = "no";
        external_editor = "nvim";
        main_window_color = "default";
        startup_screen = "playlist";
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "Visualizer";
        visualizer_in_stereo = "no";
        visualizer_type = "ellipse";
        visualizer_fps = "60";
        visualizer_look = "●▮";
        visualizer_color = "33,39,63,75,81,99,117,153,189";
      };
      bindings = [
        {
          key = "j";
          command = "scroll_down";
        }
        {
          key = "k";
          command = "scroll_up";
        }
        {
          key = "J";
          command = [ "select_item" "scroll_down" ];
        }
        {
          key = "K";
          command = [ "select_item" "scroll_up" ];
        }
      ];
    };

    services.sxhkd.keybindings = {
      "super + XF86AudioRaiseVolume" = "mpc volume +5";
      "super + XF86AudioLowerVolume" = "mpc volume -5";
      "XF86AudioPrev" = "playerctl previous";
      "XF86AudioNext" = "playerctl next";
      "XF86AudioPlay" = "playerctl play-pause";
      "XF86AudioPause" = "playerctl play-pause";
    };
  };
}
