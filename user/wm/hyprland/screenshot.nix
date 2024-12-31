{ pkgs, userSettings, ... }: {
  home.packages = [
    pkgs.slurp
    pkgs.grim
  ];
  wayland.windowManager.hyprland.settings.bind = [ ",Print,exec,grim -g \"\$(slurp)\"" ];
}
