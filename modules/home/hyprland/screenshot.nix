{ pkgs, settings, ... }: {
  home.packages = with pkgs; [
    slurp
    grim
  ];
  wayland.windowManager.hyprland.settings.exec-once = [
    "mkdir -p /home/${settings.user.name}/Media/Pictures/Screenshots" 
  ];
  wayland.windowManager.hyprland.settings.bind = [
    ",Print,exec,grim -g \"$(slurp)\" /home/${settings.user.name}/Media/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
  ];
}