{ pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [

        # desktop
        feh bspswallow 
        # cli tools
        exa ffmpeg unzip xclip bat pfetch
        libnotify gnupg update-nix-fetchgit yt-dlp
        ripgrep rsync mpc_cli imagemagick
        scrot maim bottom playerctl newsboat
        tealdeer cava killall onefetch
        # gui apps
        ungoogled-chromium obs-studio mpv sxiv 
        transmission-gtk pavucontrol pcmanfm
        # unfree apps (sorry daddy stallman)
        discord minecraft steam
        # dev tools
        python3 rustup git jdk dconf gcc
        # language servers for nvim
        rnix-lsp

    ];
}
