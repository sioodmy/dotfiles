{ pkgs, config, theme, ... }:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--height 50%"
    ];
  };
}
