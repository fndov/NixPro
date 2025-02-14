{
  services.hypridle = { # Put the system to rest when not in use.
    enable = true;

    settings = {
      general = {
        before_sleep_cmd = "pid hyprlock || hyprlock --immediate"; # Lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # Avoid having to press a key twice to turn on the display.
      };

      listener = [
        # Dim screen.
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }

        # Lock screen.
        {
          timeout = 300;
          on-timeout = "pid hyprlock || hyprlock || cw";
        }

        # Turn off screen.
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        # Suspend.
        {
          timeout = 1800;
          on-timeout = "pid hyprlock || hyprlock --immediate & systemctl suspend";
        }
      ];
    };
  };
}
