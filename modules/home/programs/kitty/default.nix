{ pkgs, lib, config, theme, ... }:
with lib;
let cfg = config.modules.programs.kitty;
in {

  options.modules.programs.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {

    home.packages = [ pkgs.tdrop ];
    programs.kitty = {
      enable = true;
      settings = with theme.colors; {
        font_family = "monospace";
        font_size = 16;
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

        enable_audio_bell = false;

        window_padding_width = 15;
        disable_ligatures = "always";
        foreground = "#D8DEE9";
        background = "#2E3440";

        selection_foreground = "#000000";
        selection_background = "#FFFACD";

        cursor = "#81A1C1";
        cursor_text_color = "#2E3440";
        url_color = "#0087BD";

        mark1_foreground = "#2E3440";
        mark1_background = "#81A1C1";
        mark2_foreground = "#2E3440";
        mark2_background = "#EBCB8B";
        mark3_foreground = "#2E3440";
        mark3_background = "#A3BE8C";

        color0 = "#2e3440";
        color1 = "#bf616a";
        color2 = "#a3be8c";
        color3 = "#ebcb8b";
        color4 = "#81a1c1";
        color5 = "#b48ead";
        color6 = "#88c0d0";
        color7 = "#e5e9f0";
        color8 = "#4c566a";
        color9 = "#bf616a";
        color10 = "#a3be8c";
        color11 = "#ebcb8b";
        color12 = "#81a1c1";
        color13 = "#b48ead";
        color14 = "#8fbcbb";
        color15 = "#eceff4";
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

    services.sxhkd.keybindings = {
      "super + Return" = "kitty --single-instance";
      "alt + grave" = "tdrop -ma -y 50% -x 25% -w 50% -n dropdownterminal kitty";
    };
  };
}
