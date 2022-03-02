{ pkgs, config, ...}:

{
  programs.newsboat = {
    enable = true;
    extraConfig = builtins readFile ./config;
  };
}
