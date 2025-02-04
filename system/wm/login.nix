{ pkgs, ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.xwayland = { enable = true; };
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.displayManager.ly.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
}
