{ pkgs, ... }:
{
  services = {
    networkd-dispatcher.enable = true;
    pcscd.enable = true;
    yubikey-touch-detector.enable = true;
    chrony = {
      enable = true;
      enableNTS = true;
      servers = [
        "server time.cloudflare.com iburst nts"
        "server ntppool1.time.nl iburst nts"
        "server nts.netnod.se iburst nts"
        "server ptbtime1.ptb.de iburst nts"
        "server time.dfm.dk iburst nts"
        "server time.cifelli.xyz iburst nts"
      ];
    };
  };
  security = {
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (subject.user == "sioodmy") {
            if (action.id.indexOf("org.freedesktop.systemd1.manage-units") == 0) {
              polkit.log("Caching admin authentication for single NixOS operation");
              return polkit.Result.AUTH_ADMIN_KEEP;
            }
          }
        });
      '';
    };
    protectKernelImage = false;
    lockKernelModules = false;
    forcePageTableIsolation = true;
    polkit.enable = true;
    sudo.package = pkgs.sudo.override { withInsults = true; };

    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };
  };
  # credits: poz
  fileSystems =
    let
      defaults = [
        "nodev"
        "nosuid"
        "noexec"
      ];
    in
    {
      "/boot".options = defaults;
      "/var/log".options = defaults;
    };
  boot = {
    blacklistedKernelModules = [
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
  };
}
