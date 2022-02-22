{ pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [

        # desktop
        bspwm sxhkd feh rofi dunst bspswallow 
        # cli tools
        exa fzf ffmpeg unzip xclip bat pfetch
        libnotify gnupg update-nix-fetchgit yt-dlp
        ripgrep rsync ncmpcpp mpd mpc_cli imagemagick
        scrot maim bottom playerctl newsboat
        tealdeer cava
        # gui apps
        ungoogled-chromium obs-studio mpv sxiv 
        transmission-gtk pavucontrol 
        # unfree apps (sorry daddy stallman)
        discord minecraft 
        # dev tools
        python3 rustup git jdk dconf gcc
        # language servers for nvim
        rnix-lsp

        # fonts
        source-sans
        twemoji-color-font
        (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode"]; })

    ];
}
