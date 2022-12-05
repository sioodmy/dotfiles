{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libsixel
    # for displaying images
  ];
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=14";
        pad = "24x24";
        dpi-aware = "yes";
      };
      colors = {
        alpha = "0.9";
        foreground = "c6d0f5";
        background = "303446";

        regular0 = "51576d";
        regular1 = "e78284";
        regular2 = "a6d189";
        regular3 = "e5c890";
        regular4 = "8caaee";
        regular5 = "f4b8e4";
        regular6 = "81c8be";
        regular7 = "b5bfe2";

        bright0 = "626880";
        bright1 = "e78284";
        bright2 = "a6d189";
        bright3 = "e5c890";
        bright4 = "8caaee";
        bright5 = "f4b8e4";
        bright6 = "81c8be";
        bright7 = "a5adce";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
