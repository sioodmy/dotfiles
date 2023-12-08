{
  lib,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];
  boot.extraModprobeConfig = lib.mkMerge [
    # idle audio card after one second
    "options snd_hda_intel power_save=1"
    # enable wifi power saving (keep uapsd off to maintain low latencies)
    "options iwlwifi power_save=1 uapsd_disable=1"
  ];

  services.udev.extraRules = lib.mkMerge [
    # autosuspend USB devices
    ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
    # autosuspend PCI devices
    ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
    # disable Ethernet Wake-on-LAN
    ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
  ];
  environment.systemPackages = with pkgs; [powertop];
  powerManagement = {
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };
  security.pam.services.login.fprintAuth = true;
  services = {
    power-profiles-daemon.enable = false;
    fprintd.enable = true;
    thermald.enable = true;
    system76-scheduler.settings.cfsProfiles.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        START_CHARGE_THRESH_BAT0 = 85;
        TLP_PERSISTENT_DEFAULT = 1;
        STOP_CHARGE_THRESH_BAT0 = 90;
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
        CPU_SCALING_MIN_FREQ_ON_AC = 800000;
        CPU_SCALING_MAX_FREQ_ON_AC = 3500000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 800000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 2300000;
      };
    };
  };

  # systemd.tmpfiles.rules =
  #   map
  #   (
  #     e: "w /sys/bus/${e}/power/control - - - - auto"
  #   ) [
  #     "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
  #     "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
  #     "pci/devices/0000:00:14.0" # FCH SMBus Controller
  #     "pci/devices/0000:00:14.3" # FCH LPC bridge
  #     "pci/devices/0000:04:00.0" # FCH SATA Controller [AHCI mode]
  #     "pci/devices/0000:04:00.1/ata1" # FCH SATA Controller, port 1
  #     "pci/devices/0000:04:00.1/ata2" # FCH SATA Controller, port 2
  #     "usb/devices/1-3" # USB camera
  #   ];
}
