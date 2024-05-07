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
    (forHost ["calypso"] ../../secrets/syncthing-calypso-key.age "syncthing-calypso-key" user)
    (forHost ["calypso"] ../../secrets/syncthing-calypso-cert.age "syncthing-calypso-cert" user)
    # TODO: rework
    (forHost ["calypso"] ../../secrets/radicale-pass.age "radicale-pass" user)
    (forHost ["prometheus"] ../../secrets/mailserver.age "mailserver" {mode = "400";})
    (forHost ["prometheus"] ../../secrets/caldav.age "caldav" {mode = "400";})

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
