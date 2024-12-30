{ pkgs, ... }:
{
  # https://hyprpanel.com/getting_started/installation.html#nixos-home-manager
  home.packages = [ pkgs.hyprpanel ];
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "hyprpanel"
      ];
    };
  };
}