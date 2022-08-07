{ inputs, pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    inputs.todo.packages."${system}".todo
    inputs.st.packages."${system}".st-snazzy
    maim
    firefox
    wofi
    waybar
    swappy
    swaybg
    grim
    wl-clipboard
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
    foot
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
