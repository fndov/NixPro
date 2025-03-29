{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [ grim slurp ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "mkdir -p /home/${settings.account.name}/Media/Pictures/Screenshots"
    ];
    wayland.windowManager.hyprland.settings.bind = [
      ",Print,exec,grim -g \"$(slurp)\" /home/${settings.account.name}/Media/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
    ];
  };
}
