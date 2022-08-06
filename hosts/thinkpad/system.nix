{ pkgs, lib, ... }: {

  # undervolting and power saving stuff
  services.thermald.enable = true;
  services.upower.enable = true;
  environment.systemPackages = [ pkgs.tpacpi-bat ];

  networking.networkmanager = {
    wifi = {
      backend = "iwd";
      powersave = false;
    };
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 1;
      DISK_IDLE_SECS_ON_AC = 0;
      DISK_IDLE_SECS_ON_BAT = 2;
      MAX_LOST_WORK_SECS_ON_AC = 15;
      MAX_LOST_WORK_SECS_ON_BAT = 60;
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 90;
      USB_BLACKLIST_WWAN = 1;
      USB_BLACKLIST_PHONE = 1;
      USB_BLACKLIST_BTUSB = 0;
      WOL_DISABLE = 1;
      USB_AUTOSUSPEND = 0;
      NMI_WATCHDOG = 0;
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
      DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "wwan";
      DEVICES_TO_DISABLE_ON_WWAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";
      DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT = "";
      DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT = "";
    };
  };

  hardware = {
    trackpoint = {
      emulateWheel = true;
      speed = 250;
      sensitivity = 100;
    };
  };
  services.undervolt = {
    enable = true;
    coreOffset = -70;
    gpuOffset = -50;
  };
  systemd.services.undervolt.wantedBy =
    [ "post-resume.target" "multi-user.target" ];
  systemd.services.undervolt.after = [ "post-resume.target" ];
}
