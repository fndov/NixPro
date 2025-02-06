{ lib, pkgs, settings, ... }:
let
  cfg = settings.desktop.enable or false;
in
{
  config = lib.mkIf cfg (lib.mkMerge [
    (if settings.desktop.de == "plasma" then {
      services.xserver.enable = true;
      services.desktopManager.plasma6.enable = true;
      services.displayManager.ly.enable = true;
    } else {})
    (if settings.desktop.de == "gnome" then {
      # gnome configuration here
    } else {})
    (if settings.desktop.de == "cinnamon" then {
      # cinnamon configuration here
    } else {})
    (if settings.desktop.de == "xfce" then {
      # xfce configuration here
    } else {})
  ]);
}
