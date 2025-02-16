{ settings, ... }: {
  imports = [ /* Home-Manager */
    ../../modules/home/commands/sh.nix
    ../../modules/home/commands/cli.nix
    ../../modules/home/commands/lib.nix
    ../../modules/home/apps/${settings.user.terminal}.nix
    ../../modules/home/apps/${settings.user.browser}.nix
    ../../modules/home/collection.nix     
    ../../modules/home/spotify.nix
  ];
}
