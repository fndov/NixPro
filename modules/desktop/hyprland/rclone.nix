{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [
      rclone
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "rclone mount --daemon home: /home/${settings.account.name}/Cloud/"
    ];
  };
}
