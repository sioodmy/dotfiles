{
  config,
  lib,
  ...
}: let
  forHost = hostnames: secretFile: secretName: extra:
    lib.mkIf (builtins.elem config.networking.hostName hostnames) {
      ${secretName} =
        {
          file = secretFile;
        }
        // extra;
    };

  user = {
    owner = "sioodmy";
    group = "users";
  };
in {
  age.secrets = lib.mkMerge [
    (forHost ["anthe"] ../../secrets/syncthing-key.age "syncthing-key" user)
    (forHost ["anthe"] ../../secrets/syncthing-cert.age "syncthing-cert" user)
    (forHost ["calypso"] ../../secrets/syncthing-calypso-key.age "syncthing-calypso-key" user)
    (forHost ["calypso"] ../../secrets/syncthing-calypso-cert.age "syncthing-calypso-cert" user)
    # TODO: rework
    (forHost ["calypso"] ../../secrets/radicale-pass.age "radicale-pass" user)
    (forHost ["anthe"] ../../secrets/radicale-pass.age "radicale-pass" user)

    (forHost ["iapetus"] ../../secrets/radicale.age "radicale" {
      owner = "radicale";
      group = "radicale";
    })
  ];
  # age.secrets.syncthing-key = {
  #   file = syncthing-key.age;
  #   owner = "sioodmy";
  #   group = "users";
  # };
  # age.secrets.syncthing-cert = {
  #   file = ../../secrets/syncthing-cert.age;
  #   owner = "sioodmy";
  #   group = "users";
  # };
}
