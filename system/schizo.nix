{
  config,
  pkgs,
  ...
}:
# this makes our system more secure
# note that it might break some stuff, eg webcam
{
  security = {
    protectKernelImage = true;
    lockKernelModules = false;
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    pam.services = {
      login.enableGnomeKeyring = true;
      swaylock = {
        text = ''
          auth include login
        '';
      };
    };
    sudo.execWheelOnly = true;
  };

  boot.kernel.sysctl = {
    "kernel.yama.ptrace_scope" = 2;
    "kernel.kptr_restrict" = 2;
    "net.core.bpf_jit_enable" = false;
    "kernel.ftrace_enabled" = false;
    "net.ipv4.conf.all.log_martians" = true;
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.default.log_martians" = true;
    "net.ipv4.conf.default.rp_filter" = "1";
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.all.secure_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.default.secure_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv6.conf.default.accept_ra" = 0;
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_timestamps" = 0;
    "net.ipv4.tcp_rfc1337" = 1;
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
    "uvcvideo" # thats why your webcam not worky
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "omfs"
    "uvcvideo"
    "qnx4"
    "qnx6"
    "sysv"
  ];
}
