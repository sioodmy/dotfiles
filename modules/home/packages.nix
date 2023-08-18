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
    (symlinkJoin {
      name = caprine-bin.name;
      paths = [caprine-bin];
      buildInputs = [makeWrapper];
      postBuild = "wrapProgram $out/bin/caprine --add-flags --no-sandbox --set GDK_BACKEND x11";
    })
    ledger_agent
    pulseaudio
    sherlock
    # sorry bros
    vscodium-fhs 
    thunderbird
    pfetch-rs
    schildichat-desktop
    qrcp
    nheko
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
