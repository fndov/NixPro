{ userSettings, ... }: {
  services.blueman-applet.enable = true;
  services.udiskie.enable = true;
  services.udiskie.tray = "always";

  imports = [
    # ./gamemode.nix        # Game mode.
    # ./timeout.nix         # Idle.
    # ./calculator.nix      # Calculator.
    ./task-bar.nix          # Top bar.
    ./keyboard.nix          # Keyboard.
    ./launcher.nix          # App launcher.
    ./nightlight.nix        # Nightlight.
    ./screenshot.nix        # Screenshot.
    ./bottom.nix           # System Monitor.
    ./cursor.nix           # Cursor.
    ./lock-screen.nix      # Lock screen.
    ./notification.nix     # Notifications.
    ./dependencies.nix     # Dependency.
    ./polkitagent.nix     # Wayland security.
    ./wallpaper.nix       # Wallpaper.
    .././theme.nix        # App themes.
    .././clipboard.nix    # Clipboard.
    .././fonts.nix        # Fonts.
  ];

  wayland.windowManager.hyprland = {
    systemd.enable = true;
    enable = true;
    xwayland.enable = true;

    settings = {
      # For VM's.
      # monitor = "Virtual-1, 1920x1080, 0x0, 1";

      exec-once = [
        "ghostty --initial-window=false"
        "${userSettings.terminal}"
        "nm-applet --indicator"
        "blueman-applet"
        "gnome-keyring-daemon --start --components=secrets"
      ];

      env = [
	    "BROWSER,${userSettings.browser}"
	    "EDITOR,${userSettings.editor}"
	    "TERMINAL,${userSettings.terminal}"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        # "WLR_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
        # "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
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
        #workspace_swipe_min_speed_to_force = 1
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 100;
        workspace_swipe_create_new = true;
        workspace_swipe_invert = true;
        workspace_swipe_forever = true;
      };

      general = {
        border_size = 5;
        resize_on_border = true;
        gaps_in = 7;
        gaps_out = 7;
        "col.active_border"  = "rgb(48425F)";
        "col.inactive_border" = "0x00000000";
        border_part_of_window = false;
        no_border_on_floating = false;
      };

      decoration = {
        rounding = 8;
        active_opacity = 1; # 0.90
        inactive_opacity = 0.95;
        fullscreen_opacity = 1;

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
        disable_hyprland_logo = true;
        # always_follow_on_dnd = true;
        # layers_hog_keyboard_focus = true;
        # animate_manual_resizes = false;
        # enable_swallow = true;
        focus_on_activate = true;
        # new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };

       windowrulev2 = [
         "float, title:^(Picture in picture)$"
         "pin, title:^(Picture in picture)$ "
       ];
    };
  };
}
