{pkgs, ...}:
# this makes our system more secure
# note that it might break some stuff, eg webcam
{
  services = {
    physlock = {
      enable = true;
      allowAnyUser = true;

      lockOn = {
        suspend = false;
        hibernate = false;
      };
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
  security = {
    protectKernelImage = false;
    lockKernelModules = false;
    forcePageTableIsolation = true;

    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    pam = {
      services.gtklock.text = ''
        auth            sufficient      pam_unix.so try_first_pass likeauth nullok
        auth            sufficient      pam_fprintd.so
        auth            include         login
      '';
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
