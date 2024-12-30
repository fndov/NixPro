{ pkgs, ... }: {
  home.packages = with pkgs; [ rofi-wayland ];
  wayland.windowManager.hyprland.settings.bind = [ "SUPER,semicolon,exec,rofi -show drun" ];
}
