{ settings, ... }: {
  zramSwap.enable = builtins.elem settings.profile [ "image" "standalone" "virtual-machine" "server" ];
  zramSwap.memoryPercent = if settings.profile == "image" then 95 else 40;
  zramSwap.algorithm = "lzo";
  # zramSwap.priority = 5; # Not sure if disk data will be cleared from memory and lost.
  boot.kernel.sysctl =
    if settings.profile == "image"
    then {
      "vm.swappiness" = 100;
      "vm.vfs_cache_pressure" = 500;
    }
    else {
      # boot.kernel.sysctl."vm.dirty_ratio" = 10; # Move cache to disk at 10% dirty pages
    };
  services.earlyoom = { 
    enable = if settings.profile == "image" then true else false;
    enableNotifications = true;
    freeMemThreshold = 10;
    freeMemKillThreshold = 10;
    freeSwapThreshold = 10;
    freeSwapKillThreshold = 10;
  };
  /*
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32*1024; # Useful for `systemctl hibernate`.
    }
  ];
  */
}
