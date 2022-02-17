{ pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [

        # desktop
        bspwm sxhkd feh dmenu j4-dmenu-desktop
        dunst
        # cli tools
        exa fzf ffmpeg unzip xclip bat pfetch
        libnotify gnupg update-nix-fetchgit yt-dlp
        ripgrep rsync ncmpcpp mpd tldr imagemagick
        # gui apps
        ungoogled-chromium obs-studio mpv sxiv st
        qbittorrent 
        # unfree apps 
        discord minecraft
        # dev tools
        python3 rustup git jdk
        # language servers for nvim
        rnix-lsp

        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    ];
}
