{
  pkgs,
  lib,
  ...
}: {
  imports = [./hardware-configuration.nix];
  services = {
    fprintd.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = false; # conflicts with tlp
    tlp = {
      enable = true;
      settings = {
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 90;
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 1;
        NMI_WATCHDOG = 0;
        PLATFORM_PROFILE_ON_AC = "performance";
        WOL_DISABLE = "Y";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
        USB_AUTOSUSPEND = 1;
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 27;
      };
    };
  };

   # https://github.com/NixOS/nixpkgs/issues/211345#issuecomment-1397825573
   systemd.tmpfiles.rules = map
        (e:
          "w /sys/bus/${e}/power/control - - - - auto"
        ) [
        "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
        "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
        "pci/devices/0000:00:14.0" # FCH SMBus Controller
        "pci/devices/0000:00:14.3" # FCH LPC bridge
        "pci/devices/0000:04:00.0" # FCH SATA Controller [AHCI mode]
        "pci/devices/0000:04:00.1/ata1" # FCH SATA Controller, port 1
        "pci/devices/0000:04:00.1/ata2" # FCH SATA Controller, port 2
        "usb/devices/1-3" # USB camera
      ];

  powerManagement = {
    cpuFreqGovernor = "powersave";
    enable = true;
  };
  security.pam.services.login.fprintAuth = true;
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    sensitivity = 250;
  };
  hardware.opengl.extraPackages = with pkgs; [vaapiIntel libvdpau-va-gl vaapiVdpau];
}
