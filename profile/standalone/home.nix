{ ... }: {
  imports = [
    ../../modules/home/commands/sh.nix
    ../../modules/home/commands/cli.nix
    ../../modules/home/commands/lib.nix
    ../../modules/home/apps/collection.nix
    ../../modules/home/apps/spotify.nix
    ../../modules/home/apps/steam.nix
  ];
}
