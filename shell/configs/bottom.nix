{pkgs, ...}: let
  toml = pkgs.formats.toml {};

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
in {
  basePackage = pkgs.bottom;
  flags = [
    "--config"
    (toml.generate "config.toml" settings)
  ];
}
