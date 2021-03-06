{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.programs.rofi;
in {
  options.modules.programs.rofi = { enable = mkEnableOption "rofi"; };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "dmenu" ''
        exec ${pkgs.rofi}/bin/rofi -dmenu "$@"
      '')
    ];

    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "drun,window,calc,emoji";
        sort = true;
        sorting-method = "fzf";
        matching = "fuzzy";
        lines = 5;
        font = "monospace 14";
        show-icons = true;
        icon-theme = "Papirus";
        terminal = "urxvt";
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Run ";
        display-window = " 﩯  Window ";
        display-calc = "  Calc ";
        display-emoji = "  Emoji ";
        sidebar-mode = true;

      };

      plugins = with pkgs; [ rofi-calc rofi-emoji ];

      theme = let inherit (config.lib.formats.rasi) mkLiteral;
      in {

        "*" = {
          bg-col = mkLiteral "#1e2030";
          bg-col-light = mkLiteral "#1e2030";
          border-col = mkLiteral "#1e2030";
          selected-col = mkLiteral "#1e2030";
          accent = mkLiteral "#8aadf4";
          fg-col = mkLiteral "#cad3f5";
          fg-col2 = mkLiteral "#ee99a0";
          grey = mkLiteral "#cad3f5";

          width = 600;
        };

        "element-text, element-icon , mode-switcher" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };

        "window" = {
          height = mkLiteral "360px";
          #                border = mkLiteral "3px";
          #                border-color = mkLiteral "@border-color";
          background-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "5px";
        };

        "mainbox, message" = { background-color = mkLiteral "@bg-col"; };

        "inputbar" = {
          children = mkLiteral "[prompt,entry]";
          background-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "5px";
          padding = mkLiteral "2px";
        };

        "prompt" = {
          background-color = mkLiteral "@accent";
          padding = mkLiteral "6px";
          text-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "3px";
          margin = mkLiteral "20px 0px 0px 20px";
        };

        "textbox-prompt-colon" = {
          exapnd = false;
          str = ":";
        };

        "entry" = {
          padding = mkLiteral "6px";
          margin = mkLiteral "20px 0px 0px 10px";
          text-color = mkLiteral "@fg-col";
          background-color = mkLiteral "@bg-col";
        };

        "listview" = {
          border = mkLiteral "0px 0px 0px";
          padding = mkLiteral "6px 0px 0px";
          margin = mkLiteral "10px 0px 0px 20px";
          columns = 2;
          background-color = mkLiteral "@bg-col";
        };

        "element" = {
          padding = mkLiteral "5px";
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@fg-col";
        };

        "element-icon" = { size = mkLiteral "25px"; };

        "element selected" = {
          background-color = mkLiteral "@selected-col";
          text-color = mkLiteral "@fg-col2";
        };

        "textbox" = {
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@fg-col";
        };

        "mode-switcher" = { spacing = 0; };

        "button" = {
          padding = mkLiteral "10px";
          background-color = mkLiteral "@bg-col-light";
          text-color = mkLiteral "@grey";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };

        "button selected" = {
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@accent";
        };

      };

    };

    services.sxhkd.keybindings = {
      "super + space" = "rofi -show drun";
      "XF86Search" = "rofi -show drun";
      "super + c" = "rofi -show calc";
      "super + period" = "rofi -show emoji";
      "alt + Tab" = "rofi -show window";
    };
  };
}
