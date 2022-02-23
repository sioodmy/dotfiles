{ pkgs, config, ...}:

{
  fontconfig = {
    defaultConfig = {
      monospace = [ "JetBrains Mono"];
      sansSerif = [ "Source Sans"];
    };
  };
}
