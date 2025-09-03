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

  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;

  services.usbmuxd.enable = true;
  services.usbmuxd.package = pkgs.usbmuxd2;

  services.gnome.gnome-keyring.enable = true;

  security.rtkit.enable = true;
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

  services.printing.enable = true;
  security.pam.services.greetd = lib.mkIf config.services.greetd.enable { enableGnomeKeyring = true; };

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  fonts.enableDefaultPackages = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ noto-fonts inter noto-fonts-cjk-sans ];
  fonts.fontconfig.defaultFonts.monospace = [ "Noto Mono" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Inter" "Noto Sans" ];
  fonts.fontconfig.defaultFonts.serif = [ "Noto Serif" ];

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.plymouth.enable = true;
  boot.loader.timeout = 1;

  services.power-profiles-daemon.enable = true;

  imports = [
    ./animation.nix
    ./cursor.nix
    ./dependencies.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprsunset.nix
    ./keybinds.nix
    ./notification.nix
    ./nwg-dock-hyprland.nix
    # ./nwg-launcher.nix
    ./plugins.nix
    ./qt-gtk.nix
    ./rclone.nix
    ./rofi-launcher.nix
    ./rules.nix
    ./screenshot.nix
    ./waybar.nix
  ] ++ lib.optional (settings.profile == "workstation") ./text-to-speach.nix;
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
      wayland.windowManager.hyprland.enable = true;
      wayland.windowManager.hyprland.systemd.enable = false;
      wayland.windowManager.hyprland.xwayland.enable = true;
      wayland.windowManager.hyprland.settings.monitor = settings.desktop.monitors;
      wayland.windowManager.hyprland.settings.exec-once = [
        "powerprofilesctl set performance"
        "nm-applet --indicator"
        "blueman-applet"
        "systemctl --user start hyprpolkitagent"
        "gnome-keyring-daemon --start --components=secrets"
      ];
      wayland.windowManager.hyprland.settings.env = [
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
      wayland.windowManager.hyprland.settings = {
        input.natural_scroll = false;
        input.touchpad.natural_scroll = true;
        gestures.workspace_swipe = true;
        gestures.workspace_swipe_distance = 170;
        gestures.workspace_swipe_fingers = 3;
        gestures.workspace_swipe_cancel_ratio = 0.2;
        gestures.workspace_swipe_direction_lock = true;
        gestures.workspace_swipe_direction_lock_threshold = 100;
        gestures.workspace_swipe_create_new = true;
        gestures.workspace_swipe_invert = true;
        gestures.workspace_swipe_forever = true;
        general.layout = "master"; # dwindle
        general.snap.enabled = true;
        general.border_size = 3;
        general.resize_on_border = true;
        general.gaps_in = 2; # 4
        general.gaps_out = 6;
        general."col.active_border" = "rgb(3b3c47)";
        general."col.inactive_border" = "rgb(3b3c47)";
        general.no_border_on_floating = false;
        decoration.rounding = 7;
        decoration.active_opacity = 1;
        decoration.inactive_opacity = 1;
        decoration.fullscreen_opacity = 1;
        decoration.dim_inactive = false;
        decoration.dim_strength = 0.2;
        decoration.dim_around = 0.6;
        decoration.blur.enabled = true;
        decoration.blur.size = 5;
        decoration.blur.passes = 3;
        decoration.blur.brightness = 0.8172;
        decoration.blur.contrast = 1.4;
        decoration.blur.vibrancy = 0.1696;
        decoration.blur.ignore_opacity = true;
        decoration.blur.noise = 0.01;
        decoration.blur.new_optimizations = true;
        decoration.blur.xray = true;
        decoration.shadow.enabled = true;
        decoration.shadow.ignore_window = true;
        decoration.shadow.offset = "0 2";
        decoration.shadow.range = 20;
        decoration.shadow.render_power = 3;
        decoration.shadow.color = "rgba(00000055)";
        misc.disable_hyprland_logo = true;
        misc.disable_splash_rendering = false;
        misc.enable_swallow = true;
        misc.animate_manual_resizes = true;
        misc.animate_mouse_windowdragging = true;
        misc.focus_on_activate = true;
        misc.middle_click_paste = false;
        misc.close_special_on_empty = true;
        misc.vfr = true;
        misc.mouse_move_enables_dpms = "on";
        misc.key_press_enables_dpms = "on";
        misc.enable_anr_dialog = true;
        ecosystem.no_update_news = true;
        ecosystem.no_donation_nag = true;
        ecosystem.enforce_permissions = false;
      };
      xdg.enable = true;
      xdg.mime.enable = true;
      xdg.mimeApps.enable = true;
      xdg.userDirs.enable = true;
      xdg.userDirs.createDirectories = true;
      xdg.userDirs.music = "/home/${settings.account.name}/Media/Music";
      xdg.userDirs.videos = "/home/${settings.account.name}/Media/Videos";
      xdg.userDirs.pictures = "/home/${settings.account.name}/Media/Pictures";
      xdg.userDirs.templates = "/home/${settings.account.name}/Templates";
      xdg.userDirs.download = "/home/${settings.account.name}/Downloads";
      xdg.userDirs.documents = "/home/${settings.account.name}/Documents";
      xdg.userDirs.desktop = null;
      xdg.userDirs.publicShare = null;
      xdg.userDirs.extraConfig.XDG_ARCHIVE_DIR = "/home/${settings.account.name}/Archive";
      xdg.userDirs.extraConfig.XDG_VM_DIR = "/home/${settings.account.name}/Machines";
      xdg.userDirs.extraConfig.XDG_ORG_DIR = "/home/${settings.account.name}/Org";
      xdg.userDirs.extraConfig.XDG_PODCAST_DIR = "/home/${settings.account.name}/Media/Podcasts";
      xdg.userDirs.extraConfig.XDG_BOOK_DIR = "/home/${settings.account.name}/Media/Books";
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
