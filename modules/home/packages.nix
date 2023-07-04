{
  inputs,
  pkgs,
  self,
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
    
    pulseaudio
    cinny-desktop
    schildichat-desktop
    socat
    transmission-gtk
    wget
    python3
    catimg
    cached-nix-shell
    prismlauncher
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
