{ pkgs, settings, ... }: 
if settings.desktop.wm == "hyprland" then {
  programs.hyprland.enable = true;
  programs.hyprland.xwayland = { enable = true; };
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.displayManager.ly.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
}
else if settings.desktop.wm == "i3" then {
  # i3 configuration here
}
else if settings.desktop.wm == "bspwm" then {
  # bspwm configuration here
}
else if settings.desktop.wm == "awesome" then {
  # awesome configuration here
}
else if settings.desktop.wm == "dwm" then {
  # dwm configuration here
}
else {}
