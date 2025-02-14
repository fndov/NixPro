{ pkgs, ... }: {
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
  home.packages = with pkgs; [
    (writeShellScriptBin "time-notice" '' # Send a notification of the time every hour to display the time.
        while true; do
            # Get the current date in the desired format
            date_string=$(date "+%A, %B %d, %I:%M %p %Z %Y")

            # Show the notification
            notify-send "Current Date and Time" "$date_string"

            # Wait until the next full hour
            current_minute=$(date +%M)
            current_second=$(date +%S)

            # Calculate how many seconds to wait until the next full hour
            seconds_to_wait=$((60 - current_minute))    # Time until next full minute
            seconds_to_wait=$((seconds_to_wait * 60))   # Convert to seconds until next hour
            seconds_to_wait=$((seconds_to_wait - current_second))  # Subtract the current second

            sleep $seconds_to_wait
        done
    '')
  ];
  wayland.windowManager.hyprland.settings.exec-once = [ "pkill time-notice && time-notice" ];
}
