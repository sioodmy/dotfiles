{
  inputs,
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    (symlinkJoin {
      name = ledger-live-desktop.name;
      paths = [ledger-live-desktop];
      buildInputs = [makeWrapper];
      postBuild = "wrapProgram $out/bin/ledger-live-desktop --add-flags --use-gl=desktop";
    })
    macchina
    catimg
    prismlauncher
    jre8
    monero-gui
    cached-nix-shell
    todo
    qalculate-gtk
    yt-dlp
    tdesktop
    tracy
    hyperfine
    fzf
    glow
    nmap
    unzip
    ripgrep
    rsync
    ttyper
    libreoffice-fresh-unwrapped
    gamemode
    brave
    tessen
    gopass
    ffmpeg
    gimp
    imagemagick
    aseprite
    transmission-gtk
    bandwhich
    grex
    fd
    xfce.thunar
    xh
    jq
    figlet
    lm_sensors
    keepassxc
    dconf
    gcc
  ];
}
