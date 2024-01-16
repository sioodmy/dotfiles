{...}: {
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, ^(gtk-layer-shell)$"
      "blur, ^(launcher)$"
      "ignorezero, ^(gtk-layer-shell)$"
      "ignorezero, ^(launcher)$"
      "blur, notifications"
      "ignorezero, notifications"
      "blur, bar"
      "ignorezero, bar"
      "ignorezero, ^(gtk-layer-shell|anyrun)$"
      "blur, ^(gtk-layer-shell|anyrun)$"
      "noanim, launcher"
      "noanim, bar"
    ];
    windowrulev2 = [
      # only allow shadows for floating windows
      "noshadow, floating:0"
      "tile, title:Spotify"

      "idleinhibit focus, class:^(mpv)$"
      "idleinhibit focus,class:foot"
      "idleinhibit fullscreen, class:^(firefox)$"

      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "float,class:udiskie"

      "opacity 0.85 0.85,class:^(firefox)$"

      "workspace special silent,class:^(pavucontrol)$"
      "opacity 0.80,class:^(pavucontrol)$"

      "opacity 0.80,title:^(Spotify)$"

      "float, class:^(imv)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      "workspace 4, title:^(.*(Disc|WebC)ord.*)$"
      "workspace 2, class:^(firefox)$"
    ];
  };
}
