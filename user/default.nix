theme: rec {
  packages = pkgs: let
    inherit (pkgs) callPackage;
  in {
    cli =
      {
        nvim = callPackage ./nvim {inherit theme;};
        zsh = callPackage ./zsh {};
      }
      // (import ./misc-scripts {inherit pkgs;});
    desktop = {
      river = callPackage ./river {inherit theme;};
      foot = callPackage ./foot {inherit theme;};
      tofi = callPackage ./tofi {inherit theme;};
      mako = callPackage ./mako {inherit theme;};
      swaylock = callPackage ./swaylock {inherit theme;};
    };
  };

  shell = pkgs:
    pkgs.mkShell {
      name = "sioodmy-devshell";
      buildInputs = builtins.attrValues (packages pkgs).cli;
    };
  module = {pkgs, ...}: {
    config = {
      environment.systemPackages = builtins.concatLists (map (x: builtins.attrValues x) (builtins.attrValues (packages pkgs)));
    };
    imports = [
      ./packages.nix
      ./git
      ./gtk
    ];
  };
}
