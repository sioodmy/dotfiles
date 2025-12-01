rec {
  theme = import ./theme;
  packages =
    pkgs:
    let
      inherit (pkgs) callPackage;
      theme = import ./theme pkgs;
    in
    {
      zsh = callPackage ./wrapped/zsh { };
      tmux = callPackage ./wrapped/tmux { inherit theme; };
      foot = callPackage ./wrapped/foot { inherit theme; };
      helix = callPackage ./wrapped/helix { inherit theme; };
      tofi = callPackage ./wrapped/tofi { inherit theme; };
      mako = callPackage ./wrapped/mako { inherit theme; };
      dunst = callPackage ./wrapped/dunst { inherit theme; };
      bat = callPackage ./wrapped/bat { inherit theme; };
      zathura = callPackage ./wrapped/zathura { };
    };

  shell =
    pkgs:
    pkgs.mkShell {
      name = "sioodmy-devshell";
      shellHook = ''
        zsh
      '';
      buildInputs = builtins.attrValues {
        inherit (packages pkgs)
          nvim
          zsh
          ;
      };
    };
  module =
    { pkgs, ... }:
    {
      config = {
        environment.systemPackages = builtins.attrValues (packages pkgs);
        programs.direnv = {
          enable = false;
          enableFishIntegration = false;
        };
      };
      imports = [
        ./packages.nix
        ./git
        ./gtk
      ];
    };
}
