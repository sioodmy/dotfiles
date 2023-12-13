{config, ...}: let
  hm = "/home/sioodmy";
in {
  services.syncthing = {
    key = config.age.secrets.syncthing-calypso-key.path;
    cert = config.age.secrets.syncthing-calypso-cert.path;
    settings = {
      devices = {"methone" = {id = "Y2YGMW4-NXKZL4K-Y7O7YBP-AUJLRQP-KZNRQD6-D6JL6AB-F425XCL-LJ7AVQO";};};
      overrideDevices = true;
      folders = {
        "photos" = {
          id = "sm-g780f_tam7-photos";
          path = "${hm}/pics/cam";
          devices = ["methone"];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600"; # 1 hour
              maxAge = "1209600"; # 14 days
            };
          };
        };
        "keepass" = {
          id = "wwm5g-uhgoz";
          path = "${hm}/.keepass";
          devices = ["methone"];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600"; # 1 hour
              maxAge = "1209600"; # 14 days
            };
          };
        };
        "docs" = {
          id = "sdm7g-shhoa";
          path = "${hm}/docs";
          devices = ["methone"];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600"; # 1 hour
              maxAge = "1209600"; # 14 days
            };
          };
        };
      };
    };
  };
}
