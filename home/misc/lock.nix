{
  pkgs,
  lib,
  config,
  theme,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
  font_family = "Lexend";
in {
  programs.hyprlock = with theme.colors; {
    enable = true;

    general = {
      disable_loading_bar = true;
      hide_cursor = false;
      no_fade_in = true;
    };

    backgrounds = [
      {
        monitor = "";
        path = "${theme.wallpaper}";
      }
    ];

    input-fields = [
      {
        monitor = "eDP-1";

        size = {
          width = 300;
          height = 50;
        };

        outline_thickness = 2;

        outer_color = "rgb(${accent})";
        inner_color = "rgb(${base})";
        font_color = "rgb(${text})";

        fade_on_empty = false;
        placeholder_text = ''<span font_family="${font_family}" foreground="##${subtext1}">Password...</span>'';

        dots_spacing = 0.3;
        dots_center = true;
      }
    ];

    labels = [
      {
        monitor = "";
        text = "$TIME";
        inherit font_family;
        font_size = 64;
        color = "rgba(${base}bf)";

        position = {
          x = 0;
          y = 80;
        };

        valign = "center";
        halign = "center";
      }
    ];
  };
  services.hypridle = {
    enable = true;
    beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
    lockCmd = lib.getExe config.programs.hyprlock.package;

    listeners = [
      {
        timeout = 330;
        onTimeout = suspendScript.outPath;
      }
    ];
  };
}
