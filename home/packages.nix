{
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    ledger-live-desktop
    libreoffice-fresh
    logseq
    ledger_agent
    caprine-bin
    pulseaudio
    session-desktop
    transmission-gtk
    prismlauncher
    tdesktop
    gimp
    wireshark
    inkscape
    keepassxc
    dconf
  ];
}
