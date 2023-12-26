{pkgs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    ledger-live-desktop
    ledger_agent
    caprine-bin
    pulseaudio
    signal-desktop
    transmission-gtk
    gimp
    wireshark
    keepassxc
    dconf
  ];
}
