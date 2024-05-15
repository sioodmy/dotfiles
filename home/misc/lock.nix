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
in {
  programs.swaylock = {
    package = pkgs.swaylock-effects;
    settings = with theme.colors; {
      clock = true;
      font = "Lexend";
      show-failed-attempts = false;
      screenshots = true;
      effect-blur = "10x5";
      effect-vignette = "0.5:0.5";
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      ring-color = surface1;
      key-hl-color = accent;
      text-color = text;
      text-caps-lock-color = "";
      ring-ver-color = accent;
      text-ver-color = text;
      ring-wrong-color = red;
      text-wrong-color = red;
      text-clear-color = blue;
      ring-clear-color = blue;
      bs-hl-color = red;

      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      separator-color = "00000000";
      line-uses-ring = false;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      datestr = "%d.%m";
      fade-in = "0.1";
      ignore-empty-password = true;
    };
  };
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        event = "lock";
        command = "${config.programs.swaylock.package}/bin/swaylock";
      }
    ];
    timeouts = [
      {
        timeout = 330;
        command = suspendScript.outPath;
      }
    ];
  };
}
