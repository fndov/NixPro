{ pkgs, settings, ... }: {
  /*
     boot.kernelPackages = pkgs.linuxPackages_latest; # Broken Thu Feb  6 01:12:18 AM CST 2025
     boot.kernelPackages = pkgs.linuxPackages_xanmod_latest; # Broken Thu Feb  6 01:12:18 AM CST 2025
     boot.kernelPackages = pkgs.linuxPackages_xanmod;
     boot.kernelPackages = pkgs.linuxPackages_zen;
     boot.kernelPackages = pkgs.linuxPackages_hardened;
   */

  boot.kernelPackages =
    (if settings.profile == "image"
     then pkgs.linuxPackages_xanmod
     else
       (if settings.profile == "server"
        then pkgs.linuxPackages
        else
          (if settings.profile == "standalone"
           then pkgs.linuxPackages
           else
             (if settings.profile == "microsoft"
              then pkgs.linuxPackages
              else
                (if settings.profile == "virtual-machine"
                 then pkgs.linuxPackages
                 else null)))));
              
  boot.blacklistedKernelModules = [ "nouveau" ];

  boot.kernelParams = [
    "quiet"
    "mitigations=off"
    "init_on_alloc=0"
    "init_on_free=0"
    "nowatchdog"
    "idle=nomwait"
    "ascpi_osi=Linux"
    "noatime"

    /*
       "fastboot"
       "preempt=full"
       "nodiratime"
       "nofail"
       "x-systemd.device-timeout=5s"

       "splash"
       "rd.systemd.show_status=0"
       "rd.udev.log_level=3"
       "udev.log_priority=3"
       "intel_pstate=active"
       "processor.max_cstate=1"
       "intel_idle.max_cstate=1"
       "threadirqs"

       "transparent_hugepage=always"

       "i915.fastboot=1"
       "raid=noautodetect"
       "noapic"
     */
  ];
  # services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = if settings.desktop.enable != true || settings.desktop.de != "plasma" then true else false; # Plasma has it's own cpu clock manager.
    settings = {
      charger = { governor = "performance"; turbo = "always"; };
      battery = { governor = "performance"; turbo = "always"; };
    };
  };
}
