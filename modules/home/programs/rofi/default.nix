{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.rofi;
in {
  options.modules.programs.rofi = { enable = mkEnableOption "rofi"; };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Lato 14";
      extraConfig = {
        modi = "drun,run,combi,filebrowser";
        drun-display-format = " {name} ";
        sidebar-mode = true;
        matching = "fuzzy";
        scroll-method = 0;
        disable-history = true;

        display-drun = "  Menu";
        display-run = "  Run";
        display-filebrowser = "  Browse";
        display-combi = "   Binds";
        display-emoji = "ﲃ   Emoji";

      };
      theme = let inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          bg = mkLiteral "#2e3440";
          fg = mkLiteral "#81a1c1";
          button = mkLiteral "#81a1c1";
          background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };
        "element-text,element-icon,mode-switcher" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "window" = {
          transparency = "real";
          width = mkLiteral "60%";
          border = mkLiteral "10px";
          border-radius = mkLiteral "15px";
          border-color = mkLiteral "#4c566a";
          height = mkLiteral "70%";
        };
        "prompt" = {
          enabled = true;
          background-color = mkLiteral "@bg";
          padding = mkLiteral "20px 15px 5px 15px";
          text-color = mkLiteral "@fg";
          border-radius = mkLiteral "50%";
          expand = true;
          font = "Iosevka Nerd Font 14";
        };
        "textbox-prompt-colon" = {
          expand = false;
          padding = mkLiteral "1% 2% 0% 2%";
          margin = mkLiteral "0% 1% 0% 1%";
          font = "Iosevka Nerd Font 26";
          border-radius = mkLiteral "50%";
          str = " ";
        };
        "entry" = {
          placeholder = "Search";
          placeholder-color = mkLiteral "#81a1c1";
          text-color = mkLiteral "#81a1c1";
          expand = true;
          padding = mkLiteral "2.0%";
          border-radius = mkLiteral "50%";
        };
        "inputbar" = {
          children = mkLiteral "[prompt,textbox-prompt-colon,entry]";
          background-image = mkLiteral ''url("bg.jpg")'';
          expand = false;
          border-radius = mkLiteral "10px 10px 0 0px";
          font = "Lato 14";
          margin = mkLiteral "0 0 20px 0";
          padding = mkLiteral "200px 20px 20px 20px";
        };
        "listview" = {
          columns = 3;
          lines = 2;
          cycle = false;
          dynamic = true;
          layout = mkLiteral "vertical";
          padding = mkLiteral "0 15px 0 15px";
          scrollbar = false;
        };
        "mainbox" = {
          children = mkLiteral "[inputbar,listview,mode-switcher]";
        };
        "element" = {
          orientation = mkLiteral "vertical";
          padding = mkLiteral "5% 2% 2% 0";
          font = "Lato 14";
          margin = mkLiteral "5px 5px 5px 5px";
          border-radius = mkLiteral "10px";
          background-color = mkLiteral "#3b4252";
        };
        "element-text" = {
          expand = true;
          vertical-align = mkLiteral "0.5";
          margin = mkLiteral "0% 1% 0% 1%";
          font = "Lato 14";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "element selected" = {
          background-color = mkLiteral "@button";
          font = "Lato 14";
          text-color = mkLiteral "#2e3440";
          border-radius = mkLiteral "10px";
        };
        "mode-switcher" = {
          spacing = 0;
          border-radius = mkLiteral "10px";
          margin = mkLiteral "0 20px 20px 20px";
        };

        "button" = {
          padding = mkLiteral "15px";
          margin = 0;
          font = "Lato, Iosevka Nerd Font 14";
          background-color = mkLiteral "#434c5e";
          text-color = mkLiteral "#d8dee9";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };
        "button selected" = {
          padding = mkLiteral "15px";
          margin = 0;
          background-color = mkLiteral "#3b4252";
          text-color = mkLiteral "#81a1c1";
        };

      };
    };
  };
}
