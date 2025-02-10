{ settings, ... }: {
  services.blueman-applet.enable = if settings.profile != "image" then false else true;
  services.udiskie.enable = true;
  services.udiskie.tray = "always";
  imports = [ /* Hyprland */
    ./features/theme.nix
    ./features/cursor.nix
    ./features/wallpaper.nix
    ./features/keyboard.nix
    ./features/launcher.nix
    ./features/lock-screen.nix
    ./features/nightlight.nix
    ./features/notification.nix
    ./features/screenshot.nix
    ./features/task-bar.nix
    ./features/timeout.nix
    ./settings/animation.nix
    ./settings/dependencies.nix
    ./settings/polkitagent.nix
    ./settings/rules.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;

    settings = {
      exec-once = [
        "gnome-keyring-daemon --start --components=secrets"
        "nm-applet --indicator"
        "blueman-applet"
      ];

      env = [
        "MOZ_ENABLE_WAYLAND,1"
	      "BROWSER,${settings.user.browser}"
	      "EDITOR,${settings.user.editor}"
	      "TERMINAL,${settings.user.terminal}"
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
        layout = "master"; # "dwindle";
        snap.enabled = true;
        border_size = 3;
        resize_on_border = true;
        gaps_in = 4;
        gaps_out = 7;
        "col.active_border"  = "rgb(3b3c47)";
        "col.inactive_border" = "0x00000000";
        border_part_of_window = true;
        no_border_on_floating = false;
      }; 

      /*
      master = {
        allow_small_split = true;
        always_center_master = true;
        drop_at_cursor = true;
        inherit_fullscreen = false;
        mfact = 0.55;
        new_on_top = true;
        new_status = "master";
        orientation = "center";
        smart_resizing = true;
      };
      */

      decoration = {
        rounding = 7;
        active_opacity = 1;
        inactive_opacity = 1;
        fullscreen_opacity = 1;
        dim_inactive = true;
        dim_strength = 0.2;
        dim_around = 0.6;

        blur = {
          enabled = false;
          size = 5;
          passes = 3;
          brightness = 0.8172;
          contrast = 1.4;
          vibrancy = 0.1696;
          ignore_opacity = true;
          noise = 0.01;
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
        disable_hyprland_logo = true;
        disable_splash_rendering = false;
        enable_swallow = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        focus_on_activate = true;
        middle_click_paste = false;
        close_special_on_empty = true;
        vfr = true;
        mouse_move_enables_dpms = "on";
        key_press_enables_dpms = "on";
      };
    };
  };
}
