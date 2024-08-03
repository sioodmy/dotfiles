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
          foot = import ./configs/foot {inherit inputs pkgs colors;};

          gtklock = import ./configs/gtklock {inherit pkgs;};
          mako = import ./configs/mako {inherit pkgs colors;};
          rofi = import ./configs/rofi {inherit pkgs colors;};
          swayidle = import ./configs/swayidle {inherit pkgs;};
        };
      }
    ];
  })
  # wrapper-manager incorrectly wraps river
  (import ./configs/river {inherit pkgs colors;})
]
