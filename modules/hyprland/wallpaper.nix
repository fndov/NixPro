{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    monitor = "eDP-1"; # Check using `hyprctl monitors`
  in {
    home.packages = [ pkgs.hyprpaper ];
    wayland.windowManager.hyprland.settings.exec-once = [ "hyprpaper" ];
    services.hyprpaper.enable = true;
    services.hyprpaper.settings.preload = if settings.profile == "installation-media" then
      "/iso/home/${settings.account.name}/${settings.system.flakePath}/wallpaper.png"
    else "/home/${settings.account.name}/${settings.desktop.wallpaperPath}/${settings.desktop.wallpaperName}";
    services.hyprpaper.settings.wallpaper = if settings.profile == "installation-media" then
      "${monitor},/iso/home/${settings.account.name}/${settings.system.flakePath}/wallpaper.png"
    else "${monitor},/home/${settings.account.name}/${settings.desktop.wallpaperPath}/${settings.desktop.wallpaperName}";
  };
}
