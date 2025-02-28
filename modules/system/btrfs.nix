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
      "space_cache=v2"
      # "relatime"
      # "nodatacow"
      # "commit=120"
    ];
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}
