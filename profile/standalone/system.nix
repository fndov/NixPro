{ ... }: {
  imports = [ ../../modules/system/btrfs.nix ];
  programs.gamemode.enable = true;
  programs.gamemode.enableRenice = true;
  hardware.steam-hardware.enable = true;
  nixpkgs.config.allowUnfree = true;
}
