theme: rec
{
  packages = pkgs: let
    inherit (pkgs) callPackage;
  in
    {
      nvim = callPackage ./nvim {inherit theme;};
      zsh = callPackage ./zsh {};
      river = callPackage ./river {inherit theme;};
      foot = callPackage ./foot {inherit theme;};
      tofi = callPackage ./tofi {inherit theme;};
      mako = callPackage ./mako {inherit theme;};
      swaylock = callPackage ./swaylock {inherit theme;};
    }
    // (import ./misc-scripts {inherit pkgs;});

  shell = pkgs:
    pkgs.mkShell {
      name = "sioodmy-devshell";
      buildInputs = builtins.attrValues (packages pkgs);
    };
  module = {pkgs, ...}: {
    config = {
      environment.systemPackages = builtins.attrValues (packages pkgs);
    };
    imports = [
      ./packages.nix
      ./hyprland
      ./git
      ./gtk
    ];
  };
}
