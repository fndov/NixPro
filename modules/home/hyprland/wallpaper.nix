{ pkgs, settings, ... }: let
  # Check using `hyprctl monitors`
  monitor = "eDP-1";
in {
  home.packages = [ pkgs.hyprpaper ];
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprpaper" ];
  services.hyprpaper.enable = true;
  services.hyprpaper.settings.preload = if settings.profile == "image" then
    "/iso/home/${settings.user.name}/${settings.system.flakePath}/profile/image/wallpaper.png"
  else "/home/${settings.user.name}/${settings.desktop.wallpaperPath}/${settings.desktop.wallpaperName}";
  services.hyprpaper.settings.wallpaper = if settings.profile == "image" then
    "${monitor},/iso/home/${settings.user.name}/${settings.system.flakePath}/profile/image/wallpaper.png"
  else "${monitor},/home/${settings.user.name}/${settings.desktop.wallpaperPath}/${settings.desktop.wallpaperName}";
}
