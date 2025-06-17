{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    services.mako = {
      enable = true;
      settings = {
        width = 600;
        height = 400;
        "background-color" = "#1e1e2e";
        "border-color" = "#3b3c47";
        "border-radius" = 6;
        "border-size" = 2;
        "default-timeout" = 6000;
        font = "Iosevka 16";
        layer = "overlay";
        "text-color" = "#cdd6f4";
      };
    };
    wayland.windowManager.hyprland.settings.exec-once = [
      "pkill time-notice"
      "time-notice"
    ];
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
