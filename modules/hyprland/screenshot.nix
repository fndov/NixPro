{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [ unstable.grim unstable.slurp ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "mkdir -p /home/${settings.account.name}/Media/Pictures/Screenshots"
    ];
    wayland.windowManager.hyprland.settings.bind = [
      ",Print,exec,grim -g \"$(slurp)\" /home/${settings.account.name}/Media/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
    ];
  };
}
