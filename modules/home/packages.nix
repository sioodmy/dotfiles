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
    self.packages.${pkgs.system}.cutefetch
    inputs.eww.packages.${pkgs.hostPlatform.system}.eww-wayland
    pulseaudio
    socat
    wget
    python3
    catimg
    cached-nix-shell
    firefox
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
