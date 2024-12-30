{ pkgs, ... }: {
  home.packages = [ pkgs.hyprpolkitagent ];
  wayland.windowManager.hyprland.settings.exec-once = [ "systemctl --user start hyprpolkitagent" ];
}
