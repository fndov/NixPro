{ settings, ... }: {
  zramSwap.enable = builtins.elem settings.profile [ "image" "standalone" "virtual-machine" "server" ];
  zramSwap.memoryPercent = if settings.profile == "image" then 90 else 40;  /*
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 32*1024; # Swap size, useful for `systemctl hibernate`.
  } ]; */
}
