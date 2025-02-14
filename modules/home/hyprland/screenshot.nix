{ pkgs, ... }: {
  home.packages = with pkgs; [
    slurp
    grim
  ];
  wayland.windowManager.hyprland.settings.bind = [
    ",Print,exec,grim -g \"$(slurp)\" ~/Media/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
  ];
}
