{pkgs, ...}:
let
  lib = pkgs.lib;
languages = {
    language =
      let

        prettier = lang: {
          command = lib.getExe pkgs.prettier;
          args = [
            "--parser"
            lang
          ];
        };
      in
      [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = lib.getExe pkgs.shfmt;
            args = [
              "-i"
              "2"
            ];
          };
        }
        {
          name = "clojure";
          injection-regex = "(clojure|clj|edn|boot|yuck)";
          file-types = [
            "clj"
            "cljs"
            "cljc"
            "clje"
            "cljr"
            "cljx"
            "edn"
            "boot"
            "yuck"
          ];
        }
        {
          name = "cmake";
          auto-format = true;
          language-servers = [ "cmake-language-server" ];
          formatter = {
            command = lib.getExe pkgs.cmake-format;
            args = [ "-" ];
          };
        }
        {
          name = "css";
          formatter = prettier "css";
          language-servers = [
            "tailwindcss-ls"
          ];
        }
        {
          name = "javascript";
          auto-format = true;
          language-servers = [
            "typescript-language-server"
          ];
        }
        {
          name = "html";
          formatter = prettier "html";
          language-servers = [
            "tailwindcss-ls"
          ];
        }
        {
          name = "markdown";
          language-servers = [
            "dprint"
            "markdown-oxide"
          ];
        }
        {
          name = "nix";
          language-servers = [
            "nil"
            "uwu-colors"
          ];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "basedpyright"
            "ruff"
          ];
        }
        {
          name = "qml";
          language-servers = [
            "qmlls"
            "uwu-colors"
          ];
        }
        {
          name = "scss";
          formatter = prettier "scss";
          language-servers = [
            "tailwindcss-ls"
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = [
            "dprint"
            "typescript-language-server"
            "uwu-colors"
          ];
        }
        {
          name = "typst";
          auto-format = true;
          language-servers = [ "tinymist" ];
        }
        {
          name = "vue";
          auto-format = true;
          formatter = prettier "vue";
          language-servers = [
            "typescript-language-server"
            "tailwindcss-ls"
          ];
        }
      ];

    language-server = {
      basedpyright.command = "${pkgs.basedpyright}/bin/basedpyright-langserver";

      vscode-css-language-server= {
        command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
      };
      vscode-html-language-server= {
        command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
      };

      bash-language-server = {
        command = lib.getExe pkgs.bash-language-server;
        args = [ "start" ];
      };

      clangd = {
        command = "${pkgs.clang-tools}/bin/clangd";
        clangd.fallbackFlags = [ "-std=c++2b" ];
      };

      cmake-language-server = {
        command = lib.getExe pkgs.cmake-language-server;
      };

      dprint = {
        command = lib.getExe pkgs.dprint;
        args = [ "lsp" ];
      };

      nil = {
        command = lib.getExe pkgs.nil;
        config.nil.formatting.command = [
          "${lib.getExe pkgs.nixfmt}"
          "-q"
        ];
      };

      qmlls = {
        command = "${pkgs.qt6.qtdeclarative}/bin/qmlls";
        args = [ "-E" ];
      };

      ruff = {
        command = lib.getExe pkgs.ruff;
        args = [ "server" ];
      };

      tailwindcss-ls = {
        command = lib.getExe pkgs.tailwindcss-language-server;
        args = [ "--stdio" ];
      };

      tinymist = {
        command = lib.getExe pkgs.tinymist;
        config = {
          exportPdf = "onType";
          outputPath = "$root/target/$dir/$name";
          formatterMode = "typstyle";
          formatterPrintWidth = 80;
        };
      };


      uwu-colors = {
        command = "${pkgs.uwu-colors}/bin/uwu_colors";
        # command = "uwu_colors"; # useful for testing
      };

    };
  };

  toml = pkgs.formats.toml { };
in
toml.generate "/languages.toml" languages
