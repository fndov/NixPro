{ lib, pkgs, settings, ... }: let
  cfg = settings.desktop.enable or false;
in {
  config = lib.mkIf cfg (lib.mkMerge [
    (if settings.desktop.wm == "hyprland" then {
      programs.hyprland.enable = true;
      programs.hyprland.xwayland.enable = true;
      programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      
      home-manager.users.${settings.user.name}.imports = [ ../../user/wm/hyprland/default.nix ];
      
      xdg.portal.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
      services.udisks2.enable = true;
      services.devmon.enable = true;
      services.gvfs.enable = true;

      fonts = {
        enableDefaultPackages = true;
        fontconfig.enable = true;
        packages = with pkgs; [ "${settings.desktop.fontPkg}" ];
        fontconfig.defaultFonts = {
          monospace = [ "${settings.desktop.font} Mono"];
          sansSerif = ["${settings.desktop.font} Sans"];
          serif = ["${settings.desktop.font} Serif"];
        };
      };
      services.greetd = {
        enable = true;
        settings = {
          initial_session = {
            command = "${pkgs.hyprland}/bin/Hyprland";
            user = "${settings.user.name}";
          };
        };
      };
    } else {})
    (if settings.desktop.wm == "sway" then {
    } else {})
    (if settings.desktop.wm == "dwm" then {
    } else {})
  ]);
}
