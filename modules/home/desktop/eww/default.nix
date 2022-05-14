{ inputs, lib, config, theme, pkgs, ... }:
with lib;
let cfg = config.modules.desktop.eww;
in {
  options.modules.desktop.eww = {
    enable = mkEnableOption "eww";
    laptop = mkOption {
      type = types.bool;
      default = false;
      description = "Add battery and brightness modules to the bar";
    };
  };

  config = mkIf cfg.enable {
    # eww package
    home.packages = [
      inputs.eww.packages."x86_64-linux".eww
      pkgs.pamixer
      pkgs.tdrop
      pkgs.libcanberra-gtk3
      pkgs.tiramisu
      pkgs.brightnessctl
    ];

    # configuration
    home.file.".config/eww/eww.yuck".text = (if cfg.laptop then
      builtins.readFile ./laptop.yuck # Same as a desktop bar + battery and brightness widgets
    else
      builtins.readFile ./desktop.yuck) + builtins.readFile ./eww.yuck;

    # color definitions
    home.file.".config/eww/eww.scss".text = with theme.colors;
      ''

        $accent: #${ac};
        $background: #${b0};
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

    home.file.".config/eww/scripts/battery.sh" = {
      source = ./scripts/battery.sh;
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

    home.file.".config/eww/scripts/brightness.sh" = {
      source = ./scripts/brightness.sh;
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

    home.file.".config/eww/scripts/wifi.sh" = {
      source = ./scripts/wifi.sh;
      executable = true;
    };

    services.sxhkd.keybindings = {
      "XF86AudioRaiseVolume" =
        ''eww update volumepoll="$(~/.config/eww/scripts/volume.sh up)"'';
      "XF86AudioLowerVolume" =
        ''eww update volumepoll="$(~/.config/eww/scripts/volume.sh down)"'';
      "XF86AudioMicMute" = ''
        eww update micvolumepoll="$(~/.config/eww/scripts/micvolume.sh toggle)"'';
      "XF86AudioMute" =
        ''eww update volumepoll="$(~/.config/eww/scripts/volume.sh toggle)"'';
      "XF86MonBrightnessUp" =
        "eww update brightnesspoll=$(~/.config/eww/scripts/brightness.sh up)";
      "XF86MonBrightnessDown" =
        "eww update brightnesspoll=$(~/.config/eww/scripts/brightness.sh down)";
      "super + b" = "eww open --toggle bar";
      "Print" = "~/.config/eww/scripts/ss.sh menu";
    };
  };
}
