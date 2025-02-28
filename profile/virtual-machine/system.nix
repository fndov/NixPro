{ ... }: {
  imports = [ ];
  # swapDevices = [ { device = "/swapfile"; priority = 2; size = 16*1024; } ];
  boot.loader.timeout = 1;
}
