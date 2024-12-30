{ pkgs, ... }: {
  programs = {
    hyprland = {
      enable = true;
      xwayland = { enable = true; };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.displayManager.ly.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
  };
}
