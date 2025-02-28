{ pkgs, settings, ... }: {
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = [ pkgs.libsecret ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  services.greetd.enable = true;
  services.greetd.settings.default_session.command = "${pkgs.bash}/bin/bash -c 'clear; exec ${pkgs.hyprland}/bin/Hyprland &> /dev/null'";
  services.greetd.settings.default_session.user = "${settings.user.name}";
  security.pam.services.ly.enableGnomeKeyring = true;
  security.rtkit.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ "${settings.desktop.fontPkg}" ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "${settings.desktop.font} Mono" ];
    sansSerif = [ "${settings.desktop.font} Sans" ];
    serif = [ "${settings.desktop.font} Serif" ];
  };
  services.auto-cpufreq.enable = true;
  services.thermald.enable = false;
  home-manager.users.${settings.user.name}.wayland.windowManager.hyprland.settings.exec-once = [ "sudo auto-cpufreq --force performance" ];
  boot.plymouth.enable = true;
  boot.loader.timeout = 1;
}
