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

  colorScheme = inputs.nix-colors.colorSchemes.everforest;

  environment.systemPackages =
    (import ./wrapped.nix {inherit pkgs inputs config;})
    ++ (with pkgs; [
      mpv
      libnotify
      dart-sass
      librewolf
      tor-browser
      tdesktop
      libreoffice-fresh
      ytmdl
      sent
      nicotine-plus
      inkscape
      ledger-live-desktop
      ledger_agent
      pulseaudio
      signal-desktop
      gimp
      keepassxc
    ]);
}
