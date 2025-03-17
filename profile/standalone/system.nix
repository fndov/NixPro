{ ... }: {
  imports = [
    ../../modules/system/btrfs.nix
  ];
  # extra options that don't fit in modules/home
  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;
  hardware.steam-hardware.enable = true;
}
