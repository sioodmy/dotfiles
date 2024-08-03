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

          gtklock = import ./wrapped/gtklock {inherit pkgs;};
          mako = import ./wrapped/mako {inherit pkgs colors;};
          rofi = import ./wrapped/rofi {inherit pkgs colors;};
          swayidle = import ./wrapped/swayidle {inherit pkgs;};
        };
      }
    ];
  })
  # wrapper-manager incorrectly wraps river
  (import ./wrapped/river {inherit pkgs colors;})
]
