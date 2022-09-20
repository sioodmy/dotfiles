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
        matching = "prefix";
        scroll-method = 0;
        disable-history = false;
        show-icons = true;

        display-drun = " ";
        display-run = " ";
        display-filebrowser = " ";
        display-combi = " ";
        display-emoji = "ﲃ ";

      };
      theme = let inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          bg = mkLiteral "#303446";
          fg = mkLiteral "#c6d0f5";
          button = mkLiteral "#8caaee";
          background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };
        "element-text,element-icon,mode-switcher" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "window" = {
          transparency = "real";
          width = mkLiteral "30%";
          border = mkLiteral "0px";
          border-radius = mkLiteral "15px";
          height = mkLiteral "50%";
        };
        "prompt" = {
          enabled = true;
          background-color = mkLiteral "@bg";
          padding = mkLiteral "12px 22px 12px 16px";
          text-color = mkLiteral "@fg";
          border-radius = mkLiteral "50%";
          expand = false;
          font = "Iosevka Nerd Font 14";
        };
        "entry" = {
          placeholder = "Search";
          placeholder-color = mkLiteral "#8caaee";
          text-color = mkLiteral "#8caaee";
          expand = true;
          padding = mkLiteral "12px 15px";
          border-radius = mkLiteral "100%";
        };
        "inputbar" = {
          children = mkLiteral "[entry,mode-switcher]";
          background-image = mkLiteral ''url("bg.jpg", width)'';
          expand = false;
          border-radius = mkLiteral "10px 10px 0 0px";
          font = "Lato 14";
          margin = mkLiteral "0 0 20px 0";
          spacing = mkLiteral "10px";
          padding = mkLiteral "30px 30px 20px 20px";
        };
        "listview" = {
          columns = 1;
          lines = 7;
          cycle = false;
          dynamic = true;
          layout = mkLiteral "vertical";
          padding = mkLiteral "0 15px 0 15px";
          scrollbar = false;
        };
        "mainbox" = { children = mkLiteral "[inputbar,listview]"; };
        "element" = {
          #          orientation = mkLiteral "vertical";
          padding = mkLiteral "7px";
          #          font = "Lato 14";
          #          margin = mkLiteral "5px 5px 5px 5px";
          spacing = mkLiteral "75px";
          border-radius = mkLiteral "100%";
          background-color = mkLiteral "transparent";
          cursor = mkLiteral "pointer";
        };
        "element-text" = {
          expand = true;
          vertical-align = mkLiteral "0.5";
          margin = mkLiteral "0% 1% 0% 1%";
          font = "Lato 14";
          cursor = mkLiteral "inherit";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "element-icon" = {
          size = mkLiteral "32px";
          cursor = mkLiteral "inherit";
        };
        "element selected" = {
          background-color = mkLiteral "@button";
          font = "Lato 14";
          text-color = mkLiteral "@bg";
          border-radius = mkLiteral "10px";
        };
        "mode-switcher" = {
          spacing = 0;
          border-radius = mkLiteral "10px";
          background-color = mkLiteral "transparent";
          margin = mkLiteral "0 20px 20px 20px";
        };

        "button" = {
          padding = mkLiteral "8px 5px 8px 8px";
          margin = mkLiteral "3px";
          width = mkLiteral "48px";
          border-radius = mkLiteral "100%";
          font = "Lato, Iosevka Nerd Font 14";
        };
        "button selected" = { background-color = mkLiteral "#414559"; };

      };
    };
  };
}
