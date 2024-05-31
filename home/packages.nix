{pkgs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    libreoffice-fresh
    thunderbird
    nicotine-plus
    fuzzel
    gnome.gnome-calculator
    brave
    inkscape
    ledger-live-desktop
    ledger_agent
    tdesktop
    calcurse
    pulseaudio
    signal-desktop
    transmission-gtk
    gimp
    wireshark
    keepassxc
    dconf
  ];
}
