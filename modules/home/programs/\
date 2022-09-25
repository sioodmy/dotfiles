{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.kitty;
in {
  options.modules.programs.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        font_family = "monospace";
        font_size = 12;
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
        foreground = "#CAD3F5";
        background = "#24273A";

        selection_foreground = "#24273A";
        selection_background = "#F4DBD6";

        cursor = "#F4DBD6";
        cursor_text_color = "#24273A";
        url_color = "#F4DBD6";

        mark1_foreground = "#24273A";
        mark1_background = "#B7BDF8";
        mark2_foreground = "#24273A";
        mark2_background = "#C6A0F6";
        mark3_foreground = "#24273A";
        mark3_background = "#7DC4E4";

        active_border_color = "#B7BDF8";
        inactive_border_color = "#6E738D";

        color0 = "#494D64";
        color1 = "#ED8796";
        color2 = "#A6DA95";
        color3 = "#EED49F";
        color4 = "#8AADF4";
        color5 = "#F5BDE6";
        color6 = "#8BD5CA";
        color7 = "#B8C0E0";
        color8 = "#5B6078";
        color9 = "#ED8796";
        color10 = "#A6DA95";
        color11 = "#EED49F";
        color12 = "#8AADF4";
        color13 = "#F5BDE6";
        color14 = "#8BD5CA";
        color15 = "#A5ADCB";
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
  };
}
