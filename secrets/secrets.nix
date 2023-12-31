let
  anthe-user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9ExEl6WqtCI4yCqbSAhAGmzvVp/nYADbgy/Qi4AKQy sioodmy@anthe";

  calypso-user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+S9LPxp3Mmha1keHlwc0iVq4CMbHvzAAwuYE2go7io sioodmy@calypso";
  anthe-host = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3LBESPBY559NbAJ7KL/+K4S5InhWf5YDQgl2XjT5ZxTtPg0x24IDcEmxrPi+7nKSAvMJCkneTfWHPYoRYrNA/G15a+Pqr/9w1EtuK+D054qtz2q+oUM029JdTP/0qzbKxAV/qzUXyJyrgcGRnRYhFRKmg3Sl7G7mxhYN20RIYL3ENXnpfculGrnqX8yONda7YRQfjyEQAsLUIS4aEN7pQsUGO2lGzvXueHcRGRflbatVD59REWoD5kYE984EVhgbky092HHhDR5rIFnFJygrhl9irYk7x6Un98qsvKBeRKzpNMZ1iqs8EFdSbayNdRimooSyFLx83pUhx7SY01cJXxuVmW8Rec9xgnW8rrclz2H+ArQHSZQz/T/QPH2zZgtE3A2xX5HsmQnCu/h7yOpwD6ULTyR8/xK61jHgx4AM1hLyGGrMoPailSXyvT9OGnmXuvcIrx8R2oHy7e48DGWiTHoW8+nltWURkUjdolg373ruLxT+Rqf1JFgPcFwCEVSjVxtTz33ljFD31OOKjs5O2y/9jndwcx54twlgLr+H/6Y1SWIPNeuhNO3IiGuFkH3+JLrQLXVN9UIE1/qHyOIIJpR3ONd4uW6xDsnl8SBZUWuYf468FQGHkinWZxdYdi1SlHbulXxGPTiRjqSUBeR9fB+CND2WJEvfeSJccofk29w== root@anthe";

  calypso-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPhD+J2Iivt9mTVV2I79iGlqN+YQFb4PPkqle0brUKy4 root@calypso";

  iapetus-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII6SEc5n1jdc9u9TLrpmZZ/3MqCrAxI/8enfkC2m/L4f root@iapetus";

  anthe = [anthe-user anthe-host];
  calypso = [calypso-user calypso-host];

  iapetus = [anthe-user calypso-user iapetus-host];
in {
  age.identityPaths = "/persist/home/sioodmy/.ssh/id_ed25519";
  "spotify.age".publicKeys = anthe;
  "syncthing-key.age".publicKeys = anthe;
  "syncthing-cert.age".publicKeys = anthe;

  "syncthing-calypso-key.age".publicKeys = calypso;
  "syncthing-calypso-cert.age".publicKeys = calypso;

  "radicale.age".publicKeys = iapetus;
  "radicale-pass.age".publicKeys = calypso ++ anthe;
}
