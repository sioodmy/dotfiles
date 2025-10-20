{
  pkgs,
  theme,
  ...
}: let
    
  inherit (pkgs) lib;
  toDunstIni = lib.generators.toINI {
    mkKeyValue =
      key: value:
      let
        value' =
          if lib.isBool value then
            (lib.hm.booleans.yesNo value)
          else if lib.isString value then
            ''"${value}"''
          else
            toString value;
      in
      "${key}=${value'}";
  };

  config = pkgs.writeText "dunst-config" (toDunstIni {
    global = {
      width = 400;
      offset = "5x5";
    
      progress_bar_min_width = 380;
      progress_bar_max_width = 380;
      progress_bar_corner_radius = 2;

      padding = 10;
      horizontal_padding = 10;
      frame_width = 2;
      gap_size = 3;
      font = "Roboto Condensed 14";

      icon_theme = "rose-pine-icons";
      enable_recursive_icon_lookup = "yes";
      corner_radius = 2;

      background = "#393552";
      foreground = "#e0def4";
    };
    urgency_low = {
      background = "#393955";
      highlight = "#3e8fb0";
      frame_color = "#3e8fb0";
      default_icon = "dialog-information";
      format = ''<b><span foreground='#3e8fb0'>%s</span></b>\n%b'';
    };
    urgency_normal = {
      background = "#443c53";
      highlight = "#f6c177";
      frame_color = "#f6c177";
      default_icon = "dialog-warning";
      format = ''<b><span foreground='#f6c177'>%s</span></b>\n%b'';
    };
    urgency_critical = {
      background = "#433754";
      highlight = "#eb6f92";
      frame_color = "#eb6f92";
      default_icon = "dialog-error";
      format = ''<b><span foreground='#eb6f92'>%s</span></b>\n%b'';
    };
  });
in
  pkgs.symlinkJoin {
    name = "dunst-wrapped";
    paths =
      [
        pkgs.dunst
      ] ++ (import ./scripts.nix { inherit pkgs; });
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/dunst --add-flags "-config ${config}";
    '';
  }
