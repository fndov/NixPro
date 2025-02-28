{ pkgs, settings, ... }: {
  services.blueman-applet.enable = if settings.driver.bluetooth == true then true else false;
  services.udiskie.enable = true;
  services.udiskie.tray = "always";
  home.packages = [ pkgs.hyprpolkitagent ];
  imports = [
    ../../modules/home/hyprland/terminal.nix
    ../../modules/home/hyprland/theme.nix
    ../../modules/home/hyprland/cursor.nix
    ../../modules/home/hyprland/wallpaper.nix
    ../../modules/home/hyprland/keyboard.nix
    ../../modules/home/hyprland/launcher.nix
    ../../modules/home/hyprland/lock-screen.nix
    ../../modules/home/hyprland/nightlight.nix
    ../../modules/home/hyprland/notification.nix
    ../../modules/home/hyprland/screenshot.nix
    ../../modules/home/hyprland/task-bar.nix
    ../../modules/home/hyprland/timeout.nix
    ../../modules/home/hyprland/animation.nix
    ../../modules/home/hyprland/dependencies.nix
    ../../modules/home/hyprland/rules.nix
    ../../modules/home/hyprland/dock.nix
    ../../modules/home/hyprland/plugins.nix
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
        "systemctl --user start hyprpolkitagent"
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
      input.natural_scroll = false;
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
          enabled = true;
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
  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "/home/${settings.user.name}/Media/Music";
    videos = "/home/${settings.user.name}/Media/Videos";
    pictures = "/home/${settings.user.name}/Media/Pictures";
    templates = "/home/${settings.user.name}/Templates";
    download = "/home/${settings.user.name}/Downloads";
    documents = "/home/${settings.user.name}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_ARCHIVE_DIR = "/home/${settings.user.name}/Archive";
      XDG_VM_DIR = "/home/${settings.user.name}/Machines";
      XDG_ORG_DIR = "/home/${settings.user.name}/Org";
      XDG_PODCAST_DIR = "/home/${settings.user.name}/Media/Podcasts";
      XDG_BOOK_DIR = "/home/${settings.user.name}/Media/Books";
    };
  };
  home.sessionVariables.EDITOR = settings.user.editor;
  home.sessionVariables.TERM = settings.user.terminal;
  home.sessionVariables.BROWSER = settings.user.browser;
} // (if settings.profile == "virtual-machine" then {
  wayland.windowManager.hyprland.settings.monitor = "Virtual-1, 1920x1080, 0x0, 1";
} else {}) // (if (settings.profile == "image") then {
  wayland.windowManager.hyprland.settings.exec-once = [
    "cp -r /iso/home/${settings.user.name}/${settings.system.flakePath} /home/${settings.user.name}; chown -R ${settings.user.name} /home/${settings.user.name}/${settings.system.flakePath}; chmod -R 777 /home/${settings.user.name}/${settings.system.flakePath}"
    "sudo systemctl restart NetworkManager"
    "${settings.user.terminal} -e 'sleep 1;nmtui'"
    "sudo rm -rf /home/nixos/"
    "sudo nixos-generate-config && cp /etc/nixos/hardware.nix /home/${settings.user.name}/${settings.system.flakePath}/modules/system/"
    "notify-send 'Welcome to Hyprland by NixPro!'"
  ];
} else {})
