{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7cb4ff42-4c16-4227-be44-91049697abf5";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd"
      "autodefrag"
      "noatime"
      "nodiratime"
      "nodatacow"
      "space_cache=v2" # Buggy?
      # "compress-force=zstd:15" # Smallest size.
      # "commit=120" Adds speed.
    ];
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}
