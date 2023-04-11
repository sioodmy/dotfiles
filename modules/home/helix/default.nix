{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha_transparent";
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "X" = "extend_line_above";
        "esc" = ["collapse_selection" "keep_primary_selection"];
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":bc";
        "C-q" = ":xa";
        space.u = {
          f = ":format"; # format using LSP formatter
          w = ":set whitespace.render all";
          W = ":set whitespace.render none";
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
        bufferline = "always";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        true-color = true;
        rulers = [80];
        soft-wrap.enable = true;
        indent-guides = {
          render = true;
        };
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          left = ["mode" "selections" "spinner" "file-name" "total-line-numbers"];
          center = [];
          right = ["diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage" "position"];
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
          select = "block";
        };
      };
    };

    # override catppuccin theme and remove background to fix transparency
    themes = {
      catppuccin_mocha_transparent = {
        "inherits" = "catppuccin_mocha";
        "ui.background" = "{}";
      };
    };

    languages = with pkgs; [
      {
        name = "cpp";
        auto-format = true;
        language-server = {
          command = "${clang-tools}/bin/clangd";
          clangd.fallbackFlags = ["-std=c++2b"];
        };
      }
      {
        name = "nix";
        language-server.command = pkgs.nil;
        auto-format = true;
        formatter = {
          command = lib.getExe alejandra;
          args = ["-q"];
        };
      }
      {
        name = "rust";
        formatter.command = lib.getExe rustfmt;
        auto-format = true;
      }
    ];
  };

  home.packages = with pkgs; [
    # some other lsp related packages / dev tools
    lldb
    gopls
    rust-analyzer
    texlab
    zls
    gcc
    uncrustify
    black
    alejandra
    shellcheck
    gawk
    haskellPackages.haskell-language-server
    java-language-server
    kotlin-language-server
    nodePackages.vls
    nodePackages.jsonlint
    nodePackages.yarn
    sumneko-lua-language-server
    nodePackages.vscode-langservers-extracted
    cargo
  ];
}
