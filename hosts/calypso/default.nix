{
  config,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  boot.initrd.availableKernelModules =
    [
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
      "dm_mod"
      "dm_crypt"
      "cryptd"
      "input_leds"
    ]
    ++ config.boot.initrd.luks.cryptoModules;

  # For some reason my mic light indicator refuses to turn off on its own
  # it may not be a perfect solution, but it works
  # so stay mad I guess
  systemd.services.micmute-led-off = {
    description = "Turn off mic mute LED";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0 > /sys/class/leds/platform::micmute/brightness'";
      TimeoutSec = 5;
    };
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.laptop.enable = true;
}
