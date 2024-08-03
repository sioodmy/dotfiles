{lib, ...}: {
  services.openssh = {
    enable = lib.mkDefault false;
    settings = {
      PermitRootLogin = lib.mkForce "yes";
      UseDns = false;
      X11Forwarding = false;
      PasswordAuthentication = lib.mkForce false;
      KbdInteractiveAuthentication = false;
    };
    openFirewall = true;
    ports = [22];
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
