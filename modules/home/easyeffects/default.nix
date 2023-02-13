{
  self,
  pkgs,
  config,
  inputs,
  ...
}: {
  xdg.configFile."easyeffects/output/quiet.json".source = ./quiet.json;
  services.easyeffects = {
    enable = true;
    preset = "quiet";
  };
}
