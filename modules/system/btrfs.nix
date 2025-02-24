{
  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/7cb4ff42-4c16-4227-be44-91049697abf5";
    fsType = "btrfs";
    options = [ 
      "subvol=@" 
      "compress=zstd" 
      "autodefrag" 
      "noatime" 
      "space_cache=v2" # Buggy?
      # "discard" # Speed.
    ];
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
}