{ ... }: {
  imports = [
    ../../modules/system/btrfs.nix
    ../../modules/system/virtualize.nix
  ];
  # swapDevices = [ { device = "/swapfile"; priority = 2; size = 16*1024; } ];
}
