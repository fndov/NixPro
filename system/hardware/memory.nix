{ ... }: {
  zramSwap.enable = true;
  # swapDevices = [ {
  #   device = "/var/lib/swapfile";
  #   size = 4*1024; # Swap size.
  # } ];
}
