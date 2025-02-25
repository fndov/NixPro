{ ... }: {
  imports = [
    ../../modules/system/btrfs.nix
    ../../modules/system/virtualize.nix
  ];
  programs.gamemode.enable = true;
  boot.plymouth.enable = true;
  boot.loader.timeout = 1;
}
