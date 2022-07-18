{ inputs, pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    inputs.todo.packages."${system}".todo
    maim
    # cli tools
    ffmpeg
    unzip
    xclip
    libnotify
    gnupg
    yt-dlp
    ripgrep
    rsync
    imagemagick
    scrot
    newsboat
    unrar
    tealdeer
    killall
    onefetch
    neofetch
    du-dust
    bunnyfetch
    tokei
    bandwhich
    grex
    fd
    xh
    direnv
    figlet
    lm_sensors
    wifite2
    # gui apps
    nsxiv
    transmission-gtk
    pavucontrol
    keepassxc
    xfce.thunar
    # unfree apps (sorry daddy stallman)
    minecraft
    # dev tools
    python3
    git
    jdk
    dconf
    gcc
    rustc
    rustfmt
    cargo
  ];
}
