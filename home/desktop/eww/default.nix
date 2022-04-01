{ inputs, config, theme, pkgs, ... }:

{
  # eww package
  home.packages = [ inputs.eww.packages."x86_64-linux".eww pkgs.pamixer ];

  # configuration
  home.file.".config/eww/eww.yuck".source = ./eww.yuck;

  # color definitions
  home.file.".config/eww/eww.scss".text = with theme.colors;
    ''

      $accent: #${ac};
      $background: #${bg};
      $foreground: #${fg};

      $black: #${ba};
      $red: #${c1};
      $green: #${c2};
      $yellow: #${c3};
      $blue: #${c4};
      $magenta: #${c5};
      $white: $foreground;'' + builtins.readFile ./eww.scss;

  # scripts
  home.file.".config/eww/scripts/memory.sh" = {
    source = ./scripts/memory.sh;
    executable = true;
  };

  home.file.".config/eww/scripts/music.sh" = {
    source = ./scripts/music.sh;
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
}
