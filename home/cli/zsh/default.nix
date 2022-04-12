{ pkgs, config, theme, ... }:

{
  home.packages = [ pkgs.devour ]; # for swallowing

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;
      character = {
        error_symbol = "[](bold red)";
        success_symbol = "[](bold green)";
        vicmd_symbol = "[](bold yellow)";
        format = "$symbol [|](bold bright-black) ";
      };
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
    sessionVariables = { 
      LC_ALL = "en_US.UTF-8"; 

      LF_ICONS= import ./LF_ICONS.nix;
    };
    history = {
      save = 1000;
      size = 1000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "$HOME/.cache/.zsh_hist";
    };

    dirHashes = {
      docs = "$HOME/docs";
      dl = "$HOME/download";
      vids = "$HOME/vids";
      music = "$HOME/music";
    };

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .# --upgrade";
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      need = "nix-shell -p";
      ytmp3 = ''
        yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
      cat = "bat --style=plain";
      grep = "rg";
      du = "dust";
      ps = "procs";
      neofetch = "fetch";
      htop = "btm";
      m = "mkdir -p";
      fcd = "cd $(find -type d | fzf)";
      ls = "exa --icons";
      sl = "ls";
      v = "nvim";
      tree = "exa --tree --icons";
      sxiv = "devour sxiv";
      mpv = "devour mpv";
      zathura = "devour zathura";
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      # Git aliases
      g = "git";
      gs = "git status";
      gc = "git commit -m";
      gp = "git push";
      ga = "git add";

    };

    plugins = with pkgs; [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "bd";
        src = pkgs.zsh-bd;
        file = "share/bd/bd.plugin.zsh";
      }
      {
        name = "you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "autopair";
        src = pkgs.zsh-autopair;
        file = "share/autopair/autopair.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file =
          "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
    ];
  };
}
