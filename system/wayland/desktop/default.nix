{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./gtk
  ];

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;

  environment.systemPackages =
    (import ./wrapped.nix {inherit pkgs inputs config;})
    ++ (with pkgs; [
      mpv
      libnotify
      dart-sass

      librewolf
      libreoffice-fresh
      ytmdl
      thunderbird
      nicotine-plus
      gnome.gnome-calculator
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
    ]);
}
