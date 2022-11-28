{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override {
      plugins = with self.packages.${pkgs.system}; [
        rofi-calc-wayland
        rofi-emoji-wayland
      ];
    };
    font = "Iosevka Nerd Font 13";
    extraConfig = {
      modi = "drun,filebrowser,calc,emoji";
      drun-display-format = " {name} ";
      sidebar-mode = true;
      matching = "prefix";
      scroll-method = 0;
      disable-history = false;
      show-icons = true;

      display-drun = " Run";
      display-run = " Run";
      display-filebrowser = " Files";
      display-calc = " Calculator";
      display-emoji = "💀 Emoji";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background = mkLiteral "#292c3c";
        background-alt = mkLiteral "#292c3c";
        foreground = mkLiteral "#c6d0f5";
        selected = mkLiteral "#303446";
        active = mkLiteral "#8caaee";
        urgent = mkLiteral "#303446";
      };
      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = mkLiteral "false";
        width = mkLiteral "600px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        enabled = mkLiteral "true";
        border-radius = mkLiteral "20px";
        border = mkLiteral "4px";
        border-color = mkLiteral "#414559";
        cursor = "default";
        background-color = mkLiteral "@background";
      };
      "mainbox" = {
        enabled = true;
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[inputbar,listbox]";
      };
      "listbox" = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "10px 10px 10px 15px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[message,listview]";
      };
      "inputbar" = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "30px 20px 30px 20px";
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
        orientation = mkLiteral "horizontal";
        children = mkLiteral "[prompt,entry]";
      };
      "entry" = {
        enabled = true;
        expand = true;
        width = mkLiteral "300px";
        padding = mkLiteral "12px 15px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Search";
        placeholder-color = mkLiteral "inherit";
      };
      "prompt" = {
        width = mkLiteral "64px";
        font = "Iosevka Nerd Font 13";
        padding = mkLiteral "10px 20px 10px 20px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };
      "mode-switcher" = {
        enabled = true;
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };
      "button" = {
        width = mkLiteral "48px";
        font = "Iosevka Nerd Font 14";
        padding = mkLiteral "8px 5px 8px 8px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };
      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };
      "listview" = {
        enabled = true;
        columns = 2;
        lines = 7;
        cycle = true;
        dynamic = true;
        srollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = false;
        spacing = mkLiteral "5px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "default";
      };
      "element" = {
        enabled = true;
        spacing = mkLiteral "15px";
        padding = mkLiteral "7px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element normal.active" = {
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@active";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element selected.active" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@active";
      };
      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "32px";
        cursor = mkLiteral "inherit";
      };
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "message" = {background-color = mkLiteral "transparent";};
      "textbox" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "error-message" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "20px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
  };
}
