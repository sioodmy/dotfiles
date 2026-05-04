{
  inputs,
  pkgs,
  theme,
  ...
}:
let

  settings = {
    theme = "everforest_dark";
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

  config = pkgs.writeTextDir "/helix/config.toml" (builtins.readFile (toml.generate "/config.toml" settings));
  languages = pkgs.writeTextDir "/helix/langauges.toml" (builtins.readFile (import ./languages.nix {inherit pkgs;}));

  xdgconfig = pkgs.buildEnv{
    name = "helix-config-xdg";
    paths = [ config languages];
  };
in
pkgs.symlinkJoin {
  name = "helix-wrapped";
  # paths = [ inputs.helix.packages.${pkgs.system}.default ];
  paths = [ pkgs.helix ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/hx --set XDG_CONFIG_HOME "${xdgconfig}"
  '';
}
