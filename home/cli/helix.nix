{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_frappe";
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
        # rainbow-brackets = true;
        completion-replace = true;
        bufferline = "always";
        true-color = true;
        rulers = [80];
        soft-wrap.enable = true;
        indent-guides = {
          render = true;
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          # mode-separator = "";
          # separator = "";
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

    languages = {
      language = [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "${pkgs.shfmt}/bin/shfmt";
            args = ["-i" "2" "-"];
          };
        }
        {
          name = "html";
          file-types = ["html" "tera"];
        }
        {
          name = "clojure";
          injection-regex = "(clojure|clj|edn|boot|yuck)";
          file-types = ["clj" "cljs" "cljc" "clje" "cljr" "cljx" "edn" "boot" "yuck"];
        }
      ];

      language-server = {
        bash-language-server = {
          command = "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server";
          args = ["start"];
        };

        clangd = {
          command = "${pkgs.clang-tools}/bin/clangd";
          clangd.fallbackFlags = ["-std=c++2b"];
        };

        nil = {
          command = lib.getExe pkgs.nil;
          config.nil.formatting.command = ["${lib.getExe pkgs.alejandra}" "-q"];
        };

        vscode-css-language-server = {
          command = "${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver";
          args = ["--stdio"];
        };
      };
    };
  };

  home.packages = with pkgs; [
    # some other lsp related packages / dev tools
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
    nodePackages.vscode-langservers-extracted
    cargo
    go
  ];
}
