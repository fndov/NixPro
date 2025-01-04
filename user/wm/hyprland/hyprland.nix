{ userSettings, ... }: {
  services.blueman-applet.enable = true;
  services.udiskie.enable = true;
  services.udiskie.tray = "always";
  imports = [
    # ./gamemode.nix         # Game mode.
    # ./calculator.nix       # Calculator.
    ./bottom.nix             # System Monitor.
    ./task-bar.nix           # Top bar.
    ./timeout.nix            # Idle.
    ./keyboard.nix           # Keyboard.
    ./launcher.nix           # App launcher.
    ./nightlight.nix         # Nightlight.
    ./screenshot.nix         # Screenshot.
    ./cursor.nix             # Cursor.
    ./lock-screen.nix        # Lock screen.
    ./notification.nix       # Notifications.
    ./dependencies.nix       # Dependency.
    ./polkitagent.nix        # Wayland security.
    ./hyprpaper.nix          # Wallpaper.
    .././theme.nix           # App themes.
    .././clipboard.nix       # Clipboard.
    .././fonts.nix           # Fonts.
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # monitor = "Virtual-1, 1920x1080, 0x0, 1"; # For VM's.

      exec-once = [
        "gnome-keyring-daemon --start --components=secrets"
        "nm-applet --indicator"
        "blueman-applet"
      ];

      env = [
	    "BROWSER,${userSettings.browser}"
	    "EDITOR,${userSettings.editor}"
	    "TERMINAL,${userSettings.terminal}"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        # "WLR_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
        # "GDK_BACKEND,wayland,x11,*"
        # "QT_QPA_PLATFORM,wayland;xcb"
        # "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "XDG_SESSION_TYPE,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "CLUTTER_BACKEND,wayland"
        "GTK_USE_PORTAL,1"
      ];

      input = {
        # natural_scroll = true;
      };

      input.touchpad = {
        natural_scroll = true;
        # drag_lock = true;
        # tap-and-drag = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 170;
        workspace_swipe_fingers = 3;
        workspace_swipe_cancel_ratio = 0.2;
        # workspace_swipe_min_speed_to_force = 1
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 100;
        workspace_swipe_create_new = true;
        workspace_swipe_invert = true;
        workspace_swipe_forever = true;
      };

      general = {
        layout = "master";
        border_size = 3;
        resize_on_border = true;
        gaps_in = 7;
        gaps_out = 7;
        "col.active_border"  = "rgb(3b3c47)";
        "col.inactive_border" = "0x00000000";
        border_part_of_window = true; # false;
        no_border_on_floating = true; # false;
      };

      decoration = {
        rounding = 8;
        active_opacity = 1;
        inactive_opacity = 1;
        fullscreen_opacity = 1;
        dim_inactive = true;
        dim_strength = 0.2;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;
          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };

      misc = {
        # disable_autoreload = true;
        # always_follow_on_dnd = true;
        # layers_hog_keyboard_focus = true;
        # new_window_takes_over_fullscreen = 2;
        # render_ahead_of_time = true; # "Warning: Buggy".
        enable_swallow = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        disable_hyprland_logo = true;
        focus_on_activate = true;
        middle_click_paste = false;
        close_special_on_empty = true;
        vfr = true; # Variable frame rate.
      };

       windowrulev2 = [
         "float, title:^(Picture-in-Picture)$"
         "pin, title:^(Picture-in-Picture)$"
       ];
    };
  };
}
