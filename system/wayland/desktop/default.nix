{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;

  environment.systemPackages =
    (import ./wrapped.nix {inherit pkgs inputs config;})
    ++ [(import ./firefox {inherit pkgs;})]
    ++ (with pkgs; [
      mpv
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
    ]);
}
