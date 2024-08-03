{
  pkgs,
  inputs,
  colors,
  ...
}: let
  toml = pkgs.formats.toml {};

  starship-settings = import ./starship.nix;

  aliases = import ./aliases.nix {inherit pkgs;};
  configs = import ./configs {inherit inputs pkgs colors;};

  packages = import ./packages.nix {inherit pkgs;};

  zconfig = import ./zsh {inherit pkgs inputs aliasesStr;};

  aliasesStr =
    pkgs.lib.concatStringsSep "\n"
    (pkgs.lib.mapAttrsToList (k: v: "alias ${k}=\"${v}\"") aliases);
in
  (inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers =
          {
            nucleus = {
              basePackage = pkgs.zsh;
              pathAdd = packages;
              env = {
                STARSHIP_CONFIG.value = toml.generate "starship.toml" starship-settings;
                ZDOTDIR.value = "${zconfig}/bin";
              };
              renames = {
                "zsh" = "nucleus";
              };
            };
          }
          // configs;
      }
    ];
  })
  .overrideAttrs (_: {
    passthru = {
      shellPath = "/bin/nucleus";
    };
  })
