let
  calypso-user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+S9LPxp3Mmha1keHlwc0iVq4CMbHvzAAwuYE2go7io sioodmy@calypso";

  calypso-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhD+J2Iivt9mTVV2I79iGlqN+YQFb4PPkqle0brUKy4 root@calypso";

  prometheus-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEO6goNjMrTXD3l2eaCET5PW3+ec3RWREtPp8TK8r82B root@prometheus";

  calypso = [calypso-user calypso-host];

  prometheus = [calypso-user prometheus-host];
in {
  age.identityPaths = "/persist/home/sioodmy/.ssh/id_ed25519";

  "openai.age".publicKeys = calypso;

  "mailserver.age".publicKeys = prometheus;
  "caldav.age".publicKeys = prometheus;
  "discordtoken.age".publicKeys = prometheus;
}
