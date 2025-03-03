{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7cb4ff42-4c16-4227-be44-91049697abf5";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "autodefrag"
      "space_cache=v2"
      "compress=zstd"
      "noatime"
      "nodiratime"
      # "nodatacow"
    ];
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}
