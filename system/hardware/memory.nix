{ settings, ... }: {
  zramSwap.enable = true;
  zramSwap.memoryPercent = if settings.profile == "iso" then 60 else 40;  /*
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 32*1024; # Swap size, useful for `systemctl hibernate`.
  } ]; */
}
