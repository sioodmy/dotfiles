{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];
  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    tmp.cleanOnBoot = true;
    # some kernel parameters, i dont remember what half of this shit does but who cares
    kernelParams = [
      "pti=on"
      "randomize_kstack_offset=on"
      "vsyscall=none"
      "acpi_call"
      "processor.max_cstate=5"
      "slab_nomerge"
      "debugfs=off"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
      "page_poison=1"
      "page_alloc.shuffle=1"
      "slub_debug=FZP"
      "sysrq_always_enabled=1"
      "processor.max_cstate=5"
      "idle=nomwait"
      "quiet"
      "rootflags=noatime"
      "iommu=pt"
      "usbcore.autosuspend=-1"
      "sysrq_always_enabled=1"
      "lsm=landlock,lockdown,yama,apparmor,bpf"
      "loglevel=7"
      "rd.udev.log_priority=3"
      "noresume"
      "logo.nologo"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
    ];
    initrd.verbose = false;
    # switch from old ass lts kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    extraModprobeConfig = "options hid_apple fnmode=1";

    bootspec.enable = true;
    loader = {
      systemd-boot.enable = true;
      timeout = 0;
    };
    loader.efi.canTouchEfiVariables = true;
  };
}
