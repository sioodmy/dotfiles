{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
in {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];
  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    tmp = {
      cleanOnBoot = true;
      useTmpfs = false;
    };
    # some kernel parameters, i dont remember what half of this shit does but who cares
    kernelParams = [
      # increase security of heap
      "slab_nomerge"
      # mitigate use-after-free vulnerabilities and erase sensitive information in memory
      "init_on_alloc=1"
      "init_on_free=1"
      # make page allocations less predictable
      "page_alloc.shuffle=1"
      # prevent meltdown
      "pti=on"
      # CVE-2019-18683
      "randomize_kstack_offset=on"
      # disable obsolete vsyscalls
      "vsyscall=none"

      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      # security
      "lsm=landlock,lockdown,yama,apparmor,bpf"
      # disable noisy audit log
      "audit=0"
      # i dont use it
      "ipv6.disable=1"
      # passthrough
      "iommu=pt"
    ];
    consoleLogLevel = mkDefault 0;
    initrd.verbose = false;
    # switch from old ass lts kernel
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    extraModprobeConfig = "options hid_apple fnmode=1";

    bootspec.enable = mkDefault true;
    loader = {
      systemd-boot.enable = mkDefault true;
      timeout = 0;
    };
    loader.efi.canTouchEfiVariables = true;
  };
}
