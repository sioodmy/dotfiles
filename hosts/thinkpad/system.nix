{ pkgs, lib, ... }: {

  # undervolting and power saving stuff
  services.thermald.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 1;
      DISK_IDLE_SECS_ON_AC= 0;
      DISK_IDLE_SECS_ON_BAT= 2;
      MAX_LOST_WORK_SECS_ON_AC= 15;
      MAX_LOST_WORK_SECS_ON_BAT= 60;
      SCHED_POWERSAVE_ON_AC= 0;
      SCHED_POWERSAVE_ON_BAT= 1;
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 90;
      USB_AUTOSUSPEND = 1;
      USB_BLACKLIST_WWAN= 1;
      WOL_DISABLE = 1;
      USB_BLACKLIST_BTUSB = 0;
      USB_BLACKLIST_PHONE = 0;
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
      speed = 140; # default: 97
    };
  };
  services.undervolt = {
    enable = true;
    coreOffset = -75;
    gpuOffset = -50;
  };
  systemd.services.undervolt.wantedBy = [ "post-resume.target" "multi-user.target" ];
  systemd.services.undervolt.after = [ "post-resume.target" ];
}
