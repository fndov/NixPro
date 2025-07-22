{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      rclone
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "rclone mount --daemon home: /home/${settings.account.name}/Cloud/"
    ];
  };
}
