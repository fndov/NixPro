{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [ unstable.grim unstable.slurp ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "mkdir -p /home/${settings.account.name}/Media/Pictures/Screenshots"
    ];
    wayland.windowManager.hyprland.settings.bind = [
    '',Print,exec,grim -g "$(slurp -b '#00000000' -c '#00000000' -s '#00000000')" /home/${settings.account.name}/Media/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png''
    ];
  };
}
