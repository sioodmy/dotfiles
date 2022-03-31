{ pkgs, config, theme, ... }: {
  home.packages = [ pkgs.tdrop ];
  programs.kitty = {
    enable = true;
    settings = with theme.colors; {
      font_family = "monospace";
      font_size = 13;
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      scrollback_lines = 2000;
      click_interval = "0.5";
      select_by_word_characters = ":@-./_~?&=%+#";
      remember_window_size = "no";
      initial_window_width = 640;
      initial_window_height = 400;
      repaint_delay = 15;
      input_delay = 3;
      visual_bell_duration = "0.0";
      open_url_with = "default";

      enable_audio_bell = "no";

      window_padding_width = 15;
      disable_ligatures = "always";
      foreground = "#${fg}";
      background = "#${bg}";

      selection_foreground = "#${fg}";
      selection_background = "#${ac}";

      cursor = "#${c6}";
      cursor_text_color = "#${bg}";
      url_color = "#${c6}";

      mark1_foreground = "#${bg}";
      mark1_background = "#${c4}";
      mark2_foreground = "#${bg}";
      mark2_background = "#${c6}";
      mark3_foreground = "#${bg}";
      mark3_background = "#${c2}";

      color0 = "#${c0}";
      color1 = "#${c1}";
      color2 = "#${c2}";
      color3 = "#${c3}";
      color4 = "#${c4}";
      color5 = "#${c5}";
      color6 = "#${c6}";
      color7 = "#${c7}";
      color8 = "#${c8}";
      color9 = "#${c9}";
      color10 = "#${c10}";
      color11 = "#${c11}";
      color12 = "#${c12}";
      color13 = "#${c13}";
      color14 = "#${c14}";
      color15 = "#${c15}";
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+shift+up" = "increase_font_size";
      "ctrl+shift+down" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+alt+c" = "copy_to_clipboard";
      "ctrl+alt+v" = "paste_from_clipboard";
      "ctrl+v" = "paste_from_clipboard";
    };
  };
}
