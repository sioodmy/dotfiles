{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = false;
  environment.systemPackages = with pkgs; [
    river
    mpv
    emacs
    mako
    firefox-esr-128
    overskride
    libnotify
    dart-sass

    libreoffice-fresh
    ytmdl
    thunderbird
    nicotine-plus
    gnome.gnome-calculator
    brave
    inkscape
    ledger-live-desktop
    ledger_agent
    tdesktop
    calcurse
    pulseaudio
    signal-desktop
    gimp
    wireshark
    keepassxc
    go
  ];
}
