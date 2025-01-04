{ pkgs, ... }: {
  home.packages = [ pkgs.rofi-wayland ];
  wayland.windowManager.hyprland.settings.bind = [ "SUPER,semicolon,exec,rofi -show drun" ];
}
