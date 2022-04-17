{ inputs, lib, config, theme, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.eww;
in {
  options.modules.desktop.eww = { enable = mkEnableOption "eww"; };

  config = mkIf cfg.enable {
    # eww package
    home.packages =
      [ inputs.eww.packages."x86_64-linux".eww pkgs.pamixer pkgs.tdrop ];

    # configuration
    home.file.".config/eww/eww.yuck".source = ./eww.yuck;

    # color definitions
    home.file.".config/eww/eww.scss".text = with theme.colors;
      ''

        $accent: #${ac};
        $background: #${bg};
        $foreground: #${fg};

        $black: #${ba};
        $gray: #${c0};
        $red: #${c1};
        $green: #${c2};
        $yellow: #${c3};
        $blue: #${c4};
        $magenta: #${c5};
        $white: $foreground;'' + builtins.readFile ./eww.scss;

    # scripts

    home.file.".config/eww/scripts/music.sh" = {
      source = ./scripts/music.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/volume.sh" = {
      source = ./scripts/volume.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/micvolume.sh" = {
      source = ./scripts/micvolume.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/ss.sh" = {
      source = ./scripts/ss.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/workspaces.sh" = {
      source = ./scripts/workspaces.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/microphone_icon.sh" = {
      source = ./scripts/microphone_icon.sh;
      executable = true;
    };

    services.sxhkd.keybindings = {
      "XF86AudioRaiseVolume" = "eww update volumepoll=\"$(~/.config/eww/scripts/volume.sh up)\"";
      "XF86AudioLowerVolume" = "eww update volumepoll=\"$(~/.config/eww/scripts/volume.sh down)\"";
      "XF86AudioMute" = "eww update volumepoll=\"$(~/.config/eww/scripts/volume.sh toggle)\"";
      "super + b" = "eww open --toggle bar";
      "Print" = "~/.config/eww/scripts/ss.sh menu";
    };
  };
}
