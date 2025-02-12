{ settings, ... }: {
  zramSwap.enable = builtins.elem settings.profile [ "image" "standalone" "virtual-machine" "server" ];
  zramSwap.memoryPercent = if settings.profile == "image" then 100 else 40;
  zramSwap.algorithm = "zstd -Xcompression-level 22"; # lzo is small, zstd is fast.
  zramSwap.priority = if settings.profile == "image" then 100 else 5; 
  boot.kernel.sysctl = {
    "vm.swappiness" = if settings.profile == "image" then 60 else 40; 
    "vm.vfs_cache_pressure" = if settings.profile == "image" then 100 else 100;
    "vm.dirty_ratio" = if settings.profile == "image" then 50 else 40;
  };
  services.earlyoom = {
    enable = if settings.profile == "image" then true else false;
    enableNotifications = true;
    freeMemThreshold = 3;
    freeMemKillThreshold = 3;
    freeSwapThreshold = 3;
    freeSwapKillThreshold = 3;
  }; /*
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32*1024; # Useful for `systemctl hibernate`.
    }
  ]; */
}
