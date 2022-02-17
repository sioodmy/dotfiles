{ pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [

        # desktop
        bspwm sxhkd feh rofi dunst
        # cli tools
        exa fzf ffmpeg unzip xclip bat pfetch
        libnotify gnupg update-nix-fetchgit yt-dlp
        ripgrep rsync ncmpcpp mpd tldr imagemagick
        scrot maim lolcat
        # gui apps
        ungoogled-chromium obs-studio mpv sxiv 
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
