{ config, pkgs, lib, theme, ... }:
with lib;
let cfg = config.modules.cli.helix;
in {
  options.modules.cli.helix = { enable = mkEnableOption "helix"; };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        lsp.display-messages = true;
        editor = {
          search.smart-case = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
        theme = "base16";
      };
      themes =  {
          base16 = with theme.colors; let
            background = "#${bg}";
            foreground = "#${fg}";
            transparent = "none";
            gray = "#${c8}";
            dark-gray = "#${c0}";
            white = "#${c7}";
            black = "#${ba}";
            red = "#${c1}";
            light-red = "${c9}";
            green = "#${c2}";
            yellow = "#${c3}";
            orange = "#${c10}";
            blue = "#${c4}";
            magenta = "#${c5}";
            pink = "${c6}";
            cyan = "#${c12}";
          in {
            "atribute" = blue;
            "keyword" = blue;
            "keyword.directive" = red;
            "namespace" = orange;
            "punctation" = foreground;
            "punctation.delimiter" = blue;
            "operator" = blue;
            "special" = orange;
            "variable.other.member" = green;
            "variable" = orange;
            "variable.parameter" = { fg = pink; };
            "variable.builtin" = magenta;
            "type" = blue;
            "type.builtin" = foreground;
            "constructor" = blue;
            "function" = red;
            "function.macro" = light-red;
            "function.builtin" = blue;
            "tag" = orange;
            "comment" = gray;
            "constant" = foreground;
            "constant.builtin" = green;
            "string" = green;
            "constant.numeric" = blue;
            "constant.character.escape" = orange;
            "label" = orange;

            "markup.heading" = magenta;
            "markup.bold" = { modifiers = ["bold"]; };
            "markup.italic" = { modifiers = ["italic"]; };
            "markup.link.url" = { fg = white;  modifiers = ["underlined"]; };
            "markup.link.text" = orange;
            "markup.raw" = orange;
            "diff.plus" = green;
            "diff.minus" = red;
            "diff.delta" = magenta;
            
            "ui.background" = { bg = background;};
            "ui.linenr" = { fg = dark-gray; };
            "ui.linenr.selected" = { fg = magenta; };
            "ui.statusline" = { fg = foreground; bg = black; };
            "ui.statusline.inactive" = { fg = magenta; bg = gray; };
            "ui.popup" = { bg = black; };
            "ui.window" = { fg = light-red; };
            "ui.help" = { bg = black; fg = foreground; };
            "ui.text" = { fg = pink; };
            "ui.text.focus" = { fg = white; };
            "ui.selection" = { bg = black; };
            "ui.selection.primary" = { bg = black; };

            "ui.cursor.select" = { bg = magenta; };
            "ui.cursor.insert" = { bg = blue; };
            "ui.cursor.match" = { fg = foreground; bg = green; };
            "ui.cursor" = { modifiers = ["reversed"]; };
            "ui.highlight" = { bg = light-red; };

            "ui.menu.selected" = { fg = green; bg = black; };

            
            "diagnostic" = { modifiers = ["underlined"]; };

            "warning" = yellow;
            "error" = red;
            "info" = blue;
            "hint" = orange;
          };
      };
    };
    };
 } 
