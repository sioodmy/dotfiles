{ pkgs, config, lib, theme, ... }: {
  home.packages = [
    (pkgs.writeShellScriptBin "dmenu" ''
      exec ${pkgs.rofi}/bin/rofi -dmenu "$@"
    '')
  ];

  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,window,calc,emoji";
      lines = 5;
      font = "${theme.colors.font} 14";
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
    in with theme.colors; {
      "*" = {
        bg-col = mkLiteral "#${bg}";
        bg-col-light = mkLiteral "#${bg}";
        border-col = mkLiteral "#${bg}";
        selected-col = mkLiteral "#${bg}";
        accent = mkLiteral "#${ac}";
        fg-col = mkLiteral "#${fg}";
        fg-col2 = mkLiteral "#${c1}";
        grey = mkLiteral "#${fg}";
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
}
