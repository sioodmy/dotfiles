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
    ledger_agent
    catimg
    cached-nix-shell
    todo
    yt-dlp
    tdesktop
    hyperfine
    glow
    nmap
    unzip
    rsync
    gamemode
    brave
    ffmpeg
    gimp
    imagemagick
    bc
    aseprite
    transmission-gtk
    bandwhich
    grex
    fd
    xh
    jq
    lm_sensors
    keepassxc
    dconf
  ];
}
