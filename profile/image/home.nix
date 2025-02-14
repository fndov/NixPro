/*
  NixPro-ISO Home Manager
  - All modules must fit within available RAM
  - Avoid heavy modules like user\software\apps\collection.nix
  - Keep system packages minimal
  - Consider compression settings carefully
*/
{ settings, ... }: {
  imports = [ /* Home-Manager */
    ../../module/home/commands/sh.nix
    ../../module/home/commands/cli.nix
    ../../module/home/commands/lib.nix
    ../../module/home/apps/${settings.user.terminal}.nix
    ../../module/home/apps/${settings.user.browser}.nix
  ];
}