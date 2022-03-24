{ pkgs, config, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      style = "numbers";
      theme = "base16";
    };
  };
}
