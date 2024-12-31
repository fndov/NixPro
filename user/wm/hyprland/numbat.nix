{ pkgs, userSettings, ... }: {
  home.packages = [ pkgs.numbat ];
  wayland.windowManager.hyprland.settings.bind =
  [ "SUPER,n,exec,hyprctl dispatch exec '[float] ${userSettings.terminal} -e numbatw'" ];
}
