{ inputs, pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    inputs.st.packages."${system}".st-snazzy
    firefox
    wofi
    imv
    waybar
    swappy
    swaybg
    slurp
    grim
    wl-clipboard
    # cli tools
    ffmpeg
    unzip
    libnotify
    gnupg
    yt-dlp
    ripgrep
    rsync
    imagemagick
    scrot
    unrar
    tealdeer
    killall
    du-dust
    tokei
    bandwhich
    grex
    fd
    xh
    direnv
    figlet
    lm_sensors
    # gui apps
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
