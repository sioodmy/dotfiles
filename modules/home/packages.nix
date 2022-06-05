{ inputs, pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    inputs.todo.packages."${system}".todo
    maim
    # cli tools
    ffmpeg unzip xclip
    libnotify gnupg yt-dlp
    ripgrep rsync imagemagick
    scrot newsboat unrar
    tealdeer killall onefetch
    du-dust pfetch tokei bandwhich
    grex fd xh
    # gui apps
    obs-studio mpv nsxiv tdesktop monero-gui
    transmission-gtk pavucontrol pcmanfm
    libreoffice-fresh
    # unfree apps (sorry daddy stallman)
    minecraft
    # dev tools
    python3 git jdk dconf gcc rustc rustfmt cargo
  ];
}
