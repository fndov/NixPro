{ lib, pkgs, settings, ... }: let
  cfg = settings.desktop.enable or false;
in {
  config = lib.mkIf cfg (lib.mkMerge [
    (if settings.desktop.de == "plasma" then {
      home-manager.users.${settings.user.name}.imports = [ ../../user/de/plasma/default.nix ];
      services.xserver.enable = true;
      services.desktopManager.plasma6.enable = true;
      services.displayManager.ly.enable = true;
    } else {})
    (if settings.desktop.de == "gnome" then {
      services.xserver.enable = true;
      services.xserver.desktopManager.gnome.enable = true;
      services.displayManager.ly.enable = true;
    } else {})
    (if settings.desktop.de == "cinnamon" then {
      services.xserver.enable = true;
      services.xserver.desktopManager.cinnamon.enable = true;  
      services.displayManager.ly.enable = true;
    } else {})
    (if settings.desktop.de == "xfce" then {
      services.xserver.enable = true;
      services.xserver.desktopManager.xfce.enable = true;
      services.displayManager.ly.enable = true;
    } else {})
  ]);
}
