{
  pkgs,
  lib,
  ...
}: {
  imports = [./hardware-configuration.nix];
  services = {
    fprintd.enable = true;
    thermald.enable = true;
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
        CPU_MAX_PERF_ON_BAT = 20;
      };
    };
  };
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
