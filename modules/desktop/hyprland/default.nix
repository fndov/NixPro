{ config, inputs, lib, pkgs, settings, ... }: {
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [ libsecret cups-filters ];
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  programs.hyprland.portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-gtk ];
  services.blueman.enable = true;
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
  services.greetd.settings.default_session.user = settings.account.name;
  services.getty.autologinUser = lib.mkForce "${settings.account.name}";
  services.getty.helpLine = lib.mkForce "";
  services.thermald.enable = false;
  security.pam.services.greetd = lib.mkIf config.services.greetd.enable { enableGnomeKeyring = true; };
  security.rtkit.enable = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ noto-fonts inter ];
  fonts.fontconfig.defaultFonts.monospace = [ "Noto Mono" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Inter" "Noto Sans" ];
  fonts.fontconfig.defaultFonts.serif = [ "Noto Serif" ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  boot.plymouth.enable = true;
  boot.loader.timeout = 1;
  services.power-profiles-daemon.enable = true;
  imports = [
    ../hyprland/animation.nix
    ../hyprland/cursor.nix
    ../hyprland/dependencies.nix
    ../hyprland/dock.nix
    ../hyprland/keyboard.nix
    ../hyprland/launcher.nix
    ../hyprland/lock-screen.nix
    ../hyprland/nightlight.nix
    ../hyprland/notification.nix
    ../hyprland/rules.nix
    ../hyprland/screenshot.nix
    ../hyprland/task-bar.nix
    ../hyprland/theme.nix
    ../hyprland/timeout.nix
    ../hyprland/wallpaper.nix
  ] ++ lib.optional (settings.profile == "workstation") ../hyprland/tts.nix;
  home-manager.users.${settings.account.name} = lib.mkMerge [
    {
      services.blueman-applet.enable = true;
      services.udiskie.enable = true;
      services.udiskie.tray = "always";
      home.packages = with pkgs; [
        hyprpolkitagent
        libnotify
        mako
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        xwayland.enable = false;
        settings = {
          monitor = settings.desktop.monitors;
          exec-once = [
            "powerprofilesctl set performance"
            "nm-applet --indicator"
            "blueman-applet"
            "systemctl --user start hyprpolkitagent"
            "gnome-keyring-daemon --start --components=secrets"
          ];
          env = [
            "EDITOR,${settings.account.editor}"
            "TERMINAL,${settings.account.terminal}"
            "XDG_SESSION_DESKTOP,Hyprland"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "GDK_BACKEND,wayland,x11,*"
            "QT_QPA_PLATFORM,wayland;xcb"
            "QT_AUTO_SCREEN_SCALE_FACTOR,1"
            "XDG_SESSION_TYPE,wayland"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "CLUTTER_BACKEND,wayland"
            "GTK_USE_PORTAL,1"
          ];
          input.natural_scroll = false;
          input.touchpad = {
            natural_scroll = true;
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_distance = 170;
            workspace_swipe_fingers = 3;
            workspace_swipe_cancel_ratio = 0.2;
            workspace_swipe_direction_lock = true;
            workspace_swipe_direction_lock_threshold = 100;
            workspace_swipe_create_new = true;
            workspace_swipe_invert = true;
            workspace_swipe_forever = true;
          };

          general = {
            layout = "master"; # dwindle
            snap.enabled = true;
            border_size = 3;
            resize_on_border = true;
            gaps_in = 2; # 4
            gaps_out = 6;
            "col.active_border" = "rgb(3b3c47)";
            "col.inactive_border" = "rgb(3b3c47)";
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
            enable_anr_dialog = true;
            render_ahead_safezone = 1;
          };
          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
            enforce_permissions = false;
          };
        };
      };
      xdg.enable = true;
      xdg.mime.enable = true;
      xdg.mimeApps.enable = true;
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        music = "/home/${settings.account.name}/Media/Music";
        videos = "/home/${settings.account.name}/Media/Videos";
        pictures = "/home/${settings.account.name}/Media/Pictures";
        templates = "/home/${settings.account.name}/Templates";
        download = "/home/${settings.account.name}/Downloads";
        documents = "/home/${settings.account.name}/Documents";
        desktop = null;
        publicShare = null;
        extraConfig = {
          XDG_ARCHIVE_DIR = "/home/${settings.account.name}/Archive";
          XDG_VM_DIR = "/home/${settings.account.name}/Machines";
          XDG_ORG_DIR = "/home/${settings.account.name}/Org";
          XDG_PODCAST_DIR = "/home/${settings.account.name}/Media/Podcasts";
          XDG_BOOK_DIR = "/home/${settings.account.name}/Media/Books";
        };
      };
    }
    (lib.mkIf (settings.profile == "image") {
      wayland.windowManager.hyprland.settings.exec-once = [
        "cp -r /iso/home/${settings.account.name}/${settings.system.flakePath} /home/${settings.account.name}; chown -R ${settings.account.name} /home/${settings.account.name}/${settings.system.flakePath}; chmod -R 777 /home/${settings.account.name}/${settings.system.flakePath}"
        "sudo systemctl restart NetworkManager"
        "${settings.account.terminal} -e 'sleep 1;nmtui'"
        "sudo rm -rf /home/nixos/"
        "sudo nixos-generate-config && cp /etc/nixos/hardware.nix /home/${settings.account.name}/${settings.system.flakePath}/modules/system/"
        "notify-send 'Welcome to Hyprland by NixPro!'"
      ];
    })
  ];
}
