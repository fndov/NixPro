{ userSettings, pkgs, ... }: let
  # See user/wm/wallpaper
  wallpaperName = "bunnies-road.png";
  # Check using `hyprctl monitors`
  monitor = "eDP-1";
in {
  home.packages = [ pkgs.hyprpaper ];
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprpaper" ];
  services.hyprpaper.enable = true;
  services.hyprpaper.settings.preload = "/home/${userSettings.username}/${userSettings.wallpaperPath}/${wallpaperName}";
	services.hyprpaper.settings.wallpaper = "${monitor},/home/${userSettings.username}/${userSettings.wallpaperPath}/${wallpaperName}";
}
