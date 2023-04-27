{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.anyrun.packages.${pkgs.system}) anyrun;
in {
  # I borrowed this config from fuf <3
  # https://github.com/fufexan/dotfiles/blob/3fe7fc0919d9579c60b36c5eac2a36ca8ca88c3d/home/wayland/anyrun.nix
  home.packages = [anyrun];

  xdg.configFile = {
    "anyrun/config.ron".text = ''
      Config(
        // `width` and `vertical_offset` use an enum for the value it can be either:
        // Absolute(n): The absolute value in pixels
        // Fraction(n): A fraction of the width or height of the full screen (depends on exclusive zones and the settings related to them) window respectively
        // How wide the input box and results are.
        width: Fraction(0.3),
        // Where Anyrun is located on the screen: Top, Center
        position: Top,
        // How much the runner is shifted vertically
        vertical_offset: Absolute(15),
        // Hide match and plugin info icons
        hide_icons: false,
        // ignore exclusive zones, f.e. Waybar
        ignore_exclusive_zones: false,
        // Layer shell layer: Background, Bottom, Top, Overlay
        layer: Overlay,
        // Hide the plugin info panel
        hide_plugin_info: true,
        // List of plugins to be loaded by default, can be specified with a relative path to be loaded from the
        // `<anyrun config dir>/plugins` directory or with an absolute path to just load the file the path points to.
        plugins: [
          "${anyrun}/lib/libapplications.so",
          "${anyrun}/lib/librandr.so",
          "${anyrun}/lib/librink.so",
          "${anyrun}/lib/libshell.so",
          "${anyrun}/lib/libsymbols.so",
          "${anyrun}/lib/libtranslate.so",
        ],
      )
    '';

    "anyrun/style.css".text = ''
      * {
        transition: 200ms ease-out;
        font-family: Lexend;
      }
      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }
      #match:selected {
        background: rgba(203, 166, 247, 0.7);
      }
      #match {
        padding: 3px;
        border-radius: 16px;
      }
      #entry {
        border-radius: 16px;
      }
      box#main {
        background: rgba(30, 30, 46, 0.7);
        border: 1px solid #28283d;
        border-radius: 24px;
        padding: 8px;
      }
      row:first-child {
        margin-top: 6px;
      }
    '';
  };
}
