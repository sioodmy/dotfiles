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
      theme = "catppuccin_frappe";
      editor.lsp.display-messages = true;
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        "C-d" = ["half_page_down" "align_view_center"];
        "C-u" = ["half_page_up" "align_view_center"];
        "C-q" = ":bc";
        space.u = {
          f = ":format"; # format using LSP formatter
          w = ":set whitespace.render all";
          W = ":set whitespace.render none";
        };
      };
      editor = {
        color-modes = true;
        cursorline = true;
        idle-timeout = 1;
        line-number = "relative";
        scrolloff = 10;
        bufferline = "always";
        true-color = true;
        rulers = [80];
        indent-guides = {
          render = true;
        };
        rainbow-brackets = true;
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          separator = "|";
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
          select = "underline";
        };
      };
      
      
      };

      # credits: fuf <3
      languages = with pkgs; [
        {
          name = "bash";
          language-server = {
            command = "${nodePackages.bash-language-server}/bin/bash-language-server";
            args = ["start"];
          };
          auto-format = true;
        }
        {
          name = "cpp";
          language-server = {
            command = "${clang-tools}/bin/clangd";
            clangd.fallbackFlags = ["-std=c++2b"];
          };
        }
        {
          name = "nix";
          language-server = {command = lib.getExe inputs.nil.packages.${pkgs.system}.default;};
          config.nil.formatting.command = ["alejandra" "-q"];
        }
        {
          name = "clojure";
          scope = "source.clojure";
          injection-regex = "(clojure|clj|edn|boot|yuck)";
          file-types = ["clj" "cljs" "cljc" "clje" "cljr" "cljx" "edn" "boot" "yuck"];
          roots = ["project.clj" "build.boot" "deps.edn" "shadow-cljs.edn"];
          comment-token = ";";
          language-server = {command = "clojure-lsp";};
          indent = {
            tab-width = 2;
            unit = "  ";
          };
        }
      ];
    
  };

  home.packages = with pkgs; [
    # some other lsp related packages
    lldb
    gopls
    rust-analyzer
    texlab
    zls
    elixir_ls
    black
    shellcheck
    haskellPackages.haskell-language-server
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.jsonlint
    nodePackages.yarn
    sumneko-lua-language-server
    nodePackages.vscode-langservers-extracted
  ];
}
