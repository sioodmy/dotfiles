{
  pkgs,
  lib,
  ...
}:
# this makes our system more secure
# note that it might break some stuff, eg webcam
{
  services = {
    physlock = {
      enable = true;
      allowAnyUser = true;
    };
    tor = {
      enable = true;
      client.enable = true;
    };
    networkd-dispatcher = {
      enable = true;
      rules."restart-tor" = {
        onState = ["routable" "off"];
        script = ''
          #!${pkgs.runtimeShell}
          if [[ $IFACE == "wlan0" && $AdministrativeState == "configured" ]]; then
            echo "Restarting Tor ..."
            systemctl restart tor
          fi
          exit 0
        '';
      };
    };
  };

  programs.proxychains = {
    enable = true;
    quietMode = false;
    proxyDNS = true;
    package = pkgs.proxychains-ng;
    proxies = {
      tor = {
        type = "socks5";
        host = "127.0.0.1";
        port = 9050;
      };
    };
  };

  programs.ssh.startAgent = true;
  programs.wireshark.enable = true;
  security = {
    # disables hibernation
    protectKernelImage = true;

    # brakes wireguard
    lockKernelModules = true;
    forcePageTableIsolation = true;
    allowUserNamespaces = true;

    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    pam = {
      services.gtklock.text = "auth include login";
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
      services = {
        login.enableGnomeKeyring = true;
      };
    };

    sudo = {
      enable = true;
      extraRules = [
        {
          commands =
            builtins.map (command: {
              command = "/run/current-system/sw/bin/${command}";
              options = ["NOPASSWD"];
            })
            ["poweroff" "reboot" "nixos-rebuild" "nix-env" "bandwhich" "mic-light-on" "mic-light-off" "systemctl"];
          groups = ["wheel"];
        }
      ];
    };
  };

  # thanks to NotAShelf for commenting all of this :3

  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    # Disable it, since we don't need it, and is a potential security concern.
    "kernel.sysrq" = 0;

    # Restrict ptrace() usage to processes with a pre-defined relationship
    # (e.g., parent/child)
    # FIXME: this breaks game launchers, find a way to launch them with privileges (steam)
    # gamescope wrapped with the capabilities *might* solve the issue
    "kernel.yama.ptrace_scope" = 2;

    # Hide kptrs even for processes with CAP_SYSLOG
    # also prevents printing kernel pointers
    "kernel.kptr_restrict" = 2;

    # Disable bpf() JIT (to eliminate spray attacks)
    "net.core.bpf_jit_enable" = false;

    # Disable ftrace debugging
    "kernel.ftrace_enabled" = false;

    # Avoid kernel memory address exposures via dmesg (this value can also be set by CONFIG_SECURITY_DMESG_RESTRICT).
    "kernel.dmesg_restrict" = 1;

    # Prevent unintentional fifo writes
    "fs.protected_fifos" = 2;

    # Prevent unintended writes to already-created files
    "fs.protected_regular" = 2;

    # Disable SUID binary dump
    "fs.suid_dumpable" = 0;

    # Disallow profiling at all levels without CAP_SYS_ADMIN
    "kernel.perf_event_paranoid" = 3;

    # Require CAP_BPF to use bpf
    "kernel.unprvileged_bpf_disabled" = 1;
  };

  # Security
  boot.blacklistedKernelModules = lib.concatLists [
    # Obscure network protocols
    [
      "dccp" # Datagram Congestion Control Protocol
      "sctp" # Stream Control Transmission Protocol
      "rds" # Reliable Datagram Sockets
      "tipc" # Transparent Inter-Process Communication
      "n-hdlc" # High-level Data Link Control
      "netrom" # NetRom
      "x25" # X.25
      "ax25" # Amatuer X.25
      "rose" # ROSE
      "decnet" # DECnet
      "econet" # Econet
      "af_802154" # IEEE 802.15.4
      "ipx" # Internetwork Packet Exchange
      "appletalk" # Appletalk
      "psnap" # SubnetworkAccess Protocol
      "p8022" # IEEE 802.3
      "p8023" # Novell raw IEEE 802.3
      "can" # Controller Area Network
      "atm" # ATM
    ]

    # Old or rare or insufficiently audited filesystems
    [
      "adfs" # Active Directory Federation Services
      "affs" # Amiga Fast File System
      "befs" # "Be File System"
      "bfs" # BFS, used by SCO UnixWare OS for the /stand slice
      "cifs" # Common Internet File System
      "cramfs" # compressed ROM/RAM file system
      "efs" # Extent File System
      "erofs" # Enhanced Read-Only File System
      "exofs" # EXtended Object File System
      "freevxfs" # Veritas filesystem driver
      "f2fs" # Flash-Friendly File System
      "vivid" # Virtual Video Test Driver (unnecessary)
      "gfs2" # Global File System 2
      "hpfs" # High Performance File System (used by OS/2)
      "hfs" # Hierarchical File System (Macintosh)
      "hfsplus" # " same as above, but with extended attributes
      "jffs2" # Journalling Flash File System (v2)
      "jfs" # Journaled File System - only useful for VMWare sessions
      "ksmbd" # SMB3 Kernel Server
      "minix" # minix fs - used by the minix OS
      "nfsv3" # " (v3)
      "nfsv4" # Network File System (v4)
      "nfs" # Network File System
      "nilfs2" # New Implementation of a Log-structured File System
      "omfs" # Optimized MPEG Filesystem
      "qnx4" #  extent-based file system used by the QNX4 and QNX6 OSes
      "qnx6" # "
      "squashfs" # compressed read-only file system (used by live CDs)
      "sysv" # implements all of Xenix FS, SystemV/386 FS and Coherent FS.
      "udf" # https://docs.kernel.org/5.15/filesystems/udf.html
    ]

    # Disable Thunderbolt and FireWire to prevent DMA attacks
    [
      "thunderbolt"
      "firewire-core"
    ]
  ];
}
