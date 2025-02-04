{ settings, ... }: {
  zramSwap.enable = true;
  zramSwap.memoryPercent = if settings.profile == "image" then 70 else 40;  /*
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 32*1024; # Swap size, useful for `systemctl hibernate`.
  } ]; */
}
