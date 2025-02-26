{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7cb4ff42-4c16-4227-be44-91049697abf5";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd"
      "autodefrag"
      "noatime"
      # "relatime"
      "nodiratime"
      "space_cache=v2" # Buggy?
      # "compress-force=zstd:15" # Smallest size.
      # "nodatacow" Adds speed.
      # "commit=120" Adds speed.
    ];
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}

# try doing just home and nix/store
