{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    exa.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        scan_timeout = 5;
        character = {
          error_symbol = "[](bold red)";
          success_symbol = "[](bold green)";
          vicmd_symbol = "[](bold yellow)";
          format = "$symbol [|](bold bright-black) ";
        };
        git_commit = {commit_hash_length = 4;};
        line_break.disabled = false;
        lua.symbol = "[](blue) ";
        python.symbol = "[](blue) ";
        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue) ";
          disabled = false;
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      sessionVariables = {
        LC_ALL = "en_US.UTF-8";
        ZSH_AUTOSUGGEST_USE_ASYNC = "true";
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      };
      completionInit = ''
        autoload -U compinit
        zstyle ':completion:*' menu select
        zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' sort false
        zstyle ':completion:complete:*:options' sort false
        zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' menu yes select # search
        zstyle ':completion:*' list-grouped false
        zstyle ':completion:*' list-separator '''
        zstyle ':completion:*' group-name '''
        zstyle ':completion:*' verbose yes
        zstyle ':completion:*:matches' group 'yes'
        zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
        zstyle ':completion:*:messages' format '%d'
        zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
        zstyle ':fzf-tab:*' switch-group ',' '.'
        zstyle ':fzf-tab:complete:_zlua:*' query-string input
        zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview.sh $realpath'
        zstyle ":completion:*:git-checkout:*" sort false
        zstyle ':completion:*' file-sort modification
        zstyle ':completion:*:exa' sort false
        zstyle ':completion:files' sort false

        zmodload zsh/complist
        compinit
        _comp_options+=(globdots)
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -v '^?' backward-delete-char
      '';
      initExtra = ''
        autoload -U url-quote-magic
        zle -N self-insert url-quote-magic
        export FZF_DEFAULT_OPTS="
        --color fg:#c6d0f5
        --color fg+:#51576d
        --color bg:#303446
        --color bg+:#303446
        --color hl:#8caaee
        --color hl+:#8caaee
        --color info:#626880
        --color prompt:#a6d189
        --color spinner:#8caaee
        --color pointer:#8caaee
        --color marker:#8caaee
        --color border:#626880
        --color header:#8caaee
        --prompt ' | '
        --pointer ''
        --layout=reverse
        --border horizontal
        --height 40
        "

        # fzf-tab
        FZF_TAB_COMMAND=(
          ${pkgs.fzf}/bin/fzf
          --ansi
          --expect='$continuous_trigger' # For continuous completion
          --nth=2,3 --delimiter='\x00'  # Don't search prefix
          --layout=reverse --height="''${FZF_TMUX_HEIGHT:=50%}"
          --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
          '--query=$query'   # $query will be expanded to query string at runtime.
          '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
        )

        function run() {
          nix run nixpkgs#$@
        }

        command_not_found_handler() {
          printf 'Command not found ->\033[01;32m %s\033[0m \n' "$0" >&2
          return 127
        }

        clear
      '';
      history = {
        save = 1000;
        size = 1000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
      };

      dirHashes = {
        docs = "$HOME/docs";
        notes = "$HOME/docs/notes";
        dotfiles = "$HOME/dotfiles";
        dl = "$HOME/download";
        vids = "$HOME/vids";
        music = "$HOME/music";
        media = "/run/media/$USER";
      };

      shellAliases = let
        # for setting up license in new projects
        gpl3 = pkgs.fetchurl {
          url = "https://www.gnu.org/licenses/gpl-3.0.txt";
          sha256 = "OXLcl0T2SZ8Pmy2/dmlvKuetivmyPd5m1q+Gyd+zaYY=";
        };
      in
        with pkgs; {
          rebuild = "doas nix-store --verify; pushd ~dotfiles && doas nixos-rebuild switch --flake .# && notify-send \"Done\"&& bat cache --build; popd";
          cleanup = "doas nix-collect-garbage --delete-older-than 7d";
          bloat = "nix path-info -Sh /run/current-system";
          ytmp3 = ''
            ${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
          cat = "${lib.getExe bat} --style=plain";
          grep = lib.getExe ripgrep;
          du = lib.getExe du-dust;
          ps = lib.getExe procs;
          m = "mkdir -p";
          fcd = "cd $(find -type d | fzf)";
          ls = "${lib.getExe exa} -h --git --color=auto --group-directories-first -s extension";
          l = "ls -lF --time-style=long-iso";
          sc = "sudo systemctl";
          scu = "systemctl --user ";
          la = "${lib.getExe exa} -lah";
          tree = "${lib.getExe exa}--tree --icons";
          http = "${lib.getExe python3}-m http.server";
          burn = "pkill -9";
          diff = "diff --color=auto";
          killall = "pkill";
          gpl3init = "cp ${gpl3} LICENSE";
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "....." = "cd ../../../../";
          "......" = "cd ../../../../../";
          # helix > nvim
          v = "hx";
          nvim = "hx";
          vim = "hx";

          g = "git";
          sudo = "doas";
        };

      plugins = with pkgs; [
        {
          name = "zsh-nix-shell";
          src = zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "zsh-vi-mode";
          src = zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
        {
          name = "zsh-autopair";
          file = "zsh-autopair.plugin.zsh";
          src = fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
            sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
          };
        }
      ];
    };
  };
}
