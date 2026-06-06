{
  pkgs,
  theme,
  ...
}:
let

  inherit (pkgs) lib;
  toDunstIni = lib.generators.toINI {
    mkKeyValue =
      key: value:
      let
        value' =
          if lib.isBool value then
            if value then "yes" else "no"
          else if lib.isString value then
            lib.strings.escapeNixString value
          else
            toString value;
      in
      "${key}=${value'}";
  };

  # credits: poz
  config = pkgs.writeText "dunst-config" (toDunstIni {
    global = {
      monitor = 1;
      follow = "none";
      width = 300;
      height = 300;
      origin = "top-center";
      offset = "0x15";
      scale = 0;
      notification_limit = 3;
      idle_threshold = 120;
      progress_bar = true;
      progress_bar_height = 10;
      progress_bar_frame_width = 0;
      progress_bar_min_width = 150;
      progress_bar_max_width = 300;
      indicate_hidden = "yes";
      transparency = 10;
      separator_height = 2;
      padding = 10;
      frame_width = 3;
      frame_color = "#A7C080";
      separator_color = "frame";
      highlight = "#D3C6AA";
      sort = "yes";
      font = "monospace 16";
      line_height = 0;
      markup = "full";
      format = "<b>%s</b>\n%b";
      alignment = "right";
      vertical_alignment = "center";
      show_age_threshold = 60;
      ellipsize = "middle";
      ignore_newline = "no";
      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = "yes";
      icon_position = "left";
      min_icon_size = 0;
      max_icon_size = 32;
      sticky_history = "yes";
      history_length = 20;
      browser = lib.getExe' pkgs.xdg-utils "xdg-open";
      always_run_script = true;
      title = "Dunst";
      class = "dunst";
      corner_radius = 10;
      ignore_dbusclose = false;
      force_xwayland = false;
      force_xinerama = false;
      mouse_left_click = "do_action, close_current";
      mouse_middle_click = "context";
      mouse_right_click = "close_all";
    };
    experimental = {
      per_monitor_dpi = false;
    };
    urgency_low = {
      background = "#4D5960";
      foreground = "#D3C6AA";
      timeout = 5;
    };
    urgency_normal = {
      background = "#4D5960";
      foreground = "#D3C6AA";
      timeout = 6;
    };
    urgency_critical = {
      background = "#4D5960";
      foreground = "#D3C6AA";
      frame_color = "#E67E80";
      timeout = 0;
    };
  });
in
pkgs.symlinkJoin {
  name = "dunst-wrapped";
  paths = [
    pkgs.dunst
  ]
  ++ (import ./scripts.nix { inherit pkgs; });
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/dunst --add-flags "-config ${config}";
  '';
}
