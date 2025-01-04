{ pkgs, ... }: {
  home.packages = [ pkgs.dunst ];
  wayland.windowManager.hyprland.settings.exec-once = [ "dunst" ];
}
