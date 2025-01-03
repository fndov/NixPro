{ pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # linuxPackages_xanmod_latest;
  # linuxPackages_xanmod;
  # linuxPackages_zen;
  # linuxPackages_hardened;
  boot.blacklistedKernelModules = [ "nouveau" ]; # Prevent conflicts with the NVIDIA driver.
  boot.kernelParams = [
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "quiet"
    "nospectre_v2"
    "mitigations=off"
  ];
  # CPU Clock speed.
  # services.thermald.enable = true; # Prevents overheating.
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "performance";
      turbo = "always";
    };
    charger = {
      governor = "performance";
      turbo = "always";
    };
  };
}
