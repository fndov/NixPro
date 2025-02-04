{ ... }: {
  zramSwap.enable = true;
  zramSwap.memoryPercent = 40; /*
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 32*1024; # Swap size, useful for `systemctl hibernate`.
  } ]; */
}
