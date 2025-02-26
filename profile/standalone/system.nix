{ ... }: {
  imports = [
    ../../modules/system/btrfs.nix
    ../../modules/system/virtualize.nix
  ];
  # swapDevices = [ { device = "/swapfile"; priority = 2; size = 16*1024; } ];
  programs.gamemode.enable = true;
  boot.plymouth.enable = true;
  boot.loader.timeout = 1;
}
