{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.programs.kitty;
in {

  options.modules.programs.kitty = { enable = mkEnableOption "kitty"; };

  config = mkIf cfg.enable {

    home.packages = [ pkgs.tdrop ];
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
        foreground = "#cdd6f4";
        background = "#1e1e2e";

        selection_foreground = "#1e1e2e";
        selection_background = "#f5e0dc";

        cursor = "#f5e0dc";
        cursor_text_color = "#1e1e2e";
        url_color = "#f5e0dc";

        mark1_foreground = "#1e1e2e";
        mark1_background = "#b4befe";
        mark2_foreground = "#1e1e2e";
        mark2_background = "#cba6f7";
        mark3_foreground = "#1e1e2e";
        mark3_background = "#7DC4E4";

        active_border_color = "#b4befe";
        inactive_border_color = "#6c7086";

        color0 = "#45475a";
        color1 = "#f38ba8";
        color2 = "#a6e3a1";
        color3 = "#f9e2af";
        color4 = "#89b4fa";
        color5 = "#f5c2e7";
        color6 = "#94e2d5";
        color7 = "#bac2de";
        color8 = "#585b70";
        color9 = "#f38ba8";
        color10 = "#a6e3a1";
        color11 = "#f9e2af";
        color12 = "#89b4fa";
        color13 = "#f5c2e7";
        color14 = "#94e2d5";
        color15 = "#a6adc8";
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
