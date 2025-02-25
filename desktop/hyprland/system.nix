{ pkgs, settings, ... }: {
  nix.settings.substituters = ["https://hyprland.cachix.org"];
  nix.settings.trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = [ pkgs.libsecret ];
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

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
      default_session = {
        command = "${pkgs.bash}/bin/bash -c 'clear; exec ${pkgs.hyprland}/bin/Hyprland &> /dev/null'";
        user = "${settings.user.name}";
      };
    };
  };

  services.auto-cpufreq = {
    enable = true;
    # settings = {
    #   charger = { governor = "performance"; turbo = "always"; };
    #   battery = { governor = "performance"; turbo = "always"; };
    # };
  };
  services.thermald.enable = false;
}
