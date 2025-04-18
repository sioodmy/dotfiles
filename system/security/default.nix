{pkgs, ...}: {
  hardware.ledger.enable = true;
  services = {
    networkd-dispatcher.enable = true;
    pcscd.enable = true;
    yubikey-touch-detector.enable = true;
  };
  security = {
    protectKernelImage = false;
    lockKernelModules = false;
    forcePageTableIsolation = true;
    polkit.enable = true;
    sudo.package = pkgs.sudo.override {withInsults = true;};

    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
  };
  # credits: poz
  fileSystems = let
    defaults = ["nodev" "nosuid" "noexec"];
  in {
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
