/*
  NixPro-ISO Home Manager
  - All modules must fit within available RAM
  - Avoid heavy modules like user\software\apps\collection.nix
  - Keep system packages minimal
  - Consider compression settings carefully
*/
{ settings, ... }: {
  imports = [ /* Home-Manager */
    ../../modules/home/commands/sh.nix
    ../../modules/home/commands/cli.nix
    ../../modules/home/commands/lib.nix
    ../../modules/home/apps/${settings.user.terminal}.nix
    ../../modules/home/apps/${settings.user.browser}.nix
  ];
}