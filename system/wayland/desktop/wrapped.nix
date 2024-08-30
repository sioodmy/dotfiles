{
  pkgs,
  inputs,
  config,
  ...
}: let
  colors = config.colorScheme.palette;
in [
  (inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          foot = import ./wrapped/foot {inherit inputs pkgs colors;};

          swaylock = import ./wrapped/swaylock {inherit pkgs colors;};
          mako = import ./wrapped/mako {inherit pkgs colors;};
        };
      }
    ];
  })
  # wrapper-manager incorrectly wraps river
  (import ./wrapped/river {inherit pkgs colors;})
  (import ./wrapped/tofi {inherit pkgs colors;})
]
