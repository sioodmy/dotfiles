{ ...}: let
  # This is my little home brew impermanence :3
  # see, you don't need any external modules for that
  inherit (builtins) map;
  inherit (lib.strings) concatStrings concatStringsSep;
  inherit (lib) mkMerge optionalAttrs forEach;

  persistpath = "/persist";

  mkPersistentBindMounts = list:
    mkMerge (map (
        path: {
          "${path}" = {
            device = concatStrings [persistpath path];
            fsType = "none";
            options = ["bind"];
          };
        }
      )
      list);
  mkPersistentSourcePaths = list: concatStringsSep "\n" (forEach list (path: "mkdir -p /persist${path}"));

  persist = ["/etc/ssh" "/etc/NetworkManager" "/etc/nix" "/var/lib/fprint" "/var/lib/pipewire"];
in {
  staypls = {
    enable = 
  }
  boot.initrd.postDeviceCommands = mkPersistentSourcePaths persist;
  fileSystems = mkPersistentBindMounts persist;
}
