{ pkgs, settings, ... }: { /*
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages = pkgs.linuxPackages_hardened; */

  boot.kernelPackages = if settings.profile == "standalone"
    then pkgs.linuxPackages_xanmod_latest
  else pkgs.linuxPackages;
  

  boot.blacklistedKernelModules = [ "nouveau" ];

  boot.kernelParams = [
    "quiet"
    "mitigations=off"
    "init_on_alloc=0"
    "init_on_free=0"
    "no_timer_check"
    "nowatchdog"
    "fastboot"
    "preempt=full"
    "idle=nomwait" /*
    
    "noatime"
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
    "page_alloc.shuffle=1"

    "i915.fastboot=1"
    "raid=noautodetect"
    "noapic" */
  ];
  services.thermald.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = { governor = "performance"; turbo = "always"; };
      battery = { governor = "performance"; turbo = "always"; };
    };
  };
}
