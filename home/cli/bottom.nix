{pkgs, ...}: {
  # universal aliases
  home.packages = with pkgs; [
    (writeScriptBin "htop" ''exec btm'')
    # yeah it might brake some stuff
    # but if your script relies on TOP
    # then its fucking trash
    # cope
    (writeScriptBin "top" ''exec btm'')
  ];
  programs.bottom = {
    enable = true;
    settings = {
      flags.group_processes = true;
      row = [
        {
          ratio = 2;
          child = [
            {type = "cpu";}
            {type = "mem";}
          ];
        }
        {
          ratio = 3;
          child = [
            {
              type = "proc";
              ratio = 1;
              default = true;
            }
          ];
        }
      ];
    };
  };
}
