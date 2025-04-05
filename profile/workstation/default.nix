{ ... }: {
  imports = [
    ../../modules/commands/sh.nix
    ../../modules/commands/cli.nix
    ../../modules/commands/lib.nix
    ../../modules/apps/collection.nix
    ../../modules/apps/spotify.nix
    ../../modules/apps/lutris.nix
    ../../modules/apps/virtualize.nix
  ];
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
    ];
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}
