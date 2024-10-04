{
  config,
  lib,
  ...
}: let
  # This is my little home brew impermanence :3
  # see, you don't need any external modules for that
  inherit (builtins) map;
  inherit (lib.strings) concatStringsSep;
  inherit (lib) mkMerge forEach mkDefault mkIf mkEnableOption mkOption types;

  cfg = config.staypls;

  mkPersistentBindMounts = list:
    mkMerge (map (
        path: {
          "${path}" = {
            device = "/persist${path}";
            fsType = "none";
            options = [
              "bind"
              # no reason to trim bind mounts like that
              "X-fstrim.notrim"
              # hide the mounts cuz I dont wanna see them
              "x-gvfs-hide"
            ];
          };
        }
      )
      list);
  mkPersistentSourcePaths = list: concatStringsSep "\n" (forEach list (path: "mkdir -p /persist${path}"));
in {
  options.staypls = {
    enable = mkEnableOption "Enable directory impermanence module";
    dirs = mkOption {
      type = types.listOf types.str;
      description = "List of directiories to mount";
    };
  };
  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = mkDefault true;

    fileSystems = mkPersistentBindMounts cfg.dirs;
    boot.initrd.systemd.services.make-source-of-persistent-dirs = {
      wantedBy = ["initrd-root-device.target"];
      before = ["sysroot.mount"];
      requires = ["persist.mount"];
      after = ["persist.mount"];
      serviceConfig.Type = "oneshot";
      unitConfig.DefaultDependencies = false;
      script = mkPersistentSourcePaths cfg.dirs;
    };
  };
}
