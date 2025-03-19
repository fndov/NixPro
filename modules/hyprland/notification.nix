{ pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = {
    services.mako = {
      width = 600;
      height = 400;
      backgroundColor = "#1e1e2e";
      borderColor = "#3b3c47";
      borderRadius = 6;
      borderSize = 2;
      defaultTimeout = 6000;
      enable = true;
      font = "Iosevka 16";
      layer = "overlay";
      textColor = "#cdd6f4";
    };
    wayland.windowManager.hyprland.settings.exec-once = [ "pkill time-notice;time-notice" ];
    home.packages = with pkgs; [
      (writeShellScriptBin "time-notice" ''
          while true; do
              date_string=$(date "+%A, %B %d, %I:%M %p %Z %Y")
              notify-send "Current Date and Time" "$date_string"
              current_minute=$(date +%M)
              current_second=$(date +%S)
              seconds_to_wait=$((60 - current_minute))
              seconds_to_wait=$((seconds_to_wait * 60))
              seconds_to_wait=$((seconds_to_wait - current_second))
              sleep $seconds_to_wait
          done
      '')
    ];
  };
}
