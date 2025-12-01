{
  pkgs,
  theme,
  ...
}:
let

  settings = {
    theme = "rose_pine_moon";
    keys.normal = {
      "{" = "goto_prev_paragraph";
      "}" = "goto_next_paragraph";
      "X" = "extend_line_above";
      "esc" = [
        "collapse_selection"
        "keep_primary_selection"
      ];
      space.space = "file_picker";
      space.w = ":w";
      space.q = ":bc";
      "C-q" = ":xa";
      space.u = {
        f = ":format"; # format using LSP formatter
        W = ":set whitespace.render all";
        w = ":set whitespace.render none";
        G = ":set indent-guide.render true";
        g = ":set indent-guide.render false";
      };
    };
    keys.select = {
      "%" = "match_brackets";
    };
    editor = {
      color-modes = true;
      cursorline = true;
      mouse = false;
      idle-timeout = 1;
      line-number = "relative";
      scrolloff = 5;
      completion-replace = true;
      bufferline = "always";
      true-color = true;
      rulers = [ 80 ];
      soft-wrap.enable = true;
      indent-guides = {
        render = false;
      };
      lsp = {
        display-messages = true;
        display-inlay-hints = true;
      };

      gutters = [
        "diagnostics"
        "line-numbers"
        "spacer"
        "diff"
      ];
      statusline = {
        left = [
          "mode"
          "selections"
          "spinner"
          "file-name"
          "total-line-numbers"
        ];
        center = [ "position-percentage" ];
        right = [
          "diagnostics"
          "file-encoding"
          "file-line-ending"
          "file-type"
          "position"
        ];
        mode = {
          normal = "NORMAL";
          insert = "INSERT";
          select = "SELECT";
        };
      };

      whitespace.characters = {
        space = "·";
        nbsp = "⍽";
        tab = "→";
        newline = "⤶";
      };

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };

  toml = pkgs.formats.toml { };

  config = toml.generate "config.toml" settings;
in
pkgs.symlinkJoin {
  name = "helix-wrapped";
  paths = [ pkgs.helix ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/hx --add-flags "--config ${config}"
  '';
}
