{ pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # linuxPackages_xanmod;
  # linuxPackages_zen;
  # linuxPackages_latest;
  # linuxPackages_hardened;
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelParams = [
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "quiet"
    "nospectre_v2"
    "mitigations=off"
  ];
}
