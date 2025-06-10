{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = [ pkgs.hypridle ];
    wayland.windowManager.hyprland.settings.exec-once = [ "systemctl --user enable --now hypridle.service" ];
    services.hypridle = {
      enable = true;
      settings = {
        general.before_sleep_cmd = "pid hyprlock || hyprlock --immediate";
        general.after_sleep_cmd = "hyprctl dispatch dpms on";
        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 3";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 300;
            on-timeout = "pid hyprlock || hyprlock || cw";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 400;
            on-timeout = "pid hyprlock || hyprlock --immediate & systemctl suspend";
          }
        ];
      };
    };
  };
}
