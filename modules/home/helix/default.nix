{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages."x86_64-linux".default;
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
        rainbow-brackets = true;
        completion-replace = true;
        cursor-word = true;
        bufferline = "always";
        true-color = true;
        rulers = [80];
        soft-wrap.enable = true;
        indent-guides = {
          render = true;
        };
        sticky-context.enable = false;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          mode-separator = "";
          separator = "";
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
        "ui.virtual.inlay-hint" = {
          fg = "surface1";
          modifiers = ["italic"];
        };
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
      {
        name = "typst";
        scope = "source.typst";
        injection-regex = "^typst$";
        file-types = ["typ"];
        comment-token = "//";
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        roots = [];

        language-server = {
          command = lib.getExe typst-lsp;
        };
        formatter.command = lib.getExe typst-fmt;
        auto-format = true;
      }
    ];
  };

  home.packages = with pkgs; [
    # some other lsp related packages / dev tools
    typst
    shellcheck
    lldb
    gopls
    rust-analyzer
    clang-tools
    nodejs
    guile
    nim
    zig
    texlab
    zls
    jre8
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
    luajitPackages.lua-lsp
    nodePackages.vscode-langservers-extracted
    cargo
  ];
}
