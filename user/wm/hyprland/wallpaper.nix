{ userSettings, systemSettings, pkgs, ... }: let
  # See user/wm/wallpaper
  wallpaper-name = "dark-waves.jpg";
  # Check using `hyprctl monitors`
  monitor = "eDP-1";
in {
  home.packages = [ pkgs.hyprpaper ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/${userSettings.username}/${systemSettings.flakePath}/user/wm/wallpaper/${wallpaper-name}
    wallpaper = ${monitor},/home/${userSettings.username}/${systemSettings.flakePath}/user/wm/wallpaper/${wallpaper-name}
  '';

  wayland.windowManager.hyprland.settings.exec-once = [ "hyprpaper" ];
}
