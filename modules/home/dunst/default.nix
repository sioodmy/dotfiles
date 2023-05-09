{
  config,
  self,
  lib,
  pkgs,
  ...
}: let
  volume = let
    pamixer = lib.getExe pkgs.pamixer;
    notify-send = pkgs.libnotify + "/bin/notify-send";
  in
    pkgs.writeShellScriptBin "volume" ''
      #!/bin/sh

      ${pamixer} "$@"

      volume="$(${pamixer} --get-volume-human)"

      if [ "$volume" = "muted" ]; then
          ${notify-send} -r 69 \
              -a "Volume" \
              "Muted" \
              -i ${./mute.svg} \
              -t 888 \
              -u low
      else
          ${notify-send} -r 69 \
              -a "Volume" "Currently at $volume" \
              -h int:value:"$volume" \
              -i ${./volume.svg} \
              -t 888 \
              -u low
      fi
    '';
in {
  home.packages = [volume];
  services.dunst = {
    enable = true;
    package = pkgs.dunst.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "sioodmy";
        repo = "dunst";
        rev = "6477864bd870dc74f9cf76bb539ef89051554525";
        sha256 = "FCoGrYipNOZRvee6Ks5PQB5y2IvN+ptCAfNuLXcD8Sc=";
      };
    });
    iconTheme = {
      package = self.packages.${pkgs.system}.catppuccin-folders;
      name = "Papirus";
    };
    settings = {
      global = {
        frame_color = "#f4b8e495";
        separator_color = "#f4b8e4";
        width = 220;
        height = 280;
        offset = "0x15";
        font = "Lexend 12";
        corner_radius = 10;
        origin = "top-center";
        notification_limit = 3;
        idle_threshold = 120;
        ignore_newline = "no";
        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
        sticky_history = "yes";
        history_length = 20;
        show_age_threshold = 60;
        ellipsize = "middle";
        padding = 10;
        always_run_script = true;
        frame_width = 2;
        transparency = 10;
        progress_bar = true;
        progress_bar_frame_width = 0;
        highlight = "#f4b8e4";
      };
      fullscreen_delay_everything.fullscreen = "delay";
      urgency_low = {
        background = "#1e1e2e83";
        foreground = "#c6d0f5";
        timeout = 5;
      };
      urgency_normal = {
        background = "#1e1e2e83";
        foreground = "#c6d0f5";
        timeout = 6;
      };
      urgency_critical = {
        background = "#1e1e2e83";
        foreground = "#c6d0f5";
        frame_color = "#ea999c80";
        timeout = 0;
      };
    };
  };
}
