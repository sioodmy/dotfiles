{
  config,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = false;
    permitRootLogin = "no";
    passwordAuthentication = true;
  };
}
