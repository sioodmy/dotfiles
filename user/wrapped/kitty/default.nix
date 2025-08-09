{
  pkgs,
  ...
}: let
  inherit (pkgs.lib.generators) toKeyValue;
  inherit (pkgs.lib) isBool;

  yesno = val:
    if val
    then "yes"
    else "no";

  toKittyConfig = toKeyValue {
    mkKeyValue = key: value: let
      value' =
        (
          if isBool value
          then yesno
          else toString
        )
        value;
    in "${key} ${value'}";
  };

  config = pkgs.writeText "kitty.conf" (toKittyConfig {
    font_family = "monospace";
    font_size = 11;
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
    hide_window_decorations = true;

    enable_audio_bell = false;

    window_padding_width = 4;
    window_margin_width = 4;
    disable_ligatures = "never";

    foreground = "#D8DEE9";
    background = "#2E3440";
    selection_foreground = "#000000";
    selection_background = "#FFFACD";
    url_color = "#0087BD";
    cursor = "#81A1C1";

    # Normal colors
    color0 = "#3B4252"; # black
    color1 = "#BF616A"; # red
    color2 = "#A3BE8C"; # green
    color3 = "#EBCB8B"; # yellow
    color4 = "#81A1C1"; # blue
    color5 = "#B48EAD"; # magenta
    color6 = "#88C0D0"; # cyan
    color7 = "#E5E9F0"; # white

    # Bright colors
    color8 = "#4C566A"; # bright black
    color9 = "#BF616A"; # bright red
    color10 = "#A3BE8C"; # bright green
    color11 = "#EBCB8B"; # bright yellow
    color12 = "#81A1C1"; # bright blue
    color13 = "#B48EAD"; # bright magenta
    color14 = "#8FBCBB"; # bright cyan
    color15 = "#ECEFF4"; # bright white
  });
in
  pkgs.symlinkJoin {
    name = "kitty-wrapped";
    paths = [pkgs.kitty];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/kitty --add-flags "--config=${config}"
    '';
  }
