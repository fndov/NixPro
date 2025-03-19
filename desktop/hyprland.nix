{ pkgs, settings, lib, ... }: {
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = [ pkgs.libsecret ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk ];
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  services.greetd.enable = true;
  services.greetd.settings.default_session.command = "${pkgs.bash}/bin/bash -c 'clear; exec ${pkgs.hyprland}/bin/Hyprland &> /dev/null'";
  services.greetd.settings.default_session.user = "${settings.user.name}";
  security.pam.services.ly.enableGnomeKeyring = true;
  security.rtkit.enable = true;
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.enable = true;
  fonts.packages = [ pkgs.${settings.desktop.fontPkg} ];
  fonts.fontconfig.defaultFonts.monospace = [ "${settings.desktop.font} Mono" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "${settings.desktop.font} Sans" ];
  fonts.fontconfig.defaultFonts.serif = [ "${settings.desktop.font} Serif" ];
  services.auto-cpufreq.enable = true;
  services.thermald.enable = false;
  boot.plymouth.enable = true;
  boot.loader.timeout = 1;

  imports = [
    ../modules/hyprland/animation.nix
    ../modules/hyprland/cursor.nix
    ../modules/hyprland/dependencies.nix
    ../modules/hyprland/dock.nix
    ../modules/hyprland/keyboard.nix
    ../modules/hyprland/launcher.nix
    ../modules/hyprland/lock-screen.nix
    ../modules/hyprland/nightlight.nix
    ../modules/hyprland/notification.nix
    ../modules/hyprland/rules.nix
    ../modules/hyprland/screenshot.nix
    ../modules/hyprland/task-bar.nix
    ../modules/hyprland/terminal.nix
    ../modules/hyprland/theme.nix
    ../modules/hyprland/timeout.nix
    ../modules/hyprland/wallpaper.nix
    # ../modules/home/hyprland/plugins.nix
  ];

  home-manager.users.${settings.user.name} = lib.mkMerge [
    {
      services.blueman-applet.enable = if settings.driver.bluetooth == true then true else false; # fix
      services.udiskie.enable = true;
      services.udiskie.tray = "always";
      home.packages = [ pkgs.hyprpolkitagent ];
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
            "sudo auto-cpufreq --force performance"
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
            gaps_in = 2; # 4
            gaps_out = 6;
            "col.active_border" = "rgb(3b3c47)";
            "col.inactive_border" = "rgb(3b3c47)";
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
    }
    (lib.mkIf (settings.profile == "virtual-machine") {
      wayland.windowManager.hyprland.settings.monitor = "Virtual-1, 1920x1080, 0x0, 1";
    })
    (lib.mkIf (settings.profile == "image") {
      wayland.windowManager.hyprland.settings.exec-once = [
        "cp -r /iso/home/${settings.user.name}/${settings.system.flakePath} /home/${settings.user.name}; chown -R ${settings.user.name} /home/${settings.user.name}/${settings.system.flakePath}; chmod -R 777 /home/${settings.user.name}/${settings.system.flakePath}"
        "sudo systemctl restart NetworkManager"
        "${settings.user.terminal} -e 'sleep 1;nmtui'"
        "sudo rm -rf /home/nixos/"
        "sudo nixos-generate-config && cp /etc/nixos/hardware.nix /home/${settings.user.name}/${settings.system.flakePath}/modules/system/"
        "notify-send 'Welcome to Hyprland by NixPro!'"
      ];
    })
  ];
}
