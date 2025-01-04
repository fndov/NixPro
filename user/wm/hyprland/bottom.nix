{ pkgs, userSettings, ... }: {
  home.packages = [ pkgs.bottom ];
  # wayland.windowManager.hyprland.settings.bind = [ "SUPER,B,exec,hyprctl dispatch exec '[float] ${userSettings.terminal} -e btm'" ];
  # Fix this ^^^
}
