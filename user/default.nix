rec {
  packages =
    { pkgs, inputs }:
    let
      inherit (pkgs) callPackage;
    in
    {
      zsh = callPackage ./wrapped/zsh { };
      tmux = callPackage ./wrapped/tmux { };
      foot = callPackage ./wrapped/foot { };
      helix = callPackage ./wrapped/helix { inherit inputs; };
      quickshell = callPackage ./wrapped/quickshell { inherit inputs; };
      tofi = callPackage ./wrapped/tofi { };
      bat = callPackage ./wrapped/bat { };
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
    { pkgs, inputs, ... }:
    {
      config = {
        environment.systemPackages = builtins.attrValues (packages {
          inherit pkgs inputs;
        });
        programs.direnv = {
          enable = true;
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
