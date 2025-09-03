{ settings, ... }: {
  home-manager.users.${settings.account.name} = {
    wayland.windowManager.hyprland.settings.bindl = [
      "SUPERSHIFT,left,exec, hyprctl hyprsunset temperature -250"
      "SUPERSHIFT,right,exec, hyprctl hyprsunset temperature +250"
      "SUPERSHIFT,down,exec, systemctl --user restart hyprsunset"
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "systemctl --user enable --now hyprsunset"
    ];
    services.hyprsunset.enable = true;
  };
}
