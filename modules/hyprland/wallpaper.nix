{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
  monitor = settings.desktop.wallpaperMonitor; # Check using `hyprctl monitors`
  in {
    home.packages = with pkgs; [
      hyprpaper
      waypaper
    ];
    wayland.windowManager.hyprland.settings.exec-once = [ "hyprpaper" ];
    services.hyprpaper.enable = true;
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER,N,exec, waypaper --random"
      "SUPERSHIFT,N,exec, pkill hyprpaper"
    ];
    services.hyprpaper.settings.preload = if settings.profile == "image" then
      "/iso/home/${settings.account.name}/${settings.system.flakePath}/wallpaper.png"
    else "/home/${settings.account.name}/${settings.desktop.wallpaperPath}/${settings.desktop.wallpaperName}";
    services.hyprpaper.settings.wallpaper = if settings.profile == "image" then
      "${monitor},/iso/home/${settings.account.name}/${settings.system.flakePath}/wallpaper.png"
    else "${monitor},/home/${settings.account.name}/${settings.desktop.wallpaperPath}/${settings.desktop.wallpaperName}";
  };
}
