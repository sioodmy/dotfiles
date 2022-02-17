{ pkgs, config, ...}:
{
    programs.rofi = {
        enable = true;
        extraConfig = {
            modi = "run,drun,window";
            lines = 5;
            font = "JetBrainsMono Nerd Font 14";
            show-icons = true;
            icon-theme = "Oranchelo";
            terminal = "urxvt";
            drun-display-format = "{icon} {name}";
            location = 0;
            disable-history = false;
            hide-scrollbar = true;
            display-drun = "   Apps ";
            display-run = "   Run ";
            display-window = " 﩯  window";
            display-Network = " 󰤨  Network";
            sidebar-mode = true;

        };
        theme = {
            "*" = {
                bg-col = "#1E1D2F";
                bg-col-light = "#1E1D2F";
                border-col = "#1E1D2F";
                selected-col = "#1E1D2F";
                blue = "#7aa2f7";
                fg-col = "#D9E0EE";
                fg-col2 = "#F28FAD";
                grey = "#D9E0EE";
                width = 600;
            };
            "window" = {
                background-color = "#1E1D2F";
                text-color = "#D9E0EE";
            };
            "mainbox" = {
                background-color = "#1E1D2F";
            };

          };


  
        };
}
