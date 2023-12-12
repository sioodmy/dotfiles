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
    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };
  };
  programs.ssh.startAgent = true;
  programs.firejail = let
    profiles = "${pkgs.firejail}/etc/firejail";
    inherit (lib) getBin;
  in {
    enable = true;
    wrappedBinaries = with pkgs; {
      # FIXME: why did i think this was a good idea (too lazy to write a propper function tho)
      thunderbird = {
        executable = "${getBin thunderbird}/thunderbird";
        profile = "${profiles}/thunderbird.profile";
      };
      spotify = {
        executable = "${getBin spotify}/spotify";
        profile = "${profiles}/spotify.profile";
      };
      brave = {
        executable = "${getBin brave}/brave";
        profile = "${profiles}/brave-browser-stable.profile";
      };
      keepassxc = {
        executable = "${getBin keepassxc}/keepassxc";
        profile = "${profiles}/keepassxc.profile";
      };
      zathura = {
        executable = "${getBin zathura}/zathura";
        profile = "${profiles}/zathura.profile";
      };
      tor = {
        executable = "${getBin tor}/tor";
        profile = "${profiles}/tor.profile";
      };
      transmission-gtk = {
        executable = "${getBin transmission-gtk}/transmission-gtk";
        profile = "${profiles}/transmission-gtk.profile";
      };
    };
  };
  security = {
    protectKernelImage = true;
    lockKernelModules = false;
    forcePageTableIsolation = true;

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

    sudo.enable = lib.mkForce false;
    sudo-rs = {
      enable = true;
      extraRules = [
        {
          commands =
            builtins.map (command: {
              command = "/run/current-system/sw/bin/${command}";
              options = ["NOPASSWD"];
            })
            ["poweroff" "reboot" "nixos-rebuild" "nh" "bandwhich" "mic-light-on" "mic-light-off"];
          groups = ["wheel"];
        }
      ];
    };
  };

  boot.kernel.sysctl = {
    # Hide kernel pointers from processes without the CAP_SYSLOG capability.
    "kernel.kptr_restrict" = 1;
    "kernel.printk" = "3 3 3 3";
    # Restrict loading TTY line disciplines to the CAP_SYS_MODULE capability.
    "dev.tty.ldisc_autoload" = 0;
    # Make it so a user can only use the secure attention key which is required to access root securely.
    "kernel.sysrq" = 4;
    # Protect against SYN flooding.
    "net.ipv4.tcp_syncookies" = 1;
    # Protect against time-wait assasination.
    "net.ipv4.tcp_rfc1337" = 1;

    # Enable strict reverse path filtering (that is, do not attempt to route
    # packets that "obviously" do not belong to the iface's network; dropped
    # packets are logged as martians).
    "net.ipv4.conf.all.log_martians" = true;
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.log_martians" = true;
    "net.ipv4.conf.default.rp_filter" = "1";

    # Protect against SMURF attacks and clock fingerprinting via ICMP timestamping.
    "net.ipv4.icmp_echo_ignore_all" = "1";

    # Ignore incoming ICMP redirects (note: default is needed to ensure that the
    # setting is applied to interfaces added after the sysctls are set)
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.all.secure_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.default.secure_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;

    # Ignore outgoing ICMP redirects (this is ipv4 only)
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;

    # Restrict abritrary use of ptrace to the CAP_SYS_PTRACE capability.
    "kernel.yama.ptrace_scope" = 2;
    "net.core.bpf_jit_enable" = false;
    "kernel.ftrace_enabled" = false;
  };

  # Security
  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"
    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "vivid"
    "gfs2"
    "ksmbd"
    "nfsv4"
    "nfsv3"
    "cifs"
    "nfs"
    "cramfs"
    "freevxfs"
    "jffs2"
    "hfs"
    "hfsplus"
    "squashfs"
    "udf"
    "bluetooth"
    "btusb"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
  ];
}
