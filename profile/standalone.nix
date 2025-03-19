{ ... }: {
  imports = [
    ../modules/apps/steam.nix
    ../modules/apps/collection.nix
    ../modules/apps/spotify.nix
    ../modules/system/btrfs.nix
    ../modules/commands/sh.nix
    ../modules/commands/cli.nix
    ../modules/commands/lib.nix
  ];
}
