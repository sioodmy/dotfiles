{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.programs.shell;
in {
  options.modules.programs.shell = { enable = mkEnableOption "shell"; };

  config = mkIf cfg.enable {
    programs.exa.enable = true;
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.starship = {
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
        git_commit = { commit_hash_length = 4; };
        line_break.disabled = false;
        lua.symbol = "[](blue) ";
        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue) ";
          disabled = false;
        };
      };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      sessionVariables = { LC_ALL = "en_US.UTF-8"; };
      completionInit = ''
        autoload -U compinit
        zstyle ':completion:*' menu select
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
        dl = "$HOME/download";
        vids = "$HOME/vids";
        music = "$HOME/music";
        media = "/run/media/$USER";
      };

      shellAliases = {
        rebuild =
          "sudo nix-store --verify; sudo nixos-rebuild switch --flake .#";
        cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
        nixtest = "sudo nixos-rebuild test --flake .#graphene --fast";
        bloat = "nix path-info -Sh /run/current-system";
        ytmp3 = ''
          yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
        cat = "bat --style=plain";
        grep = "rg";
        du = "dust";
        ps = "procs";
        m = "mkdir -p";
        fcd = "cd $(find -type d | fzf)";
        ls = "exa --icons --group-directories-first";
        la = "exa -lah";
        tree = "exa --tree --icons";
        http = "python3 -m http.server";

      };

      plugins = with pkgs; [
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
    };

    programs.git = {
      enable = true;
      userName = "sioodmy";
      userEmail = "sioodmy@tuta.io";
      extraConfig = {
        init = { defaultBranch = "main"; };
        delta = {
          syntax-theme = "Nord";
          line-numbers = true;
        };
      };
      delta = { enable = true; };
      aliases = {
        co = "checkout";
        d = "diff";
        ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
        pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
        st = "status";
        br = "branch";
        df =
          "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
        hist = ''
          log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
        llog = ''
          log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative'';
        edit-unmerged =
          "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
      };
    };

  };
}
