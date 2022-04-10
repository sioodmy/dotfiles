{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "sioodmy";
    userEmail = "sioodmy@tuta.io";
    extraConfig = { init = { defaultBranch = "main"; }; };
    delta.enable = true;
  };
  
}
