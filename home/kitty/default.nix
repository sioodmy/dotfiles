{ config, lib, pkgs, ... }: {

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "1.0";
      font_family = "monospace";
      font_size = 14;
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      scrollback_lines = 2000;
      click_interval = "0.5";
      select_by_word_characters = ":@-./_~?&=%+#";
      remember_window_size = false;
      allow_remote_control = true;
      initial_window_width = 640;
      initial_window_height = 400;
      repaint_delay = 15;
      input_delay = 3;
      visual_bell_duration = "0.0";
      open_url_with = "default";
      confirm_os_window_close = 0;

      enable_audio_bell = false;

      window_padding_width = 15;
      window_margin_width = 10;
      disable_ligatures = "never";
      foreground = "#C6D0F5";
      background = "#303446";

      selection_foreground = "#303446";
      selection_background = "#F2D5CF";

      cursor = "#F2D5CF";
      cursor_text_color = "#303446";
      url_color = "#F2D5CF";

      mark1_foreground = "#303446";
      mark1_background = "#BABBF1";
      mark2_foreground = "#303446";
      mark2_background = "#CA9EE6";
      mark3_foreground = "#303446";
      mark3_background = "#85C1DC";

      active_border_color = "#BABBF1";
      inactive_border_color = "#737994";

      color0 = "#51576D";
      color1 = "#E78284";
      color2 = "#A6D189";
      color3 = "#E5C890";
      color4 = "#8CAAEE";
      color5 = "#F4B8E4";
      color6 = "#81C8BE";
      color7 = "#B5BFE2";
      color8 = "#626880";
      color9 = "#E78284";
      color10 = "#A6D189";
      color11 = "#E5C890";
      color12 = "#8CAAEE";
      color13 = "#F4B8E4";
      color14 = "#81C8BE";
      color15 = "#A5ADCE";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+shift+up" = "increase_font_size";
      "ctrl+shift+down" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+alt+c" = "copy_to_clipboard";
      "ctrl+alt+v" = "paste_from_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
  };
}
